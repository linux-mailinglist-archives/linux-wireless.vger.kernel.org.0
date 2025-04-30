Return-Path: <linux-wireless+bounces-22281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F82AA509C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 17:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D7C189F5BA
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB543204F9C;
	Wed, 30 Apr 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wdmc0dgq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AAE2DC760
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746027761; cv=none; b=Cz1OvPzEHx9Fv9y/OLRmEDq0GGnUxSHwZvX6YY6xe/3/uUbHtpuRzwVlNHS1rPZOwg2+4En3tv3YN5ih7WSnpDKty7VkKi05u5c9twSxkLNsvWzCIuWYGuTsair0eH+IFGD3IqVIvJgR1zXitav4JktoPEtJBd09REDvntrGOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746027761; c=relaxed/simple;
	bh=woFoXOLadEUAsg4DlOaEPa+E1O871VyQeBIsURbYJEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U6srywlKc6lWKlx5yESFNie9a60nurWqRQA+yWUeQZ/63aEreFV4/OfHnmnwH2C5dciDz86K2FdWEvSRLHUqMyf9aQq6FL+yePBucyGGr6TNSlk8bwKrmuneiqLp75i8y1BONHFT9BHlr2xvDjSkiPjL1Fa//hIPWPLzmWH+aWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wdmc0dgq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53U9bAbd000731;
	Wed, 30 Apr 2025 15:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LRfW99nOsu+o+0KFkM+QX2
	uIWyaG7IcpRjY/IbHsvRE=; b=Wdmc0dgqeiZlMigzVpxvxJSvG91lmAU+2485BG
	epyUKHHR6lY0G8SowciZYZHNx3t1brfK4696P0M+DWqXMYm4dgXkfvyVDS2qw8ea
	CN2iPBmyF2c+QqLG7nuDYN2oBba3SVysllNXg+CNpsvpxfOuhmUWSKDo2UA+FVN6
	dOMPlSQ5TF5eN9RtQ8W4FkIinq6RCfUeoCtFRDLZNLXqXAVNR7vwzMgD5tRhsAMc
	kcxOVb0xPiwBoWbdkGU3DrmRr3OCtLx2GmxLGN+ugDaQBmfPdHFmW3+tKclZaZEK
	fY1nEg9RjZywTijrswyNUTcxpSd1Dz2cbvQybyT0GX0OlfAA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u2aqew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 15:42:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53UFgXcI025985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 15:42:33 GMT
Received: from hu-rajson-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Apr 2025 08:42:31 -0700
From: Rajat Soni <quic_rajson@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Aishwarya R <quic_aisr@quicinc.com>,
        Rajat Soni <quic_rajson@quicinc.com>
Subject: [PATCH ath-next] wifi: ath12k: remove redundant regulatory rules intersection logic in host
Date: Wed, 30 Apr 2025 21:12:11 +0530
Message-ID: <20250430154211.669502-1-quic_rajson@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FelgGtbUmCpczhe-E0j8dVqibhhIlIBi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDExMiBTYWx0ZWRfXzog0JwQCHMIU Rmdz61NofNRVo+fbNvJfxBrPjXFrNPGY5TBMowvCr+onVfuEFAB8VU/oUMfxvUe0SOa4vMX/l9C +g/JvBKgOexSP4vwGo0coEdCKmfO7A2GhDZttJsBfMFPWS0F8vXBIayynGPE+UllouibGwkvQAl
 DZB/+I3lSFR/yRmE9ntihBCuy8tCIiVgIszol/UFSi69dOKbq8eMxAhO0kx8r6bk08C2GuZ02VF vKzeLl7saPA1swUZr/K0B5azw8PVydkSeAcTg73AY2q2gTOTVl2BTCcqSQjnZEuGrIUK6paP1Uv NJ72e8MiSIi+Dt//y19xPOSUSSeu1riJNRpaIjKvUuCWRsW2gPO/dR1VxiVQ5CcEG8ZyB3mT92N
 bP0L6s4BChRQgieBVRIT8moqC5rWKJlqWmI9N5Ffgfz+JrNqilydrQ4VBTRGksRfCDNGCa14
X-Authority-Analysis: v=2.4 cv=b5qy4sGx c=1 sm=1 tr=0 ts=681244ea cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=bctMepNisiZQuO0GxY0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: FelgGtbUmCpczhe-E0j8dVqibhhIlIBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300112

From: Aishwarya R <quic_aisr@quicinc.com>

Whenever there is a change in the country code settings from the
user, driver does an intersection of the regulatory rules for this
new country with the original regulatory rules which were reported
during initialization time.

There is also similar logic running in firmware with a difference
that the intersection in firmware is only done when the country code
is configuration during boot up time (BDF/OTP). Firmware logic does
not kick in when no country code is configured during device bring
up time as the device is always expected to have the country code
configured properly in the deployment.

There is a debug/test use case that requires absolute regulatory
rules to be used for a user configured country code when the device
is not configured with a particular country code during boot up time.

To support the above test use case, remove the redundant regulatory
rules intersection logic in the host driver. Depend on the
intersection logic in firmware when the device comes up with
pre-configured country code.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 164 ++------------------------
 drivers/net/wireless/ath/ath12k/reg.h |   3 +-
 drivers/net/wireless/ath/ath12k/wmi.c |  24 +---
 3 files changed, 14 insertions(+), 177 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 7048834e0d14..4c7a56ce9ada 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -454,129 +454,6 @@ static u32 ath12k_map_fw_phy_flags(u32 phy_flags)
 	return flags;
 }
 
-static bool
-ath12k_reg_can_intersect(struct ieee80211_reg_rule *rule1,
-			 struct ieee80211_reg_rule *rule2)
-{
-	u32 start_freq1, end_freq1;
-	u32 start_freq2, end_freq2;
-
-	start_freq1 = rule1->freq_range.start_freq_khz;
-	start_freq2 = rule2->freq_range.start_freq_khz;
-
-	end_freq1 = rule1->freq_range.end_freq_khz;
-	end_freq2 = rule2->freq_range.end_freq_khz;
-
-	if ((start_freq1 >= start_freq2 &&
-	     start_freq1 < end_freq2) ||
-	    (start_freq2 > start_freq1 &&
-	     start_freq2 < end_freq1))
-		return true;
-
-	/* TODO: Should we restrict intersection feasibility
-	 *  based on min bandwidth of the intersected region also,
-	 *  say the intersected rule should have a  min bandwidth
-	 * of 20MHz?
-	 */
-
-	return false;
-}
-
-static void ath12k_reg_intersect_rules(struct ieee80211_reg_rule *rule1,
-				       struct ieee80211_reg_rule *rule2,
-				       struct ieee80211_reg_rule *new_rule)
-{
-	u32 start_freq1, end_freq1;
-	u32 start_freq2, end_freq2;
-	u32 freq_diff, max_bw;
-
-	start_freq1 = rule1->freq_range.start_freq_khz;
-	start_freq2 = rule2->freq_range.start_freq_khz;
-
-	end_freq1 = rule1->freq_range.end_freq_khz;
-	end_freq2 = rule2->freq_range.end_freq_khz;
-
-	new_rule->freq_range.start_freq_khz = max_t(u32, start_freq1,
-						    start_freq2);
-	new_rule->freq_range.end_freq_khz = min_t(u32, end_freq1, end_freq2);
-
-	freq_diff = new_rule->freq_range.end_freq_khz -
-			new_rule->freq_range.start_freq_khz;
-	max_bw = min_t(u32, rule1->freq_range.max_bandwidth_khz,
-		       rule2->freq_range.max_bandwidth_khz);
-	new_rule->freq_range.max_bandwidth_khz = min_t(u32, max_bw, freq_diff);
-
-	new_rule->power_rule.max_antenna_gain =
-		min_t(u32, rule1->power_rule.max_antenna_gain,
-		      rule2->power_rule.max_antenna_gain);
-
-	new_rule->power_rule.max_eirp = min_t(u32, rule1->power_rule.max_eirp,
-					      rule2->power_rule.max_eirp);
-
-	/* Use the flags of both the rules */
-	new_rule->flags = rule1->flags | rule2->flags;
-
-	/* To be safe, lts use the max cac timeout of both rules */
-	new_rule->dfs_cac_ms = max_t(u32, rule1->dfs_cac_ms,
-				     rule2->dfs_cac_ms);
-}
-
-static struct ieee80211_regdomain *
-ath12k_regd_intersect(struct ieee80211_regdomain *default_regd,
-		      struct ieee80211_regdomain *curr_regd)
-{
-	u8 num_old_regd_rules, num_curr_regd_rules, num_new_regd_rules;
-	struct ieee80211_reg_rule *old_rule, *curr_rule, *new_rule;
-	struct ieee80211_regdomain *new_regd = NULL;
-	u8 i, j, k;
-
-	num_old_regd_rules = default_regd->n_reg_rules;
-	num_curr_regd_rules = curr_regd->n_reg_rules;
-	num_new_regd_rules = 0;
-
-	/* Find the number of intersecting rules to allocate new regd memory */
-	for (i = 0; i < num_old_regd_rules; i++) {
-		old_rule = default_regd->reg_rules + i;
-		for (j = 0; j < num_curr_regd_rules; j++) {
-			curr_rule = curr_regd->reg_rules + j;
-
-			if (ath12k_reg_can_intersect(old_rule, curr_rule))
-				num_new_regd_rules++;
-		}
-	}
-
-	if (!num_new_regd_rules)
-		return NULL;
-
-	new_regd = kzalloc(sizeof(*new_regd) + (num_new_regd_rules *
-			sizeof(struct ieee80211_reg_rule)),
-			GFP_ATOMIC);
-
-	if (!new_regd)
-		return NULL;
-
-	/* We set the new country and dfs region directly and only trim
-	 * the freq, power, antenna gain by intersecting with the
-	 * default regdomain. Also MAX of the dfs cac timeout is selected.
-	 */
-	new_regd->n_reg_rules = num_new_regd_rules;
-	memcpy(new_regd->alpha2, curr_regd->alpha2, sizeof(new_regd->alpha2));
-	new_regd->dfs_region = curr_regd->dfs_region;
-	new_rule = new_regd->reg_rules;
-
-	for (i = 0, k = 0; i < num_old_regd_rules; i++) {
-		old_rule = default_regd->reg_rules + i;
-		for (j = 0; j < num_curr_regd_rules; j++) {
-			curr_rule = curr_regd->reg_rules + j;
-
-			if (ath12k_reg_can_intersect(old_rule, curr_rule))
-				ath12k_reg_intersect_rules(old_rule, curr_rule,
-							   (new_rule + k++));
-		}
-	}
-	return new_regd;
-}
-
 static const char *
 ath12k_reg_get_regdom_str(enum nl80211_dfs_regions dfs_region)
 {
@@ -712,9 +589,9 @@ static void ath12k_reg_update_freq_range(struct ath12k_reg_freq *reg_freq,
 
 struct ieee80211_regdomain *
 ath12k_reg_build_regd(struct ath12k_base *ab,
-		      struct ath12k_reg_info *reg_info, bool intersect)
+		      struct ath12k_reg_info *reg_info)
 {
-	struct ieee80211_regdomain *tmp_regd, *default_regd, *new_regd = NULL;
+	struct ieee80211_regdomain *new_regd = NULL;
 	struct ath12k_reg_rule *reg_rule;
 	u8 i = 0, j = 0, k = 0;
 	u8 num_rules;
@@ -738,20 +615,20 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 	if (reg_info->dfs_region == ATH12K_DFS_REG_ETSI)
 		num_rules += 2;
 
-	tmp_regd = kzalloc(sizeof(*tmp_regd) +
+	new_regd = kzalloc(sizeof(*new_regd) +
 			   (num_rules * sizeof(struct ieee80211_reg_rule)),
 			   GFP_ATOMIC);
-	if (!tmp_regd)
+	if (!new_regd)
 		goto ret;
 
-	memcpy(tmp_regd->alpha2, reg_info->alpha2, REG_ALPHA2_LEN + 1);
+	memcpy(new_regd->alpha2, reg_info->alpha2, REG_ALPHA2_LEN + 1);
 	memcpy(alpha2, reg_info->alpha2, REG_ALPHA2_LEN + 1);
 	alpha2[2] = '\0';
-	tmp_regd->dfs_region = ath12k_map_fw_dfs_region(reg_info->dfs_region);
+	new_regd->dfs_region = ath12k_map_fw_dfs_region(reg_info->dfs_region);
 
 	ath12k_dbg(ab, ATH12K_DBG_REG,
 		   "\r\nCountry %s, CFG Regdomain %s FW Regdomain %d, num_reg_rules %d\n",
-		   alpha2, ath12k_reg_get_regdom_str(tmp_regd->dfs_region),
+		   alpha2, ath12k_reg_get_regdom_str(new_regd->dfs_region),
 		   reg_info->dfs_region, num_rules);
 
 	/* Reset start and end frequency for each band
@@ -803,7 +680,7 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 		flags |= ath12k_map_fw_reg_flags(reg_rule->flags);
 		flags |= ath12k_map_fw_phy_flags(reg_info->phybitmap);
 
-		ath12k_reg_update_rule(tmp_regd->reg_rules + i,
+		ath12k_reg_update_rule(new_regd->reg_rules + i,
 				       reg_rule->start_freq,
 				       reg_rule->end_freq, max_bw,
 				       reg_rule->ant_gain, reg_rule->reg_power,
@@ -818,7 +695,7 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 		    reg_info->dfs_region == ATH12K_DFS_REG_ETSI &&
 		    (reg_rule->end_freq > ETSI_WEATHER_RADAR_BAND_LOW &&
 		    reg_rule->start_freq < ETSI_WEATHER_RADAR_BAND_HIGH)){
-			ath12k_reg_update_weather_radar_band(ab, tmp_regd,
+			ath12k_reg_update_weather_radar_band(ab, new_regd,
 							     reg_rule, &i,
 							     flags, max_bw);
 			continue;
@@ -828,36 +705,19 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 			ath12k_dbg(ab, ATH12K_DBG_REG, "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d) (%d, %d)\n",
 				   i + 1, reg_rule->start_freq, reg_rule->end_freq,
 				   max_bw, reg_rule->ant_gain, reg_rule->reg_power,
-				   tmp_regd->reg_rules[i].dfs_cac_ms,
+				   new_regd->reg_rules[i].dfs_cac_ms,
 				   flags, reg_rule->psd_flag, reg_rule->psd_eirp);
 		} else {
 			ath12k_dbg(ab, ATH12K_DBG_REG,
 				   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
 				   i + 1, reg_rule->start_freq, reg_rule->end_freq,
 				   max_bw, reg_rule->ant_gain, reg_rule->reg_power,
-				   tmp_regd->reg_rules[i].dfs_cac_ms,
+				   new_regd->reg_rules[i].dfs_cac_ms,
 				   flags);
 		}
 	}
 
-	tmp_regd->n_reg_rules = i;
-
-	if (intersect) {
-		default_regd = ab->default_regd[reg_info->phy_id];
-
-		/* Get a new regd by intersecting the received regd with
-		 * our default regd.
-		 */
-		new_regd = ath12k_regd_intersect(default_regd, tmp_regd);
-		kfree(tmp_regd);
-		if (!new_regd) {
-			ath12k_warn(ab, "Unable to create intersected regdomain\n");
-			goto ret;
-		}
-	} else {
-		new_regd = tmp_regd;
-	}
-
+	new_regd->n_reg_rules = i;
 ret:
 	return new_regd;
 }
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index b1eb584ff34c..423dd16ae3dc 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -96,8 +96,7 @@ void ath12k_reg_init(struct ieee80211_hw *hw);
 void ath12k_reg_free(struct ath12k_base *ab);
 void ath12k_regd_update_work(struct work_struct *work);
 struct ieee80211_regdomain *ath12k_reg_build_regd(struct ath12k_base *ab,
-						  struct ath12k_reg_info *reg_info,
-						  bool intersect);
+						  struct ath12k_reg_info *reg_info);
 int ath12k_regd_update(struct ath12k *ar, bool init);
 int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ea303dca38b5..8583d3b33116 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6115,22 +6115,10 @@ static void ath12k_wmi_htc_tx_complete(struct ath12k_base *ab,
 	dev_kfree_skb(skb);
 }
 
-static bool ath12k_reg_is_world_alpha(char *alpha)
-{
-	if (alpha[0] == '0' && alpha[1] == '0')
-		return true;
-
-	if (alpha[0] == 'n' && alpha[1] == 'a')
-		return true;
-
-	return false;
-}
-
 static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct ath12k_reg_info *reg_info = NULL;
 	struct ieee80211_regdomain *regd = NULL;
-	bool intersect = false;
 	int ret = 0, pdev_idx, i, j;
 	struct ath12k *ar;
 
@@ -6178,17 +6166,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 		    reg_info->alpha2, 2))
 		goto mem_free;
 
-	/* Intersect new rules with default regd if a new country setting was
-	 * requested, i.e a default regd was already set during initialization
-	 * and the regd coming from this event has a valid country info.
-	 */
-	if (ab->default_regd[pdev_idx] &&
-	    !ath12k_reg_is_world_alpha((char *)
-		ab->default_regd[pdev_idx]->alpha2) &&
-	    !ath12k_reg_is_world_alpha((char *)reg_info->alpha2))
-		intersect = true;
-
-	regd = ath12k_reg_build_regd(ab, reg_info, intersect);
+	regd = ath12k_reg_build_regd(ab, reg_info);
 	if (!regd) {
 		ath12k_warn(ab, "failed to build regd from reg_info\n");
 		goto fallback;

base-commit: 21346cd925c2567d5f56cdb1421c94815ac10221
-- 
2.34.1


