(function($) {

  function Countdown(options) {
    this.settings = options;
  }

  Countdown.prototype = {
    start: function(amountOfSeconds) {
      this.stop();
      var amountOfSecondsAsNumber = parseInt(amountOfSeconds);

      if (amountOfSecondsAsNumber) {
        this.secondsRemaining = amountOfSecondsAsNumber;
      } else {
        this.secondsRemaining = parseInt(this.settings.seconds);
      }

      if (this.secondsRemaining > 0 && parseInt(this.settings.cycle) > 0) {
        this.refreshHoursMinutesSeconds();

        if (this.settings.onTick) {
          this.settings.onTick(this.formattedHours, this.formattedMinutes, this.formattedSeconds);
        }

        this.interval = setInterval($.proxy(this.tick, this), 1000);
      } else {
        this.complete();
      }
    },

    stop: function() {
      clearInterval(this.interval);
    },

    resume: function() {
      if (this.secondsRemaining > 0) {
        var isNumber = !isNaN(parseInt(this.secondsRemaining));

        if (isNumber) {
          this.start(this.secondsRemaining);
        }
      }
    },

    resetToCycle: function() {
      if (parseInt(this.secondsRemaining) <= parseInt(this.settings.cycle)) {
        this.start(this.settings.cycle);
      }
    },

    tick: function() {
      this.secondsRemaining -= 1;

      if (this.secondsRemaining == 0) {
        this.complete();
      } else {
        this.refreshHoursMinutesSeconds();

        if (this.settings.onTick) {
          this.settings.onTick(this.formattedHours, this.formattedMinutes, this.formattedSeconds);
        }
      }
    },

    complete: function() {
      this.stop();

      if (this.settings.onComplete) {
        this.settings.onComplete(this.settings.textOnComplete);
      }
    },

    refreshHoursMinutesSeconds: function() {
      this.hoursRemaining = Math.floor(this.secondsRemaining / (60 * 60));

      this.minutesRemaining = this.secondsRemaining % (60 * 60);
      this.hourMinutesRemaining = Math.floor(this.minutesRemaining / 60);

      this.minuteSecondsRemaining = this.minutesRemaining % 60;
      this.hourSecondsRemaining = Math.ceil(this.minuteSecondsRemaining);

      this.formattedHours = this.formatToTwoDigitNumber(this.hoursRemaining);
      this.formattedMinutes = this.formatToTwoDigitNumber(this.hourMinutesRemaining);
      this.formattedSeconds = this.formatToTwoDigitNumber(this.hourSecondsRemaining);
    },

    formatToTwoDigitNumber: function(number) {
      var text = String(number);
      if(text.length == 1){
        text = '0' + text;
      }
      return text;
    }
  };

  var methods = {
    init: function(options) {

      // Repeat over each element in selector
      return this.each(function() {
        var $this = $(this);

        // Attempt to grab saved settings, if they don't exist we'll get "undefined".
        var settings = $this.data('countdown');

        // If we could't grab settings, create them from defaults and passed options
        if(typeof(settings) == 'undefined') {

          var defaults = {
            element: $this,
            seconds: $this.attr('data-countdown-seconds'),
            cycle: $this.attr('data-countdown-cycle'),
            autoStart: true,
            onTick: function(hours, minutes, seconds) {
              $this.text(hours + ':' + minutes + ':' + seconds);
            },
            onComplete: function(textOnComplete) {
              $this.text(textOnComplete);
            }
          }

          settings = $.extend(defaults, options);
        } else {
          settings = $.extend(settings, options);
        }

        $this.data('countdown', new Countdown(settings));

        // run code here
        if ($this.data('countdown').settings.autoStart) {
          $this.data('countdown').start();
        }

      });
    },
    destroy: function(options) {
      // Repeat over each element in selector
      return $(this).each(function() {
        var $this = $(this);

        // run code here
        $this.data('countdown').stop();

        // Remove settings data when deallocating our plugin
        $this.removeData('countdown');
      });
    }
  };

  $.fn.extend({
    countdown: function() {
      var method = arguments[0];
      if (methods[method]) {
        method = methods[method];
        arguments = Array.prototype.slice.call(arguments, 1);
      } else if (typeof(method) == 'object' || !method) {
        method = methods.init;
      } else {
        $.error('Method ' +  method + ' does not exist on jQuery.countdown');
        return this;
      }

      return method.apply(this, arguments);
    }
  });

})(jQuery);
