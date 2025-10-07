Return-Path: <linux-wireless+bounces-27861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97045BC1812
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 15:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D2F3A49FD
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46043225785;
	Tue,  7 Oct 2025 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OzPpIme1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921625FDA7
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844033; cv=none; b=uRnhC4nimu2OcuFSBfW6Guh8zTl97if9yvzG0uzsE2eiSiQ4WgWMNVo27xqvSKZo0xA5835kgeft7ag+3QLhkGbKhh/UfZNdIqy0/oH7NYGq3io7mnzx/n4hFqOykwAnJkpgIRxTiOabGi4PVrBOrPel128Msx8645j+GWPXwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844033; c=relaxed/simple;
	bh=ZILx2XFsWToDj3mRwbYGNvlyC+UGZbD97jw1+WZnfLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CO81geufSqhS3+GqwJWtB12uXyZrwUEj0WQxY/dp9+kyICsHZX8zEmnmUr/RaLdCvf6s0A+/7YnmSZXSCJ8kL+JQa+5RZey5TNSnxXtTFC2QJ4aZgbV8+vM+QLZGumA3hdxqoojiGZeOFS1vqYjwGUAuBia7THPCLosT3mIvra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OzPpIme1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597DNIim026536
	for <linux-wireless@vger.kernel.org>; Tue, 7 Oct 2025 13:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=niQkkf7HgMoKKp1+WrllKQhIsL/j0I6kBde
	vJ4pk0+0=; b=OzPpIme1cZ63RNgrtIFfXjqFbkpj4kHKFgDxnPaqzltQaQ+SDYP
	6zcOqoWsl6llsezhUrBlyHgROA/HtC06z94cNZ7GZ8X/eQtDjkZL+NPVdqQYVNNL
	I+YalawD/1+nAqR2GTKg+pJ7MXqr5iJhdD/Fyj+LeTxZoJEUrtitUW4GSJONfxcw
	CQj0l4IigRwkgU4o/a6kiIHRw0XdoOeXhJJbXAWCj9oiFA7bWcjT5XjAmTwxz1JG
	W4yVOGD7Qsk+II2NZaergOiakSimO9OwAWHm+WYV6m/0ax0mnxTeyx5zoh7givSC
	FTy7y8NxoiCgpOyZ0pImMj7+GUxUU7ceXWQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgqcp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 13:33:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-792722e4ebeso987994b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 06:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844029; x=1760448829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niQkkf7HgMoKKp1+WrllKQhIsL/j0I6kBdevJ4pk0+0=;
        b=JWCP9v0bGtkbp2STSwGayJvRwtidLw92XQPEm94k6NxOSQ8cTlyb6I+2l1ApQCcTcG
         MJ1i1YBKyXjbl5PqxYdZoYDxR484G0HjYCL9mg8iuM1mEFHx4QCwB4kU8S4ShfGiaq67
         u4+BMdVkC5Nen4HMLzY5+CMvOSsECz32DyCygtCMEdnU4ni8+Bat2Tqu9YVcZkKLQsCy
         IaU8okZ/zB5+XdqRP4SX8kkJmCCdYLDjQ8rC26W+ZtyVmSplnlXFOXegBdaPi4VMgnOT
         FjYZx/uyKztBtnIvUOjFd3CEfAAnqEdPNri+5WdpClutJStxftcWU4HEl1FxVftvXClg
         wd0g==
X-Gm-Message-State: AOJu0YwaQP5yXyVDKAuCV/5wxzcIUwBEijDj4QNOmpFeE/OHmfmN97UQ
	6eJdQKnH+coP2Y5FdPHr6gIDxnuixo9eJOX7B4lBf0q6jv7bJgDe/wxKgUPkkQpokmR7a674uxw
	yWcjmQzwguNN0uHjlTYzhMrBh60VTTLOJLKLFjjAbMbUBloAZtXFfl2IZTco0vmljcXj5TQ==
X-Gm-Gg: ASbGncvESstkKgmR2WotV8/czpbyzyhx32fEyohUXrTpvzMeHj1I3764brg4XYfEXvm
	1KEpvNffIbKgojYwV7+xtJrScpJdIgx1jlsEV9zR0GIjLaZ4vO5Fx4Anf9CJHN/qDb6nH0wgk6D
	aKWgRhDxtshd0tYLzaYytHSNdQuj5ko9ulruYNMzaCYIcQ0Q5+QRsjQrNvfcxYs8DM8bb9UvrYa
	HnF+B05J6Zo0JnYjgCEVQbzYV82NW2C8NpqsEKLjuQLLcMYKsDiRJ1nuRVffvidUnYIA6EvD85F
	dFtTAxXLCn8XFbBdI0qkYARJv8KXSeiiHAPKdR7iwfJNC8ezYdRlPwi7KgosThGueDSiPD92OwO
	o7J5G5NTkWfOKC2kzD5ZOfU3YPr/zK19JWBhODalB4vPvDMVRygDIbrTrcq2/ahPSoxmPZscana
	GniQ==
X-Received: by 2002:a05:6a20:7fa5:b0:2fa:516e:26b5 with SMTP id adf61e73a8af0-32b61e58364mr20907838637.20.1759844028790;
        Tue, 07 Oct 2025 06:33:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd4uOTYbCCqX64dZuLBwCZIQP8tE0wWh9u3cKOdDbFxUzaBtFKggP1sH/FQpelDTRU5YYxFA==
X-Received: by 2002:a05:6a20:7fa5:b0:2fa:516e:26b5 with SMTP id adf61e73a8af0-32b61e58364mr20907804637.20.1759844028298;
        Tue, 07 Oct 2025 06:33:48 -0700 (PDT)
Received: from hu-tmariyap-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b81760e58sm14045353b3a.24.2025.10.07.06.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:33:47 -0700 (PDT)
From: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Fix NSS value update in ext_rx_stats
Date: Tue,  7 Oct 2025 19:03:32 +0530
Message-Id: <20251007133332.1092178-1-thiraviyam.mariyappan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX0zyPxOj74YSo
 iqgVi2LqNXSj83/d8IFx5C6dDkriRczFh0enFCoKoMRV6/HWqpscgZzqRPu3GGKIRa/yC5UbMsr
 8eSgCP5xCbXIOZOBtA7uxfTw/kuWdZWzA9faqRmaoe+6kN3a6Bbh1+Mmn7yexeTy+AGTrVZfD46
 r0TlPX+g4xon+31/9jdZazTtR4JxBOfoEJV/JDiRSStPVaDmPY7No05E2IcSnCWmKDobBzgKqoY
 ezOvTMwqossqtJxv0PxfIag5YzngiLJZ+8wJDigOXCHoKgDxtRyfLzdFuMhXd9FfkwxmAu40UoS
 AHog3+JXznGJigmhe5dxD7yTsljENPRCjRXfdb2z57zKhP6hGscEox9GJ3P1te1ymmkN3LuDFir
 O4B8zaybEgnolyFTjnohIpGbUVK2VA==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e516be cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=WCOCDAP-shxDn94hZWYA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: -uJbDFdSc2ZgDDCKJ2PkJu47xTYC_Kmk
X-Proofpoint-ORIG-GUID: -uJbDFdSc2ZgDDCKJ2PkJu47xTYC_Kmk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

Currently, in ext_rx_stats, the NSS value is taken directly from
the firmware, which results in incorrect mapping:
        4x4, 3x3, 2x2, 1x1 SS are incorrectly updated as 3x3, 2x2,
1x1, 0x0 SS respectively.

Fix the issue by incrementing the NSS value by 1 while updating
the PPDU info to ensure accurate spatial stream statistics.

Remove the redundant +1 increment in the radiotap header when monitor
mode is enabled to prevent double counting.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
---
Changes in v2:
 - Rebased and changed copyright to QTI.
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 009c49502148..39d1967584db 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "dp_mon.h"
@@ -105,7 +105,7 @@ static void ath12k_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vh
 	if (ppdu_info->is_stbc && nsts > 0)
 		nsts = ((nsts + 1) >> 1) - 1;
 
-	ppdu_info->nss = u32_get_bits(nsts, VHT_SIG_SU_NSS_MASK);
+	ppdu_info->nss = u32_get_bits(nsts, VHT_SIG_SU_NSS_MASK) + 1;
 	ppdu_info->bw = u32_get_bits(info0, HAL_RX_VHT_SIG_A_INFO_INFO0_BW);
 	ppdu_info->beamformed = u32_get_bits(info1,
 					     HAL_RX_VHT_SIG_A_INFO_INFO1_BEAMFORMED);
@@ -129,7 +129,7 @@ static void ath12k_dp_mon_parse_ht_sig(const struct hal_rx_ht_sig_info *ht_sig,
 	ppdu_info->is_stbc = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_STBC);
 	ppdu_info->ldpc = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_FEC_CODING);
 	ppdu_info->gi = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_GI);
-	ppdu_info->nss = (ppdu_info->mcs >> 3);
+	ppdu_info->nss = (ppdu_info->mcs >> 3) + 1;
 }
 
 static void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
@@ -233,7 +233,9 @@ ath12k_dp_mon_parse_he_sig_b2_ofdma(const struct hal_rx_he_sig_b2_ofdma_info *of
 	value = value << HE_STA_ID_SHIFT;
 	ppdu_info->he_data4 |= value;
 
-	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_NSTS);
+	ppdu_info->nss =
+		u32_get_bits(info0,
+			     HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_NSTS) + 1;
 	ppdu_info->beamformed = u32_get_bits(info0,
 					     HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF);
 }
@@ -261,7 +263,9 @@ ath12k_dp_mon_parse_he_sig_b2_mu(const struct hal_rx_he_sig_b2_mu_info *he_sig_b
 	value = value << HE_STA_ID_SHIFT;
 	ppdu_info->he_data4 |= value;
 
-	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_NSTS);
+	ppdu_info->nss =
+		u32_get_bits(info0,
+			     HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_NSTS) + 1;
 }
 
 static void
@@ -553,7 +557,8 @@ static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *
 	ppdu_info->is_stbc = u32_get_bits(info1, HAL_RX_HE_SIG_A_SU_INFO_INFO1_STBC);
 	ppdu_info->beamformed = u32_get_bits(info1, HAL_RX_HE_SIG_A_SU_INFO_INFO1_TXBF);
 	dcm = u32_get_bits(info0, HAL_RX_HE_SIG_A_SU_INFO_INFO0_DCM);
-	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_A_SU_INFO_INFO0_NSTS);
+	ppdu_info->nss = u32_get_bits(info0,
+				      HAL_RX_HE_SIG_A_SU_INFO_INFO0_NSTS) + 1;
 	ppdu_info->dcm = dcm;
 }
 
@@ -2179,7 +2184,7 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 	spin_unlock_bh(&ar->data_lock);
 
 	rxs->flag |= RX_FLAG_MACTIME_START;
-	rxs->nss = ppduinfo->nss + 1;
+	rxs->nss = ppduinfo->nss;
 	if (test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
 		     ar->ab->wmi_ab.svc_map))
 		rxs->signal = ppduinfo->rssi_comb;

base-commit: 94aced6ed9e2630bae0b5631e384a5302c4b6783
-- 
2.34.1


