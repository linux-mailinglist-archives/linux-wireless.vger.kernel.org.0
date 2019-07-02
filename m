Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5090D5C9A2
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 08:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfGBG7V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 02:59:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfGBG7V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 02:59:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 80035608A5; Tue,  2 Jul 2019 06:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562050759;
        bh=AZej5X8MKf03cLmzNUBI/f1HQJU/3Im+YxXiCfxDrIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=FUyKO2l49f1EP3N9dsMfIPdvTohlHWP5BAv5csRvSuYmk8Dc6sj6C2VnhECfslTgZ
         b0JZlAu0Uc7jvguUebrKvUMpFCmtVBV8kcim6R9r+RIZq1GjWXyedQE8mTawS/pgKN
         NW2BZAwuwET1PbCVeGvs+Txms54JPZhcTHV+jQ6I=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from zhonglin-HP-Z230.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zhonglin@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA14160770;
        Tue,  2 Jul 2019 06:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562050757;
        bh=AZej5X8MKf03cLmzNUBI/f1HQJU/3Im+YxXiCfxDrIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=FQXHkJQGAlBwn3ZdAhzWVXYsZptA48PzHQTRMsJGRnd+ltqrk/P912Ql7Tlv8U+g3
         rbIiLQiM17afzCs/IRpAvMpXJCqe4DmPg8WeukdAIOI67ZuZOeIeCNb+HQxcUh9GXE
         k/qM8gHT3UdqisO69sRiP0RUYOXidq6M2Cr67IzQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA14160770
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=zhonglin@codeaurora.org
From:   Zhonglin Zhang <zhonglin@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Zhonglin Zhang <zhonglin@codeaurora.org>
Subject: [PATCH] ath10k:New interface to get interface combinations from FW
Date:   Tue,  2 Jul 2019 14:59:02 +0800
Message-Id: <1562050742-8741-1-git-send-email-zhonglin@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

New wmi event "WMI_TLV_IFACE_COMBINATION_EVENTID" is used.
If WMI_SERVICE_IFACE_COMBINATION_SUPPORT service bit set and
WMI_TLV_IFACE_COMBINATION_EVENTID event got from FW side, then
interface combinations reported from FW will override the default
combinations which is hard-coded in host drivers.

Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-01061-QCAHLSWMTPL-1

Signed-off-by: Zhonglin Zhang <zhonglin@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c    |   2 +
 drivers/net/wireless/ath/ath10k/core.h    |  36 +++++
 drivers/net/wireless/ath/ath10k/mac.c     |  12 ++
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 183 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/wmi-tlv.h | 232 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/wmi.h     |   2 +
 6 files changed, 466 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index dc45d16..29d558a 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3210,6 +3210,7 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
 		  ath10k_core_set_coverage_class_work);
 
 	init_dummy_netdev(&ar->napi_dev);
+	ath10k_init_iface_comb(ar);
 
 	ret = ath10k_coredump_create(ar);
 	if (ret)
@@ -3248,6 +3249,7 @@ void ath10k_core_destroy(struct ath10k *ar)
 	ath10k_coredump_destroy(ar);
 	ath10k_htt_tx_destroy(&ar->htt);
 	ath10k_wmi_free_host_mem(ar);
+	ath10k_deinit_iface_comb(ar);
 	ath10k_mac_destroy(ar);
 }
 EXPORT_SYMBOL(ath10k_core_destroy);
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 4d7db07..4ec7517 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -40,6 +40,9 @@
 #define ATH10K_NUM_CHANS 41
 #define ATH10K_MAX_5G_CHAN 173
 
+#define MAX_NUM_IFACE_COMBINATIONS  16
+#define BEACON_TX_OFFLOAD_MAX_VDEV  2
+
 /* Antenna noise floor */
 #define ATH10K_DEFAULT_NOISE_FLOOR -95
 
@@ -940,6 +943,13 @@ struct ath10k_bus_params {
 	bool hl_msdu_ids;
 };
 
+struct ath10k_iface_comb {
+	struct ieee80211_iface_combination combo[MAX_NUM_IFACE_COMBINATIONS];
+	u16 combo_sz;
+	u16 interface_modes;
+	u32 beacon_tx_offload_max_vdev;
+};
+
 struct ath10k {
 	struct ath_common ath_common;
 	struct ieee80211_hw *hw;
@@ -1211,10 +1221,36 @@ struct ath10k {
 	struct ath10k_bus_params bus_param;
 	struct completion peer_delete_done;
 
+	/* iface combination */
+	struct ath10k_iface_comb iface;
+
 	/* must be last */
 	u8 drv_priv[0] __aligned(sizeof(void *));
 };
 
+static inline void ath10k_init_iface_comb(struct ath10k *ar)
+{
+	memset(&ar->iface, 0, sizeof(struct ath10k_iface_comb));
+	ar->iface.beacon_tx_offload_max_vdev = BEACON_TX_OFFLOAD_MAX_VDEV;
+}
+
+static inline void ath10k_deinit_iface_comb(struct ath10k *ar)
+{
+	int i;
+
+	for (i = 0; i < ar->iface.combo_sz; i++) {
+		kfree(ar->iface.combo[i].limits);
+		ar->iface.combo[i].limits = NULL;
+	}
+}
+
+static inline void ath10k_iface_comb_assignment(struct ath10k *ar)
+{
+	ar->hw->wiphy->iface_combinations = ar->iface.combo;
+	ar->hw->wiphy->n_iface_combinations = ar->iface.combo_sz;
+	ar->hw->wiphy->interface_modes = ar->iface.interface_modes;
+}
+
 static inline bool ath10k_peer_stats_enabled(struct ath10k *ar)
 {
 	if (test_bit(ATH10K_FLAG_PEER_STATS, &ar->dev_flags) &&
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index e43a566..0e90f30 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8913,6 +8913,18 @@ int ath10k_mac_register(struct ath10k *ar)
 				ARRAY_SIZE(ath10k_tlv_if_comb);
 		}
 		ar->hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_ADHOC);
+
+		if (test_bit
+		    (WMI_SERVICE_IFACE_COMBINATION_SUPPORT, ar->wmi.svc_map)) {
+			/**
+			 * If combo_sz is not ZERO, it means that host will use
+			 * iface_combinations reported from FW.
+			 */
+			if (ar->iface.combo_sz)
+				ath10k_iface_comb_assignment(ar);
+			else
+				ath10k_warn(ar, "iface combination event missing!\n");
+		}
 		break;
 	case ATH10K_FW_WMI_OP_VERSION_10_1:
 	case ATH10K_FW_WMI_OP_VERSION_10_2:
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 2985bb1..ce89e96 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -64,6 +64,12 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		= { .min_len = sizeof(struct wmi_tlv_wow_event_info) },
 	[WMI_TLV_TAG_STRUCT_TX_PAUSE_EVENT]
 		= { .min_len = sizeof(struct wmi_tlv_tx_pause_ev) },
+	[WMI_TLV_TAG_STRUCT_IFACE_COMBINATION_IND_EVENT]
+		= { .min_len = sizeof(struct wmi_tlv_iface_combination_event) },
+	[WMI_TLV_TAG_STRUCT_IFACE_COMBINATION]
+		= { .min_len = sizeof(struct wmi_tlv_iface_combination) },
+	[WMI_TLV_TAG_STRUCT_IFACE_LIMIT]
+		= { .min_len = sizeof(struct wmi_tlv_iface_limit) },
 };
 
 static int
@@ -483,6 +489,177 @@ static int ath10k_wmi_tlv_event_peer_delete_resp(struct ath10k *ar,
 	return 0;
 }
 
+static u16 ath10k_wmi_tlv_vdev_type_remap(struct wmi_tlv_iface_limit *limit)
+{
+	u32 vdev_has_type = __le32_to_cpu(limit->vdev_type);
+	u32 vdev_has_subtype = __le32_to_cpu(limit->vdev_subtype);
+	u16 type = 0;
+
+	if (vdev_has_subtype) {
+		if (vdev_has_subtype & BIT(WMI_VDEV_SUBTYPE_P2P_DEVICE))
+			type |= BIT(NL80211_IFTYPE_P2P_DEVICE);
+		if (vdev_has_subtype & BIT(WMI_VDEV_SUBTYPE_P2P_CLIENT))
+			type |= BIT(NL80211_IFTYPE_P2P_CLIENT);
+		if (vdev_has_subtype & BIT(WMI_VDEV_SUBTYPE_P2P_GO))
+			type |= BIT(NL80211_IFTYPE_P2P_GO);
+	} else {
+		if (vdev_has_type & BIT(WMI_VDEV_TYPE_AP))
+			type |= BIT(NL80211_IFTYPE_AP);
+		if (vdev_has_type & BIT(WMI_VDEV_TYPE_STA))
+			type |= BIT(NL80211_IFTYPE_STATION);
+		if (vdev_has_type & BIT(WMI_VDEV_TYPE_IBSS))
+			type |= BIT(NL80211_IFTYPE_ADHOC);
+	}
+
+	return type;
+}
+
+static int ath10k_wmi_tlv_iface_comb_parse(struct ath10k *ar, u16 tag, u16 len,
+					   const void *ptr, void *data)
+{
+	int ret = 0;
+	unsigned long valid_fields = 0;
+	struct wmi_tlv_iface_comb_parse *p = data;
+	struct ieee80211_iface_combination *comb = &ar->iface.combo[0];
+	struct ieee80211_iface_limit *limit = NULL;
+
+	switch (tag) {
+	case WMI_TLV_TAG_STRUCT_IFACE_COMBINATION_IND_EVENT:
+		p->ev = (struct wmi_tlv_iface_combination_event *)ptr;
+		break;
+	case WMI_TLV_TAG_ARRAY_STRUCT:
+		ret = ath10k_wmi_tlv_iter(ar, ptr, len,
+					  ath10k_wmi_tlv_iface_comb_parse, p);
+		break;
+	case WMI_TLV_TAG_STRUCT_IFACE_COMBINATION:
+		p->combs = (struct wmi_tlv_iface_combination *)ptr;
+
+		if (p->n_combs >= MAX_NUM_IFACE_COMBINATIONS) {
+			ath10k_warn(ar, "Exceed Max Num Iface Combinations!\n");
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		valid_fields = __le32_to_cpu(p->combs->valid_fields);
+
+		if (test_bit(WMI_TLV_IFACE_COMB_BCN_INT_MATCH_VALID_BIT,
+			     &valid_fields))
+			comb[p->n_combs].beacon_int_infra_match =
+				__le32_to_cpu(p->combs->beacon_int_infra_match);
+
+		if (test_bit(WMI_TLV_IFACE_COMB_BCN_INT_MIN_GCD_VALID_BIT,
+			     &valid_fields))
+			comb[p->n_combs].beacon_int_min_gcd =
+				__le32_to_cpu(p->combs->beacon_int_min_gcd);
+
+		comb[p->n_combs].limits =
+			kcalloc(p->combs->limits_n, sizeof(*limit), GFP_ATOMIC);
+		if (!comb[p->n_combs].limits) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		p->n_combs++;
+		ar->iface.combo_sz++;
+		break;
+	case WMI_TLV_TAG_STRUCT_IFACE_LIMIT:
+		p->limits = (struct wmi_tlv_iface_limit *)ptr;
+
+		/**
+		 * p->comb_index: current iface combo index, default value 0
+		 * comb[p->comb_index]: current iface comb
+		 * p->limit_index: point to the next available iface limit slot,
+		 * limit_index default value 0.
+		 * comb[p->comb_index].n_limits: num of limits of this
+		 * comb_index. n_limits value got from
+		 * WMI_TLV_TAG_STRUCT_IFACE_COMBINATION assignment.
+		 *
+		 * So the logic here:
+		 * 0) Basic precondition now we have got all comb(s) in
+		 *    WMI_TLV_TAG_STRUCT_IFACE_COMBINATION assignment.
+		 * 1) if (limit_index >= n_limits of current iface combo, then
+		 *    this new iface limit will belong to a new iface combo. So
+		 *    update the index
+		 *    a. comb_index++ and limit_index reset as 0.
+		 *    b. comb_fill_max_interfaces point to the current iface
+		 *       combo to fill max_interfaces field. And its default
+		 *       value should point to the first iface combo.
+		 * 2) Use combo_index/limit_index to do assignment, and finally
+		 *    limit_index++ to point to the next available limit slot.
+		 * 3) Loop to 1) when find new iface limit, else exit the parse
+		 *    procedure.
+		 */
+		if (p->limit_index >= comb[p->comb_index].n_limits) {
+			p->comb_index++;
+			p->limit_index = 0;
+			p->comb_fill_max_interfaces = &comb[p->comb_index];
+		}
+
+		limit = (struct ieee80211_iface_limit *)
+			  &comb[p->comb_index].limits[p->limit_index];
+		limit->max = __le32_to_cpu(p->limits->vdev_limit_n);
+		limit->types = ath10k_wmi_tlv_vdev_type_remap(p->limits);
+		ar->iface.interface_modes |= limit->types;
+
+		/**
+		 * ar->iface.beacon_tx_offload_max_vdev default value is 2.
+		 * If limit type is AP and
+		 * limit->max > ar->iface.beacon_tx_offload_max_vdev, we will
+		 * override this value by limit->max.  FW needs this value in
+		 * WMI_INIT command for beacon offload function.
+		 */
+		if ((limit->types & BIT(NL80211_IFTYPE_AP)) &&
+		    limit->max > ar->iface.beacon_tx_offload_max_vdev)
+			ar->iface.beacon_tx_offload_max_vdev = limit->max;
+		if (!p->comb_fill_max_interfaces)
+			/* point to the first combination */
+			p->comb_fill_max_interfaces = comb;
+
+		p->comb_fill_max_interfaces->max_interfaces += limit->max;
+
+		p->limit_index++;
+		break;
+	default:
+		break;
+	}
+out:
+	if (ret) {
+		int i;
+
+		for (i = 0; i < p->n_combs; i++) {
+			kfree(comb[i].limits);
+			comb[i].limits = NULL;
+		}
+	}
+	return ret;
+}
+
+static int ath10k_wmi_tlv_iface_combination(struct ath10k *ar,
+					    struct sk_buff *skb)
+{
+	int ret;
+	struct wmi_tlv_iface_comb_parse parse;
+
+	if (!test_bit(WMI_SERVICE_IFACE_COMBINATION_SUPPORT, ar->wmi.svc_map))
+		return 0;
+
+	memset(&parse, 0, sizeof(struct wmi_tlv_iface_comb_parse));
+
+	ath10k_deinit_iface_comb(ar);
+	ath10k_init_iface_comb(ar);
+
+	ret = ath10k_wmi_tlv_iter(ar, skb->data, skb->len,
+				  ath10k_wmi_tlv_iface_comb_parse, &parse);
+
+	if (ret) {
+		ath10k_warn(ar, "%s:failed to parse tlv: %d\n", __func__, ret);
+		ar->iface.combo_sz = 0;
+		return ret;
+	}
+
+	return 0;
+}
+
 /***********/
 /* TLV ops */
 /***********/
@@ -608,6 +785,9 @@ static void ath10k_wmi_tlv_op_rx(struct ath10k *ar, struct sk_buff *skb)
 	case WMI_TLV_SERVICE_READY_EVENTID:
 		ath10k_wmi_event_service_ready(ar, skb);
 		return;
+	case WMI_TLV_IFACE_COMBINATION_EVENTID:
+		ath10k_wmi_tlv_iface_combination(ar, skb);
+		break;
 	case WMI_TLV_READY_EVENTID:
 		ath10k_wmi_event_ready(ar, skb);
 		break;
@@ -1776,7 +1956,8 @@ static struct sk_buff *ath10k_wmi_tlv_op_gen_init(struct ath10k *ar)
 	cfg->max_frag_entries = __cpu_to_le32(2);
 	cfg->num_tdls_vdevs = __cpu_to_le32(TARGET_TLV_NUM_TDLS_VDEVS);
 	cfg->num_tdls_conn_table_entries = __cpu_to_le32(0x20);
-	cfg->beacon_tx_offload_max_vdev = __cpu_to_le32(2);
+	cfg->beacon_tx_offload_max_vdev =
+			__cpu_to_le32(ar->iface.beacon_tx_offload_max_vdev);
 	cfg->num_multicast_filter_entries = __cpu_to_le32(5);
 	cfg->num_wow_filters = __cpu_to_le32(ar->wow.max_num_patterns);
 	cfg->num_keep_alive_pattern = __cpu_to_le32(6);
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.h b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
index d691f06..71d7f396 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -288,6 +288,7 @@ enum wmi_tlv_event_id {
 	WMI_TLV_SERVICE_READY_EVENTID = 0x1,
 	WMI_TLV_READY_EVENTID,
 	WMI_TLV_SERVICE_AVAILABLE_EVENTID,
+	WMI_TLV_IFACE_COMBINATION_EVENTID,
 	WMI_TLV_SCAN_EVENTID = WMI_TLV_EV(WMI_TLV_GRP_SCAN),
 	WMI_TLV_PDEV_TPC_CONFIG_EVENTID = WMI_TLV_EV(WMI_TLV_GRP_PDEV),
 	WMI_TLV_CHAN_INFO_EVENTID,
@@ -1217,6 +1218,121 @@ enum wmi_tlv_tag {
 	WMI_TLV_TAG_STRUCT_FD_SEND_FROM_HOST_CMD,
 	WMI_TLV_TAG_STRUCT_ENABLE_FILS_CMD,
 	WMI_TLV_TAG_STRUCT_HOST_SWFDA_EVENT,
+	WMI_TLV_TAG_STRUCT_BCN_OFFLOAD_CTRL_CMD,
+	WMI_TLV_TAG_STRUCT_PDEV_SET_AC_TXQ_OPTIMIZED_CMD,
+	WMI_TLV_TAG_STRUCT_STATS_PERIOD,
+	WMI_TLV_TAG_STRUCT_NDL_SCHEDULE_UPDATE,
+	WMI_TLV_TAG_STRUCT_PEER_TID_MSDUQ_QDEPTH_THRESH_UPDATE_CMD,
+	WMI_TLV_TAG_STRUCT_MSDUQ_QDEPTH_THRESH_UPDATE,
+	WMI_TLV_TAG_STRUCT_PDEV_SET_RX_FILTER_PROMISCUOUS_CMD,
+	WMI_TLV_TAG_STRUCT_SAR2_RESULT_EVENT,
+	WMI_TLV_TAG_STRUCT_SAR_CAPABILITIES,
+	WMI_TLV_TAG_STRUCT_SAP_OBSS_DETECTION_CFG_CMD,
+	WMI_TLV_TAG_STRUCT_SAP_OBSS_DETECTION_INFO_EVENT,
+	WMI_TLV_TAG_STRUCT_DMA_RING_CAPABILITIES,
+	WMI_TLV_TAG_STRUCT_DMA_RING_CFG_REQ,
+	WMI_TLV_TAG_STRUCT_DMA_RING_CFG_RSP,
+	WMI_TLV_TAG_STRUCT_DMA_BUF_RELEASE,
+	WMI_TLV_TAG_STRUCT_DMA_BUF_RELEASE_ENTRY,
+	WMI_TLV_TAG_STRUCT_SAR_GET_LIMITS_CMD,
+	WMI_TLV_TAG_STRUCT_SAR_GET_LIMITS_EVENT,
+	WMI_TLV_TAG_STRUCT_SAR_GET_LIMITS_EVENT_ROW,
+	WMI_TLV_TAG_STRUCT_OFFLOAD_11K_REPORT,
+	WMI_TLV_TAG_STRUCT_INVOKE_NEIGHBOR_REPORT,
+	WMI_TLV_TAG_STRUCT_NEIGHBOR_REPORT_OFFLOAD_TLV_PARAM,
+	WMI_TLV_TAG_STRUCT_VDEV_SET_CONNECTIVITY_CHECK_STATS,
+	WMI_TLV_TAG_STRUCT_VDEV_GET_CONNECTIVITY_CHECK_STATS,
+	WMI_TLV_TAG_STRUCT_BPF_SET_VDEV_ENABLE_CMD,
+	WMI_TLV_TAG_STRUCT_BPF_SET_VDEV_WORK_MEMORY_CMD,
+	WMI_TLV_TAG_STRUCT_BPF_GET_VDEV_WORK_MEMORY_CMD,
+	WMI_TLV_TAG_STRUCT_BPF_GET_VDEV_WORK_MEMORY_RESP_EVENT,
+	WMI_TLV_TAG_STRUCT_PDEV_GET_NFCAL_POWER,
+	WMI_TLV_TAG_STRUCT_BSS_COLOR_CHANGE_ENABLE,
+	WMI_TLV_TAG_STRUCT_OBSS_COLOR_COLLISION_DET_CONFIG,
+	WMI_TLV_TAG_STRUCT_OBSS_COLOR_COLLISION_EVENT,
+	WMI_TLV_TAG_STRUCT_RUNTIME_DPD_RECAL_CMD,
+	WMI_TLV_TAG_STRUCT_TWT_ENABLE_CMD,
+	WMI_TLV_TAG_STRUCT_TWT_DISABLE_CMD,
+	WMI_TLV_TAG_STRUCT_TWT_ADD_DIALOG_CMD,
+	WMI_TLV_TAG_STRUCT_TWT_DEL_DIALOG_CMD,
+	WMI_TLV_TAG_STRUCT_TWT_PAUSE_DIALOG_CMD,
+	WMI_TLV_TAG_STRUCT_TWT_RESUME_DIALOG_CMD,
+	WMI_TLV_TAG_STRUCT_TWT_ENABLE_COMPLETE_EVENT,
+	WMI_TLV_TAG_STRUCT_TWT_DISABLE_COMPLETE_EVENT,
+	WMI_TLV_TAG_STRUCT_TWT_ADD_DIALOG_COMPLETE_EVENT,
+	WMI_TLV_TAG_STRUCT_TWT_DEL_DIALOG_COMPLETE_EVENT,
+	WMI_TLV_TAG_STRUCT_TWT_PAUSE_DIALOG_COMPLETE_EVENT,
+	WMI_TLV_TAG_STRUCT_TWT_RESUME_DIALOG_COMPLETE_EVENT,
+	WMI_TLV_TAG_STRUCT_REQUEST_ROAM_SCAN_STATS_CMD,
+	WMI_TLV_TAG_STRUCT_ROAM_SCAN_STATS_EVENT,
+	WMI_TLV_TAG_STRUCT_PEER_TID_CONFIGURATIONS_CMD,
+	WMI_TLV_TAG_STRUCT_VDEV_SET_CUSTOM_SW_RETRY_TH_CMD,
+	WMI_TLV_TAG_STRUCT_GET_TPC_POWER_CMD,
+	WMI_TLV_TAG_STRUCT_GET_TPC_POWER_EVENT,
+	WMI_TLV_TAG_STRUCT_DMA_BUF_RELEASE_SPECTRAL_META_DATA,
+	WMI_TLV_TAG_STRUCT_MOTION_DET_CONFIG_PARAMS_CMD,
+	WMI_TLV_TAG_STRUCT_MOTION_DET_BASE_LINE_CONFIG_PARAMS_CMD,
+	WMI_TLV_TAG_STRUCT_MOTION_DET_START_STOP_CMD,
+	WMI_TLV_TAG_STRUCT_MOTION_DET_BASE_LINE_START_STOP_CMD,
+	WMI_TLV_TAG_STRUCT_MOTION_DET_EVENT,
+	WMI_TLV_TAG_STRUCT_MOTION_DET_BASE_LINE_EVENT,
+	WMI_TLV_TAG_STRUCT_NDP_TRANSPORT_IP_PARAM,
+	WMI_TLV_TAG_STRUCT_OBSS_SPATIAL_REUSE_SET_CMD,
+	WMI_TLV_TAG_STRUCT_ESP_ESTIMATE_EVENT,
+	WMI_TLV_TAG_STRUCT_NAN_HOST_CONFIG_PARAM,
+	WMI_TLV_TAG_STRUCT_SPECTRAL_BIN_SCALING_PARAM,
+	WMI_TLV_TAG_STRUCT_PEER_CFR_CAPTURE_CONF_CMD,
+	WMI_TLV_TAG_STRUCT_PEER_CHAN_WIDTH_SWITCH_CMD,
+	WMI_TLV_TAG_STRUCT_CHAN_WIDTH_PEER_LIST,
+	WMI_TLV_TAG_STRUCT_OBSS_SPATIAL_REUSE_SET_DEF_OBSS_THRESH_CMD,
+	WMI_TLV_TAG_STRUCT_PDEV_HE_TB_ACTION_FRM_CMD,
+	WMI_TLV_TAG_STRUCT_PEER_EXTD2_STATS,
+	WMI_TLV_TAG_STRUCT_HPCS_PULSE_START_CMD,
+	WMI_TLV_TAG_STRUCT_PDEV_CTL_FAILSAFE_CHECK_PARAM,
+	WMI_TLV_TAG_STRUCT_VDEV_CHAINMASK_CONFIG_CMD,
+	WMI_TLV_TAG_STRUCT_VDEV_BCN_OFFLOAD_QUIET_CONFIG_CMD,
+	WMI_TLV_TAG_STRUCT_NAN_EVENT_INFO,
+	WMI_TLV_TAG_STRUCT_NDP_CHANNEL_INFO,
+	WMI_TLV_TAG_STRUCT_NDP_CMD,
+	WMI_TLV_TAG_STRUCT_NDP_EVENT,
+	WMI_TLV_TAG_STRUCT_PDEV_PKTLOG_FILTER_CMD,
+	WMI_TLV_TAG_STRUCT_PDEV_PKTLOG_FILTER_INFO,
+	WMI_TLV_TAG_STRUCT_QUIET_OFFLOAD_INFO,
+	WMI_TLV_TAG_STRUCT_GET_BCN_RECV_STATS,
+	WMI_TLV_TAG_STRUCT_VDEV_BCN_RECV_STATS_EVENT,
+	WMI_TLV_TAG_STRUCT_PEER_TX_PN_REQUEST_CMD,
+	WMI_TLV_TAG_STRUCT_PEER_TX_PN_RESPONSE_EVENT,
+	WMI_TLV_TAG_STRUCT_TLV_ARRAYS_LEN_PARAM,
+	WMI_TLV_TAG_STRUCT_PEER_UNMAP_RESPONSE_CMD,
+	WMI_TLV_TAG_STRUCT_PDEV_CSC_SWITCH_COUNT_STATUS_EVENT,
+	WMI_TLV_TAG_STRUCT_ROAM_BSS_LOAD_CONFIG_CMD,
+	WMI_TLV_TAG_STRUCT_ROAM_BLACKLIST_EVENT,
+	WMI_TLV_TAG_STRUCT_CSC_VDEV_LIST,
+	WMI_TLV_TAG_STRUCT_VDEV_GET_MWS_COEX_INFO_CMD,
+	WMI_TLV_TAG_STRUCT_VDEV_GET_MWS_COEX_STATE,
+	WMI_TLV_TAG_STRUCT_VDEV_GET_MWS_COEX_DPWB_STATE,
+	WMI_TLV_TAG_STRUCT_VDEV_GET_MWS_COEX_TDM_STATE,
+	WMI_TLV_TAG_STRUCT_VDEV_GET_MWS_COEX_IDRX_STATE,
+	WMI_TLV_TAG_STRUCT_VDEV_GET_MWS_COEX_ANTENNA_SHARING_STATE,
+	WMI_TLV_TAG_STRUCT_REQUEST_WLM_STATS_CMD,
+	WMI_TLV_TAG_STRUCT_WLM_STATS_EVENT,
+	WMI_TLV_TAG_STRUCT_KEY_MATERIAL_EXT,
+	WMI_TLV_TAG_STRUCT_PEER_CFR_CAPTURE_EVENT,
+	WMI_TLV_TAG_STRUCT_COLD_BOOT_CAL_DATA,
+	WMI_TLV_TAG_STRUCT_PDEV_SET_RAP_CONFIG,
+	WMI_TLV_TAG_STRUCT_PDEV_SET_RAP_CONFIG_ON_STA_PS,
+	WMI_TLV_TAG_STRUCT_PDEV_RAP_INFO_EVENT,
+	WMI_TLV_TAG_STRUCT_STA_TDCC_CONFIG_CMD,
+	WMI_TLV_TAG_STRUCT_ROAM_DEAUTH_CONFIG_CMD,
+	WMI_TLV_TAG_STRUCT_ROAM_IDLE_CONFIG_CMD,
+	WMI_TLV_TAG_STRUCT_IDLE_TRIGGER_MONITOR_CMD,
+	WMI_TLV_TAG_STRUCT_STATS_INTERFERENCE,
+	WMI_TLV_TAG_STRUCT_ROAM_SCORE_DELTA_PARAM,
+	WMI_TLV_TAG_STRUCT_ROAM_CND_MIN_RSSI_PARAM,
+	WMI_TLV_TAG_STRUCT_CHAN_RF_CHARACTERIZATION_INFO,
+	WMI_TLV_TAG_STRUCT_IFACE_COMBINATION_IND_EVENT,
+	WMI_TLV_TAG_STRUCT_IFACE_COMBINATION,
+	WMI_TLV_TAG_STRUCT_IFACE_LIMIT,
 
 	WMI_TLV_TAG_MAX
 };
@@ -1409,6 +1525,7 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_WLAN_HPCS_PULSE = 172,
 	WMI_TLV_SERVICE_PER_VDEV_CHAINMASK_CONFIG_SUPPORT = 173,
 	WMI_TLV_SERVICE_TX_DATA_MGMT_ACK_RSSI = 174,
+	WMI_TLV_SERVICE_IFACE_COMBINATION_SUPPORT = 209,
 
 	WMI_TLV_MAX_EXT_SERVICE = 256,
 };
@@ -1588,6 +1705,8 @@ wmi_tlv_svc_map_ext(const __le32 *in, unsigned long *out, size_t len)
 	       WMI_TLV_MAX_SERVICE);
 	SVCMAP(WMI_TLV_SERVICE_TX_DATA_MGMT_ACK_RSSI,
 	       WMI_SERVICE_TX_DATA_ACK_RSSI, WMI_TLV_MAX_SERVICE);
+	SVCMAP(WMI_TLV_SERVICE_IFACE_COMBINATION_SUPPORT,
+	       WMI_SERVICE_IFACE_COMBINATION_SUPPORT, WMI_TLV_MAX_SERVICE);
 }
 
 #undef SVCMAP
@@ -2483,4 +2602,117 @@ struct wmi_tlv_mgmt_tx_cmd {
 	__le32 frame_len;
 	__le32 buf_len;
 } __packed;
+
+struct wmi_tlv_iface_combination_event {
+	/* common part */
+	__le32 pdev_n;
+
+	/* iface combination part
+	 * wmi_tlv_iface_combinations[] will follow.
+	 * 1. iface combinations:
+	 * wmi_tlv_iface_combination combinations[0];
+	 * wmi_tlv_iface_combination combinations[.];
+	 * wmi_tlv_iface_combination combinations[m];
+	 * ===========================================
+	 * 2. limits for all combinations:
+	 * 2.1 limits for first combination:
+	 * wmi_tlv_iface_limit limits[0];
+	 * wmi_tlv_iface_limit limits[vdev_limit_n - 1];
+	 * -------------------------------------------
+	 * 2.2 limits for next combination:
+	 * wmi_tlv_iface_limit limits[i];
+	 * wmi_tlv_iface_limit limits[vdev_limit_n - 1];
+	 * -------------------------------------------
+	 * 2.3 limits for the last combination:
+	 * wmi_tlv_iface_limit limits[m];
+	 * wmi_tlv_iface_limit limits[vdev_limit_n - 1];
+	 */
+} __packed;
+
+struct wmi_tlv_iface_limit {
+	/**
+	 * How many vdevs can work as below vdev_type/vdev_subtype
+	 * in one combination
+	 */
+	__le32 vdev_limit_n;
+
+	/* Indicate what role above vdev can work as
+	 * Refer to "WMI_VDEV_TYPE_xx, WMI_VDEV_SUBTYPE_xx
+	 * for role definition
+	 */
+	__le32 vdev_type;
+	__le32 vdev_subtype;
+} __packed;
+
+#define WMI_TLV_IFACE_COMB_PEER_MAX_VALID_BIT 0
+#define WMI_TLV_IFACE_COMB_BCN_INT_MATCH_VALID_BIT 1
+#define WMI_TLV_IFACE_COMB_BCN_INT_MIN_GCD_VALID_BIT 2
+#define WMI_TLV_IFACE_COMB_NUM_UNIQUE_BI_VALID_BIT 3
+
+struct wmi_tlv_iface_combination {
+	/**
+	 * Max num peers can be supported in this combination.
+	 * It excludes the self-peers associated with each vdev.
+	 * It's the number of real remote peers.
+	 * eg: when working as AP mode, indicating how many clients can be
+	 * supported to connect with this AP.
+	 */
+	__le32 peer_max;
+	/**
+	 * Home channels supported on one single phy concurrently
+	 */
+	__le32 channel_n;
+	/**
+	 * The number of "wmi_tlv_iface_limit" for a specified combination.
+	 */
+	__le32 limits_n;
+	/**
+	 * Beacon intervals between infrastructure and AP types must match
+	 * or not.
+	 * 1: need match
+	 * 0: not need
+	 */
+	__le32 beacon_int_infra_match;
+	/**
+	 * This interface (vdev) combination supports different beacon
+	 * intervals.
+	 *
+	 * = 0
+	 *   all beacon intervals for different interface must be same.
+	 * > 0
+	 *   any beacon interval for the interface part of this combination AND
+	 *   GCD of all beacon intervals from beaconing interfaces of this
+	 *   combination must be greater or equal to this value.
+	 */
+	__le32 beacon_int_min_gcd;
+	/**
+	 * Number of different beacon intervals supported.
+	 */
+	__le32 num_unique_bi;
+	/**
+	 * This indicates which field contains valid value from FW side.
+	 * All fields except channel_n and limits_n are optional.
+	 */
+	__le32 valid_fields;
+} __packed;
+
+/**
+ * It is to save the parse status. Through the parse procedure,
+ * iface_combinations info will be got finally.
+ */
+struct wmi_tlv_iface_comb_parse {
+	struct wmi_tlv_iface_combination_event *ev;
+	struct wmi_tlv_iface_combination *combs;
+	struct wmi_tlv_iface_limit *limits;
+	/* for combos fill */
+	int n_combs;
+	struct ieee80211_iface_combination *comb_fill_max_interfaces;
+
+	/* for limits fill
+	 * comb_index point to the current combo
+	 * limit_index point to the next available limit slot
+	 */
+	int comb_index;
+	int limit_index;
+};
 #endif
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 838768c..cdba117 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -202,6 +202,7 @@ enum wmi_service {
 	WMI_SERVICE_REPORT_AIRTIME,
 	WMI_SERVICE_SYNC_DELETE_CMDS,
 	WMI_SERVICE_TX_PWR_PER_PEER,
+	WMI_SERVICE_IFACE_COMBINATION_SUPPORT,
 
 	/* Remember to add the new value to wmi_service_name()! */
 
@@ -496,6 +497,7 @@ static inline char *wmi_service_name(enum wmi_service service_id)
 	SVCSTR(WMI_SERVICE_REPORT_AIRTIME);
 	SVCSTR(WMI_SERVICE_SYNC_DELETE_CMDS);
 	SVCSTR(WMI_SERVICE_TX_PWR_PER_PEER);
+	SVCSTR(WMI_SERVICE_IFACE_COMBINATION_SUPPORT);
 
 	case WMI_SERVICE_MAX:
 		return NULL;
-- 
2.7.4

