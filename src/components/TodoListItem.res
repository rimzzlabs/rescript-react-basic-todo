@react.component
let make = (~id: int, ~title: string, ~n: int, ~removeTodo: int => unit) => {
  <div className="rounded border mb-4 last-of-type:mb-0">
    <div className="py-6 px-4">
      <p> {"No "->String.concat((n + 1)->Int.toString)->React.string} </p>
      <p className="font-medium"> {title->React.string} </p>
    </div>
    <div className="pb-4 px-4 flex justify-end">
      <button
        onClick={_ => {
          removeTodo(id)
        }}
        className="inline-flex items-center justify-center h-10 px-4 rounded bg-red-600 text-stone-50 hover:bg-red-400 transition">
        {"Delete"->React.string}
      </button>
    </div>
  </div>
}
