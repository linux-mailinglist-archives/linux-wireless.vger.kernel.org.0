Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116887F23B5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 03:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjKUCNn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 21:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKUCNm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 21:13:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415D5CC
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 18:13:39 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL1kUfg016808;
        Tue, 21 Nov 2023 02:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=RVswQanSlZDwRvjP+z0pW7HS5L7S568d6bpUCj3FAMQ=;
 b=DoDN+3WaVetpJSGoVdrOZdXgXr8JO5s0Bjw9vYsAkNrmdUeRrbhMBufYCPhm6HOV4BAh
 lDyQeldo5tOZqbXXEh6ikxnHfSYlTmfLU5xysX4lIY2cZ5UdlYlOQafi0ws+2WO+wVa/
 1KoqU6aYQLypHixMuWrCcilGWR4jZPCxzTpgYXpWlmR2PS/PAbR+6EmbsWFh+1+dt7YY
 SDuol6ClP2SlhwuXxGU5EuUD44Y65p+bdSUJUBKVwjYpddQpiYl/uKrHm+oxHnyHNtno
 IxwijV1EwGEatRNDitJQDe9NeB1neMop7OjS6mwx19/c0K6lwh9G0Gv4vIyAb2yNOuTC qg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugcqs0taq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:13:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL2DYWw011808
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:13:34 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 18:13:32 -0800
From:   Kang Yang <quic_kangyang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 1/7] wifi: ath12k: get msi_data again after request_irq is called
Date:   Tue, 21 Nov 2023 10:12:57 +0800
Message-ID: <20231121021304.12966-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121021304.12966-1-quic_kangyang@quicinc.com>
References: <20231121021304.12966-1-quic_kangyang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nSXVxXXLAlXOKzv39A-KZEgEYT0Y2XUf
X-Proofpoint-GUID: nSXVxXXLAlXOKzv39A-KZEgEYT0Y2XUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=938
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The reservation mode of interrupts in kernel assigns a dummy vector
when the interrupt is allocated and assigns a real vector when the
request_irq is called. The reservation mode helps to ease vector
pressure when devices with a large amount of queues/interrupts are
initialized, but only a minimal subset of those queues/interrupts
is actually used.

So on reservation mode, the msi_data may change after request_irq is
called, then it will lead to spurious interrupt. But when VT-d in
BIOS is enabled and ath12k can get 32 MSI vectors, ath12k always get
the same msi_data before and after request_irq.

So in case of one MSI vector, ath12k need read msi_data again after
request_irq is called, and then the correct msi_data is programmed
into WCN7850 hardware components.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v2: No change from v1.

---
 drivers/net/wireless/ath/ath12k/pci.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 3006cd3fbe11..c5bc9afaa9fc 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -708,6 +708,25 @@ static void ath12k_pci_msi_free(struct ath12k_pci *ab_pci)
 	pci_free_irq_vectors(ab_pci->pdev);
 }
 
+static int ath12k_pci_config_msi_data(struct ath12k_pci *ab_pci)
+{
+	struct msi_desc *msi_desc;
+
+	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
+	if (!msi_desc) {
+		ath12k_err(ab_pci->ab, "msi_desc is NULL!\n");
+		pci_free_irq_vectors(ab_pci->pdev);
+		return -EINVAL;
+	}
+
+	ab_pci->msi_ep_base_data = msi_desc->msg.data;
+
+	ath12k_dbg(ab_pci->ab, ATH12K_DBG_PCI, "pci after request_irq msi_ep_base_data %d\n",
+		   ab_pci->msi_ep_base_data);
+
+	return 0;
+}
+
 static int ath12k_pci_claim(struct ath12k_pci *ab_pci, struct pci_dev *pdev)
 {
 	struct ath12k_base *ab = ab_pci->ab;
@@ -1286,6 +1305,17 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		goto err_ce_free;
 	}
 
+	/* kernel may allocate a dummy vector before request_irq and
+	 * then allocate a real vector when request_irq is called.
+	 * So get msi_data here again to avoid spurious interrupt
+	 * as msi_data will configured to srngs.
+	 */
+	ret = ath12k_pci_config_msi_data(ab_pci);
+	if (ret) {
+		ath12k_err(ab, "failed to config msi_data: %d\n", ret);
+		goto err_free_irq;
+	}
+
 	ret = ath12k_core_init(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to init core: %d\n", ret);
-- 
2.34.1

