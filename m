Return-Path: <linux-wireless+bounces-29485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B27ACA299E
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 08:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB0F4301E214
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 07:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4BB21CC5A;
	Thu,  4 Dec 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g699UPge";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LbJOTM16"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FC528488D
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764832279; cv=none; b=ahyFmKNbQfhxE+9mgL8VQwgwsFpeY1ZNVgub+7Gq4QYpfWGrQJyRHbIHm9r1+N7TBcEhkffz6xH825e4ys5BKhdVF6N2srH5EWS0VDBpPgYZQQm19bTqMDQWYxW/NZZ6qtQXhWaUYZDIySOyOi/uuaL5Whd/bMm1ebCU/AvxO7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764832279; c=relaxed/simple;
	bh=2wVXeLWe3ZnDp4/vITX1AjAmqZE9UuKve3+vH8//3Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3WqgsBNYZBC1vdzlH8+OiSutzYruxWyoczIisLdkcD/I/QYO/48jrkcshwRDoT5cbkKkQdX+9Bg1psBXfDrIi3Vjdg1kwdrxZFhN41xwENJ65kmJuuZvXOpbP60yT2moh2EMNcZJHOqtaDA61XQnmMWq88EtMIfJDxIaw/6XYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g699UPge; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LbJOTM16; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4692pI735453
	for <linux-wireless@vger.kernel.org>; Thu, 4 Dec 2025 07:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=w+Yt+b8q8Vj
	xvzQ2cWX0SzX2S2I2lHz/ZTVgM/PTf5I=; b=g699UPgee6rpPlKYIFmSLUSMWZI
	MuQWa8FPTVolJHpm88IBtaYuLFaIQndvzXhA2oHtR0Ahb77VOtkhXUhKu5AzK2TK
	BO9o4EdY57haEl76uforGRDZt6PiEJtcGgIbG37UdT4yEGstsk0Wo5OoCTkQ7/kH
	wdE7kWBNZedfzpMF/MpxuUGeXX6GM2NTd3JxJXqoeF+RVpYK0b8zgBBQUbcPVXE/
	44vHWlAXVRC0w1+gcZclZKuIPCtsmHxweIte97ZacXNovp1JdmEfwyNaoEfbKhpy
	4eNPkujo2ykPllmhdSgEWEdk1Lg/QGCKAkB90nn25dVzFCZiaRxdNdsoing==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atr7yjcm2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 04 Dec 2025 07:11:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so648052b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Dec 2025 23:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764832276; x=1765437076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+Yt+b8q8VjxvzQ2cWX0SzX2S2I2lHz/ZTVgM/PTf5I=;
        b=LbJOTM16g+ogTMY2Qhkoywq4IKuWitK9/tpoqBBM2Unp8HM2ffN2I9uLrFZ8dkjws7
         K5iQJaCv+qlHPuAhv/UHbOe7wEsWpaoAARB6qFiMk3yYN8s/FdFfNPTmtyfdRaEocs1c
         Cos7t7RbVqe8yTzr6CQsM+WplYLJjaWjvsjgMSs8qJgZpNTzwfB6N7UrZQz95SDC7ObR
         7lb6TnQ0eTSBs8Xt3q8qhb/ICZR/rvwDh81iv98nTkoPJMY0GHRpkVNleb55NLrkeFys
         OToewoJIy7AifsLgYueAjngWyN6It+nzrBnb/XRV1tb8283KNBqREBC6gAdg2WS4EJBW
         H83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764832276; x=1765437076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+Yt+b8q8VjxvzQ2cWX0SzX2S2I2lHz/ZTVgM/PTf5I=;
        b=YPj2Dt5I5l9pMh0WjyOeBgRxQ+tPb5vyvnzAukZfhCav//L+ZvL1900p7upvO9xhZS
         /u0z9QqbxlKy6TqNL6afCQYbpO7BtEMhJ818p+b0hRoz1YGXTVXW54C5e1BRoiYtudsr
         LOB+fvSPpOvYh9Im3XimUl32GAta/uyNDndl6ruL41oJWq36nPwf67KR9H9SC491IQG3
         ogQjjl57IXkZ4oAOUvLMuQiVWmCKywOtjxrtodCN4HuQIqG361J2Q/UUJ0V7BAcDx9NW
         X18RCGIXOJMaCNgE5yLLvmgIRacAN7mdRxF4R03hEzYec5Yp1XczPNYOCo7NfUENOPBy
         ckqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoyMJqXS671lRtv+rCbXLlFLjiMh6bEV8ZOv/juORILsNYbI9PrOaLAxRfansNoVkNX+0Gh/RfQWeOyw1p3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvG8dN+ZMfij4rkTc3LPrWGn+1P5uoot4gbTsR3Vv6QMKNF7MO
	TjEiSUbBm9YdFMvvoJ7Di/zy4p4ZlcDWjZW5VVdkwIB7C750442fi/4+1bcsxfoLHOJo19qVLWg
	+BIwkeIliLskrA3Vf5ofDd8u1cLewsIdK0ANK+IKZEu2wK8YmCBC/lPtD3Hm4tdfnYDJzCA==
X-Gm-Gg: ASbGnctpk25aTxGkgn4xgUZotemCngCpW3fopv9k0T+SXrgAnrrr8XADtnjJW9dZz0w
	7oKoY4rx4JWriStnE0oD2jUyVu+POAbyIwvE6TbNqJIe2m+pkSnZiWzsUeSDdkNeiIOdON2hBjn
	Ne6j29evO6hQOWpWWhD4MxdxeA5vnphPIZ+Ba85Uzz7475GRot+cdDIMSptKvji3EaGHY8IOPca
	BqirM0ibNO63DFPjEY2GXuVOiSQA4XfCdjNPrlWK9gFDIodZ+SYLLaViGd7RA/k9Tvf7sGRQUKF
	W2+Vul3sQLSiv/0GJee5doOZpkxj1cvfWJzwlq21n57mPX8+Du6Hg0GEXypXBj+s47xj39XGHRX
	e5aJPW6dwN9MUiLtV7rso8vXHsaSRuX/PnONi6K+wxjDIRL91bj9IHf0rVd+j+SZMtbbb
X-Received: by 2002:a05:6a00:2e9f:b0:7a5:9cf5:b341 with SMTP id d2e1a72fcca58-7e2259ddfcemr2440413b3a.7.1764832275677;
        Wed, 03 Dec 2025 23:11:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdjjjpA4rf37aA7kTwgkuuiTsJYAC1y4NmUcAkrMaRDWq3DGig0k1Wx+gXs04GDeqg0OKrqg==
X-Received: by 2002:a05:6a00:2e9f:b0:7a5:9cf5:b341 with SMTP id d2e1a72fcca58-7e2259ddfcemr2440381b3a.7.1764832275193;
        Wed, 03 Dec 2025 23:11:15 -0800 (PST)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ed331sm1117470b3a.4.2025.12.03.23.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 23:11:14 -0800 (PST)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-current 1/2] wifi: ath11k: add usecase firmware handling based on device compatible
Date: Thu,  4 Dec 2025 15:10:59 +0800
Message-Id: <20251204071100.970518-2-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251204071100.970518-1-miaoqing.pan@oss.qualcomm.com>
References: <20251204071100.970518-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Q32Myv9D4Gfw-JDI1hPmhJghQxUGJ7g5
X-Proofpoint-GUID: Q32Myv9D4Gfw-JDI1hPmhJghQxUGJ7g5
X-Authority-Analysis: v=2.4 cv=ZMTaWH7b c=1 sm=1 tr=0 ts=69313414 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=abYA0IzpRIpkkFLbjSYA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA1NyBTYWx0ZWRfX1vj0g1yf2FZx
 SlJF0Js76FVW4gxsep3sz51Rtgd6MxHIbHYcKBw5PqPZRlL0BECNWwGAwZMYGHRcG1jL8XNdQ+R
 ZkSag1fag69lTDEAjsXVpuTS+LIhJ8TLcVlO1nGYPqFFXFCSZ4OSIgdpShZpvwTgScasVpYrbjg
 2xHLKg6rMasHv4euykhiFuc3OfDixkRALjQJmmqtuZpcJC71t2S3NRxRR1trds/x6LInEDgKYfy
 lmqyPkY97pE7bCEE+LBSs68JdB4bc818Ovv8xjUvKfl7ngtqBN0KnJQhb3IrfAAqG6fzg9IHNST
 HB4Z8UJG1Oglg6pg6+yGDhsR6Xj7wOaKALHAcp1411hiTBTrF+4hVDdRcMvOkHpKAvboH+f2eyX
 ieFhhpHZoD6qHTIN0zh70q0tipls0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512040057

For M.2 WLAN chips, there is no suitable DTS node to specify the
firmware-name property. In addition, assigning firmware for the
M.2 PCIe interface causes chips that do not use usecase specific
firmware to fail. Therefore, abandoning the approach of specifying
firmware in DTS. As an alternative, propose a static lookup table
mapping device compatible to firmware names. Currently, only WCN6855
HW2.1 requires this.

For details on usecase specific firmware, see:
https://lore.kernel.org/all/20250522013444.1301330-3-miaoqing.pan@oss.qualcomm.com/.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Fixes: edbbc647c4f3 ("wifi: ath11k: support usercase-specific firmware overrides")
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 37 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/core.h |  7 +++--
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 812686173ac8..a4a3a65c7752 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -997,6 +996,42 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 	{}
 };
 
+static const struct __ath11k_core_usecase_firmware_table {
+	u32 hw_rev;
+	const char *compatible;
+	const char *firmware_name;
+} ath11k_core_usecase_firmware_table[] = {
+	{ ATH11K_HW_WCN6855_HW21, "qcom,lemans-evk", "nfa765"},
+	{ ATH11K_HW_WCN6855_HW21, "qcom,monaco-evk", "nfa765"},
+	{ ATH11K_HW_WCN6855_HW21, "qcom,hamoa-iot-evk", "nfa765"},
+	{ /* Sentinel */ }
+};
+
+const char *ath11k_core_get_usecase_firmware(struct ath11k_base *ab)
+{
+	struct device_node *root __free(device_node) = of_find_node_by_path("/");
+	const struct __ath11k_core_usecase_firmware_table *entry = NULL;
+	int i, count = of_property_count_strings(root, "compatible");
+	const char *compatible = NULL;
+
+	for (i = 0; i < count; i++) {
+		if (of_property_read_string_index(root, "compatible", i,
+						  &compatible) < 0)
+			continue;
+
+		entry = ath11k_core_usecase_firmware_table;
+		while (entry->compatible) {
+			if (ab->hw_rev == entry->hw_rev &&
+			    !strcmp(entry->compatible, compatible))
+				return entry->firmware_name;
+			entry++;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(ath11k_core_get_usecase_firmware);
+
 void ath11k_fw_stats_pdevs_free(struct list_head *head)
 {
 	struct ath11k_fw_stats_pdev *i, *tmp;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index e8780b05ce11..f8fcd897ebd2 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_CORE_H
@@ -1275,6 +1275,7 @@ bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
+const char *ath11k_core_get_usecase_firmware(struct ath11k_base *ab);
 
 static inline const char *ath11k_scan_state_str(enum ath11k_scan_state state)
 {
@@ -1325,9 +1326,7 @@ static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
 						    const char *filename,
 						    void *buf, size_t buf_len)
 {
-	const char *fw_name = NULL;
-
-	of_property_read_string(ab->dev->of_node, "firmware-name", &fw_name);
+	const char *fw_name = ath11k_core_get_usecase_firmware(ab);
 
 	if (fw_name && strncmp(filename, "board", 5))
 		snprintf(buf, buf_len, "%s/%s/%s/%s", ATH11K_FW_DIR,
-- 
2.34.1


