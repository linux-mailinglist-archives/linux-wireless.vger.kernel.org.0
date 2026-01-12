Return-Path: <linux-wireless+bounces-30683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E25DDD10E91
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E21733015E1E
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADA330CD82;
	Mon, 12 Jan 2026 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E55Eo0I3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eg96j1Pb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0D334361
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203435; cv=none; b=TpuklDZf6G6nlVF9zmtsnHKIRm8hGKNpei8m5oMsmhVpPvcKV/Y4xB8x1k63WbeGG6Et0228Q8kJvflczzWPJdl/R6X4IO0785qdgnaUCip6pH333OVYB641uiWtRGQO2LaGcqbIoxDPtaol/vVzp6Mj8y86qujn7QIsCER9MsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203435; c=relaxed/simple;
	bh=2WPoqdIpmEUe1RpDEUfqMGN5Sh+uny6SUNn9P+LTMuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sF4zx4P64YhO9GndfPTeoNd4KyuuR8JrhAzvgfKh6+JqS94U7MlroX4QBy9bmXpuxMaZ0lyjLyYfxgbn1O37acrm/cqFKee2V6OK3oq/L3otZeBPbVA7wN8ODsK0BKgICquCIe/5Ixx0ioooRRTBALq3i5bqvqLItpyH8YO0aZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E55Eo0I3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eg96j1Pb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BMbGfx4024750
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NE7S8gBTNQKTG3tmqbJFI7qx+haDyEtPwTPhOF443DQ=; b=E55Eo0I3uU8/098v
	Aq2adUoG9Yw3eHuSYgRzsWGq8lk/eVgMpB7GlMuOJERtv7EdE7EUlviksjNcnlJE
	C1A1k9rG25Vc28Mi97IzK24KGVwP6nqGjKi3oieYjqYXcPMzcT/pgutX5PszvOMk
	ODcRUokXf+331LMcrNULCG5JnmJwev56wZ9PBBEsMorUWimsNg1agPEY7kmbh+MQ
	IlP8UH8vffcondF7VSoTY4THM06w8ggtTtg3+mFSbuu3L2Rd9xqZxPJcv7fIEb3u
	rizRf/tAiHHPPo5IIv7Bzl85hJbo4v55ay22uv6G4NdTC4Ml9Ec4yD1hKwK/pRNn
	hfHH5w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkfhakxcb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:13 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c52779e9e65so1704684a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203432; x=1768808232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NE7S8gBTNQKTG3tmqbJFI7qx+haDyEtPwTPhOF443DQ=;
        b=Eg96j1PbEj3hesrXkI5IVZak4aNTBSAaWpU3mJhS5gPl3JjmFVfbQZ0nfnzmRfHle8
         doou9Dl641PrPDCgXoT5BICppOr30w+qwGGNYojq2s2LIz5/Gk3UbInN4u2/KDAD8G6x
         4k/+fgEEyG4CSTAbia0l5823DjyF8fLFPfkWMbzqSF+YkOJvsDeqzaj7bithb6PfTH1l
         ii9RLp5XALjS7ibonlF/q48QRFDs0pDhv0YcP8Xs0sryA/uy4ahPDlJ/PzRoJxC/aliV
         RG67rXQ7PpYE68HLwEsPGXFn0yWDTWvLmIkbAu+GSqTSPzoaZDzwlqtB7L9eEkqB76Aj
         w6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203432; x=1768808232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NE7S8gBTNQKTG3tmqbJFI7qx+haDyEtPwTPhOF443DQ=;
        b=ak9Js0br48DtBErBlg5oUiSkfzkEWvkj80QujpO1xGC4yGYhIO6EAp/M82KSgC8HG4
         wTrcA3d+sWxhOdtkHeh3VwjezCJeyoYBPfsihdafOW1lHDv+TtzidMbDDBkELiJ6ARCS
         M4+Y3zYRpa4yIdxD0z2WtmbDjjKJ9KN60EG7G3wD66z/127CDQktfFaPQw/t/juGinCH
         IZLZxqBroIx3pJBfkb1Nyuhzlqa9T1iD6VVK3Sjcq83n2vsIjAk7QlmZyh5uxhK7qbRe
         e6Q0hL8fVaN1G2PZN4Ywy03YICbViWnsxjrBfNWPqtq+wpl4NTBtjOp3w0svkHBtTnC7
         peHg==
X-Gm-Message-State: AOJu0YxH5pUp7qZHleiiRPILUxhpFU4moYa+yQkw3+aVTGy1BG36NckN
	uSqoWok3fLa2bL3WCIVz+2X6iFXn7+ZXDfCU0JDP9d63heH//YAqcfvy0MJKh8z5BlT72t/LJHn
	EhDViMpvuUPOVj7yw80itPgAitsBbQlBMldm9f3xS8C4Dms12Txc+hHJfOvp341q+TSTmkSoht9
	O1k/jj
X-Gm-Gg: AY/fxX7pqzrTfMoU2DQe3nOYRYp4Ajh7MjLJ73bN3/wQqPA0P1FSmR/C7EtdkLYmMxM
	K7aZ3eQInaxtMk3CcjTDJ7UD4vo8ZbQBD1mQ5s8XQd9fhPld1GInz8Eh6eG4y9TVM8y+a2RpxJe
	AvcqfT5Pei4z+b8nL49z5TFqLvF3MB772biaclILcHb3I7H3/ESry7Tmf9izdjO8JwJe9Hqesgh
	2nfU1NdhDikukwzeaFF83mmQCUmQR+3QEWSqo9xEAp086vF3Tdhl7grD6tdBlX9N+6ye6cNz8aI
	O/j6tLgNmWayA9QXzey7a6fFJ2yhBI1Nt/rfZYzuC4RFwBg2qQx/9KSKHuJ8+Ve+QFj9GIQZ4tj
	5/44xwja/M4ugb9CEhIcmvoEkq7siquELvmkYB8tjNkorkfBvzs8VPsXg2nOgWxs=
X-Received: by 2002:a05:6a20:e212:b0:34a:f63:59dd with SMTP id adf61e73a8af0-3898f9ba712mr16218142637.51.1768203432032;
        Sun, 11 Jan 2026 23:37:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsb9S52hPVJ5K/uAzdEyTnpgJTw6JTQ7/Q4JNdQh4BuJioN6plEDP+I1V6h7C82yC9ErCU/w==
X-Received: by 2002:a05:6a20:e212:b0:34a:f63:59dd with SMTP id adf61e73a8af0-3898f9ba712mr16218130637.51.1768203431468;
        Sun, 11 Jan 2026 23:37:11 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:11 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:30 +0800
Subject: [PATCH ath-next v2 10/18] wifi: ath12k: support downloading
 auxiliary ucode image for QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-10-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: jpUKyVRGf6VycLcsVchRiufiXeVXRlyr
X-Authority-Analysis: v=2.4 cv=bOEb4f+Z c=1 sm=1 tr=0 ts=6964a4a9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ejwxJ43VBFfvAu_YmawA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: jpUKyVRGf6VycLcsVchRiufiXeVXRlyr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX6jtNbLWLwmQc
 FJEhon/q/xX8Lh8C5IAxfOBRLgGdyHg9MOyoD+0dCBewgk051PazYUZXZ6naR238uBUp2jtzgkf
 tjU78U1Tiq3YJ9BLOgN3nxqXCErPHX/NKjomLbALmc3hI2HvxLiwRmt0rE+M8ImyXNBS/18EUCd
 K1A3O+q7q6TlvoWUfkuPJcWHNmuVYkrRinZbUpsC5iswmAvG3PwrSQoU8y5O8UEFDOiVogWugRn
 eoq9snyNEo5dpzmLI7xLNCUCte9hHOz//cDKJ0JCSMhMt5eZRHNZ9Dus504UaYjrrSKJF7lOtSB
 ANMkS0UqsAqgHHy8UzFMUga9k9mhfPSMM9indcRKrhgYAaqgTvXjQwaj5GNtp4BXxfymeGuNMIu
 38DjYmk7zPSNi/eeKBcCTR6io25cRDx4410+coU7uu6HeAZD9w+BMQ2kcoammor5WAy9mahhLh7
 4hjbKPvzNHQEl2VukzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120058

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
index 655753d0413a..a9888e0521a1 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -78,6 +78,7 @@
 #define ATH12K_DEFAULT_CAL_FILE		"caldata.bin"
 #define ATH12K_AMSS_FILE		"amss.bin"
 #define ATH12K_M3_FILE			"m3.bin"
+#define ATH12K_AUX_UC_FILE		"aux_ucode.bin"
 #define ATH12K_REGDB_FILE_NAME		"regdb.bin"
 
 #define ATH12K_PCIE_MAX_PAYLOAD_SIZE	128
@@ -142,6 +143,7 @@ struct ath12k_hw_params {
 		size_t board_size;
 		size_t cal_offset;
 		enum ath12k_m3_fw_loaders m3_loader;
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
index ef0a59f6339c..38c388319e00 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -339,6 +339,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 128 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_driver,
+			.download_aux_ucode = false,
 		},
 		.max_radios = 1,
 		.single_pdev_only = false,
@@ -421,6 +422,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 256 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_driver,
+			.download_aux_ucode = false,
 		},
 
 		.max_radios = 1,
@@ -505,6 +507,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 128 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_driver,
+			.download_aux_ucode = false,
 		},
 		.max_radios = 2,
 		.single_pdev_only = false,
@@ -586,6 +589,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 128 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_remoteproc,
+			.download_aux_ucode = false,
 		},
 		.max_radios = 1,
 		.single_pdev_only = false,
@@ -661,6 +665,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 256 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_driver,
+			.download_aux_ucode = true,
 		},
 
 		.max_radios = 1,
@@ -707,7 +712,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.wmi_init = ath12k_wifi7_wmi_init_wcn7850,
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01) |
-					   BIT(CNSS_PCIE_PERST_NO_PULL_V01),
+					   BIT(CNSS_PCIE_PERST_NO_PULL_V01) |
+					   BIT(CNSS_AUX_UC_SUPPORT_V01),
 
 		.rfkill_pin = 0,
 		.rfkill_cfg = 0,

-- 
2.25.1


