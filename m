Return-Path: <linux-wireless+bounces-16142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D119EA9E4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 08:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DDB285150
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 07:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10BA231CA4;
	Tue, 10 Dec 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eSGl10Nu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCF231C8F;
	Tue, 10 Dec 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816584; cv=none; b=mYxZS5jueA50Y4WPUOQtXdA7dM1ImXnr0eH4PfwlDRPmXvx0RClTqN3NkleQsF/GxAQhajjG/HCRZrYB31vhAQcZKBxRpZGQCakU80pc3J9pfgQ6WH6kL+hGqJFOojIaaXqlbfWpPsS3u0uujQmSUQ1Yd+SoHGlbicc5jTe5MrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816584; c=relaxed/simple;
	bh=WafydAqlUWvOFeXFz0RRx0mlsK6QIWkCE74JudVnGjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbnIUeQY4ymlKpmrYLYd+eSRyKwW1M/+Z1k+jdJpATHckgzx8AdEUwKOHbE+uOotRO9LCquhgjcj+s6Ny+W8WEdN0jQpVyYRbpFszQmbim2Lj0rUpbcl/0lLxJXCdJKBoiEIz3ZRg//MHEuK2MdHb/xESfKZcTp8NCPpIOfAq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eSGl10Nu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9I0Bgd003487;
	Tue, 10 Dec 2024 07:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dlgCgoFthfRrmavHzLstpwx+DhkGmsgc0ONflCN9zaE=; b=eSGl10NurgrIqQch
	1EBC2D5oUOGbGklfrUWWiwcOL65Hpbti6izUMscYEczRbnugRzRKqbDReWftCuZU
	uTZMdL90ZGsyXsa0Y7uxFGayGUxm2/VcxfNv31IU7DAf8VgGGTchd6TKOspJ7YIm
	J77RA4vsMPu8e+Uj7f0sFSiLwmGeZSup2Ka7YYNWatYFAaEJGVR9w7Kft8dK4FCY
	KX6BIwyShwrWUtB5NGVd65xdYAcoka8FnqY07oddh+oL5K1UnrtSov9tFLd1oyab
	BM5aF1cZBPXEZA3LhnTKhjnM3EikIkG5e96QqmbUF3hXVPsqk9/poleDJWFXIv4I
	8AVYBA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw439ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 07:42:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA7guu0004617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 07:42:56 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 23:42:52 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [PATCH v4 06/13] wifi: ath12k: Add hw_params to remap CE register space for IPQ5332
Date: Tue, 10 Dec 2024 13:11:52 +0530
Message-ID: <20241210074159.2637933-7-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210074159.2637933-1-quic_rajkbhag@quicinc.com>
References: <20241210074159.2637933-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: rI1wLvbn27n55LBhrKpXwY2scQK6oIjq
X-Proofpoint-GUID: rI1wLvbn27n55LBhrKpXwY2scQK6oIjq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100058

From: Balamurugan S <quic_bselvara@quicinc.com>

For IPQ5332 CE register space is moved out of WCSS region and the
space is not contiguous. Hence, add hardware params (ce_ie_addr &
ce_remap) for IPQ5332. These parameters would be used by Ath12k
AHB driver (in subsequent patches) to remap the CE registers to a
new space for accessing them.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ce.h   | 11 +++++++++
 drivers/net/wireless/ath/ath12k/core.h |  4 ++++
 drivers/net/wireless/ath/ath12k/hal.h  |  4 ++++
 drivers/net/wireless/ath/ath12k/hw.c   | 31 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/hw.h   |  2 ++
 5 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index 6b1a356f43be..75c9f8f1f7c6 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -76,6 +76,17 @@ struct ce_pipe_config {
 	__le32 reserved;
 };
 
+struct ce_ie_addr {
+	u32 ie1_reg_addr;
+	u32 ie2_reg_addr;
+	u32 ie3_reg_addr;
+};
+
+struct ce_remap {
+	u32 base;
+	u32 size;
+};
+
 struct ce_attr {
 	/* CE_ATTR_* values */
 	unsigned int flags;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 1737fb8f765d..e45ff85b675d 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -872,6 +872,10 @@ struct ath12k_base {
 	void __iomem *mem;
 	unsigned long mem_len;
 
+	void __iomem *mem_ce;
+	u32 ce_remap_base_addr;
+	bool ce_remap;
+
 	struct {
 		enum ath12k_bus bus;
 		const struct ath12k_hif_ops *ops;
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 69579f118b81..70dbd460dae3 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -11,6 +11,7 @@
 #include "rx_desc.h"
 
 struct ath12k_base;
+#define HAL_CE_REMAP_REG_BASE	(ab->ce_remap_base_addr)
 
 #define HAL_LINK_DESC_SIZE			(32 << 2)
 #define HAL_LINK_DESC_ALIGN			128
@@ -372,6 +373,9 @@ struct ath12k_base;
  * ath12k_hal_rx_desc_get_err().
  */
 
+#define HAL_IPQ5332_CE_WFSS_REG_BASE	0x740000
+#define HAL_IPQ5332_CE_SIZE		0x100000
+
 enum hal_srng_ring_id {
 	HAL_SRNG_RING_ID_REO2SW0 = 0,
 	HAL_SRNG_RING_ID_REO2SW1,
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index f7035669bc6f..494963b19fe9 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1106,10 +1106,14 @@ static const struct ath12k_hw_regs ipq5332_regs = {
 	.hal_ppe_rel_ring_base = 0x0000046c,
 
 	/* CE address */
-	.hal_umac_ce0_src_reg_base = 0x00740000,
-	.hal_umac_ce0_dest_reg_base = 0x00741000,
-	.hal_umac_ce1_src_reg_base = 0x00742000,
-	.hal_umac_ce1_dest_reg_base = 0x00743000,
+	.hal_umac_ce0_src_reg_base = 0x00740000 -
+		HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.hal_umac_ce0_dest_reg_base = 0x00741000 -
+		HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.hal_umac_ce1_src_reg_base = 0x00742000 -
+		HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.hal_umac_ce1_dest_reg_base = 0x00743000 -
+		HAL_IPQ5332_CE_WFSS_REG_BASE,
 };
 
 static const struct ath12k_hw_regs wcn7850_regs = {
@@ -1223,6 +1227,17 @@ static const struct ath12k_hw_hal_params ath12k_hw_hal_params_ipq5332 = {
 			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
 };
 
+static const struct ce_ie_addr ath12k_ce_ie_addr_ipq5332 = {
+	.ie1_reg_addr = CE_HOST_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie2_reg_addr = CE_HOST_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie3_reg_addr = CE_HOST_IE_3_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+};
+
+static const struct ce_remap ath12k_ce_remap_ipq5332 = {
+	.base = HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.size = HAL_IPQ5332_CE_SIZE,
+};
+
 static const struct ath12k_hw_params ath12k_hw_params[] = {
 	{
 		.name = "qcn9274 hw1.0",
@@ -1301,6 +1316,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_aspm = false,
 
 		.needs_m3_fw = true,
+		.ce_ie_addr = NULL,
+		.ce_remap = NULL,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1383,6 +1400,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_aspm = true,
 
 		.needs_m3_fw = true,
+		.ce_ie_addr = NULL,
+		.ce_remap = NULL,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1461,6 +1480,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_aspm = false,
 
 		.needs_m3_fw = true,
+		.ce_ie_addr = NULL,
+		.ce_remap = NULL,
 	},
 	{
 		.name = "ipq5332 hw1.0",
@@ -1534,6 +1555,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_aspm = false,
 
 		.needs_m3_fw = false,
+		.ce_ie_addr = &ath12k_ce_ie_addr_ipq5332,
+		.ce_remap = &ath12k_ce_remap_ipq5332,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 241aa83ddbdd..ee37e50476a4 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -222,6 +222,8 @@ struct ath12k_hw_params {
 	u32 iova_mask;
 
 	bool needs_m3_fw;
+	const struct ce_ie_addr *ce_ie_addr;
+	const struct ce_remap *ce_remap;
 };
 
 struct ath12k_hw_ops {
-- 
2.34.1


