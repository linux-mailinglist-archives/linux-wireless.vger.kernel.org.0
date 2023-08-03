Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769E476E117
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 09:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjHCHRd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 03:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjHCHRc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 03:17:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D228F2D5F
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 00:17:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37377hRr008636;
        Thu, 3 Aug 2023 07:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=hr6PSejjFbfeT/Qsqsxy9Z+nW8PlMxwJxhswSmoxLbI=;
 b=ZA5Q/XGbzvXxTOU/Llb7LsdFGb5fBu7gCyg74fSzj7KrQINmdK8T4GduxbOwSi9084f7
 rc/VQxO9zW3Re9ur97GrxGRwgjune4WT44eTkOpddURm/ZJOfuDYhTYiyJkzXRDvgcwm
 2LI7lzreis+GR2MsnZ9QdReaLfIHYqBFj3F0mfG5Z1O1dVFtfWBqsklKpokjIM+L5J8w
 KUbwTZnYJkQ9SebfWHAh6VJuW+6dWVW19buT2zXfr58OebghoPGLkNdnqN7ytKpuBmZ8
 OiHtHUmJbKGGL/Q5FkJZTeOshZnMisJ+h9bVKOj8H7XYSAraST6Qna8uX89JTLZNyuzg og== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s87jhg0jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 07:17:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3737HIOg017307
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 07:17:18 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 00:17:17 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, Wen Gong <quic_wgong@quicinc.com>
Subject: [PATCH v5 1/5] wifi: ath11k: add support to select 6 GHz regulatory type
Date:   Thu, 3 Aug 2023 03:16:57 -0400
Message-ID: <20230803071701.15084-2-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803071701.15084-1-quic_wgong@quicinc.com>
References: <20230803071701.15084-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 89cHtmTaP75tBr3JdijdiHepyoCDdqsl
X-Proofpoint-ORIG-GUID: 89cHtmTaP75tBr3JdijdiHepyoCDdqsl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_04,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=970 spamscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are 3 types of regulatory rules for AP mode and 6 type for
station mode. Add wmi_vdev_type and ieee80211_ap_reg_power to
select the exact reg rules.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/reg.c | 66 +++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/reg.h |  4 +-
 drivers/net/wireless/ath/ath11k/wmi.c |  3 +-
 3 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 7f9fb968dac6..516cbea37aa6 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -607,25 +607,64 @@ ath11k_reg_update_weather_radar_band(struct ath11k_base *ab,
 	*rule_idx = i;
 }
 
+static enum wmi_reg_6ghz_ap_type
+ath11k_reg_ap_pwr_convert(enum ieee80211_ap_reg_power power_type)
+{
+	switch (power_type) {
+	case IEEE80211_REG_LPI_AP:
+		return WMI_REG_INDOOR_AP;
+	case IEEE80211_REG_SP_AP:
+		return WMI_REG_STANDARD_POWER_AP;
+	case IEEE80211_REG_VLP_AP:
+		return WMI_REG_VERY_LOW_POWER_AP;
+	default:
+		return WMI_REG_MAX_AP_TYPE;
+	}
+}
+
 struct ieee80211_regdomain *
 ath11k_reg_build_regd(struct ath11k_base *ab,
-		      struct cur_regulatory_info *reg_info, bool intersect)
+		      struct cur_regulatory_info *reg_info, bool intersect,
+		      enum wmi_vdev_type vdev_type,
+		      enum ieee80211_ap_reg_power power_type)
 {
 	struct ieee80211_regdomain *tmp_regd, *default_regd, *new_regd = NULL;
-	struct cur_reg_rule *reg_rule;
+	struct cur_reg_rule *reg_rule, *reg_rule_6ghz;
 	u8 i = 0, j = 0, k = 0;
 	u8 num_rules;
 	u16 max_bw;
-	u32 flags;
+	u32 flags, reg_6ghz_number, max_bw_6ghz;
 	char alpha2[3];
 
 	num_rules = reg_info->num_5ghz_reg_rules + reg_info->num_2ghz_reg_rules;
 
-	/* FIXME: Currently taking reg rules for 6 GHz only from Indoor AP mode list.
-	 * This can be updated after complete 6 GHz regulatory support is added.
-	 */
-	if (reg_info->is_ext_reg_event)
-		num_rules += reg_info->num_6ghz_rules_ap[WMI_REG_INDOOR_AP];
+	if (reg_info->is_ext_reg_event) {
+		if (vdev_type == WMI_VDEV_TYPE_STA) {
+			enum wmi_reg_6ghz_ap_type ap_type;
+
+			ap_type = ath11k_reg_ap_pwr_convert(power_type);
+
+			if (ap_type == WMI_REG_MAX_AP_TYPE)
+				ap_type = WMI_REG_INDOOR_AP;
+			reg_6ghz_number = reg_info->num_6ghz_rules_client
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+			if (reg_6ghz_number == 0) {
+				ap_type = WMI_REG_INDOOR_AP;
+				reg_6ghz_number = reg_info->num_6ghz_rules_client
+						[ap_type][WMI_REG_DEFAULT_CLIENT];
+			}
+			reg_rule_6ghz = reg_info->reg_rules_6ghz_client_ptr
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+			max_bw_6ghz = reg_info->max_bw_6ghz_client
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+		} else {
+			reg_6ghz_number = reg_info->num_6ghz_rules_ap[WMI_REG_INDOOR_AP];
+			reg_rule_6ghz =
+				reg_info->reg_rules_6ghz_ap_ptr[WMI_REG_INDOOR_AP];
+			max_bw_6ghz = reg_info->max_bw_6ghz_ap[WMI_REG_INDOOR_AP];
+		}
+		num_rules += reg_6ghz_number;
+	}
 
 	if (!num_rules)
 		goto ret;
@@ -672,13 +711,10 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 			 * per other BW rule flags we pass from here
 			 */
 			flags = NL80211_RRF_AUTO_BW;
-		} else if (reg_info->is_ext_reg_event &&
-			   reg_info->num_6ghz_rules_ap[WMI_REG_INDOOR_AP] &&
-			   (k < reg_info->num_6ghz_rules_ap[WMI_REG_INDOOR_AP])) {
-			reg_rule = reg_info->reg_rules_6ghz_ap_ptr[WMI_REG_INDOOR_AP] +
-				   k++;
-			max_bw = min_t(u16, reg_rule->max_bw,
-				       reg_info->max_bw_6ghz_ap[WMI_REG_INDOOR_AP]);
+		} else if (reg_info->is_ext_reg_event && reg_6ghz_number &&
+			   (k < reg_6ghz_number)) {
+			reg_rule = reg_rule_6ghz + k++;
+			max_bw = min_t(u16, reg_rule->max_bw, max_bw_6ghz);
 			flags = NL80211_RRF_AUTO_BW;
 		} else {
 			break;
diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
index 2f284f26378d..4930b5c93e1e 100644
--- a/drivers/net/wireless/ath/ath11k/reg.h
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -30,7 +30,9 @@ void ath11k_reg_free(struct ath11k_base *ab);
 void ath11k_regd_update_work(struct work_struct *work);
 struct ieee80211_regdomain *
 ath11k_reg_build_regd(struct ath11k_base *ab,
-		      struct cur_regulatory_info *reg_info, bool intersect);
+		      struct cur_regulatory_info *reg_info, bool intersect,
+		      enum wmi_vdev_type vdev_type,
+		      enum ieee80211_ap_reg_power power_type);
 int ath11k_regd_update(struct ath11k *ar);
 int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 23ad6825e5be..5a6578865b25 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7150,7 +7150,8 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	    !ath11k_reg_is_world_alpha((char *)reg_info->alpha2))
 		intersect = true;
 
-	regd = ath11k_reg_build_regd(ab, reg_info, intersect);
+	regd = ath11k_reg_build_regd(ab, reg_info, intersect,
+				     WMI_VDEV_TYPE_AP, IEEE80211_REG_LPI_AP);
 	if (!regd) {
 		ath11k_warn(ab, "failed to build regd from reg_info\n");
 		goto fallback;
-- 
2.40.1

