Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9CB5B6736
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 07:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiIMFQX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 01:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiIMFPv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 01:15:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353CD4BD00
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 22:15:50 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D2iqH0012307;
        Tue, 13 Sep 2022 05:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=8FYYGKI60JU5ZMgcDo7iSgGoUQ3GO47GZycByeRXlJ4=;
 b=bvSm/xzVKQqzLcbsZW1sQsoJyUlvZTxmZSgf77suTueIg+jkChz2lTdXLkrl5JwKYPeh
 X8szUIS7WOmp4xrZrKl/q3YxjCogQVCY0LuQx5OadnnxpLa45PUI5Vup24Wu/fX6i+mZ
 GbOIKxJ3A25QPcDj0vvV6dEhWhguCXlOQhc4EGsP9MYGKFG/8IG+ysQ8jMUd8OExGNQR
 c1C76yLKnibtEMSQmAhKbqP9YVO+9nkgaOAzHTQF/ffB9fRY9YlctT/wHxiYgbpzJtx3
 N6VgjKuvH2upqGej/CNxH+Tp8wtoIJdzRh/SVgNEbDFTkqq1HbZCbMmPQwI7DruNmxTV yQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk3gx4w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D5FkGY021668
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:46 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 22:15:44 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3 08/15] wifi: ath11k: save power spectral density(psd) of regulatory rule
Date:   Tue, 13 Sep 2022 01:15:11 -0400
Message-ID: <20220913051518.23051-9-quic_wgong@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ChsfTaUH-HIuPBkpJ3xcmt_RSmVmIpDe
X-Proofpoint-GUID: ChsfTaUH-HIuPBkpJ3xcmt_RSmVmIpDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

