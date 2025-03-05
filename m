Return-Path: <linux-wireless+bounces-19823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D93A50A86
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 19:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104273AABC2
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707682571A5;
	Wed,  5 Mar 2025 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bj6Tpsjj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E01253F07;
	Wed,  5 Mar 2025 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200978; cv=none; b=cY5soeaJRDmj8m/fG8w5EV9RBZrg9zPY0NyNKhcty14+yScSCM+pD71bb1s35639wMDHNWYNmpusZ7/Hw8HIyQ40J9YHeyZP8L63ww+6W8e0gnLRpO0g9z/A/zaSgY74s6Rblae5m11WFb2NU3ZX3riN/wMB2pxUfWMrzugZe7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200978; c=relaxed/simple;
	bh=7aJWQv15k9Ny2AV2XLhRvLqSnfH/XSqW4mQBoZVgDfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTabwC7Y5/sNJfNroph2H2mvVb8CI3nIYNnpD/ceY+1I+leV+L1LGS3f/lOaX6q85dj1ag2l+6rcNMsufU6ui9P+QbOEl0MNcE9Ku4GRTN7kYisU1AtSRvl8hxTiXEfoSdZbGDgEo4t6FVLovDRqb12PIb16LlukFq5B6S4TBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bj6Tpsjj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IUShS030823;
	Wed, 5 Mar 2025 18:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JzLJEJ5/4D5taHBhWMVYlLCGW98gosvYPwN3I05GWoI=; b=bj6TpsjjWVnXU9/0
	kkr+GgSdl8LxCjrTDOtfdYc7fUZasiPNFx3X/5ZzWe41Ml9mAtGylMQMW84bY0d8
	l/UDcQi/pWkIVN/Y9ALp8dY8tM62jds5sUgwAPPiCpaabPuq+wX19SMO6QHuIkYY
	7WycJlpum9Ix66gJbra/VFCfA6CLZ04mexAn/iudOBwMUqs8A3T/PvHdZ8rgrDTz
	uENAS8edR404TNPRVrlrFpLklb8LixyAUyfw7GlUDU4mfnYjiy6coja6Z+RgtqL1
	AQfFI8g0NIGbV1AGMTHuAs1RznMeucdVTbM8GNEZJApqSIIsTsfmSq3s8tOhfoXU
	e2OObw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 456uy082fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 18:56:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 525Iu7R7002375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 18:56:07 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Mar 2025 10:56:03 -0800
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
Subject: [PATCH ath-next v9 11/13] wifi: ath12k: Power up userPD
Date: Thu, 6 Mar 2025 00:24:59 +0530
Message-ID: <20250305185501.2400888-12-quic_rajkbhag@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=Pq5pbxM3 c=1 sm=1 tr=0 ts=67c89e47 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9KLz4mBoNmX795gwMUkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 4rTNudcykF5slTRsZt1ygfvnZgim8BnC
X-Proofpoint-GUID: 4rTNudcykF5slTRsZt1ygfvnZgim8BnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050145

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
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 128 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/ahb.h |   9 ++
 2 files changed, 137 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 291ae8177cdd..1ce08bad0646 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -5,10 +5,12 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
+#include <linux/soc/qcom/mdt_loader.h>
 #include <linux/soc/qcom/smem_state.h>
 #include "ahb.h"
 #include "debug.h"
@@ -336,6 +338,131 @@ static void ath12k_ahb_stop(struct ath12k_base *ab)
 	ath12k_ce_cleanup_pipes(ab);
 }
 
+static int ath12k_ahb_power_up(struct ath12k_base *ab)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+	char fw_name[ATH12K_USERPD_FW_NAME_LEN];
+	char fw2_name[ATH12K_USERPD_FW_NAME_LEN];
+	struct device *dev = ab->dev;
+	const struct firmware *fw, *fw2;
+	struct reserved_mem *rmem = NULL;
+	unsigned long time_left;
+	phys_addr_t mem_phys;
+	void *mem_region;
+	size_t mem_size;
+	u32 pasid;
+	int ret;
+
+	rmem = ath12k_core_get_reserved_mem(ab, 0);
+	if (!rmem)
+		return -ENODEV;
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
+	ath12k_dbg(ab, ATH12K_DBG_AHB, "UserPD%d is now UP\n", ab_ahb->userpd_id);
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
@@ -551,6 +678,7 @@ static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
 	.irq_enable = ath12k_ahb_ext_irq_enable,
 	.irq_disable = ath12k_ahb_ext_irq_disable,
 	.map_service_to_pipe = ath12k_ahb_map_service_to_pipe,
+	.power_up = ath12k_ahb_power_up,
 };
 
 static irqreturn_t ath12k_userpd_irq_handler(int irq, void *data)
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index b17e7693b31a..f8a5c43075c1 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.h
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -19,6 +19,15 @@
 #define ATH12K_PCI_IRQ_CE0_OFFSET		3
 #define ATH12K_ROOTPD_READY_TIMEOUT		(5 * HZ)
 #define ATH12K_RPROC_AFTER_POWERUP		QCOM_SSR_AFTER_POWERUP
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
-- 
2.34.1


