Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B24F2DCB0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 14:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfE2MZx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 08:25:53 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54308 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726791AbfE2MZv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 08:25:51 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVxeO-0007wy-Jr; Wed, 29 May 2019 15:25:48 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 07/10] mac80211: call rate_control_send_low() internally
Date:   Wed, 29 May 2019 15:25:34 +0300
Message-Id: <20190529122537.8564-8-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529122537.8564-1-luca@coelho.fi>
References: <20190529122537.8564-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's no rate control algorithm that *doesn't* want to call
it internally, and calling it internally will let us modify
its behaviour in the future.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[removed the call from non-iwlwifi drivers]
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlegacy/3945-rs.c |  3 ---
 drivers/net/wireless/intel/iwlegacy/4965-rs.c |  4 ---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   | 26 +++++++------------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  4 ---
 drivers/net/wireless/realtek/rtlwifi/rc.c     |  3 ---
 include/net/mac80211.h                        | 23 ----------------
 net/mac80211/rate.c                           | 14 +++++-----
 net/mac80211/rc80211_minstrel.c               |  5 +---
 net/mac80211/rc80211_minstrel_ht.c            |  4 +--
 9 files changed, 19 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
index a697edd46e7f..922f09f7ea3e 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
@@ -646,9 +646,6 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
 		il_sta = NULL;
 	}
 
-	if (rate_control_send_low(sta, il_sta, txrc))
-		return;
-
 	rate_mask = sta->supp_rates[sband->band];
 
 	/* get user max rate if set */
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
index 54ff83829afb..946f352fd9a4 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
@@ -2224,10 +2224,6 @@ il4965_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
 		il_sta = NULL;
 	}
 
-	/* Send management frames and NO_ACK data using lowest rate. */
-	if (rate_control_send_low(sta, il_sta, txrc))
-		return;
-
 	if (!lq_sta)
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index ef4b9de256f7..5e6af876bcb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -1,6 +1,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
+ * Copyright (C) 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -2715,25 +2716,17 @@ static void rs_get_rate(void *priv_r, struct ieee80211_sta *sta, void *priv_sta,
 	IWL_DEBUG_RATE_LIMIT(priv, "rate scale calculate new rate for skb\n");
 
 	/* Get max rate if user set max rate */
-	if (lq_sta) {
-		lq_sta->max_rate_idx = fls(txrc->rate_idx_mask) - 1;
-		if ((sband->band == NL80211_BAND_5GHZ) &&
-		    (lq_sta->max_rate_idx != -1))
-			lq_sta->max_rate_idx += IWL_FIRST_OFDM_RATE;
-		if ((lq_sta->max_rate_idx < 0) ||
-		    (lq_sta->max_rate_idx >= IWL_RATE_COUNT))
-			lq_sta->max_rate_idx = -1;
-	}
+	lq_sta->max_rate_idx = fls(txrc->rate_idx_mask) - 1;
+	if (sband->band == NL80211_BAND_5GHZ && lq_sta->max_rate_idx != -1)
+		lq_sta->max_rate_idx += IWL_FIRST_OFDM_RATE;
+	if (lq_sta->max_rate_idx < 0 || lq_sta->max_rate_idx >= IWL_RATE_COUNT)
+		lq_sta->max_rate_idx = -1;
 
-	/* Treat uninitialized rate scaling data same as non-existing. */
-	if (lq_sta && !lq_sta->drv) {
+	if (!lq_sta->drv) {
 		IWL_DEBUG_RATE(priv, "Rate scaling not initialized yet.\n");
-		priv_sta = NULL;
-	}
-
-	/* Send management frames and NO_ACK data using lowest rate. */
-	if (rate_control_send_low(sta, priv_sta, txrc))
+		/* mac80211 already set up the data for using low rates */
 		return;
+	}
 
 	rate_idx  = lq_sta->last_txrate_idx;
 
@@ -2802,7 +2795,6 @@ void iwl_rs_rate_init(struct iwl_priv *priv, struct ieee80211_sta *sta, u8 sta_i
 	lq_sta = &sta_priv->lq_sta;
 	sband = hw->wiphy->bands[conf->chandef.chan->band];
 
-
 	lq_sta->lq.sta_id = sta_id;
 
 	for (j = 0; j < LQ_SIZE; j++)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index c182821ab22b..9107b1698b0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2960,10 +2960,6 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 		mvm_sta = NULL;
 	}
 
-	/* Send management frames and NO_ACK data using lowest rate. */
-	if (rate_control_send_low(sta, mvm_sta, txrc))
-		return;
-
 	if (!mvm_sta)
 		return;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rc.c b/drivers/net/wireless/realtek/rtlwifi/rc.c
index cf8e42a01015..0c7d74902d33 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rc.c
@@ -173,9 +173,6 @@ static void rtl_get_rate(void *ppriv, struct ieee80211_sta *sta,
 	u8 try_per_rate, i, rix;
 	bool not_data = !ieee80211_is_data(fc);
 
-	if (rate_control_send_low(sta, priv_sta, txrc))
-		return;
-
 	rix = _rtl_rc_get_highest_rix(rtlpriv, sta, skb, not_data);
 	try_per_rate = 1;
 	_rtl_rc_rate_set_series(rtlpriv, sta, &rates[0], txrc,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 72080d9d617e..9dc98d6d1b4d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5951,29 +5951,6 @@ static inline int rate_supported(struct ieee80211_sta *sta,
 	return (sta == NULL || sta->supp_rates[band] & BIT(index));
 }
 
-/**
- * rate_control_send_low - helper for drivers for management/no-ack frames
- *
- * Rate control algorithms that agree to use the lowest rate to
- * send management frames and NO_ACK data with the respective hw
- * retries should use this in the beginning of their mac80211 get_rate
- * callback. If true is returned the rate control can simply return.
- * If false is returned we guarantee that sta and sta and priv_sta is
- * not null.
- *
- * Rate control algorithms wishing to do more intelligent selection of
- * rate for multicast/broadcast frames may choose to not use this.
- *
- * @sta: &struct ieee80211_sta pointer to the target destination. Note
- * 	that this may be null.
- * @priv_sta: private rate control structure. This may be null.
- * @txrc: rate control information we sholud populate for mac80211.
- */
-bool rate_control_send_low(struct ieee80211_sta *sta,
-			   void *priv_sta,
-			   struct ieee80211_tx_rate_control *txrc);
-
-
 static inline s8
 rate_lowest_index(struct ieee80211_supported_band *sband,
 		  struct ieee80211_sta *sta)
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 76f303fda3ed..c78a259d81ed 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -3,6 +3,7 @@
  * Copyright 2005-2006, Devicescape Software, Inc.
  * Copyright (c) 2006 Jiri Benc <jbenc@suse.cz>
  * Copyright 2017	Intel Deutschland GmbH
+ * Copyright (C) 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -369,9 +370,8 @@ static void __rate_control_send_low(struct ieee80211_hw *hw,
 }
 
 
-bool rate_control_send_low(struct ieee80211_sta *pubsta,
-			   void *priv_sta,
-			   struct ieee80211_tx_rate_control *txrc)
+static bool rate_control_send_low(struct ieee80211_sta *pubsta,
+				  struct ieee80211_tx_rate_control *txrc)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(txrc->skb);
 	struct ieee80211_supported_band *sband = txrc->sband;
@@ -379,7 +379,7 @@ bool rate_control_send_low(struct ieee80211_sta *pubsta,
 	int mcast_rate;
 	bool use_basicrate = false;
 
-	if (!pubsta || !priv_sta || rc_no_data_or_no_ack_use_min(txrc)) {
+	if (!pubsta || rc_no_data_or_no_ack_use_min(txrc)) {
 		__rate_control_send_low(txrc->hw, sband, pubsta, info,
 					txrc->rate_idx_mask);
 
@@ -405,7 +405,6 @@ bool rate_control_send_low(struct ieee80211_sta *pubsta,
 	}
 	return false;
 }
-EXPORT_SYMBOL(rate_control_send_low);
 
 static bool rate_idx_match_legacy_mask(s8 *rate_idx, int n_bitrates, u32 mask)
 {
@@ -902,12 +901,15 @@ void rate_control_get_rate(struct ieee80211_sub_if_data *sdata,
 	if (ieee80211_hw_check(&sdata->local->hw, HAS_RATE_CONTROL))
 		return;
 
+	if (rate_control_send_low(ista, txrc))
+		return;
+
 	if (ista) {
 		spin_lock_bh(&sta->rate_ctrl_lock);
 		ref->ops->get_rate(ref->priv, ista, priv_sta, txrc);
 		spin_unlock_bh(&sta->rate_ctrl_lock);
 	} else {
-		ref->ops->get_rate(ref->priv, NULL, NULL, txrc);
+		rate_control_send_low(NULL, txrc);
 	}
 
 	if (ieee80211_hw_check(&sdata->local->hw, SUPPORTS_RC_TABLE))
diff --git a/net/mac80211/rc80211_minstrel.c b/net/mac80211/rc80211_minstrel.c
index a34e9c2ca626..9bb2e89daa9c 100644
--- a/net/mac80211/rc80211_minstrel.c
+++ b/net/mac80211/rc80211_minstrel.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2008 Felix Fietkau <nbd@openwrt.org>
+ * Copyright (C) 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -340,10 +341,6 @@ minstrel_get_rate(void *priv, struct ieee80211_sta *sta,
 	int delta;
 	int sampling_ratio;
 
-	/* management/no-ack frames do not use rate control */
-	if (rate_control_send_low(sta, priv_sta, txrc))
-		return;
-
 	/* check multi-rate-retry capabilities & adjust lookaround_rate */
 	mrr_capable = mp->has_mrr &&
 		      !txrc->rts &&
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 8b168724c5e7..63c648d2bdcf 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2010-2013 Felix Fietkau <nbd@openwrt.org>
+ * Copyright (C) 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -1098,9 +1099,6 @@ minstrel_ht_get_rate(void *priv, struct ieee80211_sta *sta, void *priv_sta,
 	struct minstrel_priv *mp = priv;
 	int sample_idx;
 
-	if (rate_control_send_low(sta, priv_sta, txrc))
-		return;
-
 	if (!msp->is_ht)
 		return mac80211_minstrel.get_rate(priv, sta, &msp->legacy, txrc);
 
-- 
2.20.1

