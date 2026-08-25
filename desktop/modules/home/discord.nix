{
  programs.nixcord = {
    enable = true;
    user = "aether";
    discord = {
      branches = [ "stable" ];
      equicord.enable = true;
      krisp.enable = true;
    };

    quickCss = "
      @import url('https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/themes/midnight.theme.css');
    ";
    config = {
      useQuickCss = true;
      frameless = false;

      plugins = {
        alwaysAnimate.enable = true;
        anonymiseFileNames.enable = true;
        betterAudioPlayer.enable = true;
        betterBanReasons.enable = true;
        betterBlockedUsers.enable = true;
        betterCommands.enable = true;
        betterForwards.enable = true;
        betterGifAltText.enable = true;
        betterGifPicker.enable = true;
        betterInvites.enable = true;
        betterPlusReacts.enable = true;
        betterRoleContext.enable = true;
        betterRoleDot.enable = true;
        betterSessions.enable = true;
        betterSettings.enable = true;
        betterUploadButton.enable = true;
        biggerStreamPreview.enable = true;
        callTimer.enable = true;
        characterCounter.enable = true;
        clearUrls.enable = true;
        concatenatedComponentExtractor.enable = true;
        copyStickerLinks.enable = true;
        copyUserUrls.enable = true;
        crashHandler.enable = true;
        customCommands.enable = true;
        dearrow.enable = true;
        declutter.enable = true;
        disableCallIdle.enable = true;
        disableDeepLinks.enable = true;
        dragify.enable = true;
        equicordHelper.enable = true;
        exportMessages.enable = true;
        fakeNitro.enable = true;
        fastDeleteChannels.enable = true;
        favoriteEmojiFirst.enable = true;
        favouriteAnything.enable = true;
        fixFileExtensions.enable = true;
        fixImagesQuality.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        fontLoader = {
          enable = true;
          selectedFont = "Comfortaa";
          applyOnCodeBlocks = true;
        };
        forceOwnerCrown.enable = true;
        gameActivityToggle.enable = true;
        ghosted.enable = true;
        gifMaker.enable = true;
        googleThat.enable = true;
        imageZoom.enable = true;
        memberCount.enable = true;
        moreCommands.enable = true;
        newPluginsManager.enable = true;
        noNitroUpsell.enable = true;
        noTrack.enable = true;
        petpet.enable = true;
        platformIndicators.enable = true;
        quickReply.enable = true;
        readAllNotificationsButton.enable = true;
        settings.enable = true;
        silentTyping.enable = true;
        supportHelper.enable = true;
        translatePlus.enable = true;
        typingIndicator.enable = true;
        typingTweaks.enable = true;
        unlimitedAccounts.enable = true;
        webContextMenus.enable = true;
        webKeybinds = {
          enable = true;
          overrideCommonKeybinds = true;
        };
        webScreenShareFixes.enable = true;
        youtubeAdblock.enable = true;
      }; 
    };
  };
}
