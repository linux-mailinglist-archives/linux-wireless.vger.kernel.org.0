Return-Path: <linux-wireless+bounces-23131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D944ABB142
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 20:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A573B5694
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FF521D5B0;
	Sun, 18 May 2025 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OeNxmXGH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B11FAC23;
	Sun, 18 May 2025 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747592608; cv=none; b=LDrk6ebc4UeQ1z2vtFDHlLgLbpE5i4Jugrb9tMOjkmXL6RBtAsymeFRod82onyTa+7tN4afjZkTiC0TKx284tUapLKSxsNCh7xElnGVF9/PJEbu/HZZLuFkrC0Ikc1FELyNKsQ49AU4oyXLRA/ZgCJJbf7oBtjG44vkralqOEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747592608; c=relaxed/simple;
	bh=MsNdBs/3Q+jNyguJm1dlmEu6PKBSuhmq477YGcPot58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZbxA0RIScrF3oVAe2jXzyfXO6KXkPHyPDBfwcxAiA6WMAKZS72goQvBDQb3EojBMal6SpztOd5fDnhSCFUr36FYFyyhYxYgSEUpkJhskvldsOLaYDUy191FOfCI/ylTJldJueVX1A29RkM4ZigbF+Acy5XoFPeTLNhayH7ugojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OeNxmXGH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54IIA2Re029077;
	Sun, 18 May 2025 18:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I/4l9n3MNcIl9r+2nFmOXILpdKv0avHCmu00r9eveT8=; b=OeNxmXGHCMGLx4e2
	ZMGj8QXAuPMLgL83O1mMaNmF4f1TigqHnZCULN0YJY5oYPWbiaioFGEyZxB0vACS
	znKZR12UFIZyCVbtKGXMD+skESK+GKh9aCJ70XxLpqUnBYA+ECFON28rTlc3dFLR
	BTig8eGBM04JYTlcE2L0VdnMCctA83FU1m7bOqZ1FmtWt3EdezV/bxkOH/mofp1B
	yj5O68W9rpsbnCN+rj9mnBokewl8z8W25jcRmWR0ldwHCQusD2gzdgqQFh3Z6oQU
	z4CTNb6vK683pSCvYHCevejrY4HsxunZCwnQyi7yJrt+5l+Xf3gbBzxapKpmHdhe
	csUgog==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pk7g28tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 18:23:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54IINCXa002342
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 18:23:12 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 18 May 2025 11:23:08 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Sun, 18 May 2025 23:52:32 +0530
Subject: [PATCH ath-next v2 5/5] wifi: ath12k: Enable IPQ5424 WiFi device
 support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250518-ath12k-ipq5424-v2-5-ef81b833dc97@quicinc.com>
References: <20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com>
In-Reply-To: <20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Sowmiya Sree
 Elavalagan" <quic_ssreeela@quicinc.com>,
        Saravanakumar Duraisamy
	<quic_saradura@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1RkriNYIfdnlOrwHiHVZOOulIyXdZe_q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDE3OSBTYWx0ZWRfX9sXBlJeq4YNF
 MVpj/HA17h9QTlSFeCmXMIuS6oAQ6oGcPJefa2jfokqpAWPmzplhV0yRrwDvgy6OUb9M4X6JUqH
 tl2ZdfBRtfPybyV2L9l/Wzfe5i40ooE9vS/mK0Ekjt6jEI26Ex4XNggJjXo5dez6jYoNHffgAKw
 NKn8Pm+OcKd+KhMHY0gNy/6K8PmU9BRLQKNnwFeqBZVLT6Ys+No0p0gp9uV7qt+e0xaIEYv+uDP
 qjbrBIL17gE007UHnzthKNu+G0wTfSrkT1mTxDBMlVHsho+uca83dEo0zTjqZH2fmB6RLp361SS
 QvWwPHHdFZcJdDfu9Q6Pb8z15LGSZtz/F/uQpSQGakkyhFOXFz7b80VhgsT1zBvuJ4DLhA6Y8mj
 3sjuCq40/YHgHmSL0TJVlRIVOCp8MU8NcGhINBoKKTtgYe2LRq/ajP7/td5ai6Fxzqg6bT3a
X-Authority-Analysis: v=2.4 cv=CKkqXQrD c=1 sm=1 tr=0 ts=682a2590 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=-7epug4WMcN2zn_RaXQA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1RkriNYIfdnlOrwHiHVZOOulIyXdZe_q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_09,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505180179

From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

Currently, ath12k AHB (in IPQ5332) uses SCM calls to authenticate the
firmware image to bring up userpd. From IPQ5424 onwards, Q6 firmware can
directly communicate with the Trusted Management Engine - Lite (TME-L),
eliminating the need for SCM calls for userpd bring-up.

Hence, to enable IPQ5424 device support, use qcom_mdt_load_no_init() and
skip the SCM call as Q6 will directly authenticate the userpd firmware.

Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.5-01053-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Co-developed-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 114 +++++++++++++++++++++-------------
 drivers/net/wireless/ath/ath12k/ahb.h |  17 ++++-
 2 files changed, 86 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 40690cef7e57d121c6c41765048d8e64c9320b02..f5a2c176d03d6eebb119165a7fa1a394cf3ef3b2 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -16,15 +16,6 @@
 #include "debug.h"
 #include "hif.h"
 
-static const struct of_device_id ath12k_ahb_of_match[] = {
-	{ .compatible = "qcom,ipq5332-wifi",
-	  .data = (void *)ATH12K_HW_IPQ5332_HW10,
-	},
-	{ }
-};
-
-MODULE_DEVICE_TABLE(of, ath12k_ahb_of_match);
-
 #define ATH12K_IRQ_CE0_OFFSET 4
 #define ATH12K_MAX_UPDS 1
 #define ATH12K_UPD_IRQ_WRD_LEN  18
@@ -348,9 +339,9 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 	struct reserved_mem *rmem = NULL;
 	unsigned long time_left;
 	phys_addr_t mem_phys;
+	u32 pasid, userpd_id;
 	void *mem_region;
 	size_t mem_size;
-	u32 pasid;
 	int ret;
 
 	rmem = ath12k_core_get_reserved_mem(ab, 0);
@@ -366,8 +357,9 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 		return PTR_ERR(mem_region);
 	}
 
+	userpd_id = ab_ahb->ahb_data->userpd_id;
 	snprintf(fw_name, sizeof(fw_name), "%s/%s/%s%d%s", ATH12K_FW_DIR,
-		 ab->hw_params->fw.dir, ATH12K_AHB_FW_PREFIX, ab_ahb->userpd_id,
+		 ab->hw_params->fw.dir, ATH12K_AHB_FW_PREFIX, userpd_id,
 		 ATH12K_AHB_FW_SUFFIX);
 
 	ret = request_firmware(&fw, fw_name, dev);
@@ -385,12 +377,12 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 		goto err_fw;
 	}
 
-	pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
+	pasid = (u32_encode_bits(userpd_id, ATH12K_USERPD_ID_MASK)) |
 		ATH12K_AHB_UPD_SWID;
 
 	/* Load FW image to a reserved memory location */
-	ret = qcom_mdt_load(dev, fw, fw_name, pasid, mem_region, mem_phys, mem_size,
-			    &mem_phys);
+	ret = ab_ahb->ahb_data->ahb_ops->mdt_load(dev, fw, fw_name, pasid, mem_region,
+						  mem_phys, mem_size, &mem_phys);
 	if (ret) {
 		ath12k_err(ab, "Failed to load MDT segments: %d\n", ret);
 		goto err_fw;
@@ -421,11 +413,13 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 		goto err_fw2;
 	}
 
-	/* Authenticate FW image using peripheral ID */
-	ret = qcom_scm_pas_auth_and_reset(pasid);
-	if (ret) {
-		ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
-		goto err_fw2;
+	if (ab_ahb->ahb_data->scm_auth_enabled) {
+		/* Authenticate FW image using peripheral ID */
+		ret = qcom_scm_pas_auth_and_reset(pasid);
+		if (ret) {
+			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
+			goto err_fw2;
+		}
 	}
 
 	/* Instruct Q6 to spawn userPD thread */
@@ -454,7 +448,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 
 	qcom_smem_state_update_bits(ab_ahb->spawn_state, BIT(ab_ahb->spawn_bit), 0);
 
-	ath12k_dbg(ab, ATH12K_DBG_AHB, "UserPD%d is now UP\n", ab_ahb->userpd_id);
+	ath12k_dbg(ab, ATH12K_DBG_AHB, "UserPD%d is now UP\n", userpd_id);
 
 err_fw2:
 	release_firmware(fw2);
@@ -467,7 +461,7 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
 {
 	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
 	unsigned long time_left;
-	u32 pasid;
+	u32 pasid, userpd_id;
 	int ret;
 
 	qcom_smem_state_update_bits(ab_ahb->stop_state, BIT(ab_ahb->stop_bit),
@@ -482,13 +476,16 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
 
 	qcom_smem_state_update_bits(ab_ahb->stop_state, BIT(ab_ahb->stop_bit), 0);
 
-	pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
-		ATH12K_AHB_UPD_SWID;
-	/* Release the firmware */
-	ret = qcom_scm_pas_shutdown(pasid);
-	if (ret)
-		ath12k_err(ab, "scm pas shutdown failed for userPD%d: %d\n",
-			   ab_ahb->userpd_id, ret);
+	if (ab_ahb->ahb_data->scm_auth_enabled) {
+		userpd_id = ab_ahb->ahb_data->userpd_id;
+		pasid = (u32_encode_bits(userpd_id, ATH12K_USERPD_ID_MASK)) |
+			 ATH12K_AHB_UPD_SWID;
+		/* Release the firmware */
+		ret = qcom_scm_pas_shutdown(pasid);
+		if (ret)
+			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
+				   userpd_id);
+	}
 }
 
 static void ath12k_ahb_init_qmi_ce_config(struct ath12k_base *ab)
@@ -698,6 +695,14 @@ static int ath12k_ahb_map_service_to_pipe(struct ath12k_base *ab, u16 service_id
 	return 0;
 }
 
+static const struct ath12k_ahb_ops ahb_ops_ipq5332 = {
+	.mdt_load = qcom_mdt_load,
+};
+
+static const struct ath12k_ahb_ops ahb_ops_ipq5424 = {
+	.mdt_load = qcom_mdt_load_no_init,
+};
+
 static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
 	.start = ath12k_ahb_start,
 	.stop = ath12k_ahb_stop,
@@ -747,7 +752,7 @@ static int ath12k_ahb_config_rproc_irq(struct ath12k_base *ab)
 			return -ENOMEM;
 
 		scnprintf(upd_irq_name, ATH12K_UPD_IRQ_WRD_LEN, "UserPD%u-%s",
-			  ab_ahb->userpd_id, ath12k_userpd_irq[i]);
+			  ab_ahb->ahb_data->userpd_id, ath12k_userpd_irq[i]);
 		ret = devm_request_threaded_irq(&ab->pdev->dev, ab_ahb->userpd_irq_num[i],
 						NULL, ath12k_userpd_irq_handler,
 						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -991,10 +996,8 @@ static void ath12k_ahb_resource_deinit(struct ath12k_base *ab)
 static int ath12k_ahb_probe(struct platform_device *pdev)
 {
 	struct ath12k_base *ab;
-	const struct ath12k_hif_ops *hif_ops;
 	struct ath12k_ahb *ab_ahb;
-	enum ath12k_hw_rev hw_rev;
-	u32 addr, userpd_id;
+	u32 addr;
 	int ret;
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
@@ -1008,24 +1011,19 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 	if (!ab)
 		return -ENOMEM;
 
-	hw_rev = (enum ath12k_hw_rev)(kernel_ulong_t)of_device_get_match_data(&pdev->dev);
-	switch (hw_rev) {
-	case ATH12K_HW_IPQ5332_HW10:
-		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
-		userpd_id = ATH12K_IPQ5332_USERPD_ID;
-		break;
-	default:
+	ab_ahb = ath12k_ab_to_ahb(ab);
+	ab_ahb->ab = ab;
+	ab_ahb->ahb_data =
+		(struct ath12k_ahb_probe_data *)of_device_get_match_data(&pdev->dev);
+	if (!ab_ahb->ahb_data) {
 		ret = -EOPNOTSUPP;
 		goto err_core_free;
 	}
 
-	ab->hif.ops = hif_ops;
+	ab->hif.ops = ab_ahb->ahb_data->hif_ops;
+	ab->hw_rev = ab_ahb->ahb_data->hw_rev;
 	ab->pdev = pdev;
-	ab->hw_rev = hw_rev;
 	platform_set_drvdata(pdev, ab);
-	ab_ahb = ath12k_ab_to_ahb(ab);
-	ab_ahb->ab = ab;
-	ab_ahb->userpd_id = userpd_id;
 
 	/* Set fixed_mem_region to true for platforms that support fixed memory
 	 * reservation from DT. If memory is reserved from DT for FW, ath12k driver
@@ -1136,6 +1134,34 @@ static void ath12k_ahb_remove(struct platform_device *pdev)
 	ath12k_ahb_free_resources(ab);
 }
 
+static const struct ath12k_ahb_probe_data ath12k_ahb_ipq5332 = {
+	.hw_rev = ATH12K_HW_IPQ5332_HW10,
+	.userpd_id = ATH12K_IPQ5332_USERPD_ID,
+	.scm_auth_enabled = true,
+	.ahb_ops = &ahb_ops_ipq5332,
+	.hif_ops = &ath12k_ahb_hif_ops_ipq5332,
+};
+
+static const struct ath12k_ahb_probe_data ath12k_ahb_ipq5424 = {
+	.hw_rev = ATH12K_HW_IPQ5424_HW10,
+	.userpd_id = ATH12K_IPQ5332_USERPD_ID,
+	.scm_auth_enabled = false,
+	.ahb_ops = &ahb_ops_ipq5424,
+	.hif_ops = &ath12k_ahb_hif_ops_ipq5332,
+};
+
+static const struct of_device_id ath12k_ahb_of_match[] = {
+	{ .compatible = "qcom,ipq5332-wifi",
+	  .data = (void *)&ath12k_ahb_ipq5332,
+	},
+	{ .compatible = "qcom,ipq5424-wifi",
+	  .data = (void *)&ath12k_ahb_ipq5424,
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, ath12k_ahb_of_match);
+
 static struct platform_driver ath12k_ahb_driver = {
 	.driver         = {
 		.name   = "ath12k_ahb",
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index d56244b20a6a667cf3730dc1ce38a22b0e86ffca..84415008331a3d719573d4f88e1596f460b1522c 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.h
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -43,6 +43,21 @@ enum ath12k_ahb_userpd_irq {
 
 struct ath12k_base;
 
+struct ath12k_ahb_ops {
+	int (*mdt_load)(struct device *dev, const struct firmware *fw,
+			const char *firmware, int pas_id, void *mem_region,
+			phys_addr_t mem_phys, size_t mem_size,
+			phys_addr_t *reloc_base);
+};
+
+struct ath12k_ahb_probe_data {
+	enum ath12k_hw_rev hw_rev;
+	u32 userpd_id;
+	bool scm_auth_enabled;
+	const struct ath12k_ahb_ops *ahb_ops;
+	const struct ath12k_hif_ops *hif_ops;
+};
+
 struct ath12k_ahb {
 	struct ath12k_base *ab;
 	struct rproc *tgt_rproc;
@@ -55,10 +70,10 @@ struct ath12k_ahb {
 	struct completion userpd_spawned;
 	struct completion userpd_ready;
 	struct completion userpd_stopped;
-	u32 userpd_id;
 	u32 spawn_bit;
 	u32 stop_bit;
 	int userpd_irq_num[ATH12K_USERPD_MAX_IRQ];
+	const struct ath12k_ahb_probe_data *ahb_data;
 };
 
 static inline struct ath12k_ahb *ath12k_ab_to_ahb(struct ath12k_base *ab)

-- 
2.34.1


