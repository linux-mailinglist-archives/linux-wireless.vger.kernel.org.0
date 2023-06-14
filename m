Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA2E7215BC
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjFDJMO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjFDJMN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:12:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8491B4
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869925; x=1717405925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RlccYh8hxRYmQAEB+8NvLpnWRmL/FGaJLScUdpZTR10=;
  b=i0TQkRXvxCUuWjsem0zpd8JW3X9dgNrZn5J5MNe1qb4/sNs53X2sHrlD
   IS4+r3PzAvnkwTWPhOLzvU8n4MyiW2eVIUvecF4GSpaCaEbEDg8P8oF47
   PfQv/W96aphVK6ATdUxEsz5Ke73vNzDkEMA7m9Qb6ZAxOD4yCCgzN1gZy
   UWvyUfyaW1KVzWhl2nMho2516fORzbZ5fV2N10V5TccU1f8T+qZ84wtKg
   iZ5HGTCFpVgWOQZOQNR5UM++9CmPYNq9Rmzyhe3rkfnsqREsIqten1fRH
   yksdOC2CxhS4lPeIcLzVTElJqtGsdzO2YmsU+GCg6SQSOO1uHmP+pZvby
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526522"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526522"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804679"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804679"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:03 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/16] wifi: mac80211: move sta_info_move_state() up
Date:   Sun,  4 Jun 2023 12:11:21 +0300
Message-Id: <20230604120651.05bb735d7075.I984b5c194a0f84580247d73620a4e61a5f82a774@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230604091128.609335-1-gregory.greenman@intel.com>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

To fix a sequencing issue, this code needs to be changed
a bit. Move it up in the file to prepare for that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/sta_info.c | 201 ++++++++++++++++++++--------------------
 1 file changed, 100 insertions(+), 101 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index a1cd5c234f47..dc76bc40350f 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -4,7 +4,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 
 #include <linux/module.h>
@@ -1274,6 +1274,105 @@ static int __must_check __sta_info_destroy_part1(struct sta_info *sta)
 	return 0;
 }
 
+int sta_info_move_state(struct sta_info *sta,
+			enum ieee80211_sta_state new_state)
+{
+	might_sleep();
+
+	if (sta->sta_state == new_state)
+		return 0;
+
+	/* check allowed transitions first */
+
+	switch (new_state) {
+	case IEEE80211_STA_NONE:
+		if (sta->sta_state != IEEE80211_STA_AUTH)
+			return -EINVAL;
+		break;
+	case IEEE80211_STA_AUTH:
+		if (sta->sta_state != IEEE80211_STA_NONE &&
+		    sta->sta_state != IEEE80211_STA_ASSOC)
+			return -EINVAL;
+		break;
+	case IEEE80211_STA_ASSOC:
+		if (sta->sta_state != IEEE80211_STA_AUTH &&
+		    sta->sta_state != IEEE80211_STA_AUTHORIZED)
+			return -EINVAL;
+		break;
+	case IEEE80211_STA_AUTHORIZED:
+		if (sta->sta_state != IEEE80211_STA_ASSOC)
+			return -EINVAL;
+		break;
+	default:
+		WARN(1, "invalid state %d", new_state);
+		return -EINVAL;
+	}
+
+	sta_dbg(sta->sdata, "moving STA %pM to state %d\n",
+		sta->sta.addr, new_state);
+
+	/* notify the driver before the actual changes so it can
+	 * fail the transition
+	 */
+	if (test_sta_flag(sta, WLAN_STA_INSERTED)) {
+		int err = drv_sta_state(sta->local, sta->sdata, sta,
+					sta->sta_state, new_state);
+		if (err)
+			return err;
+	}
+
+	/* reflect the change in all state variables */
+
+	switch (new_state) {
+	case IEEE80211_STA_NONE:
+		if (sta->sta_state == IEEE80211_STA_AUTH)
+			clear_bit(WLAN_STA_AUTH, &sta->_flags);
+		break;
+	case IEEE80211_STA_AUTH:
+		if (sta->sta_state == IEEE80211_STA_NONE) {
+			set_bit(WLAN_STA_AUTH, &sta->_flags);
+		} else if (sta->sta_state == IEEE80211_STA_ASSOC) {
+			clear_bit(WLAN_STA_ASSOC, &sta->_flags);
+			ieee80211_recalc_min_chandef(sta->sdata, -1);
+			if (!sta->sta.support_p2p_ps)
+				ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
+		}
+		break;
+	case IEEE80211_STA_ASSOC:
+		if (sta->sta_state == IEEE80211_STA_AUTH) {
+			set_bit(WLAN_STA_ASSOC, &sta->_flags);
+			sta->assoc_at = ktime_get_boottime_ns();
+			ieee80211_recalc_min_chandef(sta->sdata, -1);
+			if (!sta->sta.support_p2p_ps)
+				ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
+		} else if (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
+			ieee80211_vif_dec_num_mcast(sta->sdata);
+			clear_bit(WLAN_STA_AUTHORIZED, &sta->_flags);
+			ieee80211_clear_fast_xmit(sta);
+			ieee80211_clear_fast_rx(sta);
+		}
+		break;
+	case IEEE80211_STA_AUTHORIZED:
+		if (sta->sta_state == IEEE80211_STA_ASSOC) {
+			ieee80211_vif_inc_num_mcast(sta->sdata);
+			set_bit(WLAN_STA_AUTHORIZED, &sta->_flags);
+			ieee80211_check_fast_xmit(sta);
+			ieee80211_check_fast_rx(sta);
+		}
+		if (sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
+		    sta->sdata->vif.type == NL80211_IFTYPE_AP)
+			cfg80211_send_layer2_update(sta->sdata->dev,
+						    sta->sta.addr);
+		break;
+	default:
+		break;
+	}
+
+	sta->sta_state = new_state;
+
+	return 0;
+}
+
 static void __sta_info_destroy_part2(struct sta_info *sta)
 {
 	struct ieee80211_local *local = sta->local;
@@ -2252,106 +2351,6 @@ void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 	}
 }
 
-int sta_info_move_state(struct sta_info *sta,
-			enum ieee80211_sta_state new_state)
-{
-	might_sleep();
-
-	if (sta->sta_state == new_state)
-		return 0;
-
-	/* check allowed transitions first */
-
-	switch (new_state) {
-	case IEEE80211_STA_NONE:
-		if (sta->sta_state != IEEE80211_STA_AUTH)
-			return -EINVAL;
-		break;
-	case IEEE80211_STA_AUTH:
-		if (sta->sta_state != IEEE80211_STA_NONE &&
-		    sta->sta_state != IEEE80211_STA_ASSOC)
-			return -EINVAL;
-		break;
-	case IEEE80211_STA_ASSOC:
-		if (sta->sta_state != IEEE80211_STA_AUTH &&
-		    sta->sta_state != IEEE80211_STA_AUTHORIZED)
-			return -EINVAL;
-		break;
-	case IEEE80211_STA_AUTHORIZED:
-		if (sta->sta_state != IEEE80211_STA_ASSOC)
-			return -EINVAL;
-		break;
-	default:
-		WARN(1, "invalid state %d", new_state);
-		return -EINVAL;
-	}
-
-	sta_dbg(sta->sdata, "moving STA %pM to state %d\n",
-		sta->sta.addr, new_state);
-
-	/*
-	 * notify the driver before the actual changes so it can
-	 * fail the transition
-	 */
-	if (test_sta_flag(sta, WLAN_STA_INSERTED)) {
-		int err = drv_sta_state(sta->local, sta->sdata, sta,
-					sta->sta_state, new_state);
-		if (err)
-			return err;
-	}
-
-	/* reflect the change in all state variables */
-
-	switch (new_state) {
-	case IEEE80211_STA_NONE:
-		if (sta->sta_state == IEEE80211_STA_AUTH)
-			clear_bit(WLAN_STA_AUTH, &sta->_flags);
-		break;
-	case IEEE80211_STA_AUTH:
-		if (sta->sta_state == IEEE80211_STA_NONE) {
-			set_bit(WLAN_STA_AUTH, &sta->_flags);
-		} else if (sta->sta_state == IEEE80211_STA_ASSOC) {
-			clear_bit(WLAN_STA_ASSOC, &sta->_flags);
-			ieee80211_recalc_min_chandef(sta->sdata, -1);
-			if (!sta->sta.support_p2p_ps)
-				ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
-		}
-		break;
-	case IEEE80211_STA_ASSOC:
-		if (sta->sta_state == IEEE80211_STA_AUTH) {
-			set_bit(WLAN_STA_ASSOC, &sta->_flags);
-			sta->assoc_at = ktime_get_boottime_ns();
-			ieee80211_recalc_min_chandef(sta->sdata, -1);
-			if (!sta->sta.support_p2p_ps)
-				ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
-		} else if (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
-			ieee80211_vif_dec_num_mcast(sta->sdata);
-			clear_bit(WLAN_STA_AUTHORIZED, &sta->_flags);
-			ieee80211_clear_fast_xmit(sta);
-			ieee80211_clear_fast_rx(sta);
-		}
-		break;
-	case IEEE80211_STA_AUTHORIZED:
-		if (sta->sta_state == IEEE80211_STA_ASSOC) {
-			ieee80211_vif_inc_num_mcast(sta->sdata);
-			set_bit(WLAN_STA_AUTHORIZED, &sta->_flags);
-			ieee80211_check_fast_xmit(sta);
-			ieee80211_check_fast_rx(sta);
-		}
-		if (sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
-		    sta->sdata->vif.type == NL80211_IFTYPE_AP)
-			cfg80211_send_layer2_update(sta->sdata->dev,
-						    sta->sta.addr);
-		break;
-	default:
-		break;
-	}
-
-	sta->sta_state = new_state;
-
-	return 0;
-}
-
 static struct ieee80211_sta_rx_stats *
 sta_get_last_rx_stats(struct sta_info *sta)
 {
-- 
2.38.1

