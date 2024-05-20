Return-Path: <linux-wireless+bounces-7837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E39F8C9917
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 09:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620701C20DF4
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 07:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5439D52F;
	Mon, 20 May 2024 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SKrTHdqc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA9C2FD
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716188486; cv=none; b=jLx6k1HgzcrVKDB+Sl/fqcp4/nnXvbDXV8AwE9pLUVGDLa3NOWQNenDnL41gUmGoYhBLHVynyboCx8IaeOLDjQ/7+jIfbd/DU/lz0feIOKrf9L4/xe3g68CzqVlfWU+soiRmCL1Nxroh9lP21nCps1NMzT2QAe6WE/soScu0XZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716188486; c=relaxed/simple;
	bh=G8FR9tRGRjQP2ubvvmioEa8PjrxLLLgFf6N3diYKDfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+Bivu8leL1r2Luj1q6VHUhIHwZgWozQnDvqMsR+tFGdMXxdtM26mWtxjpfvHhW8e9OT/zYjPLRzQNXRSGco/I9lhN72e2GQBz2gZ7JCEHbu/F3B4T87kkInyQXfrodXwncAsTT4IeF2T9AGO+z7Rio7UEHGj8toB+mHetIaAdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SKrTHdqc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44K0FLTO012012;
	Mon, 20 May 2024 07:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+qbBM8cQ1qwtSFHCz6eBqi5qLQGoBprKLjDhtJbw5nM=; b=SK
	rTHdqcGnvhoGFdB5JnRJSowFS7kaEzpf4e24wLO28Nrl0IQ3Rytgd16AjSs7U2oD
	6NAq5K6ggvpHwn6JllFHIF9YP2ydBzHfYH2KpkJdTqh4qWajyRJji3uPyju9kMO3
	QoFNWQr9VJPFnwd2wt1qL1lT6KMrnUuUt8Y1futbFoTlU6WVTWtqrpmLHttmrkhy
	0Pu4Y8YuZEB7oOmvFtdQwf+bE4vMdCm5FbcE3xbiEuk3v7JZaEwgQVxAH+zqglwQ
	TldS/Z03or8S1ZOVWfyC5QpnO7JC2lTMdPxh3ZYcjdq17a8WzTh9jBGxsMjxXVps
	cCYqgaSHDnpUuCMB0Niw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6psatkxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 07:01:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44K71JxA023377
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 07:01:19 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 20 May 2024 00:01:18 -0700
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH 3/3] wifi: ath12k: fix firmware crash during reo reinject
Date: Mon, 20 May 2024 12:30:45 +0530
Message-ID: <20240520070045.631029-4-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520070045.631029-1-quic_ppranees@quicinc.com>
References: <20240520070045.631029-1-quic_ppranees@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S1aTmnDNOrvELhJ4WJkB1nkZ_jKnHGrv
X-Proofpoint-ORIG-GUID: S1aTmnDNOrvELhJ4WJkB1nkZ_jKnHGrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_04,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200057

When handling fragmented packets, the ath12k driver reassembles each
fragment into a normal packet and then reinjects it into the HW ring.
However, a firmware crash occurs during this reinjection process.
The issue arises because the driver populates peer metadata in
reo_ent_ring->queue_addr_lo, while the firmware expects the physical
address obtained from the corresponding peer’s queue descriptor. Fix it
by filling peer's queue descriptor's physical address in queue_addr_lo.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 2bfcc19d15ea..2adb6c7d4a42 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2967,7 +2967,7 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	struct hal_srng *srng;
 	dma_addr_t link_paddr, buf_paddr;
 	u32 desc_bank, msdu_info, msdu_ext_info, mpdu_info;
-	u32 cookie, hal_rx_desc_sz, dest_ring_info0;
+	u32 cookie, hal_rx_desc_sz, dest_ring_info0, queue_addr_hi;
 	int ret;
 	struct ath12k_rx_desc_info *desc_info;
 	enum hal_rx_buf_return_buf_manager idle_link_rbm = dp->idle_link_rbm;
@@ -3060,13 +3060,11 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	reo_ent_ring->rx_mpdu_info.peer_meta_data =
 		reo_dest_ring->rx_mpdu_info.peer_meta_data;
 
-	/* Firmware expects physical address to be filled in queue_addr_lo in
-	 * the MLO scenario and in case of non MLO peer meta data needs to be
-	 * filled.
-	 * TODO: Need to handle for MLO scenario.
-	 */
-	reo_ent_ring->queue_addr_lo = reo_dest_ring->rx_mpdu_info.peer_meta_data;
-	reo_ent_ring->info0 = le32_encode_bits(dst_ind,
+	reo_ent_ring->queue_addr_lo = cpu_to_le32(lower_32_bits(rx_tid->paddr));
+	queue_addr_hi = upper_32_bits(rx_tid->paddr);
+	reo_ent_ring->info0 = le32_encode_bits(queue_addr_hi,
+					       HAL_REO_ENTR_RING_INFO0_QUEUE_ADDR_HI) |
+			      le32_encode_bits(dst_ind,
 					       HAL_REO_ENTR_RING_INFO0_DEST_IND);
 
 	reo_ent_ring->info1 = le32_encode_bits(rx_tid->cur_sn,
-- 
2.25.1


