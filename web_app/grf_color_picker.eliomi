(* Graffiti
 * http://www.ocsigen.org/graffiti
 * Copyright (C) 2013 Arnaud Parant
 * Laboratoire PPS - CNRS Université Paris Diderot
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, with linking exception;
 * either version 2.1 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *)

{shared{

type t
type div = [ Html5_types.div ] Eliom_content.Html5.D.elt

(** The agrument is the divisor of 255
*** It have to  be greater than 1 **)
val genere_lll_color : int -> string list list list

(* Some pre-genereated lll_color in several precision *)
val lll_color_p2 : string list list list
val lll_color_p3 : string list list list
val lll_color_p4 : string list list list
val lll_color_p5 : string list list list
val lll_color_p6 : string list list list

(* Some hand-mained lll_color *)
val lll_color_6 : string list list list (* 1 table 2 columns 5 lines *)
val lll_color_10 : string list list list (* 1 table 2 columns 3 lines *)

(**
*** Take one list (tables) of list (columns) of list (lines) of color (string)
*** and build table list with it.
*** By default this list is initialised with lll_color_p5
***
*** It return
*** - t to future action,
*** - color_div, to display current select color,
***     it is not mandatory to include it in page
*** - and the block with all color square content in the genered table **)
val create :
  ?initial_color: int * int * int ->
  ?lll_color: string list list list ->
  unit ->
  (t * div * div)

}}

{client{

(** Get two color_picker to fusion in single
    This new color_picker use color squares of the two olders
    It use color_div of first color_picker given in argument
    It also keep referend on first color_picker's block to future append color

    This action have to be made before start function **)
val fusion : t -> t -> t

(** It allow to add square color and append directly in block
    It have to be made before start **)
val add_square_color : t -> string list list list -> t

val start : t -> unit

(** It allow to add square color after start
    It have not to be used before start **)
val add_square_color_and_start : t -> string list list list -> unit

(** It is not disturbe by fusion or add square **)
val get_color: t -> string

(** get all square color div element *)
val get_square_color_div_list : t -> div list


}}
