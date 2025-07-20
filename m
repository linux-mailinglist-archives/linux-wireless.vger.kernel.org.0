Return-Path: <linux-wireless+bounces-25688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 230CFB0B682
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jul 2025 16:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1D418976C8
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jul 2025 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E226B20103A;
	Sun, 20 Jul 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jxK3wqsZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906802110
	for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753022784; cv=none; b=jr1uUGIPsRtGmX9AG2JWsIKKL+BrK56OUOD/iSGNVl92J6nrfhpssu0sEfjWvlXOqxNN39eQSXcuRLv4vnKsQkmUrqdt7ON6d3I+PkWSYfPxZal5QmCuLT4mJe9g+Dc8Ij6CoKRymbRuWUwhEAIL67weVMvrQCra9yMRoH1TVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753022784; c=relaxed/simple;
	bh=Jq8jhVW0cCEdf6xyTCAhkmsjUVfRZ2W/5N8mH2cGxOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b+fM0BuF67vIkBBZrAHE+6GtAfl7zcg4MFxUa4660pf1Z3NXnDwzjo2CIiemJDDKTY/cz4thlfgmGfgT3H8YQCySzPLVjjWEO/+V2JIZzC82FyRl+QcYQl5uKU5zDfqIIAHjYya9yPZ4Y+Wl9ylNz2hB9r8zLL9lAyDPc/43oh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jxK3wqsZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KDwrQq030367
	for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 14:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xjVSLZuv0o0l1y7ZfSWiHI
	hHW8W40xj46tm+AH/rBNs=; b=jxK3wqsZ2FREWmvh/L/FvUhjD0OPecXKjU3/BE
	FTW5Ap/UBgjYbHsLMhlbaWs3g6+REkFiftdyTyDpMLuYesrC4aefeEgBOUMIo5J6
	lJyvpfw2UrDdmM1bQAVrUotd2nKj/p1kJBgY2VoR2GlqxdG0Tdz39pyOJoqVBb/A
	1YyPd0l7TYTeRAL3LWzDHmP4qjAZ/f5oDx1wq8n9WHorNjxvMbKpThdsluw6odI2
	GwPa89E4WBt9KxGmQZSZVGUE94eYNRtKcC2EANRIziEG4ZRu89AWZXHvzbSVp9j+
	CyQnvLStxNVCaFDB3jRT735vpu1eZ5td7HbThrEytii2cXKw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804n9t8ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 14:46:20 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74913385dd8so5057734b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 07:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753022779; x=1753627579;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjVSLZuv0o0l1y7ZfSWiHIhHW8W40xj46tm+AH/rBNs=;
        b=lSIWO8pE4IoOg+6bq/58tdVkePKwAtSZew+wQ11Bs4MZG39eNEOEWOKbhpHQanKz0+
         RTH8Se2uYgYKkiDTcRcNdsaL9oxQ+Fk8FfCum0GIV0URODnUN374KL9fTcm+X2mxKtK7
         84Shv6seUrJvIR+SQLq4wyCk2cae37YQKkIbuIPT6x65COcukjAzL+gbgZYZlE+Sx6xZ
         wB+FkgGWf/XDIJx6MdcOPoh8woPK0w0R4zWSlxqH6RAo9d8Yqa0br58KEm4JkznIeGUU
         mCR6WyUIsMuVVgl6wjCudO/pnjKNo7R2yuZX15bGuGaKF2gIWR1KP9/5aU2beQAaAug6
         9tLw==
X-Gm-Message-State: AOJu0Yzf/UinwWteBxAJqNqstoGwWe3SbFRpFJr1RMnYG04o4K1Z1Riq
	kBmIbUQPgPP0+N7+Ml10eVm8mrq6Oqgu7Egu9Tc5OJ7j9XQZjuZiIE4UQ4Izw+zj52sNj/X895g
	fSyR5LltQfVDcuzKGRQQREzYgMRk9ui3lLvKRiL0Bwu9sYpEc4wLzbePw/cdGotpk9Eu6bA==
X-Gm-Gg: ASbGncsnURBA9MuZdTG0mWmHzwyjbERcZV+hDM5FHdTVHkftZJx08utF02hTFtBLFfl
	AzUYsGlHzaqsnNQzAjmBVoII0MJWSuex1YAWSU2cO5i+ZMEL6721aI5sUUPBDSQst2p9q9EI3md
	TPc2uxldVzrIBcpXvqCm0LnT8u1u+9ETWZnkVAYEImMHm6FnK+IRWKZFZ1qvMhsapGRYyPOYeZp
	ldFgNTXY/bj32rw1VzHdajEAge8kkhITyPcX/e9Pm0Z+LvVwbL8vnXB26vEtAA5vll7a6J0ABBK
	Csz5fEUjJ25cbg1J51vlnoi+SApeL9tJ48t8dR32qicVRlq1yySmed9MQQujPaFW3AeK7GR8N7y
	b
X-Received: by 2002:a05:6a20:729a:b0:231:7dcc:f449 with SMTP id adf61e73a8af0-2381153ef10mr27191947637.18.1753022779336;
        Sun, 20 Jul 2025 07:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlA5oox/CgRP/D9vKcoxmGsTqGvE2VXR1KcrTRmjRb6uqqi16UWkvuapOOpShICdBz7boybA==
X-Received: by 2002:a05:6a20:729a:b0:231:7dcc:f449 with SMTP id adf61e73a8af0-2381153ef10mr27191912637.18.1753022778824;
        Sun, 20 Jul 2025 07:46:18 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb156a04sm4152377b3a.70.2025.07.20.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 07:46:18 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 07:46:15 -0700
Subject: [PATCH ath-next] wifi: ath10k: Prefer {} to {0} in initializers
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ath10k-zero-brace-v1-1-c1ee818d6238@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADYBfWgC/4XNQQ6CMBAF0KuQri3ptECLK+9hXJQySKNSbZGgh
 LvbdK2ymeTnz7xZSEBvMZB9thCPkw3WDTHALiOm18MZqW1jJpzxkklQVI89sAt9o3e08dog5aL
 SpZJ1q4wg8e7usbNzMo8krtMB55GcYtPbMDr/Ss8mSP0fdwIKVAJ2pSq0rFEfXAj546mvxt1ue
 RwJnfgmxCOkoJJVZ+oKzS9IbEIiQloAQ2agbmTxBVrX9QPwJ0BcVQEAAA==
X-Change-ID: 20250718-ath10k-zero-brace-236a5879d8c3
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: SqZvQKT1ML0023kzhH_WhsE9mo0x-tyL
X-Proofpoint-ORIG-GUID: SqZvQKT1ML0023kzhH_WhsE9mo0x-tyL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE0MiBTYWx0ZWRfXxKggL6jS3ptQ
 1e6AEI+HddiiIlkdyZdtZlfTAAvC/fVtM2dlfvwz8UzsyGo9upPR87ZqSW2/A0TTF2jssEZL/sR
 qjqDB9AalGtD1qNSHoEVwolV9KGKPVwmQhBsq+a2t2Ae8+qOdYPc9L84M/UqunJfAFiyt7hELzo
 55ziANoR88sVttsC3G7I/BcorAXnsJ2hG36oz1fQi1aEexI9Z8tITYdy62VrnIGrDIdpxZx7gV+
 RrSvIhn5mU2PuSyBMFQrN1P6Wf3TGrl4AoIUX5Os/3gEs2RqoHJGAdai1jwdNoWNH+zdPN2pKLB
 xwpemPp2nYmaBGVgucwmgG6JcJCpvkYNDc6prr1LskNY/IryIscTyHYg3GLk05bSw0dPMU3eMwo
 9B5gP6yfz8cYI84b06VNnD/tbjFQnVfaLrAexlYzFRlzYZi3Em/OVdRscvjHOSnuFRaQPy3y
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687d013c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=LHJufyryw8ALvslwOl4A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200142

Prefer {} to {0} in initializers since {} works even when the first
member is not a scalar.

Generated using:
sed -i 's/{[[:space:]]*0[[:space:]]*}/{}/g' drivers/net/wireless/ath/ath10k/*

Compile tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/core.c        | 2 +-
 drivers/net/wireless/ath/ath10k/debug.c       | 6 +++---
 drivers/net/wireless/ath/ath10k/debugfs_sta.c | 7 ++++---
 drivers/net/wireless/ath/ath10k/htt_rx.c      | 8 ++++----
 drivers/net/wireless/ath/ath10k/htt_tx.c      | 4 ++--
 drivers/net/wireless/ath/ath10k/mac.c         | 8 ++++----
 drivers/net/wireless/ath/ath10k/pci.c         | 3 ++-
 7 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 9c6c07598b3a12fd544d33c3cb893766c36eebc9..6f78f1752cd6ffcf8eb56621ba0e4978ac23e696 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1565,7 +1565,7 @@ static int ath10k_core_create_board_name(struct ath10k *ar, char *name,
 					 bool with_chip_id)
 {
 	/* strlen(',variant=') + strlen(ar->id.bdf_ext) */
-	char variant[9 + ATH10K_SMBIOS_BDF_EXT_STR_LENGTH] = { 0 };
+	char variant[9 + ATH10K_SMBIOS_BDF_EXT_STR_LENGTH] = {};
 
 	if (with_variant && ar->id.bdf_ext[0] != '\0')
 		scnprintf(variant, sizeof(variant), ",variant=%s",
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index 6410d3961e76ca2b4191052277c2072638db4b8d..b7520220465a838ba700bb10bee2325ccc324d20 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -547,7 +547,7 @@ static ssize_t ath10k_write_simulate_fw_crash(struct file *file,
 					      size_t count, loff_t *ppos)
 {
 	struct ath10k *ar = file->private_data;
-	char buf[32] = {0};
+	char buf[32] = {};
 	ssize_t rc;
 	int ret;
 
@@ -983,7 +983,7 @@ static ssize_t ath10k_write_htt_max_amsdu_ampdu(struct file *file,
 {
 	struct ath10k *ar = file->private_data;
 	int res;
-	char buf[64] = {0};
+	char buf[64] = {};
 	unsigned int amsdu, ampdu;
 
 	res = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
@@ -1039,7 +1039,7 @@ static ssize_t ath10k_write_fw_dbglog(struct file *file,
 {
 	struct ath10k *ar = file->private_data;
 	int ret;
-	char buf[96] = {0};
+	char buf[96] = {};
 	unsigned int log_level;
 	u64 mask;
 
diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index 0f6de862c3a9ba8995a72ef451e90371dce0a978..b9fb192e0b48456cc21b281fec47ce607913ab02 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
@@ -244,7 +245,7 @@ static ssize_t ath10k_dbg_sta_write_addba(struct file *file,
 	struct ath10k *ar = arsta->arvif->ar;
 	u32 tid, buf_size;
 	int ret;
-	char buf[64] = {0};
+	char buf[64] = {};
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
 				     user_buf, count);
@@ -295,7 +296,7 @@ static ssize_t ath10k_dbg_sta_write_addba_resp(struct file *file,
 	struct ath10k *ar = arsta->arvif->ar;
 	u32 tid, status;
 	int ret;
-	char buf[64] = {0};
+	char buf[64] = {};
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
 				     user_buf, count);
@@ -345,7 +346,7 @@ static ssize_t ath10k_dbg_sta_write_delba(struct file *file,
 	struct ath10k *ar = arsta->arvif->ar;
 	u32 tid, initiator, reason;
 	int ret;
-	char buf[64] = {0};
+	char buf[64] = {};
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
 				     user_buf, count);
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index f12243d6bee171eeccf4a57e8001cbddfd26733c..d7e429041065ad21ed699a7e75809817ba719830 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1884,7 +1884,7 @@ static bool ath10k_htt_rx_h_frag_pn_check(struct ath10k *ar,
 					  enum htt_rx_mpdu_encrypt_type enctype)
 {
 	struct ath10k_peer *peer;
-	union htt_rx_pn_t *last_pn, new_pn = {0};
+	union htt_rx_pn_t *last_pn, new_pn = {};
 	struct ieee80211_hdr *hdr;
 	u8 tid, frag_number;
 	u32 seq;
@@ -2402,7 +2402,7 @@ static bool ath10k_htt_rx_pn_check_replay_hl(struct ath10k *ar,
 	bool last_pn_valid, pn_invalid = false;
 	enum htt_txrx_sec_cast_type sec_index;
 	enum htt_security_types sec_type;
-	union htt_rx_pn_t new_pn = {0};
+	union htt_rx_pn_t new_pn = {};
 	struct htt_hl_rx_desc *rx_desc;
 	union htt_rx_pn_t *last_pn;
 	u32 rx_desc_info, tid;
@@ -2465,7 +2465,7 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	struct fw_rx_desc_hl *fw_desc;
 	enum htt_txrx_sec_cast_type sec_index;
 	enum htt_security_types sec_type;
-	union htt_rx_pn_t new_pn = {0};
+	union htt_rx_pn_t new_pn = {};
 	struct htt_hl_rx_desc *rx_desc;
 	struct ieee80211_hdr *hdr;
 	struct ieee80211_rx_status *rx_status;
@@ -2767,7 +2767,7 @@ static bool ath10k_htt_rx_proc_rx_frag_ind_hl(struct ath10k_htt *htt,
 	struct htt_rx_indication_hl *rx_hl;
 	enum htt_security_types sec_type;
 	u32 tid, frag, seq, rx_desc_info;
-	union htt_rx_pn_t new_pn = {0};
+	union htt_rx_pn_t new_pn = {};
 	struct htt_hl_rx_desc *rx_desc;
 	u16 peer_id, sc, hdr_space;
 	union htt_rx_pn_t *last_pn;
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index c1ddd761af3e9ff987fcfd3a55b8747e48783b9e..d6f1d85ba8713d4343605082d91b96ea0df900e7 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -510,7 +510,7 @@ static int ath10k_htt_tx_clean_up_pending(int msdu_id, void *skb, void *ctx)
 {
 	struct ath10k *ar = ctx;
 	struct ath10k_htt *htt = &ar->htt;
-	struct htt_tx_done tx_done = {0};
+	struct htt_tx_done tx_done = {};
 
 	ath10k_dbg(ar, ATH10K_DBG_HTT, "force cleanup msdu_id %u\n", msdu_id);
 
@@ -560,7 +560,7 @@ void ath10k_htt_op_ep_tx_credits(struct ath10k *ar)
 void ath10k_htt_htc_tx_complete(struct ath10k *ar, struct sk_buff *skb)
 {
 	struct ath10k_htt *htt = &ar->htt;
-	struct htt_tx_done tx_done = {0};
+	struct htt_tx_done tx_done = {};
 	struct htt_cmd_hdr *htt_hdr;
 	struct htt_data_tx_desc *desc_hdr = NULL;
 	u16 flags1 = 0;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 11569c18204c01c0d8d27ab731ce3c122d78f168..24dd794e31ea2ccd2f8c0481cda395dacce80ed5 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3385,7 +3385,7 @@ static int ath10k_update_channel_list(struct ath10k *ar)
 	struct ieee80211_supported_band **bands;
 	enum nl80211_band band;
 	struct ieee80211_channel *channel;
-	struct wmi_scan_chan_list_arg arg = {0};
+	struct wmi_scan_chan_list_arg arg = {};
 	struct wmi_channel_arg *ch;
 	bool passive;
 	int len;
@@ -4885,7 +4885,7 @@ static int ath10k_mac_get_vht_cap_bf_sound_dim(struct ath10k *ar)
 
 static struct ieee80211_sta_vht_cap ath10k_create_vht_cap(struct ath10k *ar)
 {
-	struct ieee80211_sta_vht_cap vht_cap = {0};
+	struct ieee80211_sta_vht_cap vht_cap = {};
 	struct ath10k_hw_params *hw = &ar->hw_params;
 	u16 mcs_map;
 	u32 val;
@@ -4943,7 +4943,7 @@ static struct ieee80211_sta_vht_cap ath10k_create_vht_cap(struct ath10k *ar)
 static struct ieee80211_sta_ht_cap ath10k_get_ht_cap(struct ath10k *ar)
 {
 	int i;
-	struct ieee80211_sta_ht_cap ht_cap = {0};
+	struct ieee80211_sta_ht_cap ht_cap = {};
 
 	if (!(ar->ht_cap_info & WMI_HT_CAP_ENABLED))
 		return ht_cap;
@@ -5175,7 +5175,7 @@ static int ath10k_start(struct ieee80211_hw *hw)
 	struct ath10k *ar = hw->priv;
 	u32 param;
 	int ret = 0;
-	struct wmi_bb_timing_cfg_arg bb_timing = {0};
+	struct wmi_bb_timing_cfg_arg bb_timing = {};
 
 	/*
 	 * This makes sense only when restarting hw. It is harmless to call
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 1e6d43285138ece619b9d7dc49f113a439e2085d..97b49bf4ad80916dd139acd5f5744922317191aa 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/pci.h>
@@ -63,7 +64,7 @@ static const struct pci_device_id ath10k_pci_id_table[] = {
 	{ PCI_VDEVICE(ATHEROS, QCA9984_1_0_DEVICE_ID) }, /* PCI-E QCA9984 V1 */
 	{ PCI_VDEVICE(ATHEROS, QCA9377_1_0_DEVICE_ID) }, /* PCI-E QCA9377 V1 */
 	{ PCI_VDEVICE(ATHEROS, QCA9887_1_0_DEVICE_ID) }, /* PCI-E QCA9887 */
-	{0}
+	{}
 };
 
 static const struct ath10k_pci_supp_chip ath10k_pci_supp_chips[] = {

---
base-commit: 9e8086b865ab458e4a1ae520aa3a4f304a0a0539
change-id: 20250718-ath10k-zero-brace-236a5879d8c3


