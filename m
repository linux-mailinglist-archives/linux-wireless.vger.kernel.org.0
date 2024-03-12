Return-Path: <linux-wireless+bounces-4605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB36879057
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 10:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CE42848E5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40D7868A;
	Tue, 12 Mar 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ae9WjuM3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48CB77F2E
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234290; cv=none; b=nyixMWzcGlFQ+UfsNqd8nzKLI6aNl5CHn5Dk6LXwdVekcNaV7GIsf86d7HVXmCwMVA5glh2M6Tw5fCvwCnpTG9x0k8gpvA6NNNfVGRuPUL5XG+urmxglzhGBcVS8vjU0HotQ67i/Uic08Ov8N9EUJ8yELt4EO8EUhiQvr/Kc7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234290; c=relaxed/simple;
	bh=e0vTb5RlaKGdPg9yCz7yqzplicqoEPtpMpQNSwSvs5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry4YJlOXHVGYB9icg2mdw9zu4nwi4Xy+JFk0F1SKK7lcwLUJmrrc4DGnjZos3Oew3AQ6nQ26fe4NozBXD6J0q3kVAD+70fe9BQ+d3ojH5BDUfAinp+BuRrStpevJXZh4WEPowC5+jdip2s493yH8ZrIvXEcgIuVuuI5lFcFxFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ae9WjuM3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C7loUb027209;
	Tue, 12 Mar 2024 09:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tUM/Ju9aK4iSOwpxhxl3AvnD03TmbsIcqpCil7BxX/8=; b=Ae
	9WjuM3jArGnligTjyBQB8xww5TdsY1i+VrcV2knykItfwNhks0ZyQNEn/kucdV5S
	OCBL1Uq1VAfb7LkQzhLwEbrG/uEQG2h86ctACT1rZ4hNPEUOWpZfIgPT3TbKzWHt
	aJ4D/0gYb24ExFVBpBT4pHSbUKkc69h5hY7lbSwOKvCP8kyiOgG5egXJw6yUPfm/
	8cjkGNF/QaTe7vdCmBKB50y8nm2ZPLktQd1PwJ3yNLR91evmXWWbT4qpDaGUQLgm
	RA2Y7z7EgaYA+gFs6KV14zEPRb8LaeiLtuSCmspvyXePodFKUzrHl00ff4thn33H
	UlmVMGgnPXbj2+ilwZLQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtckh0u45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:04:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C94hqT013736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:04:43 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 02:04:41 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v3 12/12] wifi: ath12k: support get_survey mac op for single wiphy
Date: Tue, 12 Mar 2024 14:33:51 +0530
Message-ID: <20240312090351.1620218-13-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312090351.1620218-1-quic_ramess@quicinc.com>
References: <20240312090351.1620218-1-quic_ramess@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t4WohCMKJywuZgo5XvwwQG3gEg8_dngb
X-Proofpoint-GUID: t4WohCMKJywuZgo5XvwwQG3gEg8_dngb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=813
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120070

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
 drivers/net/wireless/ath/ath12k/mac.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6123d7db2edc..a31003f8325d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7821,7 +7821,6 @@ ath12k_mac_update_bss_chan_survey(struct ath12k *ar,
 static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 				    struct survey_info *survey)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ieee80211_supported_band *sband;
 	struct survey_info *ar_survey;
@@ -7830,12 +7829,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
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
@@ -7850,6 +7843,21 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
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
@@ -7861,9 +7869,8 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	if (ar->rx_channel == survey->channel)
 		survey->filled |= SURVEY_INFO_IN_USE;
 
-exit:
 	mutex_unlock(&ar->conf_mutex);
-
+exit:
 	return ret;
 }
 
-- 
2.25.1


