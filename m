Return-Path: <linux-wireless+bounces-15913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F499E4BA4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 02:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA38B16A313
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 01:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C16715B980;
	Thu,  5 Dec 2024 01:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qb5Wu9PH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760A1422AB
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733360909; cv=none; b=rYwLMa0HA9YVeKPv3gqx5J0bxoRh8MN0pYKGarKkwtYQRz+CewQKAHOtIjqLCp2v1WiZFG9MTNHuXgSbIqDNqEp9OUNc5kmIP73NwpxRIWvjl1f3jPHRHMTtKLweI1N+MVjvTXEvvRy3FIhBhY/AY2RYD1nSl9/UzHE/FnG7SMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733360909; c=relaxed/simple;
	bh=EeONiJqmbq+6K/L9XXjPb6/Kg3R2FvtuViwfHS8AdNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Joj3lk/4MQWGgwPgXKA46ciOzr7Z1zP8o9nN0NhY7GVfxGMGpaLDOhh7/3TvL43IIXJc1cNvjc6AL06lFY6+QrAFzTA37uH17VZxmFVvE5GHsNqme7KK6xcdUnxs5njmeN1RT241dIyo3ZHF7Bfl3H5rhGBSaFr7GmxQQXE3LEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qb5Wu9PH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4Lup65029882;
	Thu, 5 Dec 2024 01:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PmRavJ84/ZqlGF4feSXh+mmnP8FY4va81jQfZPCofpI=; b=Qb5Wu9PHLGav+p8G
	BHYldwtf1wH2XTgxmV+ddRlQZQjomUOfX5aHx03Jzw8u3qfDngMwWM9K5TO3qink
	YYx8K2u+RRnmQ55QDK7uhdhclnSlZhekM4jaYn0lVrbQMbbM7/z7BnKYy+39mEGH
	ISp5vb7/b5zb7zv+uiO9lk8temPtL2FG4Y0ApDP9gU2i9hYQfvYuPMXP1DlCHIp5
	GbU65qENRvRgOEvtELgEViH2/Mgn2aWXG4P/Y875MeUmQTbYTSkvVhwaFsU+rT/o
	ZDJOZuE1bV+IxM8hKBc6j3j7Zwq17nC1tEtEvLGz1oYcrBLjPTPi/nrTV9bp8v1z
	Nxjvrg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ayem8b1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 01:08:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B518OxV011384
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 01:08:24 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 17:08:22 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2 7/8] wifi: ath12k: Change the Tx monitor SRNG ring ID
Date: Thu, 5 Dec 2024 06:37:53 +0530
Message-ID: <20241205010754.2846603-8-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205010754.2846603-1-quic_periyasa@quicinc.com>
References: <20241205010754.2846603-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: jgM9XZtP8Lfw4tYML4Nyh9lcw1l-C-JF
X-Proofpoint-ORIG-GUID: jgM9XZtP8Lfw4tYML4Nyh9lcw1l-C-JF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050006

The Tx monitor SRNG ring ID does not align with the ath12k 802.11be
hardware architecture. Currently, there is no issue since the Tx monitor
is not enabled. However, in the future, the Tx monitor will be enabled.
Therefore, change the HAL_SRNG_RING_ID_WMAC1_SW2TXMON_BUF0 SRNG ID and
assign the correct start ring ID for the ring type HAL_TX_MONITOR_BUF.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
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


