Return-Path: <linux-wireless+bounces-28395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8217AC1E59D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 05:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317081890F20
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 04:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAD02F12BE;
	Thu, 30 Oct 2025 04:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mtXROhUK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DxIgBp2y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A990223715
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798718; cv=none; b=aaEF6yQsNM1zGBFwojUcxijATi59u/vqVdqepJCwpgRyzboh+UBGBYvfK8FlpMsI41gS1qn1D+20HK9ON4n2SxUDsn6wnj1VWW/iNXwvdEZffbmtaYMeKU+Wx+gAJK5HrUEz+2hnrZugLQEU1fZeRiNyu659rXJYH4OE2pshBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798718; c=relaxed/simple;
	bh=0YsPlQzQUDpKBKLk9TeWc8Hatk5Ixvaq6eX4dUvz2S0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NcpJMoGR2lGmm4ZYZfbHeqdYpvY9QzPZk74U++2Kmu0ZEtTMmYKTPZvF77N3UumXDxw0UZJimUmNcernZF25+rhaqTtEqSQzKidpHHrOf0nskz5jazLveeh7itdEH4WdRb608Hn1S56t1y+2bL9PVbZdTs86vA6imt5mUQhNyKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mtXROhUK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DxIgBp2y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U0d0IA811145
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 04:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=spCyHmehyGY
	T6p3u/kA7drMtAU2lkKaQNQlSdVw+Uv4=; b=mtXROhUKUR0BTX8zAl3swhtLDxY
	D9G4yubKcRw32rsa0Qu9si1T9Kg5afEb9XO5ughRVuipXJx/10acDYhf5GmkJyrv
	JStaQSOHjk2YJgmz3WQqGA5PZMbpKKDEIBWnO5MGBAwfsZRuuUwcOCYlg1IMDLNy
	+484crU6DTSeB5XIhDVNJTnNlc/cAeZWrhkBU+o/Cqc7uhp2qQusfAiDGURDX2NN
	RPAIoMexGmohEjQPPacJSLq8eIzcRR/HElCqRmodB0IHhyXuP3kh4w41JX6Rwu+s
	6/wAZ5zYzlqlXCHdaiGsZIy6h+AR1FEtJP+MFkh24ZBu4LLzvmao3FYAK0g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3mvga7tp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 04:31:54 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a675fbd6c3so517781b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 21:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761798714; x=1762403514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spCyHmehyGYT6p3u/kA7drMtAU2lkKaQNQlSdVw+Uv4=;
        b=DxIgBp2yMxSMKjqGxNjU+UuoC5BQdDVf5ELip4zAcS0MnQocCPshnxSruJ+OymfVcq
         /HRAYd5kQ/OrihTtmxu70EfOKUsfUJ/cbS+nObeCBDyTTsfnh52t9Ne0mJzfRbEe4FeT
         03/DgsajQLcKWs7hm3OZMONi1JVRaFPghZ6uf2lFOQ2ISL/9B2N1H2zYQLCM0QH5gFJe
         hUlnc3uVGagV0LjAwvmWJlmOJpfPVLWOsTfM/OmtfpMK8B6Mu6pjB2dh+Mgvah5Ypbgl
         Xh0lu9kXyC1ZPiHxcouvE6EKQNe8+GFTXjHyWxO149Re8PZ01zZoz5JOia2WBOfv6TC3
         0zHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761798714; x=1762403514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spCyHmehyGYT6p3u/kA7drMtAU2lkKaQNQlSdVw+Uv4=;
        b=PHzWcC2pR/y5iwwNz7CSqk6RQo2PptdQdP1LzCcEhGLtX5Msc0M26iPZDWzbeMZuPv
         V2C5dEp+Y3XTKsQQ5yJxN/eKyaI2vNxzuIDbo36QT4Bu/yQhPw5Xv9gDK5OfzoMpPRQe
         QTbn/csqXw2vSdiVIv04xFaVCD3xnyNextkNfaYxe9xh8xsqaM0whSAjfMFLYsSUFbYG
         0gD0sfeqvU561sPNo+68Ej8sKhG15DIpMGx0nWkqVz/K2x5TcD4WThVQ1uGkexsZl25d
         iGn/CLMghrgylM4dAF8WhVOLD3qT2Vfz8DKUsqnF1L8N4X662EoF6+1egO1k5eWkIyay
         /qAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjSvGKtK/URlvtIhmzdc+vS4ZmmBwGCKnXBDlqInhaJ6q/D0N3iEcXRKMNdAATWCRM+/rA1fNx8C0AtMNlmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd76nTIVB3zTY1UqcoUqyTqwkxrP8Hr52apV9Sj8B25mGOIJRX
	Ude83zdP5KGLr9WGGLzotrNAE624TRoBn7Dhc0gfeokDJZjO36ziOhWSN9qpA5BGOhL1hhLV1ov
	h7Mxbv48OiJ6A1r+JcTZtIrDikH5ch/t8VY2wp1tDxtH6N4ZJws+zCBjZM5JaYwb/I0jNTw==
X-Gm-Gg: ASbGncuIrXxzBIIQHqctFKygN3UpFqExsbPxdoIlHoXCWpU4N9JoOCgnDaD/XMlR+Gq
	Jbh4cSsk7wpMB7I91hIUcaGLYS1Pi2X0BDC6R7ZVr6+m4szXZkMZlyhqGjl6/uwCwVU/cAOZXCe
	ujN8IhCjZKS+bLBiW8Y5y8bt/PRgBnUaHQ67Afc8wMm7veNaiqEHGK6y4MNnhA5n1Z5nCD7gj4w
	9yUJKRdGTw0xi0BgmHSZmjU1Jlzj+/tJ8sgTy5/Ame9o1tg+YA9y9HvVMJEtNWTp0AM1BO45DdX
	YSGz0dhf0hb3uwgq+xZJ5bWxW/TLL5tIVRk+uZsA0BVZ80iL9YdDBt3p/oXaPSVkFldI7I71PjJ
	YmhRpv4meG/jUKPBEel4DrPXys8DAgo8HCTeqerkkZByr
X-Received: by 2002:a05:6a00:928f:b0:7a2:2381:d1df with SMTP id d2e1a72fcca58-7a4e51fcde5mr5425820b3a.22.1761798713315;
        Wed, 29 Oct 2025 21:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTNCng0KlUk+cmaWgkFAh/ViFsfsul3LjC3NiGcpMMykyk7/B8D2H8A+lJt/DS1le0qd2mGg==
X-Received: by 2002:a05:6a00:928f:b0:7a2:2381:d1df with SMTP id d2e1a72fcca58-7a4e51fcde5mr5425794b3a.22.1761798712633;
        Wed, 29 Oct 2025 21:31:52 -0700 (PDT)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409e456sm16912161b3a.71.2025.10.29.21.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 21:31:52 -0700 (PDT)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: [PATCH ath-next 1/6] wifi: ath11k: Add initialization and deinitialization sequence for CFR module
Date: Wed, 29 Oct 2025 21:31:45 -0700
Message-Id: <20251030043150.3905086-2-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAzNCBTYWx0ZWRfX2jWpUwQDRcuc
 VoxHbo+s5MNF10xEWqT5paEwmztAkl2tjgoKjBds34J4/DlkanEER5Rcn/8sDX2zZcxxKpYuWhq
 lvDa7nrhKsxqXo4KRE3cKxRYiN0HRM/JNwfjEouXvImx6+kjB+Sd1+2bL/FaO1ZwyMC8msfjkkp
 HLa2oMrhUsBbXmlpniMDNQP59gIvO/T1ndaSeUM/hQrLmcYIW0M/gpyb9vAhkeYY7ElnkNDof6P
 Yy29INZbjTkx+ema0I6FEOH4x7nnPIrWTS27LzHfT8sIURkPPWuSzsRvPu0Ig0s2kAjAnEI78Rv
 p3eazKir0B4HvZ3MMOh8Hx/F5dinWw8aRP82DRtSKusPrKwTNQaa7qbLHXITgGR7b+trFWxYp3O
 u64tvLpc9gREIwMjWLy+GrOLyKgpsw==
X-Authority-Analysis: v=2.4 cv=S8XUAYsP c=1 sm=1 tr=0 ts=6902ea3a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=sTJiG90S0w3vqaoQ0_0A:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: GAhRZhlFs72t-vGDLQYYEmNsAmgJ8IKX
X-Proofpoint-ORIG-GUID: GAhRZhlFs72t-vGDLQYYEmNsAmgJ8IKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300034

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

Channel Frequency Response (CFR) module will be initialized only when
the following criteria passes:
 * Enabled CFR support for the hardware through the hardware param
   'cfr_support'
 * WMI service enabled for the CFR support
   'WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT'

Also, provide a configuration option CONFIG_ATH11K_CFR to enable CFR
feature support during the compilation time.

CFR module initialization includes Direct Buffer(DB) ring initialization
where hardware uses the DB ring buffers to copy CFR data to host.
Number of buffers and buffer size of the ring is based on the DB ring
capabilities advertised by the firmware through WMI service ready.
Also ring configurations are sent to firmware through
ath11k_dbring_wmi_cfg_setup().

Predefine ath11k_cfr_dma_hdr, ath11k_look_up_table, and ath11k_cfr
structs and fields for subsequent patches.

Tested-on: IPQ8074 hw2.0 PCI IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Co-developed-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/Kconfig  |  11 ++
 drivers/net/wireless/ath/ath11k/Makefile |   1 +
 drivers/net/wireless/ath/ath11k/cfr.c    | 160 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h    |  84 ++++++++++++
 drivers/net/wireless/ath/ath11k/core.c   |  41 +++++-
 drivers/net/wireless/ath/ath11k/core.h   |   8 +-
 drivers/net/wireless/ath/ath11k/dbring.c |  40 ++++--
 drivers/net/wireless/ath/ath11k/dbring.h |   6 +-
 drivers/net/wireless/ath/ath11k/hal.c    |   3 +-
 drivers/net/wireless/ath/ath11k/hw.h     |   5 +-
 drivers/net/wireless/ath/ath11k/wmi.h    |   1 +
 11 files changed, 343 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 659ef134ef16..47dfd39caa89 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -58,3 +58,14 @@ config ATH11K_SPECTRAL
 	  Enable ath11k spectral scan support
 
 	  Say Y to enable access to the FFT/spectral data via debugfs.
+
+config ATH11K_CFR
+	bool "ath11k channel frequency response support"
+	depends on ATH11K_DEBUGFS
+	depends on RELAY
+	help
+	  Enable ath11k channel frequency response dump support.
+	  This option exposes debugfs nodes that will allow the user
+	  to enable, disable, and dump data.
+
+	  Say Y to enable CFR data dump collection via debugfs.
diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index d9092414b362..b1435fcf3e1b 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -28,6 +28,7 @@ ath11k-$(CONFIG_THERMAL) += thermal.o
 ath11k-$(CONFIG_ATH11K_SPECTRAL) += spectral.o
 ath11k-$(CONFIG_PM) += wow.o
 ath11k-$(CONFIG_DEV_COREDUMP) += coredump.o
+ath11k-$(CONFIG_ATH11K_CFR) += cfr.o
 
 obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
 ath11k_ahb-y += ahb.o
diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
new file mode 100644
index 000000000000..d057e4556c24
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/relay.h>
+#include "core.h"
+#include "debug.h"
+
+static int ath11k_cfr_process_data(struct ath11k *ar,
+				   struct ath11k_dbring_data *param)
+{
+	return 0;
+}
+
+void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
+				 u32 buf_id)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+
+	if (cfr->lut)
+		cfr->lut[buf_id].dbr_address = paddr;
+}
+
+static void ath11k_cfr_ring_free(struct ath11k *ar)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+
+	ath11k_dbring_buf_cleanup(ar, &cfr->rx_ring);
+	ath11k_dbring_srng_cleanup(ar, &cfr->rx_ring);
+}
+
+static int ath11k_cfr_ring_alloc(struct ath11k *ar,
+				 struct ath11k_dbring_cap *db_cap)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	int ret;
+
+	ret = ath11k_dbring_srng_setup(ar, &cfr->rx_ring,
+				       ATH11K_CFR_NUM_RING_ENTRIES,
+				       db_cap->min_elem);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring: %d\n", ret);
+		return ret;
+	}
+
+	ath11k_dbring_set_cfg(ar, &cfr->rx_ring,
+			      ATH11K_CFR_NUM_RESP_PER_EVENT,
+			      ATH11K_CFR_EVENT_TIMEOUT_MS,
+			      ath11k_cfr_process_data);
+
+	ret = ath11k_dbring_buf_setup(ar, &cfr->rx_ring, db_cap);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring buffer: %d\n", ret);
+		goto srng_cleanup;
+	}
+
+	ret = ath11k_dbring_wmi_cfg_setup(ar, &cfr->rx_ring, WMI_DIRECT_BUF_CFR);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring cfg: %d\n", ret);
+		goto buffer_cleanup;
+	}
+
+	return 0;
+
+buffer_cleanup:
+	ath11k_dbring_buf_cleanup(ar, &cfr->rx_ring);
+srng_cleanup:
+	ath11k_dbring_srng_cleanup(ar, &cfr->rx_ring);
+	return ret;
+}
+
+void ath11k_cfr_deinit(struct ath11k_base *ab)
+{
+	struct ath11k_pdev *pdev;
+	struct ath11k_cfr *cfr;
+	struct ath11k *ar;
+	int i;
+
+	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
+	    !ab->hw_params.cfr_support)
+		return;
+
+	for (i = 0; i <  ab->num_radios; i++) {
+		pdev = rcu_dereference(ab->pdevs_active[i]);
+		if (pdev && pdev->ar) {
+			ar = ab->pdevs[i].ar;
+			cfr = &ar->cfr;
+
+			ath11k_cfr_ring_free(ar);
+
+			spin_lock_bh(&cfr->lut_lock);
+			kfree(cfr->lut);
+			cfr->lut = NULL;
+			spin_unlock_bh(&cfr->lut_lock);
+		}
+	}
+}
+
+int ath11k_cfr_init(struct ath11k_base *ab)
+{
+	struct ath11k_dbring_cap db_cap;
+	struct ath11k_cfr *cfr;
+	u32 num_lut_entries;
+	struct ath11k *ar;
+	int i, ret;
+
+	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
+	    !ab->hw_params.cfr_support)
+		return 0;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		cfr = &ar->cfr;
+
+		ret = ath11k_dbring_get_cap(ar->ab, ar->pdev_idx,
+					    WMI_DIRECT_BUF_CFR, &db_cap);
+		if (ret)
+			continue;
+
+		idr_init(&cfr->rx_ring.bufs_idr);
+		spin_lock_init(&cfr->rx_ring.idr_lock);
+		spin_lock_init(&cfr->lock);
+		spin_lock_init(&cfr->lut_lock);
+
+		num_lut_entries = min_t(u32, CFR_MAX_LUT_ENTRIES, db_cap.min_elem);
+		cfr->lut = kcalloc(num_lut_entries, sizeof(*cfr->lut),
+				   GFP_KERNEL);
+		if (!cfr->lut) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		ret = ath11k_cfr_ring_alloc(ar, &db_cap);
+		if (ret) {
+			ath11k_warn(ab, "failed to init cfr ring for pdev %d: %d\n",
+				    i, ret);
+			goto err;
+		}
+
+		cfr->lut_num = num_lut_entries;
+	}
+
+	return 0;
+
+err:
+	for (i = i - 1; i >= 0; i--) {
+		ar = ab->pdevs[i].ar;
+		cfr = &ar->cfr;
+
+		ath11k_cfr_ring_free(ar);
+
+		spin_lock_bh(&cfr->lut_lock);
+		kfree(cfr->lut);
+		cfr->lut = NULL;
+		spin_unlock_bh(&cfr->lut_lock);
+	}
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
new file mode 100644
index 000000000000..65b87d759329
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH11K_CFR_H
+#define ATH11K_CFR_H
+
+#include "dbring.h"
+#include "wmi.h"
+
+#define ATH11K_CFR_NUM_RESP_PER_EVENT   1
+#define ATH11K_CFR_EVENT_TIMEOUT_MS     1
+#define ATH11K_CFR_NUM_RING_ENTRIES     1
+
+#define CFR_MAX_LUT_ENTRIES 136
+
+#define HOST_MAX_CHAINS 8
+
+struct ath11k_cfr_dma_hdr {
+	u16 info0;
+	u16 info1;
+	u16 sw_peer_id;
+	u16 phy_ppdu_id;
+};
+
+struct ath11k_look_up_table {
+	bool dbr_recv;
+	bool tx_recv;
+	u8 *data;
+	u32 data_len;
+	u16 dbr_ppdu_id;
+	u16 tx_ppdu_id;
+	dma_addr_t dbr_address;
+	struct ath11k_cfr_dma_hdr hdr;
+	u64 txrx_tstamp;
+	u64 dbr_tstamp;
+	u32 header_length;
+	u32 payload_length;
+	struct ath11k_dbring_element *buff;
+};
+
+struct ath11k_cfr {
+	struct ath11k_dbring rx_ring;
+	/* Protects cfr data */
+	spinlock_t lock;
+	/* Protect for lut entries */
+	spinlock_t lut_lock;
+	struct ath11k_look_up_table *lut;
+	u32 lut_num;
+	u64 tx_evt_cnt;
+	u64 dbr_evt_cnt;
+	u64 release_cnt;
+	u64 tx_peer_status_cfr_fail;
+	u64 tx_evt_status_cfr_fail;
+	u64 tx_dbr_lookup_fail;
+	u64 last_success_tstamp;
+	u64 flush_dbr_cnt;
+	u64 clear_txrx_event;
+	u64 cfr_dma_aborts;
+};
+
+#ifdef CONFIG_ATH11K_CFR
+int ath11k_cfr_init(struct ath11k_base *ab);
+void ath11k_cfr_deinit(struct ath11k_base *ab);
+void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
+				 u32 buf_id);
+#else
+static inline int ath11k_cfr_init(struct ath11k_base *ab)
+{
+	return 0;
+}
+
+static inline void ath11k_cfr_deinit(struct ath11k_base *ab)
+{
+}
+
+static inline void ath11k_cfr_lut_update_paddr(struct ath11k *ar,
+					       dma_addr_t paddr, u32 buf_id)
+{
+}
+#endif /* CONFIG_ATH11K_CFR */
+#endif /* ATH11K_CFR_H */
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 2810752260f2..71926a774f57 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -126,6 +125,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_dual_stations = false,
 		.pdev_suspend = false,
+		.cfr_support = true,
+		.cfr_num_stream_bufs = 255,
+		.cfr_stream_buf_size = 8200,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -211,6 +213,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = false,
 		.support_dual_stations = false,
 		.pdev_suspend = false,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -301,6 +306,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
 		.pdev_suspend = false,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -385,6 +393,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = false,
 		.support_dual_stations = false,
 		.pdev_suspend = false,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -475,6 +486,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
 		.pdev_suspend = false,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -563,6 +577,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
 		.pdev_suspend = false,
+		.cfr_support = true,
+		.cfr_num_stream_bufs = 255,
+		.cfr_stream_buf_size = 8200,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -646,6 +663,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = false,
 		.pdev_suspend = true,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ5018_HW10,
@@ -729,6 +749,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = false,
 		.support_dual_stations = false,
 		.pdev_suspend = false,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "qca2066 hw2.1",
@@ -818,6 +841,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "qca6698aq hw2.1",
@@ -906,6 +932,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
 		.pdev_suspend = false,
+		.cfr_support = true,
+		.cfr_num_stream_bufs = 255,
+		.cfr_stream_buf_size = 8200,
 	},
 };
 
@@ -1945,8 +1974,16 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 		goto err_thermal_unregister;
 	}
 
+	ret = ath11k_cfr_init(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to init cfr %d\n", ret);
+		goto err_spectral_unregister;
+	}
+
 	return 0;
 
+err_spectral_unregister:
+	ath11k_spectral_deinit(ab);
 err_thermal_unregister:
 	ath11k_thermal_unregister(ab);
 err_mac_unregister:
@@ -1996,6 +2033,7 @@ static void ath11k_core_pdev_suspend_target(struct ath11k_base *ab)
 
 static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
+	ath11k_cfr_deinit(ab);
 	ath11k_spectral_deinit(ab);
 	ath11k_thermal_unregister(ab);
 	ath11k_mac_unregister(ab);
@@ -2208,6 +2246,7 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	mutex_lock(&ab->core_lock);
 	ath11k_thermal_unregister(ab);
 	ath11k_dp_pdev_free(ab);
+	ath11k_cfr_deinit(ab);
 	ath11k_spectral_deinit(ab);
 	ath11k_ce_cleanup_pipes(ab);
 	ath11k_wmi_detach(ab);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index e8780b05ce11..40fb7cee3e43 100644
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
@@ -35,6 +35,7 @@
 #include "wow.h"
 #include "fw.h"
 #include "coredump.h"
+#include "cfr.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -795,6 +796,11 @@ struct ath11k {
 	bool ps_state_enable;
 	bool ps_timekeeper_enable;
 	s8 max_allowed_tx_power;
+
+#ifdef CONFIG_ATH11K_CFR
+	struct ath11k_cfr cfr;
+#endif
+	bool cfr_enabled;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index 520d8b8662a2..ed2b781a6bab 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -37,10 +36,10 @@ static void ath11k_dbring_fill_magic_value(struct ath11k *ar,
 	memset32(buffer, ATH11K_DB_MAGIC_VALUE, size);
 }
 
-static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
-					struct ath11k_dbring *ring,
-					struct ath11k_dbring_element *buff,
-					enum wmi_direct_buffer_module id)
+int ath11k_dbring_bufs_replenish(struct ath11k *ar,
+				 struct ath11k_dbring *ring,
+				 struct ath11k_dbring_element *buff,
+				 enum wmi_direct_buffer_module id)
 {
 	struct ath11k_base *ab = ar->ab;
 	struct hal_srng *srng;
@@ -80,6 +79,9 @@ static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 		goto err_idr_remove;
 	}
 
+	if (id == WMI_DIRECT_BUF_CFR)
+		ath11k_cfr_lut_update_paddr(ar, paddr, buf_id);
+
 	buff->paddr = paddr;
 
 	cookie = FIELD_PREP(DP_RXDMA_BUF_COOKIE_PDEV_ID, ar->pdev_idx) |
@@ -155,12 +157,11 @@ int ath11k_dbring_wmi_cfg_setup(struct ath11k *ar,
 				enum wmi_direct_buffer_module id)
 {
 	struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd param = {};
-	int ret;
+	int ret, i;
 
 	if (id >= WMI_DIRECT_BUF_MAX)
 		return -EINVAL;
 
-	param.pdev_id		= DP_SW2HW_MACID(ring->pdev_id);
 	param.module_id		= id;
 	param.base_paddr_lo	= lower_32_bits(ring->refill_srng.paddr);
 	param.base_paddr_hi	= upper_32_bits(ring->refill_srng.paddr);
@@ -173,10 +174,23 @@ int ath11k_dbring_wmi_cfg_setup(struct ath11k *ar,
 	param.num_resp_per_event = ring->num_resp_per_event;
 	param.event_timeout_ms	= ring->event_timeout_ms;
 
-	ret = ath11k_wmi_pdev_dma_ring_cfg(ar, &param);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to setup db ring cfg\n");
-		return ret;
+	/* For single pdev, 2GHz and 5GHz use one DBR. */
+	if (ar->ab->hw_params.single_pdev_only) {
+		for (i = 0; i < ar->ab->target_pdev_count; i++) {
+			param.pdev_id = ar->ab->target_pdev_ids[i].pdev_id;
+			ret = ath11k_wmi_pdev_dma_ring_cfg(ar, &param);
+			if (ret) {
+				ath11k_warn(ar->ab, "failed to setup db ring cfg\n");
+				return ret;
+			}
+		}
+	} else {
+		param.pdev_id = DP_SW2HW_MACID(ring->pdev_id);
+		ret = ath11k_wmi_pdev_dma_ring_cfg(ar, &param);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to setup db ring cfg\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -285,6 +299,10 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	pdev_idx = ev->fixed.pdev_id;
 	module_id = ev->fixed.module_id;
 
+	if (ab->hw_params.single_pdev_only &&
+	    pdev_idx < ab->target_pdev_count)
+		pdev_idx = 0;
+
 	if (pdev_idx >= ab->num_radios) {
 		ath11k_warn(ab, "Invalid pdev id %d\n", pdev_idx);
 		return -EINVAL;
diff --git a/drivers/net/wireless/ath/ath11k/dbring.h b/drivers/net/wireless/ath/ath11k/dbring.h
index 2f93b78a50df..0a380120f7a0 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.h
+++ b/drivers/net/wireless/ath/ath11k/dbring.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_DBRING_H
@@ -61,6 +61,10 @@ int ath11k_dbring_set_cfg(struct ath11k *ar,
 			  u32 event_timeout_ms,
 			  int (*handler)(struct ath11k *,
 					 struct ath11k_dbring_data *));
+int ath11k_dbring_bufs_replenish(struct ath11k *ar,
+				 struct ath11k_dbring *ring,
+				 struct ath11k_dbring_element *buff,
+				 enum wmi_direct_buffer_module id);
 int ath11k_dbring_wmi_cfg_setup(struct ath11k *ar,
 				struct ath11k_dbring *ring,
 				enum wmi_direct_buffer_module id);
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 0c797b8d0a27..e821e5a62c1c 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/dma-mapping.h>
@@ -184,7 +183,7 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 	},
 	{ /* RXDMA DIR BUF */
 		.start_ring_id = HAL_SRNG_RING_ID_RXDMA_DIR_BUF,
-		.max_rings = 1,
+		.max_rings = 2,
 		.entry_size = 8 >> 2, /* TODO: Define the struct */
 		.lmac_ring = true,
 		.ring_dir = HAL_SRNG_DIR_SRC,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 52d9f4c13b13..e13ca02a9d05 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_HW_H
@@ -228,6 +228,9 @@ struct ath11k_hw_params {
 	bool support_fw_mac_sequence;
 	bool support_dual_stations;
 	bool pdev_suspend;
+	bool cfr_support;
+	u32 cfr_num_stream_bufs;
+	u32 cfr_stream_buf_size;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 0f0de24a3840..7a55fe0879c0 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -981,6 +981,7 @@ enum wmi_tlv_pdev_param {
 	WMI_PDEV_PARAM_RADIO_CHAN_STATS_ENABLE,
 	WMI_PDEV_PARAM_RADIO_DIAGNOSIS_ENABLE,
 	WMI_PDEV_PARAM_MESH_MCAST_ENABLE,
+	WMI_PDEV_PARAM_PER_PEER_CFR_ENABLE = 0xa8,
 	WMI_PDEV_PARAM_SET_CMD_OBSS_PD_THRESHOLD = 0xbc,
 	WMI_PDEV_PARAM_SET_CMD_OBSS_PD_PER_AC = 0xbe,
 	WMI_PDEV_PARAM_ENABLE_SR_PROHIBIT = 0xc6,
-- 
2.34.1


