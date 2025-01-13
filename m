Return-Path: <linux-wireless+bounces-17403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F175A0B042
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 08:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091C018849B5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 07:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DF1231C8A;
	Mon, 13 Jan 2025 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gX3F0Pll"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB73C1F
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736754514; cv=none; b=Nhg1ckg/M+a9sg9hGWHvpYZavZTDYnCv1AMVJoAoBCXOKqz2IY4BbH2N84tIZiv0zfm8kqJAimNEb45/26PMneb+OJor98ke8PX9yxUUjSnZobqoe77mftAqk3wHXfjoq9frixJ9jasX5Suo5DMp/0ss7+vJ/V7kb7NkwLAkpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736754514; c=relaxed/simple;
	bh=qXcidrLJXv78pJO2wVhDaKgi5sBVt6g2Jzq7yTxQASQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCzJSPvRQED0FryxXfxtQ+TrudFN1RZ3JvaPEePozv0GeFgb6aJ6gunEBVeDK/6kmwxysuSOW9QGh3U8cBaNOHcHM8ixXinTsBn9zKOxXletO5+vJAwDHnRrrHOEV+b/T08lq+nCxQsyau5AYmh2t9soGjFF2Quk8Fb8wUsT7l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gX3F0Pll; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D7OLqs023769;
	Mon, 13 Jan 2025 07:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	COJcRGNsPOa6pNTOIetxZqgfLyUoBJIICtuCd0MES6w=; b=gX3F0Pll8ogFPQd1
	58z7ir+voTAXMxhZJloFaF9Z1drHTw9lg26pRdn3BxgFT2Og6sRrt9YX7nuet+eh
	mM6eNGen/gCBQ12yHJnrln0Z8icmPXdr7LY/KBdO+cOkk3R3ld6ZcE2iuwSZAHZW
	Dc2KnYgv7FXI6lzDye9seSb54V9YETeeIdmukYgk0Gi+DgahrBJa9q14AuWEbbQY
	eotosUO5pIaaGqjt+eVrAoJqUxXeyjq9RTEbwms2uyJOORsi/tVL8fCvRem3MVkG
	0Pb2FknN6wpBkmge+Ds+/5eRHBh7U46PLPpdqSa4VPU3wKAMQ2ys7G7dAWXKA9Nz
	wCQy6w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444xcxr1rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:48:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D7mSP0021716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:48:28 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 12 Jan 2025 23:48:26 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v4 4/4] wifi: ath12k: Add support for reading variant from ACPI to download board data file
Date: Mon, 13 Jan 2025 15:48:10 +0800
Message-ID: <20250113074810.29729-5-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113074810.29729-1-quic_lingbok@quicinc.com>
References: <20250113074810.29729-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 36rL35cohcz6bn9kGEN5STzzZgGFsDNn
X-Proofpoint-GUID: 36rL35cohcz6bn9kGEN5STzzZgGFsDNn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130066

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
v4:
1.rebase to 0c5fcd9069dd

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
index fe6f051debda..cf28b5dd049a 100644
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
index 7c18a3f60e3f..24f5a367a299 100644
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
 bool ath12k_acpi_get_disable_rfkill(struct ath12k_base *ab);
 bool ath12k_acpi_get_disable_11be(struct ath12k_base *ab);
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
index c11c8c03b357..eacf377e2efa 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1042,7 +1042,9 @@ struct ath12k_base {
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
index 86d055c45ace..f97f38899d55 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2745,6 +2745,10 @@ int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
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


