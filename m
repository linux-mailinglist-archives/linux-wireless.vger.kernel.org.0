Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473844FE957
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 22:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiDLUPF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 16:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiDLUPC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 16:15:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8FAB645E
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=DvXP29wr0qTTPtoDc/epf0W9+yJEFZNyem++GYEyQFc=; t=1649794361; x=1651003961; 
        b=ScszqcwH5aYTtOcbHlxalddIbspVf0tYIY0zW82OnXK5VSEQ3sEuYYL0cO8usJ4fmpYVDJI2kVl
        V4tB9a9GnlyJf5nwyNS9Xsklhs0rEwDCpCR59rFXuoGhAnxKQDFSff20uuA1cY7vv4xK2kpCuegFT
        T/AjKfMDGk+90vS+L7ijtxt/fAqnZR4tjD+jGlTidZw0IluimqwnXsBpTdyspAt4954faoY2pLJ0+
        X4DgWz7lsd8Favfy2dGSAoAd0f+NMqBpe7HLJ41dgLyKKpN6QTc/yJ82Mco/xT7kAMlweIJpSD74f
        Pj7Hk1iu+ZLWQlLV8TUHp3rfOo5Kj0mIFAjg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1neMo9-0096RH-3T;
        Tue, 12 Apr 2022 22:08:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] cfg80211: remove cfg80211_get_chan_state()
Date:   Tue, 12 Apr 2022 22:08:10 +0200
Message-Id: <20220412220809.026f03c412c0.Ide4448f02d0e2f1ca2992971421ffc1933a5370a@changeid>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We haven't used this function for years, since commit c781944b71f8
("cfg80211: Remove unused cfg80211_can_use_iftype_chan()") which
itself removed a function unused since commit 97dc94f1d933
("cfg80211: remove channel_switch combination check"), almost eight
years ago.

Also remove the now unused enum cfg80211_chan_mode and some struct
members that were only used for this function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  5 ---
 net/wireless/chan.c    | 91 ------------------------------------------
 net/wireless/core.h    | 12 ------
 net/wireless/ibss.c    |  2 -
 4 files changed, 110 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 68713388b617..cd1212113901 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5549,8 +5549,6 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
  * @conn_owner_nlportid: (private) connection owner socket port ID
  * @disconnect_wk: (private) auto-disconnect work
  * @disconnect_bssid: (private) the BSSID to use for auto-disconnect
- * @ibss_fixed: (private) IBSS is using fixed BSSID
- * @ibss_dfs_possible: (private) IBSS may change to a DFS channel
  * @event_list: (private) list for internal event processing
  * @event_lock: (private) lock for event list
  * @owner_nlportid: (private) owner socket port ID
@@ -5599,9 +5597,6 @@ struct wireless_dev {
 	struct cfg80211_chan_def preset_chandef;
 	struct cfg80211_chan_def chandef;
 
-	bool ibss_fixed;
-	bool ibss_dfs_possible;
-
 	bool ps;
 	int ps_timeout;
 
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 8b7fb4a9e07b..21962ac08d72 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1344,97 +1344,6 @@ int cfg80211_set_monitor_channel(struct cfg80211_registered_device *rdev,
 	return rdev_set_monitor_channel(rdev, chandef);
 }
 
-void
-cfg80211_get_chan_state(struct wireless_dev *wdev,
-		        struct ieee80211_channel **chan,
-		        enum cfg80211_chan_mode *chanmode,
-		        u8 *radar_detect)
-{
-	int ret;
-
-	*chan = NULL;
-	*chanmode = CHAN_MODE_UNDEFINED;
-
-	ASSERT_WDEV_LOCK(wdev);
-
-	if (wdev->netdev && !netif_running(wdev->netdev))
-		return;
-
-	switch (wdev->iftype) {
-	case NL80211_IFTYPE_ADHOC:
-		if (wdev->current_bss) {
-			*chan = wdev->current_bss->pub.channel;
-			*chanmode = (wdev->ibss_fixed &&
-				     !wdev->ibss_dfs_possible)
-				  ? CHAN_MODE_SHARED
-				  : CHAN_MODE_EXCLUSIVE;
-
-			/* consider worst-case - IBSS can try to return to the
-			 * original user-specified channel as creator */
-			if (wdev->ibss_dfs_possible)
-				*radar_detect |= BIT(wdev->chandef.width);
-			return;
-		}
-		break;
-	case NL80211_IFTYPE_STATION:
-	case NL80211_IFTYPE_P2P_CLIENT:
-		if (wdev->current_bss) {
-			*chan = wdev->current_bss->pub.channel;
-			*chanmode = CHAN_MODE_SHARED;
-			return;
-		}
-		break;
-	case NL80211_IFTYPE_AP:
-	case NL80211_IFTYPE_P2P_GO:
-		if (wdev->cac_started) {
-			*chan = wdev->chandef.chan;
-			*chanmode = CHAN_MODE_SHARED;
-			*radar_detect |= BIT(wdev->chandef.width);
-		} else if (wdev->beacon_interval) {
-			*chan = wdev->chandef.chan;
-			*chanmode = CHAN_MODE_SHARED;
-
-			ret = cfg80211_chandef_dfs_required(wdev->wiphy,
-							    &wdev->chandef,
-							    wdev->iftype);
-			WARN_ON(ret < 0);
-			if (ret > 0)
-				*radar_detect |= BIT(wdev->chandef.width);
-		}
-		return;
-	case NL80211_IFTYPE_MESH_POINT:
-		if (wdev->mesh_id_len) {
-			*chan = wdev->chandef.chan;
-			*chanmode = CHAN_MODE_SHARED;
-
-			ret = cfg80211_chandef_dfs_required(wdev->wiphy,
-							    &wdev->chandef,
-							    wdev->iftype);
-			WARN_ON(ret < 0);
-			if (ret > 0)
-				*radar_detect |= BIT(wdev->chandef.width);
-		}
-		return;
-	case NL80211_IFTYPE_OCB:
-		if (wdev->chandef.chan) {
-			*chan = wdev->chandef.chan;
-			*chanmode = CHAN_MODE_SHARED;
-			return;
-		}
-		break;
-	case NL80211_IFTYPE_MONITOR:
-	case NL80211_IFTYPE_AP_VLAN:
-	case NL80211_IFTYPE_P2P_DEVICE:
-	case NL80211_IFTYPE_NAN:
-		/* these interface types don't really have a channel */
-		return;
-	case NL80211_IFTYPE_UNSPECIFIED:
-	case NL80211_IFTYPE_WDS:
-	case NUM_NL80211_IFTYPES:
-		WARN_ON(1);
-	}
-}
-
 bool cfg80211_any_usable_channels(struct wiphy *wiphy,
 				  unsigned long sband_mask,
 				  u32 prohibited_flags)
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 3a7dbd63d8c6..b9aa6f52a308 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -281,12 +281,6 @@ struct cfg80211_cached_keys {
 	int def;
 };
 
-enum cfg80211_chan_mode {
-	CHAN_MODE_UNDEFINED,
-	CHAN_MODE_SHARED,
-	CHAN_MODE_EXCLUSIVE,
-};
-
 struct cfg80211_beacon_registration {
 	struct list_head list;
 	u32 nlportid;
@@ -525,12 +519,6 @@ static inline unsigned int elapsed_jiffies_msecs(unsigned long start)
 	return jiffies_to_msecs(end + (ULONG_MAX - start) + 1);
 }
 
-void
-cfg80211_get_chan_state(struct wireless_dev *wdev,
-		        struct ieee80211_channel **chan,
-		        enum cfg80211_chan_mode *chanmode,
-		        u8 *radar_detect);
-
 int cfg80211_set_monitor_channel(struct cfg80211_registered_device *rdev,
 				 struct cfg80211_chan_def *chandef);
 
diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index 8f98e546becf..bcbdd27b0b1c 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -131,8 +131,6 @@ int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
 		kfree_sensitive(wdev->connect_keys);
 	wdev->connect_keys = connkeys;
 
-	wdev->ibss_fixed = params->channel_fixed;
-	wdev->ibss_dfs_possible = params->userspace_handles_dfs;
 	wdev->chandef = params->chandef;
 	if (connkeys) {
 		params->wep_keys = connkeys->params;
-- 
2.35.1

