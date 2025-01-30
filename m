Return-Path: <linux-wireless+bounces-18196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9CCA2287A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 06:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BEB166AA0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 05:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD21865FA;
	Thu, 30 Jan 2025 05:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UxMfTjzb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0D154BFE;
	Thu, 30 Jan 2025 05:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738214398; cv=none; b=L2GgzeMVUpCC8R2Yd6dhhyNRCeEUJHWcIHje3G5W0lwlhyvhcnaPV+ztOxqVdr33WQr85Rlg2n5Xl8E52KanKNlarF2AKqed3k1Ce52aHFqYjU/FZiYZu3NAOL+QpO4WrFpWeJSAgf37NI/DXYFpmfDlg4Oaixxc+fTk1KX/mIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738214398; c=relaxed/simple;
	bh=iASeqjJsAnlFb+Z/MW7NADrnwsZt3hjo1ZbxDDj1Rg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssnbZBJ1eLwFkHgie9OqF6/Tkt7LgthGu1urZ0QtK0osAsmTG6Pj8MZzVCI1wa3sDyKaXPaXCRIKIhYpY62LDdrVTkDQwZ+mnCfNG4HlImrFjVO45C9oIDgsybxm5TAyUCf3VfiOuQL2rIcx94YkLSiExsTH+Oh+duHb9btbDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UxMfTjzb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TLlfpA030164;
	Thu, 30 Jan 2025 05:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hQW/uwSsCdNcJYbKXhDgIauPl8mwC5rmI2zt4OYJh+w=; b=UxMfTjzbrkK916Bp
	Ejy93jSBxdNgKg/EUbaiZKPs7dOqRpfbU/41B0Lljd+wCLatnCty7QaaanWgGd4R
	gfWgISVlC0qBU3IVCjx7jdB7ua1ed5ScAVnsP7zvlT5bk9nplqihikIfGjMiypky
	i0mWUUp9YhPnlCQ3ON2Ed732uM8u6DOvzbAVRMx3udJWCTT7EmUVk0wY8xtHbi9L
	ot+PMTThl4Q3yLUVya+A0j8tzJbwVVl9A2Z0ssbrHlV4WgP8bl+KqQbPAngLCZ0C
	1MugmOPSL9Q8MP64+XVlZmpMAdzopfNGPfdnzFZU3pHQEu5dZSDA0/MLpfIIeLrn
	DtjDwg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fvjcgnn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 05:19:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U5JoO1001618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 05:19:50 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 21:19:46 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Sowmiya Sree
 Elavalagan" <quic_ssreeela@quicinc.com>,
        Saravanakumar Duraisamy
	<quic_saradura@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 5/5] wifi: ath12k: Enable IPQ5424 WiFi device support
Date: Thu, 30 Jan 2025 10:48:38 +0530
Message-ID: <20250130051838.1924079-6-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130051838.1924079-1-quic_rajkbhag@quicinc.com>
References: <20250130051838.1924079-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ei1D-p9qtg0vRv9F5iXpZaVbq_t-k_9E
X-Proofpoint-GUID: ei1D-p9qtg0vRv9F5iXpZaVbq_t-k_9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300039

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
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 80 +++++++++++++++++----------
 drivers/net/wireless/ath/ath12k/ahb.h |  9 +++
 2 files changed, 61 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index d502b59a78d8..75767915dec3 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -21,6 +21,9 @@ static const struct of_device_id ath12k_ahb_of_match[] = {
 	{ .compatible = "qcom,ipq5332-wifi",
 	  .data = (void *)ATH12K_HW_IPQ5332_HW10,
 	},
+	{ .compatible = "qcom,ipq5424-wifi",
+	  .data = (void *)ATH12K_HW_IPQ5424_HW10,
+	},
 	{ }
 };
 
@@ -398,8 +401,8 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 		ATH12K_AHB_UPD_SWID;
 
 	/* Load FW image to a reserved memory location */
-	ret = qcom_mdt_load(dev, fw, fw_name, pasid, mem_region, mem_phys, mem_size,
-			    &mem_phys);
+	ret = ab_ahb->ahb_ops->mdt_load(dev, fw, fw_name, pasid, mem_region, mem_phys,
+					mem_size, &mem_phys);
 	if (ret) {
 		ath12k_err(ab, "Failed to load MDT segments: %d\n", ret);
 		goto err_fw;
@@ -430,11 +433,13 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 		goto err_fw2;
 	}
 
-	/* Authenticate FW image using peripheral ID */
-	ret = qcom_scm_pas_auth_and_reset(pasid);
-	if (ret) {
-		ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
-		goto err_fw2;
+	if (ab_ahb->scm_auth_enabled) {
+		/* Authenticate FW image using peripheral ID */
+		ret = qcom_scm_pas_auth_and_reset(pasid);
+		if (ret) {
+			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
+			goto err_fw2;
+		}
 	}
 
 	/* Instruct Q6 to spawn userPD thread */
@@ -491,13 +496,15 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
 
 	qcom_smem_state_update_bits(ab_ahb->stop_state, BIT(ab_ahb->stop_bit), 0);
 
-	pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
-		ATH12K_AHB_UPD_SWID;
-	/* Release the firmware */
-	ret = qcom_scm_pas_shutdown(pasid);
-	if (ret)
-		ath12k_err(ab, "scm pas shutdown failed for userPD%d: %d\n",
-			   ab_ahb->userpd_id, ret);
+	if (ab_ahb->scm_auth_enabled) {
+		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
+			 ATH12K_AHB_UPD_SWID;
+		/* Release the firmware */
+		ret = qcom_scm_pas_shutdown(pasid);
+		if (ret)
+			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
+				   ab_ahb->userpd_id);
+	}
 }
 
 static void ath12k_ahb_init_qmi_ce_config(struct ath12k_base *ab)
@@ -707,6 +714,14 @@ static int ath12k_ahb_map_service_to_pipe(struct ath12k_base *ab, u16 service_id
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
@@ -1041,19 +1056,9 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 	struct device_node *mem_node;
 	struct ath12k_ahb *ab_ahb;
 	enum ath12k_hw_rev hw_rev;
-	u32 addr, userpd_id;
+	u32 addr;
 	int ret;
 
-	hw_rev = ath12k_ahb_get_hw_rev(pdev);
-	switch (hw_rev) {
-	case ATH12K_HW_IPQ5332_HW10:
-		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
-		userpd_id = ATH12K_IPQ5332_USERPD_ID;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to set 32-bit coherent dma\n");
@@ -1067,13 +1072,32 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	ab_ahb = ath12k_ab_to_ahb(ab);
+	ab_ahb->ab = ab;
+
+	hw_rev = ath12k_ahb_get_hw_rev(pdev);
+	switch (hw_rev) {
+	case ATH12K_HW_IPQ5332_HW10:
+		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
+		ab_ahb->userpd_id = ATH12K_IPQ5332_USERPD_ID;
+		ab_ahb->scm_auth_enabled = true;
+		ab_ahb->ahb_ops = &ahb_ops_ipq5332;
+		break;
+	case ATH12K_HW_IPQ5424_HW10:
+		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
+		ab_ahb->userpd_id = ATH12K_IPQ5332_USERPD_ID;
+		ab_ahb->scm_auth_enabled = false;
+		ab_ahb->ahb_ops = &ahb_ops_ipq5424;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		goto err_core_free;
+	}
+
 	ab->hif.ops = hif_ops;
 	ab->pdev = pdev;
 	ab->hw_rev = hw_rev;
 	platform_set_drvdata(pdev, ab);
-	ab_ahb = ath12k_ab_to_ahb(ab);
-	ab_ahb->ab = ab;
-	ab_ahb->userpd_id = userpd_id;
 
 	/* Set fixed_mem_region to true for platforms that support fixed memory
 	 * reservation from DT. If memory is reserved from DT for FW, ath12k driver
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index d56244b20a6a..270d6db2a4a4 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.h
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -43,6 +43,13 @@ enum ath12k_ahb_userpd_irq {
 
 struct ath12k_base;
 
+struct ath12k_ahb_ops {
+	int (*mdt_load)(struct device *dev, const struct firmware *fw,
+			const char *firmware, int pas_id, void *mem_region,
+			phys_addr_t mem_phys, size_t mem_size,
+			phys_addr_t *reloc_base);
+};
+
 struct ath12k_ahb {
 	struct ath12k_base *ab;
 	struct rproc *tgt_rproc;
@@ -59,6 +66,8 @@ struct ath12k_ahb {
 	u32 spawn_bit;
 	u32 stop_bit;
 	int userpd_irq_num[ATH12K_USERPD_MAX_IRQ];
+	bool scm_auth_enabled;
+	const struct ath12k_ahb_ops *ahb_ops;
 };
 
 static inline struct ath12k_ahb *ath12k_ab_to_ahb(struct ath12k_base *ab)
-- 
2.34.1


