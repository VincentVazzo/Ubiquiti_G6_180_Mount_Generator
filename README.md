# Ubiquiti G6 180 - Parametric Soffit Mount

A fully customizable, parametric camera mount designed to be laser-cut from sheet metal and tucked neatly into your exterior eaves or soffits. 

This project is perfect for getting those exterior security cameras permanently and securely mounted, especially if you are taking the time to hardwire them back to a dedicated camera VLAN on your Ubiquiti gear or other home network setup.

Because laser-cutting services like [SendCutSend](https://sendcutsend.com/) require highly specific 2D vector files, this guide will walk you through customizing the dimensions in OpenSCAD and formatting the final file in Inkscape so it passes the automated quoting systems perfectly.

## 🛠️ Software Requirements

You will need two free, open-source programs to generate your cut files:
1. **[OpenSCAD](https://openscad.org/downloads.html)**: To customize the parametric model.  For better performance, download a "Nightly Build" instead of the latest Release (really).
2. **[Inkscape](https://inkscape.org/)**: To format the vector paths specifically for SendCutSend.

---

## ⚙️ Step 1: Customize Your Mount

1. Clone or download this repository and open `camera_soffit_mount.scad` in **OpenSCAD**.
2. Ensure the Customizer panel is visible by checking **Window > Customizer** in the top menu.
3. Use the Control Panel on the right side of the screen to adjust the variables for your specific camera base and house:
   * **plate_length & plate_width:** The overall physical dimensions of the metal plate.
   * **center_holes:** Check to automatically center your mounting holes, or uncheck to manually offset them.
   * **gutter_width:** The amount of the plate on *both ends* that will tuck up into the soffit tracks. This acts as a restricted zone for your holes.
   * **show_gutter_debug:** Check this box to overlay a red zone showing exactly where the soffit covers the plate. This helps visually verify that your camera fits perfectly in the exposed area.

> **⚠️ CRITICAL:** You MUST uncheck `show_gutter_debug` before proceeding to the next step! Leaving it on will merge the red warning blocks into your final cut file.

---

## 💾 Step 2: Export from OpenSCAD

1. With `show_gutter_debug` unchecked, press **F6** to Render the final 2D geometry. The design should turn a solid color (usually yellow/green).
2. Go to **File > Export > Export as SVG...**
3. Uncheck Fill and Stroke options.
4. Save the file to your computer.

---

## 🧼 Step 3: The "Inkscape Wash" (Prep for SendCutSend)

OpenSCAD's native DXF exports are often rejected by modern automated laser-cutting parsers. We use Inkscape as a "middleman" to weld the paths and generate a flawless AutoCAD R14 DXF.

1. Open your exported `.svg` file in **Inkscape**.
2. Press **Ctrl + A** (or Cmd + A on Mac) to select the entire object.
3. Go to **Path > Union** in the top menu. This welds all the OpenSCAD shapes into one continuous, laser-ready path.
4. Go to **File > Document Properties** (or Shift + Ctrl + D).
5. Go to **File > Save As...** 7. In the format dropdown, select **Desktop Cutting Plotter (AutoCAD DXF R14) (*.dxf)** and hit Save.
6. A secondary dialog box will appear. **Uncheck** both "Use" options (like ROBO-Master splines). Ensure the **Base unit** is set to **mm** and Character Encoding is **UTF8**. Click **OK**.

---

## 🛒 Step 4: Order Your Parts

Your DXF is now perfectly formatted! 

1. Head over to [SendCutSend](https://app.sendcutsend.com/quote).
2. Upload your new `.dxf` file. Ensure the system reads the overall dimensions correctly in millimeters.
3. **Material Recommendations:** Since this will live outside, select a rust-proof material. **5052 Aluminum** (lightweight and easy to drill if you make a mistake) or **304 Stainless Steel** (incredibly rigid) are ideal for exterior soffit mounts.
