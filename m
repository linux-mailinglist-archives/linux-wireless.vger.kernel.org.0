Return-Path: <linux-wireless+bounces-27932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE586BCDFB6
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 18:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 906B84E281F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4DB26657D;
	Fri, 10 Oct 2025 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DrGT3VFl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA701FBCA1
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760114884; cv=none; b=crvjY9LZV9pIjDMZaB1N5zVrn8txVh3NV/GzSFf534q+8sYhcO09r4lN26SFWf2lHs2R5JX0Wjwu9rRVRyzqv/h1qtu1d1iJAvGW5Vf0japsxTJXW8Z2lLv/oDAFtHZzk40PFhmJI1WGinNBkfuxhnY4z3PWWJu1RQzZDq39QkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760114884; c=relaxed/simple;
	bh=ymW+zyTZP4gAEse1v2OnM/48QMF0bwv76+SY9R8XWIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kOENJE4JNJNfsajrpCTZ8lMfJaQEjp9c+h5mOHjCJa+K2jEcCqYruiZ1KgrCNUx91u+ywl4/Ii1hsJ1uiy6cwJx41fckkq7L43LWpRwRL8kZdDhJlqpk8/zU7dCykCnx0Ph05M0DY/+X4lxnSdV26dHqUDhTKMusxAa93okplec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DrGT3VFl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AF1OO7018539
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 16:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UQLk3w6GkzbTjYg8BRnJ/q
	Gfyc3WiUkLopNUoNxwb40=; b=DrGT3VFlgdhd9K3OcybKLdW6BRpq0+qcbchkUX
	gGvfC2mS3q0Fqc6cgHd90JSkFJ8o0PmFQ3uQau4EMIW6nJCBZDwqbHufMtQDCRFR
	Oh/GIb8bRCqO/6HAZJ2Rlla3SC0VArbN/C3NPDfGoGVQ3YTZBGyqZaMPjraiZ5L6
	T0NUdbPz8KcU08DXytl1av3BhZ/zDjya6XFXGyKYuSMxk+8XRu8V8zrHILhrk06U
	hQH0V52py846P99vdBEUNtqlP5DlrMPRxj0+VGdR+vtFWcKn9PlSMuXKWPH0Rmri
	c4P5rfzLhvV0pSq64EyFxn9faE9gMgSVtETK1WY9gTM6Okiw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m74jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 16:48:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28e8112143fso57166595ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 09:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760114881; x=1760719681;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQLk3w6GkzbTjYg8BRnJ/qGfyc3WiUkLopNUoNxwb40=;
        b=Z2YAeUaf7mMXq/VT+b5eEv+mv2JCg6MEHVeBLKFkSablkXo8dtYHU73jr85dl5SH4u
         p1hh947dBzEFaHrKKbcHrKV3/pEh4oYPilt1VbwRiI7cGqRw/Vybubnvq0zmy8oE6ukX
         PFfxYh+FQDzJqCwjkJMsjU4oaDWTDKYpwnzZsK+PKEomRphwuQxIdMVPZ6AIVfrixUtp
         S3YphX+nHGqwnYDn2FU7gMfMtsJ6e2C7ZxyjWlRJCbrcmku6gd8LF/nIlotXfrsGpO0Y
         S3LkXUh7zx1lWPw32roWGaIoamR9mV8EphecZbq85fZ7dCqI+w/Ie0dB2IfrPEEQfznB
         QY6w==
X-Gm-Message-State: AOJu0YzatwiFtYNMJxZ5+ZlndHHn0FzbtwJssNou2hus1wRfHwf61mbE
	FXePTOnMjHXPVXUi99Es4TjZhhBxDhibaC+DDSB87VRmDiId3ymP84ub9PhrUcQJEqJXEOU9W1Y
	9ldOzGCgr/2Lx3CEF0X43CBIgGTZtUkxJDkbcFpg3rDF8tIqZVq/DP/KyTKdCkU1wYD+RKcZTE5
	liNw==
X-Gm-Gg: ASbGnctk2JfQIeM6IYjhLMtkkVbsYKQOxYgvhEk4Dm7CNkA1pUUakMjy0L2BI8wrtGW
	bgj3qyxzyPqOSMbWt6SXJP0EZke20uBNocjL+qlXqZaQ2hXGeEPmfIZULNufOjZlsGvHjSKTbTn
	cmNlCCZTWIgK/KIGFVPAV0jRppI2mSC44I9z7ipzNb1sdiDSJI+24BpPe7K5Mi7xyFO7muKE0Cr
	yCQVQEBZHDrRB0aUTxif/Hs8eKia6KesUYk2quZGQMS6aHKLdSGhSmVdAAFn5Pd9oZs0TsBnRon
	Oa4bKlm9DQwztx4B8B2BRbA17elUw0jzSXhwepmUqwgNIezQqRIOkStZAJ/nsiD0xp0q4wEC1JU
	8
X-Received: by 2002:a17:903:2343:b0:28e:7f50:5d80 with SMTP id d9443c01a7336-2902721336cmr169496555ad.7.1760114881085;
        Fri, 10 Oct 2025 09:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPCbDu/FieQ+1h3nbSJfYEKgWjo1fZ5p8ESMMN+g7cvnCdHW+SRo5D4/i2QdXk4gTd+gR+0w==
X-Received: by 2002:a17:903:2343:b0:28e:7f50:5d80 with SMTP id d9443c01a7336-2902721336cmr169496125ad.7.1760114880618;
        Fri, 10 Oct 2025 09:48:00 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cc53sm61760885ad.46.2025.10.10.09.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 09:48:00 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 09:47:58 -0700
Subject: [PATCH ath-next] wifi: ath12k: Remove struct
 wmi_bcn_send_from_host_cmd
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-ath12k-nuke-wmi_bcn_send_from_host_cmd-v1-1-6f1172b77848@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAL046WgC/52PywrCMBBFf0WyNiWZvqgr/0MkpMnUhppEk7ZWS
 v/d0LUb3QxcLpxzZyURg8FIToeVBJxNNN6lwI8HonrpbkiNTpkAg5Iz1lA59hwG6qYB6csa0So
 nIjotuuCt6H0chbKaFjWrGtm0ICskCfYI2JllF11IYlCHy0iuqelNHH147wtmvve/ymZOOYW8z
 kuUMgcJZx9j9pzkXXlrs3R20wz/0SHRWXoIykp1qIsv9G3bPibN5rRLAQAA
X-Change-ID: 20251009-ath12k-nuke-wmi_bcn_send_from_host_cmd-47069a9b2a6e
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5cmZuHMF28Tn
 PrMlATcIKAumrs6/PXHeRpGYmcB9ZOj/B6IEXuMio7SeeIdZQMQvbgAxysU+5gKlkypsPIOE/Hw
 UI3WLgQ3FadKZqYh/CCPRBdfP7X/1H49nCarRoUN4MVLlBHLcxTvRkD20YA53Vdzy2D2aydzEdz
 m9eEcG5GF2EG9UWtPutLJFrCQYrUSMxUhU7ASsvTyGlhLbssjLLLBdRcqo+QspFHeSRcPcOlnmV
 lZ6RT3cM6pGNs1SAm017efEBFMRmks2FE8yA8XgrZWlxxDZ8HPF7fKmu88d2k0BqTEqRuEvKXYy
 rCnlh0qi7p9GMaG8bL4XO2LWZAPZssI/De5IacSiap2QvErVra6KD2VSHFtSLCZSklOMH4kStAi
 LZeMC9HDpgm5b1XUKdS/iEaF7hLZcw==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e938c2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=kmflYwvQEMg1wVHhIzQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: gIJCFpf_LLpDMyCnflisXX3SIm37ZyIB
X-Proofpoint-ORIG-GUID: gIJCFpf_LLpDMyCnflisXX3SIm37ZyIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

struct wmi_bcn_send_from_host_cmd is unused, so remove it.

Compile tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index a8c3190e8ad9..d9fd6a6b708d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_WMI_H
@@ -3609,20 +3609,6 @@ struct ath12k_wmi_scan_cancel_arg {
 	u32 pdev_id;
 };
 
-struct wmi_bcn_send_from_host_cmd {
-	__le32 tlv_header;
-	__le32 vdev_id;
-	__le32 data_len;
-	union {
-		__le32 frag_ptr;
-		__le32 frag_ptr_lo;
-	};
-	__le32 frame_ctrl;
-	__le32 dtim_flag;
-	__le32 bcn_antenna;
-	__le32 frag_ptr_hi;
-};
-
 #define WMI_CHAN_INFO_MODE		GENMASK(5, 0)
 #define WMI_CHAN_INFO_HT40_PLUS		BIT(6)
 #define WMI_CHAN_INFO_PASSIVE		BIT(7)

---
base-commit: de7674ee69a0023a2dd1c6f0cb66f3cbbba89923
change-id: 20251009-ath12k-nuke-wmi_bcn_send_from_host_cmd-47069a9b2a6e


