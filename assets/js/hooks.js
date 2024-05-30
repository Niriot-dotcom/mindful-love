import flatpickr from "../vendor/flatpickr";
import PhoneNumber from "./PhoneNumberHook";
import Clipboard from "./ClipboardHook";

let Hooks = {
  PhoneNumber,
  Clipboard,
};

Hooks.Calendar = {
  mounted() {
    console.log("Calendar HOOK mounted", this.el);
    this.pickr = flatpickr(this.el, {
      inline: true,
      showMonths: 1,
      maxDate: new Date().fp_incr(60),
      // maxDate: new Date(new Date().setMonth(new Date().getMonth() + 2)),
      // disable: JSON.parse(this.el.dataset.unavailableDates),
      minDate: "today",
      onChange: (selectedDates) => {
        if (selectedDates.length < 1) return;
        // selectedDates = selectedDates.map((date) => this.utcStartOfDay(date));
        this.pushEvent("date-picked", selectedDates[0]);
        console.log("selectedDates: ", selectedDates);
      },
    });

    this.handleEvent("add-unavailable-dates", (dates) => {
      this.pickr.set("disable", [dates, ...this.pickr.config.disable]);
    });

    this.pushEvent("unavailable-dates", {}, (reply, ref) => {
      this.pickr.set("disable", reply.dates);
    });
  },
  destroyed() {
    this.pickr.destroy();
  },
  updated() {
    console.log("CALENDAR HOOK updated");
  },
  utcStartOfDay(date) {
    const newDate = new Date(date);
    // important to set it in descending order, smaller time units
    // can shift bigger ones, if those are not already set in UTC.
    newDate.setUTCFullYear(date.getFullYear());
    newDate.setUTCMonth(date.getMonth());
    newDate.setUTCDate(date.getDate());
    newDate.setUTCHours(0, 0, 0, 0);
    return newDate;
  },
};

Hooks.MultiSelect = {
  mounted() {
    console.log("MultiSelect HOOK mounted", this.el);

    // this.handleEvent("add-unavailable-dates", (dates) => {
    //   this.pickr.set("disable", [dates, ...this.pickr.config.disable]);
    // });

    // console.log("HERE MultiSelect");
    // el.addEventListener("click", (event) => {
    //   console.log("HERE MultiSelect CLICKCKSKSK");
    //   event.preventDefault(); // Prevent default multi-select behavior
    //   const option = event.target.closest("option");
    //   if (option) {
    //     option.selected = !option.selected;
    //   }
    // });
  },
};

export default Hooks;
