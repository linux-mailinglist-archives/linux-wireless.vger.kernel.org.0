Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EB07A5AB2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 09:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjISHRw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 03:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjISHRv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 03:17:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98067FC
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 00:17:45 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J61HIg025795;
        Tue, 19 Sep 2023 07:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=n8IkF1u3DUleBgcLLJ3DBTHJud8ansvzjEviM0cGL0c=;
 b=BE95X9JQjApWJ2TD43BwBEjq0jmUAfjTGHfq1XdaLYCFObPoLrVRWH/pE9N/Uoh2UcFb
 bfwQBPzEaITwsNiO4AyQ9CObYP4YRuhQlHVerR6JCDhjIRxLMn57+Eb+0x5alBvjxM+n
 nQex+7RZXRuOIWezsT155BnGXUbCT+QXBGGyEIsg14whDmEtYu4oTtU1wbDdBgm45QzN
 3uha0i2p3QGad9MzomhwLVulqL5JUj+l3mbq5yDWUx5akX649s3N5AQ5MGgNw/P/w8Y9
 F8rK/BWYATcY2sNR3bBxxkExh8B9mY1J11vk6EdZTCWJbsOKV1e0cdPM4Q/YHRw7SHmM ZA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t72ngre1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:17:42 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38J6xTaZ023102;
        Tue, 19 Sep 2023 07:17:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3t74xehgg4-1;
        Tue, 19 Sep 2023 07:17:41 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J7DcLP017501;
        Tue, 19 Sep 2023 07:17:41 GMT
Received: from aisr-linux.qualcomm.com (aisr-linux.qualcomm.com [10.201.124.194])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 38J7He2L024625;
        Tue, 19 Sep 2023 07:17:41 +0000
Received: by aisr-linux.qualcomm.com (Postfix, from userid 4090849)
        id 4BDD0E02320; Tue, 19 Sep 2023 12:47:39 +0530 (IST)
From:   Aishwarya R <quic_aisr@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Aishwarya R <quic_aisr@quicinc.com>
Subject: [PATCH 4/7] wifi: ath12k: save power spectral density(PSD) of regulatory rule
Date:   Tue, 19 Sep 2023 12:47:21 +0530
Message-Id: <20230919071724.15505-5-quic_aisr@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230919071724.15505-1-quic_aisr@quicinc.com>
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: evQj9cGNSQTm6hxeZoykANJ2S5J96NR7
X-Proofpoint-ORIG-GUID: evQj9cGNSQTm6hxeZoykANJ2S5J96NR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_01,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Save the Power Spectral Density(PSD) report from firmware
to struct ieee80211_reg_rule. 6 GHz regulatory domains
introduces PSD. The PSD value of the regulatory rule should
be taken into effect for the ieee80211_channels falling into
that particular regulatory rule.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 8501f77eee55..19681474026f 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -390,6 +390,10 @@ static void ath12k_reg_intersect_rules(struct ieee80211_reg_rule *rule1,
 
 	/* Use the flags of both the rules */
 	new_rule->flags = rule1->flags | rule2->flags;
+	if ((rule1->flags & NL80211_RRF_PSD) && (rule2->flags & NL80211_RRF_PSD))
+		new_rule->psd = min_t(s8, rule1->psd, rule2->psd);
+	else
+		new_rule->flags &= ~NL80211_RRF_PSD;
 
 	/* To be safe, lts use the max cac timeout of both rules */
 	new_rule->dfs_cac_ms = max_t(u32, rule1->dfs_cac_ms,
@@ -488,13 +492,14 @@ ath12k_reg_adjust_bw(u16 start_freq, u16 end_freq, u16 max_bw)
 static void
 ath12k_reg_update_rule(struct ieee80211_reg_rule *reg_rule, u32 start_freq,
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
 
@@ -516,7 +521,7 @@ ath12k_reg_update_weather_radar_band(struct ath12k_base *ab,
 	ath12k_reg_update_rule(regd->reg_rules + i, reg_rule->start_freq,
 			       ETSI_WEATHER_RADAR_BAND_LOW, bw,
 			       reg_rule->ant_gain, reg_rule->reg_power,
-			       flags);
+			       reg_rule->psd_eirp, flags);
 
 	ath12k_dbg(ab, ATH12K_DBG_REG,
 		   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
@@ -538,7 +543,7 @@ ath12k_reg_update_weather_radar_band(struct ath12k_base *ab,
 	ath12k_reg_update_rule(regd->reg_rules + i,
 			       ETSI_WEATHER_RADAR_BAND_LOW, end_freq, bw,
 			       reg_rule->ant_gain, reg_rule->reg_power,
-			       flags);
+			       reg_rule->psd_eirp, flags);
 
 	regd->reg_rules[i].dfs_cac_ms = ETSI_WEATHER_RADAR_BAND_CAC_TIMEOUT;
 
@@ -563,7 +568,7 @@ ath12k_reg_update_weather_radar_band(struct ath12k_base *ab,
 	ath12k_reg_update_rule(regd->reg_rules + i, ETSI_WEATHER_RADAR_BAND_HIGH,
 			       reg_rule->end_freq, bw,
 			       reg_rule->ant_gain, reg_rule->reg_power,
-			       flags);
+			       reg_rule->psd_eirp, flags);
 
 	ath12k_dbg(ab, ATH12K_DBG_REG,
 		   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
@@ -673,6 +678,8 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 			reg_rule = reg_rule_6ghz + k++;
 			max_bw = min_t(u16, reg_rule->max_bw, max_bw_6ghz);
 			flags = NL80211_RRF_AUTO_BW;
+			if (reg_rule->psd_flag)
+				flags |= NL80211_RRF_PSD;
 		} else {
 			break;
 		}
@@ -683,7 +690,7 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 				       reg_rule->start_freq,
 				       reg_rule->end_freq, max_bw,
 				       reg_rule->ant_gain, reg_rule->reg_power,
-				       flags);
+				       reg_rule->psd_eirp, flags);
 
 		/* Update dfs cac timeout if the dfs domain is ETSI and the
 		 * new rule covers weather radar band.
-- 
2.17.1

