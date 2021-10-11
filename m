Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F248428C24
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 13:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhJKLjh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 07:39:37 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56518 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbhJKLjf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 07:39:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633952255; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=aybu3bPvzPR31WnmOWiAymCQRNCSfYY64YiemOj03yU=; b=R9z2JxwonyGQya8txPvLom/fd00On26TL9lwLx5c3nK7IJe0s1L1ww+4zbUy4i/f3OBnyzMh
 2BjpNxbNebjaMWY8qgtWd8uuQ5cbDVqo9jJlQCR3Zb4rPm+0MY72InnQzHd0iX3zVHU2t+13
 4zTDNJ/gLcPlnEcMAAfUvHmFdFs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 616421f7ff0285fb0a2c98e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 11:37:27
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9EC16C4360D; Mon, 11 Oct 2021 11:37:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F81DC4360C;
        Mon, 11 Oct 2021 11:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9F81DC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/6] ath11k: Add WoW net-detect functionality
Date:   Mon, 11 Oct 2021 15:37:46 -0400
Message-Id: <20211011193750.4891-3-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211011193750.4891-1-cjhuang@codeaurora.org>
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Implement net-detect feature by setting flag
WIPHY_WOWLAN_NET_DETECT if firmware supports this
feature. Driver sets the related PNO configuration
to firmware before entering WoW and firmware then
scans periodically and wakes up host if a specific
SSID is found.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  |  12 +++
 drivers/net/wireless/ath/ath11k/wmi.c  | 150 ++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h  | 169 ++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wow.c  | 172 ++++++++++++++++++++++++++++++++-
 5 files changed, 503 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 565cffc..6e40a33 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -636,6 +636,7 @@ struct ath11k {
 	struct completion finish_11d_ch_list;
 	bool pending_11d;
 	bool regdom_set_by_user;
+	bool nlo_enabled;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b32ef40..ce235ca 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7742,6 +7742,18 @@ static int __ath11k_mac_register(struct ath11k *ar)
 
 	ar->hw->wiphy->max_ap_assoc_sta = ar->max_num_stations;
 
+	if (test_bit(WMI_TLV_SERVICE_NLO, ar->wmi->wmi_ab->svc_map)) {
+		ar->hw->wiphy->max_sched_scan_ssids = WMI_PNO_MAX_SUPP_NETWORKS;
+		ar->hw->wiphy->max_match_sets = WMI_PNO_MAX_SUPP_NETWORKS;
+		ar->hw->wiphy->max_sched_scan_ie_len = WMI_PNO_MAX_IE_LENGTH;
+		ar->hw->wiphy->max_sched_scan_plans = WMI_PNO_MAX_SCHED_SCAN_PLANS;
+		ar->hw->wiphy->max_sched_scan_plan_interval =
+			WMI_PNO_MAX_SCHED_SCAN_PLAN_INT;
+		ar->hw->wiphy->max_sched_scan_plan_iterations =
+			WMI_PNO_MAX_SCHED_SCAN_PLAN_ITRNS;
+		ar->hw->wiphy->features |= NL80211_FEATURE_ND_RANDOM_MAC_ADDR;
+	}
+
 	ret = ath11k_wow_init(ar);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to init wow: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 4fe56b7..9f466fe 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8546,3 +8546,153 @@ int ath11k_wmi_wow_del_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id)
 
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_DEL_WAKE_PATTERN_CMDID);
 }
+
+static struct sk_buff *
+ath11k_wmi_op_gen_config_pno_start(struct ath11k *ar,
+				   u32 vdev_id,
+				       struct wmi_pno_scan_req *pno)
+{
+	struct nlo_configured_parameters *nlo_list;
+	struct wmi_wow_nlo_config_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	u32 *channel_list;
+	size_t len, nlo_list_len, channel_list_len;
+	u8 *ptr;
+	u32 i;
+
+	len = sizeof(*cmd) +
+	      sizeof(*tlv) +
+	      /* TLV place holder for array of structures
+	       * nlo_configured_parameters(nlo_list)
+	       */
+	      sizeof(*tlv);
+	      /* TLV place holder for array of uint32 channel_list */
+
+	channel_list_len = sizeof(u32) * pno->a_networks[0].channel_count;
+	len += channel_list_len;
+
+	nlo_list_len = sizeof(*nlo_list) * pno->uc_networks_count;
+	len += nlo_list_len;
+
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	ptr = (u8 *)skb->data;
+	cmd = (struct wmi_wow_nlo_config_cmd *)ptr;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_NLO_CONFIG_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->vdev_id = pno->vdev_id;
+	cmd->flags = WMI_NLO_CONFIG_START | WMI_NLO_CONFIG_SSID_HIDE_EN;
+
+	/* current FW does not support min-max range for dwell time */
+	cmd->active_dwell_time = pno->active_max_time;
+	cmd->passive_dwell_time = pno->passive_max_time;
+
+	if (pno->do_passive_scan)
+		cmd->flags |= WMI_NLO_CONFIG_SCAN_PASSIVE;
+
+	cmd->fast_scan_period = pno->fast_scan_period;
+	cmd->slow_scan_period = pno->slow_scan_period;
+	cmd->fast_scan_max_cycles = pno->fast_scan_max_cycles;
+	cmd->delay_start_time = pno->delay_start_time;
+
+	if (pno->enable_pno_scan_randomization) {
+		cmd->flags |= WMI_NLO_CONFIG_SPOOFED_MAC_IN_PROBE_REQ |
+				WMI_NLO_CONFIG_RANDOM_SEQ_NO_IN_PROBE_REQ;
+		ether_addr_copy(cmd->mac_addr.addr, pno->mac_addr);
+		ether_addr_copy(cmd->mac_mask.addr, pno->mac_addr_mask);
+	}
+
+	ptr += sizeof(*cmd);
+
+	/* nlo_configured_parameters(nlo_list) */
+	cmd->no_of_ssids = pno->uc_networks_count;
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG,
+				 WMI_TAG_ARRAY_STRUCT) |
+		      FIELD_PREP(WMI_TLV_LEN, nlo_list_len);
+
+	ptr += sizeof(*tlv);
+	nlo_list = (struct nlo_configured_parameters *)ptr;
+	for (i = 0; i < cmd->no_of_ssids; i++) {
+		tlv = (struct wmi_tlv *)(&nlo_list[i].tlv_header);
+		tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
+			      FIELD_PREP(WMI_TLV_LEN, sizeof(*nlo_list) - sizeof(*tlv));
+
+		nlo_list[i].ssid.valid = true;
+		nlo_list[i].ssid.ssid.ssid_len = pno->a_networks[i].ssid.ssid_len;
+		memcpy(nlo_list[i].ssid.ssid.ssid,
+		       pno->a_networks[i].ssid.ssid,
+		       nlo_list[i].ssid.ssid.ssid_len);
+
+		if (pno->a_networks[i].rssi_threshold &&
+		    pno->a_networks[i].rssi_threshold > -300) {
+			nlo_list[i].rssi_cond.valid = true;
+			nlo_list[i].rssi_cond.rssi =
+				pno->a_networks[i].rssi_threshold;
+		}
+
+		nlo_list[i].bcast_nw_type.valid = true;
+		nlo_list[i].bcast_nw_type.bcast_nw_type =
+			pno->a_networks[i].bcast_nw_type;
+	}
+
+	ptr += nlo_list_len;
+	cmd->num_of_channels = pno->a_networks[0].channel_count;
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header =  FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_UINT32) |
+		       FIELD_PREP(WMI_TLV_LEN, channel_list_len);
+	ptr += sizeof(*tlv);
+	channel_list = (u32 *)ptr;
+	for (i = 0; i < cmd->num_of_channels; i++)
+		channel_list[i] = pno->a_networks[0].channels[i];
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi tlv start pno config vdev_id %d\n",
+		   vdev_id);
+
+	return skb;
+}
+
+static struct sk_buff *ath11k_wmi_op_gen_config_pno_stop(struct ath11k *ar,
+							 u32 vdev_id)
+{
+	struct wmi_wow_nlo_config_cmd *cmd;
+	struct sk_buff *skb;
+	size_t len;
+
+	len = sizeof(*cmd);
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	cmd = (struct wmi_wow_nlo_config_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_NLO_CONFIG_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+
+	cmd->vdev_id = vdev_id;
+	cmd->flags = WMI_NLO_CONFIG_STOP;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi tlv stop pno config vdev_id %d\n", vdev_id);
+	return skb;
+}
+
+int ath11k_wmi_wow_config_pno(struct ath11k *ar, u32 vdev_id,
+			      struct wmi_pno_scan_req  *pno_scan)
+{
+	struct sk_buff *skb;
+
+	if (pno_scan->enable)
+		skb = ath11k_wmi_op_gen_config_pno_start(ar, vdev_id, pno_scan);
+	else
+		skb = ath11k_wmi_op_gen_config_pno_stop(ar, vdev_id);
+
+	if (IS_ERR_OR_NULL(skb))
+		return -ENOMEM;
+
+	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID);
+}
+
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 0e3a880..6d3dfb9 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5626,6 +5626,173 @@ struct wmi_wow_del_pattern_cmd {
 	u32 pattern_type;
 } __packed;
 
+#define WMI_PNO_MAX_SCHED_SCAN_PLANS      2
+#define WMI_PNO_MAX_SCHED_SCAN_PLAN_INT   7200
+#define WMI_PNO_MAX_SCHED_SCAN_PLAN_ITRNS 100
+#define WMI_PNO_MAX_NETW_CHANNELS         26
+#define WMI_PNO_MAX_NETW_CHANNELS_EX      60
+#define WMI_PNO_MAX_SUPP_NETWORKS         WLAN_SCAN_PARAMS_MAX_SSID
+#define WMI_PNO_MAX_IE_LENGTH             WLAN_SCAN_PARAMS_MAX_IE_LEN
+
+/*size based of dot11 declaration without extra IEs as we will not carry those for PNO*/
+#define WMI_PNO_MAX_PB_REQ_SIZE    450
+
+#define WMI_PNO_24G_DEFAULT_CH     1
+#define WMI_PNO_5G_DEFAULT_CH      36
+
+#define WMI_ACTIVE_MAX_CHANNEL_TIME 40
+#define WMI_PASSIVE_MAX_CHANNEL_TIME   110
+
+/* SSID broadcast type */
+enum wmi_ssid_bcast_type {
+	BCAST_UNKNOWN      = 0,
+	BCAST_NORMAL       = 1,
+	BCAST_HIDDEN       = 2,
+};
+
+#define WMI_NLO_MAX_SSIDS    16
+#define WMI_NLO_MAX_CHAN     48
+
+#define WMI_NLO_CONFIG_STOP                             BIT(0)
+#define WMI_NLO_CONFIG_START                            BIT(1)
+#define WMI_NLO_CONFIG_RESET                            BIT(2)
+#define WMI_NLO_CONFIG_SLOW_SCAN                        BIT(4)
+#define WMI_NLO_CONFIG_FAST_SCAN                        BIT(5)
+#define WMI_NLO_CONFIG_SSID_HIDE_EN                     BIT(6)
+
+/* This bit is used to indicate if EPNO or supplicant PNO is enabled.
+ * Only one of them can be enabled at a given time
+ */
+#define WMI_NLO_CONFIG_ENLO                             BIT(7)
+#define WMI_NLO_CONFIG_SCAN_PASSIVE                     BIT(8)
+#define WMI_NLO_CONFIG_ENLO_RESET                       BIT(9)
+#define WMI_NLO_CONFIG_SPOOFED_MAC_IN_PROBE_REQ         BIT(10)
+#define WMI_NLO_CONFIG_RANDOM_SEQ_NO_IN_PROBE_REQ       BIT(11)
+#define WMI_NLO_CONFIG_ENABLE_IE_WHITELIST_IN_PROBE_REQ BIT(12)
+#define WMI_NLO_CONFIG_ENABLE_CNLO_RSSI_CONFIG          BIT(13)
+
+struct wmi_nlo_ssid_param {
+	u32 valid;
+	struct wmi_ssid ssid;
+} __packed;
+
+struct wmi_nlo_enc_param {
+	u32 valid;
+	u32 enc_type;
+} __packed;
+
+struct wmi_nlo_auth_param {
+	u32 valid;
+	u32 auth_type;
+} __packed;
+
+struct wmi_nlo_bcast_nw_param {
+	u32 valid;
+	u32 bcast_nw_type;
+} __packed;
+
+struct wmi_nlo_rssi_param {
+	u32 valid;
+	s32 rssi;
+} __packed;
+
+struct nlo_configured_parameters {
+	/* TLV tag and len;*/
+	u32 tlv_header;
+	struct wmi_nlo_ssid_param ssid;
+	struct wmi_nlo_enc_param enc_type;
+	struct wmi_nlo_auth_param auth_type;
+	struct wmi_nlo_rssi_param rssi_cond;
+
+	/* indicates if the SSID is hidden or not */
+	struct wmi_nlo_bcast_nw_param bcast_nw_type;
+} __packed;
+
+struct wmi_network_type {
+	struct wmi_ssid ssid;
+	u32 authentication;
+	u32 encryption;
+	u32 bcast_nw_type;
+	u8 channel_count;
+	u16 channels[WMI_PNO_MAX_NETW_CHANNELS_EX];
+	s32 rssi_threshold;
+};
+
+struct wmi_pno_scan_req {
+	u8 enable;
+	u8 vdev_id;
+	u8 uc_networks_count;
+	struct wmi_network_type a_networks[WMI_PNO_MAX_SUPP_NETWORKS];
+	u32 fast_scan_period;
+	u32 slow_scan_period;
+	u8 fast_scan_max_cycles;
+
+	bool do_passive_scan;
+
+	u32 delay_start_time;
+	u32 active_min_time;
+	u32 active_max_time;
+	u32 passive_min_time;
+	u32 passive_max_time;
+
+	/* mac address randomization attributes */
+	u32 enable_pno_scan_randomization;
+	u8 mac_addr[ETH_ALEN];
+	u8 mac_addr_mask[ETH_ALEN];
+};
+
+struct wmi_wow_nlo_config_cmd {
+	u32 tlv_header;
+	u32 flags;
+	u32 vdev_id;
+	u32 fast_scan_max_cycles;
+	u32 active_dwell_time;
+	u32 passive_dwell_time; /* PDT in msecs */
+	u32 probe_bundle_size;
+
+	/* ART = IRT */
+	u32 rest_time;
+
+	/* Max value that can be reached after SBM */
+	u32 max_rest_time;
+
+	/* SBM */
+	u32 scan_backoff_multiplier;
+
+	/* SCBM */
+	u32 fast_scan_period;
+
+	/* specific to windows */
+	u32 slow_scan_period;
+
+	u32 no_of_ssids;
+
+	u32 num_of_channels;
+
+	/* NLO scan start delay time in milliseconds */
+	u32 delay_start_time;
+
+	/* MAC Address to use in Probe Req as SA */
+	struct wmi_mac_addr mac_addr;
+
+	/* Mask on which MAC has to be randomized */
+	struct wmi_mac_addr mac_mask;
+
+	/* IE bitmap to use in Probe Req */
+	u32 ie_bitmap[8];
+
+	/* Number of vendor OUIs. In the TLV vendor_oui[] */
+	u32 num_vendor_oui;
+
+	/* Number of connected NLO band preferences */
+	u32 num_cnlo_band_pref;
+
+	/* The TLVs will follow.
+	 * nlo_configured_parameters nlo_list[];
+	 * u32 channel_list[num_of_channels];
+	 */
+} __packed;
+
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len);
@@ -5780,6 +5947,8 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 int ath11k_wmi_send_vdev_set_tpc_power(struct ath11k *ar,
 				       u32 vdev_id,
 				       struct ath11k_reg_tpc_power_info *param);
+int ath11k_wmi_wow_config_pno(struct ath11k *ar, u32 vdev_id,
+			      struct wmi_pno_scan_req  *pno_scan);
 int ath11k_wmi_wow_del_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id);
 int ath11k_wmi_wow_add_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id,
 			       const u8 *pattern, const u8 *mask,
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index 105a331..839c58e7 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -228,6 +228,100 @@ static void ath11k_wow_convert_8023_to_80211(struct cfg80211_pkt_pattern *new,
 	}
 }
 
+static int ath11k_wmi_pno_check_and_convert(struct ath11k *ar, u32 vdev_id,
+					    struct cfg80211_sched_scan_request *nd_config,
+					    struct wmi_pno_scan_req *pno)
+{
+	int i, j;
+	u8 ssid_len;
+
+	pno->enable = 1;
+	pno->vdev_id = vdev_id;
+	pno->uc_networks_count = nd_config->n_match_sets;
+
+	if (!pno->uc_networks_count ||
+	    pno->uc_networks_count > WMI_PNO_MAX_SUPP_NETWORKS)
+		return -EINVAL;
+
+	if (nd_config->n_channels > WMI_PNO_MAX_NETW_CHANNELS_EX)
+		return -EINVAL;
+
+	/* Filling per profile params */
+	for (i = 0; i < pno->uc_networks_count; i++) {
+		ssid_len = nd_config->match_sets[i].ssid.ssid_len;
+
+		if (ssid_len == 0 || ssid_len > 32)
+			return -EINVAL;
+
+		pno->a_networks[i].ssid.ssid_len = ssid_len;
+
+		memcpy(pno->a_networks[i].ssid.ssid,
+		       nd_config->match_sets[i].ssid.ssid,
+		       nd_config->match_sets[i].ssid.ssid_len);
+		pno->a_networks[i].authentication = 0;
+		pno->a_networks[i].encryption     = 0;
+		pno->a_networks[i].bcast_nw_type  = 0;
+
+		/*Copying list of valid channel into request */
+		pno->a_networks[i].channel_count = nd_config->n_channels;
+		pno->a_networks[i].rssi_threshold = nd_config->match_sets[i].rssi_thold;
+
+		for (j = 0; j < nd_config->n_channels; j++) {
+			pno->a_networks[i].channels[j] =
+					nd_config->channels[j]->center_freq;
+		}
+	}
+
+	/* set scan to passive if no SSIDs are specified in the request */
+	if (nd_config->n_ssids == 0)
+		pno->do_passive_scan = true;
+	else
+		pno->do_passive_scan = false;
+
+	for (i = 0; i < nd_config->n_ssids; i++) {
+		j = 0;
+		while (j < pno->uc_networks_count) {
+			if (pno->a_networks[j].ssid.ssid_len ==
+				nd_config->ssids[i].ssid_len &&
+			(memcmp(pno->a_networks[j].ssid.ssid,
+				nd_config->ssids[i].ssid,
+				pno->a_networks[j].ssid.ssid_len) == 0)) {
+				pno->a_networks[j].bcast_nw_type = BCAST_HIDDEN;
+				break;
+			}
+			j++;
+		}
+	}
+
+	if (nd_config->n_scan_plans == 2) {
+		pno->fast_scan_period = nd_config->scan_plans[0].interval * MSEC_PER_SEC;
+		pno->fast_scan_max_cycles = nd_config->scan_plans[0].iterations;
+		pno->slow_scan_period =
+			nd_config->scan_plans[1].interval * MSEC_PER_SEC;
+	} else if (nd_config->n_scan_plans == 1) {
+		pno->fast_scan_period = nd_config->scan_plans[0].interval * MSEC_PER_SEC;
+		pno->fast_scan_max_cycles = 1;
+		pno->slow_scan_period = nd_config->scan_plans[0].interval * MSEC_PER_SEC;
+	} else {
+		ath11k_warn(ar->ab, "Invalid number of scan plans %d !!",
+			    nd_config->n_scan_plans);
+	}
+
+	if (nd_config->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		/* enable mac randomization */
+		pno->enable_pno_scan_randomization = 1;
+		memcpy(pno->mac_addr, nd_config->mac_addr, ETH_ALEN);
+		memcpy(pno->mac_addr_mask, nd_config->mac_addr_mask, ETH_ALEN);
+	}
+
+	pno->delay_start_time = nd_config->delay;
+
+	/* Current FW does not support min-max range for dwell time */
+	pno->active_max_time = WMI_ACTIVE_MAX_CHANNEL_TIME;
+	pno->passive_max_time = WMI_PASSIVE_MAX_CHANNEL_TIME;
+	return 0;
+}
+
 static int ath11k_vif_wow_set_wakeups(struct ath11k_vif *arvif,
 				      struct cfg80211_wowlan *wowlan)
 {
@@ -261,6 +355,26 @@ static int ath11k_vif_wow_set_wakeups(struct ath11k_vif *arvif,
 
 		if (wowlan->magic_pkt)
 			__set_bit(WOW_MAGIC_PKT_RECVD_EVENT, &wow_mask);
+
+		if (wowlan->nd_config) {
+			struct wmi_pno_scan_req *pno;
+			int ret;
+
+			pno = kzalloc(sizeof(*pno), GFP_KERNEL);
+			if (!pno)
+				return -ENOMEM;
+
+			ar->nlo_enabled = true;
+
+			ret = ath11k_wmi_pno_check_and_convert(ar, arvif->vdev_id,
+							       wowlan->nd_config, pno);
+			if (!ret) {
+				ath11k_wmi_wow_config_pno(ar, arvif->vdev_id, pno);
+				__set_bit(WOW_NLO_DETECTED_EVENT, &wow_mask);
+			}
+
+			kfree(pno);
+		}
 		break;
 	default:
 		break;
@@ -348,6 +462,51 @@ static int ath11k_wow_set_wakeups(struct ath11k *ar,
 	return 0;
 }
 
+static int ath11k_vif_wow_clean_nlo(struct ath11k_vif *arvif)
+{
+	int ret = 0;
+	struct ath11k *ar = arvif->ar;
+
+	switch (arvif->vdev_type) {
+	case WMI_VDEV_TYPE_STA:
+		if (ar->nlo_enabled) {
+			struct wmi_pno_scan_req *pno;
+
+			pno = kzalloc(sizeof(*pno), GFP_KERNEL);
+			if (!pno)
+				return -ENOMEM;
+
+			pno->enable = 0;
+			ar->nlo_enabled = false;
+			ret = ath11k_wmi_wow_config_pno(ar, arvif->vdev_id, pno);
+			kfree(pno);
+		}
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static int ath11k_wow_nlo_cleanup(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		ret = ath11k_vif_wow_clean_nlo(arvif);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to clean nlo settings on vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
@@ -433,8 +592,14 @@ int ath11k_wow_op_resume(struct ieee80211_hw *hw)
 	ath11k_hif_irq_enable(ar->ab);
 
 	ret = ath11k_wow_wakeup(ar->ab);
-	if (ret)
+	if (ret) {
 		ath11k_warn(ar->ab, "failed to wakeup from wow: %d\n", ret);
+		goto exit;
+	}
+
+	ret = ath11k_wow_nlo_cleanup(ar);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to cleanup nlo: %d\n", ret);
 
 exit:
 	if (ret) {
@@ -472,6 +637,11 @@ int ath11k_wow_init(struct ath11k *ar)
 		ar->wow.wowlan_support.max_pkt_offset -= WOW_MAX_REDUCE;
 	}
 
+	if (test_bit(WMI_TLV_SERVICE_NLO, ar->wmi->wmi_ab->svc_map)) {
+		ar->wow.wowlan_support.flags |= WIPHY_WOWLAN_NET_DETECT;
+		ar->wow.wowlan_support.max_nd_match_sets = WMI_PNO_MAX_SUPP_NETWORKS;
+	}
+
 	ar->wow.max_num_patterns = ATH11K_WOW_PATTERNS;
 	ar->wow.wowlan_support.n_patterns = ar->wow.max_num_patterns;
 	ar->hw->wiphy->wowlan = &ar->wow.wowlan_support;
-- 
2.7.4

