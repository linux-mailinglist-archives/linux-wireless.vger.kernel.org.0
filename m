Return-Path: <linux-wireless+bounces-29730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA86CCBB629
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 03:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 129D83001E1D
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 02:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB2C2E6CA8;
	Sun, 14 Dec 2025 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pI+41+7z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cFLj9KC2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1622E7162
	for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765680806; cv=none; b=SRUOkorRWpd0QBXPz8AJBD6G2uLJ2j5zTEd7Yr0rIBs/M3uXsH7kyN9uk9gAUtjr65d1HpGNzPULJbbKcKsOid4o+T9jfUfQiKJH4UP4UvnTqhOZbdTxvDPXF9rh0wQG/9N9t2l7/wJzXLqzaaBwa6bvwxLOBdHYKZ+ychYt8mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765680806; c=relaxed/simple;
	bh=MO3MlrOI0tN1SexzJ0j9AAGaYHqn7NIRpEkyMm+MAxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUfJ+a6XIyZnZtMng2f6SSK4Atn8dSkO9f6zEXVoTlvMe1tr9QKW6o+bCjDFkkrUV6zBfIikbiMiK8ErE/qLlRu/Mg57DP/CpYn3XyxncO22uiv1NHMKCdJgCX71dQWstGv/OWLC5FaqcIS0nxRSPK+DalWDmnhu6ngKj2XiOTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pI+41+7z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cFLj9KC2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BE0uMKC710754
	for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 02:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0/28AV0Euwi
	hBLTp87IeykhYBs1dfdS5hG7E4DXt3fs=; b=pI+41+7zFNKV24QV/YfB3I9NcAO
	Xhtk0ovWQL6fPNqc/Rldbv/r8IWciFfVvWG+mMb0o6Arhh+5j/fxRTnk9MmRcip1
	ZPj7aBII5+GpQV7Dpj5f3QmIFR9pa/zroMU1CwKXru+3hiUattlpdHr+O19aNaZA
	HPy0AsZhBAwdGqRQgpjsjCGK0nwOOPy0i4MK23UMzzWiPebhCsGolBIZG1Chn8JS
	aBbjb+21aCpnTn2CNeZrzfKeXt62kqmWWEWVCpr5nlxmzDl8Jsi0cZCbkDToLcEz
	1iRb5X4D4HUOMVQllWLxH/yOhG6v4e87NbCFj4uoJNUNc8QyqQIjPEB8DzQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b11ds9ca1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 02:53:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-299ddb0269eso30473645ad.0
        for <linux-wireless@vger.kernel.org>; Sat, 13 Dec 2025 18:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765680802; x=1766285602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/28AV0EuwihBLTp87IeykhYBs1dfdS5hG7E4DXt3fs=;
        b=cFLj9KC2GgCazJK4TlqP3ObUXp+flgRf/blct6IsyFhIFhu0y714oEQDhJHGI/R7gx
         fanYk5ZFAGqId55yfrD3bjFQMiIF5NUMgeqPhRXhwmZhyN539N3vFt4PCDsASHGraN8K
         a3/aHQaOlTA/l3mcouqg5mc0TBIB4tU5klD75p0mlhVl6/v3D7RN3dGljyQno1s4XWX6
         94/WsEShMqpNdpDBynU3/wStbswIM8u7SN+txXrYDQ5yxRye+RBziVP8yW4tEdr6Q9e/
         BeN8TJm2CiT/SRqgY36n1Xp5sEzBb/EigSEMhy8/QsJN9uItcQ69XBb57n85DRQyUG5H
         oYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765680802; x=1766285602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0/28AV0EuwihBLTp87IeykhYBs1dfdS5hG7E4DXt3fs=;
        b=GTtFJXm5p0+/ga0UfD+/XJW+SKnDtLtu0uINA/rtqIYFqzjMlvMBbqYnp4q4qRN/nW
         jAp+mB4QOU94M3/TjaZlc0AMWhDQ1IPm5gbxC5Xk9AhN7/Gm+xGaAp62WZtA8Qreutnk
         PFmyUIh5OQvsm1FbPXZxIuyV3oWDeP07bt5eflyR2bgrS+qnF9XHSQtsZaHjLvBaUN5l
         KLkGL5Iiex0zp2urYtVwETgY7yt/pnQKAgfza7DxmlAKq+fXgrKUqP8yil5OMa13g47D
         c4J37wZDtLKLtlzHq6+BrpEAf17Cu7a7Dxq5F6cYIQNXu7cOkNvDpqfwDahXYrfiNrCA
         PDAA==
X-Forwarded-Encrypted: i=1; AJvYcCXIM2aFwvf24tfmVjM7FrQFAdiuEazISH9kyp/OUgtjBRDMMOLfxLLfPMOYTciAl3UCIZ7saPAyEvLqmCcruA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34hZvwCHFQoAqu42Z0PMyzpnJl/T+yxGLUZXFQjrNc7Jxksm3
	KDhV9P5SipcquBlXcVthX9rf4gh+ZxM/dssQ1nLUvBP03Jex3TlU78qvVQWbT+l86MKGSQOHnQu
	6j3reSdZemBH3IaT0OBlkCl3dGPql9dpNmn/vMHhzWXnrup5iyuZbtCiOvlgZTPBtXXxWeQ==
X-Gm-Gg: AY/fxX7pn8YXlpqWF998sE0wgnP8m0trLcB2Sz/0+u0IOL4RgJlvleU4AC+zNWBaAzN
	T3vJnpP3yOaUT4Z+yWB8EC4MlvgSMoMhdaQJgiWD+mnnCFySI67o/4eb+a2Gts6gJl9/zXLW/hq
	PVq8dLJTKOvK35/rE/8D8DD2+GYvcPQ1lwJR+WhHYQ7+P+AyyAQyjX355pWindqQUrKwp7GC5Lo
	SbtjN3hFBjuMQxMR7XndDTgOTEozcCQfwiwRtYWc/dI1POK0InRLSNnCpPWGx5cXYvl3q3esv1K
	P1XVnnQwWCKUzVOrfOfojbN/b8z6+0YwGZx/fAA9E5joCDMFVW+i//NnhyaR2zQh8dU3NJqRtwv
	1l0JVsK82/NdMuWKdz34z+aPt4t/pDiTKWYaz08jqhW18d6boExtXwUt176k3zixUktKt
X-Received: by 2002:a17:903:1c3:b0:268:cc5:5e4e with SMTP id d9443c01a7336-29f23de47f9mr57961915ad.1.1765680802368;
        Sat, 13 Dec 2025 18:53:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD82J143Gwteiul8EadMeaMm7d83geu6UUvxKwdal4ICJXBB+/kg1J1G/V71wv+YloxAzRsA==
X-Received: by 2002:a17:903:1c3:b0:268:cc5:5e4e with SMTP id d9443c01a7336-29f23de47f9mr57961745ad.1.1765680801906;
        Sat, 13 Dec 2025 18:53:21 -0800 (PST)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea01723bsm94148115ad.62.2025.12.13.18.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 18:53:21 -0800 (PST)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzk@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH v2 ath-current 1/2] wifi: ath11k: add usecase firmware handling based on device compatible
Date: Sun, 14 Dec 2025 10:52:29 +0800
Message-Id: <20251214025230.716387-2-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251214025230.716387-1-miaoqing.pan@oss.qualcomm.com>
References: <20251214025230.716387-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cJRU0ZSjknEbJlD8UQ4r14akLL2x9znw
X-Proofpoint-ORIG-GUID: cJRU0ZSjknEbJlD8UQ4r14akLL2x9znw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE0MDAyNSBTYWx0ZWRfX+E6PodREPrNK
 wLwc4jndlaWpK+Jyvl+lT9qw3P0BsKe1se5O4SJLfzQjvi0XN/q8CFASgNky0H2NAmyYsv9ngqq
 mOjHiev8JcTcgvRAMSO1bzYYKWbvGDl4K9xD6Bqgv63oovtAPffy7X2wyB5MazBe2daWX1Wkj1D
 Wa88VPwP0tcIYMdyb1YL2/EQw2eDFUrZsogPCqImgWL/4It8rfup08KTWyXj1TXVl1CxU1VR7w6
 yWPCPt0cgS/NJLu7EXB5+dNhJhnxjhzlVHw2tyoLI7BgM9xuss1FARhD9NT402psipTF5lVmdUg
 xIYntVPrVjnSjDEtXRFUkNM+TRcpohvNnu67GcL5TQ3OcBrzn52NWUCRydmih//BDauM22QBKCy
 hvhEnm/5sQZbRI20Cfvw8k0D/euMQw==
X-Authority-Analysis: v=2.4 cv=cfLfb3DM c=1 sm=1 tr=0 ts=693e26a3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=abYA0IzpRIpkkFLbjSYA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512140025

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
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
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


