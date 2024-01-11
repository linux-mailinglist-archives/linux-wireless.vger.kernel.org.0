Return-Path: <linux-wireless+bounces-1698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350D682A717
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 05:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31A41F229D1
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 04:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD62578;
	Thu, 11 Jan 2024 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="doxGa1vI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95323CB
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B2o2bd012416;
	Thu, 11 Jan 2024 04:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=gcuhiW98e0od9UdGfcr4
	k6mwunf/WDuglpkRGyHMUl4=; b=doxGa1vIKVNfZaNvAXEs3w4hGtvjFaLEw1sm
	/yVhohAFk/0XvDUrD6BHq60k5DqWIis2vAo5ujY9gRLty/KnXxK/AmsL4MP5tZGD
	Tma5Xu4AjvmwPNqivmNTkG0aZuMMpGXg4F8klFrFVKN8tZ43Yupk1ddtj6qU74fX
	cIFSGG3GeZfeH0bpVPuTIHhc039wJigShbVb6UunQ1vtJ8kJfbuCHP7efZDQ6YUG
	wHABhycXZ+FyT2rXNJTg939ZgjKwwBvGl7hbzwqgYT0lFqPsalhBw4XHkRk5+8Nl
	ekFp7NfBU7Tq7S95yVdT4aMACykW57NnRpySITUCzZoPNASkKw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj7w20657-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 04:51:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B4phHw013026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 04:51:43 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 20:51:41 -0800
From: Sriram R <quic_srirrama@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 12/12] wifi: ath12k: support get_survey mac op for single wiphy
Date: Thu, 11 Jan 2024 10:20:45 +0530
Message-ID: <20240111045045.28377-13-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240111045045.28377-1-quic_srirrama@quicinc.com>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qbm9I21cWHZCFpQ_vJCsIbP40nyFfEek
X-Proofpoint-ORIG-GUID: qbm9I21cWHZCFpQ_vJCsIbP40nyFfEek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxlogscore=621 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110035

The radio for which the survey info needs to be collected
depends on the channel idx which could be based on the band.
Use the idx to identify the appropriate sband since multiple
bands could be combined for single wiphy case.

Also use the channel idx and sband to identify the corresponding
radio on which the survey results needs to be populated.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 900741a5f9e3..318c4ad20898 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7827,12 +7827,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah, 0);
-
-	ar_survey = &ar->survey[idx];
-
-	mutex_lock(&ar->conf_mutex);
-
 	sband = hw->wiphy->bands[NL80211_BAND_2GHZ];
 	if (sband && idx >= sband->n_channels) {
 		idx -= sband->n_channels;
@@ -7847,6 +7841,21 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 		goto exit;
 	}
 
+	ar = ath12k_mac_get_ar_by_chan(hw, &sband->channels[idx]);
+	if (!ar) {
+		if (sband->channels[idx].flags & IEEE80211_CHAN_DISABLED) {
+			ret = 0;
+			memset(survey, 0, sizeof(*survey));
+			goto exit;
+		}
+		ret = -ENOENT;
+		goto exit;
+	}
+
+	ar_survey = &ar->survey[idx];
+
+	mutex_lock(&ar->conf_mutex);
+
 	ath12k_mac_update_bss_chan_survey(ar, &sband->channels[idx]);
 
 	spin_lock_bh(&ar->data_lock);
@@ -7858,8 +7867,8 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	if (ar->rx_channel == survey->channel)
 		survey->filled |= SURVEY_INFO_IN_USE;
 
-exit:
 	mutex_unlock(&ar->conf_mutex);
+exit:
 	mutex_unlock(&ah->conf_mutex);
 
 	return ret;
-- 
2.17.1


