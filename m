Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5334D64CC8F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 15:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiLNOoa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 09:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbiLNOoH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 09:44:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CF024977
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 06:44:05 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEESGLC012079;
        Wed, 14 Dec 2022 14:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=XHBcWwAm6xrDE299jbJeKF1cxQSqZ9EGqi6x/jevULo=;
 b=P63AfM3N093I7l8FGOM4YrXcanP8NgXto7+dlTsMQ/AptWD3KpQGwz9GPd68EWzvXSiB
 wZgUQx6/N3B0ZFsp/zygmhlmLQrhWaMui2YLr4jM1bX+UwOqV2EINiafUH9uj9wJJZja
 4TfFFta8w2fsn5r5A1+2Bsvml1Z/zh5VrBPkx460T8lkqYt3g1zEnm1d8cD8HhwO+Ldq
 XuulMgxd0JnVGmxwkexow8D0eHpdwkgCXa64BCWVHGz0Di7vBPBi1F27LJQE1IrdolJW
 9ygIBxVuWt1dcl6ZiyTaqnC0FcOWELzCPnpd8yV9ifOCl82OJOC3d1p5eobawZrKHtuK 2A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rehe1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 14:43:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BEEhs7E003705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 14:43:54 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 14 Dec 2022 06:43:51 -0800
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Lavanya Suresh <quic_lavaks@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>
Subject: [PATCH 2/3] wifi: ath11k: add support to parse new WMI event for 6 GHz
Date:   Wed, 14 Dec 2022 20:13:33 +0530
Message-ID: <20221214144334.13812-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221214144334.13812-1-quic_adisi@quicinc.com>
References: <20221214144334.13812-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KyG-rGPSlauRGAV5lZoFB0xyO7lmVa_p
X-Proofpoint-GUID: KyG-rGPSlauRGAV5lZoFB0xyO7lmVa_p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_06,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212140117
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to support different power levels of 6 GHz AP and client,
new WMI event for regulatory - WMI_REG_CHAN_LIST_CC_EXT_EVENTID is
added in firmware. This event provides new parameters required for
6 GHz regulatory rules.

Add support for parsing 2.4 GHz, 5 GHz and 6 GHz reg rules and other
parameters from WMI_REG_CHAN_LIST_CC_EXT_EVENTID.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Signed-off-by: Lavanya Suresh <quic_lavaks@quicinc.com>
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/reg.c |  36 ++-
 drivers/net/wireless/ath/ath11k/wmi.c | 416 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h | 162 +++++++++-
 3 files changed, 581 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index c231abdf49cb..4729e281adff 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -613,7 +613,7 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 {
 	struct ieee80211_regdomain *tmp_regd, *default_regd, *new_regd = NULL;
 	struct cur_reg_rule *reg_rule;
-	u8 i = 0, j = 0;
+	u8 i = 0, j = 0, k = 0;
 	u8 num_rules;
 	u16 max_bw;
 	u32 flags;
@@ -621,6 +621,12 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 
 	num_rules = reg_info->num_5ghz_reg_rules + reg_info->num_2ghz_reg_rules;
 
+	/* FIXME: Currently taking reg rules for 6 GHz only from Indoor AP mode list.
+	 * This can be updated after complete 6 GHz regulatory support is added.
+	 */
+	if (reg_info->is_ext_reg_event)
+		num_rules += reg_info->num_6ghz_reg_rules_ap[WMI_REG_INDOOR_AP];
+
 	if (!num_rules)
 		goto ret;
 
@@ -666,6 +672,13 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 			 * per other BW rule flags we pass from here
 			 */
 			flags = NL80211_RRF_AUTO_BW;
+		} else if (reg_info->is_ext_reg_event &&
+			   reg_info->num_6ghz_reg_rules_ap[WMI_REG_INDOOR_AP] &&
+			   (k < reg_info->num_6ghz_reg_rules_ap[WMI_REG_INDOOR_AP])) {
+			reg_rule = reg_info->reg_rules_6ghz_ap_ptr[WMI_REG_INDOOR_AP] + k++;
+			max_bw = min_t(u16, reg_rule->max_bw,
+				       reg_info->max_bw_6ghz_ap[WMI_REG_INDOOR_AP]);
+			flags = NL80211_RRF_AUTO_BW;
 		} else {
 			break;
 		}
@@ -693,12 +706,21 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
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
index fd84963d5860..027ed35c43e1 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -105,6 +105,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		= { .min_len = sizeof(struct wmi_vdev_stopped_event) },
 	[WMI_TAG_REG_CHAN_LIST_CC_EVENT]
 		= { .min_len = sizeof(struct wmi_reg_chan_list_cc_event) },
+	[WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT]
+		= { .min_len = sizeof(struct wmi_reg_chan_list_cc_ext_event) },
 	[WMI_TAG_MGMT_RX_HDR]
 		= { .min_len = sizeof(struct wmi_mgmt_rx_hdr) },
 	[WMI_TAG_MGMT_TX_COMPL_EVENT]
@@ -3966,6 +3968,10 @@ ath11k_wmi_copy_resource_config(struct wmi_resource_config *wmi_cfg,
 	wmi_cfg->sched_params = tg_cfg->sched_params;
 	wmi_cfg->twt_ap_pdev_count = tg_cfg->twt_ap_pdev_count;
 	wmi_cfg->twt_ap_sta_count = tg_cfg->twt_ap_sta_count;
+	wmi_cfg->host_service_flags &=
+		~(1 << WMI_CFG_HOST_SERVICE_FLAG_REG_CC_EXT);
+	wmi_cfg->host_service_flags |= (tg_cfg->is_reg_cc_ext_event_supported <<
+					WMI_CFG_HOST_SERVICE_FLAG_REG_CC_EXT);
 }
 
 static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
@@ -4184,6 +4190,10 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 
 	ab->hw_params.hw_ops->wmi_init_config(ab, &config);
 
+	if (test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT,
+		     ab->wmi_ab.svc_map))
+		config.is_reg_cc_ext_event_supported = 1;
+
 	memcpy(&wmi_sc->wlan_resource_config, &config, sizeof(config));
 
 	init_param.res_cfg = &wmi_sc->wlan_resource_config;
@@ -4987,18 +4997,11 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 	reg_info->phy_id = chan_list_event_hdr->phy_id;
 	reg_info->ctry_code = chan_list_event_hdr->country_id;
 	reg_info->reg_dmn_pair = chan_list_event_hdr->domain_code;
-	if (chan_list_event_hdr->status_code == WMI_REG_SET_CC_STATUS_PASS)
-		reg_info->status_code = REG_SET_CC_STATUS_PASS;
-	else if (chan_list_event_hdr->status_code == WMI_REG_CURRENT_ALPHA2_NOT_FOUND)
-		reg_info->status_code = REG_CURRENT_ALPHA2_NOT_FOUND;
-	else if (chan_list_event_hdr->status_code == WMI_REG_INIT_ALPHA2_NOT_FOUND)
-		reg_info->status_code = REG_INIT_ALPHA2_NOT_FOUND;
-	else if (chan_list_event_hdr->status_code == WMI_REG_SET_CC_CHANGE_NOT_ALLOWED)
-		reg_info->status_code = REG_SET_CC_CHANGE_NOT_ALLOWED;
-	else if (chan_list_event_hdr->status_code == WMI_REG_SET_CC_STATUS_NO_MEMORY)
-		reg_info->status_code = REG_SET_CC_STATUS_NO_MEMORY;
-	else if (chan_list_event_hdr->status_code == WMI_REG_SET_CC_STATUS_FAIL)
-		reg_info->status_code = REG_SET_CC_STATUS_FAIL;
+
+	reg_info->status_code =
+		ath11k_wmi_cc_setting_code_to_regulatory(chan_list_event_hdr->status_code);
+
+	reg_info->is_ext_reg_event = false;
 
 	reg_info->min_bw_2ghz = chan_list_event_hdr->min_bw_2ghz;
 	reg_info->max_bw_2ghz = chan_list_event_hdr->max_bw_2ghz;
@@ -5052,6 +5055,370 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 	return 0;
 }
 
+static struct cur_reg_rule
+*create_ext_reg_rules_from_wmi(u32 num_reg_rules,
+			       struct wmi_regulatory_ext_rule *wmi_reg_rule)
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
+			u32_get_bits(wmi_reg_rule[count].freq_info,
+				     REG_RULE_START_FREQ);
+		reg_rule_ptr[count].end_freq =
+			u32_get_bits(wmi_reg_rule[count].freq_info,
+				     REG_RULE_END_FREQ);
+		reg_rule_ptr[count].max_bw =
+			u32_get_bits(wmi_reg_rule[count].bw_pwr_info,
+				     REG_RULE_MAX_BW);
+		reg_rule_ptr[count].reg_power =
+			u32_get_bits(wmi_reg_rule[count].bw_pwr_info,
+				     REG_RULE_REG_PWR);
+		reg_rule_ptr[count].ant_gain =
+			u32_get_bits(wmi_reg_rule[count].bw_pwr_info,
+				     REG_RULE_ANT_GAIN);
+		reg_rule_ptr[count].flags =
+			u32_get_bits(wmi_reg_rule[count].flag_info,
+				     REG_RULE_FLAGS);
+		reg_rule_ptr[count].psd_flag =
+			u32_get_bits(wmi_reg_rule[count].psd_power_info,
+				     REG_RULE_PSD_INFO);
+		reg_rule_ptr[count].psd_eirp =
+			u32_get_bits(wmi_reg_rule[count].psd_power_info,
+				     REG_RULE_PSD_EIRP);
+	}
+
+	return reg_rule_ptr;
+}
+
+static u8
+ath11k_invalid_5ghz_reg_ext_rules_from_wmi(u32 num_reg_rules,
+					   const struct wmi_regulatory_ext_rule *wmi_reg_rule)
+{
+	u8 num_invalid_5ghz_rules = 0;
+	u32 count, start_freq, end_freq;
+
+	for (count = 0; count < num_reg_rules; count++) {
+		start_freq = u32_get_bits(wmi_reg_rule[count].freq_info,
+					  REG_RULE_START_FREQ);
+		end_freq = u32_get_bits(wmi_reg_rule[count].freq_info,
+					REG_RULE_END_FREQ);
+
+		if (start_freq >= ATH11K_MIN_6G_FREQ)
+			num_invalid_5ghz_rules++;
+	}
+
+	return num_invalid_5ghz_rules;
+}
+
+static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
+						   struct sk_buff *skb,
+						   struct cur_regulatory_info *reg_info)
+{
+	const void **tb;
+	const struct wmi_reg_chan_list_cc_ext_event *ext_chan_list_event_hdr;
+	struct wmi_regulatory_ext_rule *ext_wmi_reg_rule;
+	u32 num_2ghz_reg_rules, num_5ghz_reg_rules;
+	u32 num_6ghz_reg_rules_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u32 num_6ghz_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u32 total_reg_rules = 0;
+	int ret, i, j, num_invalid_5ghz_ext_rules = 0;
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
+	reg_info->num_2ghz_reg_rules =
+			ext_chan_list_event_hdr->num_2ghz_reg_rules;
+	reg_info->num_5ghz_reg_rules =
+			ext_chan_list_event_hdr->num_5ghz_reg_rules;
+	reg_info->num_6ghz_reg_rules_ap[WMI_REG_INDOOR_AP] =
+			ext_chan_list_event_hdr->num_6ghz_reg_rules_ap_lpi;
+	reg_info->num_6ghz_reg_rules_ap[WMI_REG_STANDARD_POWER_AP] =
+			ext_chan_list_event_hdr->num_6ghz_reg_rules_ap_sp;
+	reg_info->num_6ghz_reg_rules_ap[WMI_REG_VERY_LOW_POWER_AP] =
+			ext_chan_list_event_hdr->num_6ghz_reg_rules_ap_vlp;
+
+	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
+		reg_info->num_6ghz_reg_rules_client[WMI_REG_INDOOR_AP][i] =
+			ext_chan_list_event_hdr->num_6ghz_reg_rules_client_lpi[i];
+		reg_info->num_6ghz_reg_rules_client[WMI_REG_STANDARD_POWER_AP][i] =
+			ext_chan_list_event_hdr->num_6ghz_reg_rules_client_sp[i];
+		reg_info->num_6ghz_reg_rules_client[WMI_REG_VERY_LOW_POWER_AP][i] =
+			ext_chan_list_event_hdr->num_6ghz_reg_rules_client_vlp[i];
+	}
+
+	num_2ghz_reg_rules = reg_info->num_2ghz_reg_rules;
+	num_5ghz_reg_rules = reg_info->num_5ghz_reg_rules;
+
+	total_reg_rules += num_2ghz_reg_rules;
+	total_reg_rules += num_5ghz_reg_rules;
+
+	if ((num_2ghz_reg_rules > MAX_REG_RULES) ||
+	    (num_5ghz_reg_rules > MAX_REG_RULES)) {
+		ath11k_warn(ab, "Num reg rules for 2.4 GHz/5 GHz exceeds max limit (num_2ghz_reg_rules: %d num_5ghz_reg_rules: %d max_rules: %d)\n",
+			    num_2ghz_reg_rules, num_5ghz_reg_rules, MAX_REG_RULES);
+		kfree(tb);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
+		num_6ghz_reg_rules_ap[i] = reg_info->num_6ghz_reg_rules_ap[i];
+
+		if (num_6ghz_reg_rules_ap[i] > MAX_6GHZ_REG_RULES) {
+			ath11k_warn(ab, "Num 6 GHz reg rules for AP mode(%d) exceeds max limit (num_6ghz_reg_rules_ap: %d, max_rules: %d)\n",
+				    i, num_6ghz_reg_rules_ap[i], MAX_6GHZ_REG_RULES);
+			kfree(tb);
+			return -EINVAL;
+		}
+
+		total_reg_rules += num_6ghz_reg_rules_ap[i];
+	}
+
+	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
+		num_6ghz_client[WMI_REG_INDOOR_AP][i] =
+			reg_info->num_6ghz_reg_rules_client[WMI_REG_INDOOR_AP][i];
+		total_reg_rules += num_6ghz_client[WMI_REG_INDOOR_AP][i];
+
+		num_6ghz_client[WMI_REG_STANDARD_POWER_AP][i] =
+			reg_info->num_6ghz_reg_rules_client[WMI_REG_STANDARD_POWER_AP][i];
+		total_reg_rules += num_6ghz_client[WMI_REG_STANDARD_POWER_AP][i];
+
+		num_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][i] =
+			reg_info->num_6ghz_reg_rules_client[WMI_REG_VERY_LOW_POWER_AP][i];
+		total_reg_rules += num_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][i];
+
+		if ((num_6ghz_client[WMI_REG_INDOOR_AP][i] > MAX_6GHZ_REG_RULES) ||
+		    (num_6ghz_client[WMI_REG_STANDARD_POWER_AP][i] > MAX_6GHZ_REG_RULES) ||
+		    (num_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][i] >  MAX_6GHZ_REG_RULES)) {
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
+	reg_info->dfs_region = ext_chan_list_event_hdr->dfs_region;
+	reg_info->phybitmap = ext_chan_list_event_hdr->phybitmap;
+	reg_info->num_phy = ext_chan_list_event_hdr->num_phy;
+	reg_info->phy_id = ext_chan_list_event_hdr->phy_id;
+	reg_info->ctry_code = ext_chan_list_event_hdr->country_id;
+	reg_info->reg_dmn_pair = ext_chan_list_event_hdr->domain_code;
+
+	reg_info->status_code =
+		ath11k_wmi_cc_setting_code_to_regulatory(ext_chan_list_event_hdr->status_code);
+
+	reg_info->is_ext_reg_event = true;
+
+	reg_info->min_bw_2ghz = ext_chan_list_event_hdr->min_bw_2ghz;
+	reg_info->max_bw_2ghz = ext_chan_list_event_hdr->max_bw_2ghz;
+	reg_info->min_bw_5ghz = ext_chan_list_event_hdr->min_bw_5ghz;
+	reg_info->max_bw_5ghz = ext_chan_list_event_hdr->max_bw_5ghz;
+
+	reg_info->min_bw_6ghz_ap[WMI_REG_INDOOR_AP] =
+			ext_chan_list_event_hdr->min_bw_6ghz_ap_lpi;
+	reg_info->max_bw_6ghz_ap[WMI_REG_INDOOR_AP] =
+			 ext_chan_list_event_hdr->max_bw_6ghz_ap_lpi;
+	reg_info->min_bw_6ghz_ap[WMI_REG_STANDARD_POWER_AP] =
+			ext_chan_list_event_hdr->min_bw_6ghz_ap_sp;
+	reg_info->max_bw_6ghz_ap[WMI_REG_STANDARD_POWER_AP] =
+			ext_chan_list_event_hdr->max_bw_6ghz_ap_sp;
+	reg_info->min_bw_6ghz_ap[WMI_REG_VERY_LOW_POWER_AP] =
+			ext_chan_list_event_hdr->min_bw_6ghz_ap_vlp;
+	reg_info->max_bw_6ghz_ap[WMI_REG_VERY_LOW_POWER_AP] =
+			ext_chan_list_event_hdr->max_bw_6ghz_ap_vlp;
+
+	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
+		reg_info->min_bw_6ghz_client[WMI_REG_INDOOR_AP][i] =
+				ext_chan_list_event_hdr->min_bw_6ghz_client_lpi[i];
+		reg_info->max_bw_6ghz_client[WMI_REG_INDOOR_AP][i] =
+				ext_chan_list_event_hdr->max_bw_6ghz_client_lpi[i];
+		reg_info->min_bw_6ghz_client[WMI_REG_STANDARD_POWER_AP][i] =
+				ext_chan_list_event_hdr->min_bw_6ghz_client_sp[i];
+		reg_info->max_bw_6ghz_client[WMI_REG_STANDARD_POWER_AP][i] =
+				ext_chan_list_event_hdr->max_bw_6ghz_client_sp[i];
+		reg_info->min_bw_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][i] =
+				ext_chan_list_event_hdr->min_bw_6ghz_client_vlp[i];
+		reg_info->max_bw_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][i] =
+				ext_chan_list_event_hdr->max_bw_6ghz_client_vlp[i];
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "%s:cc_ext %s dsf %d BW: min_2ghz %d max_2ghz %d min_5ghz %d max_5ghz %d",
+		   __func__, reg_info->alpha2, reg_info->dfs_region,
+		   reg_info->min_bw_2ghz, reg_info->max_bw_2ghz,
+		   reg_info->min_bw_5ghz, reg_info->max_bw_5ghz);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "num_2ghz_reg_rules %d num_5ghz_reg_rules %d",
+		   num_2ghz_reg_rules, num_5ghz_reg_rules);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "num_6ghz_reg_rules_ap_lpi: %d num_6ghz_reg_rules_ap_sp: %d num_6ghz_reg_rules_ap_vlp: %d",
+		   num_6ghz_reg_rules_ap[WMI_REG_INDOOR_AP],
+		   num_6ghz_reg_rules_ap[WMI_REG_STANDARD_POWER_AP],
+		   num_6ghz_reg_rules_ap[WMI_REG_VERY_LOW_POWER_AP]);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "6 GHz Regular client: num_6ghz_reg_rules_lpi: %d num_6ghz_reg_rules_sp: %d num_6ghz_reg_rules_vlp: %d",
+		   num_6ghz_client[WMI_REG_INDOOR_AP][WMI_REG_DEFAULT_CLIENT],
+		   num_6ghz_client[WMI_REG_STANDARD_POWER_AP][WMI_REG_DEFAULT_CLIENT],
+		   num_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][WMI_REG_DEFAULT_CLIENT]);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "6 GHz Subordinate client: num_6ghz_reg_rules_lpi: %d num_6ghz_reg_rules_sp: %d num_6ghz_reg_rules_vlp: %d",
+		   num_6ghz_client[WMI_REG_INDOOR_AP][WMI_REG_SUBORDINATE_CLIENT],
+		   num_6ghz_client[WMI_REG_STANDARD_POWER_AP][WMI_REG_SUBORDINATE_CLIENT],
+		   num_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][WMI_REG_SUBORDINATE_CLIENT]);
+
+	ext_wmi_reg_rule =
+		(struct wmi_regulatory_ext_rule *)((u8 *)ext_chan_list_event_hdr
+						   + sizeof(*ext_chan_list_event_hdr)
+						   + sizeof(struct wmi_tlv));
+	if (num_2ghz_reg_rules) {
+		reg_info->reg_rules_2ghz_ptr =
+			create_ext_reg_rules_from_wmi(num_2ghz_reg_rules,
+						      ext_wmi_reg_rule);
+
+		if (!reg_info->reg_rules_2ghz_ptr) {
+			kfree(tb);
+			ath11k_warn(ab, "Unable to Allocate memory for 2 GHz rules\n");
+			return -ENOMEM;
+		}
+	}
+
+	ext_wmi_reg_rule += num_2ghz_reg_rules;
+
+	/* Firmware might include 6 GHz reg rule in 5 GHz rule list
+	 * for few countries along with separate 6 GHz rule.
+	 * Having same 6 GHz reg rule in 5 GHz and 6 GHz rules list
+	 * causes intersect check to be true, and same rules will be
+	 * shown multiple times in iw cmd.
+	 * Hence, avoid parsing 6 GHz rule from 5 GHz reg rule list
+	 */
+	num_invalid_5ghz_ext_rules =
+		ath11k_invalid_5ghz_reg_ext_rules_from_wmi(num_5ghz_reg_rules,
+							   ext_wmi_reg_rule);
+
+	if (num_invalid_5ghz_ext_rules) {
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "CC: %s 5 GHz reg rules number %d from fw, %d number of invalid 5 GHz rules",
+			   reg_info->alpha2, reg_info->num_5ghz_reg_rules,
+			   num_invalid_5ghz_ext_rules);
+
+		num_5ghz_reg_rules = num_5ghz_reg_rules - num_invalid_5ghz_ext_rules;
+		reg_info->num_5ghz_reg_rules = num_5ghz_reg_rules;
+	}
+
+	if (num_5ghz_reg_rules) {
+		reg_info->reg_rules_5ghz_ptr =
+			create_ext_reg_rules_from_wmi(num_5ghz_reg_rules,
+						      ext_wmi_reg_rule);
+
+		if (!reg_info->reg_rules_5ghz_ptr) {
+			kfree(tb);
+			ath11k_warn(ab, "Unable to Allocate memory for 5 GHz rules\n");
+			return -ENOMEM;
+		}
+	}
+
+	/* We have adjusted the number of 5 GHz reg rules above. But still those
+	 * many rules needs to be adjusted in ext_wmi_reg_rule.
+	 *
+	 * NOTE: num_invalid_5ghz_ext_rules will be 0 for rest other cases.
+	 */
+	ext_wmi_reg_rule += (num_5ghz_reg_rules + num_invalid_5ghz_ext_rules);
+
+	for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
+		reg_info->reg_rules_6ghz_ap_ptr[i] =
+			create_ext_reg_rules_from_wmi(num_6ghz_reg_rules_ap[i],
+						      ext_wmi_reg_rule);
+
+		if (!reg_info->reg_rules_6ghz_ap_ptr[i]) {
+			kfree(tb);
+			ath11k_warn(ab, "Unable to Allocate memory for 6 GHz AP rules\n");
+			return -ENOMEM;
+		}
+
+		ext_wmi_reg_rule += num_6ghz_reg_rules_ap[i];
+	}
+
+	for (j = 0; j < WMI_REG_CURRENT_MAX_AP_TYPE; j++) {
+		for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
+			reg_info->reg_rules_6ghz_client_ptr[j][i] =
+				create_ext_reg_rules_from_wmi(num_6ghz_client[j][i],
+							      ext_wmi_reg_rule);
+
+			if (!reg_info->reg_rules_6ghz_client_ptr[j][i]) {
+				kfree(tb);
+				ath11k_warn(ab, "Unable to Allocate memory for 6 GHz client rules\n");
+				return -ENOMEM;
+			}
+
+			ext_wmi_reg_rule += num_6ghz_client[j][i];
+		}
+	}
+
+	reg_info->client_type = ext_chan_list_event_hdr->client_type;
+	reg_info->rnr_tpe_usable = ext_chan_list_event_hdr->rnr_tpe_usable;
+	reg_info->unspecified_ap_usable =
+			ext_chan_list_event_hdr->unspecified_ap_usable;
+	reg_info->domain_code_6ghz_ap[WMI_REG_INDOOR_AP] =
+			ext_chan_list_event_hdr->domain_code_6ghz_ap_lpi;
+	reg_info->domain_code_6ghz_ap[WMI_REG_STANDARD_POWER_AP] =
+			ext_chan_list_event_hdr->domain_code_6ghz_ap_sp;
+	reg_info->domain_code_6ghz_ap[WMI_REG_VERY_LOW_POWER_AP] =
+			ext_chan_list_event_hdr->domain_code_6ghz_ap_vlp;
+
+	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
+		reg_info->domain_code_6ghz_client[WMI_REG_INDOOR_AP][i] =
+				ext_chan_list_event_hdr->domain_code_6ghz_client_lpi[i];
+		reg_info->domain_code_6ghz_client[WMI_REG_STANDARD_POWER_AP][i] =
+				ext_chan_list_event_hdr->domain_code_6ghz_client_sp[i];
+		reg_info->domain_code_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][i] =
+				ext_chan_list_event_hdr->domain_code_6ghz_client_vlp[i];
+	}
+
+	reg_info->domain_code_6ghz_super_id =
+			ext_chan_list_event_hdr->domain_code_6ghz_super_id;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "6 GHz client_type: %d domain_code_6ghz_super_id: %d",
+		   reg_info->client_type, reg_info->domain_code_6ghz_super_id);
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
@@ -6493,12 +6860,14 @@ static bool ath11k_reg_is_world_alpha(char *alpha)
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
@@ -6507,7 +6876,11 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *sk
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
@@ -6609,6 +6982,14 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *sk
 	if (reg_info) {
 		kfree(reg_info->reg_rules_2ghz_ptr);
 		kfree(reg_info->reg_rules_5ghz_ptr);
+		if (reg_info->is_ext_reg_event) {
+			for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++)
+				kfree(reg_info->reg_rules_6ghz_ap_ptr[i]);
+
+			for (j = 0; j < WMI_REG_CURRENT_MAX_AP_TYPE; j++)
+				for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++)
+					kfree(reg_info->reg_rules_6ghz_client_ptr[j][i]);
+		}
 		kfree(reg_info);
 	}
 	return ret;
@@ -8041,7 +8422,10 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
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
index 94f90148c54f..83ed4314f3bb 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -797,6 +797,7 @@ enum wmi_tlv_event_id {
 	WMI_RMC_NEW_LEADER_EVENTID = WMI_TLV_CMD(WMI_GRP_RMC),
 	WMI_REG_CHAN_LIST_CC_EVENTID = WMI_TLV_CMD(WMI_GRP_REGULATORY),
 	WMI_11D_NEW_COUNTRY_EVENTID,
+	WMI_REG_CHAN_LIST_CC_EXT_EVENTID,
 	WMI_NDI_CAP_RSP_EVENTID = WMI_TLV_CMD(WMI_GRP_PROTOTYPE),
 	WMI_NDP_INITIATOR_RSP_EVENTID,
 	WMI_NDP_RESPONDER_RSP_EVENTID,
@@ -1864,6 +1865,8 @@ enum wmi_tlv_tag {
 	WMI_TAG_PDEV_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
 	WMI_TAG_PDEV_NON_SRG_OBSS_COLOR_ENABLE_BITMAP_CMD,
 	WMI_TAG_PDEV_NON_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
+	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
+	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
 	WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD = 0x3D8,
 	WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD,
 	WMI_TAG_MAX
@@ -2095,6 +2098,7 @@ enum wmi_tlv_service {
 
 	/* The second 128 bits */
 	WMI_MAX_EXT_SERVICE = 256,
+	WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT = 281,
 	WMI_TLV_SERVICE_BIOS_SAR_SUPPORT = 326,
 
 	/* The third 128 bits */
@@ -2310,6 +2314,8 @@ struct wmi_init_cmd {
 
 #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 BIT(5)
 
+#define WMI_CFG_HOST_SERVICE_FLAG_REG_CC_EXT 4
+
 struct wmi_resource_config {
 	u32 tlv_header;
 	u32 num_vdevs;
@@ -2369,6 +2375,15 @@ struct wmi_resource_config {
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
@@ -2851,6 +2866,8 @@ struct rx_reorder_queue_remove_params {
 #define REG_RULE_MAX_BW				0x0000ffff
 #define REG_RULE_REG_PWR			0x00ff0000
 #define REG_RULE_ANT_GAIN			0xff000000
+#define REG_RULE_PSD_INFO			BIT(0)
+#define REG_RULE_PSD_EIRP			0xff0000
 
 #define WMI_VDEV_PARAM_TXBF_SU_TX_BFEE BIT(0)
 #define WMI_VDEV_PARAM_TXBF_MU_TX_BFEE BIT(1)
@@ -4039,6 +4056,7 @@ struct wmi_he_rate_set {
 
 #define MAX_REG_RULES 10
 #define REG_ALPHA2_LEN 2
+#define MAX_6GHZ_REG_RULES 5
 
 enum wmi_start_event_param {
 	WMI_VDEV_START_RESP_EVENT = 0,
@@ -4069,15 +4087,6 @@ enum wmi_vdev_start_resp_status_code {
 	WMI_VDEV_START_RESPONSE_INVALID_REGDOMAIN = 4,
 };
 
-;
-enum cc_setting_code {
-	REG_SET_CC_STATUS_PASS = 0,
-	REG_CURRENT_ALPHA2_NOT_FOUND = 1,
-	REG_INIT_ALPHA2_NOT_FOUND = 2,
-	REG_SET_CC_CHANGE_NOT_ALLOWED = 3,
-	REG_SET_CC_STATUS_NO_MEMORY = 4,
-	REG_SET_CC_STATUS_FAIL = 5,
-};
 
 /* Regaulatory Rule Flags Passed by FW */
 #define REGULATORY_CHAN_DISABLED     BIT(0)
@@ -4092,13 +4101,72 @@ enum cc_setting_code {
 #define REGULATORY_CHAN_NO_20MHZ     BIT(11)
 #define REGULATORY_CHAN_NO_10MHZ     BIT(12)
 
-enum {
+enum wmi_reg_chan_list_cmd_type {
+	WMI_REG_CHAN_LIST_CC_ID = 0,
+	WMI_REG_CHAN_LIST_CC_EXT_ID = 1,
+};
+
+enum wmi_reg_cc_setting_code {
 	WMI_REG_SET_CC_STATUS_PASS = 0,
 	WMI_REG_CURRENT_ALPHA2_NOT_FOUND = 1,
 	WMI_REG_INIT_ALPHA2_NOT_FOUND = 2,
 	WMI_REG_SET_CC_CHANGE_NOT_ALLOWED = 3,
 	WMI_REG_SET_CC_STATUS_NO_MEMORY = 4,
 	WMI_REG_SET_CC_STATUS_FAIL = 5,
+
+	/* add new setting code above, update in
+	 * @enum cc_setting_code as well.
+	 * Also handle it in ath11k_wmi_cc_setting_code_to_regulatory()
+	 */
+};
+
+enum cc_setting_code {
+	REG_SET_CC_STATUS_PASS = 0,
+	REG_CURRENT_ALPHA2_NOT_FOUND = 1,
+	REG_INIT_ALPHA2_NOT_FOUND = 2,
+	REG_SET_CC_CHANGE_NOT_ALLOWED = 3,
+	REG_SET_CC_STATUS_NO_MEMORY = 4,
+	REG_SET_CC_STATUS_FAIL = 5,
+
+	/* add new setting code above, update in
+	 * @enum wmi_reg_cc_setting_code as well.
+	 */
+};
+
+static inline enum cc_setting_code
+ath11k_wmi_cc_setting_code_to_regulatory(enum wmi_reg_cc_setting_code status_code)
+{
+	switch (status_code) {
+	case WMI_REG_SET_CC_STATUS_PASS:
+		return REG_SET_CC_STATUS_PASS;
+	case WMI_REG_CURRENT_ALPHA2_NOT_FOUND:
+		return REG_CURRENT_ALPHA2_NOT_FOUND;
+	case WMI_REG_INIT_ALPHA2_NOT_FOUND:
+		return REG_INIT_ALPHA2_NOT_FOUND;
+	case WMI_REG_SET_CC_CHANGE_NOT_ALLOWED:
+		return REG_SET_CC_CHANGE_NOT_ALLOWED;
+	case WMI_REG_SET_CC_STATUS_NO_MEMORY:
+		return REG_SET_CC_STATUS_NO_MEMORY;
+	case WMI_REG_SET_CC_STATUS_FAIL:
+		return REG_SET_CC_STATUS_FAIL;
+	}
+
+	return REG_SET_CC_STATUS_FAIL;
+}
+
+enum wmi_reg_6ghz_ap_type {
+	WMI_REG_INDOOR_AP = 0,
+	WMI_REG_STANDARD_POWER_AP = 1,
+	WMI_REG_VERY_LOW_POWER_AP = 2,
+
+	WMI_REG_CURRENT_MAX_AP_TYPE,
+	WMI_REG_MAX_AP_TYPE = 7,
+};
+
+enum wmi_reg_6ghz_client_type {
+	WMI_REG_DEFAULT_CLIENT = 0,
+	WMI_REG_SUBORDINATE_CLIENT = 1,
+	WMI_REG_MAX_CLIENT_TYPE = 2,
 };
 
 struct cur_reg_rule {
@@ -4108,6 +4176,8 @@ struct cur_reg_rule {
 	u8 reg_power;
 	u8 ant_gain;
 	u16 flags;
+	bool psd_flag;
+	s8 psd_eirp;
 };
 
 struct cur_regulatory_info {
@@ -4127,6 +4197,22 @@ struct cur_regulatory_info {
 	u32 num_5ghz_reg_rules;
 	struct cur_reg_rule *reg_rules_2ghz_ptr;
 	struct cur_reg_rule *reg_rules_5ghz_ptr;
+	bool is_ext_reg_event;
+	enum wmi_reg_6ghz_client_type client_type;
+	bool rnr_tpe_usable;
+	bool unspecified_ap_usable;
+	u8 domain_code_6ghz_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u8 domain_code_6ghz_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u32 domain_code_6ghz_super_id;
+	u32 min_bw_6ghz_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u32 max_bw_6ghz_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u32 min_bw_6ghz_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u32 max_bw_6ghz_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u32 num_6ghz_reg_rules_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u32 num_6ghz_reg_rules_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	struct cur_reg_rule *reg_rules_6ghz_ap_ptr[WMI_REG_CURRENT_MAX_AP_TYPE];
+	struct cur_reg_rule *reg_rules_6ghz_client_ptr
+		[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
 };
 
 struct wmi_reg_chan_list_cc_event {
@@ -4153,6 +4239,61 @@ struct wmi_regulatory_rule_struct {
 	u32  flag_info;
 };
 
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
+	u32 min_bw_2ghz;
+	u32 max_bw_2ghz;
+	u32 min_bw_5ghz;
+	u32 max_bw_5ghz;
+	u32 num_2ghz_reg_rules;
+	u32 num_5ghz_reg_rules;
+	u32 client_type;
+	u32 rnr_tpe_usable;
+	u32 unspecified_ap_usable;
+	u32 domain_code_6ghz_ap_lpi;
+	u32 domain_code_6ghz_ap_sp;
+	u32 domain_code_6ghz_ap_vlp;
+	u32 domain_code_6ghz_client_lpi[WMI_REG_CLIENT_MAX];
+	u32 domain_code_6ghz_client_sp[WMI_REG_CLIENT_MAX];
+	u32 domain_code_6ghz_client_vlp[WMI_REG_CLIENT_MAX];
+	u32 domain_code_6ghz_super_id;
+	u32 min_bw_6ghz_ap_sp;
+	u32 max_bw_6ghz_ap_sp;
+	u32 min_bw_6ghz_ap_lpi;
+	u32 max_bw_6ghz_ap_lpi;
+	u32 min_bw_6ghz_ap_vlp;
+	u32 max_bw_6ghz_ap_vlp;
+	u32 min_bw_6ghz_client_sp[WMI_REG_CLIENT_MAX];
+	u32 max_bw_6ghz_client_sp[WMI_REG_CLIENT_MAX];
+	u32 min_bw_6ghz_client_lpi[WMI_REG_CLIENT_MAX];
+	u32 max_bw_6ghz_client_lpi[WMI_REG_CLIENT_MAX];
+	u32 min_bw_6ghz_client_vlp[WMI_REG_CLIENT_MAX];
+	u32 max_bw_6ghz_client_vlp[WMI_REG_CLIENT_MAX];
+	u32 num_6ghz_reg_rules_ap_sp;
+	u32 num_6ghz_reg_rules_ap_lpi;
+	u32 num_6ghz_reg_rules_ap_vlp;
+	u32 num_6ghz_reg_rules_client_sp[WMI_REG_CLIENT_MAX];
+	u32 num_6ghz_reg_rules_client_lpi[WMI_REG_CLIENT_MAX];
+	u32 num_6ghz_reg_rules_client_vlp[WMI_REG_CLIENT_MAX];
+} __packed;
+
+struct wmi_regulatory_ext_rule {
+	u32 tlv_header;
+	u32 freq_info;
+	u32 bw_pwr_info;
+	u32 flag_info;
+	u32 psd_power_info;
+} __packed;
+
 struct wmi_vdev_delete_resp_event {
 	u32 vdev_id;
 } __packed;
@@ -5346,6 +5487,7 @@ struct target_resource_config {
 	u32 sched_params;
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
+	u8 is_reg_cc_ext_event_supported;
 };
 
 enum wmi_debug_log_param {
-- 
2.17.1

