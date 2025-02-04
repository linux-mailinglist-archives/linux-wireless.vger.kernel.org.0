Return-Path: <linux-wireless+bounces-18430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90917A277C9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593CA3A7B61
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED4C215F7F;
	Tue,  4 Feb 2025 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="molv57UD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BC215F67
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688726; cv=none; b=FOB+fGU0Q/YVze1gzahe5LUV/mJT1eW1LO0VAK9HxfaaIGpJtBj4tpwWvodwsSVeQspVOXb5JwCCpbFIPg5fa2e1Zklf1fCF7LWBntHPrgTKFMtzX2ZsMh0YW7QLfhQriRKUkoNima72ubXd+IMVT9FeDvvOIHW/jT5XpoSNCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688726; c=relaxed/simple;
	bh=2zaqtMLmaEiFWQIT21mk66I0QwlyJgIFFDVjO5lJIGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRg59MuLSUs537O3MngSPqzuZ+5EunNDN/qYx3GCM5llerHSYF8JG4CnkppMGS0yvXDdWj9EdCi35k7cTlo2IHaIrMwxOaaxmrWbGQXczxHavB1n9cbI/rHsvs80ozjjcc1/HZnaONBo5pomKncQL122LOugiK2IMh/6RYLBjms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=molv57UD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GulGS024727
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 17:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hBnMagGnfmOlAsemSbgdCgpnsrubY8Yw3Y2FnZmojeU=; b=molv57UDlDd9WkLo
	8+qC7qFNNgf0wJw6FWgrscoHiGd7NMQM0zYffu+zBU91gM+o+FKpl1/rgRTQkG7J
	7dN5ghgdKcp90NFnsx/LjT/xigoGt2nY8isNfzEcLdg4nnx++RpNLzMnCINKOI6O
	rOPxij9vONyloAgdaT8CtwKmyt1rt2U0RLdEDsYhZaWMcV5kifbpTPYB4wiprEEn
	CiMPfSHJTTgvbcbz7q2iUH9LDkHbsTUVnuTkvv8TadS5s+XT+AN7HfRoYbkajz1q
	vUbr+9Hy1+4/I9hHLvzvSK3/AS9WZDgslcDtFjSFepQy8TAQ1G2YrRugJpYslZsU
	tlf/LQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kpuy80uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 17:05:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef6ef9ba3fso11260267a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 09:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688722; x=1739293522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBnMagGnfmOlAsemSbgdCgpnsrubY8Yw3Y2FnZmojeU=;
        b=hnuwP85B7toZjuitnpL/aY0S0iuzRH9/Ra0lMwT/x3iDu3lI29zvfhL/rbtN6R0NfR
         v9fvztW+1FSO74SIVikxwHh7ozG5cszoFnTh6LRkcQsrRq4vN6AoA+C5X4eMlmPxlBIX
         MCb4prWGDoObeYxJcGTB+yWpQj/QVCerfId+98aLn41rba34rZCXNc8CRb4xftagN0zx
         wRGXLThl5bqJOREq3CGzwIYwBfsdQXHvQLlMzgPmb2LjXflFsX1wDDzF+EzGEsj0ybka
         Cyx1Y0pqDMCxFvraseLcYNpCQEI6R7XZPww4k1JEbPcFsG4MaEOUKN//VfG45fnmsp+2
         UaxQ==
X-Gm-Message-State: AOJu0YzxB89F2PiqUF5lQlk6YgzXgdGQBcrHTgUWWI65jt/Z3SmnHsAa
	HJYi14ybOl/7n2SmtIAKCPgd8yuS08gssOQcnTf0V2dAcsn1ZvCMYPkOIQhQggWfK6q6WPAnXeO
	PIb0gTzRBf66XvADITQuxEcVgpvf0N/2mIMCPB2NVvkJbJ+6I7Y6OjT+AOBlHpQ/DCA==
X-Gm-Gg: ASbGncsr7l3HtkFKWJOLjqKxSXmCfpUoPHP/0bCfdZw72IzNJrZITu0dFLk5rgAJgSH
	FKjh+GdQyJxEuvqUKYFk/Sf4R8EF8RCPbqmCr98g+3I01sSj1fBTmnL4woKaZyZkQElxg5BdiPy
	C8b6ax/z4etdbF/M52EiRoBOvE7PwM7CN1mkv53o76dfxOEcU6Ni785oeKG1jyjAtQbPaMJjzq1
	LUYkeQ7JZv4QHjDvSXViiQ35Gjwe3LxXg6Nf5ssllDK50PcvDdhivdcsNqWa5voCrt1Sfb/kTFr
	BMszzlLgHvfTneB7+6qivWOMQr53jhXIng22cRo4WqXa+WfUz+obJP8OW8N0NLupq88tQkZCGWv
	dM01bl0061CxCyh9r6hf4wT6/ga6G3Q==
X-Received: by 2002:a05:6a00:b4b:b0:729:1b8f:9645 with SMTP id d2e1a72fcca58-72fd0c7f7camr40884091b3a.24.1738688722383;
        Tue, 04 Feb 2025 09:05:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/o0PDFYKduJ/WFg5MTpCskunjYwzsD7hxpDVDXG2wzp3GnoR6788Fy5nXVsJL9b4i/RBxvg==
X-Received: by 2002:a05:6a00:b4b:b0:729:1b8f:9645 with SMTP id d2e1a72fcca58-72fd0c7f7camr40883896b3a.24.1738688720498;
        Tue, 04 Feb 2025 09:05:20 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cddbbsm10772788b3a.125.2025.02.04.09.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:05:20 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 22:35:07 +0530
Subject: [PATCH v2 1/8] wifi: ath12k: eliminate redundant debug mask check
 in ath12k_dbg()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v2-1-764fb5973c1a@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: jHQ_duyh0S_c2xkd7Ivp0D4k3EXPrGXe
X-Proofpoint-ORIG-GUID: jHQ_duyh0S_c2xkd7Ivp0D4k3EXPrGXe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 mlxlogscore=987 spamscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502040132

The current implementation includes a debug mask check both in the macro
expansion and in the function __ath12k_dbg(), which is unnecessary.

Simplify the code by removing the redundant check from the helper function
__ath12k_dbg().

While at this, rename the first argument in macro from ar to ab since the
first argument name in the function __ath12k_dbg() is ab.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/debug.c | 5 ++---
 drivers/net/wireless/ath/ath12k/debug.h | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debug.c b/drivers/net/wireless/ath/ath12k/debug.c
index ff6eaeafa092cd12e572430ed0f1c7aa21b78377..fd9796b5ad3b9feea5c7e78e8a88d361049e08df 100644
--- a/drivers/net/wireless/ath/ath12k/debug.c
+++ b/drivers/net/wireless/ath/ath12k/debug.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/vmalloc.h>
@@ -63,8 +63,7 @@ void __ath12k_dbg(struct ath12k_base *ab, enum ath12k_debug_mask mask,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (ath12k_debug_mask & mask)
-		dev_printk(KERN_DEBUG, ab->dev, "%pV", &vaf);
+	dev_printk(KERN_DEBUG, ab->dev, "%pV", &vaf);
 
 	/* TODO: trace log */
 
diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
index 0aa7c8ccb14ccb9de28a78ca3d2b2a7bf6e481c1..ba0e4da3bb761a49fb81e3efcb61557df8ad1942 100644
--- a/drivers/net/wireless/ath/ath12k/debug.h
+++ b/drivers/net/wireless/ath/ath12k/debug.h
@@ -62,11 +62,11 @@ static inline void ath12k_dbg_dump(struct ath12k_base *ab,
 }
 #endif /* CONFIG_ATH12K_DEBUG */
 
-#define ath12k_dbg(ar, dbg_mask, fmt, ...)			\
+#define ath12k_dbg(ab, dbg_mask, fmt, ...)			\
 do {								\
 	typeof(dbg_mask) mask = (dbg_mask);			\
 	if (ath12k_debug_mask & mask)				\
-		__ath12k_dbg(ar, mask, fmt, ##__VA_ARGS__);	\
+		__ath12k_dbg(ab, mask, fmt, ##__VA_ARGS__);	\
 } while (0)
 
 #endif /* _ATH12K_DEBUG_H_ */

-- 
2.34.1


