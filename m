Return-Path: <linux-wireless+bounces-13991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD099F562
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 20:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DE31C239B9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6E61F5859;
	Tue, 15 Oct 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JOuaNIR/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3357E1F5850;
	Tue, 15 Oct 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016889; cv=none; b=phmPgp8ZxyoqkbCz2KUXxrJrEwuJt7iV8oq953MN6nIPM9QLLdjVCrRSePiFvtNaRoLVvHdxlxSw2LXLR94OdSURRHgivTc+s/3l5eaFF98UUf+yW/8qt/wMHbgwgQXrHLzq+TETFSXX+3bqdKLDKmUHVYC1kiJAu9vQRtpWI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016889; c=relaxed/simple;
	bh=+UIf+nDZUdKuKNQI0YXAMbCYE6kVNtvxO1M3UTtmmBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2U3j+6/GQWmWT38iD1BsRAkvzBFQH+2cixwetvD5gNZhwjCBcQasv+jhmXPk7Dub+yfg+fiBbjpm9yOWSJtwuSCxVs6GEYRh7AHtf0l2bGnYBz2YLvpu5JG4KYbt3qL67BVcC0oVLXvykXD5eoOieplkhxuUG8FwgF6ZsNf4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JOuaNIR/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FC5CNP023386;
	Tue, 15 Oct 2024 18:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A0NIdAvzD+ZRFi31Is3Wd8qTpnUeBk+iLpKDRYq+4wQ=; b=JOuaNIR/Gb0CmGGG
	5B9nz0HcBsibJxaTJLXvesRnctPq0P5RgmYyyjgvQTHF4Clo71zuI8Vt66hGjB5Y
	mOWTvBym3ML6Pfg8AckzhdhjtxnCGhMzLnSrrCMwZTh0dCr2XBuigNWiMJTLY8QB
	+NNwlaS+eYIe+BzQwlFtKRzm/9ANGsOHQEewA8qucIYGWYZ82BCphQ+nNhawG4Vz
	veJskpyUOP5nMH4denR9QLJAdYW3GfSz6aMTkx/zABzGC6xH9Mg+0xPGnRQxfrgM
	WM8VMeLXV/ypA+BCCVtyRlzfAhIyIdMeyIjEwsi/GqqfaL+McDRTMUNWjwuSdiEy
	phc2jw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429r3b962c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FIS2Ek018564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:02 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 11:27:58 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Balamurugan S <quic_bselvara@quicinc.com>,
        "P Praneesh" <quic_ppranees@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 10/22] wifi: ath12k: add new CMEM read-write ath12k_hif_ops
Date: Tue, 15 Oct 2024 23:56:25 +0530
Message-ID: <20241015182637.955753-11-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _VQ2Nlhj6gBLDGGKw0gwLUd-YQR6VbZx
X-Proofpoint-GUID: _VQ2Nlhj6gBLDGGKw0gwLUd-YQR6VbZx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150125

From: Balamurugan S <quic_bselvara@quicinc.com>

In IPQ5332 AHB device, CMEM region is outside of WCSS register block.
Hence, add new ath12k_hif_ops (cmem_read32 and cmem_write32) for
accessing CMEM register.

In PCI devices (QCN9274 and WCN7850), these cmem_read32/cmem_write32
are same as read32/write32 ath12k_hif_ops. Hence, use the same
functions for these new ath12k_hif_ops cmem_read32/cmem_write32.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c  | 10 ++++++----
 drivers/net/wireless/ath/ath12k/hif.h | 13 +++++++++++++
 drivers/net/wireless/ath/ath12k/pci.c |  2 ++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 2ab2a7d45be9..1e9139923838 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1474,7 +1474,7 @@ static int ath12k_dp_cmem_init(struct ath12k_base *ab,
 			       struct ath12k_dp *dp,
 			       enum ath12k_dp_desc_type type)
 {
-	u32 cmem_base;
+	u32 cmem_base, data;
 	int i, start, end;
 
 	cmem_base = ab->qmi.dev_mem[ATH12K_QMI_DEVMEM_CMEM_INDEX].start;
@@ -1495,9 +1495,11 @@ static int ath12k_dp_cmem_init(struct ath12k_base *ab,
 	}
 
 	/* Write to PPT in CMEM */
-	for (i = start; i < end; i++)
-		ath12k_hif_write32(ab, cmem_base + ATH12K_PPT_ADDR_OFFSET(i),
-				   dp->spt_info[i].paddr >> ATH12K_SPT_4K_ALIGN_OFFSET);
+	for (i = start; i < end; i++) {
+		data = dp->spt_info[i].paddr >> ATH12K_SPT_4K_ALIGN_OFFSET;
+		ath12k_hif_cmem_write32(ab, cmem_base + ATH12K_PPT_ADDR_OFFSET(i),
+					data);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath12k/hif.h b/drivers/net/wireless/ath/ath12k/hif.h
index 0e53ec269fa4..44e42065b551 100644
--- a/drivers/net/wireless/ath/ath12k/hif.h
+++ b/drivers/net/wireless/ath/ath12k/hif.h
@@ -12,6 +12,8 @@
 struct ath12k_hif_ops {
 	u32 (*read32)(struct ath12k_base *ab, u32 address);
 	void (*write32)(struct ath12k_base *ab, u32 address, u32 data);
+	u32 (*cmem_read32)(struct ath12k_base *sc, u32 address);
+	void (*cmem_write32)(struct ath12k_base *sc, u32 address, u32 data);
 	void (*irq_enable)(struct ath12k_base *ab);
 	void (*irq_disable)(struct ath12k_base *ab);
 	int (*start)(struct ath12k_base *ab);
@@ -132,6 +134,17 @@ static inline void ath12k_hif_write32(struct ath12k_base *ab, u32 address,
 	ab->hif.ops->write32(ab, address, data);
 }
 
+static inline u32 ath12k_hif_cmem_read32(struct ath12k_base *ab, u32 address)
+{
+	return ab->hif.ops->cmem_read32(ab, address);
+}
+
+static inline void ath12k_hif_cmem_write32(struct ath12k_base *ab, u32 address,
+					   u32 data)
+{
+	ab->hif.ops->cmem_write32(ab, address, data);
+}
+
 static inline int ath12k_hif_power_up(struct ath12k_base *ab)
 {
 	if (!ab->hif.ops->power_up)
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index bd269aa1740b..0c393bc30f92 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1316,6 +1316,8 @@ static const struct ath12k_hif_ops ath12k_pci_hif_ops = {
 	.stop = ath12k_pci_stop,
 	.read32 = ath12k_pci_read32,
 	.write32 = ath12k_pci_write32,
+	.cmem_read32 = ath12k_pci_read32,
+	.cmem_write32 = ath12k_pci_write32,
 	.power_down = ath12k_pci_power_down,
 	.power_up = ath12k_pci_power_up,
 	.suspend = ath12k_pci_hif_suspend,
-- 
2.34.1


