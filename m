Return-Path: <linux-wireless+bounces-19560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557CAA488AF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 20:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2B3188B264
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 19:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF46D27127E;
	Thu, 27 Feb 2025 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BG64DuI2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253AB27126D;
	Thu, 27 Feb 2025 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683509; cv=none; b=KyPN4cuL9m0+kbat0CGGm+fjIh2WEqkMJBsfN4vWD0cnUYou7yWTLNBPGTybw21Jesf2adGOncOrclpoFmz5sXnJRJ5ZNO4rI6oZEsGMcZedOXpiMEtXayA7eQWTtrlWc/J6rtQMTo5MIoHI8D/BJ2IjMp1axiRILs132FLgQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683509; c=relaxed/simple;
	bh=VP5ykv4LHxPDvDo/SxzXdvGOsrjZ4YD2RrrzaDGdgiM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGATxbPDyTnKRUh/Q5/Cr26uD0sJlRXVfU1pSsH7/CJC5cutAzKYG/UrvqRFv9Q7ATbiEjG1suIeBUxNRQwO+TGH4iO6k9d0yjFE9HzJRHzS8n9TKHkj3h3NdL+/FOG6sZqmimkbzOeVChOnsg0J6LC2eJlX7xcy4dDZUCYhrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BG64DuI2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RIlVtB015835;
	Thu, 27 Feb 2025 19:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B97ppNrPDPppdC54rMWu0qKrJkkHW7sNQ77xfcM5LQo=; b=BG64DuI27N6NXoFd
	DIfP7W24rV2PLEE6Sc7apKZh3VFLvUaqKBK51idOKhnyajztiKP0Vu+0MdlnaqNO
	Yki/wO/OLcgQJsG3JvcUfGAA6GXcAb8nwm2fwH92x0Ek66Iubwvl8fWBk3eSmIrY
	uK3KgtuLhTGCwuW6huAd1mYaN9/BaZ7y8fZ9N5L/GernERSsjNsTSHa6FOWQwDws
	SGhpPyMLTta2TKNY9hBZ9lAp1wslUFbK3UzwktCvM3lgl8yWvHtPx491kAmVVchT
	A1A8NPtkLteAA1eBinZWoX09AGJe0Z0jrMe0MLbmrymeh2owfsLSOqH0TDa4OPxh
	64kZLw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prnpt1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:11:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51RJBciF025451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:11:38 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 11:11:34 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Sowmiya Sree
 Elavalagan" <quic_ssreeela@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v7 10/13] wifi: ath12k: Register various userPD interrupts and save SMEM entries
Date: Fri, 28 Feb 2025 00:40:31 +0530
Message-ID: <20250227191034.1949954-11-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
References: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: XRhFe7nENlagBwH41Y8BLLsjpf3UbYot
X-Proofpoint-ORIG-GUID: XRhFe7nENlagBwH41Y8BLLsjpf3UbYot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270142

From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

Q6 and ath12k driver communicates using SMEM and IRQs. Spawn interrupt
is triggered once the userPD thread is spawned. Ready interrupts denotes
userPD is completely powered up and ready. Stop-ack is to acknowledge
the ath12k driver that userPD is stopped. Ath12k driver needs to set spawn
bit in SMEM to instruct Q6 to spawn a userPD. Similarly stop bit is
set when userPD needs to be stopped.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 79 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/ahb.h | 16 ++++++
 drivers/net/wireless/ath/ath12k/hw.h  |  1 +
 3 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index a6edf288c22c..4ac2c9179f2d 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -9,6 +9,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
+#include <linux/soc/qcom/smem_state.h>
 #include "ahb.h"
 #include "debug.h"
 #include "hif.h"
@@ -23,6 +24,11 @@ static const struct of_device_id ath12k_ahb_of_match[] = {
 MODULE_DEVICE_TABLE(of, ath12k_ahb_of_match);
 
 #define ATH12K_IRQ_CE0_OFFSET 4
+#define ATH12K_MAX_UPDS 1
+#define ATH12K_UPD_IRQ_WRD_LEN  18
+static const char ath12k_userpd_irq[][9] = {"spawn",
+				     "ready",
+				     "stop-ack"};
 
 static const char *irq_name[ATH12K_IRQ_NUM_MAX] = {
 	"misc-pulse1",
@@ -547,6 +553,72 @@ static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
 	.map_service_to_pipe = ath12k_ahb_map_service_to_pipe,
 };
 
+static irqreturn_t ath12k_userpd_irq_handler(int irq, void *data)
+{
+	struct ath12k_base *ab = data;
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+
+	if (irq == ab_ahb->userpd_irq_num[ATH12K_USERPD_SPAWN_IRQ]) {
+		complete(&ab_ahb->userpd_spawned);
+	} else if (irq == ab_ahb->userpd_irq_num[ATH12K_USERPD_READY_IRQ]) {
+		complete(&ab_ahb->userpd_ready);
+	} else if (irq == ab_ahb->userpd_irq_num[ATH12K_USERPD_STOP_ACK_IRQ])	{
+		complete(&ab_ahb->userpd_stopped);
+	} else {
+		ath12k_err(ab, "Invalid userpd interrupt\n");
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ath12k_ahb_config_rproc_irq(struct ath12k_base *ab)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+	int i, ret;
+	char *upd_irq_name;
+
+	for (i = 0; i < ATH12K_USERPD_MAX_IRQ; i++) {
+		ab_ahb->userpd_irq_num[i] = platform_get_irq_byname(ab->pdev,
+								    ath12k_userpd_irq[i]);
+		if (ab_ahb->userpd_irq_num[i] < 0)
+			return ab_ahb->userpd_irq_num[i];
+
+		upd_irq_name = devm_kzalloc(&ab->pdev->dev, ATH12K_UPD_IRQ_WRD_LEN,
+					    GFP_KERNEL);
+		if (!upd_irq_name)
+			return -ENOMEM;
+
+		scnprintf(upd_irq_name, ATH12K_UPD_IRQ_WRD_LEN, "UserPD%u-%s",
+			  ab_ahb->userpd_id, ath12k_userpd_irq[i]);
+		ret = devm_request_threaded_irq(&ab->pdev->dev, ab_ahb->userpd_irq_num[i],
+						NULL, ath12k_userpd_irq_handler,
+						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+						upd_irq_name, ab);
+		if (ret)
+			return dev_err_probe(&ab->pdev->dev, ret,
+					     "Request %s irq failed: %d\n",
+					     ath12k_userpd_irq[i], ret);
+	}
+
+	ab_ahb->spawn_state = devm_qcom_smem_state_get(&ab->pdev->dev, "spawn",
+						       &ab_ahb->spawn_bit);
+	if (IS_ERR(ab_ahb->spawn_state))
+		return dev_err_probe(&ab->pdev->dev, PTR_ERR(ab_ahb->spawn_state),
+				     "Failed to acquire spawn state\n");
+
+	ab_ahb->stop_state = devm_qcom_smem_state_get(&ab->pdev->dev, "stop",
+						      &ab_ahb->stop_bit);
+	if (IS_ERR(ab_ahb->stop_state))
+		return dev_err_probe(&ab->pdev->dev, PTR_ERR(ab_ahb->stop_state),
+				     "Failed to acquire stop state\n");
+
+	init_completion(&ab_ahb->userpd_spawned);
+	init_completion(&ab_ahb->userpd_ready);
+	init_completion(&ab_ahb->userpd_stopped);
+	return 0;
+}
+
 static int ath12k_ahb_root_pd_state_notifier(struct notifier_block *nb,
 					     const unsigned long event, void *data)
 {
@@ -659,7 +731,8 @@ static int ath12k_ahb_configure_rproc(struct ath12k_base *ab)
 			goto err_unreg_notifier;
 		}
 	}
-	return 0;
+
+	return ath12k_ahb_config_rproc_irq(ab);
 
 err_unreg_notifier:
 	ath12k_ahb_unregister_rproc_notifier(ab);
@@ -764,7 +837,7 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 	const struct ath12k_hif_ops *hif_ops;
 	struct ath12k_ahb *ab_ahb;
 	enum ath12k_hw_rev hw_rev;
-	u32 addr;
+	u32 addr, userpd_id;
 	int ret;
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
@@ -782,6 +855,7 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 	switch (hw_rev) {
 	case ATH12K_HW_IPQ5332_HW10:
 		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
+		userpd_id = ATH12K_IPQ5332_USERPD_ID;
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -793,6 +867,7 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ab);
 	ab_ahb = ath12k_ab_to_ahb(ab);
 	ab_ahb->ab = ab;
+	ab_ahb->userpd_id = userpd_id;
 
 	/* Set fixed_mem_region to true for platforms that support fixed memory
 	 * reservation from DT. If memory is reserved from DT for FW, ath12k driver
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index 1105473917ce..b17e7693b31a 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.h
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -25,6 +25,13 @@ enum ath12k_ahb_smp2p_msg_id {
 	ATH12K_AHB_POWER_SAVE_EXIT,
 };
 
+enum ath12k_ahb_userpd_irq {
+	ATH12K_USERPD_SPAWN_IRQ,
+	ATH12K_USERPD_READY_IRQ,
+	ATH12K_USERPD_STOP_ACK_IRQ,
+	ATH12K_USERPD_MAX_IRQ,
+};
+
 struct ath12k_base;
 
 struct ath12k_ahb {
@@ -34,6 +41,15 @@ struct ath12k_ahb {
 	struct completion rootpd_ready;
 	struct notifier_block root_pd_nb;
 	void *root_pd_notifier;
+	struct qcom_smem_state *spawn_state;
+	struct qcom_smem_state *stop_state;
+	struct completion userpd_spawned;
+	struct completion userpd_ready;
+	struct completion userpd_stopped;
+	u32 userpd_id;
+	u32 spawn_bit;
+	u32 stop_bit;
+	int userpd_irq_num[ATH12K_USERPD_MAX_IRQ];
 };
 
 static inline struct ath12k_ahb *ath12k_ab_to_ahb(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index a4332588b117..d4a2e47169d9 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -97,6 +97,7 @@
 #define ATH12K_REGDB_FILE_NAME		"regdb.bin"
 
 #define ATH12K_PCIE_MAX_PAYLOAD_SIZE	128
+#define ATH12K_IPQ5332_USERPD_ID	1
 
 enum ath12k_hw_rate_cck {
 	ATH12K_HW_RATE_CCK_LP_11M = 0,
-- 
2.34.1


