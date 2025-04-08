Return-Path: <linux-wireless+bounces-21247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A223A7F4AD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605D83B5B98
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8689B263F54;
	Tue,  8 Apr 2025 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="if4O7gDJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DAF25FA02
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092433; cv=none; b=PA1EsDPUg60kNg73U9yRwSYdk3h315rEtOmynWTOF8nLzfKCU9eHsSzUJ+plbQCY1oJy0nVuoiNqSx8Ch++K3T6+Y2RtnKXsK/50+58q26p+IUED1sNs7311A2gDXna5K/lIB3l1/JT77QtkrInhUfp26fIfQN/DxydX30B92Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092433; c=relaxed/simple;
	bh=iFvBxuI8JXsz6HSNF+NVcvvqpqMG6oPrAR680qTQYXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hy22FuZpd0QUzZ+Hw6nyswuQuw/HWAWXARO7RO+ZD+7DA8/8UNyFhG6z4zjfNW4XJtZKglRaPjIanvI0yuXNlAJiQfIihJWFmB+2950H368gGS9MYIqsKlo+0HTggSdJdqI0FYvW5wE8l8GS4lq8KIe+PaIcIy3DkwKv/xCJkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=if4O7gDJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GaU1008216
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TBNsYFDvRWgIGDQos+hDO8AQ7SgvMSnwcorWv3miZ/Q=; b=if4O7gDJWETnX+vS
	JgacxQhsi06ndsmYzIVb1jfx4hT4IhXNoBS3tAiBigfUkTNMslPdzqA83/RzxhC2
	NDw1Q2hN8M6vtKBwuD+2o/PHK/kygCKrpLvnmml3JuWVx0PvKfY/e3QGWVs57GPD
	VOA3OaJiYfKaZlcMQ/6ZfmAMZyiyofw8gLzM/pNsSCt+YdvFfqafHPD2z6wjAzwg
	WRNSyG3pKFJ2G6JMUjzJOv4jfQqO2dfXZh13Jg/q3A2zTf0JaHpLdnGA4l4xCj8V
	Ej0q8WV94zaA/hjb+zhn9bzaf4LVGXOllOZhdRgc1AgNMTiIrQTbMUDRDdt4CQt2
	Um1tLQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtaxq38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:07:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b00aa1f50d1so618726a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092430; x=1744697230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBNsYFDvRWgIGDQos+hDO8AQ7SgvMSnwcorWv3miZ/Q=;
        b=RZg2uB+9107MdIOrChjpIy53znRSJdC8yG2ekmYzMuuAWpRdPylIPh/8smyXzoW4Y+
         M2Q7bLfQWawYsHP377FpQhZNwOQfy175e+q78RQ7T6EkFMg35FI+piuUbCs5c8NbP2y8
         uI9MEmCkKPHgUWox9f8KKNHL2hjXVn0y2FKPMTVf9R7HL0z8uKN2yvGFowXueNAJBPsD
         ASMacoOhAxb8CvFAF04IwwQsqGa8mLBbDn7qZYnnuTHEcTC9N6Wx/jO5mm+NDl5tVZbI
         8Gf5txY/TO5I47pV0SYf+qJ4QGiEgV5ZJyc1Ff6sXIQ15M1KAYzYVIsyoWOdOzeogU8x
         mIYg==
X-Forwarded-Encrypted: i=1; AJvYcCWC/SMZaLB2LWgGBU65g4PuefJonIB1IONO3kIEse8CDac47BZWgz7xd2cR1h0zjrVqI0bbvWptKZcg5sWEHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DKsC0ZqPa//lYcSqdnPUAm/VAnZdyowP34NJckp4PNvgDSEu
	2e33Je3NByPH/FqQaJwCBnxTfS9c2InU4+e7aOGqQiHC/NPOWV+Osrzb//T3J6K8BYsEGDV0W68
	wGX43boS7X+XwhS2bKSb9deQx0Lob8D2OY3WK0TQyI/D5AAnfbzMnTH4XKI6wcUVn1A==
X-Gm-Gg: ASbGncuqq3wZJo3tlPBfEeNzgrtNyGGtpsWxafK677pnG9NmdjXTzwqlXbpHbbIUbSN
	O5oSyAwzfnIdmXGcQejKQbQHFEGiosbbRHgfEW1+FeRQhbOsaSW65+JGX5KwHuExpIpUjNx7meG
	/umVs+KoGLPVrB0ujFQ3sgcRQdY8NzMMAZnCu+D1YuVx3CcPnb6hzaISy9zjZBr1rLS3RDb7dpL
	q1AAfFGtNbEkiDYi8eO/i/TwWYxwJ/32nQQkA5eVqz1rcphi8DnaqZwPc8+hZwy3maGcYEgczPI
	Nozm8fyNwzgDbb+JTxDId7xQXK4rFVxR1dukSODZISMwbqrggC4r83NtYwuJdRLIwaGz86/ikGM
	r2ZCtVMqcnQPFutSu68k8sn/FFc8+EbdRZJsJ0RuL
X-Received: by 2002:a05:6a21:398a:b0:1f3:3ca3:8216 with SMTP id adf61e73a8af0-2010447b49bmr22460066637.5.1744092430023;
        Mon, 07 Apr 2025 23:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnZbvQpsmy69UjkGjJMMc2V92O5njwVfVcsI9+dfavomT4AnX/sa54dA8IjoGEF2kgN6ADhg==
X-Received: by 2002:a05:6a21:398a:b0:1f3:3ca3:8216 with SMTP id adf61e73a8af0-2010447b49bmr22460036637.5.1744092429644;
        Mon, 07 Apr 2025 23:07:09 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc35079fsm6863981a12.41.2025.04.07.23.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:07:09 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 08 Apr 2025 11:36:37 +0530
Subject: [PATCH ath-next v4 9/9] wifi: ath12k: reset MLO global memory
 during recovery
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-fix_reboot_issues_with_hw_grouping-v4-9-95e7bf048595@oss.qualcomm.com>
References: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
In-Reply-To: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Harshitha Prem <quic_hprem@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: hUOnArBi9Ie3usKvsCdf8DpBHlahuIey
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f4bd0e cx=c_pps a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=W2Wr2cnFbXLycozjVykA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: hUOnArBi9Ie3usKvsCdf8DpBHlahuIey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080042

When operating with multiple devices grouped together, the firmware stores
data related to the state machine of each partner device in the MLO global
memory region. If the firmware crashes, it updates the state to 'crashed'.
During recovery, this memory is shared with the firmware again, and upon
detecting the 'crashed' state, it reasserts. This leads to a loop of
firmware asserts and it never recovers.

Hence to fix this issue,  once all devices in the group have been asserted
and powered down, reset the MLO global memory region.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  3 +++
 drivers/net/wireless/ath/ath12k/qmi.c  | 22 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/qmi.h  |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 55db189d82346438272c94f25b62dd0db8716efb..9b23329f1bf2a1a84f2b5dee1b67db469d3a8ce5 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1657,6 +1657,9 @@ static void ath12k_core_reset(struct work_struct *work)
 		return;
 	}
 
+	/* Prepare MLO global memory region for power up */
+	ath12k_qmi_reset_mlo_mem(ag);
+
 	for (i = 0; i < ag->num_devices; i++) {
 		ab = ag->ab[i];
 		if (!ab)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 7df6c6eebed6855ab42519610962d2b21825d9ec..c867130f1ddc87ba3ea65d03a6fe99a06c6fe2ab 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2439,6 +2439,28 @@ int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 	return ret;
 }
 
+void ath12k_qmi_reset_mlo_mem(struct ath12k_hw_group *ag)
+{
+	struct target_mem_chunk *mlo_chunk;
+	int i;
+
+	lockdep_assert_held(&ag->mutex);
+
+	if (!ag->mlo_mem.init_done || ag->num_started)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(ag->mlo_mem.chunk); i++) {
+		mlo_chunk = &ag->mlo_mem.chunk[i];
+
+		if (mlo_chunk->v.addr)
+			/* TODO: Mode 0 recovery is the default mode hence resetting the
+			 * whole memory region for now. Once Mode 1 support is added, this
+			 * needs to be handled properly
+			 */
+			memset(mlo_chunk->v.addr, 0, mlo_chunk->size);
+	}
+}
+
 static void ath12k_qmi_free_mlo_mem_chunk(struct ath12k_base *ab,
 					  struct target_mem_chunk *chunk,
 					  int idx)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 7c44ced22c6f610fc32b1db9c073de73020d8e16..96e6c3daecfea48efc8fb65ccfddcd516ef2f3ce 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -42,6 +42,7 @@
 #define ATH12K_BOARD_ID_DEFAULT	0xFF
 
 struct ath12k_base;
+struct ath12k_hw_group;
 
 enum ath12k_qmi_file_type {
 	ATH12K_QMI_FILE_TYPE_BDF_GOLDEN	= 0,
@@ -622,5 +623,6 @@ void ath12k_qmi_deinit_service(struct ath12k_base *ab);
 int ath12k_qmi_init_service(struct ath12k_base *ab);
 void ath12k_qmi_free_resource(struct ath12k_base *ab);
 void ath12k_qmi_trigger_host_cap(struct ath12k_base *ab);
+void ath12k_qmi_reset_mlo_mem(struct ath12k_hw_group *ag);
 
 #endif

-- 
2.34.1


