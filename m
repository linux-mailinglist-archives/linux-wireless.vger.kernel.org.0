Return-Path: <linux-wireless+bounces-11417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349369517FE
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09FF28200F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C5816BE1A;
	Wed, 14 Aug 2024 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IojmXFl9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD9516BE13
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628699; cv=none; b=TRnADrPgXe+IT+RLMKvyPkXU91Is5aT4wSMRIqr8YamqQsTsyUGixXF1FXVnXg79HL7NJCttou6KU2KeZca/La1fWOgqzNOXFaT8QqHOhg6Z1UsqM0BV8BBkxRWe3Wi5ovdJYa9vLNUVfuTjwa3cHnRGbVstGydLdDpYE1q9/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628699; c=relaxed/simple;
	bh=EmyHcYr2R3cztoflD7rbb7zbpa+A3C8cUr8FJATVtho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=li8M9F0uVwmF0nEXIhYePkJjb2vPhbX0+iUq8IYmqJY+RIM/PhRxyxGn1SagMvxrOf5oFruyiA+EWb1KUhRhjqMxRkoy1kkNF/3DuEnk8WjJ28bKmrffaG6jl/3+RvhdlPTh1RK9HYM6pr8JYjH0ybEgfI0V4rGtjF1iDtKu4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IojmXFl9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E2clv2016977;
	Wed, 14 Aug 2024 09:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6CZ3wsDki4Yjq6d7XGf9ovEe9RqWs2nfDi6Xyl1OkuE=; b=IojmXFl9SbHo7oNk
	gX3u6KGa4FUzL7aJqX1Xk6VrFw5J6xJW9fkhvhwugvWt5XimhfeoEP2eBZBUDSYm
	PONl3nZrxHY5y5lciecy3cW1Wl6OAGoDKzpFjzltcZs7CysMjfNfdvzHaiJmvS5X
	aKXtuk42ocfuDC6eenSVhEne4zK97QR3lDQ9Z1jHwHyxakU8+f8qlqq5TWWQyTZp
	efutjXedHX0PwaPTkIGJQh8WOO37czYz6Ubigj5wYGevUQGFVISlVlIvBOckcwgN
	ReyLmIVV5eMSkzBKV2dKt15eVTTC4ZzCV0PKYIf5qp2+EZa1sgWV1w0wvMgbQO+K
	TJP1aQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410kywgyr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47E9isot010723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:54 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 02:44:52 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 16/18] wifi: ath12k: convert tasklet to BH workqueue for CE interrupts
Date: Wed, 14 Aug 2024 15:13:21 +0530
Message-ID: <20240814094323.3927603-17-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: nT2fBkIlei8ng7udHneMYK64H_SbBArh
X-Proofpoint-GUID: nT2fBkIlei8ng7udHneMYK64H_SbBArh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=984 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140067

Currently in Ath12k, tasklet is used to handle the BH context of CE
interrupts. However the tasklet is marked deprecated and has some
design flaws. To replace tasklets, BH workqueue support has been
added. BH workqueue behaves similarly to regular workqueues except
that the queued work items are executed in the BH context.

Hence, convert the tasklet to BH workqueue for handling CE interrupts
in the BH context.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ce.h  |  2 +-
 drivers/net/wireless/ath/ath12k/pci.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index 9dd71056e1c5..75c9f8f1f7c6 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -159,7 +159,7 @@ struct ath12k_ce_pipe {
 	void (*send_cb)(struct ath12k_ce_pipe *pipe);
 	void (*recv_cb)(struct ath12k_base *ab, struct sk_buff *skb);
 
-	struct tasklet_struct intr_tq;
+	struct work_struct intr_wq;
 	struct ath12k_ce_ring *src_ring;
 	struct ath12k_ce_ring *dest_ring;
 	struct ath12k_ce_ring *status_ring;
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 0c393bc30f92..9a50d813e9b4 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -425,9 +425,9 @@ static void ath12k_pci_sync_ce_irqs(struct ath12k_base *ab)
 	}
 }
 
-static void ath12k_pci_ce_tasklet(struct tasklet_struct *t)
+static void ath12k_pci_ce_workqueue(struct work_struct *work)
 {
-	struct ath12k_ce_pipe *ce_pipe = from_tasklet(ce_pipe, t, intr_tq);
+	struct ath12k_ce_pipe *ce_pipe = from_work(ce_pipe, work, intr_wq);
 	int irq_idx = ATH12K_PCI_IRQ_CE0_OFFSET + ce_pipe->pipe_num;
 
 	ath12k_ce_per_engine_service(ce_pipe->ab, ce_pipe->pipe_num);
@@ -449,7 +449,7 @@ static irqreturn_t ath12k_pci_ce_interrupt_handler(int irq, void *arg)
 
 	disable_irq_nosync(ab->irq_num[irq_idx]);
 
-	tasklet_schedule(&ce_pipe->intr_tq);
+	queue_work(system_bh_wq, &ce_pipe->intr_wq);
 
 	return IRQ_HANDLED;
 }
@@ -675,7 +675,7 @@ static int ath12k_pci_config_irq(struct ath12k_base *ab)
 
 		irq_idx = ATH12K_PCI_IRQ_CE0_OFFSET + i;
 
-		tasklet_setup(&ce_pipe->intr_tq, ath12k_pci_ce_tasklet);
+		INIT_WORK(&ce_pipe->intr_wq, ath12k_pci_ce_workqueue);
 
 		ret = request_irq(irq, ath12k_pci_ce_interrupt_handler,
 				  ab_pci->irq_flags, irq_name[irq_idx],
@@ -962,7 +962,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
 						   PCI_EXP_LNKCTL_ASPMC);
 }
 
-static void ath12k_pci_kill_tasklets(struct ath12k_base *ab)
+static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
 {
 	int i;
 
@@ -972,7 +972,7 @@ static void ath12k_pci_kill_tasklets(struct ath12k_base *ab)
 		if (ath12k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 
-		tasklet_kill(&ce_pipe->intr_tq);
+		cancel_work_sync(&ce_pipe->intr_wq);
 	}
 }
 
@@ -980,7 +980,7 @@ static void ath12k_pci_ce_irq_disable_sync(struct ath12k_base *ab)
 {
 	ath12k_pci_ce_irqs_disable(ab);
 	ath12k_pci_sync_ce_irqs(ab);
-	ath12k_pci_kill_tasklets(ab);
+	ath12k_pci_cancel_workqueue(ab);
 }
 
 int ath12k_pci_map_service_to_pipe(struct ath12k_base *ab, u16 service_id,
-- 
2.34.1


