Return-Path: <linux-wireless+bounces-4622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E9F879576
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 14:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F349B23C33
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 13:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882BD7AE40;
	Tue, 12 Mar 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VAg2x0X5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB607AE76
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251802; cv=none; b=rsRUpfTlmDvqGKgUf9jH9y5Yg0PQf7ANHpiQlGVniRjofdxu6aQUQotVIQ3O4QWyfg4MeGlT3zVaJslKOPoQvnq0gaPpsBCnX4t7z484l5gjLjmbkgHVNyLCbI1Ms3wwR5iNq05c1lHP/F1y5HNre4hB7jadpoZhpgtG4rCYQkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251802; c=relaxed/simple;
	bh=nFpWTN4XYtHR9px+ar1TI87gZMRP0ZR4YizJg/0gSs0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maGmLEblk/bPUc0R6rYKSTBxe1RIaA3Ja3Da4IvpyviKyDFzG+9mWx7KQY3G19uIIr5Kkqwgi7N/VS8n7Liwu2sGDRjJGHZY5J+ym9sLMyC2kEA6etrMvB2OEWsT4QbFp/H/gXj2oF8Ao+V5o1YBQ8YWCKv63tbxNBZ0/qO+98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VAg2x0X5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CDAAqZ006059;
	Tue, 12 Mar 2024 13:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2ooT2xNwMhbWwrEQmrl62I+wO7+i9J6o798XT7Cmwm4=; b=VA
	g2x0X5HluJWuP0TRhzjILFY5y9yHFs794tSqKoM/vEmgzi3N7nMYILEb5Q61Fvxf
	t4ve29LSNY9su0f7hTrciBN9Xr521O0ytv3JgSFmf4Dk5YGQpBDSHzhzkhoErURT
	2TWlGVqSNi0CgA6/z6E4/WSPLWO3Ziurz2HWvgiuQ2RVlzvTyyD9IWC7VMJ1pmq1
	WM5DD2ELpzyvyowUXYXqxousssIzIKpmOd3CbEyzuR36yVkuEOV2+uq/IGHG470N
	O8RaexYmFiRHstE9qmwvCnAdnZ3h9Th2X4/l4lQw0QqgMlxvnpGupZkvCKPqYlMA
	ozp3NsakFavRPrFRz4Kg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtgc3h236-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 13:56:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CDubDd002785
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 13:56:37 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 06:56:35 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v4 11/12] wifi: ath12k: Modify rts threshold mac op for single wiphy
Date: Tue, 12 Mar 2024 19:25:56 +0530
Message-ID: <20240312135557.1778379-12-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312135557.1778379-1-quic_ramess@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: GWSpKCDEHbr3U66smMW73ArZcEIqX2J9
X-Proofpoint-GUID: GWSpKCDEHbr3U66smMW73ArZcEIqX2J9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=909 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120107

From: Sriram R <quic_srirrama@quicinc.com>

Since multiple radios are abstracted under a single wiphy,
apply the rts threshold value to all the vdevs of the radios
combined under single wiphy.

This also implies that vif specific rts threshold support
needs to be added in future from cfg80211/mac80211.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0934abc7995f..6123d7db2edc 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7292,11 +7292,21 @@ static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
-	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD, ret;
+	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD, ret, i;
 
-	ar = ath12k_ah_to_ar(ah, 0);
-
-	ret = ath12k_set_vdev_param_to_all_vifs(ar, param_id, value);
+	/* Currently we set the rts threshold value to all the vifs across
+	 * all radios of the single wiphy.
+	 * TODO Once support for vif specific RTS threshold in mac80211 is
+	 * available, ath12k can make use of it.
+	 */
+	for_each_ar(i, ah, ar) {
+		ret = ath12k_set_vdev_param_to_all_vifs(ar, param_id, value);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set RTS config for all vdevs of pdev %d",
+				    ar->pdev->pdev_id);
+			break;
+		}
+	}
 
 	return ret;
 }
-- 
2.25.1


