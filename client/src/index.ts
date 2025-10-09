console.log('Hello, Consumers!');

// Example function
function greet(name: string): string {
  return `Welcome to, ${name}!`;
}

// Example usage
const message = greet('Confi');
console.log(message);

export { greet };