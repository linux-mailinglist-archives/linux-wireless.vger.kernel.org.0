Return-Path: <linux-wireless+bounces-184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A347FCC87
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 03:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FED91F20FAF
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 02:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD3B3C3F;
	Wed, 29 Nov 2023 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="obvLAY/m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BCA10EB
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 18:04:41 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT0tEkx014733;
	Wed, 29 Nov 2023 02:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=97vaNmadfX1/6483iZHJLkzWazWIa7J0SV2L+hEWg+A=;
 b=obvLAY/mL4Z/MhySgXuzCEbtjYJWFL+oK9AeRsDzCcUPPJroDcu9/dwXRi0m41LW3zHj
 HZcVM1D5Kkx+WNzWumnkai9ZX/wSoZFDtO4CfGgIWAX1gkGK2RUewsF5XAbu2ADNKT/b
 P9GG9Z54soJVpguplkqYpGMM2XOrFeLjbXwnhopgvy4YOxh4P9+IYH5n0UprBk+PGna4
 IVm2sXCusKn+keqdNK0pkMWnB+MulsltT9KlRREgPYAZLv9zDCCaDUi6SFsbyPLUJTgx
 b63OQfpbhDJahOgA/v+kRk/RbYJ80+f8i8PMCQCCrdOpvHnL8L1r20rrRUa/VMkyDrtS IA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unkens941-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 02:04:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT24cug013347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 02:04:38 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 28 Nov 2023 18:04:37 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/3] wifi: ath12k: change MAC buffer ring size to 2048
Date: Wed, 29 Nov 2023 10:04:14 +0800
Message-ID: <20231129020414.56425-4-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129020414.56425-1-quic_bqiang@quicinc.com>
References: <20231129020414.56425-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: Y3aeE_ELnRkDxs4SwImiar4V4y0G3gdS
X-Proofpoint-ORIG-GUID: Y3aeE_ELnRkDxs4SwImiar4V4y0G3gdS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=840 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290014

For WCN7850, there is a SRNG named MAC buffer ring, i.e.,
dp->rx_mac_buf_ring. During initialization, it is setup
by host and then under control of firmware. During RX
process, firmware fetches buffers from
dp->rx_refill_buf_ring to fill that MAC buffer ring,
and those buffers are taken by RXDMA to carry real WLAN
frames received from air.

Currently a low RX throughput is observed. Checking
firmware log, lots of errors are reported by MAC buffer
ring, complaining that it is running out of buffers,
which further indicates that RXDMA is suffering from
starvation. Currently the size of dp->rx_mac_buf_ring
is configured as 1024. After changing it to 2048, those
error messages are reduced, and a 6.4% increase is seen
in peak throughput. Note that 2048 is an empirical
value. It is chosen here because the RX throughput
meets our expectation after the change.

This change only applies to WCN7850 since other
chips don't have a MAC buffer ring.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v2:
 no change.

 drivers/net/wireless/ath/ath12k/dp.h    | 1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 50db1403ebce..ce55cb550379 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -165,6 +165,7 @@ struct ath12k_pdev_dp {
 #define DP_REO_CMD_RING_SIZE		128
 #define DP_REO_STATUS_RING_SIZE		2048
 #define DP_RXDMA_BUF_RING_SIZE		4096
+#define DP_RX_MAC_BUF_RING_SIZE		2048
 #define DP_RXDMA_REFILL_RING_SIZE	2048
 #define DP_RXDMA_ERR_DST_RING_SIZE	1024
 #define DP_RXDMA_MON_STATUS_RING_SIZE	1024
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 9f831e3971f9..f6fbe867bbd4 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -4110,7 +4110,7 @@ int ath12k_dp_rx_alloc(struct ath12k_base *ab)
 			ret = ath12k_dp_srng_setup(ab,
 						   &dp->rx_mac_buf_ring[i],
 						   HAL_RXDMA_BUF, 1,
-						   i, 1024);
+						   i, DP_RX_MAC_BUF_RING_SIZE);
 			if (ret) {
 				ath12k_warn(ab, "failed to setup rx_mac_buf_ring %d\n",
 					    i);
-- 
2.25.1


