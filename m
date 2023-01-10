Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92AE66400A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 13:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjAJMNR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 07:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjAJMMt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 07:12:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA321159
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 04:11:06 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AC2tfc021242;
        Tue, 10 Jan 2023 12:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=nt8WwUNzbH+/1NcwAqtgH+N9kCyFE61HNrpXPCd2/YE=;
 b=VqGvfuHq5PhIPk1cLG4oqWwPrQBIUhK5nuXTsWp/AyqHORbtvjqj6PupFz5i7EreBTdH
 cIwdfsLDRLkoL8wmLZYtB6CGTN+rBzVh2WRzu7Srsa/39kCM6cp4vtDcLoftcwWlSLyk
 L62RTwR0f6Hhk1b7jXpfydeeyeDxbTeCjfBiMwCMARQts+hVH2Oiwbyn1WvlRc5F3Yun
 NcJLQx+ZgKcHNl5lEspA5yCoMnGntq46N3U4Pf0ls3NMsgN7CUWY949VVckgZFpYC3ZL
 SzMQbOygkBHOAkBmrErAH6PlCoxm5BXTkhN2/BgmOlCKjDRWKRqefDIR0MIcVUf9FwrB ew== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n156x0cyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 12:11:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ACAxJj008798
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 12:10:59 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 10 Jan 2023 04:10:43 -0800
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 3/3] wifi: ath11k: add debug prints in regulatory WMI event processing
Date:   Tue, 10 Jan 2023 17:40:24 +0530
Message-ID: <20230110121024.14051-4-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110121024.14051-1-quic_adisi@quicinc.com>
References: <20230110121024.14051-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nl6_yfU30w0dc6icGN8WZ_vsG30nnf7Y
X-Proofpoint-GUID: nl6_yfU30w0dc6icGN8WZ_vsG30nnf7Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_03,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100074
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add some more debug prints in processing regulatory WMI event in order to
increase more debuggability.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/reg.c |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.c | 207 ++++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/wmi.h | 142 ++++++++++++++++++
 3 files changed, 291 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 08621bd13a12..67443457f4da 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -646,7 +646,7 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 	tmp_regd->dfs_region = ath11k_map_fw_dfs_region(reg_info->dfs_region);
 
 	ath11k_dbg(ab, ATH11K_DBG_REG,
-		   "\r\nCountry %s, CFG Regdomain %s FW Regdomain %d, num_reg_rules %d\n",
+		   "Country %s, CFG Regdomain %s FW Regdomain %d, num_reg_rules %d\n",
 		   alpha2, ath11k_reg_get_regdom_str(tmp_regd->dfs_region),
 		   reg_info->dfs_region, num_rules);
 	/* Update reg_rules[] below. Firmware is expected to
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 0624386a5963..94fdbd29d883 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4917,6 +4917,26 @@ static int ath11k_pull_vdev_start_resp_tlv(struct ath11k_base *ab, struct sk_buf
 	return 0;
 }
 
+static void ath11k_print_reg_rule(struct ath11k_base *ab, const char *band,
+				  u32 num_reg_rules,
+				  struct cur_reg_rule *reg_rule_ptr)
+{
+	struct cur_reg_rule *reg_rule = reg_rule_ptr;
+	u32 count;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "number of reg rules in %s band: %d\n",
+		   band, num_reg_rules);
+
+	for (count = 0; count < num_reg_rules; count++) {
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "reg rule %d: (%d - %d @ %d) (%d, %d) (FLAGS %d)\n",
+			   count + 1, reg_rule->start_freq, reg_rule->end_freq,
+			   reg_rule->max_bw, reg_rule->ant_gain,
+			   reg_rule->reg_power, reg_rule->flags);
+		reg_rule++;
+	}
+}
+
 static struct cur_reg_rule
 *create_reg_rules_from_wmi(u32 num_reg_rules,
 			   struct wmi_regulatory_rule_struct *wmi_reg_rule)
@@ -4998,6 +5018,10 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 	reg_info->ctry_code = chan_list_event_hdr->country_id;
 	reg_info->reg_dmn_pair = chan_list_event_hdr->domain_code;
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "status_code %s",
+		   ath11k_cc_status_to_str(reg_info->status_code));
+
 	reg_info->status_code =
 		ath11k_wmi_cc_setting_code_to_reg(chan_list_event_hdr->status_code);
 
@@ -5012,13 +5036,13 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 	num_5ghz_reg_rules = reg_info->num_5ghz_reg_rules;
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "%s:cc %s dsf %d BW: min_2ghz %d max_2ghz %d min_5ghz %d max_5ghz %d",
-		   __func__, reg_info->alpha2, reg_info->dfs_region,
+		   "cc %s dsf %d BW: min_2ghz %d max_2ghz %d min_5ghz %d max_5ghz %d",
+		   reg_info->alpha2, reg_info->dfs_region,
 		   reg_info->min_bw_2ghz, reg_info->max_bw_2ghz,
 		   reg_info->min_bw_5ghz, reg_info->max_bw_5ghz);
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "%s: num_2ghz_reg_rules %d num_5ghz_reg_rules %d", __func__,
+		   "num_2ghz_reg_rules %d num_5ghz_reg_rules %d",
 		   num_2ghz_reg_rules, num_5ghz_reg_rules);
 
 	wmi_reg_rule =
@@ -5035,6 +5059,10 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 			ath11k_warn(ab, "Unable to Allocate memory for 2 GHz rules\n");
 			return -ENOMEM;
 		}
+
+		ath11k_print_reg_rule(ab, "2 GHz",
+				      num_2ghz_reg_rules,
+				      reg_info->reg_rules_2ghz_ptr);
 	}
 
 	if (num_5ghz_reg_rules) {
@@ -5047,6 +5075,10 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 			ath11k_warn(ab, "Unable to Allocate memory for 5 GHz rules\n");
 			return -ENOMEM;
 		}
+
+		ath11k_print_reg_rule(ab, "5 GHz",
+				      num_5ghz_reg_rules,
+				      reg_info->reg_rules_5ghz_ptr);
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI, "processed regulatory channel list\n");
@@ -5120,7 +5152,7 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 						   struct cur_regulatory_info *reg_info)
 {
 	const void **tb;
-	const struct wmi_reg_chan_list_cc_ext_event *ext_chan_list_event_hdr;
+	const struct wmi_reg_chan_list_cc_ext_event *ev;
 	struct wmi_regulatory_ext_rule *ext_wmi_reg_rule;
 	u32 num_2ghz_reg_rules, num_5ghz_reg_rules;
 	u32 num_6ghz_reg_rules_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
@@ -5137,31 +5169,29 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 		return ret;
 	}
 
-	ext_chan_list_event_hdr = tb[WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT];
-	if (!ext_chan_list_event_hdr) {
+	ev = tb[WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT];
+	if (!ev) {
 		ath11k_warn(ab, "failed to fetch reg chan list ext update ev\n");
 		kfree(tb);
 		return -EPROTO;
 	}
 
-	reg_info->num_2ghz_reg_rules =
-			ext_chan_list_event_hdr->num_2ghz_reg_rules;
-	reg_info->num_5ghz_reg_rules =
-			ext_chan_list_event_hdr->num_5ghz_reg_rules;
+	reg_info->num_2ghz_reg_rules = ev->num_2ghz_reg_rules;
+	reg_info->num_5ghz_reg_rules = ev->num_5ghz_reg_rules;
 	reg_info->num_6ghz_rules_ap[WMI_REG_INDOOR_AP] =
-			ext_chan_list_event_hdr->num_6ghz_reg_rules_ap_lpi;
+			ev->num_6ghz_reg_rules_ap_lpi;
 	reg_info->num_6ghz_rules_ap[WMI_REG_STANDARD_POWER_AP] =
-			ext_chan_list_event_hdr->num_6ghz_reg_rules_ap_sp;
+			ev->num_6ghz_reg_rules_ap_sp;
 	reg_info->num_6ghz_rules_ap[WMI_REG_VERY_LOW_POWER_AP] =
-			ext_chan_list_event_hdr->num_6ghz_reg_rules_ap_vlp;
+			ev->num_6ghz_reg_rules_ap_vlp;
 
 	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
 		reg_info->num_6ghz_rules_client[WMI_REG_INDOOR_AP][i] =
-			ext_chan_list_event_hdr->num_6ghz_reg_rules_client_lpi[i];
+			ev->num_6ghz_reg_rules_client_lpi[i];
 		reg_info->num_6ghz_rules_client[WMI_REG_STANDARD_POWER_AP][i] =
-			ext_chan_list_event_hdr->num_6ghz_reg_rules_client_sp[i];
+			ev->num_6ghz_reg_rules_client_sp[i];
 		reg_info->num_6ghz_rules_client[WMI_REG_VERY_LOW_POWER_AP][i] =
-			ext_chan_list_event_hdr->num_6ghz_reg_rules_client_vlp[i];
+			ev->num_6ghz_reg_rules_client_vlp[i];
 	}
 
 	num_2ghz_reg_rules = reg_info->num_2ghz_reg_rules;
@@ -5223,57 +5253,79 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 		return -EINVAL;
 	}
 
-	memcpy(reg_info->alpha2, &ext_chan_list_event_hdr->alpha2,
-	       REG_ALPHA2_LEN);
+	memcpy(reg_info->alpha2, &ev->alpha2, REG_ALPHA2_LEN);
 
-	reg_info->dfs_region = ext_chan_list_event_hdr->dfs_region;
-	reg_info->phybitmap = ext_chan_list_event_hdr->phybitmap;
-	reg_info->num_phy = ext_chan_list_event_hdr->num_phy;
-	reg_info->phy_id = ext_chan_list_event_hdr->phy_id;
-	reg_info->ctry_code = ext_chan_list_event_hdr->country_id;
-	reg_info->reg_dmn_pair = ext_chan_list_event_hdr->domain_code;
+	reg_info->dfs_region = ev->dfs_region;
+	reg_info->phybitmap = ev->phybitmap;
+	reg_info->num_phy = ev->num_phy;
+	reg_info->phy_id = ev->phy_id;
+	reg_info->ctry_code = ev->country_id;
+	reg_info->reg_dmn_pair = ev->domain_code;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "status_code %s",
+		   ath11k_cc_status_to_str(reg_info->status_code));
 
 	reg_info->status_code =
-		ath11k_wmi_cc_setting_code_to_reg(ext_chan_list_event_hdr->status_code);
+		ath11k_wmi_cc_setting_code_to_reg(ev->status_code);
 
 	reg_info->is_ext_reg_event = true;
 
-	reg_info->min_bw_2ghz = ext_chan_list_event_hdr->min_bw_2ghz;
-	reg_info->max_bw_2ghz = ext_chan_list_event_hdr->max_bw_2ghz;
-	reg_info->min_bw_5ghz = ext_chan_list_event_hdr->min_bw_5ghz;
-	reg_info->max_bw_5ghz = ext_chan_list_event_hdr->max_bw_5ghz;
+	reg_info->min_bw_2ghz = ev->min_bw_2ghz;
+	reg_info->max_bw_2ghz = ev->max_bw_2ghz;
+	reg_info->min_bw_5ghz = ev->min_bw_5ghz;
+	reg_info->max_bw_5ghz = ev->max_bw_5ghz;
 
 	reg_info->min_bw_6ghz_ap[WMI_REG_INDOOR_AP] =
-			ext_chan_list_event_hdr->min_bw_6ghz_ap_lpi;
+			ev->min_bw_6ghz_ap_lpi;
 	reg_info->max_bw_6ghz_ap[WMI_REG_INDOOR_AP] =
-			 ext_chan_list_event_hdr->max_bw_6ghz_ap_lpi;
+			ev->max_bw_6ghz_ap_lpi;
 	reg_info->min_bw_6ghz_ap[WMI_REG_STANDARD_POWER_AP] =
-			ext_chan_list_event_hdr->min_bw_6ghz_ap_sp;
+			ev->min_bw_6ghz_ap_sp;
 	reg_info->max_bw_6ghz_ap[WMI_REG_STANDARD_POWER_AP] =
-			ext_chan_list_event_hdr->max_bw_6ghz_ap_sp;
+			ev->max_bw_6ghz_ap_sp;
 	reg_info->min_bw_6ghz_ap[WMI_REG_VERY_LOW_POWER_AP] =
-			ext_chan_list_event_hdr->min_bw_6ghz_ap_vlp;
+			ev->min_bw_6ghz_ap_vlp;
 	reg_info->max_bw_6ghz_ap[WMI_REG_VERY_LOW_POWER_AP] =
-			ext_chan_list_event_hdr->max_bw_6ghz_ap_vlp;
+			ev->max_bw_6ghz_ap_vlp;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "6 GHz AP BW: LPI (%d - %d), SP (%d - %d), VLP (%d - %d)\n",
+		   reg_info->min_bw_6ghz_ap[WMI_REG_INDOOR_AP],
+		   reg_info->max_bw_6ghz_ap[WMI_REG_INDOOR_AP],
+		   reg_info->min_bw_6ghz_ap[WMI_REG_STANDARD_POWER_AP],
+		   reg_info->max_bw_6ghz_ap[WMI_REG_STANDARD_POWER_AP],
+		   reg_info->min_bw_6ghz_ap[WMI_REG_VERY_LOW_POWER_AP],
+		   reg_info->max_bw_6ghz_ap[WMI_REG_VERY_LOW_POWER_AP]);
 
 	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
 		reg_info->min_bw_6ghz_client[WMI_REG_INDOOR_AP][i] =
-				ext_chan_list_event_hdr->min_bw_6ghz_client_lpi[i];
+				ev->min_bw_6ghz_client_lpi[i];
 		reg_info->max_bw_6ghz_client[WMI_REG_INDOOR_AP][i] =
-				ext_chan_list_event_hdr->max_bw_6ghz_client_lpi[i];
+				ev->max_bw_6ghz_client_lpi[i];
 		reg_info->min_bw_6ghz_client[WMI_REG_STANDARD_POWER_AP][i] =
-				ext_chan_list_event_hdr->min_bw_6ghz_client_sp[i];
+				ev->min_bw_6ghz_client_sp[i];
 		reg_info->max_bw_6ghz_client[WMI_REG_STANDARD_POWER_AP][i] =
-				ext_chan_list_event_hdr->max_bw_6ghz_client_sp[i];
+				ev->max_bw_6ghz_client_sp[i];
 		reg_info->min_bw_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][i] =
-				ext_chan_list_event_hdr->min_bw_6ghz_client_vlp[i];
+				ev->min_bw_6ghz_client_vlp[i];
 		reg_info->max_bw_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][i] =
-				ext_chan_list_event_hdr->max_bw_6ghz_client_vlp[i];
+				ev->max_bw_6ghz_client_vlp[i];
+
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "6 GHz %s BW: LPI (%d - %d), SP (%d - %d), VLP (%d - %d)\n",
+			   ath11k_6ghz_client_type_to_str(i),
+			   reg_info->min_bw_6ghz_client[WMI_REG_INDOOR_AP][i],
+			   reg_info->max_bw_6ghz_client[WMI_REG_INDOOR_AP][i],
+			   reg_info->min_bw_6ghz_client[WMI_REG_STANDARD_POWER_AP][i],
+			   reg_info->max_bw_6ghz_client[WMI_REG_STANDARD_POWER_AP][i],
+			   reg_info->min_bw_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][i],
+			   reg_info->max_bw_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][i]);
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "%s:cc_ext %s dsf %d BW: min_2ghz %d max_2ghz %d min_5ghz %d max_5ghz %d",
-		   __func__, reg_info->alpha2, reg_info->dfs_region,
+		   "cc_ext %s dsf %d BW: min_2ghz %d max_2ghz %d min_5ghz %d max_5ghz %d",
+		   reg_info->alpha2, reg_info->dfs_region,
 		   reg_info->min_bw_2ghz, reg_info->max_bw_2ghz,
 		   reg_info->min_bw_5ghz, reg_info->max_bw_5ghz);
 
@@ -5302,9 +5354,8 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 		   num_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][j]);
 
 	ext_wmi_reg_rule =
-		(struct wmi_regulatory_ext_rule *)((u8 *)ext_chan_list_event_hdr
-						   + sizeof(*ext_chan_list_event_hdr)
-						   + sizeof(struct wmi_tlv));
+		(struct wmi_regulatory_ext_rule *)((u8 *)ev + sizeof(*ev) +
+						   sizeof(struct wmi_tlv));
 	if (num_2ghz_reg_rules) {
 		reg_info->reg_rules_2ghz_ptr =
 			create_ext_reg_rules_from_wmi(num_2ghz_reg_rules,
@@ -5315,6 +5366,10 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 			ath11k_warn(ab, "Unable to Allocate memory for 2 GHz rules\n");
 			return -ENOMEM;
 		}
+
+		ath11k_print_reg_rule(ab, "2 GHz",
+				      num_2ghz_reg_rules,
+				      reg_info->reg_rules_2ghz_ptr);
 	}
 
 	ext_wmi_reg_rule += num_2ghz_reg_rules;
@@ -5350,6 +5405,10 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 			ath11k_warn(ab, "Unable to Allocate memory for 5 GHz rules\n");
 			return -ENOMEM;
 		}
+
+		ath11k_print_reg_rule(ab, "5 GHz",
+				      num_5ghz_reg_rules,
+				      reg_info->reg_rules_5ghz_ptr);
 	}
 
 	/* We have adjusted the number of 5 GHz reg rules above. But still those
@@ -5370,10 +5429,17 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 			return -ENOMEM;
 		}
 
+		ath11k_print_reg_rule(ab, ath11k_6ghz_ap_type_to_str(i),
+				      num_6ghz_reg_rules_ap[i],
+				      reg_info->reg_rules_6ghz_ap_ptr[i]);
+
 		ext_wmi_reg_rule += num_6ghz_reg_rules_ap[i];
 	}
 
 	for (j = 0; j < WMI_REG_CURRENT_MAX_AP_TYPE; j++) {
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "6 GHz AP type %s", ath11k_6ghz_ap_type_to_str(j));
+
 		for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
 			reg_info->reg_rules_6ghz_client_ptr[j][i] =
 				create_ext_reg_rules_from_wmi(num_6ghz_client[j][i],
@@ -5385,35 +5451,58 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 				return -ENOMEM;
 			}
 
+			ath11k_print_reg_rule(ab,
+					      ath11k_6ghz_client_type_to_str(i),
+					      num_6ghz_client[j][i],
+					      reg_info->reg_rules_6ghz_client_ptr[j][i]);
+
 			ext_wmi_reg_rule += num_6ghz_client[j][i];
 		}
 	}
 
-	reg_info->client_type = ext_chan_list_event_hdr->client_type;
-	reg_info->rnr_tpe_usable = ext_chan_list_event_hdr->rnr_tpe_usable;
+	reg_info->client_type = ev->client_type;
+	reg_info->rnr_tpe_usable = ev->rnr_tpe_usable;
 	reg_info->unspecified_ap_usable =
-			ext_chan_list_event_hdr->unspecified_ap_usable;
+			ev->unspecified_ap_usable;
 	reg_info->domain_code_6ghz_ap[WMI_REG_INDOOR_AP] =
-			ext_chan_list_event_hdr->domain_code_6ghz_ap_lpi;
+			ev->domain_code_6ghz_ap_lpi;
 	reg_info->domain_code_6ghz_ap[WMI_REG_STANDARD_POWER_AP] =
-			ext_chan_list_event_hdr->domain_code_6ghz_ap_sp;
+			ev->domain_code_6ghz_ap_sp;
 	reg_info->domain_code_6ghz_ap[WMI_REG_VERY_LOW_POWER_AP] =
-			ext_chan_list_event_hdr->domain_code_6ghz_ap_vlp;
+			ev->domain_code_6ghz_ap_vlp;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "6 GHz reg info client type %s rnr_tpe_usable %d unspecified_ap_usable %d AP sub domain: lpi %s, sp %s, vlp %s\n",
+		   ath11k_6ghz_client_type_to_str(reg_info->client_type),
+		   reg_info->rnr_tpe_usable,
+		   reg_info->unspecified_ap_usable,
+		   ath11k_sub_reg_6ghz_to_str(ev->domain_code_6ghz_ap_lpi),
+		   ath11k_sub_reg_6ghz_to_str(ev->domain_code_6ghz_ap_sp),
+		   ath11k_sub_reg_6ghz_to_str(ev->domain_code_6ghz_ap_vlp));
 
 	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
 		reg_info->domain_code_6ghz_client[WMI_REG_INDOOR_AP][i] =
-				ext_chan_list_event_hdr->domain_code_6ghz_client_lpi[i];
+				ev->domain_code_6ghz_client_lpi[i];
 		reg_info->domain_code_6ghz_client[WMI_REG_STANDARD_POWER_AP][i] =
-				ext_chan_list_event_hdr->domain_code_6ghz_client_sp[i];
+				ev->domain_code_6ghz_client_sp[i];
 		reg_info->domain_code_6ghz_client[WMI_REG_VERY_LOW_POWER_AP][i] =
-				ext_chan_list_event_hdr->domain_code_6ghz_client_vlp[i];
+				ev->domain_code_6ghz_client_vlp[i];
+
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "6 GHz client type %s client sub domain: lpi %s, sp %s, vlp %s\n",
+			   ath11k_6ghz_client_type_to_str(i),
+			   ath11k_sub_reg_6ghz_to_str(ev->domain_code_6ghz_client_lpi[i]),
+			   ath11k_sub_reg_6ghz_to_str(ev->domain_code_6ghz_client_sp[i]),
+			   ath11k_sub_reg_6ghz_to_str(ev->domain_code_6ghz_client_vlp[i])
+			  );
 	}
 
-	reg_info->domain_code_6ghz_super_id =
-			ext_chan_list_event_hdr->domain_code_6ghz_super_id;
+	reg_info->domain_code_6ghz_super_id = ev->domain_code_6ghz_super_id;
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "6 GHz client_type: %d domain_code_6ghz_super_id: %d",
-		   reg_info->client_type, reg_info->domain_code_6ghz_super_id);
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "6 GHz client_type %s 6 GHz super domain %s",
+		   ath11k_6ghz_client_type_to_str(reg_info->client_type),
+		   ath11k_super_reg_6ghz_to_str(reg_info->domain_code_6ghz_super_id));
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI, "processed regulatory ext channel list\n");
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 0291bb5cf28b..13e97d44a8c4 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4129,6 +4129,7 @@ enum cc_setting_code {
 
 	/* add new setting code above, update in
 	 * @enum wmi_reg_cc_setting_code as well.
+	 * Also handle it in ath11k_cc_status_to_str()
 	 */
 };
 
@@ -4153,21 +4154,162 @@ ath11k_wmi_cc_setting_code_to_reg(enum wmi_reg_cc_setting_code status_code)
 	return REG_SET_CC_STATUS_FAIL;
 }
 
+static inline const char *ath11k_cc_status_to_str(enum cc_setting_code code)
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
+	}
+
+	return "Unknown CC status";
+}
+
 enum wmi_reg_6ghz_ap_type {
 	WMI_REG_INDOOR_AP = 0,
 	WMI_REG_STANDARD_POWER_AP = 1,
 	WMI_REG_VERY_LOW_POWER_AP = 2,
 
+	/* add AP type above, handle in ath11k_6ghz_ap_type_to_str()
+	 */
 	WMI_REG_CURRENT_MAX_AP_TYPE,
 	WMI_REG_MAX_AP_TYPE = 7,
 };
 
+static inline const char *
+ath11k_6ghz_ap_type_to_str(enum wmi_reg_6ghz_ap_type type)
+{
+	switch (type) {
+	case WMI_REG_INDOOR_AP:
+		return "INDOOR AP";
+	case WMI_REG_STANDARD_POWER_AP:
+		return "STANDARD POWER AP";
+	case WMI_REG_VERY_LOW_POWER_AP:
+		return "VERY LOW POWER AP";
+	case WMI_REG_CURRENT_MAX_AP_TYPE:
+		return "CURRENT_MAX_AP_TYPE";
+	case WMI_REG_MAX_AP_TYPE:
+		return "MAX_AP_TYPE";
+	}
+
+	return "unknown 6 GHz AP type";
+}
+
 enum wmi_reg_6ghz_client_type {
 	WMI_REG_DEFAULT_CLIENT = 0,
 	WMI_REG_SUBORDINATE_CLIENT = 1,
 	WMI_REG_MAX_CLIENT_TYPE = 2,
+
+	/* add client type above, handle it in
+	 * ath11k_6ghz_client_type_to_str()
+	 */
 };
 
+static inline const char *
+ath11k_6ghz_client_type_to_str(enum wmi_reg_6ghz_client_type type)
+{
+	switch (type) {
+	case WMI_REG_DEFAULT_CLIENT:
+		return "DEFAULT CLIENT";
+	case WMI_REG_SUBORDINATE_CLIENT:
+		return "SUBORDINATE CLIENT";
+	case WMI_REG_MAX_CLIENT_TYPE:
+		return "MAX_CLIENT_TYPE";
+	}
+
+	return "unknown 6 GHz client type";
+}
+
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
+
+	/* add sub-domain above, handle it in
+	 * ath11k_sub_reg_6ghz_to_str()
+	 */
+};
+
+static inline const char *
+ath11k_sub_reg_6ghz_to_str(enum reg_subdomains_6ghz sub_id)
+{
+	switch (sub_id) {
+	case EMPTY_6GHZ:
+		return "N/A";
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
+	}
+
+	return "unknown sub reg id";
+}
+
+enum reg_super_domain_6ghz {
+	FCC1_6GHZ = 0x01,
+	ETSI1_6GHZ = 0x02,
+	ETSI2_6GHZ = 0x03,
+	APL1_6GHZ = 0x04,
+	FCC1_6GHZ_CL = 0x05,
+
+	/* add super domain above, handle it in
+	 * ath11k_super_reg_6ghz_to_str()
+	 */
+};
+
+static inline const char *
+ath11k_super_reg_6ghz_to_str(enum reg_super_domain_6ghz domain_id)
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
+	}
+
+	return "unknown domain id";
+}
+
 struct cur_reg_rule {
 	u16 start_freq;
 	u16 end_freq;
-- 
2.17.1

