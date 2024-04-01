Return-Path: <linux-wireless+bounces-5733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE92589453D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 21:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8A41C21950
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 19:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDBE524DF;
	Mon,  1 Apr 2024 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B/GbPJiI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFEE54919
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998330; cv=none; b=Nx+MTSVMBZ6RU2LczLMd15DdB4zqZb5jhMg6C4IhZufT30i1AWFcOQNugWfAJFvIPU3CouVJ6Trg2afp0Rl8rXG49A9GT6c6Fp5BiKpq7Uqs3MdI0aMf5/jEBy3hsEDT9Un7wCT0R31HmQYl65p/c13tT04PexdX8jJ1vhN7Gt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998330; c=relaxed/simple;
	bh=sSksDoV03fxRa8BU48l8/2gCsZ9FBvopgwd0lrseOAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlcXzqbJHV9kwpyT+KEsVx+Sf3mJZrFoVQUGYoj/m2oqwgMzlg5bFG+dt8Se5bb25s1zs5OZkbcf7yfhEoXQPWEA/yhKQ5uRhWb5uszkigIJBrHjN9Jol8+PqsH9rnFNb0zWN/sj+ZZus5OL169gaSPJcbNJD3HIfFK+TSv7DFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B/GbPJiI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431ClCN4023276;
	Mon, 1 Apr 2024 19:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=R+/c07E6dcKNui6yAEPRsQRsQ/KErT9ojh8D1+GBcq8=; b=B/
	GbPJiIvi2dgxIQsObIocUN7dka2a6cQ4yrYVU0JekTB5QJNzMIZLhJM98q6U+Abu
	yt6onz2rdM9CSl957H3OzeOCIXufmFkYPQft+9uSrvJ+krhOveO58fXVEZpxxGY9
	hJPj/D2YjfI4FckDP0qTaxDprJtnb0FGPc1aGiyDapKeG0n+3z9tENw3ddecQHdT
	PBcvAk4AIGcI6Ga4g7mVLPdgg89hpustpgCQYOfFqLGkldXcXgn43leAUCt3MWEI
	IDGK1OZEPslXCgu1EorTTBls6eNXRuUUMmyvh4mUoeMPzYYwYfxkCHv1EiYQN1Pv
	raW1rD8m8s44dOou4FZw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7nbq1tba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:05:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431J5OZc005381
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 19:05:24 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Apr 2024 12:05:22 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v6 12/12] wifi: ath12k: support get_survey mac op for single wiphy
Date: Tue, 2 Apr 2024 00:34:09 +0530
Message-ID: <20240401190409.2461819-13-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401190409.2461819-1-quic_ramess@quicinc.com>
References: <20240401190409.2461819-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: mIPgA95BzB-OS31VXc_jalmuBSAhntzx
X-Proofpoint-GUID: mIPgA95BzB-OS31VXc_jalmuBSAhntzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_13,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 mlxlogscore=883 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010134

From: Sriram R <quic_srirrama@quicinc.com>

The radio for which the survey info needs to be collected
depends on the channel idx which could be based on the band.
Use the idx to identify the appropriate sband since multiple
bands could be combined for single wiphy case.

Also use the channel idx and sband to identify the corresponding
radio on which the survey results needs to be populated.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 29 ++++++++++++++-------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2b70e4394923..ec0838f77e26 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7848,21 +7848,13 @@ ath12k_mac_update_bss_chan_survey(struct ath12k *ar,
 static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 				    struct survey_info *survey)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ieee80211_supported_band *sband;
 	struct survey_info *ar_survey;
-	int ret = 0;
 
 	if (idx >= ATH12K_NUM_CHANS)
 		return -ENOENT;
 
-	ar = ath12k_ah_to_ar(ah, 0);
-
-	ar_survey = &ar->survey[idx];
-
-	mutex_lock(&ar->conf_mutex);
-
 	sband = hw->wiphy->bands[NL80211_BAND_2GHZ];
 	if (sband && idx >= sband->n_channels) {
 		idx -= sband->n_channels;
@@ -7872,11 +7864,22 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	if (!sband)
 		sband = hw->wiphy->bands[NL80211_BAND_5GHZ];
 
-	if (!sband || idx >= sband->n_channels) {
-		ret = -ENOENT;
-		goto exit;
+	if (!sband || idx >= sband->n_channels)
+		return -ENOENT;
+
+	ar = ath12k_mac_get_ar_by_chan(hw, &sband->channels[idx]);
+	if (!ar) {
+		if (sband->channels[idx].flags & IEEE80211_CHAN_DISABLED) {
+			memset(survey, 0, sizeof(*survey));
+			return 0;
+		}
+		return -ENOENT;
 	}
 
+	ar_survey = &ar->survey[idx];
+
+	mutex_lock(&ar->conf_mutex);
+
 	ath12k_mac_update_bss_chan_survey(ar, &sband->channels[idx]);
 
 	spin_lock_bh(&ar->data_lock);
@@ -7888,10 +7891,8 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	if (ar->rx_channel == survey->channel)
 		survey->filled |= SURVEY_INFO_IN_USE;
 
-exit:
 	mutex_unlock(&ar->conf_mutex);
-
-	return ret;
+	return 0;
 }
 
 static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
-- 
2.25.1


