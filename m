Return-Path: <linux-wireless+bounces-15481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DCE9D1C97
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 01:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71ADEB22F7A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 00:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBB417BD5;
	Tue, 19 Nov 2024 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YNxM4d7F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4BDDD9
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976404; cv=none; b=Embf5fVgK958EyQyt0oC3ZxUOKn2bm+ClgiezRVgRDhTPK62dbVMjG2ANwsWXLBMKOtDdOUrNogfW9Zk56QMFWxtM4BU9ZREZV7FhcJ94c7HWgsf6IOSwuawq6eLTFzG8YpIu1yjyMQClwC+jX1rk+HwN4egcMn0qJHXhR7TLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976404; c=relaxed/simple;
	bh=UhHru3PydbdPYoVR4+cxv5wFxhWEo8PAHzrpS9nFKmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5/U7eY3p4U9+laSCakByAVjllRtwpDpggmMHKjQsgC5TgZKhKC+CnorHQrcpbeIFLxPMmphivAKKcLO7RL2eFeRGsqBQ1kejvJExA4uS8UuE7fuIvXEuHgik8xMOKvqxZJVDqs3/goPhLpKUl1KtMgjj9FzesCDHoOfyNMpF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YNxM4d7F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGpGD005869;
	Tue, 19 Nov 2024 00:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ez+aLgnZgoasdnr9cgFjxhnMiNaC0bxr9wwNx0WGPxI=; b=YNxM4d7FePNd0ygU
	js8jHfWtIt/hHezds7rRY0DrkAiHhvOXg3UBpM+nzAbrsQfk2fyxgZ7vPShXjPId
	bR96ThTw/J/UTXRvfPJVCzixQC1m3A4URXjCvi0U7g6ekVrAyz1DMx+rXoD/lZ6f
	H68h+OCVshZlOmELK5HtrJm72BcrRot8rrShsk2DA3coLpCWitDf8C3olc5i7d5U
	dJDDLiNrs5ma8qhLmVK5Gy13eCqy57DyC8FJXj9jdXJCQq/TkfNPmjVnZa0PieKQ
	GyKVRr2Ba/4YPqK261Z5hkNm7Ohl4xuUgznqfznBkn1KMeR3QrY5GedJ3Pw0TDfK
	yb5PhQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y90xp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ0XIfN013084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:18 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 16:33:16 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 7/8] wifi: ath12k: Change the Tx monitor SRNG ring ID
Date: Tue, 19 Nov 2024 06:02:47 +0530
Message-ID: <20241119003248.1579567-8-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
References: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: ancRAHgMkfrSHeUR-ZisJfpv-iJxg1xa
X-Proofpoint-ORIG-GUID: ancRAHgMkfrSHeUR-ZisJfpv-iJxg1xa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411190003

The Tx monitor SRNG ring ID does not align with the ath12k 802.11be
hardware architecture. Currently, there is no issue since the Tx monitor
is not enabled. However, in the future, the Tx monitor will be enabled.
Therefore, change the HAL_SRNG_RING_ID_WMAC1_SW2TXMON_BUF0 SRNG ID and
assign the correct start ring ID for the ring type HAL_TX_MONITOR_BUF.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c | 2 +-
 drivers/net/wireless/ath/ath12k/hal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index fd98fac16dd5..cd59ff8e6c7b 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -181,7 +181,7 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 		.max_size = HAL_WBM2PPE_RELEASE_RING_BASE_MSB_RING_SIZE,
 	},
 	[HAL_TX_MONITOR_BUF] = {
-		.start_ring_id = HAL_SRNG_SW2TXMON_BUF0,
+		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2TXMON_BUF0,
 		.max_rings = 1,
 		.entry_size = sizeof(struct hal_mon_buf_ring) >> 2,
 		.mac_type = ATH12K_HAL_SRNG_PMAC,
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 8a78bb9a10bc..94e2e8735958 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -485,8 +485,8 @@ enum hal_srng_ring_id {
 	HAL_SRNG_RING_ID_WMAC1_RXMON2SW0 = HAL_SRNG_RING_ID_WMAC1_RXDMA2SW1,
 	HAL_SRNG_RING_ID_WMAC1_SW2RXDMA1_DESC,
 	HAL_SRNG_RING_ID_RXDMA_DIR_BUF,
-	HAL_SRNG_RING_ID_WMAC1_SW2TXMON_BUF0,
 	HAL_SRNG_RING_ID_WMAC1_TXMON2SW0_BUF0,
+	HAL_SRNG_RING_ID_WMAC1_SW2TXMON_BUF0,
 
 	HAL_SRNG_RING_ID_PMAC1_ID_END,
 };
-- 
2.34.1


