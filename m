Return-Path: <linux-wireless+bounces-26339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145EB22EB8
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0CF5630D0
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB77021D596;
	Tue, 12 Aug 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vk0QoXdf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670C22FE584
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018777; cv=none; b=e3RYLD0rUf2yV5C9g9pjykaNcmy1gun3bGalhp5RlY+0Qj3gYss9ZzhjnTkWQBOst7ENzTg4X5464E/TjezpcfdZuI8e0ECNoIvSLFHl1MSbxUUoe0cvDFNkiKmF1uCzjvQx0b8tWdkIgtgC1vTez8eAjEdeQ6UGS2VPAyBb+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018777; c=relaxed/simple;
	bh=Fv4xRqvIkYXFRIgJ3SsnqjrtxSER/hgpZyjDUitVez0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=A4i3qYiycR5jFqUxbUxQBzmvLJ/JA5TNCzxFBf00VnGv5xNkRLesxODb5XNuvP1BgOH6UggYfkAM7p4RqqFHp4EAx5wUY/VO+nRyM4+LV/Ix94Ctk/rHmluVWK75lpHjYpv+LFdY76O9+EUVIlld5zbYVv5UHTavVY42ASGjwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vk0QoXdf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CH6eri011485;
	Tue, 12 Aug 2025 17:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TFw2Lff6Tq2J7srX4n7Fk4zpUfnygl/Mr+Iyqr9K5Jw=; b=Vk0QoXdfN4q9Fy1B
	lcPVacl6lJ//HTtf5Hs4WhZVbcEUu4+elLQ4uIgVxFEJjyoX2ULAy9E2ufDSRzo7
	yqBEGaMWX/tGmIGh44QpZvqiemceaoswtQc2rid/963ndA2I/UjGM15EelTav9u/
	0RnMkUOGB0bxpaGRNqljY5Q1BqutzvphVx3XcOSMkIzjqba+IlO3oIKLSkRfkQb9
	1grzC3QU9wVvt+O7G3fpNWighEPefKUmixGEfBlT1RY6DkZfUUChh1vaev76vcXz
	YCzkUAnYi3wecO3EuHzhDtyzFWsIjDI28fXQpASQ2HXRZusTXCsjYfwsOckCx2Oh
	leWNNA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9r0hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CHCoqE026492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:50 GMT
Received: from hu-kiranv-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 10:12:49 -0700
From: Kiran Venkatappa <quic_kiranv@quicinc.com>
Date: Tue, 12 Aug 2025 22:39:39 +0530
Subject: [PATCH ath12k-ng 13/13] wifi: ath12k: Remove HAL define
 dependencies from shared AHB code
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-ath12k-mod-v1-13-8c9b0eb9335d@quicinc.com>
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
In-Reply-To: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689b7613 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=jfDO2W7Yx6m_jtC0e_MA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: YnNuQO-7O1l2v4M5YFa1uGghmqc-RSP4
X-Proofpoint-ORIG-GUID: YnNuQO-7O1l2v4M5YFa1uGghmqc-RSP4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX88wRY8iv4Xos
 trMdonYTZxtQ5UDgAfrBdpWmdtiHICmWiFRcXOr+znytb3vIuM62YVb3Sg0Oqev8sjg3mj0Lp2a
 0czc2kXKgEHvKuejeU7Cx9/hc+AabFLrDR1QLXgDp1pAQlEcpjIjnoj2SwTFvcZjKEt+bCnPaHf
 vn/plOiUDxquD9EzgF8Ibf0msEKBODgwIsmOwgoSbuecPMKQsV/5NQmr2cBrb5C8h8OZNAHCTiH
 4SeI2538HTOuSCxn6s1pU0o3JasVX05ZACyRhfsEuiJ4bw7YyW+PduM5O/nDTfmc4iighBDgGmR
 guIEmuzqJBzzxn1p7wwS/CTtuELpwXr1Kumd17pUJ2iGP2d7pJjtM6wltUqH5LGQcA/+GWbbrEB
 1XHyBFQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

Eliminate HAL-specific defines from the shared AHB implementation.
Store the WFSS register base-already available in hw_params via the
ce_remap structure-in the AHB context and access it directly.
Add the CMEM offset to the ce_remap structure and use it consistently in
shared code. Improve modularity by removing hardware abstraction layer
dependencies from common code paths and enable cleaner separation of
target-specific logic

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kiran Venkatappa <quic_kiranv@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c      | 7 ++++---
 drivers/net/wireless/ath/ath12k/ce.h       | 1 +
 drivers/net/wireless/ath/ath12k/core.h     | 1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 41ef5170556e9255337b26ec3565ab25f50adc65..efb0ef609dcfab307b942798b901fb7f2b85e7d7 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -123,7 +123,7 @@ enum ext_irq_num {
 
 static u32 ath12k_ahb_read32(struct ath12k_base *ab, u32 offset)
 {
-	if (ab->ce_remap && offset < HAL_SEQ_WCSS_CMEM_OFFSET)
+	if (ab->ce_remap && offset < ab->cmem_offset)
 		return ioread32(ab->mem_ce + offset);
 	return ioread32(ab->mem + offset);
 }
@@ -131,7 +131,7 @@ static u32 ath12k_ahb_read32(struct ath12k_base *ab, u32 offset)
 static void ath12k_ahb_write32(struct ath12k_base *ab, u32 offset,
 			       u32 value)
 {
-	if (ab->ce_remap && offset < HAL_SEQ_WCSS_CMEM_OFFSET)
+	if (ab->ce_remap && offset < ab->cmem_offset)
 		iowrite32(value, ab->mem_ce + offset);
 	else
 		iowrite32(value, ab->mem + offset);
@@ -928,7 +928,8 @@ static int ath12k_ahb_resource_init(struct ath12k_base *ab)
 			goto err_mem_unmap;
 		}
 		ab->ce_remap = true;
-		ab->ce_remap_base_addr = HAL_IPQ5332_CE_WFSS_REG_BASE;
+		ab->cmem_offset = ce_remap->cmem_offset;
+		ab->ce_remap_base_addr = ce_remap->base;
 	}
 
 	ab_ahb->xo_clk = devm_clk_get(ab->dev, "xo");
diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index f44ce2244bcfdb60d505d51096ed70b3965952c9..38f986ea1cd2bf6e7739ca939a3db66644c4ac77 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -85,6 +85,7 @@ struct ce_ie_addr {
 struct ce_remap {
 	u32 base;
 	u32 size;
+	u32 cmem_offset;
 };
 
 struct ce_attr {
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index fa04aaa836fcba9d647b2127651cb366046e2e73..3c4a8f834b70ffe1005e761aabbb966c30cb8ff0 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1060,6 +1060,7 @@ struct ath12k_base {
 
 	void __iomem *mem_ce;
 	u32 ce_remap_base_addr;
+	u32 cmem_offset;
 	bool ce_remap;
 
 	struct {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 9995eccd32d39f69191f0308b67d35ed3501ebf9..82b4f5b9f570076e3ca64dec7b866e1d88787789 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -695,6 +695,7 @@ static const struct ce_ie_addr ath12k_wifi7_ce_ie_addr_ipq5332 = {
 static const struct ce_remap ath12k_wifi7_ce_remap_ipq5332 = {
 	.base = HAL_IPQ5332_CE_WFSS_REG_BASE,
 	.size = HAL_IPQ5332_CE_SIZE,
+	.cmem_offset = HAL_SEQ_WCSS_CMEM_OFFSET,
 };
 
 static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {

-- 
2.34.1


