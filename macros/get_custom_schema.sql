{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if var('connection_schema') is not none -%}

        {{ var('connection_schema') | trim }}

    {%- else -%}

        {{ default_schema }}

    {%- endif -%}

{%- endmacro %}