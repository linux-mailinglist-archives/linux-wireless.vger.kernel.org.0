Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5253B47ED7B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 09:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352056AbhLXIxH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 03:53:07 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:62138 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352103AbhLXIxG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 03:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640335986; x=1671871986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8FYYGKI60JU5ZMgcDo7iSgGoUQ3GO47GZycByeRXlJ4=;
  b=UTPk2x5JF6u4hkBIeBjUm9enx93MHn2fEAsph+nbmTeIGiRiNkGLfR6w
   WocpymYa6j8iJ/gwXbQLL6qn2jzPICG+PMUtHYrEbBUhkpvbuAeTLnyX0
   MYInkdYi5Tv/caLMLNd3oHcZ37yEfFx5IUNR5MEMpoM7CYXCLbQ9xzzsN
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Dec 2021 00:53:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 00:53:05 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 00:53:05 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 00:53:04 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 08/15] ath11k: save power spectral density(psd) of regulatory rule
Date:   Fri, 24 Dec 2021 03:52:29 -0500
Message-ID: <20211224085236.9064-9-quic_wgong@quicinc.com>
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

Save the power spectral density(psd) report from firmware to struct
ieee80211_reg_rule.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/reg.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index f23a351d3f1e..20aaa1ea3d2a 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -389,6 +389,10 @@ static void ath11k_reg_intersect_rules(struct ieee80211_reg_rule *rule1,
 
 	/* Use the flags of both the rules */
 	new_rule->flags = rule1->flags | rule2->flags;
+	if ((rule1->flags & NL80211_RRF_PSD) && (rule2->flags & NL80211_RRF_PSD))
+		new_rule->psd = min_t(s8, rule1->psd, rule2->psd);
+	else
+		new_rule->flags &= ~NL80211_RRF_PSD;
 
 	/* To be safe, lts use the max cac timeout of both rules */
 	new_rule->dfs_cac_ms = max_t(u32, rule1->dfs_cac_ms,
@@ -492,13 +496,14 @@ ath11k_reg_adjust_bw(u16 start_freq, u16 end_freq, u16 max_bw)
 static void
 ath11k_reg_update_rule(struct ieee80211_reg_rule *reg_rule, u32 start_freq,
 		       u32 end_freq, u32 bw, u32 ant_gain, u32 reg_pwr,
-		       u32 reg_flags)
+		       s8 psd, u32 reg_flags)
 {
 	reg_rule->freq_range.start_freq_khz = MHZ_TO_KHZ(start_freq);
 	reg_rule->freq_range.end_freq_khz = MHZ_TO_KHZ(end_freq);
 	reg_rule->freq_range.max_bandwidth_khz = MHZ_TO_KHZ(bw);
 	reg_rule->power_rule.max_antenna_gain = DBI_TO_MBI(ant_gain);
 	reg_rule->power_rule.max_eirp = DBM_TO_MBM(reg_pwr);
+	reg_rule->psd = psd;
 	reg_rule->flags = reg_flags;
 }
 
@@ -528,7 +533,7 @@ ath11k_reg_update_weather_radar_band(struct ath11k_base *ab,
 				       reg_rule->start_freq,
 				       ETSI_WEATHER_RADAR_BAND_LOW, bw,
 				       reg_rule->ant_gain, reg_rule->reg_power,
-				       flags);
+				       reg_rule->psd_eirp, flags);
 
 		ath11k_dbg(ab, ATH11K_DBG_REG,
 			   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
@@ -549,7 +554,7 @@ ath11k_reg_update_weather_radar_band(struct ath11k_base *ab,
 
 		ath11k_reg_update_rule(regd->reg_rules + i, start_freq,
 				       end_freq, bw, reg_rule->ant_gain,
-				       reg_rule->reg_power, flags);
+				       reg_rule->reg_power, reg_rule->psd_eirp, flags);
 
 		regd->reg_rules[i].dfs_cac_ms = ETSI_WEATHER_RADAR_BAND_CAC_TIMEOUT;
 
@@ -570,7 +575,7 @@ ath11k_reg_update_weather_radar_band(struct ath11k_base *ab,
 				       ETSI_WEATHER_RADAR_BAND_HIGH,
 				       reg_rule->end_freq, bw,
 				       reg_rule->ant_gain, reg_rule->reg_power,
-				       flags);
+				       reg_rule->psd_eirp, flags);
 
 		ath11k_dbg(ab, ATH11K_DBG_REG,
 			   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
@@ -695,6 +700,8 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 			reg_rule = reg_rule_6g + k++;
 			max_bw = min_t(u16, reg_rule->max_bw, max_bw_6g);
 			flags = NL80211_RRF_AUTO_BW;
+			if (reg_rule->psd_flag)
+				flags |= NL80211_RRF_PSD;
 		} else {
 			break;
 		}
@@ -705,7 +712,7 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 				       reg_rule->start_freq,
 				       reg_rule->end_freq, max_bw,
 				       reg_rule->ant_gain, reg_rule->reg_power,
-				       flags);
+				       reg_rule->psd_eirp, flags);
 
 		/* Update dfs cac timeout if the dfs domain is ETSI and the
 		 * new rule covers weather radar band.
-- 
2.31.1

