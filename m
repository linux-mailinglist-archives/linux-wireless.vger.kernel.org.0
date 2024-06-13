Return-Path: <linux-wireless+bounces-8984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E95099076CF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCDB1F21E6D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932B812D757;
	Thu, 13 Jun 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y+zLosD4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83C12D762
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293117; cv=none; b=iDH4IlwEADF7xBsXiguNPbpaD/kMmzhs+2v390hssy2MiV1wmpcjxpEEBB1l7c7uELXqa/WNEtauNx+I1t5GIMiuI5gOAGv4mich1HTAdtbASKqU0AlHdldulpsPPnu2I6/sX/1nbNo6fIIOC1XCtsu0IRh5ts+lqBrXQcZwzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293117; c=relaxed/simple;
	bh=Hpr+ILg78F8Fd60tM/9e8ndG0chFlsCzcx8zKKS+y7g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ehFfWNDGdAqmrEOXUeNKdvB5hHBdlseBR8O99aRX8jiaXbGkOIbhNgLciTtcg0WyNrz+sgNHThIhOQVGjW098sL8YJtTaQP6ZEWjBXfV3P7h0k7rz0dA/EfGvIpr+7+4gjE9Jn7efiaRiPldokEfPW2hQonYgYSuxbI9ybEx3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y+zLosD4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D9TmtO027312;
	Thu, 13 Jun 2024 15:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=A8aeYZsa7JGE0rH7Tel4Dm
	K1ah4URP3cl1JkVWPqQmA=; b=Y+zLosD4Os3Qi/CqrUcZKDRZcIvpxf8SzObq/t
	mVeJ9rYxUll6UdR5cyselrCDKc77Dfer/T/BXSbl/yl7ikaJ9Sds97jlj2dSuWFU
	9+V2KaQzjMepEv/O8owUCBqn4KIJ+KphaMyiiBpqqCTSQqlkHKu3wmzslzycFhte
	ugVK/Jhr3gH4z4Js0KusnaBktH1+0bwRqpyWkW+JBq36uuo9XHpvKgN6ln8DVS9t
	RgTzkCEVrnofBCNnbXXztaATCNT4A/p5sSaplzvPqmABb3d2AkQsDuqFxAUvnGZE
	vmCPqkC4xGjt1q+vCSZIfA9ztdCbhfXO3XvJFnG4J4swQoOQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yps5xdspp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:38:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DFcT59022433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:38:29 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Jun 2024 08:38:27 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix mbssid max interface advertisement
Date: Thu, 13 Jun 2024 21:08:13 +0530
Message-ID: <20240613153813.3509837-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: Jj6GY_YqdAIPlFrUyXb0E7W9Oof7XOOn
X-Proofpoint-ORIG-GUID: Jj6GY_YqdAIPlFrUyXb0E7W9Oof7XOOn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=748
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406130113

The Current method for advertising the maximum MBSSID interface count
assumes single radio per wiphy (multi wiphy model). However, this
assumption is incorrect for multi radio per wiphy (single wiphy model).
Therefore, populate the parameter for each radio present in the MAC
abstraction layer (ah). This approach ensure scalability for both single
wiphy and multi wiphy models.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: 519a545cfee7 ("wifi: ath12k: advertise driver capabilities for MBSSID and EMA")
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2259ce22cc8b..cab9021b9071 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8959,6 +8959,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	u32 ht_cap = U32_MAX, antennas_rx = 0, antennas_tx = 0;
 	bool is_6ghz = false, is_raw_mode = false, is_monitor_disable = false;
 	u8 *mac_addr = NULL;
+	u8 mbssid_max_interfaces = 0;
 
 	wiphy->max_ap_assoc_sta = 0;
 
@@ -9002,6 +9003,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 			mac_addr = ar->mac_addr;
 		else
 			mac_addr = ab->mac_addr;
+
+		mbssid_max_interfaces += TARGET_NUM_VDEVS;
 	}
 
 	wiphy->available_antennas_rx = antennas_rx;
@@ -9094,7 +9097,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	wiphy->iftype_ext_capab = ath12k_iftypes_ext_capa;
 	wiphy->num_iftype_ext_capab = ARRAY_SIZE(ath12k_iftypes_ext_capa);
 
-	wiphy->mbssid_max_interfaces = TARGET_NUM_VDEVS;
+	wiphy->mbssid_max_interfaces = mbssid_max_interfaces;
 	wiphy->ema_max_profile_periodicity = TARGET_EMA_MAX_PROFILE_PERIOD;
 
 	if (is_6ghz) {

base-commit: e72048809ec7355a947415ae6836d2eb7fdcda39
-- 
2.34.1


