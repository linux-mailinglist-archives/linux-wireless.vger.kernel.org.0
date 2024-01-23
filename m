Return-Path: <linux-wireless+bounces-2356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CC4838341
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 03:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3012C1F25697
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 02:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F8F481A8;
	Tue, 23 Jan 2024 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kmz1MuIr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7760BBA
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974750; cv=none; b=levHW8m7GmOmad8LtJenVAj1o0NWuGSzhqt1pvTtqDxtQQLTfM/sPiKb9gyrWakbvGJvxFqGLCz4tMZFVMEP5jw9EaxAY1zgW4mIY2eCNPWon9O89WWTKDwH/BTLYHu4Hj2u+HnpuvC7W44MotnPm8F+KsPpseK6vKyH3qa6GwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974750; c=relaxed/simple;
	bh=v/4EF2xBrhfaiSZt+ZmLPwYQ4u15HbG5o4EX+WFXQYQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qegsLzjvNzoYqzmFZjXwdtn9joppTsMVpHU7xkvsssaLZFPIO8A7FDfGWNHfYbgd23qB3Nss3okB0wZ6I7cG9VZvRwZ6hnFXjsPSJI4Ujpr7zy9NfwC+imwWT3LzwtAXbC5IvzHvgHEm4+vpRWWlu/lP1Lq9ozPn2zSb/UzyH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kmz1MuIr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N1cJog031574;
	Tue, 23 Jan 2024 01:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=HxBIAMl
	izmBH4W8EhcAQNcgFNpknBzNbbNRkfdlFsoU=; b=Kmz1MuIrHzDhy+xG5wzfRsg
	O2I/G0NmbFrC08GYlEBTKYVxrN9DDbI4IvvXBZByWfJw+yAjgAE64mqdI06UX7+I
	vhcDR83msRVxxe3VcNp9GlQnw2HbyBm+3Co1EGwDjF6eBtCfxxS3MuLlLVi7HFOE
	BRTmH0BAI01mrJayvA9hzzYUpsim6DcLil2BecddwUD9QjUkuJhJ52xz3mxxVm3i
	SFV+wg4LMVgP9NHvnaGMwtfWpEPrAstWCpZKVy2LbCmuoPZnsU8f5kstR3gh1yiZ
	t5Pubck5wqJ+2Hrfm+n2j0qmNz6SJbu4UatDgZwdsTf8Hz7pifcg5nmRqyMQpvA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt06mgg53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 01:52:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40N1qCJE029043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 01:52:12 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 17:52:10 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath11k: enable 36 bit mask for stream DMA
Date: Tue, 23 Jan 2024 09:52:01 +0800
Message-ID: <20240123015201.28939-1-quic_bqiang@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4ODZocjl2qE9gt_WrhtniU059lNZ5389
X-Proofpoint-ORIG-GUID: 4ODZocjl2qE9gt_WrhtniU059lNZ5389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=774 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401230011

Currently 32 bit DMA mask is used, telling kernel to get us an DMA
address under 4GB when mapping a buffer. This results in a very high
CPU overhead in the case where IOMMU is disabled and more than 4GB
system memory is installed. The reason is, with more than 4GB memory
installed, kernel is likely to allocate a buffer whose physical
address is above 4GB. While with IOMMU disabled, kernel has to involve
SWIOTLB to map/unmap that buffer, which consumes lots of CPU cycles.

We did hit an issue caused by the reason mentioned above: in a system
that disables IOMMU and gets 8GB memory installed, a total of 40.5%
CPU usage is observed in throughput test. CPU profiling shows nearly
60% of CPU cycles are consumed by SWIOTLB.

By enabling 36 bit DMA mask, we can bypass SWIOTLB for any buffer
whose physical address is below 64GB. There are two types of DMA mask
within struct device, named dma_mask and coherent_dma_mask. Here we
only enable 36 bit for dma_mask, because firmware crashes if
coherent_dma_mask is also enabled, due to some unknown hardware
limitations. This is acceptable because coherent_dma_mask is used for
mapping a consistent DMA buffer, which generally does not happen in
a hot path.

With this change, the total CPU usage mentioned in above issue drops
to 18.9%.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c |  2 +-
 drivers/net/wireless/ath/ath11k/pci.c | 16 +++++++++++++---
 drivers/net/wireless/ath/ath11k/pci.h |  1 +
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 6835c14b82cc..8753dde2fe2b 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -423,7 +423,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 			goto free_controller;
 	} else {
 		mhi_ctrl->iova_start = 0;
-		mhi_ctrl->iova_stop = 0xFFFFFFFF;
+		mhi_ctrl->iova_stop = ab_pci->dma_mask;
 	}
 
 	mhi_ctrl->rddm_size = RDDM_DUMP_SIZE;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 09e65c5e55c4..1d0f5d6e1cf2 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -18,7 +18,8 @@
 #include "qmi.h"
 
 #define ATH11K_PCI_BAR_NUM		0
-#define ATH11K_PCI_DMA_MASK		32
+#define ATH11K_PCI_DMA_MASK		36
+#define ATH11K_PCI_COHERENT_DMA_MASK	32
 
 #define TCSR_SOC_HW_VERSION		0x0224
 #define TCSR_SOC_HW_VERSION_MAJOR_MASK	GENMASK(11, 8)
@@ -526,13 +527,22 @@ static int ath11k_pci_claim(struct ath11k_pci *ab_pci, struct pci_dev *pdev)
 		goto disable_device;
 	}
 
-	ret = dma_set_mask_and_coherent(&pdev->dev,
-					DMA_BIT_MASK(ATH11K_PCI_DMA_MASK));
+	ret = dma_set_mask(&pdev->dev,
+			   DMA_BIT_MASK(ATH11K_PCI_DMA_MASK));
 	if (ret) {
 		ath11k_err(ab, "failed to set pci dma mask to %d: %d\n",
 			   ATH11K_PCI_DMA_MASK, ret);
 		goto release_region;
 	}
+	ab_pci->dma_mask = DMA_BIT_MASK(ATH11K_PCI_DMA_MASK);
+
+	ret = dma_set_coherent_mask(&pdev->dev,
+				    DMA_BIT_MASK(ATH11K_PCI_COHERENT_DMA_MASK));
+	if (ret) {
+		ath11k_err(ab, "failed to set pci coherent dma mask to %d: %d\n",
+			   ATH11K_PCI_COHERENT_DMA_MASK, ret);
+		goto release_region;
+	}
 
 	pci_set_master(pdev);
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index e9a01f344ec6..21274175f0d2 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -72,6 +72,7 @@ struct ath11k_pci {
 	/* enum ath11k_pci_flags */
 	unsigned long flags;
 	u16 link_ctl;
+	u64 dma_mask;
 };
 
 static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)

base-commit: 8ff464a183f92836d7fd99edceef50a89d8ea797
-- 
2.25.1


