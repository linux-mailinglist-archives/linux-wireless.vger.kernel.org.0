Return-Path: <linux-wireless+bounces-18363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13738A26B04
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FD91887939
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30B61AA782;
	Tue,  4 Feb 2025 04:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJJeoPzB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5E183CD9
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 04:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643044; cv=none; b=lkBKLrsNKxxaVUF7il6hdd7YqJc7K18JVuCMZ7MFBSqM2mAVQH9vxU1Qlp7rpw/cLoSpgam265KgE++fUyJL5q/G1/ioj5zuezVFpqySvoDR5FH5xa/KgPlcafKoKktXBGxqH9aeFz1dqo0PxuqGBnPt7EWHbsqKMfbdCOVQhkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643044; c=relaxed/simple;
	bh=nxkKWfEGElnDHDYpMY9QNZVpKp9xiqkF73rcZPqYbkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IwRrdoD1voxlaeo6ubWUiERSEIbmbpIS0Muu7tD9Q0mTlaG3SPFBDQcHkttkHL1RlG0mmX7LtvUdiYaVOlQw8w1+25drEOfgojdPwdBFIsq8aFTNySof5HCTk5Z68qWkJiErtWE8Cxz+RKxlkng2uq+9t9h4DlQSUm/7YlVoJbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJJeoPzB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513LckuX029122
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 04:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OpQ1wqnVdVlF+fVFCGFn5AWkm1b36ebsa+hYlEcKIWc=; b=cJJeoPzBNjKrftGH
	e77cEcWJlKbXseJM0rsexHWHmuVrGijHC69cI5zgeldWhok9wneSqYmFr8aBCTg9
	WNekBcAs3kIzFks+yNQiK7NZPZ7H5IFPdOY2YCVF7T+x5q6s1KTbDyaERN6JI7og
	jr8ZK4FrSE1PIQnuSxaVQQLOC+gXCk88qNQMk7Q9Qnhw46RVq4kMfPH/E0nRl+pH
	gjlTjJVBGvORNpy4Vcj144hsKdQhAPxyKzJ+68vQqJYmDL8nfQw9RzGBVZK3WilI
	1IfJAMsZVHVlCK+m8wDpTvvBhAAZVjygfYjxzwO3gl4YBKNiX0Ov3qvvH+9vrvBd
	0z5R1w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k5w5rnb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 04:24:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee5616e986so14583489a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 20:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738643040; x=1739247840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpQ1wqnVdVlF+fVFCGFn5AWkm1b36ebsa+hYlEcKIWc=;
        b=WwMENKBntEgNFC56cXrkaWKY9ViiaxFOl77YY6u9Zn3a/Foh4qUWYufRKSDzEAkQcb
         hFik96iVR6AbL/a3N5SSK028UcxBUh9x3qxetGBufvHwzN2DU0Kpk9XJXdW2YpgRWrmE
         mQoh0BTzf2sFfR3fzJW/Nzyq4/Cq9ibv4xHM4HiD6yUqzJLgr/oiF6xKfaq9+ddpHoEi
         pIlrNmYYiIKO44YzdMztBQiO829M5RBLNzO8PDB0r3m81Rn4b7AA+G+5JEgHwE9s8mS2
         AiPL1oon0ays3rACLI8BcbEq9wgM0C2tFBzOOhXK5m9vIlZCPVKunyi6huQa/LfGLTwT
         3QPw==
X-Gm-Message-State: AOJu0YymhmTOeNXvVRqXBdTPqbmoHlkDB0gruGNb+QOIi4Uytsu3vBZK
	wboAhzQdbwb4tKpfZe3o/aFm3Ivo9MvGtelJibSsxO3/f9qX2QptzkCcURkxvJgXojXizEpyGJ7
	2qMAbSwd9FxosjDl7BFw5J5AlXxp5FnOdaYP8gRDZAG9YBb0zPO2OkQTUlnCCOuXZMA==
X-Gm-Gg: ASbGncsIO1gUXMFghyVDYs3g8DKwl9cVlzvwyu728PJLU2vX8tdXFk5euLzw6hRWQ7a
	Dxjlb+e/H3r5/XPAboTdJW7MIeixw/1OhQ1zZEAhwob6pHplzhxJA6veb6X0BQUMazdjcvB9QYC
	XI5fchEVEn5awJ8VkoD39o+JiWFJeTn27fXStWBto5ddNncXkLy5mZvtKw4X7yHoTm7JzK1DShw
	46dEw8Ovyy90H7nBGS7lVcrGLrLfKOC2uOWHJNr4BypVK8XXlpqrPUocTBGgB6FCaM1gzk7xChB
	EiqPKxYYVWLoPcCj43yeDr0VzJ/pcyI74Kqvwx7JB81xBT+lVZMqhuX0O3EWmW3NFwtN7CHVC2V
	B/5zjEmZqMQfU+g8N6B3QIRu+3qX/vw==
X-Received: by 2002:a05:6a21:498:b0:1e1:a647:8a54 with SMTP id adf61e73a8af0-1ed7a640d32mr38481745637.20.1738643040158;
        Mon, 03 Feb 2025 20:24:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOQ7Av7ChIT5Sfd9Y3FCRFBK0BvMkRxWFgYagW1fOXHmqJfop4BkVtnVNZpzYrIs3wnrErtA==
X-Received: by 2002:a05:6a21:498:b0:1e1:a647:8a54 with SMTP id adf61e73a8af0-1ed7a640d32mr38481712637.20.1738643039750;
        Mon, 03 Feb 2025 20:23:59 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04796e1sm8897144a12.58.2025.02.03.20.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:23:59 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 09:53:41 +0530
Subject: [PATCH 1/8] wifi: ath12k: eliminate redundant debug mask check in
 ath12k_dbg()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v1-1-675bd4cea339@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: xdegzXJWtTkSTRrFvtmKiV58hPVyHz54
X-Proofpoint-ORIG-GUID: xdegzXJWtTkSTRrFvtmKiV58hPVyHz54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=971 spamscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502040032

The current implementation includes a debug mask check both in the macro
expansion and in the function __ath12k_dbg(), which is unnecessary.

Simplify the code by removing the redundant check from the helper function
__ath12k_dbg().

While at this, rename the first argument in macro from ar to ab since the
first argument name in the function __ath12k_dbg() is ab.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

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


