Return-Path: <linux-wireless+bounces-6037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604D589E31E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 21:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E95B23205
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 19:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD53157476;
	Tue,  9 Apr 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Etjk0I11"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9A15746C
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689833; cv=none; b=atd9uY36ZBwtuRVFS77aYeqFW/8rHP25ljhlzDjqmyi2toNrbNACAXhIeWQtW14VG3tWdQuVaeWAGlcAUXYrDh+E41FO4qhRQC/hOjTBtUcJ6oLkCjMwMDGAVlwix1W4AbfQygV3/w6t1OWwsGMwCicxKWUUAPmLJkkXDen4LhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689833; c=relaxed/simple;
	bh=wnn4+CHRTwaPD16cKR9p0qoBI2naTCbfck+zBilJuCU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ilc4fwNp0aTN3XpwOTGNib8s3JV2K+MmIgilYbPVVmjRWkYjcK3RgdwW4Q2r0NEZELO1cKGIjp4nwB+IXiVxJj0+LNPdM+7KxarRQR/1gl/WvSCYu6J8bdE5M3C4Cu9Lk4I2I4kLwznzhNNkkbdaXxJ0ZXrJd29K5QCp0aJ8XjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Etjk0I11; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439BT7DY023437;
	Tue, 9 Apr 2024 19:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=1Lz/vNzj/7zChq/d40PDzqlFsByM2ImgVdUYiaJxcEw=; b=Et
	jk0I11x5c/ZWs8Xdpyk0WbM3jcIZ/cyYZJBMhoGuqKI0e5LYyLtYIApIdBUTCePo
	QjpArQWDJ4Y/psc0wHnb0DE4gAim4YWrLJWe8DwA122EIhscVoGcZWUSEepLEJM7
	HdyfB7zHdTbqYy55tuipEAcWiiLQRA5YJTXb3owxF5uKWFAyO+UNGT44bM9rFN/y
	CJmuQcxPMaVd8e4p1bY00CcmatCXKw1pQwqoEWNUOv/3YoYoyGGOmCV8tOYPTDOG
	QFzQKaaEOwfONDXbVGo2FAWo8QfUcoyoPGTMNGKIMR2+VwyLCB7xpycXgi6nzt0W
	ogeLl24F9ZeoT4UhQcSw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd4ues0da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 19:10:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439JAHPP003974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 19:10:17 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 12:10:15 -0700
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH] wifi: ath12k: Fix Tx Completion Ring(WBM2SW) Setup Failure
Date: Wed, 10 Apr 2024 00:39:22 +0530
Message-ID: <20240409190922.4180631-1-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fIhTfBEdF1K9VZblijNcHZonmxV_8xjV
X-Proofpoint-ORIG-GUID: fIhTfBEdF1K9VZblijNcHZonmxV_8xjV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=958 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090126

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

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index a0aa8c571867..86d80fd5e2c5 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -127,7 +127,9 @@ static int ath12k_dp_srng_find_ring_in_mask(int ring_num, const u8 *grp_mask)
 static int ath12k_dp_srng_calculate_msi_group(struct ath12k_base *ab,
 					      enum hal_ring_type type, int ring_num)
 {
+	const struct ath12k_hal_tcl_to_wbm_rbm_map *map;
 	const u8 *grp_mask;
+	int i;
 
 	switch (type) {
 	case HAL_WBM2SW_RELEASE:
@@ -135,6 +137,14 @@ static int ath12k_dp_srng_calculate_msi_group(struct ath12k_base *ab,
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
@@ -876,11 +886,9 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
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

base-commit: dc410c4accd2fe64479a1f4ebc47ec9cd3928f4a
-- 
2.17.1


