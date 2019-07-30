Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D47F7AE1C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 18:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfG3QhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 12:37:15 -0400
Received: from nbd.name ([46.4.11.11]:51046 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730380AbfG3QhO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 12:37:14 -0400
Received: from pd95fd7d7.dip0.t-ipconnect.de ([217.95.215.215] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hsV7f-0002JK-Gz; Tue, 30 Jul 2019 18:37:11 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH V3 2/2] mac80211: allow setting spatial reuse parameters from bss_conf
Date:   Tue, 30 Jul 2019 18:37:01 +0200
Message-Id: <20190730163701.18836-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730163701.18836-1-john@phrozen.org>
References: <20190730163701.18836-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Store the OBSS PD parameters inside bss_conf when bringing up an AP and/or
when a station connects to an AP. This allows the driver to configure the
HW accordingly.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h     |  4 ++++
 net/mac80211/cfg.c         |  5 ++++-
 net/mac80211/he.c          | 24 ++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/mlme.c        |  1 +
 5 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4370c58465db..ce77eac27e13 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -315,6 +315,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_FTM_RESPONDER: fime timing reasurement request responder
  *	functionality changed for this BSS (AP mode).
  * @BSS_CHANGED_TWT: TWT status changed
+ * @BSS_CHANGED_HE_OBSS_PD: OBSS Packet Detection status changed.
  *
  */
 enum ieee80211_bss_change {
@@ -346,6 +347,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_MCAST_RATE		= 1<<25,
 	BSS_CHANGED_FTM_RESPONDER	= 1<<26,
 	BSS_CHANGED_TWT			= 1<<27,
+	BSS_CHANGED_HE_OBSS_PD		= 1<<28,
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -601,6 +603,7 @@ struct ieee80211_ftm_responder_params {
  * @profile_periodicity: the least number of beacon frames need to be received
  *	in order to discover all the nontransmitted BSSIDs in the set.
  * @he_operation: HE operation information of the AP we are connected to
+ * @he_obss_pd: OBSS Packet Detection parameters.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -663,6 +666,7 @@ struct ieee80211_bss_conf {
 	bool ema_ap;
 	u8 profile_periodicity;
 	struct ieee80211_he_operation he_operation;
+	struct ieee80211_he_obss_pd he_obss_pd;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5be377b048c7..9f7ab8eb7199 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -980,7 +980,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		      BSS_CHANGED_SSID |
 		      BSS_CHANGED_P2P_PS |
 		      BSS_CHANGED_TXPOWER |
-		      BSS_CHANGED_TWT;
+		      BSS_CHANGED_TWT |
+		      BSS_CHANGED_HE_OBSS_PD;
 	int err;
 	int prev_beacon_int;
 
@@ -1051,6 +1052,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.enable_beacon = true;
 	sdata->vif.bss_conf.allow_p2p_go_ps = sdata->vif.p2p;
 	sdata->vif.bss_conf.twt_responder = params->twt_responder;
+	memcpy(&sdata->vif.bss_conf.he_obss_pd, &params->he_obss_pd,
+	       sizeof(struct ieee80211_he_obss_pd));
 
 	sdata->vif.bss_conf.ssid_len = params->ssid_len;
 	if (params->ssid_len)
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index f910f730ad0d..a02abfc424aa 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -65,3 +65,27 @@ ieee80211_he_op_ie_to_bss_conf(struct ieee80211_vif *vif,
 
 	vif->bss_conf.he_operation = *he_op_ie_elem;
 }
+
+void
+ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
+				const struct ieee80211_he_spr *he_spr_ie_elem)
+{
+	struct ieee80211_he_obss_pd *he_obss_pd =
+					&vif->bss_conf.he_obss_pd;
+	const u8 *data = he_spr_ie_elem->optional;
+
+	memset(he_obss_pd, 0, sizeof(*he_obss_pd));
+
+	if (!he_spr_ie_elem)
+		return;
+
+	if (he_spr_ie_elem->he_sr_control &
+	    IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT)
+		data++;
+	if (he_spr_ie_elem->he_sr_control &
+	    IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT) {
+		he_obss_pd->max_offset = *data++;
+		he_obss_pd->min_offset = *data++;
+		he_obss_pd->enable = true;
+	}
+}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index eaa0423eaaf9..ff7995642e86 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1878,6 +1878,9 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_supported_band *sband,
 				  const u8 *he_cap_ie, u8 he_cap_len,
 				  struct sta_info *sta);
+void
+ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
+				const struct ieee80211_he_spr *he_spr_ie_elem);
 
 void
 ieee80211_he_op_ie_to_bss_conf(struct ieee80211_vif *vif,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2b8a7428973d..225633d9e2d4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3382,6 +3382,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			bss_conf->uora_ocw_range = elems.uora_element[0];
 
 		ieee80211_he_op_ie_to_bss_conf(&sdata->vif, elems.he_operation);
+		ieee80211_he_spr_ie_to_bss_conf(&sdata->vif, elems.he_spr);
 		/* TODO: OPEN: what happens if BSS color disable is set? */
 	}
 
-- 
2.20.1

