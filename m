Return-Path: <linux-wireless+bounces-26013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F4B11A28
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 10:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51431C879E7
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865512BEFEA;
	Fri, 25 Jul 2025 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0azgPHd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ED217D2
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433089; cv=none; b=gmc0DDPzFMtLDGphWtyCwt64kaYlIOXhRojsdTaoSIyOAQqlucqdmTV3DcccXWrrdDrbeZxSNMOU3L1Fe35Wl+jiCJsLv83dn6XpuqBfdLm001XhbUDk9rjgVk2IGhdKVl880jrYf9w5wwgoZjtD2eY9b8X4lvXcu4eoMvclQvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433089; c=relaxed/simple;
	bh=mREXpj2NbNz2FkABtUW6s9Vv1ZCgUB/PmO1ERK6kNjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ccQmTKJCpBoIQ+JumJ8W5iSQqsP2970KnIUwr12dsyEew1Cm2rb3El7OQzIhqbvAx27ep/u5LJ0wGgwTbZFomQabPzCKjorVnfw18tv1faz98OdgCcjky+2RNdlFFNRcqRP8V9VKP9WeUbR5bVLnw4dv0gv6cUXoXJS38OLwuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T0azgPHd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLmVhp009335
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 08:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hAgHmAd88JIFsSnckdXzib4pSs1e+bcnMAo
	yy6n7EJ4=; b=T0azgPHd72sYnYyMIcaDVQsM8obs9xYU9omRTCUefmOtfVxRuQq
	2xM0lKHyi1dY2YK4wpDN2jmDjh0qwO/u6f3QvfeCftAW/w41C259kYkpj6KKobi8
	hEoG0rMFrskq2osGp/Vw7ye3rvXZh+CCZXTlQ9MyKo7kwxQ/wVFtGgav42t79Sns
	0klORYJFjsyBZu1C4M7Qcj6oNLRunKScSFSUbF1cKHIR6I3CyCJuQN3w12JmYMAf
	GjL5qdpVE8vFQEA76uvIS5o/TIGUOUeZSoMIAIeNouA44UmtwYg/TsTScRGMQBcd
	UQGGMoZJ78auRspF1hAul/YUQK4Vx0xNELQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2t1dsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 08:44:46 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b38d8ee46a5so1788754a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 01:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753433085; x=1754037885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAgHmAd88JIFsSnckdXzib4pSs1e+bcnMAoyy6n7EJ4=;
        b=Z+JLh9kNu+Bn+swiJDGA/lQFVR7e/JhOB6CLsSGqV0xLwwmcFgro/cOPjnENA84w3V
         fxynXbc3rDEHJtVQcSSbLzSJZWNjwLMQT+ZfBfdaWSXzYO49l1rDyRuX9VNX5S4JoNi/
         TEHa+RC9FIKRkB19r1/kJgON7UHWhR9YujaT8O6/Arb9hJg6/JjQbUYbaG2C2/3Vr1Xg
         EPFSWD4Xbz1Ycl+aC0RSgZHVYlNm4ZUMf/tK/XPjI0UqE7SI/eCdrTA8TfFVQ+WSe7AM
         iEJFIlm6wOcXanTPjhbDV7M8BfEuMBDyP8vJFi126N5CfQgzEhV7LqbaeQ3tsr0hYrsZ
         FpFA==
X-Gm-Message-State: AOJu0YxCml2Ks36dPxJAFKVA3oWwLJqK/zLwJdtNd/UgmEI5/f5RI2Yu
	2+LUKEW3PVPEJbHgfrgog/xNpERTkgAmpRVcQWlSXNS5HcO/2QIKEK0c6Mm7ragMIkbbCrCf3dV
	PWEmwmUfe82VbfV4jMcqlVetaySq3o620B2Hx3kVN06wTerX3ELJOFKsEO0pbU5WqjLz5/tiM7a
	Gnng==
X-Gm-Gg: ASbGncs4jTeTGg8SqCGL366nykfKoR8uxboAR6S7XDHPXVdc+94qiAKlCEh34FTqvMK
	qtbv+1QnXs3KxSq0siyyfU5ehis1J5lRwK+PQ+6OKZqBYH+FJxQ8mun6iSr1jmYkPlklm5IgiR0
	vg+ClE7FXe5qPTP5gHwSGgxV3dY1UcPjqdxlHTtnY7d14Q9oa92tYFaIOoFxHJBVNjQndwFZWgj
	v4jD7sZN8xNyZTCr5nTq1Wj32gdYWyg546XKBwabJF3yCw23jlFGxuQ3+6ntQdYhLhN28UEpR+7
	pBEwS//X+VUJ9hbuKNh/HNf+maQ6ZZ+QP4bOCxBd3TzfBxg1DLEyYUzywVtuSPVr2OV2Dc7TpAN
	Ql7uAH0sszk/Qr8RlB4+vJ0jZ5zs+ZlPHh+WmBzr3PKGSctos7Eqy1gLXngGD1+nduxgRjAor
X-Received: by 2002:a05:6a20:939e:b0:238:351a:f95f with SMTP id adf61e73a8af0-23d6e3b8bbbmr2037087637.22.1753433084934;
        Fri, 25 Jul 2025 01:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJgDYw4QdC9rQdP92kriMFcU28GsTOcopZ13OIgOkWnTDFXnZHHuUzqCUmQfxcZSKSXIzx+A==
X-Received: by 2002:a05:6a20:939e:b0:238:351a:f95f with SMTP id adf61e73a8af0-23d6e3b8bbbmr2037049637.22.1753433084492;
        Fri, 25 Jul 2025 01:44:44 -0700 (PDT)
Received: from hu-tmariyap-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b0625917sm3380834b3a.122.2025.07.25.01.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 01:44:44 -0700 (PDT)
From: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Fix NSS value update in ext_rx_stats
Date: Fri, 25 Jul 2025 14:14:26 +0530
Message-Id: <20250725084426.3989966-1-thiraviyam.mariyappan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BMKzrEQG c=1 sm=1 tr=0 ts=688343fe cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=K37uNGIe9fc187cu1v0A:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 8vjbqi9ZoVc9EqVq0jyyh09aukKd9x-V
X-Proofpoint-GUID: 8vjbqi9ZoVc9EqVq0jyyh09aukKd9x-V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3MyBTYWx0ZWRfX5Ec4pxs+Ok8T
 KeVaQmXrPBsmeHNpRScj3vyctaGmg68TBKXlUBgbjgpl83INW/Gqj4MqFtZbz8q0xHMr4Gudu0O
 00lgM4asfHlRnKKX1/0mLMXuEJDHe7dCP4A2zaAG+GmDaC2+4wnOwF2Yble+7Lqt2WpsCtY9fwg
 7a7Zyt5X5rIXDk6bVWkfP/0tWUhLCnmOCDR6ufSTW2ouyC5nIlBudWYU+ncKxsc5Bsw+zx20YhP
 MQaUCqbBFf0JHqO/k6PerY0FXiZ2VD3sEgjYy0eNAElpPBGPaUllkkrphFvkfV+aMevInP1+CEw
 w7v/7C8Yv1u4QfnTkXAJ/qUVycxFSN4ForkfsrgjesP0KMz4LRxE8nHEDeKwuF43KJUGPZ7+BD9
 sPhcztDxioZeVT3c3wCr2ymWRF1J+Wp1qiR8g50Ok027pV1jxUV+gEbboTvDJ0GvOwV+Qb5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250073

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
 drivers/net/wireless/ath/ath12k/dp_mon.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 8189e52ed007..4bf21286b95c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
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
@@ -233,7 +233,8 @@ ath12k_dp_mon_parse_he_sig_b2_ofdma(const struct hal_rx_he_sig_b2_ofdma_info *of
 	value = value << HE_STA_ID_SHIFT;
 	ppdu_info->he_data4 |= value;
 
-	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_NSTS);
+	ppdu_info->nss = u32_get_bits(info0,
+				      HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_NSTS) + 1;
 	ppdu_info->beamformed = u32_get_bits(info0,
 					     HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF);
 }
@@ -261,7 +262,7 @@ ath12k_dp_mon_parse_he_sig_b2_mu(const struct hal_rx_he_sig_b2_mu_info *he_sig_b
 	value = value << HE_STA_ID_SHIFT;
 	ppdu_info->he_data4 |= value;
 
-	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_NSTS);
+	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_NSTS) + 1;
 }
 
 static void
@@ -553,7 +554,7 @@ static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *
 	ppdu_info->is_stbc = u32_get_bits(info1, HAL_RX_HE_SIG_A_SU_INFO_INFO1_STBC);
 	ppdu_info->beamformed = u32_get_bits(info1, HAL_RX_HE_SIG_A_SU_INFO_INFO1_TXBF);
 	dcm = u32_get_bits(info0, HAL_RX_HE_SIG_A_SU_INFO_INFO0_DCM);
-	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_A_SU_INFO_INFO0_NSTS);
+	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_A_SU_INFO_INFO0_NSTS) + 1;
 	ppdu_info->dcm = dcm;
 }
 
@@ -2155,7 +2156,7 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 
 	rxs->flag |= RX_FLAG_MACTIME_START;
 	rxs->signal = ppduinfo->rssi_comb + noise_floor;
-	rxs->nss = ppduinfo->nss + 1;
+	rxs->nss = ppduinfo->nss;
 
 	if (ppduinfo->userstats[ppduinfo->userid].ampdu_present) {
 		rxs->flag |= RX_FLAG_AMPDU_DETAILS;

base-commit: d29591d5b52eaa62bc8c07ec83fe63018b5546ea
-- 
2.34.1


