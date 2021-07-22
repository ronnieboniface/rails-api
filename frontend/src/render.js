const renderAuthors = (authors) => {
  const authorsContainer = document.querySelector('.left');
  authors.map(author => {
    const li = document.createElement('li');
    li.dataset.id = author.id;
    li.innerText = `${author.first_name} ${author.last_name}`;
    li.addEventListener('click', () => {
      fetchAuthor(author.id)
    })
    authorsContainer.appendChild(li);
  })
};

const renderAuthor = (author) => {
  const authorName = document.createElement('p');
  // why do you think we might want to add this dataset id?
  authorInfo.dataset.id = author.id;
  authorName.innerText = `${author.first_name} ${author.last_name}`;
  authorName.classList = 'name';
  // what else do we need to do in here?
  authorInfo.appendChild(authorName);

  renderBooks(author.books);
};

const renderBooks = (books) => {
  return books.map(book => {
    renderBook(book);
  });
};

const renderBook = (book) => {
  const bookDiv = document.createElement('div');
  bookDiv.classList = "book-div";

  const title = document.createElement('p');
  title.classList = 'book-title';
  title.innerText = book.title;

  const publisher = document.createElement('p');
  publisher.innerText = `Publisher: ${book.publisher}`;

  const genre = document.createElement('p');
  genre.innerText = `Genre: ${book.genre}`;

  const pages = document.createElement('p');
  pages.innerText = `Pages: ${book.pages}`

  bookDiv.appendChild(title);
  bookDiv.appendChild(publisher);
  bookDiv.appendChild(genre);
  bookDiv.appendChild(pages);

  authorInfo.appendChild(bookDiv);
};