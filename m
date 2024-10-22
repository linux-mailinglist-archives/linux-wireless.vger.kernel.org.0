Return-Path: <linux-wireless+bounces-14293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDDD9A9AE0
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 09:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F89A1F21657
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 07:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA701465BB;
	Tue, 22 Oct 2024 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YFgz3AC1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC084A22
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581875; cv=none; b=UJYCd2MrfAiEJ/o29Y44DNDsBIoyYLTjg12kBmVnSKtQflSs2YvC2lcEQM45686Nvw41Huogb/+f6q0T3IMsFPF3+PybRcHJfHiffa5Sy8c1fB7hE4LyVk4eM130wgngHmNmeO0jp7hpN7+da16smfKiIugdZDJNakNe9Kd7bUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581875; c=relaxed/simple;
	bh=Mn+WmlDAeoWfh4SFMkV71J6Z45clZ1+aE7gAEY2Etp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uIIE5vq9wQ/ZPMMcssTp9/sAnuR5llBsOKfUZ3iUWElh+uWu7hDf2Aze2+hmWhrnK4t80wZFnqlOUNm6THFNbOfH0jt61SEeGfdyiDO/0HesCyAGfzPU0OxgUPVzI5Mj+fsVhWPPGpayfwsYDntLNK65bZkF8Z9xHwyxMMurGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YFgz3AC1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LNFJkg028031;
	Tue, 22 Oct 2024 07:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FxDKEyZZo29nj7ZoTBY6cV
	oj9iNUxfeQhNIlfNxEU3c=; b=YFgz3AC1uzPJp3EckxguD6QZ0nd2J6AqBI7STR
	hQXecsw0n6T/dNP/LstDvXZSqfDi8z23e/jUm2MQSYjvTNdSA4xTmYynYPco/oOl
	5Y3hru0gaOEDUUxzTpaP4/KcEA8cz9UV/cAOvPlqzQd3Av4cxFL4ZRVExP9oq2r6
	DaGSLE937f87WTEoOWZsVG25iuqPBHc/v1HtozSDQ+qoaDypdzeQN9Xxfr1QZash
	rmEFvvqteIOqAQE1WNe5HAe0v9EV+qb5A3u6hVnn2UcXA9K5pZyx8jqszLuwedqt
	NGhZQ7hztHDVGBJJ7LF19JBIKfQAtpbJX2BTVFot8uE4H8Zw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dmj13akw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 07:24:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49M7OSfC024937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 07:24:28 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 00:24:27 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v3] wifi: ath12k: convert tasklet to BH workqueue for CE interrupts
Date: Tue, 22 Oct 2024 12:54:06 +0530
Message-ID: <20241022072406.3231450-1-quic_rajkbhag@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uOwi9i0iqHCxeRv1OAUWpcGP2AsD-Qo3
X-Proofpoint-ORIG-GUID: uOwi9i0iqHCxeRv1OAUWpcGP2AsD-Qo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=981 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220046

Currently in Ath12k, tasklet is used to handle the BH context of CE
interrupts. However the tasklet is marked deprecated and has some
design flaws. To replace tasklets, BH workqueue support has been
added. BH workqueue behaves similarly to regular workqueues except
that the queued work items are executed in the BH context.

Hence, convert the tasklet to BH workqueue for handling CE interrupts
in the BH context.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
v3:
 - Removing this patch and sending it seperately from the series:
   "wifi: ath12k: add Ath12k AHB driver support for IPQ5332"

v2: https://patchwork.kernel.org/project/linux-wireless/patch/20241015182637.955753-17-quic_rajkbhag@quicinc.com/
 - No change
---
 drivers/net/wireless/ath/ath12k/ce.h  |  2 +-
 drivers/net/wireless/ath/ath12k/pci.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index 857bc5f9e946..1a14b9fb86b8 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -148,7 +148,7 @@ struct ath12k_ce_pipe {
 	void (*send_cb)(struct ath12k_ce_pipe *pipe);
 	void (*recv_cb)(struct ath12k_base *ab, struct sk_buff *skb);
 
-	struct tasklet_struct intr_tq;
+	struct work_struct intr_wq;
 	struct ath12k_ce_ring *src_ring;
 	struct ath12k_ce_ring *dest_ring;
 	struct ath12k_ce_ring *status_ring;
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index fd47394553b8..cf907550e6a4 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -427,9 +427,9 @@ static void ath12k_pci_sync_ce_irqs(struct ath12k_base *ab)
 	}
 }
 
-static void ath12k_pci_ce_tasklet(struct tasklet_struct *t)
+static void ath12k_pci_ce_workqueue(struct work_struct *work)
 {
-	struct ath12k_ce_pipe *ce_pipe = from_tasklet(ce_pipe, t, intr_tq);
+	struct ath12k_ce_pipe *ce_pipe = from_work(ce_pipe, work, intr_wq);
 	int irq_idx = ATH12K_PCI_IRQ_CE0_OFFSET + ce_pipe->pipe_num;
 
 	ath12k_ce_per_engine_service(ce_pipe->ab, ce_pipe->pipe_num);
@@ -451,7 +451,7 @@ static irqreturn_t ath12k_pci_ce_interrupt_handler(int irq, void *arg)
 
 	disable_irq_nosync(ab->irq_num[irq_idx]);
 
-	tasklet_schedule(&ce_pipe->intr_tq);
+	queue_work(system_bh_wq, &ce_pipe->intr_wq);
 
 	return IRQ_HANDLED;
 }
@@ -677,7 +677,7 @@ static int ath12k_pci_config_irq(struct ath12k_base *ab)
 
 		irq_idx = ATH12K_PCI_IRQ_CE0_OFFSET + i;
 
-		tasklet_setup(&ce_pipe->intr_tq, ath12k_pci_ce_tasklet);
+		INIT_WORK(&ce_pipe->intr_wq, ath12k_pci_ce_workqueue);
 
 		ret = request_irq(irq, ath12k_pci_ce_interrupt_handler,
 				  ab_pci->irq_flags, irq_name[irq_idx],
@@ -964,7 +964,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
 						   PCI_EXP_LNKCTL_ASPMC);
 }
 
-static void ath12k_pci_kill_tasklets(struct ath12k_base *ab)
+static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
 {
 	int i;
 
@@ -974,7 +974,7 @@ static void ath12k_pci_kill_tasklets(struct ath12k_base *ab)
 		if (ath12k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 
-		tasklet_kill(&ce_pipe->intr_tq);
+		cancel_work_sync(&ce_pipe->intr_wq);
 	}
 }
 
@@ -982,7 +982,7 @@ static void ath12k_pci_ce_irq_disable_sync(struct ath12k_base *ab)
 {
 	ath12k_pci_ce_irqs_disable(ab);
 	ath12k_pci_sync_ce_irqs(ab);
-	ath12k_pci_kill_tasklets(ab);
+	ath12k_pci_cancel_workqueue(ab);
 }
 
 int ath12k_pci_map_service_to_pipe(struct ath12k_base *ab, u16 service_id,

base-commit: fa934bf3e0a825ee09f035c6580af513187d59a2
-- 
2.34.1


