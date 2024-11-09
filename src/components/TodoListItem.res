module Window = {
  @scope("window") @val
  external confirm: string => bool = "confirm"
}

@react.component
let make = (
  ~id: int,
  ~title: string,
  ~completed: bool,
  ~removeTodo: int => unit,
  ~completeTodo: (int, bool) => unit,
) => {
  let checkId = React.useId()

  let checkLabel = switch completed {
  | true => "Completed!"
  | false => "Complete"
  }

  let label = switch completed {
  | true => <s> {title->React.string} </s>
  | false => title->React.string
  }

  let onClickRemove = int => _ => removeTodo(int)

  <div className="rounded border mb-2 last-of-type:mb-0">
    <div className="py-3 px-4 flex items-center gap-x-2">
      <div className="flex mr-auto flex-row-reverse items-center gap-x-2">
        <label htmlFor={checkId} className="text-sm font-medium text-stone-800"> {label} </label>
        <input
          id={checkId}
          type_="checkbox"
          onChange={_ => completeTodo(id, completed)}
          checked={completed}
        />
      </div>
      <button
        onClick={onClickRemove(id)}
        className="inline-flex text-sm font-medium items-center justify-center h-7 px-4 rounded bg-red-600 text-stone-50 hover:bg-red-400 transition">
        {"Delete"->React.string}
      </button>
    </div>
  </div>
}
