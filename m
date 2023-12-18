Return-Path: <linux-wireless+bounces-899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE1A8168F9
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 09:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA55283091
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 08:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453311714;
	Mon, 18 Dec 2023 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KSP4NtOV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82ED11198
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI6RJ2I032738;
	Mon, 18 Dec 2023 08:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=XTdED9A08a7LAF0haY72j4cbRY9jC7bQDGs4FdxkfyM=; b=KS
	P4NtOVh2lrqhsW/pVsdEtL5O/w1ROCpRNgylAtJoqvYDIS8ptRWVlk9SD+Vw/GTn
	GM3/6V8jUyAgEfN70ech1BC+PfRq0Wo9ZmRdCJUDmQkuOtI6DK+XoHNlGjMo/Auj
	AY7N88PryYuUF+HWN5v9bxY2rvdY+SIoYIsgZve6oMeNhewwAxzwCde40AKmgHeA
	J3sv8z8u6Tam4uz7cNKeFoam50Vf/efnUNGchaMhwgae9ekqUa7vBWZQxi6akN3l
	pN8ZNmVx6LvUlMraiD5PTO1+/sEM/YP50RucA4S53KvIAwmL+Fsx8KM6eN6KyEk9
	IiGGj4LEnbaqIvVKxODA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14xvutxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:59:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI8x3GI010263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:59:03 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 00:59:02 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v10 06/12] wifi: ath11k: save power spectral density(PSD) of regulatory rule
Date: Mon, 18 Dec 2023 16:58:38 +0800
Message-ID: <20231218085844.2658-7-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218085844.2658-1-quic_bqiang@quicinc.com>
References: <20231218085844.2658-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YQImoRBNRkUVcNaIkF__0I0fQAruEps5
X-Proofpoint-ORIG-GUID: YQImoRBNRkUVcNaIkF__0I0fQAruEps5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180064

From: Wen Gong <quic_wgong@quicinc.com>

Save the power spectral density(PSD) report from firmware to struct
ieee80211_reg_rule.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v10:
 no change.
v9:
 no change.
v8:
 no change.
v7:
 1. s/psd/PSD/

 drivers/net/wireless/ath/ath11k/reg.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index b860d2fd7e5c..f27cf5264678 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -424,6 +424,10 @@ static void ath11k_reg_intersect_rules(struct ieee80211_reg_rule *rule1,
 
 	/* Use the flags of both the rules */
 	new_rule->flags = rule1->flags | rule2->flags;
+	if ((rule1->flags & NL80211_RRF_PSD) && (rule2->flags & NL80211_RRF_PSD))
+		new_rule->psd = min_t(s8, rule1->psd, rule2->psd);
+	else
+		new_rule->flags &= ~NL80211_RRF_PSD;
 
 	/* To be safe, lts use the max cac timeout of both rules */
 	new_rule->dfs_cac_ms = max_t(u32, rule1->dfs_cac_ms,
@@ -527,13 +531,14 @@ ath11k_reg_adjust_bw(u16 start_freq, u16 end_freq, u16 max_bw)
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
 
@@ -563,7 +568,7 @@ ath11k_reg_update_weather_radar_band(struct ath11k_base *ab,
 				       reg_rule->start_freq,
 				       ETSI_WEATHER_RADAR_BAND_LOW, bw,
 				       reg_rule->ant_gain, reg_rule->reg_power,
-				       flags);
+				       reg_rule->psd_eirp, flags);
 
 		ath11k_dbg(ab, ATH11K_DBG_REG,
 			   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
@@ -584,7 +589,7 @@ ath11k_reg_update_weather_radar_band(struct ath11k_base *ab,
 
 		ath11k_reg_update_rule(regd->reg_rules + i, start_freq,
 				       end_freq, bw, reg_rule->ant_gain,
-				       reg_rule->reg_power, flags);
+				       reg_rule->reg_power, reg_rule->psd_eirp, flags);
 
 		regd->reg_rules[i].dfs_cac_ms = ETSI_WEATHER_RADAR_BAND_CAC_TIMEOUT;
 
@@ -605,7 +610,7 @@ ath11k_reg_update_weather_radar_band(struct ath11k_base *ab,
 				       ETSI_WEATHER_RADAR_BAND_HIGH,
 				       reg_rule->end_freq, bw,
 				       reg_rule->ant_gain, reg_rule->reg_power,
-				       flags);
+				       reg_rule->psd_eirp, flags);
 
 		ath11k_dbg(ab, ATH11K_DBG_REG,
 			   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
@@ -727,6 +732,8 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 			reg_rule = reg_rule_6ghz + k++;
 			max_bw = min_t(u16, reg_rule->max_bw, max_bw_6ghz);
 			flags = NL80211_RRF_AUTO_BW;
+			if (reg_rule->psd_flag)
+				flags |= NL80211_RRF_PSD;
 		} else {
 			break;
 		}
@@ -738,7 +745,7 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 				       reg_rule->start_freq,
 				       reg_rule->end_freq, max_bw,
 				       reg_rule->ant_gain, reg_rule->reg_power,
-				       flags);
+				       reg_rule->psd_eirp, flags);
 
 		/* Update dfs cac timeout if the dfs domain is ETSI and the
 		 * new rule covers weather radar band.
-- 
2.25.1


