Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8C64FE994
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 22:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiDLUnP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 16:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiDLUmy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 16:42:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A051704E
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=j0by0npqCyevpFr0e9s/uO2tRbkL6fmzEW7VD0mn3vo=; t=1649795858; x=1651005458; 
        b=SlRu0U1WXQJ5SLdi0Od04xXC3ATkkhmqql9OHr3H6X2AxFBnpXebBbK4su7IN06nBxs3c3ZWi2h
        y6cOoh6CAoDnsNJ9W5TtDId8o4wALou43HRHKpF+XLJgViRWF5kEPEJdLrMpXZM+1l4OZz1ltXSNV
        OWXGnAyrOenEonAqBxChn+C9sA41E5uEol1OXOKLHkmyW+Enyz/vNFLW4vDbSh+mmMIi4UbkwiyZ1
        w94Ufk968bEbaVIVhNI3/Kn82aB65s6RuAP2z4HaX2rqEsJh1AdvOhmRneV6A4OCeIG7fz0+Y0Gt3
        Pfg/A0n74yjoIb5Oh5zX7D+UxqJmhinCZPZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1neMpu-0096U2-Hu;
        Tue, 12 Apr 2022 22:10:02 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] cfg80211: remove cfg80211_get_chan_state()
Date:   Tue, 12 Apr 2022 22:09:59 +0200
Message-Id: <20220412220958.1a191dca19d7.Ide4448f02d0e2f1ca2992971421ffc1933a5370a@changeid>
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
 net/wireless/chan.c    | 93 +-----------------------------------------
 net/wireless/core.h    | 14 +------
 net/wireless/ibss.c    |  4 +-
 4 files changed, 3 insertions(+), 113 deletions(-)

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
index 8b7fb4a9e07b..f74f176e0d9d 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -6,7 +6,7 @@
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2018-2021	Intel Corporation
+ * Copyright 2018-2022	Intel Corporation
  */
 
 #include <linux/export.h>
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
index 3a7dbd63d8c6..5436ada91b1a 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -3,7 +3,7 @@
  * Wireless configuration interface internals.
  *
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #ifndef __NET_WIRELESS_CORE_H
 #define __NET_WIRELESS_CORE_H
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
index 8f98e546becf..5d89eec2869a 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -3,7 +3,7 @@
  * Some IBSS support code for cfg80211.
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2020-2021 Intel Corporation
+ * Copyright (C) 2020-2022 Intel Corporation
  */
 
 #include <linux/etherdevice.h>
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

