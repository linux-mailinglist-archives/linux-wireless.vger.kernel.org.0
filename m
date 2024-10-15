Return-Path: <linux-wireless+bounces-13999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E8099F584
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 20:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E87D1F25479
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5F422912E;
	Tue, 15 Oct 2024 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NFr8O1cS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0A22911D;
	Tue, 15 Oct 2024 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016928; cv=none; b=CN/Sra2CdIE1xl3xuUIhUjI9cglDpAtHtL6RKkUtTXwM+2PCesS59ri0UVyvYLb4dW/rB7OY6FnAMwwTgqtykT3Q8wWJFRTlrC4T55GMWcbsy81wPCj5BN7HWMSSHE93b6VapE0LSNvE50fruHN10vyYeGwiemmhdyStxl/k00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016928; c=relaxed/simple;
	bh=P8p3tuaxsKNpE9UclscTBskyimjjbfmth7ShYKTfGj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhhl70cGqbDc5CTyZp6dsWL8g4iLee88AETTiVxlJmgQGyeypHQnuNoKYrrq0Ihts13bEZe3cZUbz2Aen0yiE219RK6dDBl07NSDlKuWUPAFtHB6SfMgoLlUbKY4fiN2ABxIWk7CpMNY+mOQ1bFJYVzFdxd6Y60pTZejy2QUTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NFr8O1cS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHVH5D030770;
	Tue, 15 Oct 2024 18:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KVP38x6AQMyxtkxLDnVbjlxS9NcUknrQ22T0ArsgvWY=; b=NFr8O1cSHWwWHopl
	7lPJ7A8Irbl8VM4G18zcLkP8ZuHKQZO4ApgmO3/NRlndbssSxrWRRLJILWHUiCHi
	16V6qR9sWKYKL9CXVvzzAtIrks6q/5Y81YTXosga4my0QxDy5INLiFtyy4YabqDF
	Hy05RXK9MsFUgg1P1RyHfuUW/qRl0c1and2IvyYCXT7riRgCqcY5h+oDjcqnoqZ5
	5jn49guIvj9WX7NMIAa8ZtOEYSey8fpxhCt8hBnzGbNNxVFUkhToErQ3bmYnrcQj
	GOwpQmCQ1Z9MfEm4eMxO6hFBeqeI92rXjQIO8aX0fl0tJTiBY7PTSJDrlvnk3kLU
	SjB+WQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429mjy1sfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FISdu6017967
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:39 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 11:28:35 -0700
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
Subject: [PATCH v2 18/22] wifi: ath12k: Power up root PD
Date: Tue, 15 Oct 2024 23:56:33 +0530
Message-ID: <20241015182637.955753-19-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: qxgqvTYpn_0xvbEp7UX0_-24s3giC3b6
X-Proofpoint-ORIG-GUID: qxgqvTYpn_0xvbEp7UX0_-24s3giC3b6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150125

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
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 128 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/ahb.h |   7 ++
 2 files changed, 135 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 7049efdae38c..6c3943b63ac5 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -608,6 +608,124 @@ static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
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
+
+	if (!ab_ahb->root_pd_notifier)
+		return -EINVAL;
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
+}
+
+static int ath12k_ahb_get_rproc(struct ath12k_base *ab)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+	struct device *dev = ab->dev;
+	struct rproc *prproc;
+	phandle rproc_phandle;
+
+	if (of_property_read_u32(dev->of_node, "qcom,rproc", &rproc_phandle)) {
+		ath12k_err(ab, "failed to get q6_rproc handle\n");
+		return -ENOENT;
+	}
+
+	prproc = rproc_get_by_phandle(rproc_phandle);
+	if (!prproc) {
+		ath12k_err(ab, "failed to get rproc\n");
+		return -EINVAL;
+	}
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
+	if (ret < 0) {
+		ath12k_err(ab, "failed to get rproc: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath12k_ahb_register_rproc_notifier(ab);
+	if (ret < 0) {
+		ath12k_err(ab, "failed to register rproc notifier\n");
+		return ret;
+	}
+
+	if (ab_ahb->tgt_rproc->state != RPROC_RUNNING) {
+		ret = ath12k_ahb_boot_root_pd(ab);
+		if (ret < 0) {
+			ath12k_err(ab, "failed to boot the remote processor Q6\n");
+			goto unreg_notifier;
+		}
+	}
+	return 0;
+
+unreg_notifier:
+	ath12k_ahb_unregister_rproc_notifier(ab);
+	return ret;
+}
+
 static int ath12k_ahb_clock_init(struct ath12k_base *ab)
 {
 	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
@@ -773,6 +891,7 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 	struct ath12k_base *ab;
 	const struct ath12k_hif_ops *hif_ops;
 	struct device_node *mem_node;
+	struct ath12k_ahb *ab_ahb;
 	enum ath12k_hw_rev hw_rev;
 	u32 addr;
 	int ret;
@@ -804,6 +923,8 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 	ab->pdev = pdev;
 	ab->hw_rev = hw_rev;
 	platform_set_drvdata(pdev, ab);
+	ab_ahb = ath12k_ab_to_ahb(ab);
+	ab_ahb->ab = ab;
 
 	/* Set fixed_mem_region to true for platforms that support fixed memory
 	 * reservation from DT. If memory is reserved from DT for FW, ath12k driver
@@ -836,6 +957,12 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 
 	ath12k_ahb_init_qmi_ce_config(ab);
 
+	ret = ath12k_ahb_configure_rproc(ab);
+	if (ret) {
+		ath12k_err(ab, "failed to configure rproc: %d\n", ret);
+		goto err_ce_free;
+	}
+
 	ret = ath12k_ahb_config_irq(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to configure irq: %d\n", ret);
@@ -880,6 +1007,7 @@ static void ath12k_ahb_remove_prepare(struct ath12k_base *ab)
 	set_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags);
 	cancel_work_sync(&ab->restart_work);
 	cancel_work_sync(&ab->qmi.event_work);
+	ath12k_ahb_unregister_rproc_notifier(ab);
 }
 
 static void ath12k_ahb_free_resources(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index bd0366a79587..d1fc63091fb0 100644
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


