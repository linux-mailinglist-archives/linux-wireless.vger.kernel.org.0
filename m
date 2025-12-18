Return-Path: <linux-wireless+bounces-29879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED015CCA045
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02C9A304AF50
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE172701C4;
	Thu, 18 Dec 2025 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="csMKhYk0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J/A+CtLQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1025270552
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022944; cv=none; b=fTSQPBFBx9EaHCIstv08l1k/0owUgytWSqiTQGrS/Hd9Soyz+bvC4uo2wZuZ20nrSKBNGdEJ2tUSXdt99qu8XMUHl+zXCXxytN+MwVIaKDlg4z8QlNeB6g+x/u7dLo5r1FLTYWyW2r7gwlS7dBY7emKvNh3aJyRtlU37d2nOBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022944; c=relaxed/simple;
	bh=6KzWa6R68qeoFG3faCDND3NNJffW01aKDfuhsmQc60U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nAPmEpEREi6OCe9B6bH24cioSJ0e7ut6KKPA64cIFh29FgbU6US5mny0Y0QwCP0f8VSxlNq8FARvtukWCVKeJGdKO128FRSmxnk3u+K0uxLxy8kMQF+LHlTUlLwMivGcy4oVfqWHx1p7qMCGskk5mgCFTPOrnWHUtlfQwQjk4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=csMKhYk0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J/A+CtLQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Yqem493212
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gRYX8YVK4IhobYJuFw94CAvEwbDe36ncjXdGfdxpUb0=; b=csMKhYk0+XhXmGhe
	DHBeZ7zGNIrJIyQY0n4qMyNUgxQlnjn8kI0lyQHZiChz9Mxr6dituKTDGnP0am+G
	rYZnj5HwmPi+cDm3E1TRSdKLD/cooGJrYRpsAFDow+Du0bODQn7bsZiIPVOKvWGv
	K+hUnZGPUds+B+6AxP5nECTop41WcvNGnoQs6JZPviLg399jOcnEWZqEroYap3pG
	9cIIgE56dlRkpzYLqV+GrC5/NxP8Gl9O/AlD//5PEX1Og8XNRfE58HN8imNqEQFk
	Or8E6RWNWM77Zo3Mg61t8OP8MNICgKH7uVD9UlTtw8tQmoEfV7DcprW11FrUqrnL
	YAEqDQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3n333r3d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a08cbeb87eso1781845ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022941; x=1766627741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRYX8YVK4IhobYJuFw94CAvEwbDe36ncjXdGfdxpUb0=;
        b=J/A+CtLQKRnpQ7Q+ZYy9K+xdrD10lYrOpUlNSvk0yI8tvGnwNHXLt34wTL5j144z1K
         jEBvnweqKIyyjIMpzAWSAMsBgtJIZmYSj5MXkZFG3v1avHwr4AAme5RKIwIP+Z5IYnEU
         PFiJRyosmccVuTNB/7vBxolvxHHlqWA7d7axq0OYFkVj6nji6buLSB28vaBTZigSy8jx
         v7s2nRb1vCywhZUDyAHkAWnhEQO/uvsQt2t+tvv0gn+me4B6N53njXq7r65tA0sIon8M
         vm70WuEAtuYf9+mSBvaEgrorWbGPHzzhIKwfI6+NQg1CVx2OYlx/BA7sg/ej1FIRaZ+l
         KFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022941; x=1766627741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gRYX8YVK4IhobYJuFw94CAvEwbDe36ncjXdGfdxpUb0=;
        b=nrnLtPYnefoO4dcmqOqPeV+qd85zRe+ld5ATsCj5LX2pR9cWow9LqCBrVSgT9ZPMDv
         67OmjhKfsr6DSzBh6LUgaJzLODYcaPH6tjOv/hRf2KtP4DmanpLYgf+HMZ6WjI3yoObF
         eXanf++jnV1CBFelc05xuw5zE2c8P7P7AaIqmtXVnehyUTm5584wLv4pxnqE8zHnYszr
         sluHXCRCCr6Hf6TgBaOObYfo7hu0o1Kj7JwyhrVGmNS8rDL2Ebn8dK6p2pP/AtZ26l0J
         5HDFBUuf8C7UvVgrPtXdzgAFNyIpXSPiAiEIyLrl10XK4EV/xv6oQddnlMM4aU0OqJWV
         qvqQ==
X-Gm-Message-State: AOJu0YyMsrm/6kP+oiyqqjq7wUBLrfOi9BY8O7ss+e5mKGtJDBMS0yIQ
	TA1mVJQI/r9EeZanOtBcii0NAIv98zxJUvzilr5Moi1tFYLJJkvcjvejJZ9ndzZVt0d6m+dZu8J
	jyAUUiIExinlGg6dsgn1RBNGDyum3buh4suWvwQRlwTSGY2IEeh/ufRcPTvAxPgu8LjfH/pYtF+
	NRLOnw
X-Gm-Gg: AY/fxX7yJdTd38EmVnAzpMEld9k97qQ8hEI67JhEsYDGSDAZ88xZLAHcyJdjvT22s6x
	Idl62956PEIEwOvN8YP2Ca/GBv0XMWDFM+82H/mTjomCxTTQJ9hqrmR/Ziqq2Ccc/gFV7ClTKnW
	NuG9eqTT44q7avlTh9maSrwcPclrTQCjjYKlGXp8dPqy2xBe/ETzt0CXOxJrQW41BGtCLo9yPhL
	K7kMRH96IboyQoFEVllsCUJrao7MfAmjXoSatt1Ey2F4O4BMOXrAxIzW9iINgkyWyV9HHAhe47d
	CFB4pNiS7FRmllGcBqSHfZdzeu21lqtF4AFMEGGgtJBywObrOTb2z2LQXOwG+6kLr20V2C2x3Ce
	DXoBuItCWaYDKqZaMX5vwEUGryDVhoQChC15+DPKtGd8a/rhmcRvn0q3ZJDX7at0=
X-Received: by 2002:a17:903:9ce:b0:2a0:8be7:e3d0 with SMTP id d9443c01a7336-2a08be7e921mr171448395ad.10.1766022940559;
        Wed, 17 Dec 2025 17:55:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZWWpOqXptoEU6HXFRxsWArqZch+yr3Q3+04pMRPU9jE2HV5wA7WbSCo+tFkBd61X569Iugg==
X-Received: by 2002:a17:903:9ce:b0:2a0:8be7:e3d0 with SMTP id d9443c01a7336-2a08be7e921mr171448215ad.10.1766022940082;
        Wed, 17 Dec 2025 17:55:40 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:39 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:32 +0800
Subject: [PATCH ath-next 18/19] wifi: ath12k: fix
 PCIE_LOCAL_REG_QRTR_NODE_ID definition for QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-18-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX1hszBDZQKsIr
 6j0/1bH0ecD/BHubZS/sxT6IKH0e6th4AuiDZwM8yRrr70aGEeGbazT3F1byVoSN2U6Rns995NS
 3arxwJpbSbsI6Sa8AsvFbWcApYIuJyKbZHCAKVwyfP6ziktuSU4srM639t09tqINKqlACFyFbPr
 5woZtqK1pj8hQGLYxYUM8wO29/5rYNATdfZwMyy1vOvrLYn9ld+Z7dl8oePLOD7CfA0gnUrSJND
 VaoxS/MEuWiEQYyI9RHB6JZTMqNea067GhMqBojWDtE/XO7zaQdFTG4jSSKl+VOyUDJhd9sCk9z
 SwdwSkxr9Cn/kPh/g4IqZlfGG+bZQMBBpQKsvwpCz3dC5RkX0nvnNdtB8fn1R5SVQtQmqnLm/Ke
 AcZXhN/1zuAXf+mFUfmZ02C/c3tcMQ==
X-Proofpoint-GUID: GSas0pgR9O0GkVsIAywqZnoe9NbSegNc
X-Proofpoint-ORIG-GUID: GSas0pgR9O0GkVsIAywqZnoe9NbSegNc
X-Authority-Analysis: v=2.4 cv=U82fzOru c=1 sm=1 tr=0 ts=69435f1d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YBsQQ0GhBToZ_qaIIOwA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

The definition of PCIE_LOCAL_REG_QRTR_NODE_ID in QCC2072 is
incorrect, which causes the QMI connection to fail when
ATH12K_FW_FEATURE_MULTI_QRTR_ID is enabled. To resolve this
issue, move it to the hardware register table.

Note IPQ5332 is not affected as it is not PCIe based device.

Tested-on: QCC2072 hw1.0 PCI CI_WLAN.COL.1.0-01668.1-QCACOLSWPL_V1_TO_SILICONZ-9

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.h               | 2 ++
 drivers/net/wireless/ath/ath12k/pci.c               | 6 +-----
 drivers/net/wireless/ath/ath12k/pci.h               | 5 +++++
 drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c | 2 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c | 4 ++++
 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c | 2 ++
 6 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 520587305dfa..43e3880f8257 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1201,6 +1201,8 @@ struct ath12k_hw_regs {
 	u32 reo_status_ring_base;
 
 	u32 gcc_gcc_pcie_hot_rst;
+
+	u32 qrtr_node_id;
 };
 
 /* HAL context to be used to access SRNG APIs (currently used by data path
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 4bc30d86c1a7..fb597f063614 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -34,10 +34,6 @@
  */
 #define ACCESS_ALWAYS_OFF 0xFE0
 
-#define PCIE_LOCAL_REG_QRTR_NODE_ID	0x1E03164
-#define DOMAIN_NUMBER_MASK		GENMASK(7, 4)
-#define BUS_NUMBER_MASK			GENMASK(3, 0)
-
 static struct ath12k_pci_driver *ath12k_pci_family_drivers[ATH12K_DEVICE_FAMILY_MAX];
 static const struct ath12k_msi_config msi_config_one_msi = {
 	.total_vectors = 1,
@@ -918,7 +914,7 @@ static void ath12k_pci_update_qrtr_node_id(struct ath12k_base *ab)
 	 * writes to the given register, it is available for firmware when the QMI service
 	 * is spawned.
 	 */
-	reg = PCIE_LOCAL_REG_QRTR_NODE_ID & WINDOW_RANGE_MASK;
+	reg = PCIE_LOCAL_REG_QRTR_NODE_ID(ab) & WINDOW_RANGE_MASK;
 	ath12k_pci_write32(ab, reg, ab_pci->qmi_instance);
 
 	ath12k_dbg(ab, ATH12K_DBG_PCI, "pci reg 0x%x instance 0x%x read val 0x%x\n",
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index a74b09d23a6a..0e0e2020c6ae 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -59,6 +59,11 @@
 #define QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB	0x1E20338
 #define OTP_BOARD_ID_MASK			GENMASK(15, 0)
 
+#define PCIE_LOCAL_REG_QRTR_NODE_ID(ab) \
+	((ab)->hal.regs->qrtr_node_id)
+#define DOMAIN_NUMBER_MASK			GENMASK(7, 4)
+#define BUS_NUMBER_MASK				GENMASK(3, 0)
+
 #define PCI_BAR_WINDOW0_BASE	0x1E00000
 #define PCI_BAR_WINDOW0_END	0x1E7FFFC
 #define PCI_SOC_RANGE_MASK	0x3FFF
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
index ee2427fadfc1..1eefb931a853 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
@@ -92,6 +92,8 @@ const struct ath12k_hw_regs qcc2072_regs = {
 	.umac_ce1_dest_reg_base = 0x01b83000,
 
 	.gcc_gcc_pcie_hot_rst = 0x1e65304,
+
+	.qrtr_node_id = 0x1e03300,
 };
 
 static void ath12k_hal_rx_desc_set_msdu_len_qcc2072(struct hal_rx_desc *desc, u16 len)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 95850e6dc6c7..41c918eb1767 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -297,6 +297,8 @@ const struct ath12k_hw_regs qcn9274_v1_regs = {
 	.umac_ce1_dest_reg_base = 0x01b83000,
 
 	.gcc_gcc_pcie_hot_rst = 0x1e38338,
+
+	.qrtr_node_id = 0x1e03164,
 };
 
 const struct ath12k_hw_regs qcn9274_v2_regs = {
@@ -390,6 +392,8 @@ const struct ath12k_hw_regs qcn9274_v2_regs = {
 	.umac_ce1_dest_reg_base = 0x01b83000,
 
 	.gcc_gcc_pcie_hot_rst = 0x1e38338,
+
+	.qrtr_node_id = 0x1e03164,
 };
 
 const struct ath12k_hw_regs ipq5332_regs = {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 88f51a3828aa..e64e512cac7d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -256,6 +256,8 @@ const struct ath12k_hw_regs wcn7850_regs = {
 	.umac_ce1_dest_reg_base = 0x01b83000,
 
 	.gcc_gcc_pcie_hot_rst = 0x1e40304,
+
+	.qrtr_node_id = 0x1e03164,
 };
 
 static inline

-- 
2.25.1


