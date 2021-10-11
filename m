Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F7D428931
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 10:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhJKI4W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 04:56:22 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:54685 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbhJKI4G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 04:56:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633942432; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=DcEco86oSKp/aYM4xI859C7iZVPWxB3TjI981aMwXu4=; b=lCDJNJGbsMylW1l8TiTMAD6vCwm1B9H+x4ACx0r/rODU3iDhEiYf2qWONm41V0aJacXrvw1z
 bAhVU+b1SooKtb01RIhv/j1g7aA7wrG9E0/Qfb9S89CF/GJI7qWRD7B0C1RcwVXZtlCT/ZA3
 ybOKJUheWB2qzF+lEFxeTBsWNII=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6163fb96ff0285fb0a9a74bb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 08:53:42
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF08BC43460; Mon, 11 Oct 2021 08:53:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F29C0C4338F;
        Mon, 11 Oct 2021 08:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org F29C0C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath11k: report rssi of each chain to mac80211
Date:   Mon, 11 Oct 2021 04:53:31 -0400
Message-Id: <20211011085331.31108-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Command "iw wls1 station dump" does not show each chain's rssi currently.

This patch is to change like this:
If the rssi of each chain from mon status is invalid, then ath11k send
wmi cmd WMI_REQUEST_STATS_CMDID with flag WMI_REQUEST_RSSI_PER_CHAIN_STAT
to firmware, and parse the rssi of chain in wmi WMI_UPDATE_STATS_EVENTID,
then report them to mac80211.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01230-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h    |   7 ++
 drivers/net/wireless/ath/ath11k/debugfs.c |  36 ++++++++
 drivers/net/wireless/ath/ath11k/debugfs.h |   7 ++
 drivers/net/wireless/ath/ath11k/dp_rx.c   |   8 ++
 drivers/net/wireless/ath/ath11k/hal_rx.c  |  13 +++
 drivers/net/wireless/ath/ath11k/hal_rx.h  |  12 ++-
 drivers/net/wireless/ath/ath11k/mac.c     |  38 ++++++++
 drivers/net/wireless/ath/ath11k/wmi.c     | 107 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h     |  14 +++
 9 files changed, 240 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index f8f8ac00be80..b9a65f045b9c 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -410,6 +410,7 @@ struct ath11k_sta {
 	u64 rx_duration;
 	u64 tx_duration;
 	u8 rssi_comb;
+	s8 chain_signal[IEEE80211_MAX_CHAINS];
 	struct ath11k_htt_tx_stats *tx_stats;
 	struct ath11k_rx_peer_stats *rx_stats;
 
@@ -438,6 +439,12 @@ enum ath11k_state {
 /* Antenna noise floor */
 #define ATH11K_DEFAULT_NOISE_FLOOR -95
 
+/* signed value, 11111111h, it is full bit value, invalid */
+#define ATH11K_INVALID_RSSI_FULL -1
+
+/* signed value, 10000000h, it is empty value, invalid */
+#define ATH11K_INVALID_RSSI_EMPTY -128
+
 struct ath11k_ftm_event_obj {
 	u32 data_pos;
 	u32 expected_seq;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index deec5e504dd6..e5a0da54fa88 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -126,6 +126,11 @@ void ath11k_debugfs_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb
 		goto complete;
 	}
 
+	if (stats.stats_id == WMI_REQUEST_RSSI_PER_CHAIN_STAT) {
+		ar->debug.fw_stats_done = true;
+		goto complete;
+	}
+
 	if (stats.stats_id == WMI_REQUEST_VDEV_STAT) {
 		if (list_empty(&stats.vdevs)) {
 			ath11k_warn(ab, "empty vdev stats");
@@ -229,6 +234,37 @@ static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
 	return 0;
 }
 
+int ath11k_debug_get_fw_stats(struct ath11k *ar, u32 pdev_id, u32 vdev_id, u32 stats_id)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct stats_request_params req_param;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto err_unlock;
+	}
+
+	req_param.pdev_id = pdev_id;
+	req_param.vdev_id = vdev_id;
+	req_param.stats_id = stats_id;
+
+	ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
+	if (ret)
+		ath11k_warn(ab, "failed to request fw stats: %d\n", ret);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "debug get fw stat pdev id %d vdev id %d stats id 0x%x\n",
+		   pdev_id, vdev_id, stats_id);
+
+err_unlock:
+	mutex_unlock(&ar->conf_mutex);
+
+	return ret;
+}
+
 static int ath11k_open_pdev_stats(struct inode *inode, struct file *file)
 {
 	struct ath11k *ar = inode->i_private;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index e5346af71f24..d51fb8c5cde5 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -113,6 +113,7 @@ void ath11k_debugfs_unregister(struct ath11k *ar);
 void ath11k_debugfs_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb);
 
 void ath11k_debugfs_fw_stats_init(struct ath11k *ar);
+int ath11k_debug_get_fw_stats(struct ath11k *ar, u32 pdev_id, u32 vdev_id, u32 stats_id);
 
 static inline bool ath11k_debugfs_is_pktlog_lite_mode_enabled(struct ath11k *ar)
 {
@@ -212,6 +213,12 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return 0;
 }
 
+static inline int ath11k_debug_get_fw_stats(struct ath11k *ar,
+					    u32 pdev_id, u32 vdev_id, u32 stats_id)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MAC80211_DEBUGFS*/
 
 #endif /* _ATH11K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 5a6486d04e18..11dfafd011d0 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2696,6 +2696,7 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
 {
 	struct ath11k_rx_peer_stats *rx_stats = arsta->rx_stats;
 	u32 num_msdu;
+	int i;
 
 	if (!rx_stats)
 		return;
@@ -2757,6 +2758,13 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
 	rx_stats->ru_alloc_cnt[ppdu_info->ru_alloc] += num_msdu;
 
 	arsta->rssi_comb = ppdu_info->rssi_comb;
+
+	BUILD_BUG_ON(ARRAY_SIZE(arsta->chain_signal) >
+			     ARRAY_SIZE(ppdu_info->rssi_chain_pri20));
+
+	for (i = 0; i < ARRAY_SIZE(arsta->chain_signal); i++)
+		arsta->chain_signal[i] = ppdu_info->rssi_chain_pri20[i];
+
 	rx_stats->rx_duration += ppdu_info->rx_duration;
 	arsta->rx_duration = rx_stats->rx_duration;
 }
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 325055ca41ab..45c2f303891e 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -1078,6 +1078,9 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		break;
 	}
 	case HAL_PHYRX_RSSI_LEGACY: {
+		int i;
+		bool db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+				       ab->wmi_ab.svc_map);
 		struct hal_rx_phyrx_rssi_legacy_info *rssi =
 			(struct hal_rx_phyrx_rssi_legacy_info *)tlv_data;
 
@@ -1088,6 +1091,16 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		ppdu_info->rssi_comb =
 			FIELD_GET(HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB,
 				  __le32_to_cpu(rssi->info0));
+
+		if (db2dbm) {
+			for (i = 0; i < ARRAY_SIZE(rssi->preamble); i++) {
+				u32 rssi2040 = __le32_to_cpu(rssi->preamble[i].rssi_2040);
+
+				ppdu_info->rssi_chain_pri20[i] =
+					FIELD_GET(HAL_RX_PHYRX_RSSI_PREAMBLE_PRI20,
+						  rssi2040);
+			}
+		}
 		break;
 	}
 	case HAL_RX_MPDU_START: {
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index 0f1f04b812b9..46597b15fb33 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -98,6 +98,7 @@ struct hal_rx_mon_ppdu_info {
 	u8 ldpc;
 	u8 beamformed;
 	u8 rssi_comb;
+	u8 rssi_chain_pri20[HAL_RX_MAX_NSS];
 	u8 tid;
 	u8 dcm;
 	u8 ru_alloc;
@@ -248,8 +249,17 @@ struct hal_rx_he_sig_b2_ofdma_info {
 
 #define HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB	GENMASK(15, 8)
 
+#define HAL_RX_PHYRX_RSSI_PREAMBLE_PRI20	GENMASK(7, 0)
+
+struct hal_rx_phyrx_chain_rssi {
+	__le32 rssi_2040;
+	__le32 rssi_80;
+} __packed;
+
 struct hal_rx_phyrx_rssi_legacy_info {
-	__le32 rsvd[35];
+	__le32 rsvd[3];
+	struct hal_rx_phyrx_chain_rssi pre_rssi[HAL_RX_MAX_NSS];
+	struct hal_rx_phyrx_chain_rssi preamble[HAL_RX_MAX_NSS];
 	__le32 info0;
 } __packed;
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8714f971ad67..5b0d2547939b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6952,12 +6952,42 @@ static int ath11k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	return ret;
 }
 
+static void ath11k_mac_put_chain_rssi(struct station_info *sinfo,
+				      struct ath11k_sta *arsta,
+				      char *pre,
+				      bool clear)
+{
+	struct ath11k *ar = arsta->arvif->ar;
+	int i;
+	s8 rssi;
+
+	for (i = 0; i < ARRAY_SIZE(sinfo->chain_signal); i++) {
+		sinfo->chains &= ~BIT(i);
+		rssi = arsta->chain_signal[i];
+		if (clear)
+			arsta->chain_signal[i] = ATH11K_INVALID_RSSI_FULL;
+
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+			   "mac sta statistics %s rssi[%d] %d\n", pre, i, rssi);
+
+		if (rssi != ATH11K_DEFAULT_NOISE_FLOOR &&
+		    rssi != ATH11K_INVALID_RSSI_FULL &&
+		    rssi != ATH11K_INVALID_RSSI_EMPTY &&
+		    rssi != 0) {
+			sinfo->chain_signal[i] = rssi;
+			sinfo->chains |= BIT(i);
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
+		}
+	}
+}
+
 static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_sta *sta,
 					 struct station_info *sinfo)
 {
 	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
 
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
@@ -6980,6 +7010,14 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
 
+	ath11k_mac_put_chain_rssi(sinfo, arsta, "ppdu", false);
+
+	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) &&
+	    !ath11k_debug_get_fw_stats(ar, ar->pdev->pdev_id, 0,
+				       WMI_REQUEST_RSSI_PER_CHAIN_STAT)) {
+		ath11k_mac_put_chain_rssi(sinfo, arsta, "fw stats", true);
+	}
+
 	/* TODO: Use real NF instead of default one. */
 	sinfo->signal = arsta->rssi_comb + ATH11K_DEFAULT_NOISE_FLOOR;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index bdae480fb627..307c11683fb0 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -131,6 +131,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_probe_resp_tx_status_event) },
 	[WMI_TAG_VDEV_DELETE_RESP_EVENT] = {
 		.min_len = sizeof(struct wmi_vdev_delete_resp_event) },
+	[WMI_TAG_PER_CHAIN_RSSI_STATS] = {
+		.min_len = sizeof(struct wmi_per_chain_rssi_stats) },
 };
 
 #define PRIMAP(_hw_mode_) \
@@ -6039,10 +6041,17 @@ ath11k_wmi_pull_bcn_stats(const struct wmi_bcn_stats *src,
 int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 			     struct ath11k_fw_stats *stats)
 {
+	struct ath11k *ar;
 	const void **tb;
 	const struct wmi_stats_event *ev;
+	const struct wmi_per_chain_rssi_stats *rssi;
+	const struct wmi_rssi_stats *stats_rssi;
+	struct ieee80211_sta *sta;
+	struct ath11k_sta *arsta;
 	const void *data;
-	int i, ret;
+	const struct wmi_tlv *tlv;
+	u16 tlv_tag, tlv_len;
+	int i, ret, rssi_num = 0;
 	u32 len = skb->len;
 
 	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, len, GFP_ATOMIC);
@@ -6054,12 +6063,18 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 
 	ev = tb[WMI_TAG_STATS_EVENT];
 	data = tb[WMI_TAG_ARRAY_BYTE];
+	rssi = tb[WMI_TAG_PER_CHAIN_RSSI_STATS];
 	if (!ev || !data) {
 		ath11k_warn(ab, "failed to fetch update stats ev");
 		kfree(tb);
 		return -EPROTO;
 	}
 
+	if (rssi && (ev->stats_id & WMI_REQUEST_RSSI_PER_CHAIN_STAT))
+		rssi_num = rssi->num_per_chain_rssi_stats;
+
+	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
+
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
 		   "wmi stats update ev pdev_id %d pdev %i vdev %i bcn %i\n",
 		   ev->pdev_id,
@@ -6140,6 +6155,96 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 		list_add_tail(&dst->list, &stats->bcn);
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "wmi stats id 0x%x num chain %d\n",
+		   ev->stats_id,
+		   rssi_num);
+
+	if (rssi_num) {
+		/* This TLV of WMI_TAG_PER_CHAIN_RSSI_STATS is followed by
+		 * another TLV of array of structs
+		 * wmi_rssi_stats rssi_stats[num_per_chain_rssi_stats].
+		 * So add check integrity for the TLVs.
+		 * rssi is behind the TLV of WMI_TAG_PER_CHAIN_RSSI_STATS.
+		 */
+		tlv = (struct wmi_tlv *)((u8 *)rssi - sizeof(*tlv));
+		tlv_len = FIELD_GET(WMI_TLV_LEN, tlv->header);
+
+		/* Skip wmi_per_chain_rssi_stats to get the TLV of array structs */
+		tlv = (struct wmi_tlv *)((u8 *)rssi + tlv_len);
+		if (((u8 *)tlv - skb->data) >= skb->len)
+			goto fin;
+
+		tlv_tag = FIELD_GET(WMI_TLV_TAG, tlv->header);
+		if (tlv_tag != WMI_TAG_ARRAY_STRUCT)
+			rssi_num = 0;
+
+		/* Skip array struct TLV to get the array of structs */
+		tlv++;
+		if (((u8 *)tlv - skb->data) >= skb->len)
+			goto fin;
+
+		tlv_len = FIELD_GET(WMI_TLV_LEN, tlv->header);
+	}
+
+	for (i = 0; i < rssi_num; i++) {
+		struct ath11k_vif *arvif;
+		int j;
+
+		stats_rssi = (struct wmi_rssi_stats *)((u8 *)tlv + i *
+			(sizeof(*tlv) + tlv_len));
+		if (((u8 *)stats_rssi - skb->data) >= skb->len)
+			goto fin;
+
+		tlv_tag = FIELD_GET(WMI_TLV_TAG, stats_rssi->tlv_header);
+		if (tlv_tag != WMI_TAG_RSSI_STATS) {
+			ath11k_warn(ab, "invalid rssi stats TLV data\n");
+			break;
+		}
+
+		stats->stats_id = WMI_REQUEST_RSSI_PER_CHAIN_STAT;
+
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "wmi stats vdev id %d mac %pM\n",
+			   stats_rssi->vdev_id, stats_rssi->peer_macaddr.addr);
+
+		arvif = ath11k_mac_get_arvif(ar, stats_rssi->vdev_id);
+		if (!arvif) {
+			ath11k_warn(ab, "not found vif for vdev id %d\n",
+				    stats_rssi->vdev_id);
+			continue;
+		}
+
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "wmi stats bssid %pM vif %pK\n",
+			   arvif->bssid, arvif->vif);
+
+		sta = ieee80211_find_sta_by_ifaddr(ar->hw,
+						   arvif->bssid,
+						   NULL);
+		if (!sta) {
+			ath11k_warn(ab, "not found station for bssid %pM\n",
+				    arvif->bssid);
+			continue;
+		}
+
+		arsta = (struct ath11k_sta *)sta->drv_priv;
+
+		BUILD_BUG_ON(ARRAY_SIZE(arsta->chain_signal) >
+			     ARRAY_SIZE(stats_rssi->rssi_avg_beacon));
+
+		for (j = 0; j < ARRAY_SIZE(arsta->chain_signal); j++) {
+			arsta->chain_signal[j] = stats_rssi->rssi_avg_beacon[j];
+			ath11k_dbg(ab, ATH11K_DBG_WMI,
+				   "wmi stats beacon rssi[%d] %d data rssi[%d] %d\n",
+				   j,
+				   stats_rssi->rssi_avg_beacon[j],
+				   j,
+				   stats_rssi->rssi_avg_data[j]);
+		}
+	}
+
+fin:
 	kfree(tb);
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b6b0f1e473ab..0ca96baf3be5 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4547,6 +4547,20 @@ struct wmi_stats_event {
 	u32 num_peer_extd2_stats;
 } __packed;
 
+#define WMI_MAX_CHAINS 8
+
+struct wmi_rssi_stats {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 rssi_avg_beacon[WMI_MAX_CHAINS];
+	u32 rssi_avg_data[WMI_MAX_CHAINS];
+	struct wmi_mac_addr peer_macaddr;
+} __packed;
+
+struct wmi_per_chain_rssi_stats {
+	u32 num_per_chain_rssi_stats;
+} __packed;
+
 struct wmi_pdev_ctl_failsafe_chk_event {
 	u32 pdev_id;
 	u32 ctl_failsafe_status;
-- 
2.31.1

