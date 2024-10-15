Return-Path: <linux-wireless+bounces-14000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7A599F589
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 20:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0C728442C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540CC2003C2;
	Tue, 15 Oct 2024 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AyhZCmfC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986232003A1;
	Tue, 15 Oct 2024 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016930; cv=none; b=TICEeYj6gm5p5OW7hE3lDLYSYhr/3bYSn1uSCGguXvad5YK5/cgvGOu7be7ZrthOoydb3lGZhkQ/l2qJlsPKKHPE51BzsS+nOIaEh2giTlel9qhN2eFQ0noGFNz/aX6A8jqv8TsTD1Rg8qctctp/6Bq5LJ9e3TC/ap9xHQL6aOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016930; c=relaxed/simple;
	bh=cXB3tRJFafa9t3pwvCRQFOeuK4vBD/5wrHNRtF5fjaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drOVW5tAn8oHUroGn/MiL7obrpuVpbXs8lHNvjj8UZZOVk3t9ivget7LWZFGZwhCQv6IZLpeS1pbOKCO7QIGFVyCN8MTq0MXb1yXnchGikSIoTMkYXt26qI18dHwp4yHknHqQ0eS7hwcsWKE5DliW6DUUZOiuelRx7eW3PrpxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AyhZCmfC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBS90i031245;
	Tue, 15 Oct 2024 18:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0EYrQ6SqWmpMLVGW0m0H7qp4u4V/yy8WOKDy9sPnMIk=; b=AyhZCmfCeHQUH76i
	KtXBB6yrH9tojhqFQt02o/XdSS2cICwYbFUO9KzCXvUEEPVHv+f58Sq6yNonvXiv
	Oe65bzF8dUWC6BHyrtrzUXZ9LkYNndZv5nMGGhw3NlFaeiTyE5J8/7kYwkNs/OmT
	ezA0huizTVQhofwQzIs0drcZhEFjnDPovfc+A8PSRVUH9ZVw0z82cKDNmbkod66T
	RRdOjbpJal6F02Xu6fSCIl41EZYJwJ3a+dFhV0nwR0X5bYaqGKGWJINBs8OhCbFj
	/FtluiqUiVD7RmahyFPSFAfZBh7AO0zIxC/IH250fLkGWyRWOlgYL+TKmTQvvZjt
	9aBnZg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427jd90k00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FISiwv019416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:44 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 11:28:40 -0700
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
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 19/22] wifi: ath12k: Register various userPD interrupts and save SMEM entries
Date: Tue, 15 Oct 2024 23:56:34 +0530
Message-ID: <20241015182637.955753-20-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: NnOPtUzGbcD0iI9kV-lT4_76y-a6N-FB
X-Proofpoint-ORIG-GUID: NnOPtUzGbcD0iI9kV-lT4_76y-a6N-FB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150125

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
 drivers/net/wireless/ath/ath12k/ahb.c | 84 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/ahb.h | 16 +++++
 drivers/net/wireless/ath/ath12k/hw.h  |  1 +
 3 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 6c3943b63ac5..7b898f01c255 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -28,6 +28,11 @@ static const struct of_device_id ath12k_ahb_of_match[] = {
 MODULE_DEVICE_TABLE(of, ath12k_ahb_of_match);
 
 #define ATH12K_IRQ_CE0_OFFSET 4
+#define ATH12K_MAX_UPDS 1
+#define ATH12K_UPD_IRQ_WRD_LEN  18
+static const char ath12k_userpd_irq[][9] = {"spawn",
+				     "ready",
+				     "stop-ack"};
 
 static const char *irq_name[ATH12K_IRQ_NUM_MAX] = {
 	"misc-pulse1",
@@ -608,6 +613,78 @@ static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
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
+		if (ab_ahb->userpd_irq_num[i] < 0) {
+			ath12k_err(ab, "Failed to get %s irq: %d", ath12k_userpd_irq[i],
+				   ab_ahb->userpd_irq_num[i]);
+			return -EINVAL;
+		}
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
+		if (ret) {
+			ath12k_err(ab, "Request %s irq failed: %d\n",
+				   ath12k_userpd_irq[i], ret);
+			return ret;
+		}
+	}
+
+	ab_ahb->spawn_state = devm_qcom_smem_state_get(&ab->pdev->dev, "spawn",
+						       &ab_ahb->spawn_bit);
+	if (IS_ERR(ab_ahb->spawn_state)) {
+		ath12k_err(ab, "Failed to acquire spawn state\n");
+		return PTR_ERR(ab_ahb->spawn_state);
+	}
+
+	ab_ahb->stop_state = devm_qcom_smem_state_get(&ab->pdev->dev, "stop",
+						      &ab_ahb->stop_bit);
+	if (IS_ERR(ab_ahb->stop_state)) {
+		ath12k_err(ab, "Failed to acquire stop state\n");
+		return PTR_ERR(ab_ahb->stop_state);
+	}
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
@@ -719,7 +796,8 @@ static int ath12k_ahb_configure_rproc(struct ath12k_base *ab)
 			goto unreg_notifier;
 		}
 	}
-	return 0;
+
+	return ath12k_ahb_config_rproc_irq(ab);
 
 unreg_notifier:
 	ath12k_ahb_unregister_rproc_notifier(ab);
@@ -893,13 +971,14 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 	struct device_node *mem_node;
 	struct ath12k_ahb *ab_ahb;
 	enum ath12k_hw_rev hw_rev;
-	u32 addr;
+	u32 addr, userpd_id;
 	int ret;
 
 	hw_rev = ath12k_ahb_get_hw_rev(pdev);
 	switch (hw_rev) {
 	case ATH12K_HW_IPQ5332_HW10:
 		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
+		userpd_id = ATH12K_IPQ5332_USERPD_ID;
 		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported device type %d\n", hw_rev);
@@ -925,6 +1004,7 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ab);
 	ab_ahb = ath12k_ab_to_ahb(ab);
 	ab_ahb->ab = ab;
+	ab_ahb->userpd_id = userpd_id;
 
 	/* Set fixed_mem_region to true for platforms that support fixed memory
 	 * reservation from DT. If memory is reserved from DT for FW, ath12k driver
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index d1fc63091fb0..0999e2bbe970 100644
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
index b3e2a5d7e0e4..cd034ed14ce3 100644
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


