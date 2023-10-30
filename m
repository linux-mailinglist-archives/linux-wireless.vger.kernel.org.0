Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E367DC275
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 23:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjJ3W2J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 18:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjJ3W2H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 18:28:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA169118
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 15:28:02 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMOC7F005203;
        Mon, 30 Oct 2023 22:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=OTQhoRtbiNzi6dVmrzPGqxAPK2XUeLV3QRKOXwBBKnQ=;
 b=C6Txfb5/tjvU3rf7IplcEfnWUAsgSYA4uwCQyfWuhTUjnyN0ysrvmz2LTVJEkezVBAUQ
 tDO6mZJEhyB4YsNjefBA134co6QQ8ojpfR4Qj+rm2E76CDPO3+fB1Odb/BkV1G9hWNf7
 vKvQc12PA3K0im+KQiMZ7HrX6B3gmXjASK3nA3T5vVuy/OKOB0RS3emKAGm6bgVRlUlY
 0jl/QzKmg9PclZ7/B92Dy6nLme5a8F4waH6Q1dCR2omrkwHFHAG6Zfbw8UfaZJlB/kcC
 yj7z6hM6OMfIgUTtlvqfx1GjMRn3gysPqrOfFOjn3zIN9D5yZtsBnfdLgl8lEgkt6oIf 0A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u280jsy0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:28:00 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UMS0LP020772
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:28:00 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 15:27:57 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 12/13] wifi: ath12k: fix PCI read and write
Date:   Tue, 31 Oct 2023 03:56:59 +0530
Message-ID: <20231030222700.18914-13-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y7hSUhPVFvxaOVFQYQGseRQX5vDXE49i
X-Proofpoint-ORIG-GUID: y7hSUhPVFvxaOVFQYQGseRQX5vDXE49i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=959
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
index 3d77abd2d..6c182acfd 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -194,18 +194,17 @@ static u32 ath12k_pci_get_window_start(struct ath12k_base *ab,
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
@@ -1063,15 +1062,17 @@ u32 ath12k_pci_read32(struct ath12k_base *ab, u32 offset)
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
@@ -1108,15 +1109,17 @@ void ath12k_pci_write32(struct ath12k_base *ab, u32 offset, u32 value)
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
2.17.1

