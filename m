Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5660F4A6D45
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245262AbiBBIuL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:50:11 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37950 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245216AbiBBIuL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:50:11 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBL6-0004v8-Se;
        Wed, 02 Feb 2022 10:50:09 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:47 +0200
Message-Id: <iwlwifi.20220202104617.0ff363d4fa56.I45792c0187034a6d0e1c99a7db741996ef7caba3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202084947.370289-1-luca@coelho.fi>
References: <20220202084947.370289-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 14/14] mac80211: fix struct ieee80211_tx_info size
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The size of the status_driver_data field was not adjusted when
the is_valid_ack_signal field was added.
Since the size of struct ieee80211_tx_info is limited, replace
the is_valid_ack_signal field with a flags field, and adjust the
struct size accordingly.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/ath/ath10k/txrx.c  |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c   |  2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c |  5 +++--
 include/net/mac80211.h                  | 19 +++++++++++++++----
 net/mac80211/status.c                   | 12 ++++++++----
 5 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 6f8b64218894..10123974c3da 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -125,7 +125,7 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 	    tx_done->ack_rssi != ATH10K_INVALID_RSSI) {
 		info->status.ack_signal = ATH10K_DEFAULT_NOISE_FLOOR +
 						tx_done->ack_rssi;
-		info->status.is_valid_ack_signal = true;
+		info->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
 	}
 
 	ieee80211_tx_status(htt->ar->hw, msdu);
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 62c453a21e49..2b78ed89e1b6 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2427,7 +2427,7 @@ wmi_process_mgmt_tx_comp(struct ath10k *ar, struct mgmt_tx_compl_params *param)
 		info->flags |= IEEE80211_TX_STAT_ACK;
 		info->status.ack_signal = ATH10K_DEFAULT_NOISE_FLOOR +
 					  param->ack_rssi;
-		info->status.is_valid_ack_signal = true;
+		info->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
 	}
 
 	ieee80211_tx_status_irqsafe(ar->hw, msdu);
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 91d6244b6543..6d19547d78be 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -351,7 +351,8 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 			info->flags |= IEEE80211_TX_STAT_ACK;
 			info->status.ack_signal = ATH11K_DEFAULT_NOISE_FLOOR +
 						  ts->ack_rssi;
-			info->status.is_valid_ack_signal = true;
+			info->status.flags |=
+				IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
 		} else {
 			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
 		}
@@ -552,7 +553,7 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 		info->flags |= IEEE80211_TX_STAT_ACK;
 		info->status.ack_signal = ATH11K_DEFAULT_NOISE_FLOOR +
 					  ts->ack_rssi;
-		info->status.is_valid_ack_signal = true;
+		info->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
 	}
 
 	if (ts->status == HAL_WBM_TQM_REL_REASON_CMD_REMOVE_TX &&
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c50221d7e82c..bd6912d0292b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7,7 +7,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2021 Intel Corporation
+ * Copyright (C) 2018 - 2022 Intel Corporation
  */
 
 #ifndef MAC80211_H
@@ -883,6 +883,17 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_DONT_REORDER		= BIT(8),
 };
 
+/**
+ * enum mac80211_tx_status_flags - flags to describe transmit status
+ *
+ * @IEEE80211_TX_STATUS_ACK_SIGNAL_VALID: ACK signal is valid
+ *
+ * These flags are used in tx_info->status.flags.
+ */
+enum mac80211_tx_status_flags {
+	IEEE80211_TX_STATUS_ACK_SIGNAL_VALID = BIT(0),
+};
+
 /*
  * This definition is used as a mask to clear all temporary flags, which are
  * set by the tx handlers for each transmission attempt by the mac80211 stack.
@@ -1046,7 +1057,7 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_rate *rate)
  * @status.antenna: (legacy, kept only for iwlegacy)
  * @status.tx_time: airtime consumed for transmission; note this is only
  *	used for WMM AC, not for airtime fairness
- * @status.is_valid_ack_signal: ACK signal is valid
+ * @status.flags: status flags, see &enum mac80211_tx_status_flags
  * @status.status_driver_data: driver use area
  * @ack: union part for pure ACK data
  * @ack.cookie: cookie for the ACK
@@ -1099,8 +1110,8 @@ struct ieee80211_tx_info {
 			u8 ampdu_len;
 			u8 antenna;
 			u16 tx_time;
-			bool is_valid_ack_signal;
-			void *status_driver_data[19 / sizeof(void *)];
+			u8 flags;
+			void *status_driver_data[18 / sizeof(void *)];
 		} status;
 		struct {
 			struct ieee80211_tx_rate driver_rates[
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 22cb8f01731d..e81e8a5bb774 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2008-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2021  Intel Corporation
+ * Copyright 2021-2022  Intel Corporation
  */
 
 #include <linux/export.h>
@@ -629,6 +629,8 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 		u64 cookie = IEEE80211_SKB_CB(skb)->ack.cookie;
 		struct ieee80211_sub_if_data *sdata;
 		struct ieee80211_hdr *hdr = (void *)skb->data;
+		bool is_valid_ack_signal =
+			!!(info->status.flags & IEEE80211_TX_STATUS_ACK_SIGNAL_VALID);
 
 		rcu_read_lock();
 		sdata = ieee80211_sdata_from_skb(local, skb);
@@ -645,7 +647,7 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 				cfg80211_probe_status(sdata->dev, hdr->addr1,
 						      cookie, acked,
 						      info->status.ack_signal,
-						      info->status.is_valid_ack_signal,
+						      is_valid_ack_signal,
 						      GFP_ATOMIC);
 			else if (ieee80211_is_mgmt(hdr->frame_control))
 				cfg80211_mgmt_tx_status(&sdata->wdev, cookie,
@@ -1102,7 +1104,7 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	struct ieee80211_supported_band *sband;
 	struct sta_info *sta = NULL;
 	int rates_idx, retry_count;
-	bool acked, noack_success;
+	bool acked, noack_success, ack_signal_valid;
 	u16 tx_time_est;
 
 	if (pubsta) {
@@ -1133,6 +1135,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 
 	acked = !!(info->flags & IEEE80211_TX_STAT_ACK);
 	noack_success = !!(info->flags & IEEE80211_TX_STAT_NOACK_TRANSMITTED);
+	ack_signal_valid =
+		!!(info->status.flags & IEEE80211_TX_STATUS_ACK_SIGNAL_VALID);
 
 	if (pubsta) {
 		struct ieee80211_sub_if_data *sdata = sta->sdata;
@@ -1161,7 +1165,7 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 				    unlikely(sdata->u.mgd.probe_send_count > 0))
 					sdata->u.mgd.probe_send_count = 0;
 
-				if (info->status.is_valid_ack_signal) {
+				if (ack_signal_valid) {
 					sta->status_stats.last_ack_signal =
 							 (s8)info->status.ack_signal;
 					sta->status_stats.ack_signal_filled = true;
-- 
2.34.1

