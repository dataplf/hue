// Licensed to Cloudera, Inc. under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  Cloudera, Inc. licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

%options case-insensitive flex
%s between
%x hdfs doubleQuotedValue singleQuotedValue backtickedValue
%%

\s                                   { /* skip whitespace */ }
'--'.*                               { /* skip comments */ }
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]  { /* skip comments */ }

'\u2020'                             { parser.yy.partialCursor = false; parser.yy.cursorFound = yylloc; return 'CURSOR'; }
'\u2021'                             { parser.yy.partialCursor = true; parser.yy.cursorFound = yylloc; return 'PARTIAL_CURSOR'; }

<between>'AND'                       { this.popState(); return 'BETWEEN_AND'; }

// Reserved Keywords
'ALL'                                { return 'ALL'; }
'ALTER'                              { parser.determineCase(yytext); parser.addStatementTypeLocation('ALTER', yylloc, yy.lexer.upcomingInput()); return 'ALTER'; }
'AND'                                { return 'AND'; }
'ARRAY'                              { return 'ARRAY'; }
'AS'                                 { return 'AS'; }
'AUTHORIZATION'                      { return 'AUTHORIZATION'; }
'BETWEEN'                            { this.begin('between'); return 'BETWEEN'; }
'BIGINT'                             { return 'BIGINT'; }
'BINARY'                             { return 'BINARY'; }
'BOOLEAN'                            { return 'BOOLEAN'; }
'BY'                                 { return 'BY'; }
'CACHE'                              { return 'CACHE'; }
'CASE'                               { return 'CASE'; }
'CHAR'                               { return 'CHAR'; }
'COLUMN'                             { return 'COLUMN'; }
'CONF'                               { return 'CONF'; }
'CONSTRAINT'                         { return 'CONSTRAINT'; }
'CREATE'                             { parser.determineCase(yytext); return 'CREATE'; }
'CROSS'                              { return 'CROSS'; }
'CUBE'                               { return 'CUBE'; }
'CURRENT'                            { return 'CURRENT'; }
'DATABASE'                           { return 'DATABASE'; }
'DATE'                               { return 'DATE'; }
'DECIMAL'                            { return 'DECIMAL'; }
'DELETE'                             { parser.determineCase(yytext); return 'DELETE'; }
'DESCRIBE'                           { parser.determineCase(yytext); return 'DESCRIBE'; }
'DISTINCT'                           { return 'DISTINCT'; }
'DIV'                                { return 'ARITHMETIC_OPERATOR'; }
'DOUBLE'                             { return 'DOUBLE'; }
'DROP'                               { parser.determineCase(yytext); parser.addStatementTypeLocation('DROP', yylloc, yy.lexer.upcomingInput()); return 'DROP'; }
'ELSE'                               { return 'ELSE'; }
'END'                                { return 'END'; }
'EXISTS'                             { parser.yy.correlatedSubQuery = true; return 'EXISTS'; }
'EXTENDED'                           { return 'EXTENDED'; }
'EXTERNAL'                           { return 'EXTERNAL'; }
'FALSE'                              { return 'FALSE'; }
'FLOAT'                              { return 'FLOAT'; }
'FOLLOWING'                          { return 'FOLLOWING'; }
'FOR'                                { return 'FOR'; }
'FOREIGN'                            { return 'FOREIGN'; }
'FROM'                               { parser.determineCase(yytext); return 'FROM'; }
'FULL'                               { return 'FULL'; }
'FUNCTION'                           { return 'FUNCTION'; }
'GRANT'                              { return 'GRANT'; }
'GROUP'                              { return 'GROUP'; }
'GROUPING'                           { return 'GROUPING'; }
'HAVING'                             { return 'HAVING'; }
'IF'                                 { return 'IF'; }
'IMPORT'                             { parser.determineCase(yytext); return 'IMPORT'; }
'IN'                                 { return 'IN'; }
'INNER'                              { return 'INNER'; }
'INSERT'                             { parser.determineCase(yytext); return 'INSERT'; }
'INT'                                { return 'INT'; }
'INTEGER'                            { return 'INTEGER'; }
'INTO'                               { return 'INTO'; }
'IS'                                 { return 'IS'; }
'JOIN'                               { return 'JOIN'; }
'LATERAL'                            { return 'LATERAL'; }
'LEFT'                               { return 'LEFT'; }
'LIKE'                               { return 'LIKE'; }
'LIMIT'                              { return 'LIMIT'; }
'LOCAL'                              { return 'LOCAL'; }
'MACRO'                              { return 'MACRO'; }
'MAP'                                { return 'MAP'; }
'NONE'                               { return 'NONE'; }
'NOT'                                { return 'NOT'; }
'NULL'                               { return 'NULL'; }
'NULLS'                              { return 'NULLS'; }
'OF'                                 { return 'OF'; }
'ON'                                 { return 'ON'; }
'OR'                                 { return 'OR'; }
'ORDER'                              { return 'ORDER'; }
'OUT'                                { return 'OUT'; }
'OUTER'                              { return 'OUTER'; }
'PARTITION'                          { return 'PARTITION'; }
'PRECEDING'                          { return 'PRECEDING'; }
'PRECISION'                          { return 'PRECISION'; }
'PRIMARY'                            { return 'PRIMARY'; }
'RANGE'                              { return 'RANGE'; }
'REFERENCES'                         { return 'REFERENCES'; }
'REGEXP'                             { return 'REGEXP'; }
'REVOKE'                             { return 'REVOKE'; }
'RIGHT'                              { return 'RIGHT'; }
'RLIKE'                              { return 'RLIKE'; }
'ROLLUP'                             { return 'ROLLUP'; }
'ROW'                                { return 'ROW'; }
'ROWS'                               { return 'ROWS'; }
'SELECT'                             { parser.determineCase(yytext); parser.addStatementTypeLocation('SELECT', yylloc); return 'SELECT'; }
'SEMI'                               { return 'SEMI'; }
'SET'                                { parser.determineCase(yytext); parser.addStatementTypeLocation('SET', yylloc); return 'SET'; }
'SMALLINT'                           { return 'SMALLINT'; }
'SYNC'                               { return 'SYNC'; }
'TABLE'                              { return 'TABLE'; }
'THEN'                               { return 'THEN'; }
'TIMESTAMP'                          { return 'TIMESTAMP'; }
'TO'                                 { return 'TO'; }
'TRUE'                               { return 'TRUE'; }
'TRUNCATE'                           { parser.determineCase(yytext); parser.addStatementTypeLocation('TRUNCATE', yylloc, yy.lexer.upcomingInput()); return 'TRUNCATE'; }
'UNBOUNDED'                          { return 'UNBOUNDED'; }
'UNION'                              { return 'UNION'; }
'UPDATE'                             { parser.determineCase(yytext); return 'UPDATE'; }
'USER'                               { return 'USER'; }
'USING'                              { return 'USING'; }
'UTC_TIMESTAMP'                      { return 'UTC_TIMESTAMP'; }
'VALUES'                             { return 'VALUES'; }
'VARCHAR'                            { return 'VARCHAR'; }
'VIEWS'                              { return 'VIEWS'; }
'WHEN'                               { return 'WHEN'; }
'WHERE'                              { return 'WHERE'; }
'WITH'                               { parser.determineCase(yytext); parser.addStatementTypeLocation('WITH', yylloc); return 'WITH'; }

// Non-reserved Keywords
'ABORT'                              { parser.determineCase(yytext); return 'ABORT'; }
'ADD'                                { return 'ADD'; }
'ADMIN'                              { return 'ADMIN'; }
'AFTER'                              { return 'AFTER'; }
'ANALYZE'                            { parser.determineCase(yytext); return 'ANALYZE'; }
'ARCHIVE'                            { return 'ARCHIVE'; }
'ASC'                                { return 'ASC'; }
'AST'                                { return 'AST'; }
'AT'                                 { return 'AT'; }
'AVRO'                               { return 'AVRO'; }
'BUCKET'                             { return 'BUCKET'; }
'BUCKETS'                            { return 'BUCKETS'; }
'CASCADE'                            { return 'CASCADE'; }
'CBO'                                { return 'CBO'; }
'CHANGE'                             { return 'CHANGE'; }
'CHECK'                              { return 'CHECK'; }
'CLUSTER'                            { return 'CLUSTER'; }
'CLUSTERED'                          { return 'CLUSTERED'; }
'COLLECTION'                         { return 'COLLECTION'; }
'COLUMNS'                            { return 'COLUMNS'; }
'COMMENT'                            { return 'COMMENT'; }
'CONNECTOR'                          { return 'CONNECTOR'; }
'CONNECTORS'                         { return 'CONNECTORS'; }
'COMPACT'                            { return 'COMPACT'; }
'COMPACTIONS'                        { return 'COMPACTIONS'; }
'COMPUTE'                            { return 'COMPUTE'; }
'CONCATENATE'                        { return 'CONCATENATE'; }
'COST'                               { return 'COST'; }
CREATE\s+REMOTE                      { parser.determineCase(yytext); return 'CREATE_REMOTE'; }
'CRON'                               { return 'CRON'; }
'CURRENT_DATE'                       { return 'CURRENT_DATE'; }
'CURRENT_TIMESTAMP'                  { return 'CURRENT_TIMESTAMP'; }
'CURRENT_USER'                       { return 'CURRENT_USER'; }
'DATA'                               { return 'DATA'; }
'DATABASES'                          { return 'DATABASES'; }
'DAY'                                { return 'DAY'; }
'DAYOFWEEK'                          { return 'DAYOFWEEK'; }
'DCPROPERTIES'                       { return 'DCPROPERTIES'; }
'DBPROPERTIES'                       { return 'DBPROPERTIES'; }
'DEFAULT'                            { return 'DEFAULT'; }
'DEFERRED'                           { return 'DEFERRED'; }
'DEFINED'                            { return 'DEFINED'; }
'DELIMITED'                          { return 'DELIMITED'; }
'DEPENDENCY'                         { return 'DEPENDENCY'; }
'DESC'                               { return 'DESC'; }
'DETAIL'                             { return 'DETAIL'; }
'DIRECTORY'                          { this.begin('hdfs'); return 'DIRECTORY'; }
'DISABLE'                            { return 'DISABLE'; }
'DISABLED'                           { return 'DISABLED'; }
'DISTRIBUTE'                         { return 'DISTRIBUTE'; }
'DISTRIBUTED'                        { return 'DISTRIBUTED'; }
DOUBLE\s+PRECISION                   { return 'DOUBLE_PRECISION'; }
'ENABLE'                             { return 'ENABLE'; }
'ENABLED'                            { return 'ENABLED'; }
'ESCAPED'                            { return 'ESCAPED'; }
'EVERY'                              { return 'EVERY'; }
'EXCHANGE'                           { return 'EXCHANGE'; }
'EXECUTE'                            { return 'EXECUTE'; }
'EXECUTED'                           { return 'EXECUTED'; }
'EXPLAIN'                            { parser.determineCase(yytext); return 'EXPLAIN'; }
'EXPORT'                             { parser.determineCase(yytext); return 'EXPORT'; }
'EXPRESSION'                         { return 'EXPRESSION'; }
'FIELDS'                             { return 'FIELDS'; }
'FILE'                               { return 'FILE'; }
'FILEFORMAT'                         { return 'FILEFORMAT'; }
'FIRST'                              { return 'FIRST'; }
'FORMAT'                             { return 'FORMAT'; }
'FORMATTED'                          { return 'FORMATTED'; }
'FUNCTIONS'                          { return 'FUNCTIONS'; }
'HOUR'                               { return 'HOUR'; }
'ICEBERG'                            { return 'ICEBERG'; }
'IDXPROPERTIES'                      { return 'IDXPROPERTIES'; }
'INDEX'                              { return 'INDEX'; }
'INDEXES'                            { return 'INDEXES'; }
'INPATH'                             { this.begin('hdfs'); return 'INPATH'; }
'INPUTFORMAT'                        { return 'INPUTFORMAT'; }
'ITEMS'                              { return 'ITEMS'; }
'JAR'                                { return 'JAR'; }
'JOINCOST'                           { return 'JOINCOST'; }
'JSONFILE'                           { return 'JSONFILE'; }
'KEY'                                { return 'KEY'; }
'KEYS'                               { return 'KEYS'; }
'LAST'                               { return 'LAST'; }
'LINES'                              { return 'LINES'; }
'LITERAL'                            { return 'LITERAL'; }
'LOAD'                               { parser.determineCase(yytext); return 'LOAD'; }
'LOCATION'                           { this.begin('hdfs'); return 'LOCATION'; }
'LOCK'                               { return 'LOCK'; }
'LOCKS'                              { return 'LOCKS'; }
'MANAGEDLOCATION'                    { this.begin('hdfs'); return 'MANAGEDLOCATION'; }
'MATCHED'                            { return 'MATCHED'; }
'MATERIALIZED'                       { return 'MATERIALIZED'; }
'MERGE'                              { return 'MERGE'; }
'METADATA'                           { return 'METADATA'; }
'MINUTE'                             { return 'MINUTE'; }
'MONTH'                              { return 'MONTH'; }
'MSCK'                               { return 'MSCK'; }
'NO_DROP'                            { return 'NO_DROP'; }
'NORELY'                             { return 'NORELY'; }
'NOSCAN'                             { return 'NOSCAN'; }
'NOVALIDATE'                         { return 'NOVALIDATE'; }
'OFFLINE'                            { return 'OFFLINE'; }
'OFFSET'                             { return 'OFFSET'; }
'ONLY'                               { return 'ONLY'; }
'OPERATOR'                           { return 'OPERATOR'; }
'OPTION'                             { return 'OPTION'; }
'ORC'                                { return 'ORC'; }
'OUTPUTFORMAT'                       { return 'OUTPUTFORMAT'; }
'OVER'                               { return 'OVER'; }
'OVERWRITE'                          { return 'OVERWRITE'; }
OVERWRITE\s+DIRECTORY                { this.begin('hdfs'); return 'OVERWRITE_DIRECTORY'; }
'OWNER'                              { return 'OWNER'; }
'PARQUET'                            { return 'PARQUET'; }
'PARTITIONED'                        { return 'PARTITIONED'; }
'PARTITIONS'                         { return 'PARTITIONS'; }
'PERCENT'                            { return 'PERCENT'; }
'PRIVILEGES'                         { return 'PRIVILEGES'; }
'PURGE'                              { return 'PURGE'; }
'QUARTER'                            { return 'QUARTER'; }
'QUERY'                              { return 'QUERY'; }
'RCFILE'                             { return 'RCFILE'; }
'REBUILD'                            { return 'REBUILD'; }
'RECOVER'                            { return 'RECOVER'; }
'RELOAD'                             { parser.determineCase(yytext); return 'RELOAD'; }
'RELY'                               { return 'RELY'; }
'REMOTE'                             { return 'REMOTE'; }
'RENAME'                             { return 'RENAME'; }
'REPAIR'                             { return 'REPAIR'; }
'REPLACE'                            { return 'REPLACE'; }
'REPLICATION'                        { return 'REPLICATION'; }
'RESTRICT'                           { return 'RESTRICT'; }
'REWRITE'                            { return 'REWRITE'; }
'ROLE'                               { return 'ROLE'; }
'ROLES'                              { return 'ROLES'; }
'SCHEDULED'                          { return 'SCHEDULED'; }
'SCHEMA'                             { return 'SCHEMA'; }
'SCHEMAS'                            { return 'SCHEMAS'; }
'SECOND'                             { return 'SECOND'; }
'SEQUENCEFILE'                       { return 'SEQUENCEFILE'; }
'SERDE'                              { return 'SERDE'; }
'SERDEPROPERTIES'                    { return 'SERDEPROPERTIES'; }
'SETS'                               { return 'SETS'; }
'SHOW'                               { parser.determineCase(yytext); parser.addStatementTypeLocation('SHOW', yylloc); return 'SHOW'; }
'SHOW_DATABASE'                      { return 'SHOW_DATABASE'; }
'SKEWED LOCATION'                    { return 'SKEWED_LOCATION'; } // Hack to prevent hdfs lexer state
'SKEWED'                             { return 'SKEWED'; }
'SORT'                               { return 'SORT'; }
'SORTED'                             { return 'SORTED'; }
'SPEC'                               { return 'SPEC'; }
'STATISTICS'                         { return 'STATISTICS'; }
'STORED'                             { return 'STORED'; }
STORED\s+AS\s+DIRECTORIES            { return 'STORED_AS_DIRECTORIES'; }
'STRING'                             { return 'STRING'; }
'STRUCT'                             { return 'STRUCT'; }
'SUMMARY'                            { return 'SUMMARY'; }
'TABLES'                             { return 'TABLES'; }
'TABLESAMPLE'                        { return 'TABLESAMPLE'; }
'TBLPROPERTIES'                      { return 'TBLPROPERTIES'; }
'TEMPORARY'                          { return 'TEMPORARY'; }
'TERMINATED'                         { return 'TERMINATED'; }
'TEXTFILE'                           { return 'TEXTFILE'; }
'TINYINT'                            { return 'TINYINT'; }
'TOUCH'                              { return 'TOUCH'; }
'TRANSACTIONAL'                      { return 'TRANSACTIONAL'; }
'TRANSACTIONS'                       { return 'TRANSACTIONS'; }
'TYPE'                               { return 'TYPE'; }
'UNARCHIVE'                          { return 'UNARCHIVE'; }
'UNIONTYPE'                          { return 'UNIONTYPE'; }
'UNIQUE'                             { return 'UNIQUE'; }
'UNSET'                              { return 'UNSET'; }
'URL'                                { return 'URL'; }
'USE'                                { parser.determineCase(yytext); parser.addStatementTypeLocation('USE', yylloc); return 'USE'; }
'VECTORIZATION'                      { return 'VECTORIZATION'; }
'VIEW'                               { return 'VIEW'; }
'WAIT'                               { return 'WAIT'; }
'WEEK'                               { return 'WEEK'; }
'WINDOW'                             { return 'WINDOW'; }
'YEAR'                               { return 'YEAR'; }

'.'                                  { return '.'; }
'['                                  { return '['; }
']'                                  { return ']'; }

// --- UDFs ---
AVG\s*\(                             { yy.lexer.unput('('); yytext = 'avg'; parser.addFunctionLocation(yylloc, yytext); return 'AVG'; }
CAST\s*\(                            { yy.lexer.unput('('); yytext = 'cast'; parser.addFunctionLocation(yylloc, yytext); return 'CAST'; }
COLLECT_LIST\s*\(                    { yy.lexer.unput('('); yytext = 'collect_list'; parser.addFunctionLocation(yylloc, yytext); return 'COLLECT_LIST'; }
COLLECT_SET\s*\(                     { yy.lexer.unput('('); yytext = 'collect_set'; parser.addFunctionLocation(yylloc, yytext); return 'COLLECT_SET'; }
CORR\s*\(                            { yy.lexer.unput('('); yytext = 'corr'; parser.addFunctionLocation(yylloc, yytext); return 'CORR'; }
COUNT\s*\(                           { yy.lexer.unput('('); yytext = 'count'; parser.addFunctionLocation(yylloc, yytext); return 'COUNT'; }
COVAR_POP\s*\(                       { yy.lexer.unput('('); yytext = 'covar_pop'; parser.addFunctionLocation(yylloc, yytext); return 'COVAR_POP'; }
COVAR_SAMP\s*\(                      { yy.lexer.unput('('); yytext = 'covar_samp'; parser.addFunctionLocation(yylloc, yytext); return 'COVAR_SAMP'; }
EXTRACT\s*\(                         { yy.lexer.unput('('); yytext = 'extract'; parser.addFunctionLocation(yylloc, yytext); return 'EXTRACT'; }
HISTOGRAM_NUMERIC\s*\(               { yy.lexer.unput('('); yytext = 'histogram_numeric'; parser.addFunctionLocation(yylloc, yytext); return 'HISTOGRAM_NUMERIC'; }
MAX\s*\(                             { yy.lexer.unput('('); yytext = 'max'; parser.addFunctionLocation(yylloc, yytext); return 'MAX'; }
MIN\s*\(                             { yy.lexer.unput('('); yytext = 'min'; parser.addFunctionLocation(yylloc, yytext); return 'MIN'; }
NTILE\s*\(                           { yy.lexer.unput('('); yytext = 'ntile'; parser.addFunctionLocation(yylloc, yytext); return 'NTILE'; }
PERCENTILE\s*\(                      { yy.lexer.unput('('); yytext = 'percentile'; parser.addFunctionLocation(yylloc, yytext); return 'PERCENTILE'; }
PERCENTILE_APPROX\s*\(               { yy.lexer.unput('('); yytext = 'percentile_approx'; parser.addFunctionLocation(yylloc, yytext); return 'PERCENTILE_APPROX'; }
STDDEV_POP\s*\(                      { yy.lexer.unput('('); yytext = 'stddev_pop'; parser.addFunctionLocation(yylloc, yytext); return 'STDDEV_POP'; }
STDDEV_SAMP\s*\(                     { yy.lexer.unput('('); yytext = 'stddev_samp'; parser.addFunctionLocation(yylloc, yytext); return 'STDDEV_SAMP'; }
SUM\s*\(                             { yy.lexer.unput('('); yytext = 'sum'; parser.addFunctionLocation(yylloc, yytext); return 'SUM'; }
VAR_POP\s*\(                         { yy.lexer.unput('('); yytext = 'var_pop'; parser.addFunctionLocation(yylloc, yytext); return 'VAR_POP'; }
VAR_SAMP\s*\(                        { yy.lexer.unput('('); yytext = 'var_samp'; parser.addFunctionLocation(yylloc, yytext); return 'VAR_SAMP'; }
VARIANCE\s*\(                        { yy.lexer.unput('('); yytext = 'variance'; parser.addFunctionLocation(yylloc, yytext); return 'VARIANCE'; }

// Analytical functions
CUME_DIST\s*\(                       { yy.lexer.unput('('); yytext = 'cume_dist'; parser.addFunctionLocation(yylloc, yytext); return 'ANALYTIC'; }
CUME_DIST\s*\(                       { yy.lexer.unput('('); yytext = 'cume_dist'; parser.addFunctionLocation(yylloc, yytext); return 'ANALYTIC'; }
DENSE_RANK\s*\(                      { yy.lexer.unput('('); yytext = 'dense_rank'; parser.addFunctionLocation(yylloc, yytext); return 'ANALYTIC'; }
FIRST_VALUE\s*\(                     { yy.lexer.unput('('); yytext = 'first_value'; parser.addFunctionLocation(yylloc, yytext); return 'ANALYTIC'; }
LAG\s*\(                             { yy.lexer.unput('('); yytext = 'lag'; parser.addFunctionLocation(yylloc, yytext); return 'ANALYTIC'; }
LAST_VALUE\s*\(                      { yy.lexer.unput('('); yytext = 'last_value'; parser.addFunctionLocation(yylloc, yytext); return 'ANALYTIC'; }
LEAD\s*\(                            { yy.lexer.unput('('); yytext = 'lead'; parser.addFunctionLocation(yylloc, yytext); return 'ANALYTIC'; }
PERCENT_RANK\s*\(                    { yy.lexer.unput('('); yytext = 'percent_rank'; parser.addFunctionLocation(yylloc, yytext); return 'ANALYTIC'; }
RANK\s*\(                            { yy.lexer.unput('('); yytext = 'rank'; parser.addFunctionLocation(yylloc, yytext); return 'ANALYTIC'; }
ROW_NUMBER\s*\(                      { yy.lexer.unput('('); yytext = 'row_number'; parser.addFunctionLocation(yylloc, yytext); return 'ANALYTIC'; }

[0-9]+                               { return 'UNSIGNED_INTEGER'; }
[0-9]+(?:[YSL]|BD)?                  { return 'UNSIGNED_INTEGER'; }
[0-9]+E                              { return 'UNSIGNED_INTEGER_E'; }
[A-Za-z0-9_]+                        { return 'REGULAR_IDENTIFIER'; }

<hdfs>'\u2020'                       { parser.yy.cursorFound = true; return 'CURSOR'; }
<hdfs>'\u2021'                       { parser.yy.cursorFound = true; return 'PARTIAL_CURSOR'; }
<hdfs>\s+['"]                        { return 'HDFS_START_QUOTE'; }
<hdfs>[^'"\u2020\u2021]+             { parser.addFileLocation(yylloc, yytext); return 'HDFS_PATH'; }
<hdfs>['"]                           { this.popState(); return 'HDFS_END_QUOTE'; }
<hdfs><<EOF>>                        { return 'EOF'; }

'&&'                                 { return 'AND'; }
'||'                                 { return 'OR'; }
'='                                  { return '='; }
'<'                                  { return '<'; }
'>'                                  { return '>'; }
'!='                                 { return 'COMPARISON_OPERATOR'; }
'<='                                 { return 'COMPARISON_OPERATOR'; }
'>='                                 { return 'COMPARISON_OPERATOR'; }
'<>'                                 { return 'COMPARISON_OPERATOR'; }
'<=>'                                { return 'COMPARISON_OPERATOR'; }
'-'                                  { return '-'; }
'*'                                  { return '*'; }
'+'                                  { return 'ARITHMETIC_OPERATOR'; }
'/'                                  { return 'ARITHMETIC_OPERATOR'; }
'%'                                  { return 'ARITHMETIC_OPERATOR'; }
'|'                                  { return 'ARITHMETIC_OPERATOR'; }
'^'                                  { return 'ARITHMETIC_OPERATOR'; }
'&'                                  { return 'ARITHMETIC_OPERATOR'; }
','                                  { return ','; }
'.'                                  { return '.'; }
':'                                  { return ':'; }
';'                                  { return ';'; }
'~'                                  { return '~'; }
'!'                                  { return '!'; }
'('                                  { return '('; }
')'                                  { return ')'; }
'['                                  { return '['; }
']'                                  { return ']'; }

\$\{[^}]*\}                          { return 'VARIABLE_REFERENCE'; }

\`                                         { this.begin('backtickedValue'); return 'BACKTICK'; }
<backtickedValue>[^`]+                     {
                                             if (parser.handleQuotedValueWithCursor(this, yytext, yylloc, '`')) {
                                               return 'PARTIAL_VALUE';
                                             }
                                             return 'VALUE';
                                           }
<backtickedValue>\`                        { this.popState(); return 'BACKTICK'; }

\'                                         { this.begin('singleQuotedValue'); return 'SINGLE_QUOTE'; }
<singleQuotedValue>(?:\\\\|\\[']|[^'])+    {
                                             if (parser.handleQuotedValueWithCursor(this, yytext, yylloc, '\'')) {
                                               return 'PARTIAL_VALUE';
                                             }
                                             return 'VALUE';
                                           }
<singleQuotedValue>\'                      { this.popState(); return 'SINGLE_QUOTE'; }

\"                                         { this.begin('doubleQuotedValue'); return 'DOUBLE_QUOTE'; }
<doubleQuotedValue>(?:\\\\|\\["]|[^"])+         {
                                             if (parser.handleQuotedValueWithCursor(this, yytext, yylloc, '"')) {
                                               return 'PARTIAL_VALUE';
                                             }
                                             return 'VALUE';
                                           }
<doubleQuotedValue>\"                      { this.popState(); return 'DOUBLE_QUOTE'; }

<<EOF>>                                    { return 'EOF'; }

.                                          { /* To prevent console logging of unknown chars */ }
<between>.                                 { }
<hdfs>.                                    { }
<backtickedValue>.                         { }
<singleQuotedValue>.                       { }
<doubleQuotedValue>.                       { }
