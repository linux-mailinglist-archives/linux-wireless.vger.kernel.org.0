Return-Path: <linux-wireless+bounces-14001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3079C99F58C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 20:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76BA283643
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E020101B;
	Tue, 15 Oct 2024 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CFdpbGUr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD500201019;
	Tue, 15 Oct 2024 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016937; cv=none; b=W2JmCi9oK4X0mE0Zgo5+79LTAfFhsHgejETs+sRk1fRIQDEn2tGLFM9FYjorZTK5Wb/CX47QIHdnguaB7LsJ72qRz58OOniPwgT9NWeLbYoIngRFtHE6bjzZ0xIxsb/bLQLwljoPAARQRwdfKSB57luNssCrvad4VH2aOJBnsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016937; c=relaxed/simple;
	bh=oYuUSE1EQSwWg/GXfeSxs5WYg2kQEWid+wI87nMC9PA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1AEyhbspZNoObVRq99xpfWVRNq8ap7lhzt+PBRg7REcjFLUeP39feeYmwbk8XT8G+AV3tIyKyfpcsnS9KnJ76pdjrROpG+MYFN01zWeOqDjQGa4CzlbqsONHoZe6EQQ0z4wZzvGjNmkTHe3T58isMoGBkfV0l/kXq3/ztptQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CFdpbGUr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FG0sfM022433;
	Tue, 15 Oct 2024 18:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nv4HMjXZSLasP8T8/RQ3OqhAsQ9LWW1TGKEvrZ0xt1c=; b=CFdpbGUrmYhuhEfG
	d02JyuRU1Y9amlW53fAJXO/HNg3/AElcq7WQei1/AWd16LBkdfNexKcXIw2BlkzJ
	bS9Le/1KrtuiegkWFiyIFrucy9OqQhwXoGYY3AjuLH3NggAROYgXz34te8+kxXkb
	VEJx4+cIcgkREcwm8vhj+D7CpanVGWFoPEFWIboMD/XDhKN0ew+U0tvktzJ/Eret
	duWYscVCysaMPjzP0S5jhZ2iUDE7XkKjdezd6jCN8eiQm26+exsNh9C3QllnLzST
	le4ida/kS2JkKFRGG+jAtVy/QvpTK4TyvUlTWSqBQmPPmRU25N5PFVukurNC2ods
	hSI2LQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429jrfa2yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FISn0l005337
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:49 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 11:28:44 -0700
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
Subject: [PATCH v2 20/22] wifi: ath12k: Power up userPD
Date: Tue, 15 Oct 2024 23:56:35 +0530
Message-ID: <20241015182637.955753-21-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: rdR24TffDNChIpZNCQXFX-sfbziDu5ec
X-Proofpoint-ORIG-GUID: rdR24TffDNChIpZNCQXFX-sfbziDu5ec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150125

From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

UserPD firmware image is loaded and booted by ath12k driver. Get the userPD
memory region from DTS and load the firmware for userPD from pre-defined
path into io-remapped address of this region. Authenticate this image
using pasid which is a peripheral ID. Set the spawn bit to instruct Q6
to spawn userPD thread. Wait for userPD to spawn which is indicated by
spawn interrupt. Ready interrupt is triggered once the userPD is powered
up completely.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 138 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/ahb.h |  10 +-
 2 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 7b898f01c255..fa3927295c4e 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -5,13 +5,17 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/firmware.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
+#include <linux/soc/qcom/mdt_loader.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
 #include "ahb.h"
@@ -357,6 +361,139 @@ static void ath12k_ahb_stop(struct ath12k_base *ab)
 	ath12k_ce_cleanup_pipes(ab);
 }
 
+static int ath12k_ahb_power_up(struct ath12k_base *ab)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+	u32 pasid;
+	char fw_name[ATH12K_USERPD_FW_NAME_LEN];
+	char fw2_name[ATH12K_USERPD_FW_NAME_LEN];
+	struct device *dev = ab->dev;
+	const struct firmware *fw, *fw2;
+	struct device_node *fw_mem_node;
+	struct reserved_mem *rmem = NULL;
+	unsigned long time_left;
+	phys_addr_t mem_phys;
+	void *mem_region;
+	size_t mem_size;
+	int ret;
+
+	fw_mem_node = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (fw_mem_node)
+		rmem = of_reserved_mem_lookup(fw_mem_node);
+
+	of_node_put(fw_mem_node);
+
+	if (!rmem) {
+		ath12k_err(ab, "Failed to acquire Q6 memory-region\n");
+		return -EINVAL;
+	}
+
+	mem_phys = rmem->base;
+	mem_size = rmem->size;
+	mem_region = (void *)devm_ioremap_wc(dev, mem_phys, mem_size);
+	if (!mem_region) {
+		ath12k_err(ab, "unable to map memory region: %pa+%pa\n",
+			   &rmem->base, &rmem->size);
+		return -ENOMEM;
+	}
+
+	snprintf(fw_name, sizeof(fw_name), "%s/%s/%s%d%s", ATH12K_FW_DIR,
+		 ab->hw_params->fw.dir, ATH12K_AHB_FW_PREFIX, ab_ahb->userpd_id,
+		 ATH12K_AHB_FW_SUFFIX);
+
+	ret = request_firmware(&fw, fw_name, dev);
+	if (ret < 0) {
+		ath12k_err(ab, "request_firmware failed\n");
+		return ret;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_AHB, "Booting fw image %s, size %zd\n", fw_name,
+		   fw->size);
+
+	if (!fw->size) {
+		ath12k_err(ab, "Invalid firmware size\n");
+		ret = -EINVAL;
+		goto err_fw;
+	}
+
+	pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
+		ATH12K_AHB_UPD_SWID;
+
+	/* Load FW image to a reserved memory location */
+	ret = qcom_mdt_load(dev, fw, fw_name, pasid, mem_region, mem_phys, mem_size,
+			    &mem_phys);
+	if (ret) {
+		ath12k_err(ab, "Failed to load MDT segments: %d\n", ret);
+		goto err_fw;
+	}
+
+	snprintf(fw2_name, sizeof(fw2_name), "%s/%s/%s", ATH12K_FW_DIR,
+		 ab->hw_params->fw.dir, ATH12K_AHB_FW2);
+
+	ret = request_firmware(&fw2, fw2_name, dev);
+	if (ret < 0) {
+		ath12k_err(ab, "request_firmware failed\n");
+		goto err_fw;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_AHB, "Booting fw image %s, size %zd\n", fw2_name,
+		   fw2->size);
+
+	if (!fw2->size) {
+		ath12k_err(ab, "Invalid firmware size\n");
+		ret = -EINVAL;
+		goto err_fw2;
+	}
+
+	ret = qcom_mdt_load_no_init(dev, fw2, fw2_name, pasid, mem_region, mem_phys,
+				    mem_size, &mem_phys);
+	if (ret) {
+		ath12k_err(ab, "Failed to load MDT segments: %d\n", ret);
+		goto err_fw2;
+	}
+
+	/* Authenticate FW image using peripheral ID */
+	ret = qcom_scm_pas_auth_and_reset(pasid);
+	if (ret) {
+		ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
+		goto err_fw2;
+	}
+
+	/* Instruct Q6 to spawn userPD thread */
+	ret = qcom_smem_state_update_bits(ab_ahb->spawn_state, BIT(ab_ahb->spawn_bit),
+					  BIT(ab_ahb->spawn_bit));
+	if (ret) {
+		ath12k_err(ab, "Failed to update spawn state %d\n", ret);
+		goto err_fw2;
+	}
+
+	time_left = wait_for_completion_timeout(&ab_ahb->userpd_spawned,
+						ATH12K_USERPD_SPAWN_TIMEOUT);
+	if (!time_left) {
+		ath12k_err(ab, "UserPD spawn wait timed out\n");
+		ret = -ETIMEDOUT;
+		goto err_fw2;
+	}
+
+	time_left = wait_for_completion_timeout(&ab_ahb->userpd_ready,
+						ATH12K_USERPD_READY_TIMEOUT);
+	if (!time_left) {
+		ath12k_err(ab, "UserPD ready wait timed out\n");
+		ret = -ETIMEDOUT;
+		goto err_fw2;
+	}
+
+	qcom_smem_state_update_bits(ab_ahb->spawn_state, BIT(ab_ahb->spawn_bit), 0);
+
+	ath12k_info(ab, "UserPD%d is now UP\n", ab_ahb->userpd_id);
+
+err_fw2:
+	release_firmware(fw2);
+err_fw:
+	release_firmware(fw);
+	return ret;
+}
+
 static void ath12k_ahb_init_qmi_ce_config(struct ath12k_base *ab)
 {
 	struct ath12k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
@@ -611,6 +748,7 @@ static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
 	.irq_enable = ath12k_ahb_ext_irq_enable,
 	.irq_disable = ath12k_ahb_ext_irq_disable,
 	.map_service_to_pipe = ath12k_ahb_map_service_to_pipe,
+	.power_up = ath12k_ahb_power_up,
 };
 
 static irqreturn_t ath12k_userpd_irq_handler(int irq, void *data)
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index 0999e2bbe970..0dbbbfd45eab 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.h
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -19,7 +19,15 @@
 #define ATH12K_PCI_IRQ_CE0_OFFSET		3
 #define ATH12K_ROOTPD_READY_TIMEOUT		(5 * HZ)
 #define ATH12K_RPROC_AFTER_POWERUP		QCOM_SSR_AFTER_POWERUP
-
+#define ATH12K_AHB_FW_PREFIX			"q6_fw"
+#define ATH12K_AHB_FW_SUFFIX			".mdt"
+#define ATH12K_AHB_FW2				"iu_fw.mdt"
+#define ATH12K_AHB_UPD_SWID			0x12
+#define ATH12K_USERPD_SPAWN_TIMEOUT		(5 * HZ)
+#define ATH12K_USERPD_READY_TIMEOUT		(10 * HZ)
+#define ATH12K_USERPD_STOP_TIMEOUT		(5 * HZ)
+#define ATH12K_USERPD_ID_MASK			GENMASK(9, 8)
+#define ATH12K_USERPD_FW_NAME_LEN		35
 enum ath12k_ahb_smp2p_msg_id {
 	ATH12K_AHB_POWER_SAVE_ENTER = 1,
 	ATH12K_AHB_POWER_SAVE_EXIT,
-- 
2.34.1


