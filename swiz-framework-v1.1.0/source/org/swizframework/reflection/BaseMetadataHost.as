/*
 * Copyright 2010 Swiz Framework Contributors
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License. You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package org.swizframework.reflection
{
	/**
	 * Base implementation of the IMetadataHost interface.
	 * Implements getters and setters and initializes <code>metadataTags</code> Array.
	 *
	 * @see org.swizframework.reflection.IMetadataHost
	 * @see org.swizframework.reflection.MetadataHostClass
	 * @see org.swizframework.reflection.MetadataHostMethod
	 * @see org.swizframework.reflection.MetadataHostProperty
	 */
	public class BaseMetadataHost implements IMetadataHost
	{
		// ========================================
		// protected properties
		// ========================================
		
		/**
		 * Backing variable for <code>name</code> getter/setter.
		 */
		protected var _name:*;
		
		/**
		 * Backing variable for <code>type</code> getter/setter.
		 */
		protected var _type:Class;
		
		/**
		 * Backing variable for <code>metadataTags</code> getter/setter.
		 */
		protected var _metadataTags:Array;
		
		// ========================================
		// public properties
		// ========================================
		
		/**
		 * @inheritDoc
		 */
		public function get name():*
		{
			return _name;
		}
		
		public function set name( value:* ):void
		{
			_name = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get type():Class
		{
			return _type;
		}
		
		public function set type( value:Class ):void
		{
			_type = value;
		}
		
		[ArrayElementType( "org.swizframework.reflection.IMetadataTag" )]
		
		/**
		 * @inheritDoc
		 */
		public function get metadataTags():Array
		{
			return _metadataTags;
		}
		
		public function set metadataTags( value:Array ):void
		{
			_metadataTags = value;
		}
		
		public function getMetadataTagByName( name:String ):IMetadataTag
		{
			for each ( var metadataTag:IMetadataTag in metadataTags )
			{
				if ( metadataTag.name == name )
					{
						return metadataTag;
					}
				}
			return null;
		}
		
		public function hasMetadataTagByName( name:String ):Boolean
		{
			return getMetadataTagByName( name ) != null;
		}
		
		// ========================================
		// constructor
		// ========================================
		
		/**
		 * Constructor initializes <code>metadataTags</code> Array.
		 */
		public function BaseMetadataHost()
		{
			metadataTags = [];
		}
	}
}