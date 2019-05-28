Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E62C5B7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 13:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfE1LuI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 07:50:08 -0400
Received: from nbd.name ([46.4.11.11]:55670 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfE1LuH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 07:50:07 -0400
Received: from p5dcfb1b7.dip0.t-ipconnect.de ([93.207.177.183] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hVacG-0005pk-EK; Tue, 28 May 2019 13:50:04 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH V2 1/6] mac80211: dynamically enable the TWT requester support on STA interfaces
Date:   Tue, 28 May 2019 13:49:47 +0200
Message-Id: <20190528114952.838-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528114952.838-1-john@phrozen.org>
References: <20190528114952.838-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Turn TWT for STA interfaces when they associate and/or receive a
beacon where the twt_responder bit has changed.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h |  2 ++
 net/mac80211/mlme.c    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index bebb3ef4efa1..b41a9351434f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -317,6 +317,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_MCAST_RATE: Multicast Rate setting changed for this interface
  * @BSS_CHANGED_FTM_RESPONDER: fime timing reasurement request responder
  *	functionality changed for this BSS (AP mode).
+ * @BSS_CHANGED_TWT: TWT status changed
  *
  */
 enum ieee80211_bss_change {
@@ -347,6 +348,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_KEEP_ALIVE		= 1<<24,
 	BSS_CHANGED_MCAST_RATE		= 1<<25,
 	BSS_CHANGED_FTM_RESPONDER	= 1<<26,
+	BSS_CHANGED_TWT			= 1<<27,
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0684d1250d8a..32309f13fcb1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3151,6 +3151,19 @@ static bool ieee80211_twt_req_supported(const struct sta_info *sta,
 		IEEE80211_HE_MAC_CAP0_TWT_RES;
 }
 
+static int ieee80211_recalc_twt_req(struct ieee80211_sub_if_data *sdata,
+				    struct sta_info *sta,
+				    struct ieee802_11_elems *elems)
+{
+	bool twt = ieee80211_twt_req_supported(sta, elems);
+
+	if (sdata->vif.bss_conf.twt_requester != twt) {
+		sdata->vif.bss_conf.twt_requester = twt;
+		return BSS_CHANGED_TWT;
+	}
+	return 0;
+}
+
 static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				    struct cfg80211_bss *cbss,
 				    struct ieee80211_mgmt *mgmt, size_t len)
@@ -3333,8 +3346,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 						  sta);
 
 		bss_conf->he_support = sta->sta.he_cap.has_he;
-		bss_conf->twt_requester =
-			ieee80211_twt_req_supported(sta, &elems);
+		changed |= ieee80211_recalc_twt_req(sdata, sta, &elems);
 	} else {
 		bss_conf->he_support = false;
 		bss_conf->twt_requester = false;
@@ -3995,6 +4007,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	mutex_lock(&local->sta_mtx);
 	sta = sta_info_get(sdata, bssid);
 
+	changed |= ieee80211_recalc_twt_req(sdata, sta, &elems);
+
 	if (ieee80211_config_bw(sdata, sta,
 				elems.ht_cap_elem, elems.ht_operation,
 				elems.vht_operation, elems.he_operation,
-- 
2.20.1

