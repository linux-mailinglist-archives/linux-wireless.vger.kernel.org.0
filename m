Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E903C7A5AAF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 09:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjISHRo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 03:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjISHRn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 03:17:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB648FC
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 00:17:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J5182u013864;
        Tue, 19 Sep 2023 07:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=48LZNQd0A77wS6RreSrA0xR20Cz0KqU89J1KD6cbff0=;
 b=ZK1teMFKZtt39edWk6Y/hwq46OkrJfgV9TYViqj0FdHXcqhHshUGM9Lr5m4xR9gWHEUl
 3rkoqdpPNbl8Nsuv5MhEEU2EEROWqnyfjHI29G4SrZEEsK6RhG8un9q60XsDx4LjSnv7
 LPBGET00HTTsKRcT30QASVPnzeLsGz/oLjLLGBo0J9RWgf08C79+T0WmDAXeb/ug7ZG5
 ILR6BDmwdPLtLwj20+4w124Dt9AmZ+o9dMGWgeSwkDg6YVGDPmYSON/ENrZi1ka40OPm
 POIigUydaafGtQ6RgCCCHdlzBY5AqfvSLMbpSm7/D1SSxMewadjyOXn9S0WlcIc1bohd dw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6jsmtj2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:17:32 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38J6tC4k017028;
        Tue, 19 Sep 2023 07:17:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3t74xehgct-1;
        Tue, 19 Sep 2023 07:17:31 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J7FRVe020674;
        Tue, 19 Sep 2023 07:17:31 GMT
Received: from aisr-linux.qualcomm.com (aisr-linux.qualcomm.com [10.201.124.194])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 38J7HU4S024315;
        Tue, 19 Sep 2023 07:17:31 +0000
Received: by aisr-linux.qualcomm.com (Postfix, from userid 4090849)
        id 3EDD4E02320; Tue, 19 Sep 2023 12:47:29 +0530 (IST)
From:   Aishwarya R <quic_aisr@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Aishwarya R <quic_aisr@quicinc.com>
Subject: [PATCH 1/7] wifi: ath12k: add support to select 6 GHz Regulatory type
Date:   Tue, 19 Sep 2023 12:47:18 +0530
Message-Id: <20230919071724.15505-2-quic_aisr@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230919071724.15505-1-quic_aisr@quicinc.com>
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rNK1d98BeAVmEybHHjwVs76z8Mai6-mr
X-Proofpoint-ORIG-GUID: rNK1d98BeAVmEybHHjwVs76z8Mai6-mr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_01,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190060
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are 3 types of regulatory rules for AP mode and 6 types for
STATION mode. This is to add wmi_vdev_type and ieee80211_ap_reg_power
to select the exact reg rules.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/reg.c |  62 +++++++--
 drivers/net/wireless/ath/ath12k/reg.h |   6 +-
 drivers/net/wireless/ath/ath12k/wmi.c | 182 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h |  27 +++-
 4 files changed, 257 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 6ede91ebc8e1..8501f77eee55 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -28,6 +28,21 @@ static const struct ieee80211_regdomain ath12k_world_regd = {
 	}
 };
 
+enum wmi_reg_6g_ap_type
+ath12k_ieee80211_ap_pwr_type_convert(enum ieee80211_ap_reg_power power_type)
+{
+	switch (power_type) {
+	case IEEE80211_REG_LPI_AP:
+		return WMI_REG_INDOOR_AP;
+	case IEEE80211_REG_SP_AP:
+		return WMI_REG_STD_POWER_AP;
+	case IEEE80211_REG_VLP_AP:
+		return WMI_REG_VLP_AP;
+	default:
+		return WMI_REG_MAX_AP_TYPE;
+	}
+}
+
 static bool ath12k_regdom_changes(struct ath12k *ar, char *alpha2)
 {
 	const struct ieee80211_regdomain *regd;
@@ -562,14 +577,16 @@ ath12k_reg_update_weather_radar_band(struct ath12k_base *ab,
 
 struct ieee80211_regdomain *
 ath12k_reg_build_regd(struct ath12k_base *ab,
-		      struct ath12k_reg_info *reg_info, bool intersect)
+		      struct ath12k_reg_info *reg_info, bool intersect,
+		      enum wmi_vdev_type vdev_type,
+		      enum ieee80211_ap_reg_power power_type)
 {
 	struct ieee80211_regdomain *tmp_regd, *default_regd, *new_regd = NULL;
-	struct ath12k_reg_rule *reg_rule;
+	struct ath12k_reg_rule *reg_rule, *reg_rule_6ghz;
 	u8 i = 0, j = 0, k = 0;
 	u8 num_rules;
 	u16 max_bw;
-	u32 flags;
+	u32 flags, reg_6ghz_number, max_bw_6ghz;
 	char alpha2[3];
 
 	num_rules = reg_info->num_5g_reg_rules + reg_info->num_2g_reg_rules;
@@ -578,8 +595,33 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 	 * This can be updated to choose the combination dynamically based on AP
 	 * type and client type, after complete 6G regulatory support is added.
 	 */
-	if (reg_info->is_ext_reg_event)
-		num_rules += reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP];
+	if (reg_info->is_ext_reg_event) {
+		if (vdev_type == WMI_VDEV_TYPE_STA) {
+			enum wmi_reg_6g_ap_type ap_type;
+
+			ap_type = ath12k_ieee80211_ap_pwr_type_convert(power_type);
+
+			if (ap_type == WMI_REG_MAX_AP_TYPE)
+				ap_type = WMI_REG_INDOOR_AP;
+			reg_6ghz_number = reg_info->num_6g_reg_rules_cl
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+			if (reg_6ghz_number == 0) {
+				ap_type = WMI_REG_INDOOR_AP;
+				reg_6ghz_number = reg_info->num_6g_reg_rules_cl
+						[ap_type][WMI_REG_DEFAULT_CLIENT];
+			}
+			reg_rule_6ghz = reg_info->reg_rules_6g_client_ptr
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+			max_bw_6ghz = reg_info->max_bw_6g_client
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+		} else {
+			reg_6ghz_number = reg_info->num_6g_reg_rules_ap
+					[WMI_REG_INDOOR_AP];
+			reg_rule_6ghz = reg_info->reg_rules_6g_ap_ptr[WMI_REG_INDOOR_AP];
+			max_bw_6ghz = reg_info->max_bw_6g_ap[WMI_REG_INDOOR_AP];
+		}
+		num_rules += reg_6ghz_number;
+	}
 
 	if (!num_rules)
 		goto ret;
@@ -626,12 +668,10 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 			 * per other BW rule flags we pass from here
 			 */
 			flags = NL80211_RRF_AUTO_BW;
-		} else if (reg_info->is_ext_reg_event &&
-			   reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP] &&
-			(k < reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP])) {
-			reg_rule = reg_info->reg_rules_6g_ap_ptr[WMI_REG_INDOOR_AP] + k++;
-			max_bw = min_t(u16, reg_rule->max_bw,
-				       reg_info->max_bw_6g_ap[WMI_REG_INDOOR_AP]);
+		} else if (reg_info->is_ext_reg_event && reg_6ghz_number &&
+			   (k < reg_6ghz_number)) {
+			reg_rule = reg_rule_6ghz + k++;
+			max_bw = min_t(u16, reg_rule->max_bw, max_bw_6ghz);
 			flags = NL80211_RRF_AUTO_BW;
 		} else {
 			break;
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index 56d009a47234..56324e30a358 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -88,7 +88,11 @@ void ath12k_reg_free(struct ath12k_base *ab);
 void ath12k_regd_update_work(struct work_struct *work);
 struct ieee80211_regdomain *ath12k_reg_build_regd(struct ath12k_base *ab,
 						  struct ath12k_reg_info *reg_info,
-						  bool intersect);
+						  bool intersect,
+						  enum wmi_vdev_type vdev_type,
+						  enum ieee80211_ap_reg_power power_type);
+enum wmi_reg_6g_ap_type
+ath12k_ieee80211_ap_pwr_type_convert(enum ieee80211_ap_reg_power power_type);
 int ath12k_regd_update(struct ath12k *ar, bool init);
 int ath12k_reg_update_chan_list(struct ath12k *ar);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index af910296c41e..1b9ce9a2ae96 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4152,6 +4152,119 @@ static struct ath12k_reg_rule
 	return reg_rule_ptr;
 }
 
+static char *ath12k_cc_status_to_str(enum ath12k_reg_cc_code code)
+{
+	switch (code) {
+	case REG_SET_CC_STATUS_PASS:
+		return "REG_SET_CC_STATUS_PASS";
+	case REG_CURRENT_ALPHA2_NOT_FOUND:
+		return "REG_CURRENT_ALPHA2_NOT_FOUND";
+	case REG_INIT_ALPHA2_NOT_FOUND:
+		return "REG_INIT_ALPHA2_NOT_FOUND";
+	case REG_SET_CC_CHANGE_NOT_ALLOWED:
+		return "REG_SET_CC_CHANGE_NOT_ALLOWED";
+	case REG_SET_CC_STATUS_NO_MEMORY:
+		return "REG_SET_CC_STATUS_NO_MEMORY";
+	case REG_SET_CC_STATUS_FAIL:
+		return "REG_SET_CC_STATUS_FAIL";
+	default:
+		return "unknown cc status";
+	}
+};
+
+static char *ath12k_super_reg_6ghz_to_str(enum reg_super_domain_6ghz domain_id)
+{
+	switch (domain_id) {
+	case FCC1_6GHZ:
+		return "FCC1_6GHZ";
+	case ETSI1_6GHZ:
+		return "ETSI1_6GHZ";
+	case ETSI2_6GHZ:
+		return "ETSI2_6GHZ";
+	case APL1_6GHZ:
+		return "APL1_6GHZ";
+	case FCC1_6GHZ_CL:
+		return "FCC1_6GHZ_CL";
+	default:
+		return "unknown domain id";
+	}
+}
+
+static char *ath12k_6ghz_client_type_to_str(enum wmi_reg_6g_client_type type)
+{
+	switch (type) {
+	case WMI_REG_DEFAULT_CLIENT:
+		return "DEFAULT CLIENT";
+	case WMI_REG_SUBORDINATE_CLIENT:
+		return "SUBORDINATE CLIENT";
+	default:
+		return "unknown client type";
+	}
+}
+
+static char *ath12k_6ghz_ap_type_to_str(enum wmi_reg_6g_ap_type type)
+{
+	switch (type) {
+	case WMI_REG_INDOOR_AP:
+		return "INDOOR AP";
+	case WMI_REG_STD_POWER_AP:
+		return "STANDARD POWER AP";
+	case WMI_REG_VLP_AP:
+		return "VERY LOW POWER AP";
+	default:
+		return "unknown AP type";
+	}
+}
+
+static char *ath12k_sub_reg_6ghz_to_str(enum reg_subdomains_6ghz sub_id)
+{
+	switch (sub_id) {
+	case FCC1_CLIENT_LPI_REGULAR_6GHZ:
+		return "FCC1_CLIENT_LPI_REGULAR_6GHZ";
+	case FCC1_CLIENT_SP_6GHZ:
+		return "FCC1_CLIENT_SP_6GHZ";
+	case FCC1_AP_LPI_6GHZ:
+		return "FCC1_AP_LPI_6GHZ/FCC1_CLIENT_LPI_SUBORDINATE";
+	case FCC1_AP_SP_6GHZ:
+		return "FCC1_AP_SP_6GHZ";
+	case ETSI1_LPI_6GHZ:
+		return "ETSI1_LPI_6GHZ";
+	case ETSI1_VLP_6GHZ:
+		return "ETSI1_VLP_6GHZ";
+	case ETSI2_LPI_6GHZ:
+		return "ETSI2_LPI_6GHZ";
+	case ETSI2_VLP_6GHZ:
+		return "ETSI2_VLP_6GHZ";
+	case APL1_LPI_6GHZ:
+		return "APL1_LPI_6GHZ";
+	case APL1_VLP_6GHZ:
+		return "APL1_VLP_6GHZ";
+	case EMPTY_6GHZ:
+		return "N/A";
+	default:
+		return "unknown sub reg id";
+	}
+}
+
+static void ath12k_print_reg_rule(struct ath12k_base *ab, char *prev,
+				  u32 num_reg_rules,
+				  struct ath12k_reg_rule *reg_rule_ptr)
+{
+	struct ath12k_reg_rule *reg_rule = reg_rule_ptr;
+	u32 count;
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI, "%s reg rules number %d\n", prev, num_reg_rules);
+
+	for (count = 0; count < num_reg_rules; count++) {
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "reg rule %d: (%d - %d @ %d) (%d, %d) (FLAGS %d) (psd flag %d EIRP %d dB/MHz)\n",
+			   count + 1, reg_rule->start_freq, reg_rule->end_freq,
+			   reg_rule->max_bw, reg_rule->ant_gain, reg_rule->reg_power,
+			   reg_rule->flags, reg_rule->psd_flag, reg_rule->psd_eirp);
+		reg_rule++;
+	}
+}
+
 static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 						   struct sk_buff *skb,
 						   struct ath12k_reg_info *reg_info)
@@ -4163,7 +4276,7 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 	u32 num_6g_reg_rules_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
 	u32 num_6g_reg_rules_cl[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
 	u32 total_reg_rules = 0;
-	int ret, i, j;
+	int ret, i, j, skip_6ghz_rules_in_5ghz_rules = 0;
 
 	ath12k_dbg(ab, ATH12K_DBG_WMI, "processing regulatory ext channel list\n");
 
@@ -4265,6 +4378,13 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 	 * from 5G rules list.
 	 */
 	if (memcmp(reg_info->alpha2, "US", 2) == 0) {
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "US 5 GHz reg rules number %d from fw",
+			   reg_info->num_5g_reg_rules);
+
+		if (reg_info->num_5g_reg_rules > REG_US_5G_NUM_REG_RULES)
+			skip_6ghz_rules_in_5ghz_rules = reg_info->num_5g_reg_rules -
+						    REG_US_5G_NUM_REG_RULES;
 		reg_info->num_5g_reg_rules = REG_US_5G_NUM_REG_RULES;
 		num_5g_reg_rules = reg_info->num_5g_reg_rules;
 	}
@@ -4297,6 +4417,10 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 		break;
 	}
 
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "%s: status_code %s", __func__,
+		   ath12k_cc_status_to_str(reg_info->status_code));
+
 	reg_info->is_ext_reg_event = true;
 
 	reg_info->min_bw_2g = le32_to_cpu(ev->min_bw_2g);
@@ -4325,6 +4449,10 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 			le32_to_cpu(ev->max_bw_6g_client_vlp[i]);
 	}
 
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "%s: status_code %s", __func__,
+		   ath12k_cc_status_to_str(reg_info->status_code));
+
 	ath12k_dbg(ab, ATH12K_DBG_WMI,
 		   "%s:cc_ext %s dsf %d BW: min_2g %d max_2g %d min_5g %d max_5g %d",
 		   __func__, reg_info->alpha2, reg_info->dfs_region,
@@ -4368,10 +4496,13 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 			ath12k_warn(ab, "Unable to Allocate memory for 2g rules\n");
 			return -ENOMEM;
 		}
+		ath12k_print_reg_rule(ab, "2 GHz",
+				      num_2g_reg_rules,
+				      reg_info->reg_rules_2g_ptr);
 	}
+	ext_wmi_reg_rule += num_2g_reg_rules;
 
 	if (num_5g_reg_rules) {
-		ext_wmi_reg_rule += num_2g_reg_rules;
 		reg_info->reg_rules_5g_ptr =
 			create_ext_reg_rules_from_wmi(num_5g_reg_rules,
 						      ext_wmi_reg_rule);
@@ -4381,9 +4512,18 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 			ath12k_warn(ab, "Unable to Allocate memory for 5g rules\n");
 			return -ENOMEM;
 		}
+		ath12k_print_reg_rule(ab, "5 GHz",
+				      num_5g_reg_rules,
+				      reg_info->reg_rules_5g_ptr);
 	}
 
-	ext_wmi_reg_rule += num_5g_reg_rules;
+	/* We have adjusted the number of 5 GHz reg rules via the hack above.
+	 * Here, we adjust that many extra rules which came with 5g reg rules
+	 * (for cc: US)
+	 *
+	 * NOTE: skip_6ghz_rules_in_5ghz_rules will be 0 for rest other cases.
+	 */
+	ext_wmi_reg_rule += num_5g_reg_rules + skip_6ghz_rules_in_5ghz_rules;
 
 	for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
 		reg_info->reg_rules_6g_ap_ptr[i] =
@@ -4396,10 +4536,17 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 			return -ENOMEM;
 		}
 
+		ath12k_print_reg_rule(ab, ath12k_6ghz_ap_type_to_str(i),
+				      num_6g_reg_rules_ap[i],
+				      reg_info->reg_rules_6g_ap_ptr[i]);
+
 		ext_wmi_reg_rule += num_6g_reg_rules_ap[i];
 	}
 
 	for (j = 0; j < WMI_REG_CURRENT_MAX_AP_TYPE; j++) {
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "AP type %s", ath12k_6ghz_ap_type_to_str(j));
+
 		for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
 			reg_info->reg_rules_6g_client_ptr[j][i] =
 				create_ext_reg_rules_from_wmi(num_6g_reg_rules_cl[j][i],
@@ -4411,6 +4558,10 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 				return -ENOMEM;
 			}
 
+			ath12k_print_reg_rule(ab, ath12k_6ghz_client_type_to_str(i),
+					      num_6g_reg_rules_cl[j][i],
+					      reg_info->reg_rules_6g_client_ptr[j][i]);
+
 			ext_wmi_reg_rule += num_6g_reg_rules_cl[j][i];
 		}
 	}
@@ -4425,6 +4576,18 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 	reg_info->domain_code_6g_ap[WMI_REG_VLP_AP] =
 		le32_to_cpu(ev->domain_code_6g_ap_vlp);
 
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "6 GHz reg info client type %s rnr_tpe_usable %d unspecified_ap_usable %d AP sub domain: lpi %s , sp %s , vlp %s\n",
+		   ath12k_6ghz_client_type_to_str(reg_info->client_type),
+		   reg_info->rnr_tpe_usable,
+		   reg_info->unspecified_ap_usable,
+		   ath12k_sub_reg_6ghz_to_str
+		   (le32_to_cpu(ev->domain_code_6g_ap_lpi)),
+		   ath12k_sub_reg_6ghz_to_str
+		   (le32_to_cpu(ev->domain_code_6g_ap_sp)),
+		   ath12k_sub_reg_6ghz_to_str
+		   (le32_to_cpu(ev->domain_code_6g_ap_vlp)));
+
 	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
 		reg_info->domain_code_6g_client[WMI_REG_INDOOR_AP][i] =
 			le32_to_cpu(ev->domain_code_6g_client_lpi[i]);
@@ -4432,12 +4595,18 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 			le32_to_cpu(ev->domain_code_6g_client_sp[i]);
 		reg_info->domain_code_6g_client[WMI_REG_VLP_AP][i] =
 			le32_to_cpu(ev->domain_code_6g_client_vlp[i]);
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "6 GHz AP BW: lpi %d - %d sp %d - %d vlp %d - %d\n",
+			   ev->min_bw_6g_ap_lpi, ev->max_bw_6g_ap_lpi,
+			   ev->min_bw_6g_ap_sp, ev->max_bw_6g_ap_sp,
+			   ev->min_bw_6g_ap_vlp, ev->max_bw_6g_ap_vlp);
 	}
 
 	reg_info->domain_code_6g_super_id = le32_to_cpu(ev->domain_code_6g_super_id);
 
-	ath12k_dbg(ab, ATH12K_DBG_WMI, "6g client_type: %d domain_code_6g_super_id: %d",
-		   reg_info->client_type, reg_info->domain_code_6g_super_id);
+	ath12k_dbg(ab, ATH12K_DBG_WMI, "6 GHz client_type: %s 6 GHz super domain %s",
+		   ath12k_6ghz_client_type_to_str(reg_info->client_type),
+		   ath12k_super_reg_6ghz_to_str(reg_info->domain_code_6g_super_id));
 
 	ath12k_dbg(ab, ATH12K_DBG_WMI, "processed regulatory ext channel list\n");
 
@@ -5192,7 +5361,8 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	    !ath12k_reg_is_world_alpha((char *)reg_info->alpha2))
 		intersect = true;
 
-	regd = ath12k_reg_build_regd(ab, reg_info, intersect);
+	regd = ath12k_reg_build_regd(ab, reg_info, intersect,
+				     WMI_VDEV_TYPE_AP, IEEE80211_REG_UNSET_AP);
 	if (!regd) {
 		ath12k_warn(ab, "failed to build regd from reg_info\n");
 		goto fallback;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 08a8c9e0f59f..966e6ba4e162 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2832,8 +2832,8 @@ struct ath12k_wmi_rx_reorder_queue_remove_arg {
 #define REG_RULE_MAX_BW				0x0000ffff
 #define REG_RULE_REG_PWR			0x00ff0000
 #define REG_RULE_ANT_GAIN			0xff000000
-#define REG_RULE_PSD_INFO			BIT(2)
-#define REG_RULE_PSD_EIRP			0xffff0000
+#define REG_RULE_PSD_INFO                       BIT(0)
+#define REG_RULE_PSD_EIRP                       0xff0000
 
 #define WMI_VDEV_PARAM_TXBF_SU_TX_BFEE BIT(0)
 #define WMI_VDEV_PARAM_TXBF_MU_TX_BFEE BIT(1)
@@ -3844,6 +3844,29 @@ enum {
 	WMI_REG_SET_CC_STATUS_FAIL = 5,
 };
 
+enum reg_subdomains_6ghz {
+	EMPTY_6GHZ = 0x0,
+	FCC1_CLIENT_LPI_REGULAR_6GHZ = 0x01,
+	FCC1_CLIENT_SP_6GHZ = 0x02,
+	FCC1_AP_LPI_6GHZ = 0x03,
+	FCC1_CLIENT_LPI_SUBORDINATE = FCC1_AP_LPI_6GHZ,
+	FCC1_AP_SP_6GHZ = 0x04,
+	ETSI1_LPI_6GHZ = 0x10,
+	ETSI1_VLP_6GHZ = 0x11,
+	ETSI2_LPI_6GHZ = 0x12,
+	ETSI2_VLP_6GHZ = 0x13,
+	APL1_LPI_6GHZ = 0x20,
+	APL1_VLP_6GHZ = 0x21,
+};
+
+enum reg_super_domain_6ghz {
+	FCC1_6GHZ = 0x01,
+	ETSI1_6GHZ = 0x02,
+	ETSI2_6GHZ = 0x03,
+	APL1_6GHZ = 0x04,
+	FCC1_6GHZ_CL = 0x05,
+};
+
 #define WMI_REG_CLIENT_MAX 4
 
 struct wmi_reg_chan_list_cc_ext_event {
-- 
2.17.1

