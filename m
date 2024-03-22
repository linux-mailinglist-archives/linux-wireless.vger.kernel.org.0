Return-Path: <linux-wireless+bounces-5126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8877886475
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 01:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6951F21381
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 00:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F376376;
	Fri, 22 Mar 2024 00:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MSP0fdJh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035F10F2
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067866; cv=none; b=P9V8nwKeqyOsfVTdJLlLz5oxrUiK9w/gsNxW/hMQHdexlfPbhiO8v3KAyM0UdJxlVATZZEgsibxeb5TTuHGFQ8vOShscZdevmzI0dVKP2ACw/hXfTIIKUQjYfVtC8lQchx1RgzmrpaMSQ0CIVj0cb/LZ6GqQqbm3zVL3322eJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067866; c=relaxed/simple;
	bh=8wZo5+vr/4UnOM9A9mUGThctwqmGF5Rpy48pBB6O/Uk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ghao98FPNYdzD6yxFtCMDZlySpXlsRwDeAHPhzpVpc1hKmLcb9BEdJBLP6VCCRYxertgQT2nbpBaNdH4Xr7C+jdmuJz6p0rUYqk7jIhvMfup8Wk9+zfB0WaGoAFhyOLY6HCTwrjCaQZNAkL/rVrsnjIUwfLq/22/+IqJ49WZc7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MSP0fdJh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42M0JnQL028152;
	Fri, 22 Mar 2024 00:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=qkO59A3
	C2/XE9AMgV/UMG7t4M5gfgH6ysL2XrcLDpZM=; b=MSP0fdJhm7yZN8oYJKfgw7B
	4Se/6ZFfa5ev3dzQOxaf0FIn7ibJSymtSgCSCPpNF1QbjNSEFzI8xU59ZARmiTlQ
	tyzEvgqeN6xWFAFBJQdKnrph2qqjSb+FVjtZMNNyUWqUQPWj9hqy0Z/AkplFISkr
	CcC2RzHxNd0XnTz/Mjld7E7hNtJzWJ3RekOk92qhnhjKCzhtZofjgJgPgekwhRTE
	DiLL9jBFrtGhd3iN6KtLU11RErKji5jAQL1aWs5PdWALCeBD1bOoPUDfyQcUReKA
	a4bVFZOFCGN+Xamiuz2mEGcNlNGPLgTpGi/NHyk/2zrmmQXI9VWSENKVVn/jNZA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0wy5g5fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 00:37:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42M0bcII031357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 00:37:38 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 17:37:36 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix missing endianness conversion in wmi_vdev_create_cmd
Date: Fri, 22 Mar 2024 08:37:26 +0800
Message-ID: <20240322003726.2016208-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: KxTIzWgb64KXjYx0it315lsA3CguBzSy
X-Proofpoint-ORIG-GUID: KxTIzWgb64KXjYx0it315lsA3CguBzSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_14,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=991 phishscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403220002

The WMI commands are in little endian byte order, fix missing endianness
conversion in wmi_vdev_create_cmd.

Tested-on: WCN7850 hw2.0 WLAN.IOE_HMT.1.0.2-00240-QCAHMTSWPL_V1.0_V2.0_SILICON-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 12 ++++++------
 drivers/net/wireless/ath/ath12k/wmi.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 34de3d16efc0..a5575ce9eed4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -858,20 +858,20 @@ int ath12k_wmi_vdev_create(struct ath12k *ar, u8 *macaddr,
 	len = sizeof(*txrx_streams);
 	txrx_streams->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_VDEV_TXRX_STREAMS,
 							  len);
-	txrx_streams->band = WMI_TPC_CHAINMASK_CONFIG_BAND_2G;
+	txrx_streams->band = cpu_to_le32(WMI_TPC_CHAINMASK_CONFIG_BAND_2G);
 	txrx_streams->supported_tx_streams =
-				 args->chains[NL80211_BAND_2GHZ].tx;
+				cpu_to_le32(args->chains[NL80211_BAND_2GHZ].tx);
 	txrx_streams->supported_rx_streams =
-				 args->chains[NL80211_BAND_2GHZ].rx;
+				cpu_to_le32(args->chains[NL80211_BAND_2GHZ].rx);
 
 	txrx_streams++;
 	txrx_streams->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_VDEV_TXRX_STREAMS,
 							  len);
-	txrx_streams->band = WMI_TPC_CHAINMASK_CONFIG_BAND_5G;
+	txrx_streams->band = cpu_to_le32(WMI_TPC_CHAINMASK_CONFIG_BAND_5G);
 	txrx_streams->supported_tx_streams =
-				 args->chains[NL80211_BAND_5GHZ].tx;
+				cpu_to_le32(args->chains[NL80211_BAND_5GHZ].tx);
 	txrx_streams->supported_rx_streams =
-				 args->chains[NL80211_BAND_5GHZ].rx;
+				cpu_to_le32(args->chains[NL80211_BAND_5GHZ].rx);
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
 		   "WMI vdev create: id %d type %d subtype %d macaddr %pM pdevid %d\n",
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 6a2da0739ac8..78afc94a815d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2724,9 +2724,9 @@ struct wmi_vdev_create_cmd {
 
 struct ath12k_wmi_vdev_txrx_streams_params {
 	__le32 tlv_header;
-	u32 band;
-	u32 supported_tx_streams;
-	u32 supported_rx_streams;
+	__le32 band;
+	__le32 supported_tx_streams;
+	__le32 supported_rx_streams;
 } __packed;
 
 struct wmi_vdev_delete_cmd {
-- 
2.25.1


