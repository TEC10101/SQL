using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Data.SqlClient;

namespace FINAL_ReadExcelCreateSQLDb
{
  class Program
  {
    static void Main(string[] args)
    {

            //
            // Pull data from AccountLedger.xlsx (doesn't ask for user input)
            // Put it into DataTable called data, with Table called johnerDb
            //
            Console.WriteLine("Default Directory> C:\\test\\AccountLedger.xlsx\n\n");
            var fileName = string.Format("C:\\test\\AccountLedger.xlsx");
            var connectionString = string.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=""Excel 12.0 Xml;HDR=YES""", fileName);


            var adapterRead = new OleDbDataAdapter("SELECT * FROM [Sheet1$]", connectionString);
            var ds = new DataSet();

            adapterRead.Fill(ds, "johnerDb");

            DataTable data = ds.Tables["johnerDb"];


            //
            // Debug: verbosely show all data in console window
            // 
            Console.WriteLine(data.Rows.Count);
            for (int head = 0; head < data.Columns.Count; head++)
            {
                Console.Write($"{data.Columns[head].ColumnName}\t");
            }
            Console.WriteLine();
            foreach (DataRow verbose in data.Rows)
            {
                foreach (var item in verbose.ItemArray)
                {
                    Console.Write($"{item}\t");
                }
                Console.WriteLine();
            }
            Console.ReadLine();


            //
            //// START Sample of Working DB Table SQL Code
            //

            //DataTable table = new DataTable("Users");

            //table.Columns.Add(new DataColumn()
            //{
            //    ColumnName = "UserId",
            //    DataType = System.Type.GetType("System.Int32"),
            //    AutoIncrement = true,
            //    AllowDBNull = false,
            //    AutoIncrementSeed = 1,
            //    AutoIncrementStep = 1
            //});

            //table.Columns.Add(new DataColumn()
            //{
            //    ColumnName = "UserName",
            //    DataType = System.Type.GetType("System.String"),
            //    AllowDBNull = true,
            //    DefaultValue = String.Empty,
            //    MaxLength = 50
            //});

            //table.Columns.Add(new DataColumn()
            //{
            //    ColumnName = "LastUpdate",
            //    DataType = System.Type.GetType("System.DateTime"),
            //    AllowDBNull = false,
            //    DefaultValue = DateTime.Now,
            //    Caption = "<defaultValue>GETDATE()</defaultValue>"
            //});

            //table.PrimaryKey = new DataColumn[] { table.Columns[0] };

            //
            //// END Sample of Working DB Table SQL Code
            //

            //
            // Process and Output the SQL Query to SQLcode.txt
            //
            string sql = GetCreateTableSql(data);
            StreamWriter write = new StreamWriter("C:\\test\\SQLcode.txt");
            write.WriteLine(sql);
            Console.WriteLine("\n\n...outpuf file created successfully, saved at C:\\test\\SQLcode.txt");
            write.Close();
            Console.ReadLine();
    }
        public static string GetCreateTableSql(DataTable data)
        {
            StringBuilder sql = new StringBuilder();
            StringBuilder alterSql = new StringBuilder();

            sql.AppendFormat("USE master\nGO\n\nIF EXISTS (SELECT * FROM sys.databases WHERE [name] = 'db_" + data.TableName + "')\nDROP DATABASE db_" + data.TableName + "\nGO\n\nCREATE DATABASE db_" + data.TableName + "\nGO\n\nUSE db_" + data.TableName + "\nGO\n\nCREATE TABLE [{0}] (", data.TableName);

            int record = 0; // Record count/row count, tracks the vertical position of the cursor
            int col = 0;    // Field count/column count, tracks the horizontal position of the cursor
            foreach (DataRow row in data.Rows)
            {
                col = 0; // reset column count each loop
                bool isNumeric = false;
                #region First Row (Table Header)
                if (record == 0)
                {
                    record++;
                    for (int i = 0; i < data.Columns.Count; i++)
                    {
                        bool usesColumnDefault = true;
                        sql.AppendFormat("\n\t[{0}]", data.Columns[i].ColumnName);
                        #region DataType of Fields (columns)
                        {
                            switch (data.Columns[i].DataType.ToString().ToUpper())
                            {
                                case "SYSTEM.INT16":
                                    sql.Append(" smallint");
                                    isNumeric = true;
                                    break;
                                case "SYSTEM.INT32":
                                    sql.Append(" int");
                                    isNumeric = true;
                                    break;
                                case "SYSTEM.INT64":
                                    sql.Append(" bigint");
                                    isNumeric = true;
                                    break;
                                case "SYSTEM.DATETIME":
                                    sql.Append(" varchar(50)");
                                    isNumeric = false;
                                    usesColumnDefault = false;
                                    break;
                                case "SYSTEM.STRING":
                                    sql.AppendFormat(" nvarchar(120)");
                                    break;
                                case "SYSTEM.SINGLE":
                                    sql.Append(" single");
                                    isNumeric = true;
                                    break;
                                case "SYSTEM.DOUBLE":
                                    sql.Append(" int");
                                    isNumeric = true;
                                    break;
                                case "SYSTEM.DECIMAL":
                                    sql.AppendFormat(" decimal(18, 6)");
                                    isNumeric = true;
                                    break;
                                default:
                                    sql.AppendFormat(" nvarchar(50)");
                                    break;
                            }
                            #endregion
                        }
                        #region Extra Scripting... Commented Out... For More Complex Sheets...
                        //if (data.Columns[i].AutoIncrement)
                        //{
                        //    sql.AppendFormat(" IDENTITY({0},{1})",
                        //        data.Columns[i].AutoIncrementSeed,
                        //        data.Columns[i].AutoIncrementStep);
                        //}
                        //else
                        //{
                        //    // DataColumns will add a blank DefaultValue for any AutoIncrement column. 
                        //    // We only want to create an ALTER statement for those columns that are not set to AutoIncrement. 
                        //    if (data.Columns[i].DefaultValue != null)
                        //    {
                        //        if (usesColumnDefault)
                        //        {
                        //            if (isNumeric)
                        //            {
                        //                alterSql.AppendFormat("\nALTER TABLE {0} ADD CONSTRAINT [DF_{0}_{1}]  DEFAULT ({2}) FOR [{1}];",
                        //                    data.TableName,
                        //                    data.Columns[i].ColumnName,
                        //                    data.Columns[i].DefaultValue);
                        //            }
                        //            else
                        //            {
                        //                alterSql.AppendFormat("\nALTER TABLE {0} ADD CONSTRAINT [DF_{0}_{1}]  DEFAULT ('{2}') FOR [{1}];",
                        //                    data.TableName,
                        //                    data.Columns[i].ColumnName,
                        //                    data.Columns[i].DefaultValue);
                        //            }
                        //        }
                        //        else
                        //        {
                        //            // Default values on Date columns, e.g., "DateTime.Now" will not translate to SQL.
                        //            // This inspects the caption for a simple XML string to see if there is a SQL compliant default value, e.g., "GETDATE()".
                        //            try
                        //            {
                        //                System.Xml.XmlDocument xml = new System.Xml.XmlDocument();

                        //                xml.LoadXml(data.Columns[i].Caption);

                        //                alterSql.AppendFormat("\nALTER TABLE {0} ADD CONSTRAINT [DF_{0}_{1}]  DEFAULT ({2}) FOR [{1}];",
                        //                    data.TableName,
                        //                    data.Columns[i].ColumnName,
                        //                    xml.GetElementsByTagName("defaultValue")[0].InnerText);
                        //            }
                        //            catch
                        //            {
                        //                // Handle
                        //            }
                        //        }
                        //    }
                        //}
                        #endregion

                        if (!data.Columns[i].AllowDBNull)
                        {
                            sql.Append(" NOT NULL");
                        }

                        sql.Append(",");
                        if (i+1 == data.Columns.Count)
                        {
                            sql.AppendFormat("\n);");

                            sql.AppendFormat("\nINSERT INTO [" + data.TableName + "]\nVALUES\n");
                        }
                    }
                }
                #endregion // End Column Header
                #region DataType Switch for Number or String
                if (record > 0) // 2nd and onward records (rows)
                {
                    for (int i = 0; i < data.Columns.Count; i++)
                    {
                        //
                        // Check the cell for string/numeric value to be able to convert the data into T-SQL syntax
                        //

                        switch (data.Columns[col].DataType.ToString().ToUpper())
                        {
                            case "SYSTEM.INT16":
                                isNumeric = true;
                                break;
                            case "SYSTEM.INT32":
                                isNumeric = true;
                                break;
                            case "SYSTEM.INT64":
                                isNumeric = true;
                                break;
                            case "SYSTEM.DATETIME":
                                isNumeric = false;
                                break;
                            case "SYSTEM.STRING":
                                isNumeric = false;
                                break;
                            case "SYSTEM.SINGLE":
                                isNumeric = true;
                                break;
                            case "SYSTEM.DOUBLE":
                                isNumeric = true;
                                break;
                            case "SYSTEM.DECIMAL":
                                isNumeric = true;
                                break;
                            default:
                                isNumeric = false;
                                break;
                        }
                        //
                        // I use a binary approach, either it's a number which then creates the syntax with no '' or if it is a 'string'
                        // EXAMPLE: INSERT INTO table_name VALUES ('123 Main St','Portland','OR',97011);  <-- the zip code does not include ''
                        //
                        if (isNumeric)
                        {
                            if (col == 0)
                                sql.AppendFormat($"({data.Rows[record-1][col]},");
                            else if (col == data.Columns.Count-1)
                                sql.AppendFormat($"{data.Rows[record-1][col]}),\n");
                            else
                                sql.AppendFormat($"{data.Rows[record-1][col]},");
                            col++;
                        }
                        else
                        {
                            if (col == 0)
                                sql.AppendFormat($"('{data.Rows[record-1][col]}',");
                            else if (col == data.Columns.Count-1)
                                sql.AppendFormat($"'{data.Rows[record - 1][col]}'),\n");
                            else
                                sql.AppendFormat($"'{data.Rows[record-1][col]}',");
                            col++;
                        }
                    }
                }
                record++;
                #endregion
            }

            // Extra stuff... 
            if (data.PrimaryKey.Length > 0)
            {
                StringBuilder primaryKeySql = new StringBuilder();

                primaryKeySql.AppendFormat("\n\tCONSTRAINT PK_{0} PRIMARY KEY (", data.TableName);

                for (int i = 0; i < data.PrimaryKey.Length; i++)
                {
                    primaryKeySql.AppendFormat("{0},", data.PrimaryKey[i].ColumnName);
                }

                primaryKeySql.Remove(primaryKeySql.Length - 1, 1);
                primaryKeySql.Append(")");

                sql.Append(primaryKeySql);
            }
            else  // ! \\ I need this else statement to remove some extra chars off the generated SQL Query
            {
                sql.Remove(sql.Length - 2, 2);
            }

            // Add a trailing ; and we are done!
            sql.AppendFormat(";");
            //sql.AppendFormat(alterSql.ToString());
            return sql.ToString();
        }
    }
}
