Return-Path: <linux-wireless+bounces-19822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8946EA50A82
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 19:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E1D188B10B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACEB257ADB;
	Wed,  5 Mar 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VqLGumc9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9F425742B;
	Wed,  5 Mar 2025 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200972; cv=none; b=ZCx+TuwTHEh5Ju217SCEYtF64j/s6fb4HZ/06HZ6GUQv05Zbfro8qNouL2bJORVQy5VPPKhEAj8CVtjyEvscQqGYQkFoFc1oPqwMrv/Qn1V+sAGf4OzxNTkwGMfGXRlDH0NNU8xDwRJsqN4jOIAPS/ItfHyulu22EZuywuH2wXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200972; c=relaxed/simple;
	bh=MpM7B4VEuguCgZ+mH3k6R2uhTi93Rx3HOkk4jwIVZmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjwlxRp12/oNy7dA8oKkT482pqHwq/QR3Nm8AVkBRs4GR9fkNU8pyARLLii7EVUYJlrgFqbNx7qmiJETlFeLlvBXEdkorVhxB42eAot3G7DmxYx2niUnea47/KaN6MbHA5srWNSCF5VFeT+YSVSbPukn2+MeqBj6PDq6VgMI93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VqLGumc9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525B1TgS012881;
	Wed, 5 Mar 2025 18:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ztjSg7idj2pQKxvx6vrc+WeOuuy7j/s4ig6YtaF6Ly8=; b=VqLGumc9OLcwUMkB
	0rPRGI+s2h2E4DZ3q00i1n+qWoQhDSUpw/zFJhrnJnyIrGl4DfIMheASsOBQX/Xo
	DNMVsKAS8v6fXJd/BOvCbhinKKhMJIIZq22rysHSUnFyH22sd8QSJAVjOqXK06Ra
	OJ9tKCynpqcxSUvNsXuUMNtNEYBxjWInmzjnyQCwevDm+OiRpSkc/rUSyVVt1O05
	ZP+5lT+iuLUbjRup9D4//X/eHfa/f43+YXOMJKS7yG67VdX3/eYyw7rXgZfzExsV
	hUwB8sW1AFbdLQq4ryPj4IFyGQs1Wvr3ORGla3ICQWZhrxYFtUiJnSU9wlmZhdEt
	tdtLdg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6vpgkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 18:56:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 525Iu3nw009934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 18:56:03 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Mar 2025 10:55:59 -0800
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
	<quic_rajkbhag@quicinc.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH ath-next v9 10/13] wifi: ath12k: Register various userPD interrupts and save SMEM entries
Date: Thu, 6 Mar 2025 00:24:58 +0530
Message-ID: <20250305185501.2400888-11-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305185501.2400888-1-quic_rajkbhag@quicinc.com>
References: <20250305185501.2400888-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: RPnBXkFVBDoqTKUzVjOtU4nX7yODETbW
X-Authority-Analysis: v=2.4 cv=LYfG6ifi c=1 sm=1 tr=0 ts=67c89e44 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=M8MUCSGaitjyiz5FeOUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: RPnBXkFVBDoqTKUzVjOtU4nX7yODETbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050145

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
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 79 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/ahb.h | 16 ++++++
 drivers/net/wireless/ath/ath12k/hw.h  |  1 +
 3 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 8f7a00e9602f..291ae8177cdd 100644
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
 		ret = -EOPNOTSUPP;
@@ -794,6 +868,7 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
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


