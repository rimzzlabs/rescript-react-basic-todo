@react.component
let make = (
  ~todos: array<Todo.Todo.todo>,
  ~removeTodo: int => unit,
  ~completeTodo: (int, bool) => unit,
  ~resetTodo: unit => unit,
) => {
  let todoLength = todos->Array.length
  let isEmpty = todoLength === 0

  switch isEmpty {
  | false =>
    <div className="py-8">
      <div className="pb-4">
        <h2>
          {"List of todos ("
          ->String.concat(todoLength->Int.toString)
          ->String.concat(")")
          ->React.string}
        </h2>
        {Array.mapWithIndex(todos, (todo, i) => {
          <TodoListItem
            n={i}
            id={todo.id}
            key={todo.id->Int.toString}
            title={todo.title}
            completed={todo.completed}
            completeTodo={completeTodo}
            removeTodo={removeTodo}
          />
        })->React.array}
      </div>
      <div className="flex justify-end">
        <button className="px-4 h-10 bg-red-100 rounded text-red-800" onClick={_ => resetTodo()}>
          {"Reset List"->React.string}
        </button>
      </div>
    </div>
  | true =>
    <div className="py-8">
      <div
        className="h-96 flex items-center justify-center text-center text-balance rounded bg-stone-100">
        <p> {"No items yet"->React.string} </p>
      </div>
    </div>
  }
}
