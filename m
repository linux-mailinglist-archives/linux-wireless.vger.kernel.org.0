Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634B447ED77
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 09:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343731AbhLXIw7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 03:52:59 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:62138 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241541AbhLXIw6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 03:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640335978; x=1671871978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WpyDvq9b6ba/AhgjGDQiQ1fi9XvGG+yjXnml2vTqre0=;
  b=ih5h/RAP5AE/pBxbqwfPu1tepSviELoFeT/bJe84DTwzU5EEPujJynV1
   bDv7/9SiKEl6yrSIGKmKjARQvel8mxXi2gmkFZAYMARdwpMQppQtbJKUb
   BUlmTQdXtLLLU7z2jUJ8h3uK+rhNLXFMxFlX+a2cBlKROiPsOYjQZ6Dxu
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Dec 2021 00:52:58 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 00:52:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 00:52:58 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 00:52:56 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 03/15] ath11k: add support to select 6 GHz Regulatory type
Date:   Fri, 24 Dec 2021 03:52:24 -0500
Message-ID: <20211224085236.9064-4-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211224085236.9064-1-quic_wgong@quicinc.com>
References: <20211224085236.9064-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are 3 types of regulatory rules for AP mode and 6 type for
station mode. Add wmi_vdev_type and ieee80211_ap_reg_power to
select the exact reg rules.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/reg.c |  61 ++++++--
 drivers/net/wireless/ath/ath11k/reg.h |   6 +-
 drivers/net/wireless/ath/ath11k/wmi.c | 192 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h |  25 +++-
 4 files changed, 268 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 09825a41a284..5870cf57813c 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -583,16 +583,33 @@ ath11k_reg_update_weather_radar_band(struct ath11k_base *ab,
 	*rule_idx = i;
 }
 
+enum wmi_reg_6g_ap_type
+ath11k_ieee80211_ap_pwr_type_convert(enum ieee80211_ap_reg_power power_type)
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
+	struct cur_reg_rule *reg_rule, *reg_rule_6g;
 	u8 i = 0, j = 0, k = 0;
 	u8 num_rules;
 	u16 max_bw;
-	u32 flags;
+	u32 flags, reg_6g_number, max_bw_6g;
 	char alpha2[3];
 
 	num_rules = reg_info->num_5g_reg_rules + reg_info->num_2g_reg_rules;
@@ -601,8 +618,32 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 	 * This can be updated to choose the combination dynamically based on AP
 	 * type and client type, after complete 6 GHz regulatory support is added.
 	 */
-	if (reg_info->is_ext_reg_event)
-		num_rules += reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP];
+	if (reg_info->is_ext_reg_event) {
+		if (vdev_type == WMI_VDEV_TYPE_STA) {
+			enum wmi_reg_6g_ap_type ap_type;
+
+			ap_type = ath11k_ieee80211_ap_pwr_type_convert(power_type);
+
+			if (ap_type == WMI_REG_MAX_AP_TYPE)
+				ap_type = WMI_REG_INDOOR_AP;
+			reg_6g_number = reg_info->num_6g_reg_rules_client
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+			if (reg_6g_number == 0) {
+				ap_type = WMI_REG_INDOOR_AP;
+				reg_6g_number = reg_info->num_6g_reg_rules_client
+						[ap_type][WMI_REG_DEFAULT_CLIENT];
+			}
+			reg_rule_6g = reg_info->reg_rules_6g_client_ptr
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+			max_bw_6g = reg_info->max_bw_6g_client
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+		} else {
+			reg_6g_number = reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP];
+			reg_rule_6g = reg_info->reg_rules_6g_ap_ptr[WMI_REG_INDOOR_AP];
+			max_bw_6g = reg_info->max_bw_6g_ap[WMI_REG_INDOOR_AP];
+		}
+		num_rules += reg_6g_number;
+	}
 
 	if (!num_rules)
 		goto ret;
@@ -649,12 +690,10 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 			 * per other BW rule flags we pass from here
 			 */
 			flags = NL80211_RRF_AUTO_BW;
-		} else if (reg_info->is_ext_reg_event &&
-			   reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP] &&
-			   (k < reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP])) {
-			reg_rule = reg_info->reg_rules_6g_ap_ptr[WMI_REG_INDOOR_AP] + k++;
-			max_bw = min_t(u16, reg_rule->max_bw,
-				       reg_info->max_bw_6g_ap[WMI_REG_INDOOR_AP]);
+		} else if (reg_info->is_ext_reg_event && reg_6g_number &&
+			   (k < reg_6g_number)) {
+			reg_rule = reg_rule_6g + k++;
+			max_bw = min_t(u16, reg_rule->max_bw, max_bw_6g);
 			flags = NL80211_RRF_AUTO_BW;
 		} else {
 			break;
diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
index 5fb9dc03a74e..a7b9dd281598 100644
--- a/drivers/net/wireless/ath/ath11k/reg.h
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -30,7 +30,11 @@ void ath11k_reg_free(struct ath11k_base *ab);
 void ath11k_regd_update_work(struct work_struct *work);
 struct ieee80211_regdomain *
 ath11k_reg_build_regd(struct ath11k_base *ab,
-		      struct cur_regulatory_info *reg_info, bool intersect);
+		      struct cur_regulatory_info *reg_info, bool intersect,
+		      enum wmi_vdev_type vdev_type,
+		      enum ieee80211_ap_reg_power power_type);
+enum wmi_reg_6g_ap_type
+ath11k_ieee80211_ap_pwr_type_convert(enum ieee80211_ap_reg_power power_type);
 int ath11k_regd_update(struct ath11k *ar);
 int ath11k_reg_update_chan_list(struct ath11k *ar);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5f389aa18ebc..fa87cf0dc390 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4725,6 +4725,26 @@ static struct cur_reg_rule
 	return reg_rule_ptr;
 }
 
+static char *ath11k_cc_status_to_str(enum cc_setting_code code)
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
 static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 					       struct sk_buff *skb,
 					       struct cur_regulatory_info *reg_info)
@@ -4791,6 +4811,10 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 	num_2g_reg_rules = reg_info->num_2g_reg_rules;
 	num_5g_reg_rules = reg_info->num_5g_reg_rules;
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "%s: status_code %s", __func__,
+		   ath11k_cc_status_to_str(reg_info->status_code));
+
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
 		   "%s:cc %s dsf %d BW: min_2g %d max_2g %d min_5g %d max_5g %d",
 		   __func__, reg_info->alpha2, reg_info->dfs_region,
@@ -4833,6 +4857,99 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 	return 0;
 }
 
+static char *ath11k_super_reg_6g_to_str(enum reg_super_domain_6g domain_id)
+{
+	switch (domain_id) {
+	case FCC1_6G:
+		return "FCC1_6G";
+	case ETSI1_6G:
+		return "ETSI1_6G";
+	case ETSI2_6G:
+		return "ETSI2_6G";
+	case APL1_6G:
+		return "APL1_6G";
+	case FCC1_6G_CL:
+		return "FCC1_6G_CL";
+	default:
+		return "unknown domain id";
+	}
+};
+
+static char *ath11k_6g_client_type_to_str(enum wmi_reg_6g_client_type type)
+{
+	switch (type) {
+	case WMI_REG_DEFAULT_CLIENT:
+		return "DEFAULT CLIENT";
+	case WMI_REG_SUBORDINATE_CLIENT:
+		return "SUBORDINATE CLIENT";
+	default:
+		return "unknown client type";
+	}
+};
+
+static char *ath11k_6g_ap_type_to_str(enum wmi_reg_6g_ap_type type)
+{
+	switch (type) {
+	case WMI_REG_INDOOR_AP:
+		return "INDOOR AP";
+	case WMI_REG_STANDARD_POWER_AP:
+		return "STANDARD POWER AP";
+	case WMI_REG_VERY_LOW_POWER_AP:
+		return "VERY LOW POWER AP";
+	default:
+		return "unknown AP type";
+	}
+};
+
+static char *ath11k_sub_reg_6g_to_str(enum reg_subdomains_6g sub_id)
+{
+	switch (sub_id) {
+	case FCC1_CLIENT_LPI_REGULAR_6G:
+		return "FCC1_CLIENT_LPI_REGULAR_6G";
+	case FCC1_CLIENT_SP_6G:
+		return "FCC1_CLIENT_SP_6G";
+	case FCC1_AP_LPI_6G:
+		return "FCC1_AP_LPI_6G/FCC1_CLIENT_LPI_SUBORDINATE";
+	case FCC1_AP_SP_6G:
+		return "FCC1_AP_SP_6G";
+	case ETSI1_LPI_6G:
+		return "ETSI1_LPI_6G";
+	case ETSI1_VLP_6G:
+		return "ETSI1_VLP_6G";
+	case ETSI2_LPI_6G:
+		return "ETSI2_LPI_6G";
+	case ETSI2_VLP_6G:
+		return "ETSI2_VLP_6G";
+	case APL1_LPI_6G:
+		return "APL1_LPI_6G";
+	case APL1_VLP_6G:
+		return "APL1_VLP_6G";
+	case EMPTY_6G:
+		return "N/A";
+	default:
+		return "unknown sub reg id";
+	}
+};
+
+static void ath11k_print_reg_rule(struct ath11k_base *ab, char *prev,
+				  u32 num_reg_rules,
+				  struct cur_reg_rule *reg_rule_ptr)
+{
+	struct cur_reg_rule *reg_rule = reg_rule_ptr;
+	u32 count;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "%s reg rules number %d\n", prev, num_reg_rules);
+
+	for (count = 0; count < num_reg_rules; count++) {
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "reg rule %d: (%d - %d @ %d) (%d, %d) (FLAGS %d) (psd flag %d EIRP %d dB/MHz)\n",
+			   count + 1, reg_rule->start_freq, reg_rule->end_freq,
+			   reg_rule->max_bw, reg_rule->ant_gain, reg_rule->reg_power,
+			   reg_rule->flags, reg_rule->psd_flag, reg_rule->psd_eirp);
+		reg_rule++;
+	}
+}
+
 static struct cur_reg_rule
 *create_ext_reg_rules_from_wmi(u32 num_reg_rules,
 			       const struct wmi_regulatory_ext_rule *wmi_reg_rule)
@@ -4990,6 +5107,10 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 	 * from 5 GHz rules list.
 	 */
 	if (memcmp(reg_info->alpha2, "US", 2) == 0) {
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "US 5g reg rules number %d from firmware",
+			   reg_info->num_5g_reg_rules);
+
 		reg_info->num_5g_reg_rules = REG_US_5G_NUM_REG_RULES;
 		num_5g_reg_rules = reg_info->num_5g_reg_rules;
 	}
@@ -5022,6 +5143,10 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 		break;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "%s: status_code %s", __func__,
+		   ath11k_cc_status_to_str(reg_info->status_code));
+
 	reg_info->is_ext_reg_event = true;
 
 	reg_info->min_bw_2g = ext_chan_list_event_hdr->min_bw_2g;
@@ -5041,6 +5166,15 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 	reg_info->max_bw_6g_ap[WMI_REG_VERY_LOW_POWER_AP] =
 			ext_chan_list_event_hdr->max_bw_6g_ap_vlp;
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "6 GHz AP BW: lpi %d - %d sp %d - %d vlp %d - %d\n",
+		   ext_chan_list_event_hdr->min_bw_6g_ap_lpi,
+		   ext_chan_list_event_hdr->max_bw_6g_ap_lpi,
+		   ext_chan_list_event_hdr->min_bw_6g_ap_sp,
+		   ext_chan_list_event_hdr->max_bw_6g_ap_sp,
+		   ext_chan_list_event_hdr->min_bw_6g_ap_vlp,
+		   ext_chan_list_event_hdr->max_bw_6g_ap_vlp);
+
 	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
 		reg_info->min_bw_6g_client[WMI_REG_INDOOR_AP][i] =
 				ext_chan_list_event_hdr->min_bw_6g_client_lpi[i];
@@ -5054,6 +5188,17 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 				ext_chan_list_event_hdr->min_bw_6g_client_vlp[i];
 		reg_info->max_bw_6g_client[WMI_REG_VERY_LOW_POWER_AP][i] =
 				ext_chan_list_event_hdr->max_bw_6g_client_vlp[i];
+
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "6 GHz %s BW: lpi (%d - %d) sp (%d - %d) vlp (%d - %d)\n",
+			   ath11k_6g_client_type_to_str(i),
+			   ext_chan_list_event_hdr->min_bw_6g_client_lpi[i],
+			   ext_chan_list_event_hdr->max_bw_6g_client_lpi[i],
+			   ext_chan_list_event_hdr->min_bw_6g_client_sp[i],
+			   ext_chan_list_event_hdr->max_bw_6g_client_sp[i],
+			   ext_chan_list_event_hdr->min_bw_6g_client_vlp[i],
+			   ext_chan_list_event_hdr->max_bw_6g_client_vlp[i]);
+
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
@@ -5096,6 +5241,9 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 			ath11k_warn(ab, "Unable to Allocate memory for 2g rules\n");
 			return -ENOMEM;
 		}
+		ath11k_print_reg_rule(ab, "2g",
+				      num_2g_reg_rules,
+				      reg_info->reg_rules_2g_ptr);
 	}
 
 	if (num_5g_reg_rules) {
@@ -5109,6 +5257,9 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 			ath11k_warn(ab, "Unable to Allocate memory for 5g rules\n");
 			return -ENOMEM;
 		}
+		ath11k_print_reg_rule(ab, "5g",
+				      num_5g_reg_rules,
+				      reg_info->reg_rules_5g_ptr);
 	}
 
 	ext_wmi_reg_rule += num_5g_reg_rules;
@@ -5124,10 +5275,17 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 			return -ENOMEM;
 		}
 
+		ath11k_print_reg_rule(ab, ath11k_6g_ap_type_to_str(i),
+				      num_6g_reg_rules_ap[i],
+				      reg_info->reg_rules_6g_ap_ptr[i]);
+
 		ext_wmi_reg_rule += num_6g_reg_rules_ap[i];
 	}
 
 	for (j = 0; j < WMI_REG_CURRENT_MAX_AP_TYPE; j++) {
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "AP type %s", ath11k_6g_ap_type_to_str(j));
+
 		for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
 			reg_info->reg_rules_6g_client_ptr[j][i] =
 				create_ext_reg_rules_from_wmi(num_6g_client[j][i],
@@ -5139,6 +5297,10 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 				return -ENOMEM;
 			}
 
+			ath11k_print_reg_rule(ab, ath11k_6g_client_type_to_str(i),
+					      num_6g_client[j][i],
+					      reg_info->reg_rules_6g_client_ptr[j][i]);
+
 			ext_wmi_reg_rule += num_6g_client[j][i];
 		}
 	}
@@ -5154,6 +5316,18 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 	reg_info->domain_code_6g_ap[WMI_REG_VERY_LOW_POWER_AP] =
 			ext_chan_list_event_hdr->domain_code_6g_ap_vlp;
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "6 GHz reg info client type %s rnr_tpe_usable %d unspecified_ap_usable %d AP sub domain: lpi %s , sp %s , vlp %s\n",
+		   ath11k_6g_client_type_to_str(reg_info->client_type),
+		   reg_info->rnr_tpe_usable,
+		   reg_info->unspecified_ap_usable,
+		   ath11k_sub_reg_6g_to_str
+		   (ext_chan_list_event_hdr->domain_code_6g_ap_lpi),
+		   ath11k_sub_reg_6g_to_str
+		   (ext_chan_list_event_hdr->domain_code_6g_ap_sp),
+		   ath11k_sub_reg_6g_to_str
+		   (ext_chan_list_event_hdr->domain_code_6g_ap_vlp));
+
 	for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++) {
 		reg_info->domain_code_6g_client[WMI_REG_INDOOR_AP][i] =
 				ext_chan_list_event_hdr->domain_code_6g_client_lpi[i];
@@ -5161,13 +5335,24 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 				ext_chan_list_event_hdr->domain_code_6g_client_sp[i];
 		reg_info->domain_code_6g_client[WMI_REG_VERY_LOW_POWER_AP][i] =
 				ext_chan_list_event_hdr->domain_code_6g_client_vlp[i];
+
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "6 GHz client type %s client sub domain: lpi %s , sp %s , vlp %s\n",
+			   ath11k_6g_client_type_to_str(i),
+			   ath11k_sub_reg_6g_to_str
+			   (ext_chan_list_event_hdr->domain_code_6g_client_lpi[i]),
+			   ath11k_sub_reg_6g_to_str
+			   (ext_chan_list_event_hdr->domain_code_6g_client_sp[i]),
+			   ath11k_sub_reg_6g_to_str
+			   (ext_chan_list_event_hdr->domain_code_6g_client_vlp[i]));
 	}
 
 	reg_info->domain_code_6g_super_id =
 			ext_chan_list_event_hdr->domain_code_6g_super_id;
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "6 GHz client_type: %d domain_code_6g_super_id: %d",
-		   reg_info->client_type, reg_info->domain_code_6g_super_id);
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "6 GHz client type %s 6 GHz super domain %s",
+		   ath11k_6g_client_type_to_str(reg_info->client_type),
+		   ath11k_super_reg_6g_to_str(reg_info->domain_code_6g_super_id));
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI, "processed regulatory ext channel list\n");
 
@@ -6680,7 +6865,8 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	    !ath11k_reg_is_world_alpha((char *)reg_info->alpha2))
 		intersect = true;
 
-	regd = ath11k_reg_build_regd(ab, reg_info, intersect);
+	regd = ath11k_reg_build_regd(ab, reg_info, intersect,
+				     WMI_VDEV_TYPE_AP, IEEE80211_REG_UNSET_AP);
 	if (!regd) {
 		ath11k_warn(ab, "failed to build regd from reg_info\n");
 		goto fallback;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 02c518e95121..9d36f5774fa9 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4142,7 +4142,30 @@ struct cur_reg_rule {
 	u8 ant_gain;
 	u16 flags;
 	bool psd_flag;
-	u16 psd_eirp;
+	s8 psd_eirp;
+};
+
+enum reg_subdomains_6g {
+	EMPTY_6G = 0x0,
+	FCC1_CLIENT_LPI_REGULAR_6G = 0x01,
+	FCC1_CLIENT_SP_6G = 0x02,
+	FCC1_AP_LPI_6G = 0x03,
+	FCC1_CLIENT_LPI_SUBORDINATE = FCC1_AP_LPI_6G,
+	FCC1_AP_SP_6G = 0x04,
+	ETSI1_LPI_6G = 0x10,
+	ETSI1_VLP_6G = 0x11,
+	ETSI2_LPI_6G = 0x12,
+	ETSI2_VLP_6G = 0x13,
+	APL1_LPI_6G = 0x20,
+	APL1_VLP_6G = 0x21,
+};
+
+enum reg_super_domain_6g {
+	FCC1_6G = 0x01,
+	ETSI1_6G = 0x02,
+	ETSI2_6G = 0x03,
+	APL1_6G = 0x04,
+	FCC1_6G_CL = 0x05,
 };
 
 struct cur_regulatory_info {
-- 
2.31.1

