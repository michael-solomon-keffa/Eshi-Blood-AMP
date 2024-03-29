const mongoose = require("mongoose");
const mongoosePaginate = require("mongoose-paginate");

const appointmentSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
    acceptorId: {
      type: String,
    },
    startDate: {
      type: Date,
    },
    endDate: {
      type: Date,
    },
    status: {
      type: String,
      enum: ["active", "pending", "donated", "rejected", "canceled"],
      default: "pending",
    },
    appointmentDescription: {
      type: String,
    },

    weight: {
      type: String,
    },
    healthCondition: {
      type: String,
    },
    tattoo: {
      type: String,
    },
    pregnant: {
      type: String,
    },
    donationCenter: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "DonationCenter",
    },
    isDeleted: {
      type: Boolean,
      default: false,
    },
  },
  {
    timestamps: true,
  }
);

appointmentSchema.plugin(mongoosePaginate);

const Appointment = mongoose.model("Appointment", appointmentSchema);

module.exports = Appointment;
