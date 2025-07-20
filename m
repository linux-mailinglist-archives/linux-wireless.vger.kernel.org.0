Return-Path: <linux-wireless+bounces-25690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A449B0B6A9
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jul 2025 17:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC903B7AA6
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jul 2025 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA3E21C9E8;
	Sun, 20 Jul 2025 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oecnPwV/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A821C190
	for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753025063; cv=none; b=vEwltyAiAu/DDzcZn++zxysIljMOmD33a9o8TOJ3QDjl0nsEig7e5Rn6C5bsuc1V47skaHxpDlJ4Lyen5EWjxGvdTU4LII3+33KHnGmMvWNWyzwjQNZa6VFW1DhwvbH28HYkW1vdUH91B9mt/n6Pp/SpMlm+BSVoO1yNIBxtfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753025063; c=relaxed/simple;
	bh=VonT8OUG5BYOL1LU3TMt5EhQfdnWhHOp4DzemmQJig8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HOSG52LT04oSAyGsteQXRXeAv7YteBtmRCjvh+Ov+XBNfBRkeJGPNHvzIK/sMeGLytet8J3/hHhAjwu4z8707vvxdBUuvJIOLFDwm6NX+/k8yrQIRcxro1Z63KI5KswVy1bADqzMcjIkYfiI0nUhiX5BLQomCFRPSHCLGKAMaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oecnPwV/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K6pKrE001138
	for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 15:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=plVALh5uPZThnO1rZ7+UDO
	YClCnFOvf+/QqHJf2FtbQ=; b=oecnPwV/75vRps/Q4WxkZCp+FZLQwP2jAhANSm
	uvuP604FnJEPhTCJC5iXbo7YuFSXRTsd413E2pWKfLKipElz91ToXCW57/gZQGxO
	NodRCBqm0+kYNJ/APcbY793VrDCYE8ursAcN/RGsjuCG+/MiycnJpbQgfjNFsK5D
	92z0Okk5EbSbC2uGqeURONgaUte264s6vDc0fvoOy1togMbOCQHObNZpS7Grh1f7
	j+/6cLXEJy60hGN+uSJUXMUC+fqn9JFFET2PM0WunuAITisI/93yNV4C/IkXhxp5
	h1hNlsNDgjkOMjOjStXpKFpZ8Tb46U73Mz1oSHIYhDGtzKqA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048rte2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 15:24:19 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7489ac848f3so5615471b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 08:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753025057; x=1753629857;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plVALh5uPZThnO1rZ7+UDOYClCnFOvf+/QqHJf2FtbQ=;
        b=xHS3A7oNgFqKNe+nfZuUc3sJ9RCMQnETWOOpxxmSLrFElTjWb9oIf9PDhc1lbdrHxR
         MqldGO7wrghHWEJZM4vdFEa7FOGNQh2icl92caxyr2qS33HWsz6Z6y4x7IuTO9xbgMZc
         09Z1Q52uVmYo5pnLYZudulazsWzXIR6+aCRqfBZVWnsgLDOkr8IJR3Y2HrXm6V+nDkZX
         0eQsCjQJK4H4UzPO/vgDVj++rQxINxYI8tw7dY4/XyF4ADGI7mEj67V1kmuMvjvW3Mo5
         iahINVZCREr6JWZmbOL6h6afDYg6y9WRrVdjPMtFWvltcroeXVBjltswcgyqj+yXqOI3
         ftNQ==
X-Gm-Message-State: AOJu0YwPIwNgNJeHD0hiwLyKJzb3q3+RBYM1bMpXPQOeagDFmxpy9PRx
	nUgLfrPy7N3NbDxuupMxhjjsG714Z8frAYH6KB3IKnQMzQ5tyFRG48pwdKHXRRYmj8vjkdHKlI9
	HtkldwDGkBmBAG4f0J2sF5FOYelbORKiS6jhmrjVYlH+pXblCRtciCzatWRGtTWnozFsP9RqMaq
	i5dg==
X-Gm-Gg: ASbGncuMhfZqf1hPVG2egETecvVKnhFN62s667O+BgAA5pQ7FdyfGRojcV12Jxu2xGM
	N0P73n+Wtg7tvAhuC1272lST2PR+dTUg7aF56QFMFq8W8vXs6umklMpXKnn1A2oA8ROfAeXYY5P
	web75rjpB8r7gOGE0xzAvjUMS9voSA2HSUWum+EYTtFR251n0XUZ+ecaPBOGUZkK8LV8Bbs0t+9
	lK7AJDZcwvvl293BtKkQwRkPoLYLu6H7oAvjTTlZrtzYJhVreQ2sUKc2pG6xLep+SrNzVUeNn4+
	WE7UubOxXGuU0Ryv/03UZePqE4nu3jHckm2GadbmmtT22WTQjZft+MYPSrypL+R3pOsWS9JX7uq
	u
X-Received: by 2002:a05:6a00:ad5:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-7572316302emr26726793b3a.3.1753025057095;
        Sun, 20 Jul 2025 08:24:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMr+rKXYpcuBcjQpGI9EPcvXA0XsbLH7oIyf+np5eJ/phFQ4eHj7c5E/qyHq99ZPbpONICvw==
X-Received: by 2002:a05:6a00:ad5:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-7572316302emr26726753b3a.3.1753025056477;
        Sun, 20 Jul 2025 08:24:16 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d582bsm4288656b3a.58.2025.07.20.08.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 08:24:16 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 08:24:14 -0700
Subject: [PATCH ath-next] wifi: ath12k: Prefer {} to {0} in initializers
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ath12k-zero-brace-v1-1-d8c8ca9d40a8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAB0KfWgC/22NwQrCMBBEf6Xs2S3dBKn15H9ID2my2qBtNImhW
 vLvhuLRy8AwM29WCOwtBzhWK3hONlg3F0O7CvSo5iujNcWDaMS+aemAKo4kbvhh73DwSjNSp7Q
 0bEgPBGX38Hyxy8Y8Q6njzEuEviSjDdH593aWaMt/3O4PNxESttJQJ1mwbPTJhVA/X+qu3TTVR
 aDPOX8BttmumsMAAAA=
X-Change-ID: 20250718-ath12k-zero-brace-19ac3ded1cb1
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE0OCBTYWx0ZWRfX7N10+zjynQ49
 j4P+FhsvfmcVU2ac88IeFiJuMncqvX0JI6+wlx+0+sVVa2Z0At2FORe+680rJWb8ytgfDA7P1nv
 0jPouPqS78jGebIP1gBgTRNn4e8bUrqevA4rPTWnEUahgYCH32J8ljp+yC0GVngFkhdwL3HveOo
 Dgje/xzaCPn3wwnY5x1FE+4mBXLCeg2JaZX+7pGBmcZuC6eNrjf+54mNvKFTiY8R3quII4l43Yb
 1762DCqDGTFL8HOzstGEYmh/bp85gNSE9aFsM34ETNyMB8xG4aybHZZUpwGq6VneKeqGX8H0zlj
 8qnbItKq0Yj5Veefpb8YbOTce9DQNr3i0TTP4GvZv0xlXoBRNzHLh/Q1Jia+Q25ddrkKUpcAeq1
 je0bR8p+SJMbk3J+83CLQMBpAtZ4RMr5VaVqzdMq5++L6G8N1Xv+HUapkmQI1vTTpGz7tg94
X-Proofpoint-ORIG-GUID: XKSTbb4VjExlW7x4_wPGreMtZDEbSnDp
X-Proofpoint-GUID: XKSTbb4VjExlW7x4_wPGreMtZDEbSnDp
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687d0a23 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=8rE0DOS6Ath7_zZPqtsA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200148

Prefer {} to {0} in initializers since {} works even when the first
member is not a scalar.

Generated using:
sed -i 's/{[[:space:]]*0[[:space:]]*}/{}/g' drivers/net/wireless/ath/ath12k/*

Compile tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ce.c                |  2 +-
 drivers/net/wireless/ath/ath12k/core.c              |  2 +-
 drivers/net/wireless/ath/ath12k/dbring.c            |  3 ++-
 drivers/net/wireless/ath/ath12k/debugfs.c           |  8 ++++----
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c | 12 ++++++------
 drivers/net/wireless/ath/ath12k/dp.c                |  6 +++---
 drivers/net/wireless/ath/ath12k/dp_rx.c             | 18 +++++++++---------
 drivers/net/wireless/ath/ath12k/dp_tx.c             | 10 +++++-----
 drivers/net/wireless/ath/ath12k/mac.c               | 16 ++++++++--------
 drivers/net/wireless/ath/ath12k/pci.c               |  4 ++--
 drivers/net/wireless/ath/ath12k/wmi.c               | 14 +++++++-------
 11 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index f7c15b547504d57984c482fceaff010e8b75bc22..f93a419abf65ec6e9b31e22c78c8c2cdd7bdbc76 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -578,7 +578,7 @@ static int ath12k_ce_init_ring(struct ath12k_base *ab,
 			       struct ath12k_ce_ring *ce_ring,
 			       int ce_id, enum hal_ring_type type)
 {
-	struct hal_srng_params params = { 0 };
+	struct hal_srng_params params = {};
 	int ret;
 
 	params.ring_base_paddr = ce_ring->base_addr_ce_space;
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index bf46acb542682d5c20d2faab09d1e4f59e09f771..5d494c5cdc0da3189640751b8d191fa939ac3ff5 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -218,7 +218,7 @@ static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 					   bool bus_type_mode, bool with_default)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
-	char variant[9 + ATH12K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
+	char variant[9 + ATH12K_QMI_BDF_EXT_STR_LENGTH] = {};
 
 	if (with_variant && ab->qmi.target.bdf_ext[0] != '\0')
 		scnprintf(variant, sizeof(variant), ",variant=%s",
diff --git a/drivers/net/wireless/ath/ath12k/dbring.c b/drivers/net/wireless/ath/ath12k/dbring.c
index 788160c84c6868a9ac5134d45079b17ad220ca9b..6604dacea2ae59868d7ae3389f2fc0be561e6d36 100644
--- a/drivers/net/wireless/ath/ath12k/dbring.c
+++ b/drivers/net/wireless/ath/ath12k/dbring.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
@@ -117,7 +118,7 @@ int ath12k_dbring_wmi_cfg_setup(struct ath12k *ar,
 				struct ath12k_dbring *ring,
 				enum wmi_direct_buffer_module id)
 {
-	struct ath12k_wmi_pdev_dma_ring_cfg_arg arg = {0};
+	struct ath12k_wmi_pdev_dma_ring_cfg_arg arg = {};
 	int ret;
 
 	if (id >= WMI_DIRECT_BUF_MAX)
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 23da93afaa5c25e806c9859dbbdd796afd23d78a..16601a8c3644812489bf20b2777906ca699207bc 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -52,7 +52,7 @@ ath12k_write_simulate_fw_crash(struct file *file,
 	struct ath12k_base *ab = file->private_data;
 	struct ath12k_pdev *pdev;
 	struct ath12k *ar = NULL;
-	char buf[32] = {0};
+	char buf[32] = {};
 	int i, ret;
 	ssize_t rc;
 
@@ -816,7 +816,7 @@ static ssize_t ath12k_write_extd_rx_stats(struct file *file,
 					  size_t count, loff_t *ppos)
 {
 	struct ath12k *ar = file->private_data;
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	u32 ring_id, rx_filter = 0;
 	bool enable;
 	int ret, i;
@@ -1217,7 +1217,7 @@ void ath12k_debugfs_pdev_create(struct ath12k_base *ab)
 void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
 	bool dput_needed;
-	char soc_name[64] = { 0 };
+	char soc_name[64] = {};
 	struct dentry *debugfs_ath12k;
 
 	debugfs_ath12k = debugfs_lookup("ath12k", NULL);
@@ -1470,7 +1470,7 @@ void ath12k_debugfs_register(struct ath12k *ar)
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_hw *hw = ar->ah->hw;
 	char pdev_name[5];
-	char buf[100] = {0};
+	char buf[100] = {};
 
 	scnprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
 
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 96c834b987db5711fd496539ff67e201b6ed074a..48b010a1b7566db364d74b1ddf5de900a0b37474 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2024,7 +2024,7 @@ ath12k_htt_print_stats_string_tlv(const void *tag_buf, u16 tag_len,
 	u8 i;
 	u16 index = 0;
 	u32 datum;
-	char data[ATH12K_HTT_MAX_STRING_LEN] = {0};
+	char data[ATH12K_HTT_MAX_STRING_LEN] = {};
 
 	tag_len = tag_len >> 2;
 
@@ -3081,7 +3081,7 @@ ath12k_htt_print_ul_mumimo_trig_stats(const void *tag_buf, u16 tag_len,
 				      struct debug_htt_stats_req *stats_req)
 {
 	const struct ath12k_htt_rx_ul_mumimo_trig_stats_tlv *htt_stats_buf = tag_buf;
-	char str_buf[ATH12K_HTT_MAX_STRING_LEN] = {0};
+	char str_buf[ATH12K_HTT_MAX_STRING_LEN] = {};
 	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
 	u32 len = stats_req->buf_len;
 	u8 *buf = stats_req->buf;
@@ -3642,7 +3642,7 @@ ath12k_htt_print_dlpager_stats_tlv(const void *tag_buf, u16 tag_len,
 	u8 *buf = stats_req->buf;
 	u8 pg_locked;
 	u8 pg_unlock;
-	char str_buf[ATH12K_HTT_MAX_STRING_LEN] = {0};
+	char str_buf[ATH12K_HTT_MAX_STRING_LEN] = {};
 
 	if (tag_len < sizeof(*stat_buf))
 		return;
@@ -5923,7 +5923,7 @@ static ssize_t ath12k_write_htt_stats_type(struct file *file,
 {
 	struct ath12k *ar = file->private_data;
 	enum ath12k_dbg_htt_ext_stats_type type;
-	unsigned int cfg_param[4] = {0};
+	unsigned int cfg_param[4] = {};
 	const int size = 32;
 	int num_args;
 
@@ -5973,7 +5973,7 @@ static int ath12k_debugfs_htt_stats_req(struct ath12k *ar)
 	enum ath12k_dbg_htt_ext_stats_type type = stats_req->type;
 	u64 cookie;
 	int ret, pdev_id;
-	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+	struct htt_ext_stats_cfg_params cfg_params = {};
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -6112,7 +6112,7 @@ static ssize_t ath12k_write_htt_stats_reset(struct file *file,
 {
 	struct ath12k *ar = file->private_data;
 	enum ath12k_dbg_htt_ext_stats_type type;
-	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+	struct htt_ext_stats_cfg_params cfg_params = {};
 	u8 param_pos;
 	int ret;
 
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index d80af435959a8cd0e84f6e2bce89473331bd7f72..d6435dad61a11175fc6cd55004b9a479e2e6621c 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -242,7 +242,7 @@ int ath12k_dp_srng_setup(struct ath12k_base *ab, struct dp_srng *ring,
 			 enum hal_ring_type type, int ring_num,
 			 int mac_id, int num_entries)
 {
-	struct hal_srng_params params = { 0 };
+	struct hal_srng_params params = {};
 	int entry_sz = ath12k_hal_srng_get_entrysize(ab, type);
 	int max_entries = ath12k_hal_srng_get_max_entries(ab, type);
 	int ret;
@@ -1084,8 +1084,8 @@ int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 
 int ath12k_dp_htt_connect(struct ath12k_dp *dp)
 {
-	struct ath12k_htc_svc_conn_req conn_req = {0};
-	struct ath12k_htc_svc_conn_resp conn_resp = {0};
+	struct ath12k_htc_svc_conn_req conn_req = {};
+	struct ath12k_htc_svc_conn_resp conn_resp = {};
 	int status;
 
 	conn_req.ep_ops.ep_tx_complete = ath12k_dp_htt_htc_tx_complete;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 34072ee5b1ec2a3d11f7cbbecd824b47e3c25359..8ab91273592c826cdd3c39fb9157dc853b2722e5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -671,7 +671,7 @@ static int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_ti
 static void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
 				      struct ath12k_dp_rx_tid *rx_tid)
 {
-	struct ath12k_hal_reo_cmd cmd = {0};
+	struct ath12k_hal_reo_cmd cmd = {};
 	unsigned long tot_desc_sz, desc_sz;
 	int ret;
 
@@ -828,7 +828,7 @@ static void ath12k_peer_rx_tid_qref_reset(struct ath12k_base *ab, u16 peer_id, u
 void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 				  struct ath12k_peer *peer, u8 tid)
 {
-	struct ath12k_hal_reo_cmd cmd = {0};
+	struct ath12k_hal_reo_cmd cmd = {};
 	struct ath12k_dp_rx_tid *rx_tid = &peer->rx_tid[tid];
 	int ret;
 
@@ -939,7 +939,7 @@ static int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
 					 u32 ba_win_sz, u16 ssn,
 					 bool update_ssn)
 {
-	struct ath12k_hal_reo_cmd cmd = {0};
+	struct ath12k_hal_reo_cmd cmd = {};
 	int ret;
 
 	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
@@ -1204,7 +1204,7 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 {
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_hal_reo_cmd cmd = {0};
+	struct ath12k_hal_reo_cmd cmd = {};
 	struct ath12k_peer *peer;
 	struct ath12k_dp_rx_tid *rx_tid;
 	u8 tid;
@@ -2735,7 +2735,7 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 						  int ring_id)
 {
 	struct ath12k_hw_group *ag = ab->ag;
-	struct ieee80211_rx_status rx_status = {0};
+	struct ieee80211_rx_status rx_status = {};
 	struct ath12k_skb_rxcb *rxcb;
 	struct sk_buff *msdu;
 	struct ath12k *ar;
@@ -3030,7 +3030,7 @@ static int ath12k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
 				      size_t data_len, u8 *mic)
 {
 	SHASH_DESC_ON_STACK(desc, tfm);
-	u8 mic_hdr[16] = {0};
+	u8 mic_hdr[16] = {};
 	u8 tid = 0;
 	int ret;
 
@@ -3999,7 +3999,7 @@ static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
 				 struct sk_buff_head *msdu_list)
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	struct ieee80211_rx_status rxs = {0};
+	struct ieee80211_rx_status rxs = {};
 	struct ath12k_dp_rx_info rx_info;
 	bool drop = true;
 
@@ -4346,7 +4346,7 @@ void ath12k_dp_rx_pdev_free(struct ath12k_base *ab, int mac_id)
 int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	u32 ring_id;
 	int ret;
 	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
@@ -4387,7 +4387,7 @@ int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	u32 ring_id;
 	int ret = 0;
 	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index d79c2ff7795228c71358cf06a0a6c8bd219d4a87..abc84ca8467a21827fc9caeb44d7e2d16e39d835 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -225,7 +225,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_dp *dp = &ab->dp;
-	struct hal_tx_info ti = {0};
+	struct hal_tx_info ti = {};
 	struct ath12k_tx_desc_info *tx_desc;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
@@ -659,7 +659,7 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
 				     struct ath12k_tx_desc_params *desc_params)
 {
 	struct htt_tx_wbm_completion *status_desc;
-	struct ath12k_dp_htt_wbm_tx_status ts = {0};
+	struct ath12k_dp_htt_wbm_tx_status ts = {};
 	enum hal_wbm_htt_tx_comp_status wbm_status;
 	u16 peer_id;
 
@@ -705,7 +705,7 @@ static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status
 	struct ieee80211_sta *sta;
 	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
-	struct rate_info txrate = {0};
+	struct rate_info txrate = {};
 	u16 rate, ru_tones;
 	u8 rate_idx = 0;
 	int ret;
@@ -1001,7 +1001,7 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
 	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
 	struct ath12k_tx_desc_info *tx_desc = NULL;
-	struct hal_tx_status ts = { 0 };
+	struct hal_tx_status ts = {};
 	struct ath12k_tx_desc_params desc_params;
 	struct dp_tx_ring *tx_ring = &dp->tx_ring[ring_id];
 	struct hal_wbm_release_ring *desc;
@@ -1571,7 +1571,7 @@ int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	int ret, ring_id, i;
 
 	tlv_filter.offset_valid = false;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 05250fa0600d6bb868b8def2dd9a226dc8fc437f..7f80c72611c8ebb440d23e34da2e050f7195e504 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6375,7 +6375,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	struct ath12k_wmi_peer_create_arg peer_param = {0};
+	struct ath12k_wmi_peer_create_arg peer_param = {};
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -6719,7 +6719,7 @@ static int ath12k_mac_mlo_sta_set_link_active(struct ath12k_base *ab,
 					      u8 *mlo_inactive_vdev_lst,
 					      u8 num_mlo_inactive_vdev)
 {
-	struct wmi_mlo_link_set_active_arg param = {0};
+	struct wmi_mlo_link_set_active_arg param = {};
 	u32 entry_idx, entry_offset, vdev_idx;
 	u8 vdev_id;
 
@@ -6781,8 +6781,8 @@ static int ath12k_mac_mlo_sta_update_link_active(struct ath12k_base *ab,
 						 struct ieee80211_hw *hw,
 						 struct ath12k_vif *ahvif)
 {
-	u8 mlo_vdev_id_lst[IEEE80211_MLD_MAX_NUM_LINKS] = {0};
-	u32 mlo_freq_list[IEEE80211_MLD_MAX_NUM_LINKS] = {0};
+	u8 mlo_vdev_id_lst[IEEE80211_MLD_MAX_NUM_LINKS] = {};
+	u32 mlo_freq_list[IEEE80211_MLD_MAX_NUM_LINKS] = {};
 	unsigned long links = ahvif->links_map;
 	enum wmi_mlo_link_force_reason reason;
 	struct ieee80211_chanctx_conf *conf;
@@ -7519,7 +7519,7 @@ static struct ieee80211_sta_ht_cap
 ath12k_create_ht_cap(struct ath12k *ar, u32 ar_ht_cap, u32 rate_cap_rx_chainmask)
 {
 	int i;
-	struct ieee80211_sta_ht_cap ht_cap = {0};
+	struct ieee80211_sta_ht_cap ht_cap = {};
 	u32 ar_vht_cap = ar->pdev->cap.vht_cap;
 
 	if (!(ar_ht_cap & WMI_HT_CAP_ENABLED))
@@ -7675,7 +7675,7 @@ static struct ieee80211_sta_vht_cap
 ath12k_create_vht_cap(struct ath12k *ar, u32 rate_cap_tx_chainmask,
 		      u32 rate_cap_rx_chainmask)
 {
-	struct ieee80211_sta_vht_cap vht_cap = {0};
+	struct ieee80211_sta_vht_cap vht_cap = {};
 	u16 txmcs_map, rxmcs_map;
 	int i;
 
@@ -9682,8 +9682,8 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	struct ieee80211_hw *hw = ah->hw;
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
-	struct ath12k_wmi_vdev_create_arg vdev_arg = {0};
-	struct ath12k_wmi_peer_create_arg peer_param = {0};
+	struct ath12k_wmi_vdev_create_arg vdev_arg = {};
+	struct ath12k_wmi_peer_create_arg peer_param = {};
 	struct ieee80211_bss_conf *link_conf = NULL;
 	u32 param_id, param_value;
 	u16 nss;
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index b4e7e77518dd7750cac5b7da04e643aacc74680d..c729d5526c753d2b7b7542b6f2a145e71b335a43 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -48,7 +48,7 @@
 static const struct pci_device_id ath12k_pci_id_table[] = {
 	{ PCI_VDEVICE(QCOM, QCN9274_DEVICE_ID) },
 	{ PCI_VDEVICE(QCOM, WCN7850_DEVICE_ID) },
-	{0}
+	{}
 };
 
 MODULE_DEVICE_TABLE(pci, ath12k_pci_id_table);
@@ -1353,7 +1353,7 @@ static void ath12k_pci_coredump_download(struct ath12k_base *ab)
 	struct ath12k_tlv_dump_data *dump_tlv;
 	size_t hdr_len = sizeof(*file_data);
 	void *buf;
-	u32 dump_seg_sz[FW_CRASH_DUMP_TYPE_MAX] = { 0 };
+	u32 dump_seg_sz[FW_CRASH_DUMP_TYPE_MAX] = {};
 
 	ath12k_mhi_coredump(mhi_ctrl, false);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index a2a493928d0825b3791b0fd4033e568eca296da0..da85c28ec35568ca5c81a49e565c19cff195bac7 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7039,7 +7039,7 @@ static void ath12k_vdev_stopped_event(struct ath12k_base *ab, struct sk_buff *sk
 
 static void ath12k_mgmt_rx_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
-	struct ath12k_wmi_mgmt_rx_arg rx_ev = {0};
+	struct ath12k_wmi_mgmt_rx_arg rx_ev = {};
 	struct ath12k *ar;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr;
@@ -7158,7 +7158,7 @@ static void ath12k_mgmt_rx_event(struct ath12k_base *ab, struct sk_buff *skb)
 
 static void ath12k_mgmt_tx_compl_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
-	struct wmi_mgmt_tx_compl_event tx_compl_param = {0};
+	struct wmi_mgmt_tx_compl_event tx_compl_param = {};
 	struct ath12k *ar;
 
 	if (ath12k_pull_mgmt_tx_compl_param_tlv(ab, skb, &tx_compl_param) != 0) {
@@ -7216,7 +7216,7 @@ static struct ath12k *ath12k_get_ar_on_scan_state(struct ath12k_base *ab,
 static void ath12k_scan_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct ath12k *ar;
-	struct wmi_scan_event scan_ev = {0};
+	struct wmi_scan_event scan_ev = {};
 
 	if (ath12k_pull_scan_ev(ab, skb, &scan_ev) != 0) {
 		ath12k_warn(ab, "failed to extract scan event");
@@ -7393,7 +7393,7 @@ static void ath12k_roam_event(struct ath12k_base *ab, struct sk_buff *skb)
 
 static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
-	struct wmi_chan_info_event ch_info_ev = {0};
+	struct wmi_chan_info_event ch_info_ev = {};
 	struct ath12k *ar;
 	struct survey_info *survey;
 	int idx;
@@ -7541,7 +7541,7 @@ ath12k_pdev_bss_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 static void ath12k_vdev_install_key_compl_event(struct ath12k_base *ab,
 						struct sk_buff *skb)
 {
-	struct wmi_vdev_install_key_complete_arg install_key_compl = {0};
+	struct wmi_vdev_install_key_complete_arg install_key_compl = {};
 	struct ath12k *ar;
 
 	if (ath12k_pull_vdev_install_key_compl_ev(ab, skb, &install_key_compl) != 0) {
@@ -7646,7 +7646,7 @@ static int ath12k_service_available_event(struct ath12k_base *ab, struct sk_buff
 
 static void ath12k_peer_assoc_conf_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
-	struct wmi_peer_assoc_conf_arg peer_assoc_conf = {0};
+	struct wmi_peer_assoc_conf_arg peer_assoc_conf = {};
 	struct ath12k *ar;
 
 	if (ath12k_pull_peer_assoc_conf_ev(ab, skb, &peer_assoc_conf) != 0) {
@@ -8592,7 +8592,7 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
 				  struct sk_buff *skb)
 {
 	struct ath12k *ar;
-	struct wmi_pdev_temperature_event ev = {0};
+	struct wmi_pdev_temperature_event ev = {};
 
 	if (ath12k_pull_pdev_temp_ev(ab, skb, &ev) != 0) {
 		ath12k_warn(ab, "failed to extract pdev temperature event");

---
base-commit: d4bc7beefd076ac6f6051558b2152d152269273e
change-id: 20250718-ath12k-zero-brace-19ac3ded1cb1


