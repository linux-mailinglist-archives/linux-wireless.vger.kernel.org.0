Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD04EE923
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 09:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbiDAHeV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 03:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245444AbiDAHeU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 03:34:20 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3664D25E326
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648798351; x=1680334351;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HMmnAuVHxB0SHxOsYdSiN2WhofspnprB2nUQMcpCgfA=;
  b=RZa+DTO4y8zekh/gVmhuwF6dRvT9t2iAd1C9XhVxpc12nXG6YJLIGWci
   eS3/o9LLXShWrLq1h6GpkTaszDBEx9fCYX0b2lAQ+skyDutXAQR8rgQoG
   K88tGloe7oZx5p+she6kg2W5mCo5jrIVglZFUc8y0oJRPYgqlfIMZPZt1
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 01 Apr 2022 00:32:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 00:32:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Apr 2022 00:32:30 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Apr 2022 00:32:29 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 2/2] ath11k: Add support for SAR
Date:   Fri, 1 Apr 2022 15:32:17 +0800
Message-ID: <20220401073217.1195130-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath11k assigns ath11k_mac_op_set_bios_sar_specs to ath11k_ops,
and this function is called when user space application
calls NL80211_CMD_SET_SAR_SPECS. ath11k also registers SAR
type and frequency ranges to wiphy so user space can query
SAR capabilities.

This feature is currently enabled for WCN6855.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-02431-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  6 +++
 drivers/net/wireless/ath/ath11k/hw.c   | 20 ++++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  2 +
 drivers/net/wireless/ath/ath11k/mac.c  | 66 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c  | 70 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h  | 27 ++++++++++
 6 files changed, 191 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 7f4462cf5787..41a57312d4e6 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -102,6 +102,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = false,
 		.dbr_debug_support = true,
 		.global_reset = false,
+		.bios_sar_capa = NULL,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -169,6 +170,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = false,
 		.dbr_debug_support = true,
 		.global_reset = false,
+		.bios_sar_capa = NULL,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -235,6 +237,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = true,
 		.dbr_debug_support = false,
 		.global_reset = true,
+		.bios_sar_capa = NULL,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -301,6 +304,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = false,
 		.dbr_debug_support = true,
 		.global_reset = false,
+		.bios_sar_capa = NULL,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -367,6 +371,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = true,
 		.dbr_debug_support = false,
 		.global_reset = true,
+		.bios_sar_capa = &ath11k_hw_sar_capa_wcn6855,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -432,6 +437,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.current_cc_support = true,
 		.dbr_debug_support = false,
 		.global_reset = true,
+		.bios_sar_capa = &ath11k_hw_sar_capa_wcn6855,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index d1b0e76d9ec2..46449a18b5cb 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -2154,3 +2154,23 @@ const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074 = {
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
 };
+
+static const struct cfg80211_sar_freq_ranges ath11k_hw_sar_freq_ranges_wcn6855[] = {
+	{.start_freq = 2402, .end_freq = 2482 },  /* 2G ch1~ch13 */
+	{.start_freq = 5150, .end_freq = 5250 },  /* 5G UNII-1 ch32~ch48 */
+	{.start_freq = 5250, .end_freq = 5725 },  /* 5G UNII-2 ch50~ch144 */
+	{.start_freq = 5725, .end_freq = 5810 },  /* 5G UNII-3 ch149~ch161 */
+	{.start_freq = 5815, .end_freq = 5895 },  /* 5G UNII-4 ch163~ch177 */
+	{.start_freq = 5925, .end_freq = 6165 },  /* 6G UNII-5 Ch1, Ch2 ~ Ch41 */
+	{.start_freq = 6165, .end_freq = 6425 },  /* 6G UNII-5 ch45~ch93 */
+	{.start_freq = 6425, .end_freq = 6525 },  /* 6G UNII-6 ch97~ch113 */
+	{.start_freq = 6525, .end_freq = 6705 },  /* 6G UNII-7 ch117~ch149 */
+	{.start_freq = 6705, .end_freq = 6875 },  /* 6G UNII-7 ch153~ch185 */
+	{.start_freq = 6875, .end_freq = 7125 },  /* 6G UNII-8 ch189~ch233 */
+};
+
+const struct cfg80211_sar_capa ath11k_hw_sar_capa_wcn6855 = {
+	.type = NL80211_SAR_TYPE_POWER,
+	.num_freq_ranges = (ARRAY_SIZE(ath11k_hw_sar_freq_ranges_wcn6855)),
+	.freq_ranges = ath11k_hw_sar_freq_ranges_wcn6855,
+};
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 44025bc5d082..29546d8de738 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -195,6 +195,7 @@ struct ath11k_hw_params {
 	bool current_cc_support;
 	bool dbr_debug_support;
 	bool global_reset;
+	const struct cfg80211_sar_capa *bios_sar_capa;
 };
 
 struct ath11k_hw_ops {
@@ -380,4 +381,5 @@ static inline const char *ath11k_bd_ie_type_str(enum ath11k_bd_ie_type type)
 	return "unknown";
 }
 
+extern const struct cfg80211_sar_capa ath11k_hw_sar_capa_wcn6855;
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 175a4ae752f3..2b243458ff5d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8273,6 +8273,67 @@ static void ath11k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
 	mutex_unlock(&ar->conf_mutex);
 }
 
+static int ath11k_mac_op_set_bios_sar_specs(struct ieee80211_hw *hw,
+					    const struct cfg80211_sar_specs *sar)
+{
+	struct ath11k *ar = hw->priv;
+	const struct cfg80211_sar_sub_specs *sspec = sar->sub_specs;
+	u8 *sar_tbl;
+	u32 i;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (!test_bit(WMI_TLV_SERVICE_BIOS_SAR_SUPPORT, ar->ab->wmi_ab.svc_map) ||
+	    !ar->ab->hw_params.bios_sar_capa) {
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	if (!sar || sar->type != NL80211_SAR_TYPE_POWER ||
+	    sar->num_sub_specs == 0) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	ret = ath11k_wmi_pdev_set_bios_geo_table_param(ar);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set geo table: %d\n", ret);
+		goto exit;
+	}
+
+	sar_tbl = kzalloc(BIOS_SAR_TABLE_LEN, GFP_KERNEL);
+	if (!sar_tbl) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	for (i = 0; i < sar->num_sub_specs; i++) {
+		if (sspec->freq_range_index >= (BIOS_SAR_TABLE_LEN >> 1)) {
+			ath11k_warn(ar->ab, "Ignore bad frequency index %u, max allowed %u\n",
+				    sspec->freq_range_index, BIOS_SAR_TABLE_LEN >> 1);
+			continue;
+		}
+
+		/* chain0 and chain1 share same power setting */
+		sar_tbl[sspec->freq_range_index] = sspec->power;
+		sar_tbl[sspec->freq_range_index + (BIOS_SAR_TABLE_LEN >> 1)] = sspec->power;
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "sar tbl[%d] = %d\n",
+			   sspec->freq_range_index, sar_tbl[sspec->freq_range_index]);
+		sspec++;
+	}
+
+	ret = ath11k_wmi_pdev_set_bios_sar_table_param(ar, sar_tbl);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to set sar power: %d", ret);
+
+	kfree(sar_tbl);
+exit:
+	mutex_unlock(&ar->conf_mutex);
+
+	return ret;
+}
+
 static const struct ieee80211_ops ath11k_ops = {
 	.tx				= ath11k_mac_op_tx,
 	.start                          = ath11k_mac_op_start,
@@ -8324,6 +8385,7 @@ static const struct ieee80211_ops ath11k_ops = {
 	.ipv6_addr_change = ath11k_mac_op_ipv6_changed,
 #endif
 
+	.set_sar_specs			= ath11k_mac_op_set_bios_sar_specs,
 };
 
 static void ath11k_mac_update_ch_list(struct ath11k *ar,
@@ -8746,6 +8808,10 @@ static int __ath11k_mac_register(struct ath11k *ar)
 		ieee80211_hw_set(ar->hw, SUPPORT_FAST_XMIT);
 	}
 
+	if (test_bit(WMI_TLV_SERVICE_BIOS_SAR_SUPPORT, ar->ab->wmi_ab.svc_map) &&
+	    ab->hw_params.bios_sar_capa)
+		ar->hw->wiphy->sar_capa = ab->hw_params.bios_sar_capa;
+
 	ret = ieee80211_register_hw(ar->hw);
 	if (ret) {
 		ath11k_err(ar->ab, "ieee80211 registration failed: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index a5876e0378fe..60e6e3a41453 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8883,3 +8883,73 @@ int ath11k_wmi_gtk_rekey_getinfo(struct ath11k *ar,
 		   arvif->vdev_id);
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
 }
+
+int ath11k_wmi_pdev_set_bios_sar_table_param(struct ath11k *ar, const u8 *sar_val)
+{	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_pdev_set_sar_table_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	u8 *buf_ptr;
+	u32 len, sar_len_aligned, rsvd_len_aligned;
+
+	sar_len_aligned = roundup(BIOS_SAR_TABLE_LEN, sizeof(u32));
+	rsvd_len_aligned = roundup(BIOS_SAR_RSVD1_LEN, sizeof(u32));
+	len = sizeof(*cmd) +
+	      TLV_HDR_SIZE + sar_len_aligned +
+	      TLV_HDR_SIZE + rsvd_len_aligned;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_sar_table_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->pdev_id = ar->pdev->pdev_id;
+	cmd->sar_len = BIOS_SAR_TABLE_LEN;
+	cmd->rsvd_len = BIOS_SAR_RSVD1_LEN;
+
+	buf_ptr = skb->data + sizeof(*cmd);
+	tlv = (struct wmi_tlv *) buf_ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
+		      FIELD_PREP(WMI_TLV_LEN, sar_len_aligned);
+	buf_ptr += TLV_HDR_SIZE;
+	memcpy(buf_ptr, sar_val, BIOS_SAR_TABLE_LEN);
+
+	buf_ptr += sar_len_aligned;
+	tlv = (struct wmi_tlv *) buf_ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
+		      FIELD_PREP(WMI_TLV_LEN, rsvd_len_aligned);
+
+	return ath11k_wmi_cmd_send(wmi, skb, WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID);
+}
+
+int ath11k_wmi_pdev_set_bios_geo_table_param(struct ath11k *ar)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_pdev_set_geo_table_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	u8 *buf_ptr;
+	u32 len, rsvd_len_aligned;
+
+	rsvd_len_aligned = roundup(BIOS_SAR_RSVD2_LEN, sizeof(u32));
+	len = sizeof(*cmd) + TLV_HDR_SIZE + rsvd_len_aligned;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_geo_table_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->pdev_id = ar->pdev->pdev_id;
+	cmd->rsvd_len = BIOS_SAR_RSVD2_LEN;
+
+	buf_ptr = skb->data + sizeof(*cmd);
+	tlv = (struct wmi_tlv *) buf_ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
+		      FIELD_PREP(WMI_TLV_LEN, rsvd_len_aligned);
+
+	return ath11k_wmi_cmd_send(wmi, skb, WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index da9b0a90fd70..c9c6faee45c1 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -285,6 +285,11 @@ enum wmi_tlv_cmd_id {
 	WMI_PDEV_SET_SRG_OBSS_BSSID_ENABLE_BITMAP_CMDID,
 	WMI_PDEV_SET_NON_SRG_OBSS_COLOR_ENABLE_BITMAP_CMDID,
 	WMI_PDEV_SET_NON_SRG_OBSS_BSSID_ENABLE_BITMAP_CMDID,
+	WMI_PDEV_GET_TPC_STATS_CMDID,
+	WMI_PDEV_ENABLE_DURATION_BASED_TX_MODE_SELECTION_CMDID,
+	WMI_PDEV_GET_DPD_STATUS_CMDID,
+	WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID,
+	WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID,
 	WMI_VDEV_CREATE_CMDID = WMI_TLV_CMD(WMI_GRP_VDEV),
 	WMI_VDEV_DELETE_CMDID,
 	WMI_VDEV_START_REQUEST_CMDID,
@@ -1859,6 +1864,8 @@ enum wmi_tlv_tag {
 	WMI_TAG_PDEV_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
 	WMI_TAG_PDEV_NON_SRG_OBSS_COLOR_ENABLE_BITMAP_CMD,
 	WMI_TAG_PDEV_NON_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
+	WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD = 0x3D8,
+	WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD,
 	WMI_TAG_MAX
 };
 
@@ -2087,6 +2094,7 @@ enum wmi_tlv_service {
 
 	/* The second 128 bits */
 	WMI_MAX_EXT_SERVICE = 256,
+	WMI_TLV_SERVICE_BIOS_SAR_SUPPORT = 326,
 
 	/* The third 128 bits */
 	WMI_MAX_EXT2_SERVICE = 384
@@ -5890,6 +5898,23 @@ struct wmi_gtk_rekey_offload_cmd {
 	u8 replay_ctr[GTK_REPLAY_COUNTER_BYTES];
 } __packed;
 
+#define BIOS_SAR_TABLE_LEN	(22)
+#define BIOS_SAR_RSVD1_LEN	(6)
+#define BIOS_SAR_RSVD2_LEN	(18)
+
+struct wmi_pdev_set_sar_table_cmd {
+	u32 tlv_header;
+	u32 pdev_id;
+	u32 sar_len;
+	u32 rsvd_len;
+} __packed;
+
+struct wmi_pdev_set_geo_table_cmd {
+	u32 tlv_header;
+	u32 pdev_id;
+	u32 rsvd_len;
+} __packed;
+
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len);
@@ -6068,5 +6093,7 @@ int ath11k_wmi_gtk_rekey_offload(struct ath11k *ar,
 				 struct ath11k_vif *arvif, bool enable);
 int ath11k_wmi_gtk_rekey_getinfo(struct ath11k *ar,
 				 struct ath11k_vif *arvif);
+int ath11k_wmi_pdev_set_bios_sar_table_param(struct ath11k *ar, const u8 *sar_val);
+int ath11k_wmi_pdev_set_bios_geo_table_param(struct ath11k *ar);
 
 #endif
-- 
2.25.1

