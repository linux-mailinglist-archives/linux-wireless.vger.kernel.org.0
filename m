Return-Path: <linux-wireless+bounces-29872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65256CCA039
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BCD33001E20
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2269726F2B8;
	Thu, 18 Dec 2025 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HkiSgOXH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uodr5VBD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6526E6F0
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022930; cv=none; b=SJsuKNxpiDX4V+QNxnSQdTwH7haJmSkW69OI15sZiZKDQrK6ibNfwKWU/vw6+YI0SQQgr8E342d2njQft1f886cZaOGUT3KfWiK0KD22yExvb1RHPRse5icQPUJWhkUnPwxKei+zBGuEIllKs1S4TQm8tNJYeny5agtzoKVzpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022930; c=relaxed/simple;
	bh=1aWsQAo8tU7St2K4fTIQvfq24L08rnYoS7MaMH5qthk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUaK3kMo6v7okhripkisRmBiProKN0MzSil3U7U460l15ecWnqKPYw7itvCNd5s1jYncgmAuzVNnwPyQlBGoQHHvOpElZbT71FwkrwICD9YSL1t2KVic6va6cjnbKe2ExyDp6arblXgVlIl/CGyTI7MAc4c+72YaCQN4QXO7y2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HkiSgOXH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uodr5VBD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Ypdh4148410
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X8x6g3YZB2wpQhVgsdcIzUOEQrCimMN5/9XF8wWkrMc=; b=HkiSgOXHo0ChYvGs
	J2BsJyYYqjQ8r25Le2QcSjfG4iuCTX1LM7SeI1iZMfT7pBkXmjij3PzGZwDO+Uv7
	m4f1IjUj4BNIHGtTzrfplEpkBTks5PIlNypKmceO9HJXvs8OFhJBdAOjpeD0/uRR
	Y4m+7zpvgXWqLo0lPyJqk2Npw22qrFAkj7KqjMs0FWWtPjv9Xy2wDLO1urk7dJEK
	QSdzUSN2hgA4m6EeIUUWJRvBFKGHibYiWzhQqezI/6sm/BRDxCoHfDkrKpjWVRkc
	n2ixfZovN8azJkTHMCT8dZm+MpW1P6jRAR7plIYrBRIKjAUlV7UDWAn3CjfXYJKZ
	+bbd0w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40u798mw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f26fc6476so2273825ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022927; x=1766627727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8x6g3YZB2wpQhVgsdcIzUOEQrCimMN5/9XF8wWkrMc=;
        b=Uodr5VBDNR+lfhY3gKlFlauYZ3j70P23qwH2K494/Y9mLuizP1S66GmU/e7jbfv7Pw
         rFm8C7zAbNpXvR+S22D9l8NFvz73KwJCgG54H6Ejw9HHoXcMlCFWhJrLdah4LY+z/Tk5
         +jrcVWKq82oW2PnAKQSLV+Ql2lem+gweMLBTaCljxvI1hKw7H2UbIx721apWeS8dw9EC
         xszCDrrFiYiYVK+Ff4XQrtZRGJKdt+RyYY6hk3SArWcDdeQmrJQUAunFGkTGMKwz5f+i
         t7EhvvErvQn9mAiozR8mrYzU+HI+PMWtm3Zmfwm+vBfmeeKAIMPYbJRQWkCh8S0BAcF5
         FoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022927; x=1766627727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X8x6g3YZB2wpQhVgsdcIzUOEQrCimMN5/9XF8wWkrMc=;
        b=rndhQp7Is7L5fxCG+EWcKKU0HPyWnaZl8Vo0P9ocM0yIgZqcw8irM/4z+Awaf4z3V2
         c0bwiAM9MlY7nlGvBkqX0gosl3nlAdirUJtWICHh+qG+guNtZxhE3bjj0A4TGxcKxIUm
         qo6ueeStvftkqF2/8wWUDUlgm3hr63QcRXQnPAKpgeArMuhReyKagaZU/eTWT1Zs282R
         WJPz4JxElmGupMw0be6T7OGDi7r4slHMMg6/Qg0wzzFv4SIipv5VuCrZrx7EIs1WKX4G
         90Fimy9wyNTq3OpyFxHR3LEziK1BljABpu0qJS594ec/VQ0Ghc/3eyL+Mo2QG5zFJ8ND
         x48A==
X-Gm-Message-State: AOJu0Yyzf3m+3eu36UWQDEztzHNrp+rajVkT7cZ+7KEuOxZS7zxofqHW
	xI+zIIlsGHtNR3ADoBkp7r1swxc1X76eOwI7iKb6Evr6gIgQWzkE1fos7cvNA5kb2qHNRVQFC28
	SMQSvrva7HaPtlsthLtXP/OpNPPRKZ02wed+e1rl6leiYeT/AQWVhmh4rohmQF7n+S+pl8w==
X-Gm-Gg: AY/fxX7dJaxFhQmU4AltcSWEjN7OL4BxZo9pCBBhdSdIdhh7TdT43/7SERuYTkMc5p6
	AK6QhTRTwfA7yA/IL/Y0+AJ5SsqaYjoIQBpYSozL0DA35BuHnzpbOpzgGrE8PL9nHKZMwpZAF1d
	cZDeu95RwCT7RkJZJptYuCSNAQJit3MQ1GjNtbej/9pCre0T8mIBhGqYsXulr0qj8C3sgoaIh7J
	zhm84mZn64ICLxa1KdeITA407GO3BETqImzFuA3GLfnOEvQM2FK9ajbb6sRCQKJH4feYBrXIrDd
	BHxH8tapySeHeJCv8NHuuvocmuqgav0tCf1TTQcmqgw945Zg7Q/hQN5wjGxqfivHDJ3raB+lPl7
	NWyGR4HYQq2CyDJd3a4HLiH8qC0xLOf9gcloUxx3d8o+xMKuoNf2W1IErFKjGmFA=
X-Received: by 2002:a17:903:2f48:b0:258:f033:3ff9 with SMTP id d9443c01a7336-29f2436e48fmr209138845ad.48.1766022926534;
        Wed, 17 Dec 2025 17:55:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdny4hssq0COgccFXnFu/2aNeGS1VVg0No119OMqt9HxSHD+Q0oAALdZbuOSFFeiHq7Dp7kg==
X-Received: by 2002:a17:903:2f48:b0:258:f033:3ff9 with SMTP id d9443c01a7336-29f2436e48fmr209138645ad.48.1766022926023;
        Wed, 17 Dec 2025 17:55:26 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:25 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:25 +0800
Subject: [PATCH ath-next 11/19] wifi: ath12k: support downloading auxiliary
 ucode image for QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-11-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: sMuDJxfAft19uqyv8gnsAjELKnXdFufr
X-Authority-Analysis: v=2.4 cv=Z8Th3XRA c=1 sm=1 tr=0 ts=69435f0f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ejwxJ43VBFfvAu_YmawA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: sMuDJxfAft19uqyv8gnsAjELKnXdFufr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX3fEK3GxAavCT
 PXe8gW+9CECD2yOllKnlCdVseWbUTPjIoVScf20NeQKwiaKmOO5dA8keyveCHIB5aEer1n3uVGe
 HAqC4/fcZuILEhBN28k7NhvaZPk9JORPLKBdvm3zpeVD8t8Kg694Higohx+XKLFPiGIpu3uT0mK
 dbOvSCc/CyIk5OVUbcuvaMhsMyDkvDXkEIX71wiecRvKmQSTtiv57/h9FIreHoHhYNvFAe/MSeE
 RliJi0jjhjxfMif/49nBeADkf1QeNE07GV/J14BVmRFSYbjM6Zw+SO+XKtPtL0LbqdUwEg5m9vX
 vIBGQrK+lOHxrI08V8LTsomzFKa7hFw8QQ1Em69rWk5c1cDshiQv/wh5MqKv5tTcZmB1NhpmVF4
 IKIWhkd26qyeSPzak7VAj1z9NFLIcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

QCC2072 requires another firmware image named aux_ucode.bin, add support
to download it.

Add a new hardware parameter download_aux_ucode to make sure other chips
are not affected.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h     |   2 +
 drivers/net/wireless/ath/ath12k/fw.c       |  10 +-
 drivers/net/wireless/ath/ath12k/fw.h       |   3 +-
 drivers/net/wireless/ath/ath12k/hw.h       |   2 +
 drivers/net/wireless/ath/ath12k/qmi.c      | 179 ++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/qmi.h      |  15 +++
 drivers/net/wireless/ath/ath12k/wifi7/hw.c |   8 +-
 7 files changed, 215 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 667cf5993cf1..990934ec92fc 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1082,6 +1082,8 @@ struct ath12k_base {
 		size_t amss_dualmac_len;
 		const u8 *m3_data;
 		size_t m3_len;
+		const u8 *aux_uc_data;
+		size_t aux_uc_len;
 
 		DECLARE_BITMAP(fw_features, ATH12K_FW_FEATURE_COUNT);
 		bool fw_features_valid;
diff --git a/drivers/net/wireless/ath/ath12k/fw.c b/drivers/net/wireless/ath/ath12k/fw.c
index 5ac497f80cad..22074653cbb8 100644
--- a/drivers/net/wireless/ath/ath12k/fw.c
+++ b/drivers/net/wireless/ath/ath12k/fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
- * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
@@ -121,6 +121,14 @@ static int ath12k_fw_request_firmware_api_n(struct ath12k_base *ab,
 			ab->fw.m3_data = data;
 			ab->fw.m3_len = ie_len;
 			break;
+		case ATH12K_FW_IE_AUX_UC_IMAGE:
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "found aux_uc image ie (%zd B)\n",
+				   ie_len);
+
+			ab->fw.aux_uc_data = data;
+			ab->fw.aux_uc_len = ie_len;
+			break;
 		case ATH12K_FW_IE_AMSS_DUALMAC_IMAGE:
 			ath12k_dbg(ab, ATH12K_DBG_BOOT,
 				   "found dualmac fw image ie (%zd B)\n",
diff --git a/drivers/net/wireless/ath/ath12k/fw.h b/drivers/net/wireless/ath/ath12k/fw.h
index 7afaefed5086..e146d24dfea4 100644
--- a/drivers/net/wireless/ath/ath12k/fw.h
+++ b/drivers/net/wireless/ath/ath12k/fw.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
- * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_FW_H
@@ -15,6 +15,7 @@ enum ath12k_fw_ie_type {
 	ATH12K_FW_IE_AMSS_IMAGE = 2,
 	ATH12K_FW_IE_M3_IMAGE = 3,
 	ATH12K_FW_IE_AMSS_DUALMAC_IMAGE = 4,
+	ATH12K_FW_IE_AUX_UC_IMAGE = 5,
 };
 
 enum ath12k_fw_features {
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 85da4e43cf61..d1234a65ac76 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -78,6 +78,7 @@
 #define ATH12K_DEFAULT_CAL_FILE		"caldata.bin"
 #define ATH12K_AMSS_FILE		"amss.bin"
 #define ATH12K_M3_FILE			"m3.bin"
+#define ATH12K_AUX_UC_FILE		"aux_ucode.bin"
 #define ATH12K_REGDB_FILE_NAME		"regdb.bin"
 
 #define ATH12K_PCIE_MAX_PAYLOAD_SIZE	128
@@ -143,6 +144,7 @@ struct ath12k_hw_params {
 		size_t cal_offset;
 		enum ath12k_m3_fw_loaders m3_loader;
 		bool std_elf_img:1;
+		bool download_aux_ucode:1;
 	} fw;
 
 	u8 max_radios;
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 4966697f4e62..cfde4147c8fc 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -1623,6 +1623,47 @@ static const struct qmi_elem_info qmi_wlanfw_m3_info_resp_msg_v01_ei[] = {
 	},
 };
 
+static const struct qmi_elem_info qmi_wlanfw_aux_uc_info_req_msg_v01_ei[] = {
+	{
+		.data_type      = QMI_UNSIGNED_8_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u64),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x01,
+		.offset         = offsetof(struct qmi_wlanfw_aux_uc_info_req_msg_v01, addr),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_4_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u32),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(struct qmi_wlanfw_aux_uc_info_req_msg_v01, size),
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+static const struct qmi_elem_info qmi_wlanfw_aux_uc_info_resp_msg_v01_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct qmi_response_type_v01),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(struct qmi_wlanfw_aux_uc_info_resp_msg_v01, resp),
+		.ei_array       = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
 static const struct qmi_elem_info qmi_wlanfw_ce_tgt_pipe_cfg_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
@@ -3237,6 +3278,131 @@ int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 	return ret;
 }
 
+static void ath12k_qmi_aux_uc_free(struct ath12k_base *ab)
+{
+	struct m3_mem_region *aux_uc_mem = &ab->qmi.aux_uc_mem;
+
+	if (!aux_uc_mem->vaddr)
+		return;
+
+	dma_free_coherent(ab->dev, aux_uc_mem->total_size,
+			  aux_uc_mem->vaddr, aux_uc_mem->paddr);
+	aux_uc_mem->vaddr = NULL;
+	aux_uc_mem->total_size = 0;
+	aux_uc_mem->size = 0;
+}
+
+static int ath12k_qmi_aux_uc_load(struct ath12k_base *ab)
+{
+	struct m3_mem_region *aux_uc_mem = &ab->qmi.aux_uc_mem;
+	const struct firmware *fw = NULL;
+	const void *aux_uc_data;
+	char path[100];
+	size_t aux_uc_len;
+	int ret;
+
+	if (ab->fw.aux_uc_data && ab->fw.aux_uc_len > 0) {
+		/* firmware-N.bin had a aux_uc firmware file so use that */
+		aux_uc_data = ab->fw.aux_uc_data;
+		aux_uc_len = ab->fw.aux_uc_len;
+	} else {
+		/*
+		 * No aux_uc file in firmware-N.bin so try to request old
+		 * separate aux_ucode.bin.
+		 */
+		fw = ath12k_core_firmware_request(ab, ATH12K_AUX_UC_FILE);
+		if (IS_ERR(fw)) {
+			ret = PTR_ERR(fw);
+			ath12k_core_create_firmware_path(ab, ATH12K_AUX_UC_FILE,
+							 path, sizeof(path));
+			ath12k_err(ab, "failed to load %s: %d\n", path, ret);
+			return ret;
+		}
+
+		aux_uc_data = fw->data;
+		aux_uc_len = fw->size;
+	}
+
+	/* In recovery/resume cases, AUX_UC buffer is not freed, try to reuse that */
+	if (aux_uc_mem->vaddr) {
+		if (aux_uc_mem->total_size >= aux_uc_len)
+			goto copy;
+
+		/* Old buffer is too small, free and reallocate */
+		ath12k_qmi_aux_uc_free(ab);
+	}
+
+	aux_uc_mem->vaddr = dma_alloc_coherent(ab->dev, aux_uc_len,
+					       &aux_uc_mem->paddr, GFP_KERNEL);
+	if (!aux_uc_mem->vaddr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	 aux_uc_mem->total_size = aux_uc_len;
+
+copy:
+	memcpy(aux_uc_mem->vaddr, aux_uc_data, aux_uc_len);
+	aux_uc_mem->size = aux_uc_len;
+
+	ret = 0;
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static noinline_for_stack
+int ath12k_qmi_wlanfw_aux_uc_info_send(struct ath12k_base *ab)
+{
+	struct m3_mem_region *aux_uc_mem = &ab->qmi.aux_uc_mem;
+	struct qmi_wlanfw_aux_uc_info_req_msg_v01 req = {};
+	struct qmi_wlanfw_aux_uc_info_resp_msg_v01 resp = {};
+	struct qmi_txn txn;
+	int ret = 0;
+
+	ret = ath12k_qmi_aux_uc_load(ab);
+	if (ret) {
+		ath12k_err(ab, "failed to load aux_uc firmware: %d", ret);
+		return ret;
+	}
+
+	req.addr = aux_uc_mem->paddr;
+	req.size = aux_uc_mem->size;
+
+	ret = qmi_txn_init(&ab->qmi.handle, &txn,
+			   qmi_wlanfw_aux_uc_info_resp_msg_v01_ei, &resp);
+	if (ret < 0)
+		goto out;
+
+	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
+			       QMI_WLANFW_AUX_UC_INFO_REQ_V01,
+			       QMI_WLANFW_AUX_UC_INFO_REQ_MSG_V01_MAX_MSG_LEN,
+			       qmi_wlanfw_aux_uc_info_req_msg_v01_ei, &req);
+	if (ret < 0) {
+		qmi_txn_cancel(&txn);
+		ath12k_warn(ab, "qmi failed to send AUX_UC information request, err = %d\n",
+			    ret);
+		goto out;
+	}
+
+	ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH12K_QMI_WLANFW_TIMEOUT_MS));
+	if (ret < 0) {
+		ath12k_warn(ab, "qmi failed AUX_UC information request %d\n", ret);
+		goto out;
+	}
+
+	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+		ath12k_warn(ab, "qmi AUX_UC info request failed, result: %d, err: %d\n",
+			    resp.resp.result, resp.resp.error);
+		ret = -EINVAL;
+		goto out;
+	}
+out:
+	return ret;
+}
+
 static int ath12k_qmi_wlanfw_mode_send(struct ath12k_base *ab,
 				       u32 mode)
 {
@@ -3601,6 +3767,7 @@ static noinline_for_stack
 int ath12k_qmi_event_load_bdf(struct ath12k_qmi *qmi)
 {
 	struct ath12k_base *ab = qmi->ab;
+	const struct ath12k_hw_params *hw_params = ab->hw_params;
 	int ret;
 
 	ret = ath12k_qmi_request_target_cap(ab);
@@ -3621,7 +3788,7 @@ int ath12k_qmi_event_load_bdf(struct ath12k_qmi *qmi)
 		return ret;
 	}
 
-	if (ab->hw_params->download_calib) {
+	if (hw_params->download_calib) {
 		ret = ath12k_qmi_load_bdf_qmi(ab, ATH12K_QMI_BDF_TYPE_CALIBRATION);
 		if (ret < 0)
 			ath12k_warn(ab, "qmi failed to load calibrated data :%d\n", ret);
@@ -3633,6 +3800,14 @@ int ath12k_qmi_event_load_bdf(struct ath12k_qmi *qmi)
 		return ret;
 	}
 
+	if (hw_params->fw.download_aux_ucode) {
+		ret = ath12k_qmi_wlanfw_aux_uc_info_send(ab);
+		if (ret < 0) {
+			ath12k_warn(ab, "qmi failed to send aux_uc info req: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return ret;
 }
 
@@ -3906,6 +4081,7 @@ void ath12k_qmi_deinit_service(struct ath12k_base *ab)
 	qmi_handle_release(&ab->qmi.handle);
 	cancel_work_sync(&ab->qmi.event_work);
 	destroy_workqueue(ab->qmi.event_wq);
+	ath12k_qmi_aux_uc_free(ab);
 	ath12k_qmi_m3_free(ab);
 	ath12k_qmi_free_target_mem_chunk(ab);
 	ab->qmi.ab = NULL;
@@ -3914,5 +4090,6 @@ void ath12k_qmi_deinit_service(struct ath12k_base *ab)
 void ath12k_qmi_free_resource(struct ath12k_base *ab)
 {
 	ath12k_qmi_free_target_mem_chunk(ab);
+	ath12k_qmi_aux_uc_free(ab);
 	ath12k_qmi_m3_free(ab);
 }
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 050dcaca1cb7..b5a4a01391cb 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -154,6 +154,7 @@ struct ath12k_qmi {
 	u8 num_radios;
 	struct target_info target;
 	struct m3_mem_region m3_mem;
+	struct m3_mem_region aux_uc_mem;
 	unsigned int service_ins_id;
 	struct dev_mem_info dev_mem[ATH12K_QMI_WLFW_MAX_DEV_MEM_NUM_V01];
 };
@@ -203,6 +204,7 @@ enum ath12k_qmi_cnss_feature {
 	CNSS_FEATURE_MIN_ENUM_VAL_V01 = INT_MIN,
 	CNSS_QDSS_CFG_MISS_V01 = 3,
 	CNSS_PCIE_PERST_NO_PULL_V01 = 4,
+	CNSS_AUX_UC_SUPPORT_V01 = 6,
 	CNSS_MAX_FEATURE_V01 = 64,
 	CNSS_FEATURE_MAX_ENUM_VAL_V01 = INT_MAX,
 };
@@ -541,6 +543,19 @@ struct qmi_wlanfw_m3_info_resp_msg_v01 {
 	struct qmi_response_type_v01 resp;
 };
 
+#define QMI_WLANFW_AUX_UC_INFO_REQ_MSG_V01_MAX_MSG_LEN	18
+#define QMI_WLANFW_AUX_UC_INFO_RESP_MSG_V01_MAX_MSG_LEN	7
+#define QMI_WLANFW_AUX_UC_INFO_REQ_V01	0x005A
+
+struct qmi_wlanfw_aux_uc_info_req_msg_v01 {
+	u64 addr;
+	u32 size;
+};
+
+struct qmi_wlanfw_aux_uc_info_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+
 #define QMI_WLANFW_WLAN_MODE_REQ_MSG_V01_MAX_LEN	11
 #define QMI_WLANFW_WLAN_MODE_RESP_MSG_V01_MAX_LEN	7
 #define QMI_WLANFW_WLAN_CFG_REQ_MSG_V01_MAX_LEN		803
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index bfa111968676..03732370b58e 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -340,6 +340,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.cal_offset = 128 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_driver,
 			.std_elf_img = false,
+			.download_aux_ucode = false,
 		},
 		.max_radios = 1,
 		.single_pdev_only = false,
@@ -423,6 +424,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.cal_offset = 256 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_driver,
 			.std_elf_img = false,
+			.download_aux_ucode = false,
 		},
 
 		.max_radios = 1,
@@ -508,6 +510,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.cal_offset = 128 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_driver,
 			.std_elf_img = false,
+			.download_aux_ucode = false,
 		},
 		.max_radios = 2,
 		.single_pdev_only = false,
@@ -590,6 +593,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.cal_offset = 128 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_remoteproc,
 			.std_elf_img = false,
+			.download_aux_ucode = false,
 		},
 		.max_radios = 1,
 		.single_pdev_only = false,
@@ -666,6 +670,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.cal_offset = 256 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_driver,
 			.std_elf_img = true,
+			.download_aux_ucode = true,
 		},
 
 		.max_radios = 1,
@@ -712,7 +717,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.wmi_init = ath12k_wifi7_wmi_init_wcn7850,
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01) |
-					   BIT(CNSS_PCIE_PERST_NO_PULL_V01),
+					   BIT(CNSS_PCIE_PERST_NO_PULL_V01) |
+					   BIT(CNSS_AUX_UC_SUPPORT_V01),
 
 		.rfkill_pin = 0,
 		.rfkill_cfg = 0,

-- 
2.25.1


