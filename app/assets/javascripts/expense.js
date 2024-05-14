$(document).on('click', '#addExpenseButton', function() {
  var formData = $('#expenseForm').serialize();
  $.ajax({
    url: '/expenses',
    type: 'POST',
    data: formData,
    success: function(response) {
      console.log('Expense created successfully:', response);
    },
    error: function(xhr, status, error) {
      console.error('Error creating expense:', error);
    }
  });
});

document.addEventListener('DOMContentLoaded', function() {
  var isShareableCheckbox = document.querySelector('#expense_items .form-check-input');
  var userSelection = document.querySelector('#user-selection');
  var userSelectionCheckboxes = userSelection.querySelectorAll('input[type="checkbox"]');

  function toggleUserSelection() {
    userSelection.style.display = isShareableCheckbox.checked ? 'block' : 'none';
    userSelectionCheckboxes.forEach(function(checkbox) {
      checkbox.checked = isShareableCheckbox.checked;
    });
  }

  isShareableCheckbox.addEventListener('change', toggleUserSelection);
          toggleUserSelection();
        });