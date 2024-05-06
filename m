Return-Path: <linux-wireless+bounces-7220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81768BD3D7
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242F91C20F81
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 17:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8110315747E;
	Mon,  6 May 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S6qQ2jJF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FC157485
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016640; cv=none; b=H1ZNTODvu/aUm5K6K01fT09PPNhZjR2l99kuNuiXARw8wmUCwnVscTbxPTujUezglKBIwWvITHBhIY5qulxIS2/DW9rlVNf8lZqeUjA6IuFoUbPiV5UPbUWMwl2+Bna/8UEW+/z0MiiCSs0vUyqFWOyHLi+hX2QK5AsSK5sZC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016640; c=relaxed/simple;
	bh=53t0bzVjSnvNaczHRggJm/MBhHMNlmn36Huzkcgkvh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dq4MPps2Jch5sqEknbuB4QHIdZNRoDzFX8xF2PTyeV0NzKJ/eFMsjFhewtR06cy9SWtAPrhsHakNv8YlvDoIO/vs77o3ZGr4YeeGGvpVYUJUJc3LXgu9/Xqd0Dpg3s48q7g+ILF1WCHbakJjRkdHHMYuzFDiBLjE7Lt20Y1o9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S6qQ2jJF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446DPAXN009004;
	Mon, 6 May 2024 17:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=4nA4V/k
	8y8pALSFkR7Vkpdnv0/U/QRAOrcwAmkRXR9k=; b=S6qQ2jJFoebv6I37pc2Rk8m
	rFNmoOs1AXjGsrFnlKoHk0kaFO2WmVcGUKcn++7pEcztTemKqqOd0BMmBT9o3ZCf
	SLUC0jPDhlD/dQJxqyZViI9npe5BQK0xhULjT+zFfV7y2fwMrFsqbqkM2U5yWMuU
	mGwGZQU6Njw2x54PqrKp54/XmnptzToSm588ZgrB1AlUmLRiOwoivB82+YoL/sh8
	DGXJRA1PXyDguqWkAi2eZcsJ7wpIwsgyD9UzApSJLfss2RQo940iCi7zOJx84OEp
	xGJUtlR8mC7hFviKfe9BQmeqz4bAqLyk1hpPovkXNsfaE1U2N05c6W+2YCcrBOg=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxwqdrvp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 17:30:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 446HUW3H030117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 17:30:32 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 May 2024 10:30:31 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH] wifi: ath12k: avoid double SW2HW_MACID conversion
Date: Mon, 6 May 2024 23:00:17 +0530
Message-ID: <20240506173017.597715-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: auPvU-PmCsMJ9c-8bJhrORiOFjfHBNP1
X-Proofpoint-GUID: auPvU-PmCsMJ9c-8bJhrORiOFjfHBNP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_12,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=778 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405060124

Currently, ath12k_wmi_pdev_dma_ring_cfg() fails due to an invalid pdev_id
parameter passed to the WMI_PDEV_DMA_RING_CFG_REQ_CMDID WMI command. This
invalid pdev_id is caused by a double conversion of the MAC ID. Since the
the caller of ath12k_wmi_pdev_dma_ring_cfg() already performs the MAC ID
conversion, it is unnecessary to do it again within the function. To fix
this, remove the software (SW) to hardware (HW) MAC ID conversion from
ath12k_wmi_pdev_dma_ring_cfg() to avoid this redundant conversion.

Found in code review.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7a52d2082b79..9e9f58b5cbfb 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3808,7 +3808,7 @@ int ath12k_wmi_pdev_dma_ring_cfg(struct ath12k *ar,
 	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_DMA_RING_CFG_REQ,
 						 sizeof(*cmd));
 
-	cmd->pdev_id = cpu_to_le32(DP_SW2HW_MACID(arg->pdev_id));
+	cmd->pdev_id = cpu_to_le32(arg->pdev_id);
 	cmd->module_id = cpu_to_le32(arg->module_id);
 	cmd->base_paddr_lo = cpu_to_le32(arg->base_paddr_lo);
 	cmd->base_paddr_hi = cpu_to_le32(arg->base_paddr_hi);

base-commit: 2c4d8e19cf060744a9db466ffbaea13ab37f25ca
-- 
2.34.1


