Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38195B6731
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 07:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiIMFPw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 01:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiIMFPp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 01:15:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD44D4BA43
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 22:15:42 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D4ervR003047;
        Tue, 13 Sep 2022 05:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=n4eSub/WrfXFh2LuDLEGn23WYHWu6zc/2QFSwAe+oms=;
 b=cNk+4dGXJy6U9raSGhKmtL5C9Ob24lu0H/z3EucoeAvcxR5sK2iHMveH96/VU+Bz/xXG
 o1t0a7ASKC6VGRcqPhDbM1muqSZK7t9aspTsYw18zGiSIVkt4XjAgI5xEaR7otioNQx4
 8zZ3zlA5vnFCsUSLqqiqEql4DNax8wpIaVSytcsC4km7EclKR9Nxt2kBK3t8hsg4t4kx
 GPVuhPBE757pE0nAIM44WkOLrEKwwhKAGV3AF6//qgO29tuKjVYafqh4q/BqVau7Ie/L
 Eta4ibQ09dtOZ3HJcc1xgsHLGLtCth8fVe5+/2M13Rz4hteS3lCAgcDtSNJjRUiZMt9Q Tg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk63641x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D5Faet028435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:36 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 22:15:34 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3 01/15] wifi: ath11k: Add support to parse new wmi event for 6 GHz regulatory
Date:   Tue, 13 Sep 2022 01:15:04 -0400
Message-ID: <20220913051518.23051-2-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220913051518.23051-1-quic_wgong@quicinc.com>
References: <20220913051518.23051-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FRXadEHqx-OGMQvzjj1GUjRXgoYLffnx
X-Proofpoint-ORIG-GUID: FRXadEHqx-OGMQvzjj1GUjRXgoYLffnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209130023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to support different power levels of 6 GHz AP and client, new
wmi event for regulatory was added in firmware(WMI_REG_CHAN_LIST_CC_EXT_EVENTID)
to provide new parameters required for 6 GHz regulatory rules.

firmware advertises its capability of handling new event in wmi service ready
event. Based on that, host needs to set host_service_flags in wmi init
command to indicate that host supports processing of new wmi event.
Based on advertised host capability, firmware decides to send old event
(WMI_REG_CHAN_LIST_CC_EVENTID) or new event(WMI_REG_CHAN_LIST_CC_EXT_EVENTID).

Add support for parsing 2.4 GHz/5 GHz/6 GHz reg rules and other parameters from
WMI_REG_CHAN_LIST_CC_EXT_EVENTID, to populate the channel lists.
Since 6 GHz requires additional power value fields(PSD info), update
reg rule parsing function.

Signed-off-by: Lavanya Suresh <quic_lavaks@quicinc.com>
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |   6 +
 drivers/net/wireless/ath/ath11k/hw.c   |   6 +
 drivers/net/wireless/ath/ath11k/hw.h   |   3 +
 drivers/net/wireless/ath/ath11k/reg.c  |  37 ++-
 drivers/net/wireless/ath/ath11k/wmi.c  | 378 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h  | 118 ++++++++
 6 files changed, 537 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 293563b3f784..cbfae45e600d 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -88,6 +88,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.supports_regdb = false,
+		.supports_cc_ext = false,
 		.fix_l1ss = true,
 		.credit_flow = false,
 		.max_tx_ring = DP_TCL_NUM_RING_MAX,
@@ -152,6 +153,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.supports_regdb = false,
+		.supports_cc_ext = false,
 		.fix_l1ss = true,
 		.credit_flow = false,
 		.max_tx_ring = DP_TCL_NUM_RING_MAX,
@@ -215,6 +217,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.supports_regdb = true,
+		.supports_cc_ext = false,
 		.fix_l1ss = true,
 		.credit_flow = true,
 		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
@@ -278,6 +281,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
 		.supports_regdb = false,
+		.supports_cc_ext = false,
 		.fix_l1ss = true,
 		.credit_flow = false,
 		.max_tx_ring = DP_TCL_NUM_RING_MAX,
@@ -341,6 +345,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
 		.supports_regdb = true,
+		.supports_cc_ext = true,
 		.fix_l1ss = false,
 		.credit_flow = true,
 		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
@@ -403,6 +408,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
 		.supports_regdb = true,
+		.supports_cc_ext = true,
 		.fix_l1ss = false,
 		.credit_flow = true,
 		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 3b0fdc1a6b3f..d503e8a73d32 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -801,6 +801,12 @@ static u16 ath11k_hw_wcn6855_mpdu_info_get_peerid(u8 *tlv_data)
 	return peer_id;
 }
 
+bool ath11k_hw_supports_cc_ext(struct ath11k_base *ab)
+{
+	return ab->hw_params.supports_cc_ext &&
+		test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT, ab->wmi_ab.svc_map);
+}
+
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 29934b36c14e..b57cab2b0c7b 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -183,6 +183,7 @@ struct ath11k_hw_params {
 	bool supports_suspend;
 	u32 hal_desc_sz;
 	bool supports_regdb;
+	bool supports_cc_ext;
 	bool fix_l1ss;
 	bool credit_flow;
 	u8 max_tx_ring;
@@ -276,6 +277,8 @@ static inline int ath11k_hw_mac_id_to_srng_id(struct ath11k_hw_params *hw,
 	return 0;
 }
 
+bool ath11k_hw_supports_cc_ext(struct ath11k_base *ab);
+
 struct ath11k_fw_ie {
 	__le32 id;
 	__le32 len;
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 1f8a81987187..09825a41a284 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -589,7 +589,7 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 {
 	struct ieee80211_regdomain *tmp_regd, *default_regd, *new_regd = NULL;
 	struct cur_reg_rule *reg_rule;
-	u8 i = 0, j = 0;
+	u8 i = 0, j = 0, k = 0;
 	u8 num_rules;
 	u16 max_bw;
 	u32 flags;
@@ -597,6 +597,13 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 
 	num_rules = reg_info->num_5g_reg_rules + reg_info->num_2g_reg_rules;
 
+	/* FIXME: Currently taking reg rules for 6 GHz only from Indoor AP mode list.
+	 * This can be updated to choose the combination dynamically based on AP
+	 * type and client type, after complete 6 GHz regulatory support is added.
+	 */
+	if (reg_info->is_ext_reg_event)
+		num_rules += reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP];
+
 	if (!num_rules)
 		goto ret;
 
@@ -642,6 +649,13 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 			 * per other BW rule flags we pass from here
 			 */
 			flags = NL80211_RRF_AUTO_BW;
+		} else if (reg_info->is_ext_reg_event &&
+			   reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP] &&
+			   (k < reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP])) {
+			reg_rule = reg_info->reg_rules_6g_ap_ptr[WMI_REG_INDOOR_AP] + k++;
+			max_bw = min_t(u16, reg_rule->max_bw,
+				       reg_info->max_bw_6g_ap[WMI_REG_INDOOR_AP]);
+			flags = NL80211_RRF_AUTO_BW;
 		} else {
 			break;
 		}
@@ -669,12 +683,21 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 			continue;
 		}
 
-		ath11k_dbg(ab, ATH11K_DBG_REG,
-			   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
-			   i + 1, reg_rule->start_freq, reg_rule->end_freq,
-			   max_bw, reg_rule->ant_gain, reg_rule->reg_power,
-			   tmp_regd->reg_rules[i].dfs_cac_ms,
-			   flags);
+		if (reg_info->is_ext_reg_event) {
+			ath11k_dbg(ab, ATH11K_DBG_REG,
+				   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d) (%d, %d)\n",
+				   i + 1, reg_rule->start_freq, reg_rule->end_freq,
+				   max_bw, reg_rule->ant_gain, reg_rule->reg_power,
+				   tmp_regd->reg_rules[i].dfs_cac_ms, flags,
+				   reg_rule->psd_flag, reg_rule->psd_eirp);
+		} else {
+			ath11k_dbg(ab, ATH11K_DBG_REG,
+				   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
+				   i + 1, reg_rule->start_freq, reg_rule->end_freq,
+				   max_bw, reg_rule->ant_gain, reg_rule->reg_power,
+				   tmp_regd->reg_rules[i].dfs_cac_ms,
+				   flags);
+		}
 	}
 
 	tmp_regd->n_reg_rules = i;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index bfb3effc161d..5f389aa18ebc 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -104,6 +104,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		= { .min_len = sizeof(struct wmi_vdev_stopped_event) },
 	[WMI_TAG_REG_CHAN_LIST_CC_EVENT]
 		= { .min_len = sizeof(struct wmi_reg_chan_list_cc_event) },
+	[WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT]
+		= { .min_len = sizeof(struct wmi_reg_chan_list_cc_ext_event) },
 	[WMI_TAG_MGMT_RX_HDR]
 		= { .min_len = sizeof(struct wmi_mgmt_rx_hdr) },
 	[WMI_TAG_MGMT_TX_COMPL_EVENT]
@@ -3738,6 +3740,10 @@ ath11k_wmi_copy_resource_config(struct wmi_resource_config *wmi_cfg,
 	wmi_cfg->sched_params = tg_cfg->sched_params;
 	wmi_cfg->twt_ap_pdev_count = tg_cfg->twt_ap_pdev_count;
 	wmi_cfg->twt_ap_sta_count = tg_cfg->twt_ap_sta_count;
+	wmi_cfg->host_service_flags &=
+		~(1 << WMI_CFG_HOST_SERVICE_FLAG_REG_CC_EXT);
+	wmi_cfg->host_service_flags |= tg_cfg->is_reg_cc_ext_event_supported <<
+				       WMI_CFG_HOST_SERVICE_FLAG_REG_CC_EXT;
 }
 
 static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
@@ -3956,6 +3962,9 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 
 	ab->hw_params.hw_ops->wmi_init_config(ab, &config);
 
+	if (ath11k_hw_supports_cc_ext(ab))
+		config.is_reg_cc_ext_event_supported = 1;
+
 	memcpy(&wmi_sc->wlan_resource_config, &config, sizeof(config));
 
 	init_param.res_cfg = &wmi_sc->wlan_resource_config;
@@ -4772,6 +4781,8 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 	else if (chan_list_event_hdr->status_code == WMI_REG_SET_CC_STATUS_FAIL)
 		reg_info->status_code = REG_SET_CC_STATUS_FAIL;
 
+	reg_info->is_ext_reg_event = false;
+
 	reg_info->min_bw_2g = chan_list_event_hdr->min_bw_2g;
 	reg_info->max_bw_2g = chan_list_event_hdr->max_bw_2g;
 	reg_info->min_bw_5g = chan_list_event_hdr->min_bw_5g;
@@ -4822,6 +4833,348 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 	return 0;
 }
 
+static struct cur_reg_rule
+*create_ext_reg_rules_from_wmi(u32 num_reg_rules,
+			       const struct wmi_regulatory_ext_rule *wmi_reg_rule)
+{
+	struct cur_reg_rule *reg_rule_ptr;
+	u32 count;
+
+	reg_rule_ptr =  kcalloc(num_reg_rules, sizeof(*reg_rule_ptr), GFP_ATOMIC);
+
+	if (!reg_rule_ptr)
+		return NULL;
+
+	for (count = 0; count < num_reg_rules; count++) {
+		reg_rule_ptr[count].start_freq =
+			FIELD_GET(REG_RULE_START_FREQ,
+				  wmi_reg_rule[count].freq_info);
+		reg_rule_ptr[count].end_freq =
+			FIELD_GET(REG_RULE_END_FREQ,
+				  wmi_reg_rule[count].freq_info);
+		reg_rule_ptr[count].max_bw =
+			FIELD_GET(REG_RULE_MAX_BW,
+				  wmi_reg_rule[count].bw_pwr_info);
+		reg_rule_ptr[count].reg_power =
+			FIELD_GET(REG_RULE_REG_PWR,
+				  wmi_reg_rule[count].bw_pwr_info);
+		reg_rule_ptr[count].ant_gain =
+			FIELD_GET(REG_RULE_ANT_GAIN,
+				  wmi_reg_rule[count].bw_pwr_info);
+		reg_rule_ptr[count].flags =
+			FIELD_GET(REG_RULE_FLAGS,
+				  wmi_reg_rule[count].flag_info);
+		reg_rule_ptr[count].psd_flag =
+			FIELD_GET(REG_RULE_PSD_INFO,
+				  wmi_reg_rule[count].psd_power_info);
+		reg_rule_ptr[count].psd_eirp =
+			FIELD_GET(REG_RULE_PSD_EIRP,
+				  wmi_reg_rule[count].psd_power_info);
+	}
+
+	return reg_rule_ptr;
+}
+
+static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
+						   struct sk_buff *skb,
+						   struct cur_regulatory_info *reg_info)
+{
+	const void **tb;
+	const struct wmi_reg_chan_list_cc_ext_event *ext_chan_list_event_hdr;
+	const struct wmi_regulatory_ext_rule *ext_wmi_reg_rule;
+	u32 num_2g_reg_rules, num_5g_reg_rules;
+	u32 num_6g_reg_rules_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u32 num_6g_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u32 total_reg_rules = 0;
+	int ret, i, j;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "processing regulatory ext channel list\n");
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return ret;
+	}
+
+	ext_chan_list_event_hdr = tb[WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT];
+	if (!ext_chan_list_event_hdr) {
+		ath11k_warn(ab, "failed to fetch reg chan list ext update ev\n");
+		kfree(tb);
+		return -EPROTO;
+	}
+
+	reg_info->num_2g_reg_rules = ext_chan_list_event_hdr->num_2g_reg_rules;
+	reg_info->num_5g_reg_rules = ext_chan_list_event_hdr->num_5g_reg_rules;
+	reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP] =
+			ext_chan_list_event_hdr->num_6g_reg_rules_ap_lpi;
+	reg_info->num_6g_reg_rules_ap[WMI_REG_STANDARD_POWER_AP] =
+			ext_chan_list_event_hdr->num_6g_reg_rules_ap_sp;
+	reg_info->num_6g_reg_rules_ap[WMI_REG_VERY_LOW_POWER_AP] =
+			ext_chan_list_event_hdr->num_6g_reg_rules_ap_vlp;
+
+	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
+		reg_info->num_6g_reg_rules_client[WMI_REG_INDOOR_AP][i] =
+			ext_chan_list_event_hdr->num_6g_reg_rules_client_lpi[i];
+		reg_info->num_6g_reg_rules_client[WMI_REG_STANDARD_POWER_AP][i] =
+			ext_chan_list_event_hdr->num_6g_reg_rules_client_sp[i];
+		reg_info->num_6g_reg_rules_client[WMI_REG_VERY_LOW_POWER_AP][i] =
+			ext_chan_list_event_hdr->num_6g_reg_rules_client_vlp[i];
+	}
+
+	num_2g_reg_rules = reg_info->num_2g_reg_rules;
+	total_reg_rules += num_2g_reg_rules;
+	num_5g_reg_rules = reg_info->num_5g_reg_rules;
+	total_reg_rules += num_5g_reg_rules;
+
+	if ((num_2g_reg_rules > MAX_REG_RULES) || (num_5g_reg_rules > MAX_REG_RULES)) {
+		ath11k_warn(ab, "Num reg rules for 2.4 GHz/5 GHz exceeds max limit (num_2g_reg_rules: %d num_5g_reg_rules: %d max_rules: %d)\n",
+			    num_2g_reg_rules, num_5g_reg_rules, MAX_REG_RULES);
+		kfree(tb);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
+		num_6g_reg_rules_ap[i] = reg_info->num_6g_reg_rules_ap[i];
+
+		if (num_6g_reg_rules_ap[i] > MAX_6G_REG_RULES) {
+			ath11k_warn(ab, "Num 6 GHz reg rules for AP mode(%d) exceeds max limit (num_6g_reg_rules_ap: %d, max_rules: %d)\n",
+				    i, num_6g_reg_rules_ap[i], MAX_6G_REG_RULES);
+			kfree(tb);
+			return -EINVAL;
+		}
+
+		total_reg_rules += num_6g_reg_rules_ap[i];
+	}
+
+	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
+		num_6g_client[WMI_REG_INDOOR_AP][i] =
+				reg_info->num_6g_reg_rules_client[WMI_REG_INDOOR_AP][i];
+		total_reg_rules += num_6g_client[WMI_REG_INDOOR_AP][i];
+
+		num_6g_client[WMI_REG_STANDARD_POWER_AP][i] =
+			reg_info->num_6g_reg_rules_client[WMI_REG_STANDARD_POWER_AP][i];
+		total_reg_rules += num_6g_client[WMI_REG_STANDARD_POWER_AP][i];
+
+		num_6g_client[WMI_REG_VERY_LOW_POWER_AP][i] =
+			reg_info->num_6g_reg_rules_client[WMI_REG_VERY_LOW_POWER_AP][i];
+		total_reg_rules += num_6g_client[WMI_REG_VERY_LOW_POWER_AP][i];
+
+		if ((num_6g_client[WMI_REG_INDOOR_AP][i] > MAX_6G_REG_RULES) ||
+		    (num_6g_client[WMI_REG_STANDARD_POWER_AP][i] > MAX_6G_REG_RULES) ||
+		    (num_6g_client[WMI_REG_VERY_LOW_POWER_AP][i] >  MAX_6G_REG_RULES)) {
+			ath11k_warn(ab,
+				    "Num 6 GHz client reg rules exceeds max limit, for client(type: %d)\n",
+				    i);
+			kfree(tb);
+			return -EINVAL;
+		}
+	}
+
+	if (!total_reg_rules) {
+		ath11k_warn(ab, "No reg rules available\n");
+		kfree(tb);
+		return -EINVAL;
+	}
+
+	memcpy(reg_info->alpha2, &ext_chan_list_event_hdr->alpha2,
+	       REG_ALPHA2_LEN);
+
+	/* FIXME: Currently firmware includes 6 GHz reg rule also in 5 GHz rule
+	 * list for country US.
+	 * Having same 6 GHz reg rule in 5 GHz and 6 GHz rules list causes
+	 * intersect check to be true, and same rules will be shown
+	 * multiple times in iw cmd. So added hack below to avoid
+	 * parsing 6 GHz rule from 5 GHz reg rule list, and this can be
+	 * removed later, after firmware updates to remove 6 GHz reg rule
+	 * from 5 GHz rules list.
+	 */
+	if (memcmp(reg_info->alpha2, "US", 2) == 0) {
+		reg_info->num_5g_reg_rules = REG_US_5G_NUM_REG_RULES;
+		num_5g_reg_rules = reg_info->num_5g_reg_rules;
+	}
+
+	reg_info->dfs_region = ext_chan_list_event_hdr->dfs_region;
+	reg_info->phybitmap = ext_chan_list_event_hdr->phybitmap;
+	reg_info->num_phy = ext_chan_list_event_hdr->num_phy;
+	reg_info->phy_id = ext_chan_list_event_hdr->phy_id;
+	reg_info->ctry_code = ext_chan_list_event_hdr->country_id;
+	reg_info->reg_dmn_pair = ext_chan_list_event_hdr->domain_code;
+
+	switch (ext_chan_list_event_hdr->status_code) {
+	case WMI_REG_SET_CC_STATUS_PASS:
+		reg_info->status_code = REG_SET_CC_STATUS_PASS;
+		break;
+	case WMI_REG_CURRENT_ALPHA2_NOT_FOUND:
+		reg_info->status_code = REG_CURRENT_ALPHA2_NOT_FOUND;
+		break;
+	case WMI_REG_INIT_ALPHA2_NOT_FOUND:
+		reg_info->status_code = REG_INIT_ALPHA2_NOT_FOUND;
+		break;
+	case WMI_REG_SET_CC_CHANGE_NOT_ALLOWED:
+		reg_info->status_code = REG_SET_CC_CHANGE_NOT_ALLOWED;
+		break;
+	case WMI_REG_SET_CC_STATUS_NO_MEMORY:
+		reg_info->status_code = REG_SET_CC_STATUS_NO_MEMORY;
+		break;
+	case WMI_REG_SET_CC_STATUS_FAIL:
+		reg_info->status_code = REG_SET_CC_STATUS_FAIL;
+		break;
+	}
+
+	reg_info->is_ext_reg_event = true;
+
+	reg_info->min_bw_2g = ext_chan_list_event_hdr->min_bw_2g;
+	reg_info->max_bw_2g = ext_chan_list_event_hdr->max_bw_2g;
+	reg_info->min_bw_5g = ext_chan_list_event_hdr->min_bw_5g;
+	reg_info->max_bw_5g = ext_chan_list_event_hdr->max_bw_5g;
+	reg_info->min_bw_6g_ap[WMI_REG_INDOOR_AP] =
+			ext_chan_list_event_hdr->min_bw_6g_ap_lpi;
+	reg_info->max_bw_6g_ap[WMI_REG_INDOOR_AP] =
+			 ext_chan_list_event_hdr->max_bw_6g_ap_lpi;
+	reg_info->min_bw_6g_ap[WMI_REG_STANDARD_POWER_AP] =
+			ext_chan_list_event_hdr->min_bw_6g_ap_sp;
+	reg_info->max_bw_6g_ap[WMI_REG_STANDARD_POWER_AP] =
+			ext_chan_list_event_hdr->max_bw_6g_ap_sp;
+	reg_info->min_bw_6g_ap[WMI_REG_VERY_LOW_POWER_AP] =
+			ext_chan_list_event_hdr->min_bw_6g_ap_vlp;
+	reg_info->max_bw_6g_ap[WMI_REG_VERY_LOW_POWER_AP] =
+			ext_chan_list_event_hdr->max_bw_6g_ap_vlp;
+
+	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
+		reg_info->min_bw_6g_client[WMI_REG_INDOOR_AP][i] =
+				ext_chan_list_event_hdr->min_bw_6g_client_lpi[i];
+		reg_info->max_bw_6g_client[WMI_REG_INDOOR_AP][i] =
+				ext_chan_list_event_hdr->max_bw_6g_client_lpi[i];
+		reg_info->min_bw_6g_client[WMI_REG_STANDARD_POWER_AP][i] =
+				ext_chan_list_event_hdr->min_bw_6g_client_sp[i];
+		reg_info->max_bw_6g_client[WMI_REG_STANDARD_POWER_AP][i] =
+				ext_chan_list_event_hdr->max_bw_6g_client_sp[i];
+		reg_info->min_bw_6g_client[WMI_REG_VERY_LOW_POWER_AP][i] =
+				ext_chan_list_event_hdr->min_bw_6g_client_vlp[i];
+		reg_info->max_bw_6g_client[WMI_REG_VERY_LOW_POWER_AP][i] =
+				ext_chan_list_event_hdr->max_bw_6g_client_vlp[i];
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "%s:cc_ext %s dsf %d BW: min_2g %d max_2g %d min_5g %d max_5g %d",
+		   __func__, reg_info->alpha2, reg_info->dfs_region,
+		   reg_info->min_bw_2g, reg_info->max_bw_2g,
+		   reg_info->min_bw_5g, reg_info->max_bw_5g);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "num_2g_reg_rules %d num_5g_reg_rules %d",
+		   num_2g_reg_rules, num_5g_reg_rules);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "num_6g_reg_rules_ap_lpi: %d num_6g_reg_rules_ap_sp: %d num_6g_reg_rules_ap_vlp: %d",
+		   num_6g_reg_rules_ap[WMI_REG_INDOOR_AP],
+		   num_6g_reg_rules_ap[WMI_REG_STANDARD_POWER_AP],
+		   num_6g_reg_rules_ap[WMI_REG_VERY_LOW_POWER_AP]);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "6 GHz Regular client: num_6g_reg_rules_lpi: %d num_6g_reg_rules_sp: %d num_6g_reg_rules_vlp: %d",
+		   num_6g_client[WMI_REG_INDOOR_AP][WMI_REG_DEFAULT_CLIENT],
+		   num_6g_client[WMI_REG_STANDARD_POWER_AP][WMI_REG_DEFAULT_CLIENT],
+		   num_6g_client[WMI_REG_VERY_LOW_POWER_AP][WMI_REG_DEFAULT_CLIENT]);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "6 GHz Subordinate client: num_6g_reg_rules_lpi: %d num_6g_reg_rules_sp: %d num_6g_reg_rules_vlp: %d",
+		   num_6g_client[WMI_REG_INDOOR_AP][WMI_REG_SUBORDINATE_CLIENT],
+		   num_6g_client[WMI_REG_STANDARD_POWER_AP][WMI_REG_SUBORDINATE_CLIENT],
+		   num_6g_client[WMI_REG_VERY_LOW_POWER_AP][WMI_REG_SUBORDINATE_CLIENT]);
+
+	ext_wmi_reg_rule = tb[WMI_TAG_ARRAY_STRUCT];
+
+	if (num_2g_reg_rules) {
+		reg_info->reg_rules_2g_ptr =
+			create_ext_reg_rules_from_wmi(num_2g_reg_rules,
+						      ext_wmi_reg_rule);
+
+		if (!reg_info->reg_rules_2g_ptr) {
+			kfree(tb);
+			ath11k_warn(ab, "Unable to Allocate memory for 2g rules\n");
+			return -ENOMEM;
+		}
+	}
+
+	if (num_5g_reg_rules) {
+		ext_wmi_reg_rule += num_2g_reg_rules;
+		reg_info->reg_rules_5g_ptr =
+			create_ext_reg_rules_from_wmi(num_5g_reg_rules,
+						      ext_wmi_reg_rule);
+
+		if (!reg_info->reg_rules_5g_ptr) {
+			kfree(tb);
+			ath11k_warn(ab, "Unable to Allocate memory for 5g rules\n");
+			return -ENOMEM;
+		}
+	}
+
+	ext_wmi_reg_rule += num_5g_reg_rules;
+
+	for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
+		reg_info->reg_rules_6g_ap_ptr[i] =
+			create_ext_reg_rules_from_wmi(num_6g_reg_rules_ap[i],
+						      ext_wmi_reg_rule);
+
+		if (!reg_info->reg_rules_6g_ap_ptr[i]) {
+			kfree(tb);
+			ath11k_warn(ab, "Unable to Allocate memory for 6 GHz ap rules\n");
+			return -ENOMEM;
+		}
+
+		ext_wmi_reg_rule += num_6g_reg_rules_ap[i];
+	}
+
+	for (j = 0; j < WMI_REG_CURRENT_MAX_AP_TYPE; j++) {
+		for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
+			reg_info->reg_rules_6g_client_ptr[j][i] =
+				create_ext_reg_rules_from_wmi(num_6g_client[j][i],
+							      ext_wmi_reg_rule);
+
+			if (!reg_info->reg_rules_6g_client_ptr[j][i]) {
+				kfree(tb);
+				ath11k_warn(ab, "Unable to Allocate memory for 6 GHz client rules\n");
+				return -ENOMEM;
+			}
+
+			ext_wmi_reg_rule += num_6g_client[j][i];
+		}
+	}
+
+	reg_info->client_type = ext_chan_list_event_hdr->client_type;
+	reg_info->rnr_tpe_usable = ext_chan_list_event_hdr->rnr_tpe_usable;
+	reg_info->unspecified_ap_usable =
+			ext_chan_list_event_hdr->unspecified_ap_usable;
+	reg_info->domain_code_6g_ap[WMI_REG_INDOOR_AP] =
+			ext_chan_list_event_hdr->domain_code_6g_ap_lpi;
+	reg_info->domain_code_6g_ap[WMI_REG_STANDARD_POWER_AP] =
+			ext_chan_list_event_hdr->domain_code_6g_ap_sp;
+	reg_info->domain_code_6g_ap[WMI_REG_VERY_LOW_POWER_AP] =
+			ext_chan_list_event_hdr->domain_code_6g_ap_vlp;
+
+	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
+		reg_info->domain_code_6g_client[WMI_REG_INDOOR_AP][i] =
+				ext_chan_list_event_hdr->domain_code_6g_client_lpi[i];
+		reg_info->domain_code_6g_client[WMI_REG_STANDARD_POWER_AP][i] =
+				ext_chan_list_event_hdr->domain_code_6g_client_sp[i];
+		reg_info->domain_code_6g_client[WMI_REG_VERY_LOW_POWER_AP][i] =
+				ext_chan_list_event_hdr->domain_code_6g_client_vlp[i];
+	}
+
+	reg_info->domain_code_6g_super_id =
+			ext_chan_list_event_hdr->domain_code_6g_super_id;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "6 GHz client_type: %d domain_code_6g_super_id: %d",
+		   reg_info->client_type, reg_info->domain_code_6g_super_id);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "processed regulatory ext channel list\n");
+
+	kfree(tb);
+	return 0;
+}
+
 static int ath11k_pull_peer_del_resp_ev(struct ath11k_base *ab, struct sk_buff *skb,
 					struct wmi_peer_delete_resp_event *peer_del_resp)
 {
@@ -6249,12 +6602,14 @@ static bool ath11k_reg_is_world_alpha(char *alpha)
 	return false;
 }
 
-static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *skb)
+static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
+				      struct sk_buff *skb,
+				      enum wmi_reg_chan_list_cmd_type id)
 {
 	struct cur_regulatory_info *reg_info = NULL;
 	struct ieee80211_regdomain *regd = NULL;
 	bool intersect = false;
-	int ret = 0, pdev_idx;
+	int ret = 0, pdev_idx, i, j;
 	struct ath11k *ar;
 
 	reg_info = kzalloc(sizeof(*reg_info), GFP_ATOMIC);
@@ -6263,7 +6618,11 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *sk
 		goto fallback;
 	}
 
-	ret = ath11k_pull_reg_chan_list_update_ev(ab, skb, reg_info);
+	if (id == WMI_REG_CHAN_LIST_CC_ID)
+		ret = ath11k_pull_reg_chan_list_update_ev(ab, skb, reg_info);
+	else
+		ret = ath11k_pull_reg_chan_list_ext_update_ev(ab, skb, reg_info);
+
 	if (ret) {
 		ath11k_warn(ab, "failed to extract regulatory info from received event\n");
 		goto fallback;
@@ -6365,6 +6724,14 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *sk
 	if (reg_info) {
 		kfree(reg_info->reg_rules_2g_ptr);
 		kfree(reg_info->reg_rules_5g_ptr);
+		if (reg_info->is_ext_reg_event) {
+			for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++)
+				kfree(reg_info->reg_rules_6g_ap_ptr[i]);
+
+			for (j = 0; j < WMI_REG_CURRENT_MAX_AP_TYPE; j++)
+				for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++)
+					kfree(reg_info->reg_rules_6g_client_ptr[j][i]);
+		}
 		kfree(reg_info);
 	}
 	return ret;
@@ -7574,7 +7941,10 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 		ath11k_service_ready_ext2_event(ab, skb);
 		break;
 	case WMI_REG_CHAN_LIST_CC_EVENTID:
-		ath11k_reg_chan_list_event(ab, skb);
+		ath11k_reg_chan_list_event(ab, skb, WMI_REG_CHAN_LIST_CC_ID);
+		break;
+	case WMI_REG_CHAN_LIST_CC_EXT_EVENTID:
+		ath11k_reg_chan_list_event(ab, skb, WMI_REG_CHAN_LIST_CC_EXT_ID);
 		break;
 	case WMI_READY_EVENTID:
 		ath11k_ready_event(ab, skb);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8609dcd0543b..02c518e95121 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -790,6 +790,7 @@ enum wmi_tlv_event_id {
 	WMI_RMC_NEW_LEADER_EVENTID = WMI_TLV_CMD(WMI_GRP_RMC),
 	WMI_REG_CHAN_LIST_CC_EVENTID = WMI_TLV_CMD(WMI_GRP_REGULATORY),
 	WMI_11D_NEW_COUNTRY_EVENTID,
+	WMI_REG_CHAN_LIST_CC_EXT_EVENTID,
 	WMI_NDI_CAP_RSP_EVENTID = WMI_TLV_CMD(WMI_GRP_PROTOTYPE),
 	WMI_NDP_INITIATOR_RSP_EVENTID,
 	WMI_NDP_RESPONDER_RSP_EVENTID,
@@ -1857,6 +1858,9 @@ enum wmi_tlv_tag {
 	WMI_TAG_PDEV_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
 	WMI_TAG_PDEV_NON_SRG_OBSS_COLOR_ENABLE_BITMAP_CMD,
 	WMI_TAG_PDEV_NON_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
+	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
+	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
+
 	WMI_TAG_MAX
 };
 
@@ -2086,6 +2090,8 @@ enum wmi_tlv_service {
 	/* The second 128 bits */
 	WMI_MAX_EXT_SERVICE = 256,
 
+	WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT = 281,
+
 	/* The third 128 bits */
 	WMI_MAX_EXT2_SERVICE = 384
 };
@@ -2299,6 +2305,8 @@ struct wmi_init_cmd {
 
 #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 BIT(5)
 
+#define WMI_CFG_HOST_SERVICE_FLAG_REG_CC_EXT 4
+
 struct wmi_resource_config {
 	u32 tlv_header;
 	u32 num_vdevs;
@@ -2358,6 +2366,15 @@ struct wmi_resource_config {
 	u32 sched_params;
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
+	u32 max_nlo_ssids;
+	u32 num_pkt_filters;
+	u32 num_max_sta_vdevs;
+	u32 max_bssid_indicator;
+	u32 ul_resp_config;
+	u32 msdu_flow_override_config0;
+	u32 msdu_flow_override_config1;
+	u32 flags2;
+	u32 host_service_flags;
 } __packed;
 
 struct wmi_service_ready_event {
@@ -2840,6 +2857,8 @@ struct rx_reorder_queue_remove_params {
 #define REG_RULE_MAX_BW				0x0000ffff
 #define REG_RULE_REG_PWR			0x00ff0000
 #define REG_RULE_ANT_GAIN			0xff000000
+#define REG_RULE_PSD_INFO			BIT(0)
+#define REG_RULE_PSD_EIRP			0xff0000
 
 #define WMI_VDEV_PARAM_TXBF_SU_TX_BFEE BIT(0)
 #define WMI_VDEV_PARAM_TXBF_MU_TX_BFEE BIT(1)
@@ -4036,6 +4055,8 @@ struct wmi_he_rate_set {
 
 #define MAX_REG_RULES 10
 #define REG_ALPHA2_LEN 2
+#define MAX_6G_REG_RULES 5
+#define REG_US_5G_NUM_REG_RULES 4
 
 enum wmi_start_event_param {
 	WMI_VDEV_START_RESP_EVENT = 0,
@@ -4098,6 +4119,21 @@ enum {
 	WMI_REG_SET_CC_STATUS_FAIL = 5,
 };
 
+enum wmi_reg_6g_ap_type {
+	WMI_REG_INDOOR_AP = 0,
+	WMI_REG_STANDARD_POWER_AP = 1,
+	WMI_REG_VERY_LOW_POWER_AP = 2,
+	WMI_REG_CURRENT_MAX_AP_TYPE,
+	WMI_REG_MAX_SUPP_AP_TYPE = WMI_REG_VERY_LOW_POWER_AP,
+	WMI_REG_MAX_AP_TYPE = 7,
+};
+
+enum wmi_reg_6g_client_type {
+	WMI_REG_DEFAULT_CLIENT = 0,
+	WMI_REG_SUBORDINATE_CLIENT = 1,
+	WMI_REG_MAX_CLIENT_TYPE = 2,
+};
+
 struct cur_reg_rule {
 	u16 start_freq;
 	u16 end_freq;
@@ -4105,6 +4141,8 @@ struct cur_reg_rule {
 	u8 reg_power;
 	u8 ant_gain;
 	u16 flags;
+	bool psd_flag;
+	u16 psd_eirp;
 };
 
 struct cur_regulatory_info {
@@ -4116,6 +4154,7 @@ struct cur_regulatory_info {
 	u8 alpha2[REG_ALPHA2_LEN + 1];
 	u32 dfs_region;
 	u32 phybitmap;
+	bool is_ext_reg_event;
 	u32 min_bw_2g;
 	u32 max_bw_2g;
 	u32 min_bw_5g;
@@ -4124,6 +4163,29 @@ struct cur_regulatory_info {
 	u32 num_5g_reg_rules;
 	struct cur_reg_rule *reg_rules_2g_ptr;
 	struct cur_reg_rule *reg_rules_5g_ptr;
+	enum wmi_reg_6g_client_type client_type;
+	bool rnr_tpe_usable;
+	bool unspecified_ap_usable;
+	/* TODO: All 6 GHz related info can be stored only for required
+	 * combination instead of all types, to optimize memory usage.
+	 */
+	u8 domain_code_6g_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u8 domain_code_6g_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u32 domain_code_6g_super_id;
+	u32 min_bw_6g_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u32 max_bw_6g_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u32 min_bw_6g_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u32 max_bw_6g_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u32 num_6g_reg_rules_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u32 num_6g_reg_rules_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	struct cur_reg_rule *reg_rules_6g_ap_ptr[WMI_REG_CURRENT_MAX_AP_TYPE];
+	struct cur_reg_rule *reg_rules_6g_client_ptr
+		[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+};
+
+enum wmi_reg_chan_list_cmd_type {
+	WMI_REG_CHAN_LIST_CC_ID = 0,
+	WMI_REG_CHAN_LIST_CC_EXT_ID = 1,
 };
 
 struct wmi_reg_chan_list_cc_event {
@@ -4154,6 +4216,61 @@ struct wmi_vdev_delete_resp_event {
 	u32 vdev_id;
 } __packed;
 
+#define WMI_REG_CLIENT_MAX 4
+
+struct wmi_reg_chan_list_cc_ext_event {
+	u32 status_code;
+	u32 phy_id;
+	u32 alpha2;
+	u32 num_phy;
+	u32 country_id;
+	u32 domain_code;
+	u32 dfs_region;
+	u32 phybitmap;
+	u32 min_bw_2g;
+	u32 max_bw_2g;
+	u32 min_bw_5g;
+	u32 max_bw_5g;
+	u32 num_2g_reg_rules;
+	u32 num_5g_reg_rules;
+	u32 client_type;
+	u32 rnr_tpe_usable;
+	u32 unspecified_ap_usable;
+	u32 domain_code_6g_ap_lpi;
+	u32 domain_code_6g_ap_sp;
+	u32 domain_code_6g_ap_vlp;
+	u32 domain_code_6g_client_lpi[WMI_REG_CLIENT_MAX];
+	u32 domain_code_6g_client_sp[WMI_REG_CLIENT_MAX];
+	u32 domain_code_6g_client_vlp[WMI_REG_CLIENT_MAX];
+	u32 domain_code_6g_super_id;
+	u32 min_bw_6g_ap_sp;
+	u32 max_bw_6g_ap_sp;
+	u32 min_bw_6g_ap_lpi;
+	u32 max_bw_6g_ap_lpi;
+	u32 min_bw_6g_ap_vlp;
+	u32 max_bw_6g_ap_vlp;
+	u32 min_bw_6g_client_sp[WMI_REG_CLIENT_MAX];
+	u32 max_bw_6g_client_sp[WMI_REG_CLIENT_MAX];
+	u32 min_bw_6g_client_lpi[WMI_REG_CLIENT_MAX];
+	u32 max_bw_6g_client_lpi[WMI_REG_CLIENT_MAX];
+	u32 min_bw_6g_client_vlp[WMI_REG_CLIENT_MAX];
+	u32 max_bw_6g_client_vlp[WMI_REG_CLIENT_MAX];
+	u32 num_6g_reg_rules_ap_sp;
+	u32 num_6g_reg_rules_ap_lpi;
+	u32 num_6g_reg_rules_ap_vlp;
+	u32 num_6g_reg_rules_client_sp[WMI_REG_CLIENT_MAX];
+	u32 num_6g_reg_rules_client_lpi[WMI_REG_CLIENT_MAX];
+	u32 num_6g_reg_rules_client_vlp[WMI_REG_CLIENT_MAX];
+} __packed;
+
+struct wmi_regulatory_ext_rule {
+	u32 tlv_header;
+	u32 freq_info;
+	u32 bw_pwr_info;
+	u32 flag_info;
+	u32 psd_power_info;
+};
+
 struct wmi_peer_delete_resp_event {
 	u32 vdev_id;
 	struct wmi_mac_addr peer_macaddr;
@@ -5218,6 +5335,7 @@ struct target_resource_config {
 	u32 sched_params;
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
+	u8 is_reg_cc_ext_event_supported;
 };
 
 enum wmi_sys_cap_info_flags {
-- 
2.31.1

