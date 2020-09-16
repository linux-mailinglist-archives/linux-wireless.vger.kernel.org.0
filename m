Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EE626CA46
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 21:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgIPTxi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 15:53:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16608 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbgIPTw7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 15:52:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600285977; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=tlX2D+ElAt+PqBGgnRz46uXpjuJEI/VCeQqiaRYdRY0=; b=i2Lw9oqCIb3kvTpaW1JWDQ1oLyObzFWq0/VFNjFNd7730mNSwJhp7lDZDCXxHOnsXe002d3O
 YMpFTo9id2lrPVE0DdiN2qNvYUrJQ7VgBnekkWaRUfvxj++FdK+LFIDKHNl9O8lmkgwiQnUK
 aYsapXTNlAulZuZt85ivjUBumjU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f62196f24954b1631aa47c1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 13:55:59
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F2FF7C433F1; Wed, 16 Sep 2020 13:55:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88296C433F0;
        Wed, 16 Sep 2020 13:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88296C433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] ath11k: debugfs: move some function declarations to correct header files
Date:   Wed, 16 Sep 2020 16:55:23 +0300
Message-Id: <1600264523-12939-4-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600264523-12939-1-git-send-email-kvalo@codeaurora.org>
References: <1600264523-12939-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some of the function declarations are for functions in debugfs_htt_stats.c and
debugfs_sta.c, move them to corresponding header files. As debugfs_sta.h didn't
exist create it.

Also in debugfs_htt_stats.h move dunction declarations to the end of the file.

No functional changes. Compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debugfs.h          | 28 +-------------
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    |  8 ++--
 .../net/wireless/ath/ath11k/debugfs_htt_stats.h    |  7 +++-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      | 23 +++++------
 drivers/net/wireless/ath/ath11k/debugfs_sta.h      | 44 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  7 ++--
 drivers/net/wireless/ath/ath11k/dp_tx.c            |  5 ++-
 drivers/net/wireless/ath/ath11k/mac.c              |  3 +-
 8 files changed, 75 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/debugfs_sta.h

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index 4b7867c5f26f..d1ed2e72e5d1 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -110,12 +110,9 @@ int ath11k_debugfs_pdev_create(struct ath11k_base *ab);
 void ath11k_debugfs_pdev_destroy(struct ath11k_base *ab);
 int ath11k_debugfs_register(struct ath11k *ar);
 void ath11k_debugfs_unregister(struct ath11k *ar);
-void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
-				      struct sk_buff *skb);
 void ath11k_debugfs_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb);
 
 void ath11k_debugfs_fw_stats_init(struct ath11k *ar);
-int ath11k_dbg_htt_stats_req(struct ath11k *ar);
 
 static inline bool ath11k_debugfs_is_pktlog_lite_mode_enabled(struct ath11k *ar)
 {
@@ -148,15 +145,6 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return ar->debug.rx_filter;
 }
 
-void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, struct dentry *dir);
-void
-ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
-				    struct ath11k_per_peer_tx_stats *peer_stats,
-				    u8 legacy_rate_idx);
-void ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
-					       struct sk_buff *msdu,
-					       struct hal_tx_status *ts);
 #else
 static inline int ath11k_debugfs_soc_create(struct ath11k_base *ab)
 {
@@ -209,7 +197,7 @@ static inline int ath11k_debugfs_is_extd_rx_stats_enabled(struct ath11k *ar)
 	return 0;
 }
 
-static inline int ath11k_dbg_htt_stats_req(struct ath11k *ar)
+static inline int ath11k_debugfs_htt_stats_req(struct ath11k *ar)
 {
 	return 0;
 }
@@ -234,20 +222,6 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return 0;
 }
 
-static inline void
-ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
-				    struct ath11k_per_peer_tx_stats *peer_stats,
-				    u8 legacy_rate_idx)
-{
-}
-
-static inline void
-ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
-					  struct sk_buff *msdu,
-					  struct hal_tx_status *ts)
-{
-}
-
 #endif /* CONFIG_MAC80211_DEBUGFS*/
 
 #endif /* _ATH11K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index 6f6e8ca014a1..9191ffa081c2 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -4253,8 +4253,8 @@ static int ath11k_dbg_htt_ext_stats_parse(struct ath11k_base *ab,
 	return 0;
 }
 
-void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
-				      struct sk_buff *skb)
+void ath11k_debugfs_htt_ext_stats_handler(struct ath11k_base *ab,
+					  struct sk_buff *skb)
 {
 	struct ath11k_htt_extd_stats_msg *msg;
 	struct debug_htt_stats_req *stats_req;
@@ -4402,7 +4402,7 @@ static int ath11k_prep_htt_stats_cfg_params(struct ath11k *ar, u8 type,
 	return 0;
 }
 
-int ath11k_dbg_htt_stats_req(struct ath11k *ar)
+int ath11k_debugfs_htt_stats_req(struct ath11k *ar)
 {
 	struct debug_htt_stats_req *stats_req = ar->debug.htt_stats.stats_req;
 	u8 type = stats_req->type;
@@ -4476,7 +4476,7 @@ static int ath11k_open_htt_stats(struct inode *inode, struct file *file)
 	ar->debug.htt_stats.stats_req = stats_req;
 	stats_req->type = type;
 
-	ret = ath11k_dbg_htt_stats_req(ar);
+	ret = ath11k_debugfs_htt_stats_req(ar);
 	if (ret < 0)
 		goto out;
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
index d2d01bfc5081..a36a4fed8800 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
@@ -1660,8 +1660,6 @@ struct htt_pdev_obss_pd_stats_tlv {
 	u32        num_obss_tx_ppdu_failure;
 };
 
-void ath11k_debugfs_htt_stats_init(struct ath11k *ar);
-
 struct htt_ring_backpressure_stats_tlv {
 	u32 pdev_id;
 	u32 current_head_idx;
@@ -1687,4 +1685,9 @@ struct htt_ring_backpressure_stats_tlv {
 	u32 backpressure_hist[5];
 };
 
+void ath11k_debugfs_htt_stats_init(struct ath11k *ar);
+void ath11k_debugfs_htt_ext_stats_handler(struct ath11k_base *ab,
+					  struct sk_buff *skb);
+int ath11k_debugfs_htt_stats_req(struct ath11k *ar);
+
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 14f2e904a89d..270c0edbb10f 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -5,16 +5,16 @@
 
 #include <linux/vmalloc.h>
 
+#include "debugfs_sta.h"
 #include "core.h"
 #include "peer.h"
 #include "debug.h"
 #include "dp_tx.h"
 #include "debugfs_htt_stats.h"
 
-void
-ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
-				    struct ath11k_per_peer_tx_stats *peer_stats,
-				    u8 legacy_rate_idx)
+void ath11k_debugfs_sta_add_tx_stats(struct ath11k_sta *arsta,
+				     struct ath11k_per_peer_tx_stats *peer_stats,
+				     u8 legacy_rate_idx)
 {
 	struct rate_info *txrate = &arsta->txrate;
 	struct ath11k_htt_tx_stats *tx_stats;
@@ -125,9 +125,9 @@ ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
 	tx_stats->tx_duration += peer_stats->duration;
 }
 
-void ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
-					       struct sk_buff *msdu,
-					       struct hal_tx_status *ts)
+void ath11k_debugfs_sta_update_txcompl(struct ath11k *ar,
+				       struct sk_buff *msdu,
+				       struct hal_tx_status *ts)
 {
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_per_peer_tx_stats *peer_stats = &ar->cached_stats;
@@ -200,7 +200,8 @@ void ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
 	arsta->txrate.nss = arsta->last_txrate.nss;
 	arsta->txrate.bw = ath11k_mac_bw_to_mac80211_bw(bw);
 
-	ath11k_accumulate_per_peer_tx_stats(arsta, peer_stats, rate_idx);
+	ath11k_debugfs_sta_add_tx_stats(arsta, peer_stats, rate_idx);
+
 err_out:
 	spin_unlock_bh(&ab->base_lock);
 	rcu_read_unlock();
@@ -428,7 +429,7 @@ ath11k_dbg_sta_open_htt_peer_stats(struct inode *inode, struct file *file)
 	ar->debug.htt_stats.stats_req = stats_req;
 	stats_req->type = ATH11K_DBG_HTT_EXT_STATS_PEER_INFO;
 	memcpy(stats_req->peer_addr, sta->addr, ETH_ALEN);
-	ret = ath11k_dbg_htt_stats_req(ar);
+	ret = ath11k_debugfs_htt_stats_req(ar);
 	mutex_unlock(&ar->conf_mutex);
 	if (ret < 0)
 		goto out;
@@ -820,8 +821,8 @@ static const struct file_operations fops_htt_peer_stats_reset = {
 	.llseek = default_llseek,
 };
 
-void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, struct dentry *dir)
+void ath11k_debugfs_sta_op_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta, struct dentry *dir)
 {
 	struct ath11k *ar = hw->priv;
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.h b/drivers/net/wireless/ath/ath11k/debugfs_sta.h
new file mode 100644
index 000000000000..18dc65d9edcf
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _ATH11K_DEBUGFS_STA_H_
+#define _ATH11K_DEBUGFS_STA_H_
+
+#include <net/mac80211.h>
+
+#include "core.h"
+#include "hal_tx.h"
+
+#ifdef CONFIG_ATH11K_DEBUGFS
+
+void ath11k_debugfs_sta_op_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta, struct dentry *dir);
+void ath11k_debugfs_sta_add_tx_stats(struct ath11k_sta *arsta,
+				     struct ath11k_per_peer_tx_stats *peer_stats,
+				     u8 legacy_rate_idx);
+void ath11k_debugfs_sta_update_txcompl(struct ath11k *ar,
+				       struct sk_buff *msdu,
+				       struct hal_tx_status *ts);
+
+#else /* CONFIG_ATH11K_DEBUGFS */
+
+#define ath11k_debugfs_sta_op_add NULL
+
+static inline void
+ath11k_debugfs_sta_add_tx_stats(struct ath11k_sta *arsta,
+				struct ath11k_per_peer_tx_stats *peer_stats,
+				u8 legacy_rate_idx)
+{
+}
+
+static inline void ath11k_debugfs_sta_update_txcompl(struct ath11k *ar,
+						     struct sk_buff *msdu,
+						     struct hal_tx_status *ts)
+{
+}
+
+#endif /* CONFIG_ATH11K_DEBUGFS */
+
+#endif /* _ATH11K_DEBUGFS_STA_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 2c9251bde78b..345eaa4f20f3 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -9,6 +9,8 @@
 #include <crypto/hash.h>
 #include "core.h"
 #include "debug.h"
+#include "debugfs_htt_stats.h"
+#include "debugfs_sta.h"
 #include "hal_desc.h"
 #include "hw.h"
 #include "dp_rx.h"
@@ -1434,8 +1436,7 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 			HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
 
 		if (ath11k_debugfs_is_extd_tx_stats_enabled(ar))
-			ath11k_accumulate_per_peer_tx_stats(arsta,
-							    peer_stats, rate_idx);
+			ath11k_debugfs_sta_add_tx_stats(arsta, peer_stats, rate_idx);
 	}
 
 	spin_unlock_bh(&ab->base_lock);
@@ -1658,7 +1659,7 @@ void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
 		ath11k_htt_pull_ppdu_stats(ab, skb);
 		break;
 	case HTT_T2H_MSG_TYPE_EXT_STATS_CONF:
-		ath11k_dbg_htt_ext_stats_handler(ab, skb);
+		ath11k_debugfs_htt_ext_stats_handler(ab, skb);
 		break;
 	case HTT_T2H_MSG_TYPE_PKTLOG:
 		ath11k_htt_pktlog(ab, skb);
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 7975cc036ba4..8625465500de 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -6,6 +6,7 @@
 #include "core.h"
 #include "dp_tx.h"
 #include "debug.h"
+#include "debugfs_sta.h"
 #include "hw.h"
 #include "peer.h"
 
@@ -465,12 +466,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 				   ar->cached_ppdu_id == ar->last_ppdu_id) {
 				ar->cached_ppdu_id = ar->last_ppdu_id;
 				ar->cached_stats.is_ampdu = true;
-				ath11k_update_per_peer_stats_from_txcompl(ar, msdu, ts);
+				ath11k_debugfs_sta_update_txcompl(ar, msdu, ts);
 				memset(&ar->cached_stats, 0,
 				       sizeof(struct ath11k_per_peer_tx_stats));
 			} else {
 				ar->cached_stats.is_ampdu = false;
-				ath11k_update_per_peer_stats_from_txcompl(ar, msdu, ts);
+				ath11k_debugfs_sta_update_txcompl(ar, msdu, ts);
 				memset(&ar->cached_stats, 0,
 				       sizeof(struct ath11k_per_peer_tx_stats));
 			}
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 69621160cb62..86a1b984859f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -14,6 +14,7 @@
 #include "dp_rx.h"
 #include "testmode.h"
 #include "peer.h"
+#include "debugfs_sta.h"
 
 #define CHAN2G(_channel, _freq, _flags) { \
 	.band                   = NL80211_BAND_2GHZ, \
@@ -5867,7 +5868,7 @@ static const struct ieee80211_ops ath11k_ops = {
 	.sta_statistics			= ath11k_mac_op_sta_statistics,
 	CFG80211_TESTMODE_CMD(ath11k_tm_cmd)
 #ifdef CONFIG_ATH11K_DEBUGFS
-	.sta_add_debugfs		= ath11k_sta_add_debugfs,
+	.sta_add_debugfs		= ath11k_debugfs_sta_op_add,
 #endif
 };
 
-- 
2.7.4

