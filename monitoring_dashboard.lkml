- dashboard: longrunning_schedule_monitoring
  title: Long-Running Schedule Monitoring
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: Long-Running Schedules
    name: Long-Running Schedules
    model: system__activity
    explore: scheduled_plan
    type: looker_grid
    fields: [scheduled_job.status, scheduled_job.status_detail, scheduled_job.name,
      scheduled_job.id, scheduled_job_stage.id, scheduled_job_stage.stage, scheduled_job.scheduled_plan_id,
      scheduled_job_stage.started_time, scheduled_job_stage.completed_time, user.email,
      user.id, dashboard.id, look.id, scheduled_job_stage.avg_runtime]
    filters: {}
    sorts: [scheduled_job_stage.avg_runtime desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_labels:
      user.id: User ID
      scheduled_job.id: Scheduled Job ID
      scheduled_job_stage.id: Scheduled Job Stage ID
      dashboard.id: Dashboard ID
      look.id: Look ID
    series_cell_visualizations:
      scheduled_job_stage.avg_runtime:
        is_active: true
    series_value_format:
      scheduled_job_stage.id:
        name: id
        format_string: '0'
        label: ID
    defaults_version: 1
    listen:
      Scheduled Job ID: scheduled_job.id
      Dashboard ID: dashboard.id
      Scheduled Plan ID: scheduled_plan.id
    row: 0
    col: 0
    width: 24
    height: 8
  - title: Dashboard Query IDs
    name: Dashboard Query IDs
    model: system__activity
    explore: history
    type: looker_grid
    fields: [dashboard.id, dashboard.title, dashboard.link, query.id, query.link,
      history.average_runtime]
    sorts: [history.average_runtime desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Dashboard ID: history.real_dash_id
    row: 8
    col: 0
    width: 11
    height: 8
  - name: How to Use This Dashboard
    type: text
    title_text: How to Use This Dashboard
    subtitle_text: ''
    body_text: |-
      Before we jump into the steps, I wanted to define a couple of key terms you'll see on this dashboard:

      * **Scheduled Job** -- A single instance of a schedule that ran (e.g. what you see when you open the `Admin` -> `Schedule History` panel)
      * **Scheduled Plan** -- The metadata relating to a schedule, as well as the next time it should run (e.g. what you see in the Schedule modal on a dashboard/Look, or what you see in the `Admin` -> `Schedules` panel)

      Now that we understand the differences, here's how to derive value from this dashboard:

      1. Extract a `Scheduled Job ID` value from the `Admin` -> `Schedule History` panel (or via System Activity) for a long-running job we'd like to investigate further. Add that value to the Scheduled Job ID filter.
      2. Once we've honed in on the particular long-running schedule job, extract the `Dashboard ID` value and add it as a filter to the `Dashboard ID` filter on this dashboard.
      3. Examine the `Dashboard Query IDs` tile for long-running queries. Use the `Query Link` field to open that tile's specific query to investigate further.
      4. (Optional) Extract a `Scheduled Plan ID` value and add it to the `Scheduled Plan ID` filter. Remove all other filters and re-run the dashboard to see if this long-running schedule was a one-off occurrence or a recurring issue.
      5. (Optional) Alternatively, you can use the [History hyperlink](https://docs.looker.com/admin-options/scheduler/plans#information_included) in the Admin -> Schedules panel to see previous schedule runs. This can also help identify if the schedule is non-performant or if an issue arose in a 1-off manner.
    row: 8
    col: 11
    width: 13
    height: 8
  filters:
  - name: Scheduled Job ID
    title: Scheduled Job ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: inline
      options: []
    model: system__activity
    explore: scheduled_plan
    listens_to_filters: []
    field: scheduled_job.id
  - name: Scheduled Plan ID
    title: Scheduled Plan ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: system__activity
    explore: scheduled_plan
    listens_to_filters: []
    field: scheduled_plan.id
  - name: Dashboard ID
    title: Dashboard ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: system__activity
    explore: history
    listens_to_filters: []
    field: history.real_dash_id
