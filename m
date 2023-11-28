Return-Path: <linux-wireless+bounces-140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F2D7FB03E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 03:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A8B281BE5
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 02:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FDE6AB4;
	Tue, 28 Nov 2023 02:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DLKOaju+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5571AE
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 18:55:03 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS0QAMX028995;
	Tue, 28 Nov 2023 02:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=j8FJVpZykPgWirSCW2PoZ3nFck+YF6PKLufClewYn98=;
 b=DLKOaju+8N/ghEN9sLkej2rrLWVDmfH+wRyeK1oe8DD9EYhmleYlpRkj+RpGXsjqt4LR
 wg1CM3CGljrVT3G8h0WupIKn9WJs9jdu0mUvkkv9AHzd748O6eulFXoAkwGSl3MlpVx8
 KpjMJFaAMBNC2uUelHDY7rUe67mhob4xFdFU7BSqgSWp02I074adJ+7ShvluPA8KD05a
 Xvz0CXeq5JsMNFkCZ9Z24pgmZACdyCjovCwIb0RWas64RmrEExenpzkRySviYNMn5Pmv
 9A85218KhdoGCiag+/d/f5Vo0M420fcG9ivYXIv/FSNWm+ItCsw59jGjjlhgjH/SAwJZ 3g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3un586r9bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 02:55:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS2sxvq029719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 02:54:59 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 18:54:58 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: ath12k: change MAC buffer ring size to 2048
Date: Tue, 28 Nov 2023 10:54:40 +0800
Message-ID: <20231128025440.46988-4-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128025440.46988-1-quic_bqiang@quicinc.com>
References: <20231128025440.46988-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Uzu5Qg-63h2WfkfCpBnrIEIndOt3bdyP
X-Proofpoint-GUID: Uzu5Qg-63h2WfkfCpBnrIEIndOt3bdyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_01,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=841 priorityscore=1501 spamscore=0 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311280021

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


