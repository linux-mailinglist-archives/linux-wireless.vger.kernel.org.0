Return-Path: <linux-wireless+bounces-7397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F088C129B
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 18:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F42A1F22438
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 16:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7DE16F851;
	Thu,  9 May 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kIZEgMNH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C704216F832
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271417; cv=none; b=ZQwo0I/dm/ISYJ7ymRChEiLb9vpkhAQImEYXysOZ9X5xHxKsypbmC2Ykd3zDM/iaov3vlptMbTCb30Mfse1UuHJR8M9v2TWoQs+Ztr1Gwwyxxfm5LWj923nS+fD6CGH4edO+lM7LfMJPxuDAUApr9xGp2T9TsR3degDzdqFn/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271417; c=relaxed/simple;
	bh=DcZuVDVhobipACYJ6cHnahE7k6zx6/vzKGF0YXYk5Ao=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CRp+QM77QLE6ntePPUwGuyTHE/UK/4I9tCFt4NwPPgPzzCxDDV00XW9Qw0LSqv3aEDg3zBGmt04MFUfSAKs8RbBwfvOYUPkZCL8AlYoX1KfXeMdIQroSXuH7/lb9+C0c5hDPFxJJ/XB9YOv3M+migWr8T5MRV/UjR4XTrjyGHa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kIZEgMNH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449Cbdlt013927;
	Thu, 9 May 2024 16:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=SSZ4YJLXxW2IfOkAreUAvF48rQZiDXvH7ID/LwZINTE=; b=kI
	ZEgMNHqLkDY7QwLu/EOc+tAcnrtf5+oxt6vGq2HukcOjztH2yvrnF2wLGNgSI2Mw
	jcs0KGpfVcVY1g0pH9i1u9uhCTUgvY4t/6MIekIom2RVSmAIao189rlqT1BXmr0x
	by8BYdEhZmhc40zL42GgVhs1IcMskJe/jmUZVwbjxw//XsXBBHF8z+JS1e4xjOFT
	3nbO5g5QCTmwPZY/YCZvW9RsqHxfBD6yIjBGn09nbd10wPxhUIaQZs9pBS4aZRxe
	huyVMAD8vPnTDpYhk4hNyOTJ4X/cdzZbM7lrxnk0AooP+xinK2ewKFwhdjPkPbSZ
	Jf3kCF3DMBVSM+dA58Ew==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09frb3fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 16:16:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 449GGoVD002935
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 16:16:50 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 May 2024 09:16:48 -0700
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH] wifi: ath12k: Fix Tx Completion Ring(WBM2SW) Setup Failure
Date: Thu, 9 May 2024 21:46:31 +0530
Message-ID: <20240509161631.3520506-1-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HP17jdKDUbm1FDCZDb6A1cSQLMsX1TLN
X-Proofpoint-GUID: HP17jdKDUbm1FDCZDb6A1cSQLMsX1TLN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_08,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=980 priorityscore=1501 clxscore=1011
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090111

We observe intermittent ping failures from the access point (AP) to
station (STA) in any mode(AP-STA or Mesh) configured. Specifically,
the transmission completion status is not received at Tx completion
ring id-4(WBM2SW ring4) for the packets transmitted via TCL DATA
ring id-3. This prevents freeing up Tx descriptors and leads
to buffer exhaustion.

Currently, during initialization of the WBM2SW ring, we are directly
mapping the ring number to the ring mask to obtain the ring mask
group index. This approach is causing setup failures for WBM2SW
ring-4. Similarly, during runtime, when receiving incoming
transmission completion status, the validation of the ring number by
mapping the interrupted ring mask. This is resulting in
validation failure. Thereby preventing entry into the completion
handler(ath12k_dp_tx_completion_handler()).

The existing design assumed that the ring numbers would always be
sequential and could be directly mapped with the ring mask. However,
this assumption does not hold true for WBM2SW ring-4. Therefore,
modify the design such that, instead of mapping the ring number,
the ring ID is mapped with the ring mask.

According to this design:
1. During initialization of the WBM2SW ring, mapping the ring ID
to the ring mask will ensure obtaining the correct ring mask group
ID.
2. During runtime, validating the interrupted ring mask group ID
within the transmission completion group is sufficient. This
approach allows the ring ID to be derived from the interrupted ring
mask and enables entry into the completion handler.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 18 +++++++++++++-----
 drivers/net/wireless/ath/ath12k/hw.c |  2 +-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 72ea9baaf8d7..14f26dd16b79 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -132,7 +132,9 @@ static int ath12k_dp_srng_find_ring_in_mask(int ring_num, const u8 *grp_mask)
 static int ath12k_dp_srng_calculate_msi_group(struct ath12k_base *ab,
 					      enum hal_ring_type type, int ring_num)
 {
+	const struct ath12k_hal_tcl_to_wbm_rbm_map *map;
 	const u8 *grp_mask;
+	int i;
 
 	switch (type) {
 	case HAL_WBM2SW_RELEASE:
@@ -140,6 +142,14 @@ static int ath12k_dp_srng_calculate_msi_group(struct ath12k_base *ab,
 			grp_mask = &ab->hw_params->ring_mask->rx_wbm_rel[0];
 			ring_num = 0;
 		} else {
+			map = ab->hw_params->hal_ops->tcl_to_wbm_rbm_map;
+			for (i = 0; i < ab->hw_params->max_tx_ring; i++) {
+				if (ring_num == map[i].wbm_ring_num) {
+					ring_num = i;
+					break;
+				}
+			}
+
 			grp_mask = &ab->hw_params->ring_mask->tx[0];
 		}
 		break;
@@ -883,11 +893,9 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 	enum dp_monitor_mode monitor_mode;
 	u8 ring_mask;
 
-	while (i < ab->hw_params->max_tx_ring) {
-		if (ab->hw_params->ring_mask->tx[grp_id] &
-			BIT(ab->hw_params->hal_ops->tcl_to_wbm_rbm_map[i].wbm_ring_num))
-			ath12k_dp_tx_completion_handler(ab, i);
-		i++;
+	if (ab->hw_params->ring_mask->tx[grp_id]) {
+		i = fls(ab->hw_params->ring_mask->tx[grp_id]) - 1;
+		ath12k_dp_tx_completion_handler(ab, i);
 	}
 
 	if (ab->hw_params->ring_mask->rx_err[grp_id]) {
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index f4c827015821..5ed06c0d90e2 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -580,8 +580,8 @@ static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_qcn9274 = {
 static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_wcn7850 = {
 	.tx  = {
 		ATH12K_TX_RING_MASK_0,
+		ATH12K_TX_RING_MASK_1,
 		ATH12K_TX_RING_MASK_2,
-		ATH12K_TX_RING_MASK_4,
 	},
 	.rx_mon_dest = {
 	},

base-commit: 2c4d8e19cf060744a9db466ffbaea13ab37f25ca
-- 
2.17.1


