Return-Path: <linux-wireless+bounces-13997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAF999F57D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 20:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF872848FF
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D031FF03F;
	Tue, 15 Oct 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mf09iTQO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195B1FF029;
	Tue, 15 Oct 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016918; cv=none; b=nJAAY4dnW0D7b0GNoTGo/liE/3PbZU/M1F+bNFpB4q2gGJTHTHE53/ZSrVNfqhfgz0Wg+XOTJGGZ3mISMzjW9Gzts7GcL3IbKzY6Qr4nP0OXY28IaE3sqxe934zyb6dUbA+t4vC3DMRPYEK0VrnCeHXPAOt4f11u2JIYdidiaLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016918; c=relaxed/simple;
	bh=EmyHcYr2R3cztoflD7rbb7zbpa+A3C8cUr8FJATVtho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vB/6mnLKb1yt/mNrSfJ9XqYvW4N10D9zA3Ey6L9z8lpFPY9dx5K87AO7fzmPffUx0ta5lw3xGW+sJOiTjvYB2ipg+en7nD8wvAevyALgawKJ9MKICwxy2zSyDhtGnEyF04iRqy5QX+rqbxsie/tRLV0qihpJQqhOrXXIqIw/EIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mf09iTQO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FH4bKf027069;
	Tue, 15 Oct 2024 18:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6CZ3wsDki4Yjq6d7XGf9ovEe9RqWs2nfDi6Xyl1OkuE=; b=mf09iTQOq2ILOGAY
	Tor0gE4VAFd1Zj8xUi1d6Ya8qwddT092TdHPs+B9K0F0s6hIN+G8ELWfk37EZfb/
	uS+1Z3awCxBGoWWzGXcNnWYMa+U7It3+zRgN5RvZECa1zl6h9ftDU3TYWG6UTTyh
	fRTGarXavaePZKyaCcFkCFL4yU6fo+sEGj0Y2XzVq4aWd589gCTIRovtcdGHWO2w
	x7MMkRb1qnX/xYz+DBa4IaFRhSgKqnCdf3ZPEBSYBn5j6J9SWl7GIpkpEshw1R6B
	PlCAGK/XRp+PswNlp+MIR02YG7OIp6LgE30bgCgM7lJxn4HFaJkeDWy8GE01tGL8
	+7cGTw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429m0f9vwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FISUnD017907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:30 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 11:28:25 -0700
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
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 16/22] wifi: ath12k: convert tasklet to BH workqueue for CE interrupts
Date: Tue, 15 Oct 2024 23:56:31 +0530
Message-ID: <20241015182637.955753-17-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: nrFfWYu1nrH5LHLzQ0PDaDnUEeiyo-53
X-Proofpoint-ORIG-GUID: nrFfWYu1nrH5LHLzQ0PDaDnUEeiyo-53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150125

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


