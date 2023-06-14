Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD507215BD
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjFDJMQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjFDJMP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:12:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDAAE42
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869927; x=1717405927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Su+15TSBLXIPkLs/6cc2Qboq14vMwXDHcZwd7y2j+Mo=;
  b=GLtFTRNXYkzPmgOFjm2K+LgdS9otgWtKLNYg8MRbHonPSuiRFOsRSyQM
   SHIqXf8/wGUoD4rD+LiEsdYZdOR6NLl/vNjAysSxncrS3HvKGgh0PLrNX
   9L7Oo6NkRz7sJNuBDY13avSjTw7koC8oEX5V0THHSmpTUTduIBljksETk
   Cd60mx++hcJefiTxWhSJI+ns9TRC7DIjPbHGIOH5THtAheVA6JmScn2Ax
   wiNyGw40E2mAKKrv1b9kSRQJ87cm2/8QMmLl0eRyolOLD6Uxc4kSwLtNB
   Fb+AymIHJwxczaENUcICo1ugyTMVYWP+kex8etPqj+keE/GnVZrnFjgST
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526531"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526531"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804713"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804713"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/16] wifi: mac80211: batch recalc during STA flush
Date:   Sun,  4 Jun 2023 12:11:22 +0300
Message-Id: <20230604120651.48d262b6b42d.Ia15532657c17535c28ec0c5df263b65f0f80663c@changeid>
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

When we flush stations, we first take them off the list
and then destroy them one by one. If we do the different
mode recalculations while destroying them, we cause the
following scenario:
 - STA 1 has 80 MHz - min chanctx width is now 80 MHz
 - STA 2 has 80 MHz
 - empty STA list
 - destroy STA 2
 - recalc min chanctx width -> results in 20 MHz as
   the STA list is already empty

This is broken, since as far as the driver is concerned
STA 1 still exists at this point, and this causes issues
at least with iwlwifi.

Fix - and also optimize - this by doing the recalc of
min chanctx width (and also P2P PS) only after all the
stations were removed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/sta_info.c | 48 +++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index dc76bc40350f..731b832b257c 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1274,8 +1274,9 @@ static int __must_check __sta_info_destroy_part1(struct sta_info *sta)
 	return 0;
 }
 
-int sta_info_move_state(struct sta_info *sta,
-			enum ieee80211_sta_state new_state)
+static int _sta_info_move_state(struct sta_info *sta,
+				enum ieee80211_sta_state new_state,
+				bool recalc)
 {
 	might_sleep();
 
@@ -1333,18 +1334,22 @@ int sta_info_move_state(struct sta_info *sta,
 			set_bit(WLAN_STA_AUTH, &sta->_flags);
 		} else if (sta->sta_state == IEEE80211_STA_ASSOC) {
 			clear_bit(WLAN_STA_ASSOC, &sta->_flags);
-			ieee80211_recalc_min_chandef(sta->sdata, -1);
-			if (!sta->sta.support_p2p_ps)
-				ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
+			if (recalc) {
+				ieee80211_recalc_min_chandef(sta->sdata, -1);
+				if (!sta->sta.support_p2p_ps)
+					ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
+			}
 		}
 		break;
 	case IEEE80211_STA_ASSOC:
 		if (sta->sta_state == IEEE80211_STA_AUTH) {
 			set_bit(WLAN_STA_ASSOC, &sta->_flags);
 			sta->assoc_at = ktime_get_boottime_ns();
-			ieee80211_recalc_min_chandef(sta->sdata, -1);
-			if (!sta->sta.support_p2p_ps)
-				ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
+			if (recalc) {
+				ieee80211_recalc_min_chandef(sta->sdata, -1);
+				if (!sta->sta.support_p2p_ps)
+					ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
+			}
 		} else if (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
 			ieee80211_vif_dec_num_mcast(sta->sdata);
 			clear_bit(WLAN_STA_AUTHORIZED, &sta->_flags);
@@ -1373,7 +1378,13 @@ int sta_info_move_state(struct sta_info *sta,
 	return 0;
 }
 
-static void __sta_info_destroy_part2(struct sta_info *sta)
+int sta_info_move_state(struct sta_info *sta,
+			enum ieee80211_sta_state new_state)
+{
+	return _sta_info_move_state(sta, new_state, true);
+}
+
+static void __sta_info_destroy_part2(struct sta_info *sta, bool recalc)
 {
 	struct ieee80211_local *local = sta->local;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
@@ -1389,7 +1400,7 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 	lockdep_assert_held(&local->sta_mtx);
 
 	if (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
-		ret = sta_info_move_state(sta, IEEE80211_STA_ASSOC);
+		ret = _sta_info_move_state(sta, IEEE80211_STA_ASSOC, recalc);
 		WARN_ON_ONCE(ret);
 	}
 
@@ -1417,7 +1428,7 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 	local->sta_generation++;
 
 	while (sta->sta_state > IEEE80211_STA_NONE) {
-		ret = sta_info_move_state(sta, sta->sta_state - 1);
+		ret = _sta_info_move_state(sta, sta->sta_state - 1, recalc);
 		if (ret) {
 			WARN_ON_ONCE(1);
 			break;
@@ -1454,7 +1465,7 @@ int __must_check __sta_info_destroy(struct sta_info *sta)
 
 	synchronize_net();
 
-	__sta_info_destroy_part2(sta);
+	__sta_info_destroy_part2(sta, true);
 
 	return 0;
 }
@@ -1561,9 +1572,18 @@ int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans)
 	}
 
 	if (!list_empty(&free_list)) {
+		bool support_p2p_ps = true;
+
 		synchronize_net();
-		list_for_each_entry_safe(sta, tmp, &free_list, free_list)
-			__sta_info_destroy_part2(sta);
+		list_for_each_entry_safe(sta, tmp, &free_list, free_list) {
+			if (!sta->sta.support_p2p_ps)
+				support_p2p_ps = false;
+			__sta_info_destroy_part2(sta, false);
+		}
+
+		ieee80211_recalc_min_chandef(sdata, -1);
+		if (!support_p2p_ps)
+			ieee80211_recalc_p2p_go_ps_allowed(sdata);
 	}
 	mutex_unlock(&local->sta_mtx);
 
-- 
2.38.1

