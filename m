Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC2543B111
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 13:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhJZLWP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 07:22:15 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:47817 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbhJZLWO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 07:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635247191; x=1666783191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J1ObEXw5Z+lVr0sJqYope9tZrWqDzCZAkTBcMGLQ680=;
  b=NlL+PPCsqNpbrEZyexw4rXd9KGHRZ9rPZH6Jtan8Q8lhqrWwHeGxex7W
   wQouGNn1VBfWU0H1+4EEG0Wh090rVEedkL6XQYYm76VU6ase805ka0WTj
   sZV34K+4s/zqqnWXlK9I6cXpLhKN6LLAtusrq4MWdBltq0dpzHWbnD8hH
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 04:19:51 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 04:19:51 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 04:19:49 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 02/15] ath11k: Add support to parse new wmi event for 6 GHz regulatory
Date:   Tue, 26 Oct 2021 07:19:00 -0400
Message-ID: <20211026111913.7346-3-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026111913.7346-1-quic_wgong@quicinc.com>
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
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
 drivers/net/wireless/ath/ath11k/core.c |   1 +
 drivers/net/wireless/ath/ath11k/core.h |   6 +
 drivers/net/wireless/ath/ath11k/hw.h   |   1 +
 drivers/net/wireless/ath/ath11k/reg.c  |  37 ++-
 drivers/net/wireless/ath/ath11k/wmi.c  | 378 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h  | 118 ++++++++
 6 files changed, 530 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b8c95300f34a..66ceef24532d 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -230,6 +230,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
 		.fix_l1ss = false,
+		.support_ext_cc = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 67b843a92344..a65f7d00eea2 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -966,4 +966,10 @@ static inline const char *ath11k_bus_str(enum ath11k_bus bus)
 	return "unknown";
 }
 
+static inline bool ath11k_support_cc_ext(struct ath11k_base *ab)
+{
+	return ab->hw_params.support_ext_cc &&
+	       test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT, ab->wmi_ab.svc_map);
+}
+
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index b17c37e9eda7..86fd9dc82983 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -164,6 +164,7 @@ struct ath11k_hw_params {
 	bool supports_suspend;
 	u32 hal_desc_sz;
 	bool fix_l1ss;
+	bool support_ext_cc;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 3e99c95fdf28..efd047ccf0df 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -583,7 +583,7 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 {
 	struct ieee80211_regdomain *tmp_regd, *default_regd, *new_regd = NULL;
 	struct cur_reg_rule *reg_rule;
-	u8 i = 0, j = 0;
+	u8 i = 0, j = 0, k = 0;
 	u8 num_rules;
 	u16 max_bw;
 	u32 flags;
@@ -591,6 +591,13 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 
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
 
@@ -636,6 +643,13 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
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
@@ -663,12 +677,21 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
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
index 69c7b8355e52..ff3a7bbbb27e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -96,6 +96,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		= { .min_len = sizeof(struct wmi_vdev_stopped_event) },
 	[WMI_TAG_REG_CHAN_LIST_CC_EVENT]
 		= { .min_len = sizeof(struct wmi_reg_chan_list_cc_event) },
+	[WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT]
+		= { .min_len = sizeof(struct wmi_reg_chan_list_cc_ext_event) },
 	[WMI_TAG_MGMT_RX_HDR]
 		= { .min_len = sizeof(struct wmi_mgmt_rx_hdr) },
 	[WMI_TAG_MGMT_TX_COMPL_EVENT]
@@ -3536,6 +3538,10 @@ ath11k_wmi_copy_resource_config(struct wmi_resource_config *wmi_cfg,
 	wmi_cfg->sched_params = tg_cfg->sched_params;
 	wmi_cfg->twt_ap_pdev_count = tg_cfg->twt_ap_pdev_count;
 	wmi_cfg->twt_ap_sta_count = tg_cfg->twt_ap_sta_count;
+	wmi_cfg->host_service_flags &=
+		~(1 << WMI_CFG_HOST_SERVICE_FLAG_REG_CC_EXT);
+	wmi_cfg->host_service_flags |= tg_cfg->is_reg_cc_ext_event_supported <<
+				       WMI_CFG_HOST_SERVICE_FLAG_REG_CC_EXT;
 }
 
 static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
@@ -3754,6 +3760,9 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 
 	ab->hw_params.hw_ops->wmi_init_config(ab, &config);
 
+	if (ath11k_support_cc_ext(ab))
+		config.is_reg_cc_ext_event_supported = 1;
+
 	memcpy(&wmi_sc->wlan_resource_config, &config, sizeof(config));
 
 	init_param.res_cfg = &wmi_sc->wlan_resource_config;
@@ -4569,6 +4578,8 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 	else if (chan_list_event_hdr->status_code == WMI_REG_SET_CC_STATUS_FAIL)
 		reg_info->status_code = REG_SET_CC_STATUS_FAIL;
 
+	reg_info->is_ext_reg_event = false;
+
 	reg_info->min_bw_2g = chan_list_event_hdr->min_bw_2g;
 	reg_info->max_bw_2g = chan_list_event_hdr->max_bw_2g;
 	reg_info->min_bw_5g = chan_list_event_hdr->min_bw_5g;
@@ -4619,6 +4630,348 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
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
+	struct wmi_regulatory_ext_rule *ext_wmi_reg_rule;
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
@@ -5797,12 +6150,14 @@ static bool ath11k_reg_is_world_alpha(char *alpha)
 	return alpha[0] == '0' && alpha[1] == '0';
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
@@ -5811,7 +6166,11 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *sk
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
@@ -5906,6 +6265,14 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *sk
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
@@ -7045,7 +7412,10 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
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
index 79e9140b40d0..53aa4167db7f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -769,6 +769,7 @@ enum wmi_tlv_event_id {
 	WMI_RMC_NEW_LEADER_EVENTID = WMI_TLV_CMD(WMI_GRP_RMC),
 	WMI_REG_CHAN_LIST_CC_EVENTID = WMI_TLV_CMD(WMI_GRP_REGULATORY),
 	WMI_11D_NEW_COUNTRY_EVENTID,
+	WMI_REG_CHAN_LIST_CC_EXT_EVENTID,
 	WMI_NDI_CAP_RSP_EVENTID = WMI_TLV_CMD(WMI_GRP_PROTOTYPE),
 	WMI_NDP_INITIATOR_RSP_EVENTID,
 	WMI_NDP_RESPONDER_RSP_EVENTID,
@@ -1834,6 +1835,9 @@ enum wmi_tlv_tag {
 	WMI_TAG_PDEV_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
 	WMI_TAG_PDEV_NON_SRG_OBSS_COLOR_ENABLE_BITMAP_CMD,
 	WMI_TAG_PDEV_NON_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
+	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
+	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
+
 	WMI_TAG_MAX
 };
 
@@ -2061,6 +2065,8 @@ enum wmi_tlv_service {
 
 	WMI_MAX_EXT_SERVICE = 256,
 
+	WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT = 281,
+
 	WMI_MAX_EXT2_SERVICE
 };
 
@@ -2246,6 +2252,8 @@ struct wmi_init_cmd {
 	u32 num_host_mem_chunks;
 } __packed;
 
+#define WMI_CFG_HOST_SERVICE_FLAG_REG_CC_EXT 4
+
 struct wmi_resource_config {
 	u32 tlv_header;
 	u32 num_vdevs;
@@ -2305,6 +2313,15 @@ struct wmi_resource_config {
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
@@ -2773,6 +2790,8 @@ struct rx_reorder_queue_remove_params {
 #define REG_RULE_MAX_BW				0x0000ffff
 #define REG_RULE_REG_PWR			0x00ff0000
 #define REG_RULE_ANT_GAIN			0xff000000
+#define REG_RULE_PSD_INFO			BIT(0)
+#define REG_RULE_PSD_EIRP			0xff0000
 
 #define WMI_VDEV_PARAM_TXBF_SU_TX_BFEE BIT(0)
 #define WMI_VDEV_PARAM_TXBF_MU_TX_BFEE BIT(1)
@@ -3935,6 +3954,8 @@ struct wmi_he_rate_set {
 
 #define MAX_REG_RULES 10
 #define REG_ALPHA2_LEN 2
+#define MAX_6G_REG_RULES 5
+#define REG_US_5G_NUM_REG_RULES 4
 
 enum wmi_start_event_param {
 	WMI_VDEV_START_RESP_EVENT = 0,
@@ -3997,6 +4018,21 @@ enum {
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
@@ -4004,6 +4040,8 @@ struct cur_reg_rule {
 	u8 reg_power;
 	u8 ant_gain;
 	u16 flags;
+	bool psd_flag;
+	u16 psd_eirp;
 };
 
 struct cur_regulatory_info {
@@ -4015,6 +4053,7 @@ struct cur_regulatory_info {
 	u8 alpha2[REG_ALPHA2_LEN + 1];
 	u32 dfs_region;
 	u32 phybitmap;
+	bool is_ext_reg_event;
 	u32 min_bw_2g;
 	u32 max_bw_2g;
 	u32 min_bw_5g;
@@ -4023,6 +4062,29 @@ struct cur_regulatory_info {
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
@@ -4053,6 +4115,61 @@ struct wmi_vdev_delete_resp_event {
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
@@ -5051,6 +5168,7 @@ struct target_resource_config {
 	u32 sched_params;
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
+	u8 is_reg_cc_ext_event_supported;
 };
 
 #define WMI_MAX_MEM_REQS 32
-- 
2.31.1

