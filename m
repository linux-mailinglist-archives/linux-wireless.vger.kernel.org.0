Return-Path: <linux-wireless+bounces-17691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77115A160E8
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 09:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E17818867B7
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4564199E88;
	Sun, 19 Jan 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kqTXNy8v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39A157A46
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737275859; cv=none; b=MKmKI/nhhS5w4ySvUM1FSEUHi/4PRU61wFYM0msMqU3a6jZP/8xhfn84i1tELBfogLyy9kZfOoIBpIsjm3pAyQT6Nuy600U8wjGOYcJ3lwiRQCbR6nSx3xTQnOcQIDfxzssrxbE1PDv/3lxY1lXLOexeWfrR0gK137nuZX6Ia8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737275859; c=relaxed/simple;
	bh=7H5Ich5CbUX8p1SEp3QPrgLHqa6KHlJl6GcXCWDkxhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raxmO/ijKxQ4DYyAIMRNhBaPvOwZ9QWvgPIDAlKk5920DvEfynVsxTH/yzOHcqhQylmhqOUQc0af30tBvfWJ1/GOorPtOe9I015Jx87vXxIy6sZn3kZS2e4bfNE6A+pqa5/eNjSGnduzqDkp1JDV8lLtOI63XtMCDSsmhsRUHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kqTXNy8v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50J69qfI024661;
	Sun, 19 Jan 2025 08:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OgoDrtc5xPKmJuhAFx+eLRurUBvA0O2Nm9s+2snvxhE=; b=kqTXNy8vkBCaPwp9
	fiPUBslny2fIJENTJY4c1SNKVsg6uhqjIizLRWOLiYZzdHLe/yZWkONnUyZTrWNO
	/zw2IXbdBg6Zjjxbxb5AKLYSiiKfrH9ewZmdcpccsbPcfCb2D6TOHwg8N4UW2ikW
	Vf6RGUR/CnS0dEYnNPY4NjqGwV9OPjOzw2hqAKo43DZEBwxxJp+wNDYDaFLXKnuW
	zw75XiC5tx8bkj4KlrvAiJK3rcVkWz2YfUSBq7WjY1tSO2nusANsxEuqZAEd8FKs
	iPV6DGPitFradWoP3IHrxZDQyFtpVjNFMU1B9hAC6DmV6NHgSrRLlOio+vwHhSuX
	QLIl6A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 448ky4gmeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jan 2025 08:37:28 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50J8bR1C016570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jan 2025 08:37:27 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 19 Jan 2025 00:37:25 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v10 2/4] wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
Date: Sun, 19 Jan 2025 14:06:55 +0530
Message-ID: <20250119083657.1937557-3-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250119083657.1937557-1-quic_aarasahu@quicinc.com>
References: <20250119083657.1937557-1-quic_aarasahu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MoR0eY8oO37pY2Jyl3BA8JVYlMH30Vj5
X-Proofpoint-ORIG-GUID: MoR0eY8oO37pY2Jyl3BA8JVYlMH30Vj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=874
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501190071

Export ath12k_wmi_tlv_hdr() to further use in the testmode command
processing.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 4 ++--
 drivers/net/wireless/ath/ath12k/wmi.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 4dd6cdf84571..246b8aab49a9 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -173,7 +173,7 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_p2p_noa_event) },
 };
 
-static __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
+__le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
 {
 	return le32_encode_bits(cmd, WMI_TLV_TAG) |
 		le32_encode_bits(len, WMI_TLV_LEN);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index b6a197389277..00d024d4eb2c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_WMI_H
@@ -5754,6 +5754,7 @@ int ath12k_wmi_set_bios_cmd(struct ath12k_base *ab, u32 param_id,
 			    const u8 *buf, size_t buf_len);
 int ath12k_wmi_set_bios_sar_cmd(struct ath12k_base *ab, const u8 *psar_table);
 int ath12k_wmi_set_bios_geo_cmd(struct ath12k_base *ab, const u8 *pgeo_table);
+__le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len);
 
 static inline u32
 ath12k_wmi_caps_ext_get_pdev_id(const struct ath12k_wmi_caps_ext_params *param)
-- 
2.34.1


