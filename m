Return-Path: <linux-wireless+bounces-23334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA6FAC1A06
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 04:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B8F9E44BD
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 02:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A972F1DF754;
	Fri, 23 May 2025 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K0X98Ydg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D051684AE;
	Fri, 23 May 2025 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747967029; cv=none; b=E+Pt4cu+rMziZa+2612UaND833rB4naqyBDyGcBuYnXfTZwBODTltEGsi9wdwz/zsDV3JjMO3JSdO++SJJ2oUk+NjgBUUApmcmUkNgcZ/LKQ2IeQrkuSSTzXozvrDiiESD8j7wvtkDQbVruhla3jjI0SftlB6wO5jMNYvrC8fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747967029; c=relaxed/simple;
	bh=Rgr8NCRmE3Jueb7ajS1oFMH7dV8ETtQ40tJClbz/pQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=a+0uyl3EHeEq6rD0/hSe2yje2dZDwdt/UzYWFJEBgcAWiqwnWxjXpUMe8UPnYQ/ycC4P0wGmIIsFVFvkMEMEFXD42ZQIRjeZ8Gks64UYeEXLpQ7NB6FSE5orhtfzDwiTZjddrb/zdTLhzOc8DD3OnxhCZmk/wOEbb0yypWybj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K0X98Ydg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MFjkWi006644;
	Fri, 23 May 2025 02:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Qm/zpUE17rTqamHO4SZcJ5
	Lmb1rLzay2FNmK5jqLorc=; b=K0X98YdgG1/vOH0ZzsNivGpAuOIyBe5XNJ9ueX
	dS39vMV4rS6qd7zLPlaHi69SSrPG/HtUwWVt02R2cQPh1JjWWZK0FTFI0RwK09zv
	jOU2xl2+Jim5LB2QcyY53ADooVS2Gw6t6BMLyznC8nVaRWY869ySMICGjU462jkF
	1U+FSy2V9uVTf0ngR7H6U0L0Xftr4VbgNfHSjIZHeuvdm/ANJk9gN6wurL0INZSl
	MnLOtdOHgaPOxf2CeAiEAO0PWajH9tF0qipQ808AGx34rVLjWbhvRCuUJ/spzCDs
	lNMWbvDzSNllqlgp9GruH/vm7ug6FuLx6yjEGt6kSZ9EwBEQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf0rf17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 02:23:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54N2Nfpx027952
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 02:23:41 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 19:23:38 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 23 May 2025 10:23:05 +0800
Subject: [PATCH ath-next] wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST definition
 for WCN7850
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250523-ath12k-wrong-global-reset-addr-v1-1-3b06eb556196@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAjcL2gC/43NzQ7CIBAE4FdpOLsGUPrjyfcwHii7bYkKCrXWN
 H13sSc96XEymW8mFilYimyXTSzQYKP1LgWxypjptGsJLKbMJJeKK56D7jshT/AI3rXQnn2tzxA
 oUg8aMUBdKESTU1EqzhJyDdTYcTk4sLQFR2PPjqnpbOx9eC7Pg1j6f08GAQIUaV2XBSGi3N/u1
 lhn1sZfFnyQH6CofoLyDVaaN7XBakubb3Ce5xcaWwZqKQEAAA==
X-Change-ID: 20250506-ath12k-wrong-global-reset-addr-b75ddc6e7850
To: Jeff Johnson <jjohnson@kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        "Vasanthakumar Thiagarajan" <quic_vthiagar@quicinc.com>,
        Bhagavathi Perumal S
	<quic_bperumal@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
CC: Sriram R <quic_srirrama@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Parth Panchoil
	<parth105105@gmail.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FafOzhXsl19cEKoVXck6HQSpZUDIBrgb
X-Authority-Analysis: v=2.4 cv=J/Sq7BnS c=1 sm=1 tr=0 ts=682fdc2d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=C5NdG746629Tomd590AA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: FafOzhXsl19cEKoVXck6HQSpZUDIBrgb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDAyMCBTYWx0ZWRfX5fk2eVBKVSAF
 8kqriWm0Os1kST5k02lw1RVHoXeUdHYHYwc3GwGmAXJpq205ad55DbAb4e2iP3lTbL8MnbCRu0Q
 D8sxrQ/bZGDJIFmkb7BmJB8pcv4JBzVOvsaNf8+RclBVwp60wR7qaVe0XgIa+CNN4WqKjVl+82A
 e9XRfyg7Jq2URKzIF1KojhoJTcJGiwyw3XJb2V5T4gvtIsW6+8CY9FRT5nCovzZhUNazfH9zrnh
 WcXjZOgqk4xns+Hn5nJsyswTdnFhqFPlikRcEWYJJtLRT4uJuvZsSQZ6KZZsQA5niM2XcphAheh
 wlJVyLDt1zOWwI3DXgRNkAR7c+wOR6IinDsnDZkriNp51xszRMoo85Xs4+cIjtvb5vC4LhvfBP5
 UQMxALY6MSpfGYy9VoCUOOzmQzSXgVrqf/px2u9CRRvDePkjpzULylr/1ZJCMe8Um38yWFGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_01,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 mlxlogscore=695 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505230020

GCC_GCC_PCIE_HOT_RST is wrongly defined for WCN7850, causing kernel crash
on some specific platforms.

Since this register is divergent for WCN7850 and QCN9274, move it to
register table to allow different definitions. Then correct the register
address for WCN7850 to fix this issue.

Note IPQ5332 is not affected as it is not PCIe based device.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Reported-by: Parth Panchoil <parth105105@gmail.com>
Closes: https://lore.kernel.org/all/86899b2235a59c9134603beebe08f2bb0b244ea0.camel@gmail.com
Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
---
 drivers/net/wireless/ath/ath12k/hw.c  | 6 ++++++
 drivers/net/wireless/ath/ath12k/hw.h  | 2 ++
 drivers/net/wireless/ath/ath12k/pci.c | 6 +++---
 drivers/net/wireless/ath/ath12k/pci.h | 4 +++-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 7e2cf0fb2085ab014fc14a5c81074802674b154e..8254dc10b53bbfb54a44c7ff2f705c72461d1031 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -951,6 +951,8 @@ static const struct ath12k_hw_regs qcn9274_v1_regs = {
 	.hal_umac_ce0_dest_reg_base = 0x01b81000,
 	.hal_umac_ce1_src_reg_base = 0x01b82000,
 	.hal_umac_ce1_dest_reg_base = 0x01b83000,
+
+	.gcc_gcc_pcie_hot_rst = 0x1e38338,
 };
 
 static const struct ath12k_hw_regs qcn9274_v2_regs = {
@@ -1042,6 +1044,8 @@ static const struct ath12k_hw_regs qcn9274_v2_regs = {
 	.hal_umac_ce0_dest_reg_base = 0x01b81000,
 	.hal_umac_ce1_src_reg_base = 0x01b82000,
 	.hal_umac_ce1_dest_reg_base = 0x01b83000,
+
+	.gcc_gcc_pcie_hot_rst = 0x1e38338,
 };
 
 static const struct ath12k_hw_regs ipq5332_regs = {
@@ -1215,6 +1219,8 @@ static const struct ath12k_hw_regs wcn7850_regs = {
 	.hal_umac_ce0_dest_reg_base = 0x01b81000,
 	.hal_umac_ce1_src_reg_base = 0x01b82000,
 	.hal_umac_ce1_dest_reg_base = 0x01b83000,
+
+	.gcc_gcc_pcie_hot_rst = 0x1e40304,
 };
 
 static const struct ath12k_hw_hal_params ath12k_hw_hal_params_qcn9274 = {
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 0fbc17649df463334aa0ebb3da407115985335ca..0a75bc5abfa2410ab3c7b6ce038f4d5f6445ecf9 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -375,6 +375,8 @@ struct ath12k_hw_regs {
 	u32 hal_reo_cmd_ring_base;
 
 	u32 hal_reo_status_ring_base;
+
+	u32 gcc_gcc_pcie_hot_rst;
 };
 
 static inline const char *ath12k_bd_ie_type_str(enum ath12k_bd_ie_type type)
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 489d546390fcdab8f615cc9184006a958d9f140a..1f3cfd9b89fdcfd84731ec90c9c678b0c477a2af 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -292,10 +292,10 @@ static void ath12k_pci_enable_ltssm(struct ath12k_base *ab)
 
 	ath12k_dbg(ab, ATH12K_DBG_PCI, "pci ltssm 0x%x\n", val);
 
-	val = ath12k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST);
+	val = ath12k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST(ab));
 	val |= GCC_GCC_PCIE_HOT_RST_VAL;
-	ath12k_pci_write32(ab, GCC_GCC_PCIE_HOT_RST, val);
-	val = ath12k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST);
+	ath12k_pci_write32(ab, GCC_GCC_PCIE_HOT_RST(ab), val);
+	val = ath12k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST(ab));
 
 	ath12k_dbg(ab, ATH12K_DBG_PCI, "pci pcie_hot_rst 0x%x\n", val);
 
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 0b4c459d6d8eabb0773162e6bb3ca666c0a8f15a..d1ec8aad7f6c3b6f5cbdf8ce57a4106733686521 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -28,7 +28,9 @@
 #define PCIE_PCIE_PARF_LTSSM			0x1e081b0
 #define PARM_LTSSM_VALUE			0x111
 
-#define GCC_GCC_PCIE_HOT_RST			0x1e38338
+#define GCC_GCC_PCIE_HOT_RST(ab) \
+	((ab)->hw_params->regs->gcc_gcc_pcie_hot_rst)
+
 #define GCC_GCC_PCIE_HOT_RST_VAL		0x10
 
 #define PCIE_PCIE_INT_ALL_CLEAR			0x1e08228

---
base-commit: 3d933084a072fd5fb5da54c06a017abc0412c86f
change-id: 20250506-ath12k-wrong-global-reset-addr-b75ddc6e7850

Best regards,
-- 
Baochen Qiang <quic_bqiang@quicinc.com>


