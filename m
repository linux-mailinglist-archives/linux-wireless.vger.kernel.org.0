Return-Path: <linux-wireless+bounces-21698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB42A93031
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 04:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B3346504C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F1268C6F;
	Fri, 18 Apr 2025 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xrc8WMqB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092E268C50;
	Fri, 18 Apr 2025 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944972; cv=none; b=cb9T0CpkUI3p8J3jzaH9ItuLup90CEtbfAeTFAWY/dwew3AI8IOxdFf0gugjJZGEMSDANJi5eKdWLr+iwu5sY0akQ4s3y77OmS2jWkA0V6bDDmNWhxUVFPZ47N89Zs/3FWnJ2/Tn0Tq9QMTiypD/pqMR+r/H4IPiPtHOXYySvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944972; c=relaxed/simple;
	bh=JfojYbaX2TGbPtSF+o6Ze04o4jhCt+yKkMRD9GgcF5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=I5O//P6I76DtP53ANmALceasRZhrqhlrN+UAMAsZWyyVg/CnqDQmBdUDQBzjQoiY6YD/5VLb7no5KJV5j8N9KaIrPabf4pL40T5twdwseJl0uyIxplwxFoGnBrDS394WfnOubJ38jwKZN+uzaG7A+sCCzTSqP4wKx/um4mCKGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xrc8WMqB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HJbjFI014438;
	Fri, 18 Apr 2025 02:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	klyXPSFY5tX/Ct25yVK4xQk19g+SmefgcJOQpb4nun8=; b=Xrc8WMqBnQ5Ii55z
	/6QSR8shG+hUJLpofm1dpOMs85Fvam50KqSCKR/ox/pWrQaJSwuzokG5OEzqZTsO
	Nqvo7kkDVzpkqU9bYBcSuzr6m2hxdn2YxDIksx7pE2OaSDG6reW1uODHwx3miM3l
	GbqXs9sYHWon18BavxyYJ7m4nUEPoF9gRO9IecLEahofoVPlxsrWurkHpax1ZMwA
	hrJmq9m3DXcS57WO7S6o0KvTl953rInZ8ve1xOJxhh/wi+yB6LBsyqwSDoRLTh5c
	FkMS5CntkYw/ml558u6baM7yyna6WgiK/ks/EuUwFsOMqVEYEwjpG3zxjP8brllA
	PBRcdg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf6a0tp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I2u1UZ022863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:01 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 19:55:59 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 18 Apr 2025 10:55:36 +0800
Subject: [PATCH ath-next 03/15] wifi: ath12k: refactor
 ath12k_reg_build_regd()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250418-ath12k-6g-lp-vlp-v1-3-c869c86cad60@quicinc.com>
References: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
In-Reply-To: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -mrZPHBBgYEMKDbC1z5NSc9XCNiBB-az
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=6801bf42 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=fhh3vIhDZVS6VH9qMvAA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -mrZPHBBgYEMKDbC1z5NSc9XCNiBB-az
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180020

Currently we pass intersect flag to tell ath12k_reg_build_regd() whether
regulatory rulse are intersected. This flag is determined in
ath12k_reg_handle_chan_list() and has no other users.

Move related logic into ath12k_reg_build_regd() to make code clear. Also
relocate ath12k_reg_is_world_alpha() to avoid forward declaration, and
refine it for code simplicity.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 43 +++++++++++++----------------------
 drivers/net/wireless/ath/ath12k/reg.h |  3 +--
 2 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 21c5a8312a9e55a458aab5151ff9c017808659d7..86e3b426d5f9de525a22850140cbc8acac0b6fcf 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -710,9 +710,15 @@ static void ath12k_reg_update_freq_range(struct ath12k_reg_freq *reg_freq,
 		reg_freq->end_freq = reg_rule->end_freq;
 }
 
+static bool ath12k_reg_is_world_alpha(char *alpha)
+{
+	return (alpha[0] == '0' && alpha[1] == '0') ||
+	       (alpha[0] == 'n' && alpha[1] == 'a');
+}
+
 struct ieee80211_regdomain *
 ath12k_reg_build_regd(struct ath12k_base *ab,
-		      struct ath12k_reg_info *reg_info, bool intersect)
+		      struct ath12k_reg_info *reg_info)
 {
 	struct ieee80211_regdomain *tmp_regd, *default_regd, *new_regd = NULL;
 	struct ath12k_reg_rule *reg_rule;
@@ -842,9 +848,14 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 
 	tmp_regd->n_reg_rules = i;
 
-	if (intersect) {
-		default_regd = ab->default_regd[reg_info->phy_id];
-
+	/* Intersect new rules with default regd if a new country setting was
+	 * requested, i.e a default regd was already set during initialization
+	 * and the regd coming from this event has a valid country info.
+	 */
+	default_regd = ab->default_regd[reg_info->phy_id];
+	if (default_regd &&
+	    !ath12k_reg_is_world_alpha((char *)default_regd->alpha2) &&
+	    !ath12k_reg_is_world_alpha((char *)reg_info->alpha2)) {
 		/* Get a new regd by intersecting the received regd with
 		 * our default regd.
 		 */
@@ -899,22 +910,10 @@ void ath12k_reg_reset_reg_info(struct ath12k_reg_info *reg_info)
 	}
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
 int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
 				struct ath12k_reg_info *reg_info)
 {
 	struct ieee80211_regdomain *regd = NULL;
-	bool intersect = false;
 	struct ath12k *ar;
 	int pdev_idx;
 
@@ -948,17 +947,7 @@ int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
 		    reg_info->alpha2, 2))
 		return 0;
 
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
 	if (!regd)
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index f65cfaca7404cd72a9978c0ae6ca98be9d5f6b70..41230092f77bc9f133313dd334825409f0599fd2 100644
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
 

-- 
2.34.1


