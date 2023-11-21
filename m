Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08C77F23B8
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 03:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjKUCNr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 21:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKUCNq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 21:13:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A5C3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 18:13:42 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL23ZVe029372;
        Tue, 21 Nov 2023 02:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=sUpvVYxCilw4NMfcivwCQ5HhgIMzijlNtIIyfZwf77c=;
 b=oN13JaQFHuIc6lATt0m0xugnncetHsSR5RfuGJizUjXfiPqLvsvhUPPZFb6LZNLyL5/H
 ulriHHjUtGi894zAOzYxXUugojylFcrxJLmM3TlTC0nG2JRw99De/vX2v9vGscXBDSf1
 9l8uGnVFdoi4hFW0O2oaSSyAdwif9b+E3F+nmPF/RdPRxYpbjDyp/f1V6giVKu7PwpzV
 S5ef7Co9SWXW0och2tVi0NUkWlzRC3qku8UoMbvWSIqqsJkYoeoQ+rwVuiXoKu2Bj6OW
 5jyb/oNaEkQzN2tsMHNRXu0P1hvrVxk1XgJ0gcS+7lbfsA7d3JK6M+eBnpiTIMH0cfVZ bg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugge18acm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:13:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL2DZXj028531
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:13:36 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 18:13:34 -0800
From:   Kang Yang <quic_kangyang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 2/7] wifi: ath12k: add CE and ext IRQ flag to indicate irq_handler
Date:   Tue, 21 Nov 2023 10:12:58 +0800
Message-ID: <20231121021304.12966-3-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: 1eg-0eXctw5XteTvV3EYm-ixnpCPBObs
X-Proofpoint-ORIG-GUID: 1eg-0eXctw5XteTvV3EYm-ixnpCPBObs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=357 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add two flags to indicate whether IRQ handler for CE and DP can be called.
This is because in one MSI vector case, interrupt is not disabled in
hif_stop and hif_irq_disable. So if interrupt is disabled, MHI interrupt
is disabled too.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v2: No change from v1.

---
 drivers/net/wireless/ath/ath12k/core.h |  2 ++
 drivers/net/wireless/ath/ath12k/pci.c  | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 68c42ca44fcb..63c4d84657c4 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -199,6 +199,8 @@ enum ath12k_dev_flags {
 	ATH12K_FLAG_REGISTERED,
 	ATH12K_FLAG_QMI_FAIL,
 	ATH12K_FLAG_HTC_SUSPEND_COMPLETE,
+	ATH12K_FLAG_CE_IRQ_ENABLED,
+	ATH12K_FLAG_EXT_IRQ_ENABLED,
 };
 
 enum ath12k_monitor_flags {
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index c5bc9afaa9fc..7f984a80fb27 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -373,6 +373,8 @@ static void ath12k_pci_ce_irqs_disable(struct ath12k_base *ab)
 {
 	int i;
 
+	clear_bit(ATH12K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags);
+
 	for (i = 0; i < ab->hw_params->ce_count; i++) {
 		if (ath12k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
@@ -406,6 +408,10 @@ static void ath12k_pci_ce_tasklet(struct tasklet_struct *t)
 static irqreturn_t ath12k_pci_ce_interrupt_handler(int irq, void *arg)
 {
 	struct ath12k_ce_pipe *ce_pipe = arg;
+	struct ath12k_base *ab = ce_pipe->ab;
+
+	if (!test_bit(ATH12K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags))
+		return IRQ_HANDLED;
 
 	/* last interrupt received for this CE */
 	ce_pipe->timestamp = jiffies;
@@ -428,6 +434,8 @@ static void __ath12k_pci_ext_irq_disable(struct ath12k_base *ab)
 {
 	int i;
 
+	clear_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
+
 	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath12k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
@@ -483,6 +491,10 @@ static int ath12k_pci_ext_grp_napi_poll(struct napi_struct *napi, int budget)
 static irqreturn_t ath12k_pci_ext_interrupt_handler(int irq, void *arg)
 {
 	struct ath12k_ext_irq_grp *irq_grp = arg;
+	struct ath12k_base *ab = irq_grp->ab;
+
+	if (!test_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags))
+		return IRQ_HANDLED;
 
 	ath12k_dbg(irq_grp->ab, ATH12K_DBG_PCI, "ext irq:%d\n", irq);
 
@@ -626,6 +638,8 @@ static void ath12k_pci_ce_irqs_enable(struct ath12k_base *ab)
 {
 	int i;
 
+	set_bit(ATH12K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags);
+
 	for (i = 0; i < ab->hw_params->ce_count; i++) {
 		if (ath12k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
@@ -975,6 +989,8 @@ void ath12k_pci_ext_irq_enable(struct ath12k_base *ab)
 {
 	int i;
 
+	set_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
+
 	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath12k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
-- 
2.34.1

