type addTodo = string => unit
type resetTodo = unit => unit

@react.component
let make = (~addTodo: addTodo) => {
  let id = React.useId()
  let (value, setValue) = React.useState(() => "")

  let addValidTodo = (title: string) => {
    let isValidTitle = Todo.Todo.isValidTitle(title)
    switch isValidTitle {
    | true => {
        addTodo(title)
        setValue(_v => "")
      }
    | false => ()
    }
  }

  let onClick = (title: string) => {
    (_e: JsxEventU.Mouse.t) => addValidTodo(title)
  }
  let onKeyDown = (e: JsxEvent.Keyboard.t) => {
    let target = JsxEvent.Keyboard.target(e)
    let key = JsxEvent.Keyboard.key(e)
    let value = target["value"]

    switch key === "Enter" {
    | true =>
      switch value->Type.typeof {
      | #string => addValidTodo(value)
      | _ => ()
      }
    | false => ()
    }
  }

  <div className="flex items-end gap-x-2">
    <div className="w-full">
      <label htmlFor={id}> {"Todo name"->React.string} </label>
      <input
        id={id}
        name={id}
        value={value}
        onKeyDown={onKeyDown}
        placeholder="write something for later"
        onChange={(ev: JsxEvent.Form.t) => {
          let target = JsxEvent.Form.target(ev)
          let value: string = target["value"]
          setValue(_prevValue => value)
        }}
        className="h-10 px-2 rounded outline-none w-full bg-stone-100 border"
      />
    </div>
    <div className="flex justify-end pt-4 shrink-0">
      <button
        onClick={onClick(value)}
        className="inline-flex items-center justify-center h-10 px-4 rounded bg-stone-800 text-stone-100 hover:bg-stone-900 transition">
        {"Submit"->React.string}
      </button>
    </div>
  </div>
}
