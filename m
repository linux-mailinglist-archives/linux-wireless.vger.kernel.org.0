Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E93E122E6D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 15:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfLQOTe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 09:19:34 -0500
Received: from nbd.name ([46.4.11.11]:41746 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728923AbfLQOTd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 09:19:33 -0500
Received: from pd95fd66b.dip0.t-ipconnect.de ([217.95.214.107] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihDhC-0001fe-ID; Tue, 17 Dec 2019 15:19:30 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V3 2/4] mac80211: add handling for BSS color
Date:   Tue, 17 Dec 2019 15:19:19 +0100
Message-Id: <20191217141921.8114-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191217141921.8114-1-john@phrozen.org>
References: <20191217141921.8114-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is now possible to propagate BSS color settings into the subsystem. Lets
make mac80211 also handle them so that we can send them further down the
stack into the drivers. We drop the old bss_color field and change iwlwifi
to use the new he_bss_color struct.

Signed-off-by: John Crispin <john@phrozen.org>
---
Changes in V3
* fold parts of the first patch into this one

 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 include/net/cfg80211.h                            | 13 +++++++++++++
 include/net/mac80211.h                            |  6 ++++--
 net/mac80211/cfg.c                                |  5 ++++-
 net/mac80211/mlme.c                               |  9 ++++++++-
 5 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b74bd58f3f45..f0bf42f91af1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2225,7 +2225,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	struct iwl_he_sta_context_cmd sta_ctxt_cmd = {
 		.sta_id = sta_id,
 		.tid_limit = IWL_MAX_TID_COUNT,
-		.bss_color = vif->bss_conf.bss_color,
+		.bss_color = vif->bss_conf.he_bss_color.color,
 		.htc_trig_based_pkt_ext = vif->bss_conf.htc_trig_based_pkt_ext,
 		.frame_time_rts_th =
 			cpu_to_le16(vif->bss_conf.frame_time_rts_th),
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fffae8ecef5d..fed307d9a4fe 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -272,6 +272,19 @@ struct cfg80211_he_bss_color {
 	bool partial;
 };
 
+/**
+ * struct ieee80211_he_bss_color - AP settings for BSS coloring
+ *
+ * @color: the current color.
+ * @disabled: is the feature disabled.
+ * @partial: define the AID equation.
+ */
+struct ieee80211_he_bss_color {
+	u8 color;
+	bool disabled;
+	bool partial;
+};
+
 /**
  * struct ieee80211_sta_ht_cap - STA's HT capabilities
  *
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 6781d4637557..bb53993a9c7e 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -316,6 +316,7 @@ struct ieee80211_vif_chanctx_switch {
  *	functionality changed for this BSS (AP mode).
  * @BSS_CHANGED_TWT: TWT status changed
  * @BSS_CHANGED_HE_OBSS_PD: OBSS Packet Detection status changed.
+ * @BSS_CHANGED_HE_BSS_COLOR: BSS Color has changed
  *
  */
 enum ieee80211_bss_change {
@@ -348,6 +349,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_FTM_RESPONDER	= 1<<26,
 	BSS_CHANGED_TWT			= 1<<27,
 	BSS_CHANGED_HE_OBSS_PD		= 1<<28,
+	BSS_CHANGED_HE_BSS_COLOR	= 1<<29,
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -494,7 +496,6 @@ struct ieee80211_ftm_responder_params {
  * This structure keeps information about a BSS (and an association
  * to that BSS) that can change during the lifetime of the BSS.
  *
- * @bss_color: 6-bit value to mark inter-BSS frame, if BSS supports HE
  * @htc_trig_based_pkt_ext: default PE in 4us units, if BSS supports HE
  * @multi_sta_back_32bit: supports BA bitmap of 32-bits in Multi-STA BACK
  * @uora_exists: is the UORA element advertised by AP
@@ -604,10 +605,10 @@ struct ieee80211_ftm_responder_params {
  *	in order to discover all the nontransmitted BSSIDs in the set.
  * @he_operation: HE operation information of the AP we are connected to
  * @he_obss_pd: OBSS Packet Detection parameters.
+ * @he_bss_color: BSS coloring settings, if BSS supports HE
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
-	u8 bss_color;
 	u8 htc_trig_based_pkt_ext;
 	bool multi_sta_back_32bit;
 	bool uora_exists;
@@ -667,6 +668,7 @@ struct ieee80211_bss_conf {
 	u8 profile_periodicity;
 	struct ieee80211_he_operation he_operation;
 	struct ieee80211_he_obss_pd he_obss_pd;
+	struct cfg80211_he_bss_color he_bss_color;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ed56b0c6fe19..e109b47c4219 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -981,7 +981,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		      BSS_CHANGED_P2P_PS |
 		      BSS_CHANGED_TXPOWER |
 		      BSS_CHANGED_TWT |
-		      BSS_CHANGED_HE_OBSS_PD;
+		      BSS_CHANGED_HE_OBSS_PD |
+		      BSS_CHANGED_HE_BSS_COLOR;
 	int err;
 	int prev_beacon_int;
 
@@ -1054,6 +1055,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.twt_responder = params->twt_responder;
 	memcpy(&sdata->vif.bss_conf.he_obss_pd, &params->he_obss_pd,
 	       sizeof(struct ieee80211_he_obss_pd));
+	memcpy(&sdata->vif.bss_conf.he_bss_color, &params->he_bss_color,
+	       sizeof(struct ieee80211_he_bss_color));
 
 	sdata->vif.bss_conf.ssid_len = params->ssid_len;
 	if (params->ssid_len)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 641876982ab9..bc602d460b73 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3371,9 +3371,16 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (bss_conf->he_support) {
-		bss_conf->bss_color =
+		bss_conf->he_bss_color.color =
 			le32_get_bits(elems.he_operation->he_oper_params,
 				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);
+		bss_conf->he_bss_color.partial =
+			le32_get_bits(elems.he_operation->he_oper_params,
+				      IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR);
+		bss_conf->he_bss_color.disabled =
+			le32_get_bits(elems.he_operation->he_oper_params,
+				      IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED);
+		changed |= BSS_CHANGED_HE_BSS_COLOR;
 
 		bss_conf->htc_trig_based_pkt_ext =
 			le32_get_bits(elems.he_operation->he_oper_params,
-- 
2.20.1

