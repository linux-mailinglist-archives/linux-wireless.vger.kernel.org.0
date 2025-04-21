Return-Path: <linux-wireless+bounces-21771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1100CA94B0A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDBF3AF3EF
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12974256C92;
	Mon, 21 Apr 2025 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AlFm21Lb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F12561CB
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202939; cv=none; b=KHArOcGc+7UiE+DPUa3z7JUQmxb66WOsPVwf3KFeRxOwTCygRMBj5uNgaIMM3hqyAqq4fe4fRSAaGrJJOf/0BZsKzgbMs1UqQ1x0iQltkTbQSVk4phAKevwxJNPBpxuHCadUR6xRWZ/Svj4ZYucGinzZLYXyxe4F4Pl4PVzAaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202939; c=relaxed/simple;
	bh=K5xaLtmpNUnpc1IAEQ0v+p1vPoWB68c+yZdkvhzeBnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ld54NUfwpXOiEqxYMyqZyYFkz6iyuw1CUrjMNLrfo1f7tClP5mJIHCIFyyne59jQ5/CRhzwQvgSmorjrGLVcfp8iatTjiGrg8TLXdYeEC+I0LZBHH8htOlBCe3SzeTlKUK0Xxi7VfWUZynotcDMCmuzUYX8FRswOffZMQuNrIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AlFm21Lb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNSC8c005295
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wVtxNw5DxWb
	z/CXXulYnPYRQliO3LecSwULeLmAboJg=; b=AlFm21LbYJj3EenBOE+jcFd6oeq
	Cym2uuPu0hlepFFi6cbt1jUnq5iiupnBMrDWRh6f1m1V/HhGwtNNohtMaFSEtrGz
	ILPMsVI/iAgVN0d1qxGEzGUA2eWEI3mAV2rquBWelT3xtWTaCWAJNHztKLk9avlX
	yjbzjTZDigCYvlWGyr+6JnZY0j55GnV2sRsh67GRyhok/F6mcJa7K0Fcqg+JUtBq
	E6456oFXDZfesFVZ4oZPnlEGIdw4zpFD13lDz5qi8+5dv6Id9aGiRmFn2gqCYo1U
	1MPCIU4YMbt8pR0CV2zTKdMZRyTBX3sarL2zty297iifTvuJQ9lS6nVmrzw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4641hhjx67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2264e5b2b7cso30438325ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202924; x=1745807724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVtxNw5DxWbz/CXXulYnPYRQliO3LecSwULeLmAboJg=;
        b=aq6SZvtKjVblUePdIJHVvpapfqrURyhxvq4dwGto3Q3kw6hYgz6RO2WGrQsI14NC/Q
         OMk1+B+qT+8XiAO1Fv1+HLtcCLFvmnaZDS9Yw51uoI9QLKhJ0o+uZTc4Iyg6M1MRZPki
         n8PrWUXdf+uHtUPqeScLsQgcm7RCRT3bLzeMBukdGrMpUlkWS/+qQhW18WtciCaUzFmW
         Xyel5x8GgYIxpwOyEh3QZVLtCFLLfUkkm4X1fiBYRQqLP+Jkq4E43NsTlfOx8HyySmAN
         8qZSH2BBrLqbecRynLAIEN2VR0U9CrA5xUNcvL/oXJEE2wHL78SxERoIN3n01zte+OCz
         +knw==
X-Gm-Message-State: AOJu0YyIzVBz4SMr8/SYXDONqBBu6BgJ+r5au/I1lQrBXWdutpGAUdGD
	FfBSY5LVs9YPWv6+71qyRzG1LQJenqDjd55+V7T2QuLDM1KYyFeth2TTUdyOZGdRejPq+YMBsKC
	6qaee3JVy12CiSF6qs76zvwkfNwB2K5ZLvojfCouoVTLhvsNL/oOuRBE7vJ/5nzhnUK9w2HhUYf
	mp
X-Gm-Gg: ASbGncvEEJW7HPfvMb3M1zRlWnmYM20L9Ny5VQVNw4Lbd02SF6UinJ6nhjRQb379D3T
	nqT02pV9jF8gd6QG08c5QAlMvQEoy7gzTWyDvWTtPsHFNkEzzhNm15rIblMJAgnDesHSenIzxym
	i09ttWPvsb7pqkdyn1fUKXiP0eTaALv1evis4YpEqD3Hrlgn/LaRTesJVgwJyN7BaDhxYejUkt9
	4t/voh10f/gCoC4Viwvfy52NXFWBCeGbmsGUoJrAQ+6YXnhzsjwaqxKaHxHSWXTX5Lbb7o3w6zj
	GU+Xe/WsQ5sgfrfx1x7NZUPzhuMT5WCQumlw5GqCEZ04xHs6LA/lcsmZt7thNYn4cpIFPxSCVvy
	Z0b/5pQvjaH8=
X-Received: by 2002:a17:903:fad:b0:211:e812:3948 with SMTP id d9443c01a7336-22c530b58acmr153912335ad.0.1745202924321;
        Sun, 20 Apr 2025 19:35:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFqGK/inIa5ejxkMdbcFeJZ8pLIYi7teaTtugkmA1mPFJuqCIhvkKKJQaD5g3jdWNigIP40w==
X-Received: by 2002:a17:903:fad:b0:211:e812:3948 with SMTP id d9443c01a7336-22c530b58acmr153912115ad.0.1745202923904;
        Sun, 20 Apr 2025 19:35:23 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:23 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 03/13] wifi: ath12k: add srng config template for mon status ring
Date: Mon, 21 Apr 2025 10:34:34 +0800
Message-Id: <20250421023444.1778-4-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Fe43xI+6 c=1 sm=1 tr=0 ts=6805aef7 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=bJUolzXMejWutlsJL5MA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: A36eqjiRo_3JK0BcsQoe1NvdyMzreyf1
X-Proofpoint-ORIG-GUID: A36eqjiRo_3JK0BcsQoe1NvdyMzreyf1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210018

Currently, the hw_srng_config_template does not have a template for mon
status ring.

But srng config template is necessary during ring initialization. So add
a template for mon status ring.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.c | 9 ++++++++-
 drivers/net/wireless/ath/ath12k/hal.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 12d0f991a47f..ed268089f9b6 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -154,7 +154,14 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 		.ring_dir = HAL_SRNG_DIR_SRC,
 		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
 	},
-	[HAL_RXDMA_MONITOR_STATUS] = { 0, },
+	[HAL_RXDMA_MONITOR_STATUS] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2RXDMA1_STATBUF,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_wbm_buffer_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
 	[HAL_RXDMA_MONITOR_DESC] = { 0, },
 	[HAL_RXDMA_DIR_BUF] = {
 		.start_ring_id = HAL_SRNG_RING_ID_RXDMA_DIR_BUF,
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 4adef9240409..f627cd01f60c 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -498,6 +498,7 @@ enum hal_srng_ring_id {
 
 	HAL_SRNG_RING_ID_WMAC1_SW2RXMON_BUF0 = HAL_SRNG_RING_ID_PMAC1_ID_START,
 
+	HAL_SRNG_RING_ID_WMAC1_SW2RXDMA1_STATBUF,
 	HAL_SRNG_RING_ID_WMAC1_RXDMA2SW0,
 	HAL_SRNG_RING_ID_WMAC1_RXDMA2SW1,
 	HAL_SRNG_RING_ID_WMAC1_RXMON2SW0 = HAL_SRNG_RING_ID_WMAC1_RXDMA2SW1,
-- 
2.34.1


