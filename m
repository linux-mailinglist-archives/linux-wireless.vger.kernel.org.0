Return-Path: <linux-wireless+bounces-10298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E4A933BE6
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 13:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12ED81F23B09
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59F717F50F;
	Wed, 17 Jul 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f/mMqXL3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771417F4E7
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214647; cv=none; b=ZaFh3z6Ug7Di0Dbpg1pfSSzpxZp8ZibArRlEIsfIuaJZcZrePyBTM/Nd+ueYFC7WKNHiRffv6eJRLbJUyH7O82lS3uRyh/0wX7QyvvDYmt5eg3KeCfb9aCSfQTh7rERfmbRcejZk4AIeZNwPnN9vAYMg1o3+HTJ439m/MGPvEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214647; c=relaxed/simple;
	bh=q3wPUkF3V8sAvPxyE5nqctbxO/nlS6ZomelEMkDNILc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIGm44EFV/zgBSo9EaLIyyHIcRguSRuGLDTlXzHurZa7atGgx9kAg8TfYbASx3qEb2QikuHIET8zIZGpKr9vfOpdbhzpeaA6TVzXXNSN85MqOfI/PkG6lJzeO3IQGpMYM5nP4xH4AfHTIS08v9bGIHwomNQA1GNFFg+RODTcT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f/mMqXL3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H71Bbe030301;
	Wed, 17 Jul 2024 11:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RsZAAFSv/xos6eFFu4LhAP5h5uf2xppWb8NLKJc9GB8=; b=f/mMqXL35U2I6FYr
	K69Tc3bh6PG7Www7/RoxDzLz5K4yDxfsS7uwTsvuDIaBgIgBcDYgS5tSNKtB+Jkx
	B+IxUaJ4Z3NeYtNv/xA0HgztVsYUuk/r30TmAx3GQo+83uZdnEjQo7ScniCZI4gs
	hnjMiwywMZPkiiDEDLyPVzXtZp/hRR9C3omUCBRihMSEKVQLIciIRPZKpJCLA+mK
	QsvILamnx9H5bDUw9mpsCve7MK53z8ClZwxjDpGQH2oI9z6NJ7vGwfsDI9XyLBBV
	HDaibyqBH8ryjqrr9cHfo/0NmWALaCcbzDjGnyRIayPdFdUwCkPNXFg33lHmbBAs
	pX+ncg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwj1j4ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 11:10:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HBAfcX008744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 11:10:41 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Jul 2024 04:10:39 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH 4/4] wifi: ath12k: Add support for reading variant from ACPI to download board data file
Date: Wed, 17 Jul 2024 19:10:23 +0800
Message-ID: <20240717111023.78798-5-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717111023.78798-1-quic_lingbok@quicinc.com>
References: <20240717111023.78798-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-GUID: w-zlB6PqdALxP8vTX2Y66xRPNEKZMDTy
X-Proofpoint-ORIG-GUID: w-zlB6PqdALxP8vTX2Y66xRPNEKZMDTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407170086

Currently, ath12k does not support reading variant from ACPI board data
filename extension for downloading board data file.

To address this issue, obtain the string of the ACPI data filename
extension and use it as part of the string to search for the board data
file from board-2.bin.

This patch will not affect QCN9274, because only WCN7850 supports ACPI.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/acpi.c | 30 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h |  6 ++++++
 drivers/net/wireless/ath/ath12k/core.c | 21 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/core.h |  3 +++
 drivers/net/wireless/ath/ath12k/qmi.c  |  4 ++--
 5 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index 33aa1427e6c0..1ef50fc14325 100644
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
@@ -331,6 +349,8 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 	ab->acpi.acpi_bios_sar_enable = false;
 	ab->acpi.acpi_cca_enable = false;
 	ab->acpi.acpi_band_edge_enable = false;
+	ab->acpi.acpi_enable_bdf = false;
+	ab->acpi.bdf_string[0] = '\0';
 
 	if (!ab->hw_params->acpi_guid)
 		/* not supported with this hardware */
@@ -358,6 +378,16 @@ int ath12k_acpi_start(struct ath12k_base *ab)
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
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
index f3546b02aab7..38974a8f99ea 100644
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
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3fd7ece7bcdd..db88ce3ee238 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -677,6 +677,27 @@ int ath12k_core_check_smbios(struct ath12k_base *ab)
 	return 0;
 }
 
+int ath12k_core_check_acpi(struct ath12k_base *ab)
+{
+	int ret;
+	size_t max_len = sizeof(ab->qmi.target.bdf_ext);
+
+	ret = ath12k_acpi_start(ab);
+	if (ret)
+		/* ACPI is optional so continue in case of an error */
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", ret);
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
 static int ath12k_core_soc_create(struct ath12k_base *ab)
 {
 	int ret;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 5177147e2b40..3fbfb3761d5f 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -944,7 +944,9 @@ struct ath12k_base {
 		bool acpi_disable_rfkill;
 		bool acpi_cca_enable;
 		bool acpi_band_edge_enable;
+		bool acpi_enable_bdf;
 		u32 bit_flag;
+		char bdf_string[ATH12K_ACPI_BDF_MAX_LEN];
 		u8 tas_cfg[ATH12K_ACPI_DSM_TAS_CFG_SIZE];
 		u8 tas_sar_power_table[ATH12K_ACPI_DSM_TAS_DATA_SIZE];
 		u8 bios_sar_data[ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE];
@@ -987,6 +989,7 @@ int ath12k_core_resume_early(struct ath12k_base *ab);
 int ath12k_core_resume(struct ath12k_base *ab);
 int ath12k_core_suspend(struct ath12k_base *ab);
 int ath12k_core_suspend_late(struct ath12k_base *ab);
+int ath12k_core_check_acpi(struct ath12k_base *ab);
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 6e5ec4ed533f..9bc2233080d1 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2527,10 +2527,10 @@ static int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 	if (r)
 		ath12k_dbg(ab, ATH12K_DBG_QMI, "SMBIOS bdf variant name not set.\n");
 
-	r = ath12k_acpi_start(ab);
+	r = ath12k_core_check_acpi(ab);
 	if (r)
 		/* ACPI is optional so continue in case of an error */
-		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", r);
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "ACPI bdf variant name not set.\n");
 
 out:
 	return ret;
-- 
2.34.1


