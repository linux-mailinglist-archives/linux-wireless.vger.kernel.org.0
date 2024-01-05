Return-Path: <linux-wireless+bounces-1536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E953B825B4C
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 20:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE582859CD
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 19:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8712E364AC;
	Fri,  5 Jan 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gXtQaQUW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168D360AE
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405F5a8l030638;
	Fri, 5 Jan 2024 19:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=mKJX8DpzuvAVcthquEQSl9CnPSw9uFBlhjT8mvvjuqc=; b=gX
	tQaQUWE4w4SBcfgspb9L4uedW+YRTaZySxKYMJ9td29ypj/XcU6DTw6A6TFItOOk
	MbOSay/z/SFyo8D7QfnwZntkErffFvBNnac+6uXieLvTcaKBt0uHyYNtpWM9EJZL
	kRlG+Kpe9pNT6hmQkt37PBLLnbqI9yoBOUfHmjbiyY7Ebg+tuMC17nSyfU785ejj
	WV6Nr7GPOMoWgADStw1pehzfxW0cDUPOOIKKuratmngL2wguAGrN5dk+PhW4+Goh
	mPPeHUtz+CN/5/hAAyU/4TxacNNDXOWzipgNcdDG4txkVvKBP1PDZwPCdxFA8QGG
	gm/Toy3m5I5IeqC9JG+w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve94ra72u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 19:57:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405JvMvI000345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 19:57:22 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 5 Jan 2024 11:57:19 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 11/12] wifi: ath12k: fix PCI read and write
Date: Sat, 6 Jan 2024 01:26:38 +0530
Message-ID: <20240105195639.3217739-12-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
References: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: el1JOXZ9lp7hmuVQ9EyPQEj6WyjXzVSR
X-Proofpoint-GUID: el1JOXZ9lp7hmuVQ9EyPQEj6WyjXzVSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=951 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050161

From: P Praneesh <quic_ppranees@quicinc.com>

Currently, PCI read is failing for the registers belonging to
SECURITY_CONTROL_WLAN registers. These registers read is required
to read the board-id to identify the dual-mac QCN9274 hardware.

The failure is because, for these registers (SECURITY_CONTROL_WLAN)
offset, ath12k_pci_get_window_start() returns window_start as 0. Due
to this PCI read is done without PCI select window and with
window_start offset as 0.

Hence, fix PCI read and write by doing PCI select window and by using
the correct window_start offset - WINDOW_START for
SECURITY_CONTROL_WLAN registers.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 43 ++++++++++++++-------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index d334f41f9658..14954bc05144 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -205,18 +205,17 @@ static u32 ath12k_pci_get_window_start(struct ath12k_base *ab,
 	/* If offset lies within CE register range, use 2nd window */
 	else if ((offset ^ HAL_CE_WFSS_CE_REG_BASE) < WINDOW_RANGE_MASK)
 		window_start = 2 * WINDOW_START;
-	/* If offset lies within PCI_BAR_WINDOW0_BASE and within PCI_SOC_PCI_REG_BASE
-	 * use 0th window
-	 */
-	else if (((offset ^ PCI_BAR_WINDOW0_BASE) < WINDOW_RANGE_MASK) &&
-		 !((offset ^ PCI_SOC_PCI_REG_BASE) < PCI_SOC_RANGE_MASK))
-		window_start = 0;
 	else
 		window_start = WINDOW_START;
 
 	return window_start;
 }
 
+static inline bool ath12k_pci_is_offset_within_mhi_region(u32 offset)
+{
+	return (offset >= PCI_MHIREGLEN_REG && offset <= PCI_MHI_REGION_END);
+}
+
 static void ath12k_pci_soc_global_reset(struct ath12k_base *ab)
 {
 	u32 val, delay;
@@ -1172,15 +1171,17 @@ u32 ath12k_pci_read32(struct ath12k_base *ab, u32 offset)
 		if (window_start == WINDOW_START) {
 			spin_lock_bh(&ab_pci->window_lock);
 			ath12k_pci_select_window(ab_pci, offset);
-			val = ioread32(ab->mem + window_start +
-				       (offset & WINDOW_RANGE_MASK));
+
+			if (ath12k_pci_is_offset_within_mhi_region(offset)) {
+				offset = offset - PCI_MHIREGLEN_REG;
+				val = ioread32(ab->mem +
+					       (offset & WINDOW_RANGE_MASK));
+			} else {
+				val = ioread32(ab->mem + window_start +
+					       (offset & WINDOW_RANGE_MASK));
+			}
 			spin_unlock_bh(&ab_pci->window_lock);
 		} else {
-			if ((!window_start) &&
-			    (offset >= PCI_MHIREGLEN_REG &&
-			     offset <= PCI_MHI_REGION_END))
-				offset = offset - PCI_MHIREGLEN_REG;
-
 			val = ioread32(ab->mem + window_start +
 				       (offset & WINDOW_RANGE_MASK));
 		}
@@ -1217,15 +1218,17 @@ void ath12k_pci_write32(struct ath12k_base *ab, u32 offset, u32 value)
 		if (window_start == WINDOW_START) {
 			spin_lock_bh(&ab_pci->window_lock);
 			ath12k_pci_select_window(ab_pci, offset);
-			iowrite32(value, ab->mem + window_start +
-				  (offset & WINDOW_RANGE_MASK));
+
+			if (ath12k_pci_is_offset_within_mhi_region(offset)) {
+				offset = offset - PCI_MHIREGLEN_REG;
+				iowrite32(value, ab->mem +
+					  (offset & WINDOW_RANGE_MASK));
+			} else {
+				iowrite32(value, ab->mem + window_start +
+					  (offset & WINDOW_RANGE_MASK));
+			}
 			spin_unlock_bh(&ab_pci->window_lock);
 		} else {
-			if ((!window_start) &&
-			    (offset >= PCI_MHIREGLEN_REG &&
-			     offset <= PCI_MHI_REGION_END))
-				offset = offset - PCI_MHIREGLEN_REG;
-
 			iowrite32(value, ab->mem + window_start +
 				  (offset & WINDOW_RANGE_MASK));
 		}
-- 
2.34.1


