@react.component
let make = (~todos: array<Todo.Todo.todo>, ~removeTodo: int => unit) => {
  let todoLength = todos->Array.length
  let isEmpty = todoLength === 0

  switch isEmpty {
  | false =>
    <div className="pb-10">
      <h2>
        {"List of todos ("
        ->String.concat(todoLength->Int.toString)
        ->String.concat(")")
        ->React.string}
      </h2>
      {Array.mapWithIndex(todos, (todo, i) => {
        <TodoListItem title={todo.title} id={todo.id} n={i} removeTodo />
      })->React.array}
    </div>
  | true =>
    <div
      className="h-96 flex items-center justify-center text-center text-balance rounded bg-stone-100">
      <p> {"No items yet"->React.string} </p>
    </div>
  }
}
