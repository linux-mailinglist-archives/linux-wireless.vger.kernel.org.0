Return-Path: <linux-wireless+bounces-14347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090F19ABBC8
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 04:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E7A1F246AA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 02:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F3739ACC;
	Wed, 23 Oct 2024 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SpRbPj1r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CCC80027
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 02:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651635; cv=none; b=ce5ZggjEvTU/9iRxWHJMEnjrA1gOgi7PD30QH07CH4PePevujggSiV0oA45e/puYHkIhtinsbqKF0CuUCAZ3JPepWawA1honhWHr2A4eJWDvgp7IXumxjJPqHFNV1++Ypv9xQfQmlZaYjaY3Oyba+uUlS8ujDb+jr7dzlEhDTfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651635; c=relaxed/simple;
	bh=HuRvVhUMvEzYzseoTkARpnx9F3P9VFCQulYoow1GpIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMVvZ+uQiTlW58nvB9NAOXIVtM+LSEXseWxlcLWxbOsgIavIS5E66Jzfi5CxnpLP7RMD/z8opnIZ31hIeq7Q6t6P2KdirVxtdwC90VBmGJyHsZ9PEzV88R5zy44uiZYcsc+wqa4ONEAD+hVBFsIag2fbxyJ2VWvIWw/8MdGhbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SpRbPj1r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLa3E2025435;
	Wed, 23 Oct 2024 02:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s1q3hbeEBrFTRdwCTh5/Oi9TjNG3wPlYxPJBQAnQcp4=; b=SpRbPj1rV8fP50Yl
	RBwDVbVhLqSwe0MJ1BjtFpMyi2S1dosDUPAe3vh6I2bkB4WQuvblDto1J7lgQ/VS
	X3u1pQfRxztLH2O7gFs6wQ55K3kz66wc/D9yFwRsbAgRiqOMs8rLufz2vlF+7a7R
	D5jTBnyhWiWvdxO/GiRDoin5z0MuxZp7v1b/WSwp8p2fUsMsVYoDWvG443GhUvlO
	eP74/91gTxmUDsLkxuQ2q1MKt/Nul2yCvd3SexSeYtLsPcYfpI3YJHwPbedRlZLY
	LVlvxgW00bf46xkWcV9oh3H6emV2mxeLvR9Lmf6raiTJ84acmSyo5ewIJT+uxObW
	twWXDg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em408kpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 02:47:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N2lAFn009179
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 02:47:11 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 19:47:09 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v3 4/4] wifi: ath12k: Add support for reading variant from ACPI to download board data file
Date: Wed, 23 Oct 2024 10:45:51 +0800
Message-ID: <20241023024551.18966-5-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023024551.18966-1-quic_lingbok@quicinc.com>
References: <20241023024551.18966-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-ORIG-GUID: k4TNWsAiJuTJsuLwZ-Xpxprd6nIyezww
X-Proofpoint-GUID: k4TNWsAiJuTJsuLwZ-Xpxprd6nIyezww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230014

Currently, ath12k does not support reading variant from ACPI board data
filename extension for downloading board data file.

To address this issue, obtain the string of the ACPI data filename
extension and use it as part of the string to search for the board data
file from board-2.bin.

This patch will not affect QCN9274, because only WCN7850 supports ACPI.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
v3:
no change

v2:
1.support functions for cases where CONFIG_ACPI is disabled

 drivers/net/wireless/ath/ath12k/acpi.c | 45 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h | 12 +++++++
 drivers/net/wireless/ath/ath12k/core.h |  2 ++
 drivers/net/wireless/ath/ath12k/qmi.c  |  4 +++
 4 files changed, 63 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index 9dfe6c261c02..8234359e26e5 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -37,6 +37,24 @@ static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
 			ab->acpi.bit_flag = obj->integer.value;
 			break;
 		}
+	} else if (obj->type == ACPI_TYPE_STRING) {
+		switch (func) {
+		case ATH12K_ACPI_DSM_FUNC_BDF_EXT:
+			if (obj->string.length <= ATH12K_ACPI_BDF_ANCHOR_STRING_LEN ||
+			    obj->string.length > ATH12K_ACPI_BDF_MAX_LEN ||
+			    memcmp(obj->string.pointer, ATH12K_ACPI_BDF_ANCHOR_STRING,
+				   ATH12K_ACPI_BDF_ANCHOR_STRING_LEN)) {
+				ath12k_warn(ab, "invalid ACPI DSM BDF size: %d\n",
+					    obj->string.length);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			memcpy(ab->acpi.bdf_string, obj->string.pointer,
+			       obj->buffer.length);
+
+			break;
+		}
 	} else if (obj->type == ACPI_TYPE_BUFFER) {
 		switch (func) {
 		case ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS:
@@ -341,6 +359,8 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 	ab->acpi.acpi_bios_sar_enable = false;
 	ab->acpi.acpi_cca_enable = false;
 	ab->acpi.acpi_band_edge_enable = false;
+	ab->acpi.acpi_enable_bdf = false;
+	ab->acpi.bdf_string[0] = '\0';
 
 	if (!ab->hw_params->acpi_guid)
 		/* not supported with this hardware */
@@ -368,6 +388,16 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 			ab->acpi.acpi_disable_rfkill = true;
 	}
 
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_BDF_EXT)) {
+		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_BDF_EXT);
+		if (ret || ab->acpi.bdf_string[0] == '\0') {
+			ath12k_warn(ab, "failed to get ACPI BDF EXT: %d\n", ret);
+			return ret;
+		}
+
+		ab->acpi.acpi_enable_bdf = true;
+	}
+
 	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_TAS_CFG)) {
 		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_TAS_CFG);
 		if (ret) {
@@ -452,6 +482,21 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 	return 0;
 }
 
+int ath12k_acpi_check_bdf_variant_name(struct ath12k_base *ab)
+{
+	size_t max_len = sizeof(ab->qmi.target.bdf_ext);
+
+	if (!ab->acpi.acpi_enable_bdf)
+		return -ENODATA;
+
+	if (strscpy(ab->qmi.target.bdf_ext, ab->acpi.bdf_string + 4, max_len) < 0)
+		ath12k_dbg(ab, ATH12K_DBG_BOOT,
+			   "acpi bdf variant longer than the buffer (variant: %s)\n",
+			   ab->acpi.bdf_string);
+
+	return 0;
+}
+
 void ath12k_acpi_stop(struct ath12k_base *ab)
 {
 	if (!ab->acpi.started)
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
index 0ea022a58daa..de2abd5f988f 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.h
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -10,6 +10,7 @@
 
 #define ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS	0
 #define ATH12K_ACPI_DSM_FUNC_DISABLE_FLAG	2
+#define ATH12K_ACPI_DSM_FUNC_BDF_EXT		3
 #define ATH12K_ACPI_DSM_FUNC_BIOS_SAR		4
 #define ATH12K_ACPI_DSM_FUNC_GEO_OFFSET		5
 #define ATH12K_ACPI_DSM_FUNC_INDEX_CCA		6
@@ -18,6 +19,7 @@
 #define ATH12K_ACPI_DSM_FUNC_INDEX_BAND_EDGE		10
 
 #define ATH12K_ACPI_FUNC_BIT_DISABLE_FLAG		BIT(1)
+#define ATH12K_ACPI_FUNC_BIT_BDF_EXT			BIT(2)
 #define ATH12K_ACPI_FUNC_BIT_BIOS_SAR			BIT(3)
 #define ATH12K_ACPI_FUNC_BIT_GEO_OFFSET			BIT(4)
 #define ATH12K_ACPI_FUNC_BIT_CCA			BIT(5)
@@ -57,6 +59,10 @@
 #define ATH12K_ACPI_DSM_DISABLE_11BE_BIT	BIT(0)
 #define ATH12K_ACPI_DSM_DISABLE_RFKILL_BIT	BIT(2)
 
+#define ATH12K_ACPI_BDF_ANCHOR_STRING_LEN	3
+#define ATH12K_ACPI_BDF_ANCHOR_STRING		"BDF"
+#define ATH12K_ACPI_BDF_MAX_LEN			100
+
 #define ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE (ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET + \
 					      ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN)
 #define ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE (ATH12K_ACPI_POWER_LIMIT_DATA_OFFSET + \
@@ -71,6 +77,7 @@ void ath12k_acpi_stop(struct ath12k_base *ab);
 bool ath12k_acpi_rfkill_disabled(struct ath12k_base *ab);
 bool ath12k_acpi_11be_disabled(struct ath12k_base *ab);
 void ath12k_acpi_set_dsm_func(struct ath12k_base *ab);
+int ath12k_acpi_check_bdf_variant_name(struct ath12k_base *ab);
 
 #else
 
@@ -97,6 +104,11 @@ static inline void ath12k_acpi_set_dsm_func(struct ath12k_base *ab)
 {
 }
 
+static inline int ath12k_acpi_check_bdf_variant_name(struct ath12k_base *ab)
+{
+	return 0;
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /* ATH12K_ACPI_H */
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ae730241e8fb..e8a7314fafce 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -977,7 +977,9 @@ struct ath12k_base {
 		bool acpi_disable_rfkill;
 		bool acpi_cca_enable;
 		bool acpi_band_edge_enable;
+		bool acpi_enable_bdf;
 		u32 bit_flag;
+		char bdf_string[ATH12K_ACPI_BDF_MAX_LEN];
 		u8 tas_cfg[ATH12K_ACPI_DSM_TAS_CFG_SIZE];
 		u8 tas_sar_power_table[ATH12K_ACPI_DSM_TAS_DATA_SIZE];
 		u8 bios_sar_data[ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE];
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 6e5ec4ed533f..c789a3e5d566 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2532,6 +2532,10 @@ static int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 		/* ACPI is optional so continue in case of an error */
 		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", r);
 
+	r = ath12k_acpi_check_bdf_variant_name(ab);
+	if (r)
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "ACPI bdf variant name not set.\n");
+
 out:
 	return ret;
 }
-- 
2.34.1


