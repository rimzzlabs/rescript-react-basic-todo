type addTodo = string => unit
type resetTodo = unit => unit

@react.component
let make = (~addTodo: addTodo) => {
  let id = React.useId()
  let (value, setValue) = React.useState(() => "")

  let onClick = (val: string) => {
    (_e: JsxEventU.Mouse.t) => {
      let isNotEmptyValue = val->String.replaceRegExp(%re("/\s+/g"), "")->String.length > 0
      if isNotEmptyValue {
        addTodo(val)
        setValue(_v => "")
      }
    }
  }

  <div className="flex items-end gap-x-2">
    <div className="w-full">
      <label htmlFor={id}> {"Todo name"->React.string} </label>
      <input
        id={id}
        name={id}
        value={value}
        placeholder="write something for later"
        onKeyDown={(ev: JsxEvent.Keyboard.t) => {
          let target = JsxEvent.Keyboard.target(ev)
          let key = JsxEvent.Keyboard.key(ev)
          let value: string = target["value"]

          if key === "Enter" {
            addTodo(value)
            setValue(_v => "")
          }
        }}
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
