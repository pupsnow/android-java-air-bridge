////////////////////////////////////////////////////////////////////////////////
//
//  This program is free software; you can redistribute it and/or modify 
//  it under the terms of the GNU General Public License as published by the 
//  Free Software Foundation; either version 3 of the License, or (at your 
//  option) any later version.
//
//  This program is distributed in the hope that it will be useful, but 
//  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
//  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
//  for more details.
//
//  You should have received a copy of the GNU General Public License along 
//  with this program; if not, see <http://www.gnu.org/licenses>.
//
////////////////////////////////////////////////////////////////////////////////

package
{
import merapi.systemexecute.messages.SystemExecuteMessage;

/**
 *  Performs a systemExecute by creating a SystemExecutMessage and sending it to the
 *  native Merapi Bridge.
 */
public function systemExecute( args : Array ) : void
{
	var sem : SystemExecuteMessage 	= new SystemExecuteMessage();
		sem.args 					= args;
		sem.send();
} //  end top level function
} //  end package