/**
 *  Contains logic related to the management of platform event for a given transaction
 *
 *	@author	designingobjects@gmail.com
 */
 
 public without sharing class PlatformEventManager implements ISingleton{
    
    private static PlatformEventManager instance;
    
    public static PlatformEventManager getInstance () {
 		if(instance == null) {
 			instance = new PlatformEventManager();
 		}
 		return instance;
 	}
}