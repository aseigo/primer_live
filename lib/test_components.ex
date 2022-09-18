defmodule PrimerLive.TestComponents do
  use Phoenix.Component
  use Phoenix.HTML

  alias PrimerLive.Helpers.{Attributes}

  # ------------------------------------------------------------------------------------
  # test_alert
  # ------------------------------------------------------------------------------------

  @doc section: :alerts

  @doc ~S"""
  Creates an test_alert message.

  [Examples](#test_alert/1-examples) • [Attributes](#test_alert/1-attributes) • [Reference](#test_alert/1-reference)

  ```
  <.test_alert>
    Flash message goes here.
  </.test_alert>
  ```

  ## Examples

  Success color:

  ```
  <.test_alert is_success>
    You're done!
  </.test_alert>
  ```

  Multiline message:

  ```
  <.test_alert is_success>
    <p>You're done!</p>
    <p>You may close this message</p>
  </.test_alert>
  ```

  To add an extra bottom margin alerts, wrap alerts in `test_alert_messages/1`.

  [INSERT LVATTRDOCS]

  Additional HTML attributes are passed to the outer element.

  ## Reference

  [Primer/CSS Alerts](https://primer.style/css/components/alerts/)

  ## Status

  Feature complete.

  """

  attr(:class, :string, doc: "Additional classname.")
  attr(:is_error, :boolean, default: false, doc: "Sets the color to \"error\".")
  attr(:is_success, :boolean, default: false, doc: "Sets the color to \"success\".")
  attr(:is_warning, :boolean, default: false, doc: "Sets the color to \"warning\".")

  attr(:is_full, :boolean,
    default: false,
    doc: "Renders the test_alert full width, with border and border radius removed."
  )

  slot(:inner_block, required: true, doc: "Alert content.")

  def test_alert(assigns) do
    assigns =
      assigns
      |> assign(
        :extra,
        # Attributes
        assigns_to_attributes(assigns, [
          :class,
          :is_error,
          :is_full,
          :is_success,
          :is_warning
        ])
      )

    class =
      Attributes.classnames([
        "flash",
        assigns[:class],
        assigns.is_error and "flash-error",
        assigns.is_success and "flash-success",
        assigns.is_warning and "flash-warn",
        assigns.is_full and "flash-full"
      ])

    ~H"""
    <div class={class} {@extra}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # test_alert_messages
  # ------------------------------------------------------------------------------------

  @doc section: :alerts

  @doc ~S"""
  Wrapper to render a vertical stack of `test_alert/1` messages with spacing in between.

  [Attributes](#test_alert_messages/1-attributes) • [Reference](#test_alert_messages/1-reference)

  ```
  <.test_alert_messages>
    <.test_alert is_success>
      Message 1
    </.test_alert>
    <.test_alert class="mt-4">
      Message 2
    </.test_alert>
  </.test_alert_messages>
  Rest of content
  ```

  [INSERT LVATTRDOCS]

  Additional HTML attributes are passed to the outer element.

  ## Reference

  [Primer/CSS Alerts](https://primer.style/css/components/alerts/)

  ## Status

  Feature complete.

  """

  attr(:class, :string, doc: "Additional classname.")

  slot(:inner_block, required: true, doc: "Alert messages content.")

  def test_alert_messages(assigns) do
    assigns =
      assigns
      |> assign(
        :extra,
        assigns_to_attributes(assigns, [
          # Attributes
          :class,
          :is_error,
          :is_full,
          :is_success,
          :is_warning
        ])
      )

    class =
      Attributes.classnames([
        "flash-messages",
        assigns[:class]
      ])

    ~H"""
    <div class={class} {@extra}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # layout
  # ------------------------------------------------------------------------------------

  @doc section: :layout

  @doc ~S"""
  Creates a responsive-friendly page layout with 2 columns.

  [Examples](#test_layout/1-examples) • [Attributes](#test_layout/1-attributes) • [Reference](#test_layout/1-reference)

  ```
  <.test_layout>
    <:main>
      Main content
    </:main>
    <:sidebar>
      Sidebar content
    </:sidebar>
  </.test_layout>
  ```

  ## Examples

  The position of the sidebar is set by CSS (and can be changed with attribute `is_sidebar_position_end`).

  To place the sidebar at the right:

  ```
  <.test_layout is_sidebar_position_end>
    <:main>
      Main content
    </:main>
    <:sidebar>
      Sidebar content
    </:sidebar>
  </.test_layout>
  ```

  When using a divider, use attribute `is_divided` to make the divider element visible.

  Extra divider modifiers for vertical layout (on small screens):

  - `is_divided` creates a 1px border between main and sidebar
  - `is_divided` with `is_flow_row_hidden` hides the divider
  - `is_divided` with `is_flow_row_shallow` shows a filled 8px divider


  ```
  <.test_layout is_divided>
    <:main>
      Main content
    </:main>
    <:divider></:divider>
    <:sidebar>
      Sidebar content
    </:sidebar>
  </.test_layout>
  ```

  The modifiers `is_centered_xx` create a wrapper around `main` to center its content up to a maximum width.
  Use with `.container-xx` classes to restrict the size of the content:

  ```
  <.test_layout is_centered_md>
    <:main>
      <div class="container-md">
        Centered md
      </div>
    </:main>
    <:sidebar>
      Sidebar content
    </:sidebar>
  </.test_layout>
  ```

  Layouts can be nested.

  Nested layout, example 1:

  ```
  <.test_layout>
    <:main>
      <.test_layout is_sidebar_position_end is_narrow_sidebar>
        <:main>
          Main content
        </:main>
        <:sidebar>
          Metadata sidebar
        </:sidebar>
      </.test_layout>
    </:main>
    <:sidebar>
      Default sidebar
    </:sidebar>
  </.test_layout>
  ```

  Nested layout, example 2:

  ```
  <.test_layout>
    <:main>
      <.test_layout is_sidebar_position_end is_flow_row_until_lg is_narrow_sidebar>
        <:main>
          Main content
        </:main>
        <:sidebar>
          Metadata sidebar
        </:sidebar>
      </.test_layout>
    </:main>
    <:sidebar>
      Default sidebar
    </:sidebar>
  </.test_layout>
  ```

  [INSERT LVATTRDOCS]

  Additional HTML attributes are passed to the outer element.

  ## Reference

  [Primer/CSS Layout](https://primer.style/css/components/layout/)

  ## Status

  Feature complete.

  """

  attr(:class, :string, doc: "Additional classname.")

  attr(:is_divided, :boolean,
    default: false,
    doc:
      "Use `is_divided` in conjunction with the `layout_item/1` element with attribute `divider` to show a divider between the main content and the sidebar. Creates a 1px line between main and sidebar."
  )

  attr(:is_narrow_sidebar, :boolean,
    default: false,
    doc: "Smaller sidebar size. Widths: md: 240px, lg: 256px."
  )

  attr(:is_wide_sidebar, :boolean,
    default: false,
    doc: "Wider sidebar size. Widths: md: 296px, lg: 320px, xl: 344px."
  )

  attr(:is_gutter_none, :boolean, default: false, doc: "Changes the gutter size to 0px.")
  attr(:is_gutter_condensed, :boolean, default: false, doc: "Changes the gutter size to 16px.")

  attr(:is_gutter_spacious, :boolean,
    default: false,
    doc: "Changes the gutter sizes to: md: 16px, lg: 32px, xl: 40px."
  )

  attr(:is_sidebar_position_start, :boolean,
    default: false,
    doc: "Places the sidebar at the start (commonly at the left) (default)."
  )

  attr(:is_sidebar_position_end, :boolean,
    default: false,
    doc: "Places the sidebar at the end (commonly at the right)."
  )

  attr(:is_sidebar_position_flow_row_start, :boolean,
    default: false,
    doc: "When stacked, render the sidebar first (default)."
  )

  attr(:is_sidebar_position_flow_row_end, :boolean,
    default: false,
    doc: "When stacked, render the sidebar last."
  )

  attr(:is_sidebar_position_flow_row_none, :boolean,
    default: false,
    doc: "When stacked, hide the sidebar."
  )

  attr(:is_flow_row_until_md, :boolean, default: false, doc: "Stacks when container is md.")
  attr(:is_flow_row_until_lg, :boolean, default: false, doc: "Stacks when container is lg.")

  attr(:is_centered_lg, :boolean,
    default: false,
    doc: "Creates a wrapper around `main` to keep its content centered up to max width \"lg\"."
  )

  attr(:is_centered_md, :boolean,
    default: false,
    doc: "Creates a wrapper around `main` to keep its content centered up to max width \"md\"."
  )

  attr(:is_centered_xl, :boolean,
    default: false,
    doc: "Creates a wrapper around `main` to keep its content centered up to max width \"xl\"."
  )

  attr(:is_flow_row_hidden, :boolean,
    default: false,
    doc: "On a small screen (up to 544px). Hides the horizontal divider."
  )

  attr(:is_flow_row_shallow, :boolean,
    default: false,
    doc: "On a small screen (up to 544px). Creates a filled 8px horizontal divider."
  )

  slot :main,
    doc:
      "Creates a main element. Default gutter sizes: md: 16px, lg: 24px (change with `is_gutter_none`, `is_gutter_condensed` and `is_gutter_spacious`). Stacks when container is `sm` (change with `is_flow_row_until_md` and `is_flow_row_until_lg`)." do
    attr(:order, :integer,
      doc:
        "Markup order, defines in what order the slot is rendered in HTML. Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether main or sidebar comes first in code. The markup order won't affect the visual position. Possible values: 1 or 2; default value: 2."
    )
  end

  slot(:divider,
    doc:
      "Creates a divider element. The divider will only be shown with option `is_divided`. Creates a line between the main and sidebar elements - horizontal when the elements are stacked and vertical when they are shown side by side."
  )

  slot :sidebar,
    doc:
      "Creates a sidebar element. Widths: md: 256px, lg: 296px (change with `is_narrow_sidebar` and `is_wide_sidebar`)." do
    attr :order, :integer, doc: "See `main` slot. Default value: 1."
  end

  def test_layout(assigns) do
    assigns =
      assigns
      |> assign(
        :extra,
        assigns_to_attributes(assigns, [
          # Attributes
          :class,
          :is_centered_lg,
          :is_centered_md,
          :is_centered_xl,
          :is_divided,
          :is_flow_row_hidden,
          :is_flow_row_shallow,
          :is_flow_row_until_lg,
          :is_flow_row_until_md,
          :is_gutter_condensed,
          :is_gutter_none,
          :is_gutter_spacious,
          :is_narrow_sidebar,
          :is_sidebar_position_end,
          :is_sidebar_position_flow_row_end,
          :is_sidebar_position_flow_row_none,
          :is_sidebar_position_flow_row_start,
          :is_sidebar_position_start,
          :is_wide_sidebar,
          # Slots
          :divider,
          :main,
          :sidebar
        ])
      )

    classes = %{
      layout:
        Attributes.classnames([
          "Layout",
          assigns[:class],
          assigns.is_divided and "Layout--divided",
          assigns.is_narrow_sidebar and "Layout--sidebar-narrow",
          assigns.is_wide_sidebar and "Layout--sidebar-wide",
          assigns.is_gutter_none and "Layout--gutter-none",
          assigns.is_gutter_condensed and "Layout--gutter-condensed",
          assigns.is_gutter_spacious and "Layout--gutter-spacious",
          assigns.is_sidebar_position_start and "Layout--sidebarPosition-start",
          assigns.is_sidebar_position_end and "Layout--sidebarPosition-end",
          assigns.is_sidebar_position_flow_row_start and "Layout--sidebarPosition-flowRow-start",
          assigns.is_sidebar_position_flow_row_end and "Layout--sidebarPosition-flowRow-end",
          assigns.is_sidebar_position_flow_row_none and "Layout--sidebarPosition-flowRow-none",
          assigns.is_flow_row_until_md and "Layout--flowRow-until-md",
          assigns.is_flow_row_until_lg and "Layout--flowRow-until-lg"
        ]),
      main: "Layout-main",
      main_center_wrapper:
        Attributes.classnames([
          assigns.is_centered_md and "Layout-main-centered-md",
          assigns.is_centered_lg and "Layout-main-centered-lg",
          assigns.is_centered_xl and "Layout-main-centered-xl"
        ]),
      sidebar: "Layout-sidebar",
      divider:
        Attributes.classnames([
          "Layout-divider",
          assigns.is_flow_row_shallow and "Layout-divider--flowRow-shallow",
          assigns.is_flow_row_hidden and "Layout-divider--flowRow-hidden"
        ])
    }

    default_slot_order = %{
      sidebar: 1,
      main: 2
    }

    sortable_slots = [
      main: assigns.main,
      sidebar: assigns.sidebar
    ]

    sorted_slots =
      sortable_slots
      # Remove empty slots
      |> Enum.filter(fn {_key, slot_list} -> slot_list !== [] end)
      # Translate user input to an order number (integer) and sort by order number
      |> Enum.sort_by(
        fn {key, slot_list} ->
          order =
            slot_list
            |> Enum.at(0)
            |> Map.get(:order)
            |> Attributes.as_integer(default_slot_order[key])

          order
        end,
        :asc
      )

    # Insert the divider slot if it can be inserted between 2 slots
    slots =
      case Enum.count(sorted_slots) == 2 do
        true -> List.insert_at(sorted_slots, 1, {:divider, assigns.divider})
        false -> sorted_slots
      end

    ~H"""
    <div class={classes.layout} {@extra}>
      <%= for {key, slot} <- slots do %>
        <%= if key == :main && slot !== [] do %>
          <%= if @is_centered_md || @is_centered_lg || @is_centered_xl do %>
            <div class={classes.main}>
              <div class={classes.main_center_wrapper}>
                <%= render_slot(slot) %>
              </div>
            </div>
          <% else %>
            <div class={classes.main}>
              <%= render_slot(slot) %>
            </div>
          <% end %>
        <% end %>
        <%= if key == :divider && slot !== [] do %>
          <div class={classes.divider}>
            <%= render_slot(slot) %>
          </div>
        <% end %>
        <%= if key == :sidebar && slot !== [] do %>
          <div class={classes.sidebar}>
            <%= render_slot(@sidebar) %>
          </div>
        <% end %>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # box
  # ------------------------------------------------------------------------------------

  @doc section: :layout

  @doc ~S"""
  Creates a content container.

  [Examples](#test_box/1-examples) • [Attributes](#test_box/1-attributes) • [Reference](#test_box/1-reference)

  A `box` is a container with rounded corners, a white background, and a light gray border.
  By default, there are no other styles, such as padding; however, these can be introduced
  with utility classes as needed.

  ```
  <.test_box>
    Content
  </.test_box>
  ```

  Slots allow for the creation of alternative styles and layouts.

  ```
  <.test_box>
    <:header>Header</:header>
    <:body>Body</:body>
    <:row>Row</:row>
    <:footer>Footer</:footer>
  </.test_box>
  ```

  ## Examples

  Row themes:

  ```
  <.test_box>
    <:row is_gray>Row</:row>
    <:row is_hover_gray>Row</:row>
    <:row is_yellow>Row</:row>
    <:row is_hover_blue>Row</:row>
    <:row is_blue>Row</:row>
  </.test_box>
  ```

  Box theme - "danger box":

  ```
  <.test_box is_danger>
    <:row>Row</:row>
    <:row>Row</:row>
  </.test_box>
  ```

  Header theme - blue header:

  ```
  <.box>
    <:header is_blue>Blue header</:header>
  </.box>
  ```

  Render a row for each search result:

  ```
  <.test_box>
    <:row :for={result <- @results}>
      <%= result %>
    </:row>
  </.test_box>
  ```

  Conditionally show an alert:

  ```
   <.test_box>
    <.alert :if={@show_alert}>Alert message</.alert>
    <:body>
      Body
    </:body>
  </.test_box>
  ```

  Header title. Slot `header` can be omitted:

  ```
  <.test_box>
    <:header_title>
      Title
    </:header_title>
    Content
  </.test_box>
  ```

  Header with a button, using both `header` and `header_title` slots. The title will be inserted as first header element:

  ```
  <.test_box>
    <:header class="d-flex flex-items-center">
      <.button is_primary is_smmall>
        Button
      </.button>
    </:header>
    <:header_title class="flex-auto">
      Title
    </:header_title>
    <:body>
      Rest
    </:body>
  </.test_box>
  ```

  Header with icon button:

  ```
  <.test_box>
    <:header class="d-flex flex-justify-between flex-items-start">
      <.button is_close_button aria-label="Close" class="flex-shrink-0 pl-4">
        <.octicon name="x-16" />
      </.button>
    </:header>
    <:header_title>
      A very long title that wraps onto multiple lines without overlapping or wrapping underneath the icon to it's right
    </:header_title>
    <:body>Content</:body>
  </.test_box>
  ```

  [INSERT LVATTRDOCS]

  Additional HTML attributes are passed to the outer element.

  ## Reference

  [Primer/CSS Box](https://primer.style/css/components/box/)

  ## Status

  Feature complete

  """

  attr(:class, :string, doc: "Additional classname.")

  attr(:is_blue, :boolean,
    default: false,
    doc: "Creates a blue box theme."
  )

  attr(:is_danger, :boolean,
    default: false,
    doc: "Creates a danger color box theme. Only works with slots `row` and `body`."
  )

  attr(:is_border_dashed, :boolean,
    default: false,
    doc: "Applies a dashed border to the box."
  )

  attr(:is_condensed, :boolean,
    default: false,
    doc: "Condenses line-height and reduces the padding on the Y axis."
  )

  attr(:is_spacious, :boolean,
    default: false,
    doc: "Increases padding and increases the title font size."
  )

  slot :header,
    doc: "Creates a header row element." do
    attr :class, :string, doc: "Additional classname."
    attr :is_blue, :boolean, doc: "Change the header border and background to blue."
  end

  slot :header_title,
    doc:
      "Creates a title within the header. If no header slot is passed, the header title will be wrapped inside a header element." do
    attr :class, :string, doc: "Additional classname."
  end

  slot :row,
    doc: "Creates a content row element." do
    attr :class, :string, doc: "Additional classname."
    attr :is_blue, :boolean, doc: "Blue row theme."
    attr :is_gray, :boolean, doc: "Gray row theme."
    attr :is_yellow, :boolean, doc: "Yellow row theme."
    attr :is_hover_blue, :boolean, doc: "Changes to blue row theme on hover."
    attr :is_hover_gray, :boolean, doc: "Changes to gray row theme on hover."
    attr :is_focus_blue, :boolean, doc: "Changes to blue row theme on focus."
    attr :is_focus_gray, :boolean, doc: "Changes to gray row theme on focus."

    attr :is_navigation_focus, :boolean,
      doc: "Combine with a theme color to highlight the row when using keyboard commands."

    attr :is_unread, :boolean,
      doc: "Apply a blue vertical line highlight for indicating a row contains unread items."

    attr :is_link, :boolean, doc: "Use with link attributes such as \"href\" to generate a link."
  end

  slot :body,
    doc: "Creates a body element." do
    attr :class, :string, doc: "Additional classname."
  end

  slot :footer,
    doc: "Creates a footer row element." do
    attr :class, :string, doc: "Additional classname."
  end

  def test_box(assigns) do
    assigns =
      assigns
      |> assign(
        :extra,
        assigns_to_attributes(assigns, [
          # Attributes
          :class,
          :is_blue,
          :is_border_dashed,
          :is_condensed,
          :is_danger,
          :is_spacious,
          # Slots
          :body,
          :footer,
          :header,
          :header_title,
          :row
        ])
      )
      |> assign(
        :header_slots,
        Enum.zip(Attributes.pad_lists(assigns.header, assigns.header_title, []))
      )

    classes = %{
      box:
        Attributes.classnames([
          "Box",
          assigns[:class],
          assigns.is_blue and "Box--blue",
          assigns.is_border_dashed and "border-dashed",
          assigns.is_condensed and "Box--condensed",
          assigns.is_danger and "Box--danger",
          assigns.is_spacious and "Box--spacious"
        ]),
      header: fn slot ->
        Attributes.classnames([
          "Box-header",
          slot[:class],
          slot[:is_blue] && "Box-header--blue"
        ])
      end,
      row: fn slot ->
        Attributes.classnames([
          "Box-row",
          slot[:class],
          slot[:is_blue] && "Box-row--blue",
          slot[:is_focus_blue] && "Box-row--focus-blue",
          slot[:is_focus_gray] && "Box-row--focus-gray",
          slot[:is_gray] && "Box-row--gray",
          slot[:is_hover_blue] && "Box-row--hover-blue",
          slot[:is_hover_gray] && "Box-row--hover-gray",
          slot[:is_navigation_focus] && "navigation-focus",
          slot[:is_yellow] && "Box-row--yellow",
          slot[:is_unread] && "Box-row--unread"
        ])
      end,
      body: fn slot ->
        Attributes.classnames([
          "Box-body",
          slot[:class]
        ])
      end,
      footer: fn slot ->
        Attributes.classnames([
          "Box-footer",
          slot[:class]
        ])
      end,
      header_title: fn slot ->
        Attributes.classnames([
          "Box-title",
          slot[:class]
        ])
      end,
      link: "Box-row-link"
    }

    attributes = %{
      link: fn slot ->
        Attributes.append_attributes(
          assigns_to_attributes(slot, [
            :class,
            :is_blue,
            :is_focus_blue,
            :is_focus_gray,
            :is_gray,
            :is_hover_blue,
            :is_hover_gray,
            :is_link,
            :is_navigation_focus,
            :is_unread,
            :is_yellow
          ]),
          [
            [
              class:
                Attributes.classnames([
                  classes.link
                ])
            ]
          ]
        )
      end
    }

    render_header = fn data ->
      ~H"""
      <%= for {slot, header_slot} <- data do %>
        <div class={classes.header.(slot)}>
          <%= if header_slot && header_slot !== [] do %>
            <h3 class={classes.header_title.(header_slot)}>
              <%= render_slot(header_slot) %>
            </h3>
          <% end %>
          <%= if slot && slot !== [] do %>
            <%= render_slot(slot) %>
          <% end %>
        </div>
      <% end %>
      """
    end

    render_row = fn slots ->
      ~H"""
      <%= for slot <- slots do %>
        <div class={classes.row.(slot)}>
          <%= if slot[:is_link] do %>
            <a {attributes.link.(slot)}><%= render_slot(slot) %></a>
          <% else %>
            <%= render_slot(slot) %>
          <% end %>
        </div>
      <% end %>
      """
    end

    render_body = fn slots ->
      ~H"""
      <%= for slot <- slots do %>
        <div class={classes.body.(slot)}>
          <%= render_slot(slot) %>
        </div>
      <% end %>
      """
    end

    render_footer = fn slots ->
      ~H"""
      <%= for slot <- slots do %>
        <div class={classes.footer.(slot)}>
          <%= render_slot(slot) %>
        </div>
      <% end %>
      """
    end

    ~H"""
    <div class={classes.box} {@extra}>
      <%= if @header_slots && @header_slots !== [] do %>
        <%= render_header.(@header_slots) %>
      <% end %>
      <%= render_slot(@inner_block) %>
      <%= if @body && @body !== [] do %>
        <%= render_body.(@body) %>
      <% end %>
      <%= if @row && @row !== [] do %>
        <%= render_row.(@row) %>
      <% end %>
      <%= if @footer && @footer !== [] do %>
        <%= render_footer.(@footer) %>
      <% end %>
    </div>
    """
  end
end
