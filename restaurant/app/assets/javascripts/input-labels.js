function InputLabel(options) {
  this.formLabelGroup = $(options.formLabelGroup);
  this.inputControl = this.formLabelGroup.find(options.inputControl);
  this.labelControl = this.formLabelGroup.find(options.labelControl);
}

InputLabel.prototype.init = function() {
  this.hideLabel();
  this.blur();
  this.focus();
};

InputLabel.prototype.blur = function() {
  var _this = this;
  this.inputControl.on('blur', function() {
    _this.hideLabel();
  });
};

InputLabel.prototype.focus = function() {
  var _this = this;
  this.inputControl.on('focus', function() {
    $(this).siblings(_this.labelControl).show();
  });
};

InputLabel.prototype.hideLabel = function() {
  $.each(this.inputControl, function() {
    if($(this).val()) {
      $(this).siblings(this.labelControl).hide();
    }
  });
};

$(document).ready(function() {
  var options = {
    formLabelGroup : "[data-id='form-label-group']",
    inputControl : "[data-id='form-control-input']",
    labelControl : "[data-id='control-label']"
  },
    inputLabelObject = new InputLabel(options);
  inputLabelObject.init();
});