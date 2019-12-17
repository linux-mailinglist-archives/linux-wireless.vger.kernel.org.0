Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F143B12371E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 21:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfLQUTU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 15:19:20 -0500
Received: from nbd.name ([46.4.11.11]:37054 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfLQUTU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 15:19:20 -0500
Received: from pd95fd66b.dip0.t-ipconnect.de ([217.95.214.107] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihJJL-0000ls-CL; Tue, 17 Dec 2019 21:19:15 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [RESEND 2/3] ath11k: add HE rate accounting to driver
Date:   Tue, 17 Dec 2019 21:19:08 +0100
Message-Id: <20191217201909.27420-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191217201909.27420-1-john@phrozen.org>
References: <20191217201909.27420-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Parse and store the out-of-band rates reported by the FW.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/core.h        |  2 +
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |  7 +++
 drivers/net/wireless/ath/ath11k/dp.h          |  9 ++++
 drivers/net/wireless/ath/ath11k/dp_rx.c       | 48 +++++++++++++++++--
 drivers/net/wireless/ath/ath11k/dp_tx.c       |  1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c      | 13 +++--
 drivers/net/wireless/ath/ath11k/hal_rx.h      | 30 ++++++++++++
 drivers/net/wireless/ath/ath11k/rx_desc.h     |  8 ++++
 8 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 2c5eed29333c..76999b30b02f 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -258,6 +258,8 @@ struct ath11k_rx_peer_stats {
 	u64 pream_cnt[HAL_RX_PREAMBLE_MAX];
 	u64 reception_type[HAL_RX_RECEPTION_TYPE_MAX];
 	u64 rx_duration;
+	u64 dcm_count;
+	u64 ru_alloc_cnt[HAL_RX_RU_ALLOC_TYPE_MAX];
 };
 
 #define ATH11K_HE_MCS_NUM       12
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 1d562133ae1e..437f73b95bba 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -406,6 +406,13 @@ static ssize_t ath11k_dbg_sta_dump_rx_stats(struct file *file,
 		len += scnprintf(buf + len, size - len, "%llu ", rx_stats->nss_count[i]);
 	len += scnprintf(buf + len, size - len, "\nRX Duration:%llu ",
 			 rx_stats->rx_duration);
+	len += scnprintf(buf + len, size - len,
+			 "\nDCM: %llu\nRU: 26 %llu 52: %llu 106: %llu 242: %llu 484: %llu 996: %llu\n",
+			 rx_stats->dcm_count, rx_stats->ru_alloc_cnt[0],
+			 rx_stats->ru_alloc_cnt[1], rx_stats->ru_alloc_cnt[2],
+			 rx_stats->ru_alloc_cnt[3], rx_stats->ru_alloc_cnt[4],
+			 rx_stats->ru_alloc_cnt[5]);
+
 	len += scnprintf(buf + len, size - len, "\n");
 
 	spin_unlock_bh(&ar->ab->base_lock);
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 12cea54cdfad..f504077086da 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -1086,6 +1086,13 @@ struct htt_ppdu_stats_common {
 	u16 bw_mhz;
 } __packed;
 
+enum htt_ppdu_stats_gi {
+	HTT_PPDU_STATS_SGI_0_8_US,
+	HTT_PPDU_STATS_SGI_0_4_US,
+	HTT_PPDU_STATS_SGI_1_6_US,
+	HTT_PPDU_STATS_SGI_3_2_US,
+};
+
 #define HTT_PPDU_STATS_USER_RATE_INFO0_USER_POS_M	GENMASK(3, 0)
 #define HTT_PPDU_STATS_USER_RATE_INFO0_MU_GROUP_ID_M	GENMASK(11, 4)
 
@@ -1114,6 +1121,8 @@ struct htt_ppdu_stats_common {
 		FIELD_GET(HTT_PPDU_STATS_USER_RATE_FLAGS_MCS_M, _val)
 #define HTT_USR_RATE_GI(_val) \
 		FIELD_GET(HTT_PPDU_STATS_USER_RATE_FLAGS_GI_M, _val)
+#define HTT_USR_RATE_DCM(_val) \
+		FIELD_GET(HTT_PPDU_STATS_USER_RATE_FLAGS_DCM_M, _val)
 
 #define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_LTF_SIZE_M		GENMASK(1, 0)
 #define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_STBC_M		BIT(2)
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 47f9414ee921..09edf0f05039 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1217,6 +1217,25 @@ int ath11k_dp_htt_tlv_iter(struct ath11k_base *ab, const void *ptr, size_t len,
 	return 0;
 }
 
+static inline u32 ath11k_he_gi_to_nl80211_he_gi(u8 sgi)
+{
+	u32 ret = 0;
+
+	switch (sgi) {
+	case RX_MSDU_START_SGI_0_8_US:
+		ret = NL80211_RATE_INFO_HE_GI_0_8;
+		break;
+	case RX_MSDU_START_SGI_1_6_US:
+		ret = NL80211_RATE_INFO_HE_GI_1_6;
+		break;
+	case RX_MSDU_START_SGI_3_2_US:
+		ret = NL80211_RATE_INFO_HE_GI_3_2;
+		break;
+	}
+
+	return ret;
+}
+
 static void
 ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 				struct htt_ppdu_stats *ppdu_stats, u8 user)
@@ -1230,7 +1249,7 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 	struct htt_ppdu_user_stats *usr_stats = &ppdu_stats->user_stats[user];
 	struct htt_ppdu_stats_common *common = &ppdu_stats->common;
 	int ret;
-	u8 flags, mcs, nss, bw, sgi, rate_idx = 0;
+	u8 flags, mcs, nss, bw, sgi, dcm, rate_idx = 0;
 	u32 succ_bytes = 0;
 	u16 rate = 0, succ_pkts = 0;
 	u32 tx_duration = 0;
@@ -1265,18 +1284,29 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 	nss = HTT_USR_RATE_NSS(user_rate->rate_flags) + 1;
 	mcs = HTT_USR_RATE_MCS(user_rate->rate_flags);
 	sgi = HTT_USR_RATE_GI(user_rate->rate_flags);
+	dcm = HTT_USR_RATE_DCM(user_rate->rate_flags);
 
 	/* Note: If host configured fixed rates and in some other special
 	 * cases, the broadcast/management frames are sent in different rates.
 	 * Firmware rate's control to be skipped for this?
 	 */
 
-	if (flags == WMI_RATE_PREAMBLE_VHT && mcs > 9) {
+	if (flags == WMI_RATE_PREAMBLE_HE && mcs > 11) {
+		ath11k_warn(ab, "Invalid HE mcs %hhd peer stats",  mcs);
+		return;
+	}
+
+	if (flags == WMI_RATE_PREAMBLE_HE && mcs > ATH11K_HE_MCS_MAX) {
+		ath11k_warn(ab, "Invalid HE mcs %hhd peer stats",  mcs);
+		return;
+	}
+
+	if (flags == WMI_RATE_PREAMBLE_VHT && mcs > ATH11K_VHT_MCS_MAX) {
 		ath11k_warn(ab, "Invalid VHT mcs %hhd peer stats",  mcs);
 		return;
 	}
 
-	if (flags == WMI_RATE_PREAMBLE_HT && (mcs > 7 || nss < 1)) {
+	if (flags == WMI_RATE_PREAMBLE_HT && (mcs > ATH11K_HT_MCS_MAX || nss < 1)) {
 		ath11k_warn(ab, "Invalid HT mcs %hhd nss %hhd peer stats",
 			    mcs, nss);
 		return;
@@ -1325,6 +1355,15 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 		if (sgi)
 			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
+	case WMI_RATE_PREAMBLE_HE:
+		arsta->txrate.mcs = mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
+		arsta->txrate.he_dcm = dcm;
+		arsta->txrate.he_gi = ath11k_he_gi_to_nl80211_he_gi(sgi);
+		arsta->txrate.he_ru_alloc = ath11k_he_ru_tones_to_nl80211_he_ru_alloc(
+						(user_rate->ru_end -
+						 user_rate->ru_start) + 1);
+		break;
 	}
 
 	arsta->txrate.nss = nss;
@@ -2229,6 +2268,7 @@ static void ath11k_dp_rx_h_rate(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 		}
 		rx_status->encoding = RX_ENC_HE;
 		rx_status->nss = nss;
+		rx_status->he_gi = ath11k_he_gi_to_nl80211_he_gi(sgi);
 		rx_status->bw = ath11k_mac_bw_to_mac80211_bw(bw);
 		break;
 	}
@@ -2653,6 +2693,8 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
 
 	rx_stats->num_mpdu_fcs_ok += ppdu_info->num_mpdu_fcs_ok;
 	rx_stats->num_mpdu_fcs_err += ppdu_info->num_mpdu_fcs_err;
+	rx_stats->dcm_count += ppdu_info->dcm;
+	rx_stats->ru_alloc_cnt[ppdu_info->ru_alloc] += num_msdu;
 
 	arsta->rssi_comb = ppdu_info->rssi_comb;
 	rx_stats->rx_duration += ppdu_info->rx_duration;
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index d3f57b9708ed..0c93b291305c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -7,6 +7,7 @@
 #include "dp_tx.h"
 #include "debug.h"
 #include "hw.h"
+#include "peer.h"
 
 /* NOTE: Any of the mapped ring id value must not exceed DP_TCL_NUM_RING_MAX */
 static const u8
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 800fbcd8e146..3a666565cd1e 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -1013,6 +1013,7 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		}
 
 		ppdu_info->nss = nsts + 1;
+		ppdu_info->dcm = dcm;
 		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
 		break;
 	}
@@ -1050,9 +1051,15 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		break;
 	}
 	case HAL_PHYRX_HE_SIG_B1_MU: {
-		/* TODO: Check if resource unit(RU) allocation stats
-		 * are required
-		 */
+		struct hal_rx_he_sig_b1_mu_info *he_sig_b1_mu =
+			(struct hal_rx_he_sig_b1_mu_info *)tlv_data;
+		u16 ru_tones;
+
+		info0 = __le32_to_cpu(he_sig_b1_mu->info0);
+
+		ru_tones = FIELD_GET(HAL_RX_HE_SIG_B1_MU_INFO_INFO0_RU_ALLOCATION,
+				     info0);
+		ppdu_info->ru_alloc = ath11k_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
 		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index bb022c781c48..e863e4abfcc1 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -99,6 +99,8 @@ struct hal_rx_mon_ppdu_info {
 	u8 beamformed;
 	u8 rssi_comb;
 	u8 tid;
+	u8 dcm;
+	u8 ru_alloc;
 	u8 reception_type;
 	u64 rx_duration;
 };
@@ -325,6 +327,34 @@ enum hal_rx_mon_status
 ath11k_hal_rx_parse_mon_status(struct ath11k_base *ab,
 			       struct hal_rx_mon_ppdu_info *ppdu_info,
 			       struct sk_buff *skb);
+
+static inline u32 ath11k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
+{
+	u32 ret = 0;
+
+	switch (ru_tones) {
+	case RU_26:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		break;
+	case RU_52:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
+		break;
+	case RU_106:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		break;
+	case RU_242:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+		break;
+	case RU_484:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+		break;
+	case RU_996:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+		break;
+	}
+	return ret;
+}
+
 #define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_0 0xDDBEEF
 #define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_1 0xADBEEF
 #define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_2 0xBDBEEF
diff --git a/drivers/net/wireless/ath/ath11k/rx_desc.h b/drivers/net/wireless/ath/ath11k/rx_desc.h
index 5af498ec2472..1c4264637a41 100644
--- a/drivers/net/wireless/ath/ath11k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath11k/rx_desc.h
@@ -1209,4 +1209,12 @@ struct hal_rx_desc {
 	u8 msdu_payload[0];
 } __packed;
 
+#define HAL_RX_RU_ALLOC_TYPE_MAX 6
+#define RU_26  1
+#define RU_52  2
+#define RU_106 4
+#define RU_242 9
+#define RU_484 18
+#define RU_996 37
+
 #endif /* ATH11K_RX_DESC_H */
-- 
2.20.1

