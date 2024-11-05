@react.component
let make = () => {
  let (state, updateState) = React.useReducer(Todo.Todo.reducerFn, Todo.Todo.state)

  let addTodo = (title: string) => updateState(AddTodo({id: Date.now()->Belt.Float.toInt, title}))

  <div className="max-w-2xl mx-auto w-11/12">
    <header className="pt-10 pb-4">
      <h1 className="text-4xl text-center font-bold text-balance">
        {"Todo Example with React and ReScript"->React.string}
      </h1>
    </header>
    <TodoForm addTodo={addTodo} />
    <div className="py-4 flex justify-center">
      <button
        className="px-4 h-10 bg-red-100 rounded text-red-800" onClick={_ => updateState(Reset)}>
        {"Reset List"->React.string}
      </button>
    </div>
    <TodoList todos={state.todos} removeTodo={id => updateState(id->RemoveTodo)} />
  </div>
}
