module Window = {
  @scope("window") @val
  external confirm: string => bool = "confirm"
}

@react.component
let make = (
  ~id: int,
  ~title: string,
  ~n: int,
  ~completed: bool,
  ~removeTodo: int => unit,
  ~completeTodo: (int, bool) => unit,
) => {
  let checkId = React.useId()

  let checkLabel = switch completed {
  | true => "Completed!"
  | false => "Complete"
  }

  let onClickRemove = int => _ => {
    let text = "Are you sure you want to remove this item?"
    let sure = Window.confirm(text)
    if sure {
      removeTodo(int)
    }
  }

  <div className="rounded border mb-4 last-of-type:mb-0">
    <div className="py-6 px-4 flex items-start gap-x-2">
      <div className="flex-1">
        <p> {"No "->String.concat((n + 1)->Int.toString)->React.string} </p>
        <p className="font-medium"> {title->React.string} </p>
      </div>
      <div className="shrink-0 inline-flex items-center gap-x-1">
        <label htmlFor={checkId} className="text-sm font-medium text-stone-500">
          {checkLabel->React.string}
        </label>
        <input
          id={checkId}
          type_="checkbox"
          onChange={_ => completeTodo(id, completed)}
          checked={completed}
        />
      </div>
    </div>
    <div className="pb-4 px-4 flex justify-end">
      <button
        onClick={onClickRemove(id)}
        className="inline-flex items-center justify-center h-10 px-4 rounded bg-red-600 text-stone-50 hover:bg-red-400 transition">
        {"Delete"->React.string}
      </button>
    </div>
  </div>
}
