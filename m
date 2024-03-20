Return-Path: <linux-wireless+bounces-5010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97598817A7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106CF1C21259
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5A985627;
	Wed, 20 Mar 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PNCYZGXm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDD85623
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961840; cv=none; b=CImMobCg/0ErQTZP3blrlTxq6oYVkJyCyjMdLRD9F02vkmqrTDO8Ro+xJzY8YbKxic7Nny7nxsZWcM2z7ILs13gWPq0jE81I1RoSN5HpDczYLkNHd49H4vcWQvvjYfqXolROqqf5DDZXDDoxKHVSaTmaBr5ygZU7VYKjofrzFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961840; c=relaxed/simple;
	bh=63bwLee6g8pAD9mQGPsBee7B3HUJCTiHvlzCEThbaV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OV8xiHV4Dsc0Jg6Eill+O0xQDBrEuPzO8gRt8FOTOgEOu+ZvK+GtFFXj8ABFml7gl+H9t514Z94sTbhH5NQ982ObHIP70KgT9nPCvH0gi3gNKMPjt41T3EdJBudF6FE74PLBc7vmyBLO51oHrpqvhH5/+y2nXA63rykuL5ApkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PNCYZGXm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KItPCM001897;
	Wed, 20 Mar 2024 19:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Gvi9sbcKjEn9WYEfQz7jcV7z6Qb64qBDFpwWgCPzn14=; b=PN
	CYZGXmYOQZ7QKiRumOfWwB722KTX4iZMk8GDP3hkM74Rs3SQ2aXekzm3OYVW/9HH
	Hs1LQKlrKa6xjxoG8psWi2AOQgt+Vy4bmm2i8Iqr4W2+vSAxEwPsFpXYYPChw1NQ
	SQqq93Fb0aO8grJV5YyTV1Jj71zp7jXzjbJ1QctVczFaIAjAfQDljC4iDqb+7F/H
	kfuE3tQui/TLUpDRfyx4nALnIHOkUF7WVeKC1aqVm2QsLtvJFx+DZ8cpwConFT2m
	DVwho41Mzyyc4a0oxY5mQBBTbgVxM+/QIee9lyXANNnE1med9NFWbLAGBsfEOwzZ
	MWThY6RqwvXwahl8km6g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyrp79wgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 19:10:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KJAPRX017610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 19:10:25 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 12:10:23 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v5 12/12] wifi: ath12k: support get_survey mac op for single wiphy
Date: Thu, 21 Mar 2024 00:39:43 +0530
Message-ID: <20240320190943.3850106-13-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320190943.3850106-1-quic_ramess@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UqzTWHKX1pnDIEReVM5tAxXOErWlc6dt
X-Proofpoint-GUID: UqzTWHKX1pnDIEReVM5tAxXOErWlc6dt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=865 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200154

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
---
 drivers/net/wireless/ath/ath12k/mac.c | 29 ++++++++++++++-------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 08b560157fdc..8e093f6adccb 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7852,21 +7852,13 @@ ath12k_mac_update_bss_chan_survey(struct ath12k *ar,
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
@@ -7876,11 +7868,22 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
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
@@ -7892,10 +7895,8 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
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


