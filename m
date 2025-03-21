Return-Path: <linux-wireless+bounces-20659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB1A6B945
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 11:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9223BC550
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F3D22B8D2;
	Fri, 21 Mar 2025 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j0dmn0io"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E022B5AC;
	Fri, 21 Mar 2025 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554418; cv=none; b=rDz2nmIDTZHeZcmc/cVmaX+obuNyI8pIqnRz4lnBMLPXCWZhDJmvF6gvhix9l8Gd5shsDgks1XMu7+YU0jsJ66zf4MemtmIZG6HalKwZB8JWC8FQwdwrA5bkxXLSdndvHJK2KE4xpEOb19JUBurI4tPe0HEdj+KzyesRdG6TliM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554418; c=relaxed/simple;
	bh=+IrjkGANvDJDtQMz121UIPGRaAQqeRfVazP+4MgEqxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lZKFaAJL1SSF3+paG+49435BQ9Zj1nWvWCs+tPhLi1r0mdM2MU32meSh5jSAJFgIGlROo2GTzvY8PqwOiWYBGDqTap4bxZ+8+uhJhsBCPv4tppvH2Mw+08XlE0UgnPmAx6Et9iYOmmK5pCABLws3wLJvnUCX+SZdGGJR/72yH70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j0dmn0io; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATB76022241;
	Fri, 21 Mar 2025 10:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ikeo7J4pru7bU8Em37v8N6Z1iIaD7pIN97H39+aGLns=; b=j0dmn0iopTIMnM4r
	VS9G40Tg3qSlP4YcrWFGrYUnQw34gJ4ODmftgK3EJ1R/W7XInLUBxlpDOHAaRftJ
	N+DQ+3a2IvAH4FJy4cquKEnp/4vVbEt4MvrolrXOKGLUauiWL36EXo7ti41h80ge
	/JwLa0IfKDzFppersjDJwreJhNwdsN3YJa0SGY4oJhvBPGdSahM0Xj49wxpTLlFW
	ZhJxOBEqBhPkXfr+/zHmcxkJ18IazwXVS1Va1cmr63a+AKuGeV7AMJ2jrq/KaAK8
	29qwEED5OhSlQHPf2FvXjjrsupV4RyEJfbI1a4z5dTejIUeTaMIghrxqcXFbJyxj
	2TdfZw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4wpgc08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:53:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52LArRBb002486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:53:27 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Mar 2025 03:53:23 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Fri, 21 Mar 2025 16:22:46 +0530
Subject: [PATCH ath-next v12 09/13] wifi: ath12k: Power up root PD
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250321-ath12k-ahb-v12-9-bb389ed76ae5@quicinc.com>
References: <20250321-ath12k-ahb-v12-0-bb389ed76ae5@quicinc.com>
In-Reply-To: <20250321-ath12k-ahb-v12-0-bb389ed76ae5@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Sowmiya Sree
 Elavalagan" <quic_ssreeela@quicinc.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l64CR7GJDEfDxgQr0uvL_n7tSfVANLt9
X-Proofpoint-GUID: l64CR7GJDEfDxgQr0uvL_n7tSfVANLt9
X-Authority-Analysis: v=2.4 cv=ZN3XmW7b c=1 sm=1 tr=0 ts=67dd4528 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ts5QanDNsPI7iOQJwMMA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210080

From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

Q6 processor acts as rootPD, other hardware like IPQ5332 which are
attached to Q6 act as userPDs. WCSS driver handles loading and booting
of rootPD, while the ath12k driver boots the userPD.
Get the rproc handle from the DTS entry and boot the rootPD if it
is not already powered on. Register to the rproc notifier to monitor
the rproc state, this allows ath12k driver to know power up/down
sequence of the rootPD. Power up the rootPD and wait for a power-up
notification from the notifier callback before powering up the userPDs.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 146 +++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/ahb.h |   7 ++
 2 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 28986500ff7d268fc91d900108d4aeaf8ae4a38e..c08c2e6bc0d4a92b546189b0e5a2cc4738c50ea2 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -8,6 +8,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/remoteproc.h>
 #include "ahb.h"
 #include "debug.h"
 #include "hif.h"
@@ -546,6 +547,136 @@ static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
 	.map_service_to_pipe = ath12k_ahb_map_service_to_pipe,
 };
 
+static int ath12k_ahb_root_pd_state_notifier(struct notifier_block *nb,
+					     const unsigned long event, void *data)
+{
+	struct ath12k_ahb *ab_ahb = container_of(nb, struct ath12k_ahb, root_pd_nb);
+	struct ath12k_base *ab = ab_ahb->ab;
+
+	if (event == ATH12K_RPROC_AFTER_POWERUP) {
+		ath12k_dbg(ab, ATH12K_DBG_AHB, "Root PD is UP\n");
+		complete(&ab_ahb->rootpd_ready);
+	}
+
+	return 0;
+}
+
+static int ath12k_ahb_register_rproc_notifier(struct ath12k_base *ab)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+
+	ab_ahb->root_pd_nb.notifier_call = ath12k_ahb_root_pd_state_notifier;
+	init_completion(&ab_ahb->rootpd_ready);
+
+	ab_ahb->root_pd_notifier = qcom_register_ssr_notifier(ab_ahb->tgt_rproc->name,
+							      &ab_ahb->root_pd_nb);
+	if (IS_ERR(ab_ahb->root_pd_notifier))
+		return PTR_ERR(ab_ahb->root_pd_notifier);
+
+	return 0;
+}
+
+static void ath12k_ahb_unregister_rproc_notifier(struct ath12k_base *ab)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+
+	if (!ab_ahb->root_pd_notifier) {
+		ath12k_err(ab, "Rproc notifier not registered\n");
+		return;
+	}
+
+	qcom_unregister_ssr_notifier(ab_ahb->root_pd_notifier,
+				     &ab_ahb->root_pd_nb);
+	ab_ahb->root_pd_notifier = NULL;
+}
+
+static int ath12k_ahb_get_rproc(struct ath12k_base *ab)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+	struct device *dev = ab->dev;
+	struct device_node *np;
+	struct rproc *prproc;
+
+	np = of_parse_phandle(dev->of_node, "qcom,rproc", 0);
+	if (!np) {
+		ath12k_err(ab, "failed to get q6_rproc handle\n");
+		return -ENOENT;
+	}
+
+	prproc = rproc_get_by_phandle(np->phandle);
+	of_node_put(np);
+	if (!prproc)
+		return dev_err_probe(&ab->pdev->dev, -EPROBE_DEFER,
+				     "failed to get rproc\n");
+
+	ab_ahb->tgt_rproc = prproc;
+
+	return 0;
+}
+
+static int ath12k_ahb_boot_root_pd(struct ath12k_base *ab)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+	unsigned long time_left;
+	int ret;
+
+	ret = rproc_boot(ab_ahb->tgt_rproc);
+	if (ret < 0) {
+		ath12k_err(ab, "RootPD boot failed\n");
+		return ret;
+	}
+
+	time_left = wait_for_completion_timeout(&ab_ahb->rootpd_ready,
+						ATH12K_ROOTPD_READY_TIMEOUT);
+	if (!time_left) {
+		ath12k_err(ab, "RootPD ready wait timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int ath12k_ahb_configure_rproc(struct ath12k_base *ab)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+	int ret;
+
+	ret = ath12k_ahb_get_rproc(ab);
+	if (ret < 0)
+		return ret;
+
+	ret = ath12k_ahb_register_rproc_notifier(ab);
+	if (ret < 0) {
+		ret = dev_err_probe(&ab->pdev->dev, ret,
+				    "failed to register rproc notifier\n");
+		goto err_put_rproc;
+	}
+
+	if (ab_ahb->tgt_rproc->state != RPROC_RUNNING) {
+		ret = ath12k_ahb_boot_root_pd(ab);
+		if (ret < 0) {
+			ath12k_err(ab, "failed to boot the remote processor Q6\n");
+			goto err_unreg_notifier;
+		}
+	}
+	return 0;
+
+err_unreg_notifier:
+	ath12k_ahb_unregister_rproc_notifier(ab);
+
+err_put_rproc:
+	rproc_put(ab_ahb->tgt_rproc);
+	return ret;
+}
+
+static void ath12k_ahb_deconfigure_rproc(struct ath12k_base *ab)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+
+	ath12k_ahb_unregister_rproc_notifier(ab);
+	rproc_put(ab_ahb->tgt_rproc);
+}
+
 static int ath12k_ahb_resource_init(struct ath12k_base *ab)
 {
 	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
@@ -631,6 +762,7 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 {
 	struct ath12k_base *ab;
 	const struct ath12k_hif_ops *hif_ops;
+	struct ath12k_ahb *ab_ahb;
 	enum ath12k_hw_rev hw_rev;
 	u32 addr;
 	int ret;
@@ -660,6 +792,8 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 	ab->pdev = pdev;
 	ab->hw_rev = hw_rev;
 	platform_set_drvdata(pdev, ab);
+	ab_ahb = ath12k_ab_to_ahb(ab);
+	ab_ahb->ab = ab;
 
 	/* Set fixed_mem_region to true for platforms that support fixed memory
 	 * reservation from DT. If memory is reserved from DT for FW, ath12k driver
@@ -688,20 +822,27 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 
 	ath12k_ahb_init_qmi_ce_config(ab);
 
+	ret = ath12k_ahb_configure_rproc(ab);
+	if (ret)
+		goto err_ce_free;
+
 	ret = ath12k_ahb_config_irq(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to configure irq: %d\n", ret);
-		goto err_ce_free;
+		goto err_rproc_deconfigure;
 	}
 
 	ret = ath12k_core_init(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to init core: %d\n", ret);
-		goto err_ce_free;
+		goto err_rproc_deconfigure;
 	}
 
 	return 0;
 
+err_rproc_deconfigure:
+	ath12k_ahb_deconfigure_rproc(ab);
+
 err_ce_free:
 	ath12k_ce_free_pipes(ab);
 
@@ -741,6 +882,7 @@ static void ath12k_ahb_free_resources(struct ath12k_base *ab)
 	ath12k_hal_srng_deinit(ab);
 	ath12k_ce_free_pipes(ab);
 	ath12k_ahb_resource_deinit(ab);
+	ath12k_ahb_deconfigure_rproc(ab);
 	ath12k_core_free(ab);
 	platform_set_drvdata(pdev, NULL);
 }
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index 64f0696588c05b4036f8ea45eab127cc15dd4226..1105473917ceeda294b5e073fff875331b7b1d8b 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.h
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -7,6 +7,7 @@
 #define ATH12K_AHB_H
 
 #include <linux/clk.h>
+#include <linux/remoteproc/qcom_rproc.h>
 #include "core.h"
 
 #define ATH12K_AHB_RECOVERY_TIMEOUT (3 * HZ)
@@ -16,6 +17,8 @@
 #define ATH12K_AHB_SMP2P_SMEM_VALUE_MASK	0xFFFFFFFF
 #define ATH12K_PCI_CE_WAKE_IRQ			2
 #define ATH12K_PCI_IRQ_CE0_OFFSET		3
+#define ATH12K_ROOTPD_READY_TIMEOUT		(5 * HZ)
+#define ATH12K_RPROC_AFTER_POWERUP		QCOM_SSR_AFTER_POWERUP
 
 enum ath12k_ahb_smp2p_msg_id {
 	ATH12K_AHB_POWER_SAVE_ENTER = 1,
@@ -25,8 +28,12 @@ enum ath12k_ahb_smp2p_msg_id {
 struct ath12k_base;
 
 struct ath12k_ahb {
+	struct ath12k_base *ab;
 	struct rproc *tgt_rproc;
 	struct clk *xo_clk;
+	struct completion rootpd_ready;
+	struct notifier_block root_pd_nb;
+	void *root_pd_notifier;
 };
 
 static inline struct ath12k_ahb *ath12k_ab_to_ahb(struct ath12k_base *ab)

-- 
2.34.1


