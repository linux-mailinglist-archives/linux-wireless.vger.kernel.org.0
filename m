Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35967F1010
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 11:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjKTKQR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 05:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjKTKQO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 05:16:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF139F
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 02:16:11 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK8kdcW005467;
        Mon, 20 Nov 2023 10:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=0Q30fUnEC8dc/TdDUbHchCzmrZySf8JegoY3CDdHNy0=;
 b=b1LuSATipI5eU7SN6/aAF71zCX1D4L9nnTN7wICeJi2jgfQ4GcRv7ARGc/ko9gKRuTJ8
 Wv7CBfFaCSmnZTNCNjtytRILS4WanKwq4jOUL/R1PqQ8F051iYjIYfsDOUgVn85NG7hr
 tiJbdKkn5m3Z/+/2d6S8oYIfhoSWayvtIECo8DaKrOLbEpdlh6kpQaA1thISE6V/V9oR
 j1ki13Mxikiu4JBvJ2z/1MIWUlGlWIGQMjpCRBqKuqChLwaqDuLAHb2MwIxhkDCVdkC3
 K5JEC3eY6/49TO/WGzE9YWQDcSCa0ioYp3ktm0j39dLq/hRZB6xmhn1tvI45GHTq8Q9v Hg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uejmuuvs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:16:04 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKAG3l0023591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:16:03 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 02:16:01 -0800
From:   Kang Yang <quic_kangyang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 3/7] wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP IRQ
Date:   Mon, 20 Nov 2023 18:15:39 +0800
Message-ID: <20231120101543.4369-4-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120101543.4369-1-quic_kangyang@quicinc.com>
References: <20231120101543.4369-1-quic_kangyang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aJozi39RJLHrM7peK0o-7Es1S8_RwIWp
X-Proofpoint-ORIG-GUID: aJozi39RJLHrM7peK0o-7Es1S8_RwIWp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_08,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=610
 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Like ATH12K_PCI_IRQ_CE0_OFFSET, define ATH12K_PCI_IRQ_DP_OFFSET for
DP to save the IRQ instead of base_vector from MSI config.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 7f984a80fb27..4b872eff087c 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -17,7 +17,8 @@
 #define ATH12K_PCI_BAR_NUM		0
 #define ATH12K_PCI_DMA_MASK		32
 
-#define ATH12K_PCI_IRQ_CE0_OFFSET		3
+#define ATH12K_PCI_IRQ_CE0_OFFSET	3
+#define ATH12K_PCI_IRQ_DP_OFFSET	14
 
 #define WINDOW_ENABLE_BIT		0x40000000
 #define WINDOW_REG_ADDRESS		0x310c
@@ -511,9 +512,8 @@ static irqreturn_t ath12k_pci_ext_interrupt_handler(int irq, void *arg)
 static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 {
 	int i, j, ret, num_vectors = 0;
-	u32 user_base_data = 0, base_vector = 0, base_idx;
+	u32 user_base_data = 0, base_vector = 0;
 
-	base_idx = ATH12K_PCI_IRQ_CE0_OFFSET + CE_COUNT_MAX;
 	ret = ath12k_pci_get_user_msi_assignment(ab, "DP",
 						 &num_vectors,
 						 &user_base_data,
@@ -542,7 +542,7 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 		}
 
 		irq_grp->num_irq = num_irq;
-		irq_grp->irqs[0] = base_idx + i;
+		irq_grp->irqs[0] = ATH12K_PCI_IRQ_DP_OFFSET + i;
 
 		for (j = 0; j < irq_grp->num_irq; j++) {
 			int irq_idx = irq_grp->irqs[j];
-- 
2.34.1

