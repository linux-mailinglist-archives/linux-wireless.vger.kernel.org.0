Return-Path: <linux-wireless+bounces-25689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12A1B0B69A
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jul 2025 17:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FBC179615
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jul 2025 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB28E21C19D;
	Sun, 20 Jul 2025 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2LCQ5LU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497521B9E0
	for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753024428; cv=none; b=A35xFqRZ56E8KjDq8EE54YtTUT5e8vMg86OUs+CKWD19TjdDPkAq05Y/DsYbrwd/u/oQWkkBPUOw2Gay6wzUySkC96LVbYb39dKiFF/YmYm6l9CSKhdC3cQ1krfjZ3ttbk8NuKRsERxKbr0pTmaWFLKcFYovHXPKmtcxW9K4hDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753024428; c=relaxed/simple;
	bh=526Jai4s60kIZ1iH86FHqSAbsAjWvOd3JlzbeKQ0NhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eMkbdoJGRMnKBvXOjD6OvLLjRw+9+DwO3dpQRDR+BJI/bbQbYj26taeAT2HAGUnZcRj0BGJkIN3ZUDRP1dqLR7hG1VvanzL/KxlRIXio/0O9bXONYfXRKNEVDXimfEoM/xBunWNAVSd5KvI0YjMmcBwiLTNG9Z2vkRL9jwmo6wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i2LCQ5LU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KEUneQ018577
	for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 15:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bGS33vXyOfmTr6Nm2wmouB
	PbI3ZQhgCdsd9UV32jeOs=; b=i2LCQ5LUd2G2/vhD+RJ+Izb0swJreqtLXi2RwG
	ZEnfCX48eZO9xh62Sa4XkxpPu9pGPdQ9DTwjESHiOzqBqo2axfXv+W6btehd/xan
	TKyDBxYEYPNFoSTiHr7Fdfe4tX+NlZSLxK0d9usv8ak4eFq0UnLHh0qfJ/W9gfhU
	pjSIaRgodj640adWGi+tEYbrg6zyNbeuxi7HbAiymFjOjG8JYax9n0S07WTh0q+v
	+srwFokPOn9Vb1nHn2zXgHAi2KMst2tS5EJGRC8VwolvQUH1JUBHE8RGBbeGD19s
	Ft5y43kJEaqNySIhRFQECgS/nwzMfuPuNpvecPtUHJDMfheQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dacgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 15:13:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b321087b1cdso4046439a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 08:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753024422; x=1753629222;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGS33vXyOfmTr6Nm2wmouBPbI3ZQhgCdsd9UV32jeOs=;
        b=K72jfH32IK+JxIjXk3xcxbDOouDfANwkRCdq1Hh/5ozo4drUUd1BxX4fMXiW9Ym4kF
         mGMK+uaGwhRLVSIyuo8oZgDfrwrw3kw5d1GTQ4hXHVaq4kZ4jaoO5l1zSNw8YBONPUGl
         Lip0RbU6OuayV924y5Swlzj7TRmNASs/20MEKgIxNmCCQ8WNRoABj0RK5v0V4/8uSH4h
         i+/RgowMi9wpDg47zwcMjnCC78mSL66iCFFovhlJku9ZU1GQQzsx73EfHF1vpFzArBfi
         Il172L2LRDe5SKP/f+QF2iQpACGrmK0KHd2TyyalpfjKhq2TVdEd0cbWbdqBIa1y9hxy
         Fxew==
X-Gm-Message-State: AOJu0YxP1EGvHUX/FOVrf5CwQcAb1PeZRJHryKchERCiT4xbuAVs3Wca
	y5/xxbIp8HpzE0CLUjT8PqSGE4T0UgOMAy9Ygft2zgPix7obw/FKGJlvTrezjTV+Oj96Sg+ivlR
	bW4e0C/f+FE7s9eP6AIijrM+C1xM0JWUXN0J8TPu584q0THegrwAyc+s62Oz7OQZaYGeVAcXmNC
	gGhw==
X-Gm-Gg: ASbGncvH8/mlf+Q03QYEJlwI/Byn5SIRCzHQiUxJENzvMj1LNb2Qswud7VgzPL4RBpg
	2KSeKBC9g1EuquDhu5CfgOiCVAy3Rfh6a0FPxwHfxoXVEBKbM2ndMAvMjne0WCVY8PVGNbGjonM
	qQKAr3QbGGWqFBLJB9xybQj4RXPxcgjuu3O64+o8dwNoGwnQGnmobSjk+bgYPH5ogqVwB7+Os5g
	g2VyAkmcIYqnM6+qih8ic6Qdg8+qrXHEeu8T2QScIzr2RqOuvGoJ1cpYVSUASHOYYyo1fYJqTli
	vSRTWssTdLZVUtcMqVT7dLy0LlfFdYyX5SEZGUHXQgH9An21KFqsgBkfcLO9lKCOefm4IOnbkrm
	3
X-Received: by 2002:a05:6300:6406:b0:238:3f64:41a6 with SMTP id adf61e73a8af0-2383f6447afmr19828970637.46.1753024421375;
        Sun, 20 Jul 2025 08:13:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1dF4NF8PF5jbyRkC0b5tDB9aaY7AeK94LzEXX60Ps66yQXROIVBPwmw69CJDbCfbt5bF4Iw==
X-Received: by 2002:a05:6300:6406:b0:238:3f64:41a6 with SMTP id adf61e73a8af0-2383f6447afmr19828945637.46.1753024420718;
        Sun, 20 Jul 2025 08:13:40 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c5b0f748sm4234882b3a.0.2025.07.20.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 08:13:40 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 08:13:38 -0700
Subject: [PATCH ath-next] wifi: ath11k: Prefer {} to {0} in initializers
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ath11k-zero-brace-v1-1-6132e2ef1748@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKEHfWgC/32NwQ6CMBBEf4Xs2SUs0Iie/A/DYWkXaRSqLTYo4
 d9t+AAvk0xm5s0KQbyVAOdsBS/RBuumZOiQgR54uglakzyURamKIzXI80B0x694h51nLVicFJc
 N16wVQdo9vfR22ZlXSHWcZJmhTclgw+z8Zz+LtOd/uJGQsCKWvjJNp2pzcSHkrzc/tBvHPAm02
 7b9ANH5fCPDAAAA
X-Change-ID: 20250718-ath11k-zero-brace-095a28a4ac51
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687d07a7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=IrOtqnWkbUC1Rw5qywYA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: awiPW7pssjuSevk-52qJC095NN08d35A
X-Proofpoint-ORIG-GUID: awiPW7pssjuSevk-52qJC095NN08d35A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE0NyBTYWx0ZWRfXxVwX82bZ66J1
 lRuw5Orf7XrJRZSFeTHo1oGpuhAI9UkC7naHBImgzW3iuloQ8qwaC+0caicrmheOd1UTaKWmfKu
 oW0vpnIfa7QhiZwjslHiRvQRCjXb49f+bHVpBS1ak5hXezOqSEMOFgM5owHUun1pq+FgNe2Fi2w
 Mlz9GFbdRIlRs3OOr2dnT1rhEJwkqy/6jZNX86mfyWXQj8TZhtnjYyG90OUrOAhtpRB2AR/f2I7
 oB7CiYSoFaYfFMu1u8jO3mNp4ZrW0+R6bUF5ubmZcXXm/cWppIwHZWusB5o848b0YGmxGcU1YlN
 +XlAQ17CYeW6j4AVyfgLVn/fTxpEOv+LyJrjxHJTUdVLyWngqGSNF6eEIs+MXnQCvo9hGBl9eVz
 aR7gxrYOvIUglWzwLZDtt4PGC40t0NQwbiozgr6ZzOzs+YwQdGf6upxoYtMzdjLAjBfcDxdZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200147

Prefer {} to {0} in initializers since {} works even when the first
member is not a scalar.

Generated using:
sed -i 's/{[[:space:]]*0[[:space:]]*}/{}/g' drivers/net/wireless/ath/ath11k/*

Compile tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c              |  2 +-
 drivers/net/wireless/ath/ath11k/ce.c               |  2 +-
 drivers/net/wireless/ath/ath11k/core.c             |  2 +-
 drivers/net/wireless/ath/ath11k/dbring.c           |  3 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          | 38 +++++++++++-----------
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    | 15 +++++----
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      | 11 ++++---
 drivers/net/wireless/ath/ath11k/dp.c               |  2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            | 20 ++++++------
 drivers/net/wireless/ath/ath11k/dp_tx.c            | 15 +++++----
 drivers/net/wireless/ath/ath11k/mac.c              | 16 ++++-----
 drivers/net/wireless/ath/ath11k/pci.c              |  4 +--
 drivers/net/wireless/ath/ath11k/spectral.c         |  3 +-
 drivers/net/wireless/ath/ath11k/wmi.c              | 12 +++----
 14 files changed, 75 insertions(+), 70 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index fde1ce43c4994ea75afd8170f08f9af482180fcf..50809cc1dad448e116e21ee642dc0079d1ceb759 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -988,7 +988,7 @@ static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
 	struct device *host_dev = ab->dev;
-	struct platform_device_info info = {0};
+	struct platform_device_info info = {};
 	struct iommu_domain *iommu_dom;
 	struct platform_device *pdev;
 	struct device_node *node;
diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index 878ce30b307c8c492cb3911dde478bca112b8a8b..c65fc9fb539ef10ba44f1c1d5571462b40fa098d 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -554,7 +554,7 @@ static int ath11k_ce_init_ring(struct ath11k_base *ab,
 			       struct ath11k_ce_ring *ce_ring,
 			       int ce_id, enum hal_ring_type type)
 {
-	struct hal_srng_params params = { 0 };
+	struct hal_srng_params params = {};
 	int ret;
 
 	params.ring_base_paddr = ce_ring->base_addr_ce_space;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index ad942fad01e95a49d9e44c293d8bb84cba2f3903..d49353b6b2e7657daaccae640a40772d95a30c03 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1393,7 +1393,7 @@ static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 					   enum ath11k_bdf_name_type name_type)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
-	char variant[9 + ATH11K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
+	char variant[9 + ATH11K_QMI_BDF_EXT_STR_LENGTH] = {};
 
 	if (with_variant && ab->qmi.target.bdf_ext[0] != '\0')
 		scnprintf(variant, sizeof(variant), ",variant=%s",
diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index fbb6e8d8a47692139c193348bdd5e58ae395e416..520d8b8662a282ca3ba396b3941d6155fd5ca353 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
@@ -153,7 +154,7 @@ int ath11k_dbring_wmi_cfg_setup(struct ath11k *ar,
 				struct ath11k_dbring *ring,
 				enum wmi_direct_buffer_module id)
 {
-	struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd param = {0};
+	struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd param = {};
 	int ret;
 
 	if (id >= WMI_DIRECT_BUF_MAX)
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 906df3b13f4f0a84a76c71d336bb5c16f9477aba..977f945b6e669e48df6df5926805b768172452d9 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -375,7 +375,7 @@ static ssize_t ath11k_write_simulate_fw_crash(struct file *file,
 	struct ath11k_base *ab = file->private_data;
 	struct ath11k_pdev *pdev;
 	struct ath11k *ar = ab->pdevs[0].ar;
-	char buf[32] = {0};
+	char buf[32] = {};
 	ssize_t rc;
 	int i, ret, radioup = 0;
 
@@ -473,7 +473,7 @@ static ssize_t ath11k_read_enable_extd_tx_stats(struct file *file,
 						size_t count, loff_t *ppos)
 
 {
-	char buf[32] = {0};
+	char buf[32] = {};
 	struct ath11k *ar = file->private_data;
 	int len = 0;
 
@@ -497,7 +497,7 @@ static ssize_t ath11k_write_extd_rx_stats(struct file *file,
 {
 	struct ath11k *ar = file->private_data;
 	struct ath11k_base *ab = ar->ab;
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	u32 enable, rx_filter = 0, ring_id;
 	int i;
 	int ret;
@@ -737,7 +737,7 @@ static ssize_t ath11k_write_fw_dbglog(struct file *file,
 				      size_t count, loff_t *ppos)
 {
 	struct ath11k *ar = file->private_data;
-	char buf[128] = {0};
+	char buf[128] = {};
 	struct ath11k_fw_dbglog dbglog;
 	unsigned int param, mod_id_index, is_end;
 	u64 value;
@@ -950,9 +950,9 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 {
 	struct ath11k *ar = file->private_data;
 	struct ath11k_base *ab = ar->ab;
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	u32 rx_filter = 0, ring_id, filter, mode;
-	u8 buf[128] = {0};
+	u8 buf[128] = {};
 	int i, ret, rx_buf_sz = 0;
 	ssize_t rc;
 
@@ -1081,7 +1081,7 @@ static ssize_t ath11k_read_pktlog_filter(struct file *file,
 					 size_t count, loff_t *ppos)
 
 {
-	char buf[32] = {0};
+	char buf[32] = {};
 	struct ath11k *ar = file->private_data;
 	int len = 0;
 
@@ -1235,7 +1235,7 @@ static ssize_t ath11k_debugfs_write_enable_dbr_dbg(struct file *file,
 						   size_t count, loff_t *ppos)
 {
 	struct ath11k *ar = file->private_data;
-	char buf[32] = {0};
+	char buf[32] = {};
 	u32 dbr_id, enable;
 	int ret;
 
@@ -1473,7 +1473,7 @@ int ath11k_debugfs_register(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
 	char pdev_name[10];
-	char buf[100] = {0};
+	char buf[100] = {};
 
 	snprintf(pdev_name, sizeof(pdev_name), "%s%u", "mac", ar->pdev_idx);
 
@@ -1556,10 +1556,10 @@ static ssize_t ath11k_write_twt_add_dialog(struct file *file,
 					   size_t count, loff_t *ppos)
 {
 	struct ath11k_vif *arvif = file->private_data;
-	struct wmi_twt_add_dialog_params params = { 0 };
-	struct wmi_twt_enable_params twt_params = {0};
+	struct wmi_twt_add_dialog_params params = {};
+	struct wmi_twt_enable_params twt_params = {};
 	struct ath11k *ar = arvif->ar;
-	u8 buf[128] = {0};
+	u8 buf[128] = {};
 	int ret;
 
 	if (ar->twt_enabled == 0) {
@@ -1632,10 +1632,10 @@ static ssize_t ath11k_write_twt_del_dialog(struct file *file,
 					   size_t count, loff_t *ppos)
 {
 	struct ath11k_vif *arvif = file->private_data;
-	struct wmi_twt_del_dialog_params params = { 0 };
-	struct wmi_twt_enable_params twt_params = {0};
+	struct wmi_twt_del_dialog_params params = {};
+	struct wmi_twt_enable_params twt_params = {};
 	struct ath11k *ar = arvif->ar;
-	u8 buf[64] = {0};
+	u8 buf[64] = {};
 	int ret;
 
 	if (ar->twt_enabled == 0) {
@@ -1679,8 +1679,8 @@ static ssize_t ath11k_write_twt_pause_dialog(struct file *file,
 					     size_t count, loff_t *ppos)
 {
 	struct ath11k_vif *arvif = file->private_data;
-	struct wmi_twt_pause_dialog_params params = { 0 };
-	u8 buf[64] = {0};
+	struct wmi_twt_pause_dialog_params params = {};
+	u8 buf[64] = {};
 	int ret;
 
 	if (arvif->ar->twt_enabled == 0) {
@@ -1718,8 +1718,8 @@ static ssize_t ath11k_write_twt_resume_dialog(struct file *file,
 					      size_t count, loff_t *ppos)
 {
 	struct ath11k_vif *arvif = file->private_data;
-	struct wmi_twt_resume_dialog_params params = { 0 };
-	u8 buf[64] = {0};
+	struct wmi_twt_resume_dialog_params params = {};
+	u8 buf[64] = {};
 	int ret;
 
 	if (arvif->ar->twt_enabled == 0) {
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index 870e86a31bf8962eea455986c9aa9d4922b14b40..11d28c42227efaba2152465a21bd6570286acb99 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/vmalloc.h>
@@ -375,7 +376,7 @@ static inline void htt_print_hw_stats_intr_misc_tlv(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char hw_intr_name[HTT_STATS_MAX_HW_INTR_NAME_LEN + 1] = {0};
+	char hw_intr_name[HTT_STATS_MAX_HW_INTR_NAME_LEN + 1] = {};
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_HW_STATS_INTR_MISC_TLV:\n");
 	memcpy(hw_intr_name, &(htt_stats_buf->hw_intr_name[0]),
@@ -402,7 +403,7 @@ htt_print_hw_stats_wd_timeout_tlv(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char hw_module_name[HTT_STATS_MAX_HW_MODULE_NAME_LEN + 1] = {0};
+	char hw_module_name[HTT_STATS_MAX_HW_MODULE_NAME_LEN + 1] = {};
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_HW_STATS_WD_TIMEOUT_TLV:\n");
 	memcpy(hw_module_name, &(htt_stats_buf->hw_module_name[0]),
@@ -514,7 +515,7 @@ static inline void htt_print_tx_tid_stats_tlv(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
+	char tid_name[MAX_HTT_TID_NAME + 1] = {};
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TID_STATS_TLV:\n");
 	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
@@ -567,7 +568,7 @@ static inline void htt_print_tx_tid_stats_v1_tlv(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
+	char tid_name[MAX_HTT_TID_NAME + 1] = {};
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TID_STATS_V1_TLV:\n");
 	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
@@ -624,7 +625,7 @@ static inline void htt_print_rx_tid_stats_tlv(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
+	char tid_name[MAX_HTT_TID_NAME + 1] = {};
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_RX_TID_STATS_TLV:\n");
 	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %lu\n",
@@ -4712,7 +4713,7 @@ int ath11k_debugfs_htt_stats_req(struct ath11k *ar)
 	u8 type = stats_req->type;
 	u64 cookie = 0;
 	int ret, pdev_id = ar->pdev->pdev_id;
-	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+	struct htt_ext_stats_cfg_params cfg_params = {};
 
 	init_completion(&stats_req->cmpln);
 
@@ -4852,7 +4853,7 @@ static ssize_t ath11k_write_htt_stats_reset(struct file *file,
 {
 	struct ath11k *ar = file->private_data;
 	u8 type;
-	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+	struct htt_ext_stats_cfg_params cfg_params = {};
 	int ret;
 
 	ret = kstrtou8_from_user(user_buf, count, 0, &type);
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index f56a24b6c8da21ef522dc0ece75fdbbb0a29fe8e..d89d0f28d890b4d8d69f8d4a56788cf148e4a27d 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/vmalloc.h>
@@ -456,7 +457,7 @@ static ssize_t ath11k_dbg_sta_read_peer_pktlog(struct file *file,
 	struct ieee80211_sta *sta = file->private_data;
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
-	char buf[32] = {0};
+	char buf[32] = {};
 	int len;
 
 	mutex_lock(&ar->conf_mutex);
@@ -485,7 +486,7 @@ static ssize_t ath11k_dbg_sta_write_delba(struct file *file,
 	struct ath11k *ar = arsta->arvif->ar;
 	u32 tid, initiator, reason;
 	int ret;
-	char buf[64] = {0};
+	char buf[64] = {};
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
 				     user_buf, count);
@@ -536,7 +537,7 @@ static ssize_t ath11k_dbg_sta_write_addba_resp(struct file *file,
 	struct ath11k *ar = arsta->arvif->ar;
 	u32 tid, status;
 	int ret;
-	char buf[64] = {0};
+	char buf[64] = {};
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
 				     user_buf, count);
@@ -586,7 +587,7 @@ static ssize_t ath11k_dbg_sta_write_addba(struct file *file,
 	struct ath11k *ar = arsta->arvif->ar;
 	u32 tid, buf_size;
 	int ret;
-	char buf[64] = {0};
+	char buf[64] = {};
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
 				     user_buf, count);
@@ -700,7 +701,7 @@ ath11k_write_htt_peer_stats_reset(struct file *file,
 	struct ieee80211_sta *sta = file->private_data;
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
-	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+	struct htt_ext_stats_cfg_params cfg_params = {};
 	int ret;
 	u8 type;
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 4661e0d64dd979ea0ec23fedd10d7c1ec91b141f..56b1a657e0b0f131c178e14d8ed60b28d814f04d 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -225,7 +225,7 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 			 enum hal_ring_type type, int ring_num,
 			 int mac_id, int num_entries)
 {
-	struct hal_srng_params params = { 0 };
+	struct hal_srng_params params = {};
 	int entry_sz = ath11k_hal_srng_get_entrysize(ab, type);
 	int max_entries = ath11k_hal_srng_get_max_entries(ab, type);
 	int ret;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 1eec1cc114febe79f4b345f55bdbb3ad1f184d1b..ffc7482c77b6f4974fedd50698d2f7600c1a65c5 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -719,7 +719,7 @@ static void ath11k_dp_reo_cmd_free(struct ath11k_dp *dp, void *ctx,
 static void ath11k_dp_reo_cache_flush(struct ath11k_base *ab,
 				      struct dp_rx_tid *rx_tid)
 {
-	struct ath11k_hal_reo_cmd cmd = {0};
+	struct ath11k_hal_reo_cmd cmd = {};
 	unsigned long tot_desc_sz, desc_sz;
 	int ret;
 
@@ -811,7 +811,7 @@ static void ath11k_dp_rx_tid_del_func(struct ath11k_dp *dp, void *ctx,
 void ath11k_peer_rx_tid_delete(struct ath11k *ar,
 			       struct ath11k_peer *peer, u8 tid)
 {
-	struct ath11k_hal_reo_cmd cmd = {0};
+	struct ath11k_hal_reo_cmd cmd = {};
 	struct dp_rx_tid *rx_tid = &peer->rx_tid[tid];
 	int ret;
 
@@ -938,7 +938,7 @@ static int ath11k_peer_rx_tid_reo_update(struct ath11k *ar,
 					 u32 ba_win_sz, u16 ssn,
 					 bool update_ssn)
 {
-	struct ath11k_hal_reo_cmd cmd = {0};
+	struct ath11k_hal_reo_cmd cmd = {};
 	int ret;
 
 	cmd.addr_lo = lower_32_bits(rx_tid->paddr);
@@ -1157,7 +1157,7 @@ int ath11k_dp_peer_rx_pn_replay_config(struct ath11k_vif *arvif,
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_hal_reo_cmd cmd = {0};
+	struct ath11k_hal_reo_cmd cmd = {};
 	struct ath11k_peer *peer;
 	struct dp_rx_tid *rx_tid;
 	u8 tid;
@@ -2591,7 +2591,7 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 {
 	struct sk_buff *msdu;
 	struct ath11k *ar;
-	struct ieee80211_rx_status rx_status = {0};
+	struct ieee80211_rx_status rx_status = {};
 	int ret;
 
 	if (skb_queue_empty(msdu_list))
@@ -2626,7 +2626,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 {
 	struct ath11k_dp *dp = &ab->dp;
 	struct dp_rxdma_ring *rx_ring;
-	int num_buffs_reaped[MAX_RADIOS] = {0};
+	int num_buffs_reaped[MAX_RADIOS] = {};
 	struct sk_buff_head msdu_list[MAX_RADIOS];
 	struct ath11k_skb_rxcb *rxcb;
 	int total_msdu_reaped = 0;
@@ -3224,7 +3224,7 @@ static int ath11k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
 				      size_t data_len, u8 *mic)
 {
 	SHASH_DESC_ON_STACK(desc, tfm);
-	u8 mic_hdr[16] = {0};
+	u8 mic_hdr[16] = {};
 	u8 tid = 0;
 	int ret;
 
@@ -3818,7 +3818,7 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
 	struct dp_link_desc_bank *link_desc_banks;
 	enum hal_rx_buf_return_buf_manager rbm;
 	int tot_n_bufs_reaped, quota, ret, i;
-	int n_bufs_reaped[MAX_RADIOS] = {0};
+	int n_bufs_reaped[MAX_RADIOS] = {};
 	struct dp_rxdma_ring *rx_ring;
 	struct dp_srng *reo_except;
 	u32 desc_bank, num_msdus;
@@ -4099,7 +4099,7 @@ static void ath11k_dp_rx_wbm_err(struct ath11k *ar,
 				 struct sk_buff_head *msdu_list)
 {
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
-	struct ieee80211_rx_status rxs = {0};
+	struct ieee80211_rx_status rxs = {};
 	bool drop = true;
 
 	switch (rxcb->err_rel_src) {
@@ -4135,7 +4135,7 @@ int ath11k_dp_rx_process_wbm_err(struct ath11k_base *ab,
 	struct ath11k_skb_rxcb *rxcb;
 	u32 *rx_desc;
 	int buf_id, mac_id;
-	int num_buffs_reaped[MAX_RADIOS] = {0};
+	int num_buffs_reaped[MAX_RADIOS] = {};
 	int total_num_buffs_reaped = 0;
 	int ret, i;
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8522c67baabf41492e126f7faefc439a3135f885..562aba66582f3eb534a81485bff2b807cdda0ac9 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
@@ -84,7 +85,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 {
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_dp *dp = &ab->dp;
-	struct hal_tx_info ti = {0};
+	struct hal_tx_info ti = {};
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB(skb);
 	struct hal_srng *tcl_ring;
@@ -316,7 +317,7 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 				 struct dp_tx_ring *tx_ring,
 				 struct ath11k_dp_htt_wbm_tx_status *ts)
 {
-	struct ieee80211_tx_status status = { 0 };
+	struct ieee80211_tx_status status = {};
 	struct sk_buff *msdu;
 	struct ieee80211_tx_info *info;
 	struct ath11k_skb_cb *skb_cb;
@@ -391,7 +392,7 @@ ath11k_dp_tx_process_htt_tx_complete(struct ath11k_base *ab,
 				     u32 msdu_id, struct dp_tx_ring *tx_ring)
 {
 	struct htt_tx_wbm_completion *status_desc;
-	struct ath11k_dp_htt_wbm_tx_status ts = {0};
+	struct ath11k_dp_htt_wbm_tx_status ts = {};
 	enum hal_wbm_htt_tx_comp_status wbm_status;
 
 	status_desc = desc + HTT_TX_WBM_COMP_STATUS_OFFSET;
@@ -551,8 +552,8 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 				       struct sk_buff *msdu,
 				       struct hal_tx_status *ts)
 {
-	struct ieee80211_tx_status status = { 0 };
-	struct ieee80211_rate_status status_rate = { 0 };
+	struct ieee80211_tx_status status = {};
+	struct ieee80211_rate_status status_rate = {};
 	struct ath11k_base *ab = ar->ab;
 	struct ieee80211_tx_info *info;
 	struct ath11k_skb_cb *skb_cb;
@@ -690,7 +691,7 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
 	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
 	struct sk_buff *msdu;
-	struct hal_tx_status ts = { 0 };
+	struct hal_tx_status ts = {};
 	struct dp_tx_ring *tx_ring = &dp->tx_ring[ring_id];
 	u32 *desc;
 	u32 msdu_id;
@@ -1187,7 +1188,7 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
 	struct ath11k_base *ab = ar->ab;
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	int ret = 0, ring_id = 0, i;
 
 	if (ab->hw_params.full_monitor_mode) {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7dde21289a52c0e27834e8c644d413ff6cdc7e4a..1fadf5faafb8260cc3ef5867cf32efbcb3b91460 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1037,7 +1037,7 @@ static int ath11k_mac_monitor_vdev_create(struct ath11k *ar)
 	struct ath11k_pdev *pdev = ar->pdev;
 	struct vdev_create_params param = {};
 	int bit, ret;
-	u8 tmp_addr[6] = {0};
+	u8 tmp_addr[6] = {};
 	u16 nss;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -3026,7 +3026,7 @@ static bool ath11k_mac_vif_recalc_sta_he_txbf(struct ath11k *ar,
 					      struct ieee80211_sta_he_cap *he_cap)
 {
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
-	struct ieee80211_he_cap_elem he_cap_elem = {0};
+	struct ieee80211_he_cap_elem he_cap_elem = {};
 	struct ieee80211_sta_he_cap *cap_band = NULL;
 	struct cfg80211_chan_def def;
 	u32 param = WMI_VDEV_PARAM_SET_HEMU_MODE;
@@ -3763,7 +3763,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		ath11k_recalculate_mgmt_rate(ar, vif, &def);
 
 	if (changed & BSS_CHANGED_TWT) {
-		struct wmi_twt_enable_params twt_params = {0};
+		struct wmi_twt_enable_params twt_params = {};
 
 		if (info->twt_requester || info->twt_responder) {
 			ath11k_wmi_fill_default_twt_params(&twt_params);
@@ -5323,7 +5323,7 @@ static struct ieee80211_sta_ht_cap
 ath11k_create_ht_cap(struct ath11k *ar, u32 ar_ht_cap, u32 rate_cap_rx_chainmask)
 {
 	int i;
-	struct ieee80211_sta_ht_cap ht_cap = {0};
+	struct ieee80211_sta_ht_cap ht_cap = {};
 	u32 ar_vht_cap = ar->pdev->cap.vht_cap;
 
 	if (!(ar_ht_cap & WMI_HT_CAP_ENABLED))
@@ -5490,7 +5490,7 @@ static struct ieee80211_sta_vht_cap
 ath11k_create_vht_cap(struct ath11k *ar, u32 rate_cap_tx_chainmask,
 		      u32 rate_cap_rx_chainmask)
 {
-	struct ieee80211_sta_vht_cap vht_cap = {0};
+	struct ieee80211_sta_vht_cap vht_cap = {};
 	u16 txmcs_map, rxmcs_map;
 	int i;
 
@@ -6159,7 +6159,7 @@ void ath11k_mac_drain_tx(struct ath11k *ar)
 
 static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 {
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	struct ath11k_base *ab = ar->ab;
 	int i, ret = 0;
 	u32 ring_id;
@@ -6678,7 +6678,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
-	struct vdev_create_params vdev_param = {0};
+	struct vdev_create_params vdev_param = {};
 	struct peer_create_params peer_param;
 	u32 param_id, param_value;
 	u16 nss;
@@ -10421,7 +10421,7 @@ int ath11k_mac_register(struct ath11k_base *ab)
 	struct ath11k_pdev *pdev;
 	int i;
 	int ret;
-	u8 mac_addr[ETH_ALEN] = {0};
+	u8 mac_addr[ETH_ALEN] = {};
 
 	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
 		return 0;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 78444f8ea15356f1f4c90a496efd52780499bfb2..d8655badd96d0f4b6946f8af927d878aaa3147ad 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -37,7 +37,7 @@ static const struct pci_device_id ath11k_pci_id_table[] = {
 	{ PCI_VDEVICE(QCOM, QCA6390_DEVICE_ID) },
 	{ PCI_VDEVICE(QCOM, WCN6855_DEVICE_ID) },
 	{ PCI_VDEVICE(QCOM, QCN9074_DEVICE_ID) },
-	{0}
+	{}
 };
 
 MODULE_DEVICE_TABLE(pci, ath11k_pci_id_table);
@@ -692,7 +692,7 @@ static void ath11k_pci_coredump_download(struct ath11k_base *ab)
 	struct ath11k_tlv_dump_data *dump_tlv;
 	size_t hdr_len = sizeof(*file_data);
 	void *buf;
-	u32 dump_seg_sz[FW_CRASH_DUMP_TYPE_MAX] = { 0 };
+	u32 dump_seg_sz[FW_CRASH_DUMP_TYPE_MAX] = {};
 
 	ath11k_mhi_coredump(mhi_ctrl, false);
 
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 79e091134515b432284768e66eca23314af95a9d..b6b0516819a6816fe7b76bab8ec769b3e6079e34 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/relay.h>
@@ -205,7 +206,7 @@ static int ath11k_spectral_scan_trigger(struct ath11k *ar)
 static int ath11k_spectral_scan_config(struct ath11k *ar,
 				       enum ath11k_spectral_mode mode)
 {
-	struct ath11k_wmi_vdev_spectral_conf_param param = { 0 };
+	struct ath11k_wmi_vdev_spectral_conf_param param = {};
 	struct ath11k_vif *arvif;
 	int ret, count;
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 56af2e9634f422bbbc6a317fcf02cd36357f1a73..0491e3fd6b5e16d464bd3e3c3933b9102641204b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7542,7 +7542,7 @@ static void ath11k_vdev_stopped_event(struct ath11k_base *ab, struct sk_buff *sk
 
 static void ath11k_mgmt_rx_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
-	struct mgmt_rx_event_params rx_ev = {0};
+	struct mgmt_rx_event_params rx_ev = {};
 	struct ath11k *ar;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr;
@@ -7657,7 +7657,7 @@ static void ath11k_mgmt_rx_event(struct ath11k_base *ab, struct sk_buff *skb)
 
 static void ath11k_mgmt_tx_compl_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
-	struct wmi_mgmt_tx_compl_event tx_compl_param = {0};
+	struct wmi_mgmt_tx_compl_event tx_compl_param = {};
 	struct ath11k *ar;
 
 	if (ath11k_pull_mgmt_tx_compl_param_tlv(ab, skb, &tx_compl_param) != 0) {
@@ -7712,7 +7712,7 @@ static struct ath11k *ath11k_get_ar_on_scan_state(struct ath11k_base *ab,
 static void ath11k_scan_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct ath11k *ar;
-	struct wmi_scan_event scan_ev = {0};
+	struct wmi_scan_event scan_ev = {};
 
 	if (ath11k_pull_scan_ev(ab, skb, &scan_ev) != 0) {
 		ath11k_warn(ab, "failed to extract scan event");
@@ -7884,7 +7884,7 @@ static void ath11k_roam_event(struct ath11k_base *ab, struct sk_buff *skb)
 
 static void ath11k_chan_info_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
-	struct wmi_chan_info_event ch_info_ev = {0};
+	struct wmi_chan_info_event ch_info_ev = {};
 	struct ath11k *ar;
 	struct survey_info *survey;
 	int idx;
@@ -8031,7 +8031,7 @@ ath11k_pdev_bss_chan_info_event(struct ath11k_base *ab, struct sk_buff *skb)
 static void ath11k_vdev_install_key_compl_event(struct ath11k_base *ab,
 						struct sk_buff *skb)
 {
-	struct wmi_vdev_install_key_complete_arg install_key_compl = {0};
+	struct wmi_vdev_install_key_complete_arg install_key_compl = {};
 	struct ath11k *ar;
 
 	if (ath11k_pull_vdev_install_key_compl_ev(ab, skb, &install_key_compl) != 0) {
@@ -8129,7 +8129,7 @@ static void ath11k_service_available_event(struct ath11k_base *ab, struct sk_buf
 
 static void ath11k_peer_assoc_conf_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
-	struct wmi_peer_assoc_conf_arg peer_assoc_conf = {0};
+	struct wmi_peer_assoc_conf_arg peer_assoc_conf = {};
 	struct ath11k *ar;
 
 	if (ath11k_pull_peer_assoc_conf_ev(ab, skb, &peer_assoc_conf) != 0) {

---
base-commit: 9e8086b865ab458e4a1ae520aa3a4f304a0a0539
change-id: 20250718-ath11k-zero-brace-095a28a4ac51


