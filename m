Return-Path: <linux-wireless+bounces-6821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73808B1CEF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 10:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A1C2861F4
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 08:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F727489;
	Thu, 25 Apr 2024 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MdEiqFbS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5ED7C085
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034409; cv=none; b=RHLPrwZk94j2bwZ4EL838gIVmwpqd/48TSV6pPOmTqkb1or+RIsyHfB5vxwwEGK2sxo5+jGiWKbd29FOMtHmvpbRIv9Wfp+EYXYsGRalsHwZcaoI4iDZhbKxX3QdENpR2kaMEdAVBjZrDJth9fwebokr50te9Fm/0wgaaL5THPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034409; c=relaxed/simple;
	bh=rcITST1ndqvQWjE4b6AksspjYHYEaCFfUNnPpb7lvNs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qbhwYUzeESunl1h6Yz9tq4mx9zubYFYSFQE47INWRtydcMImfTOVIK+pP66Gsy61nKU3tUpoAwZL+dkY9gkPgzcDLN9rqfktlub5uC+3wHui1Kc/oYVGjrfjTR2w2eoSKwAwFxkw2OM9PIY+QsH6wt2oaj6yL3UGoWVPU7VF6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MdEiqFbS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P6aFET004208;
	Thu, 25 Apr 2024 08:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=hHIIahfKFhzjcat/h30r
	uUc9MTCPLWnaQZOICHYEG1U=; b=MdEiqFbSoIdv/fwy4aXOl6Kzt1TRWtLXJbop
	zH5L3NdT3I46hBhgUVvp33aPZd0Gz2ewwEEO6mLfAoxvHQQEG9MhFTfg5JwaHC9c
	lKPHyCfKnvL6bsJffHkQIfjaxDZZfDsi6yutXN4CCMIdWQ+7iCH2d5/Wv3TTzlNc
	vPWPhntS8NyxcnWM00JddbGDoWSiexv2hP2tRyxTWno2xfheA1au3u8tTaZG9Cbi
	Mk9iWdXtjt3wSbN2G/4ppv4O5PWH2iFY7pfbWDc6IgAPbhgLThc4G2DtyiS/9oG0
	eWhER5VTsfWZBRAu/uIxOxdahQGJpPWdXIT/1eFbPnzJrg25Jw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenghbef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 08:40:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P8e09X013158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 08:40:00 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 01:39:59 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix the problem that down grade phy mode operation
Date: Thu, 25 Apr 2024 16:38:37 +0800
Message-ID: <20240425083837.5340-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _XR6Iosifn4s3VJGoGkx30r_259KMPeR
X-Proofpoint-ORIG-GUID: _XR6Iosifn4s3VJGoGkx30r_259KMPeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_07,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250061

Currently, when using WCN7850 or QCN9274 as AP, ath12k always performs down
grade phy mode operation regardless of whether the firmware supports EHT
capability or not and then vdev will start in HE mode. When stations that
support EHT capability try to connect to the AP, the AP will set phy mode
to EHT after receiving the association request packet, and then send
WMI_PEER_ASSOC_CMDID command to firmware, AP’s firmware will crash.

This is because when the ath12k_mac_copy_sband_iftype_data() function
handles EHT capability, it does not copy the EHT capability into the
iftype[band][type] array according to the interface type. So, interface
type should not be used as an index to get eht_cap in
ath12k_mac_check_down_grade_phy_mode() function.

To address this issue, use types_mask to select the eht_cap in
ath12k_mac_check_down_grade_phy_mode() function.

This patch affects QCN9274 and WCN7850 because they have the same issue.

Hostapd log:
wlo1: STA 02:03:7f:37:12:34 IEEE 802.11: Could not set STA to kernel driver

Kernel log:
[270894.816076] ath12k_pci 0000:03:00.0: failed to send WMI_PEER_SET_PARAM cmd
[270894.816111] ath12k_pci 0000:03:00.0: failed to setup peer SMPS for vdev 0: -108
[270894.816122] ath12k_pci 0000:03:00.0: Failed to associate station: 02:03:7f:37:12:34
[270894.843389] ieee80211 phy5: Hardware restart was requested
[270894.843517] ath12k_pci 0000:03:00.0: failed to lookup peer 02:03:7f:37:12:34 on vdev 0
[270894.843616] ath12k_pci 0000:03:00.0: failed to send WMI_PEER_DELETE cmd
[270894.843650] ath12k_pci 0000:03:00.0: failed to delete peer vdev_id 0 addr 02:03:7f:37:12:34 ret -108
[270894.843663] ath12k_pci 0000:03:00.0: Failed to delete peer: 02:03:7f:37:12:34 for VDEV: 0

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 56b1f8b6844e..805cb084484a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6754,14 +6754,24 @@ ath12k_mac_check_down_grade_phy_mode(struct ath12k *ar,
 				     enum nl80211_band band,
 				     enum nl80211_iftype type)
 {
-	struct ieee80211_sta_eht_cap *eht_cap;
+	struct ieee80211_sta_eht_cap *eht_cap = NULL;
 	enum wmi_phy_mode down_mode;
+	int n = ar->mac.sbands[band].n_iftype_data;
+	int i;
+	struct ieee80211_sband_iftype_data *data;
 
 	if (mode < MODE_11BE_EHT20)
 		return mode;
 
-	eht_cap = &ar->mac.iftype[band][type].eht_cap;
-	if (eht_cap->has_eht)
+	data = ar->mac.iftype[band];
+	for (i = 0; i < n; i++) {
+		if (data[i].types_mask & BIT(type)) {
+			eht_cap = &data[i].eht_cap;
+			break;
+		}
+	}
+
+	if (eht_cap && eht_cap->has_eht)
 		return mode;
 
 	switch (mode) {

base-commit: 326f8f68f28b0b831233acfabffb486a5b0f4717
-- 
2.34.1


