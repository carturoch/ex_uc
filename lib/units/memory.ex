defmodule ExUc.Units.Memory do
  @moduledoc """
  Defines units and conversions for the Memory kind.

  Computer data storage, often called storage or memory, 
  is a technology consisting of computer components and recording media used to retain digital data.

  _More info [here](https://en.wikipedia.org/wiki/Byte#Unit_symbol)._

  ## Included Units and Aliases

    - **B**, byte, bytes, Byte, bytes
    - **KB**, kB, kilobytes, kilobyte, Kilobyte, Kilobytes
    - **MB**, megabytes, megabyte, Megabyte, Megabytes
    - **GB**, gigabytes, gigabyte, Gigabyte, Gigabytes
    - **TB**, terabytes, terabyte, Terabyte, Terabytes
    - **PB**, petabytes, petabyte, Petabyte, Petabytes
    - **EB**, exabytes, exabyte, Exabyte, Exabytes
    - **ZB**, zettabytes, zettabyte, Zettabyte, Zettabytes
    - **YB**, yottabytes, yottabyte, Yottabyte, Yottabytes
    - **b**, bit, bits, Bit, Bits
    - **Kb**, kb, kilobits, kilobit, Kilobit, Kilobits
    - **Mb**, megabits, megabit, Megabit, Megabits
    - **Gb**, gigabits, gigabit, Gigabit, Gigabits
    - **Tb**, terabits, terabit, Terabit, Terabits
    - **Pb**, petabits, petabit, Petabit, Petabits
    - **Eb**, exabits, exabit, Exabit, Exabits
    - **Zb**, zettabits, zettabit, Zettabit, Zettabits
    - **Yb**, yottabits, yottabit, Yottabit, Yottabits
    - **KiB**, kibibytes, kibibyte, Kibibyte, Kibibytes
    - **MiB**, mebibytes, mebibyte, Mebibyte, Mebibytes
    - **GiB**, gibibytes, gibibyte, Gibibyte, Gibibytes
    - **TiB**, tebibytes, tebibyte, Tebibyte, Tebibytes
    - **PiB**, pebibytes, pebibyte, Pebibyte, Pebibytes
    - **EiB**, exbibytes, exbibyte, Exbibyte, Exbibytes
    - **ZiB**, zebibytes, zebibyte, Zebibyte, Zebibytes
    - **YiB**, yobibytes, yobibyte, Yobibyte, Yobibytes

  """
  use ExUc.Kind

  def units do
    [
      # SI Units
      B: ~w(byte bytes Byte bytes),
      KB: ~w(kB kilobytes kilobyte Kilobyte Kilobytes),
      MB: ~w(megabytes megabyte Megabyte Megabytes),
      GB: ~w(gigabytes gigabyte Gigabyte Gigabytes),
      TB: ~w(terabytes terabyte Terabyte Terabytes),
      PB: ~w(petabytes petabyte Petabyte Petabytes),
      EB: ~w(exabytes exabyte Exabyte Exabytes),
      ZB: ~w(zettabytes zettabyte Zettabyte Zettabytes),
      YB: ~w(yottabytes yottabyte Yottabyte Yottabytes),
      b: ~w(bit bits Bit Bits),
      Kb: ~w(kb kilobits kilobit Kilobit Kilobits),
      Mb: ~w(megabits megabit Megabit Megabits),
      Gb: ~w(gigabits gigabit Gigabit Gigabits),
      Tb: ~w(terabits terabit Terabit Terabits),
      Pb: ~w(petabits petabit Petabit Petabits),
      Eb: ~w(exabits exabit Exabit Exabits),
      Zb: ~w(zettabits zettabit Zettabit Zettabits),
      Yb: ~w(yottabits yottabit Yottabit Yottabits),

      # ISO/IEC 80000 units
      KiB: ~w(kibibytes kibibyte Kibibyte Kibibytes),
      MiB: ~w(mebibytes mebibyte Mebibyte Mebibytes),
      GiB: ~w(gibibytes gibibyte Gibibyte Gibibytes),
      TiB: ~w(tebibytes tebibyte Tebibyte Tebibytes),
      PiB: ~w(pebibytes pebibyte Pebibyte Pebibytes),
      EiB: ~w(exbibytes exbibyte Exbibyte Exbibytes),
      ZiB: ~w(zebibytes zebibyte Zebibyte Zebibytes),
      YiB: ~w(yobibytes yobibyte Yobibyte Yobibytes),
    ]
  end

  def conversions do
    [
      B_to_b: 8,
      YB_to_ZB: 1000,
      ZB_to_EB: 1000,
      EB_to_TB: 1000,
      EB_to_TB: 1000,
      TB_to_GB: 1000,
      GB_to_MB: 1000,
      MB_to_KB: 1000,
      KB_to_B: 1000,
      Yb_to_Zb: 1000,
      Zb_to_Eb: 1000,
      Eb_to_Tb: 1000,
      Eb_to_Tb: 1000,
      Tb_to_Gb: 1000,
      Gb_to_Mb: 1000,
      Mb_to_Kb: 1000,
      Kb_to_b: 1000,
      YiB_to_ZiB: 1024,
      ZiB_to_EiB: 1024,
      EiB_to_TiB: 1024,
      EiB_to_TiB: 1024,
      TiB_to_GiB: 1024,
      GiB_to_MiB: 1024,
      MiB_to_KiB: 1024,
      KiB_to_B: 1024
    ]
  end
end
