{{- define "hue-log4j-properties" }}

# Define some default values that can be overridden by system properties
hadoop.log.dir=.
hadoop.log.file=hadoop.log

# Define the root logger to the system property "hadoop.root.logger".
log4j.rootLogger=INFO,console, EventCounter

# Logging Threshold
log4j.threshhold=ALL

#
# Daily Rolling File Appender
#

log4j.appender.DRFA=org.apache.log4j.DailyRollingFileAppender
log4j.appender.DRFA.File=${hadoop.log.dir}/${hadoop.log.file}

# Rollver at midnight
log4j.appender.DRFA.DatePattern=.yyyy-MM-dd

# 30-day backup
#log4j.appender.DRFA.MaxBackupIndex=30
log4j.appender.DRFA.layout=org.apache.log4j.PatternLayout

# Pattern format: Date LogLevel LoggerName LogMessage
log4j.appender.DRFA.layout.ConversionPattern=%d{ISO8601} %p %c: %m%n
# Debugging Pattern format
#log4j.appender.DRFA.layout.ConversionPattern=%d{ISO8601} %-5p %c{2} (%F:%M(%L)) - %m%n


#
# console
# Add "console" to rootlogger above if you want to use this
#

log4j.appender.console=org.apache.log4j.ConsoleAppender
log4j.appender.console.target=System.err
log4j.appender.console.layout=org.apache.log4j.PatternLayout
log4j.appender.console.layout.ConversionPattern=%d{yy/MM/dd HH:mm:ss} %p %c{2}: %m%n

#
# Rolling File Appender
#

#log4j.appender.RFA=org.apache.log4j.RollingFileAppender
#log4j.appender.RFA.File=${hadoop.log.dir}/${hadoop.log.file}

# Logfile size and and 30-day backups
#log4j.appender.RFA.MaxFileSize=1MB
#log4j.appender.RFA.MaxBackupIndex=30

#log4j.appender.RFA.layout=org.apache.log4j.PatternLayout
#log4j.appender.RFA.layout.ConversionPattern=%d{ISO8601} %-5p %c{2} - %m%n
#log4j.appender.RFA.layout.ConversionPattern=%d{ISO8601} %-5p %c{2} (%F:%M(%L)) - %m%n

#
# Event Counter Appender
# Sends counts of logging messages at different severity levels to Hadoop
# Metrics.
#
log4j.appender.EventCounter=org.apache.hadoop.metrics.jvm.EventCounter

{{- end }}
