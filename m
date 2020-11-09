Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595CC2AB429
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgKIJ55 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgKIJ54 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:57:56 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EB5C0613D4
        for <linux-wireless@vger.kernel.org>; Mon,  9 Nov 2020 01:57:55 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kc3vt-004EGg-Fi; Mon, 09 Nov 2020 10:57:53 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/8] ath9k: remove WDS code
Date:   Mon,  9 Nov 2020 10:57:41 +0100
Message-Id: <20201109105103.e1d48ee20b0a.I89f8af0d50a02ce16a922fa790d6c1908f31a496@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109095747.113720-1-johannes@sipsolutions.net>
References: <20201109095747.113720-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The ability to reach this code was hidden behind
CONFIG_WIRELESS_WDS, which was just removed. Clean
up the driver accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath9k/ath9k.h |  1 -
 drivers/net/wireless/ath/ath9k/init.c  | 19 -------------------
 drivers/net/wireless/ath/ath9k/main.c  |  5 -----
 3 files changed, 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index e06b74a54a69..13b4f5f50f8a 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -661,7 +661,6 @@ struct ath9k_vif_iter_data {
 	int naps;      /* number of AP vifs */
 	int nmeshes;   /* number of mesh vifs */
 	int nstations; /* number of station vifs */
-	int nwds;      /* number of WDS vifs */
 	int nadhocs;   /* number of adhoc vifs */
 	int nocbs;     /* number of OCB vifs */
 	int nbcnvifs;  /* number of beaconing vifs */
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 690fe3a1b516..42a208787f5a 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -832,12 +832,6 @@ static const struct ieee80211_iface_limit if_limits[] = {
 				 BIT(NL80211_IFTYPE_P2P_GO) },
 };
 
-#ifdef CONFIG_WIRELESS_WDS
-static const struct ieee80211_iface_limit wds_limits[] = {
-	{ .max = 2048,	.types = BIT(NL80211_IFTYPE_WDS) },
-};
-#endif
-
 #ifdef CONFIG_ATH9K_CHANNEL_CONTEXT
 
 static const struct ieee80211_iface_limit if_limits_multi[] = {
@@ -874,15 +868,6 @@ static const struct ieee80211_iface_combination if_comb[] = {
 					BIT(NL80211_CHAN_WIDTH_40),
 #endif
 	},
-#ifdef CONFIG_WIRELESS_WDS
-	{
-		.limits = wds_limits,
-		.n_limits = ARRAY_SIZE(wds_limits),
-		.max_interfaces = 2048,
-		.num_different_channels = 1,
-		.beacon_int_infra_match = true,
-	},
-#endif
 };
 
 #ifdef CONFIG_ATH9K_CHANNEL_CONTEXT
@@ -897,7 +882,6 @@ static void ath9k_set_mcc_capab(struct ath_softc *sc, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, QUEUE_CONTROL);
 	hw->queues = ATH9K_NUM_TX_QUEUES;
 	hw->offchannel_tx_hw_queue = hw->queues - 1;
-	hw->wiphy->interface_modes &= ~ BIT(NL80211_IFTYPE_WDS);
 	hw->wiphy->iface_combinations = if_comb_multi;
 	hw->wiphy->n_iface_combinations = ARRAY_SIZE(if_comb_multi);
 	hw->wiphy->max_scan_ssids = 255;
@@ -953,9 +937,6 @@ static void ath9k_set_hw_capab(struct ath_softc *sc, struct ieee80211_hw *hw)
 			BIT(NL80211_IFTYPE_STATION) |
 			BIT(NL80211_IFTYPE_ADHOC) |
 			BIT(NL80211_IFTYPE_MESH_POINT) |
-#ifdef CONFIG_WIRELESS_WDS
-			BIT(NL80211_IFTYPE_WDS) |
-#endif
 			BIT(NL80211_IFTYPE_OCB);
 
 		if (ath9k_is_chanctx_enabled())
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 8dbf68b94228..caebe3fd6869 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -973,9 +973,6 @@ static void ath9k_vif_iter(struct ath9k_vif_iter_data *iter_data,
 		if (vif->bss_conf.enable_beacon)
 			ath9k_vif_iter_set_beacon(iter_data, vif);
 		break;
-	case NL80211_IFTYPE_WDS:
-		iter_data->nwds++;
-		break;
 	default:
 		break;
 	}
@@ -1136,8 +1133,6 @@ void ath9k_calculate_summary_state(struct ath_softc *sc,
 			ah->opmode = NL80211_IFTYPE_MESH_POINT;
 		else if (iter_data.nocbs)
 			ah->opmode = NL80211_IFTYPE_OCB;
-		else if (iter_data.nwds)
-			ah->opmode = NL80211_IFTYPE_AP;
 		else if (iter_data.nadhocs)
 			ah->opmode = NL80211_IFTYPE_ADHOC;
 		else
-- 
2.26.2

