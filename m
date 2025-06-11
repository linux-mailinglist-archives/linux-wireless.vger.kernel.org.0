Return-Path: <linux-wireless+bounces-23996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3D0AD5B98
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 18:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6665C178F8E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D61B20C494;
	Wed, 11 Jun 2025 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MNWD3ah3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E91FF7D7
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658447; cv=none; b=GFqW4ux6mrFtOwcQ2mNHwt796VUbWWau3f6dT4rhGWSyirJF3dVmH2xskoGigO/Z3R6j5zAc9BGEf39flQJ4BmqmZ8ODlI2N3xSE5KtxO0MR/J9bq5L6g7j66qznyQmdwaMgwxUyHrIwFqKGZ7FeI8bI3PsDbZsgAEStqph7esY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658447; c=relaxed/simple;
	bh=EBSr7VcZwrJX9WQADv767eRuRO+Fqfa161/jwkrav7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQJ2M0sjiKRaYEsrMT/zPmz/2Av93Qxf31hX2hDeL8wMMeK79o6rVVJjRgGf4AevA1COjJJCGWP2R4CqDwrTDNOPv17GPjCebuPzt8dpgC8QZPBoghLwynMwsZdtrNIwVLWpB8AEiT2m0MlBbk2UShAgzHjsNA+V7ukP7sTIZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MNWD3ah3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DnSn028144
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vC+xxtvYYgCeXhh6pwXkgGaTGJbI1B8K+txHJMCvu4E=; b=MNWD3ah3YQDWEqvJ
	g/y1aZc0m4DzG1wwg+tA1HD1kZvPtHSnX/4EkVKTjGcEYKWsaR4km4jab9ADHva6
	R4O9M6YroUyY1gDcs+DGw8Yd2td2kxA4xORKUJ4WKN3w7KnjGUo9hvSevVi5NVzK
	mcWIDbPGElQw6bDSp6u2U+75/2gugHw+rIVnBPCrJec/u1eOB9V6TzF4TjvBPXc0
	RjF2Bw2u8Lkx6VwXimsvmrEzzKJfcwZat/UKzLEOcf+Id4QZzOt6lNxFcrYnE8DD
	spfarTr+Sw7fPdoOHLkIhOsYtIZ/A+/BL7Txcy74OuO5YyS5nCEBiqeZ+0VoJB5k
	XEj4uQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ccvdh10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7398d70abbfso55912b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749658444; x=1750263244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vC+xxtvYYgCeXhh6pwXkgGaTGJbI1B8K+txHJMCvu4E=;
        b=ROG9jtKdgsViH0UmyjYadbRICbqWSwVimcF2WDWry8e+wEpIbfbiO5JoRoqxVybRVv
         dvhPhemvKG7qzP4kQp89Nc0VLipa2v8a+WKWN7tWVje8F7lL5B0rOy2e616ZMF6aA+Ir
         uXTav0jFa0gQYSB9aG47U+AJooZlv6RZy8rzXiYrrSb56mvw9jeM7qLml4nEMNOHUFYP
         9yxbM8WinpKSJ/lswiTmTS8xvwcpZqhN8VYQdBizTYJgC+9izBl+pF0vs3GTf5tzg1VA
         MEOabLjfRv0IsQ5JmeXD0L5zXWZefuR0/No1vhE3rHF28KYeWcgLMAXMe0k/1vC7VNr2
         BypQ==
X-Gm-Message-State: AOJu0Yywv+XbT+/o0rdDmLko+N8MR6gcyKLlxsnqsasTfkqO4VziAAnY
	6X7gcucY3r4dTFJ1BjxYwasHCKERcTtfJSjc5SmsmKExjyw1ccu/c17KF0Bc6cO3fWcpnT8Nh3q
	W/0hlqHp1iIF/rDwozLPtLU43B1heXsasfuGOyOcH/fqciQEmmq1Js7LbP09uGpohefIg4g==
X-Gm-Gg: ASbGnctsgY1B7Zxd8U7DpXddPk+qxasWfD74ibsfQyLT0KLEye9LEILBNsRZbxwZFFU
	9xj0ihO6RiHU1KjyJ6zbcj3DyjyVQi7LPM6OLJQ8dxdaAYchspe7Thn4MLqgDUFnb0zS8tcgFb/
	pbEbRw72PlndhiwTY5NNX2EyQxSBGitZBG3ubVJVX/EBJIBz+5DpOckK/EcmRYn/374OEjQtBEy
	N2gdWlBQBLp5vfIzJVAgC9CnFV3ai1tk1xa45tbRyWOoGDbqzTlLO634hUCX2+cnAttv38tlzHl
	9zbrNL8/YttcuzWAI26q9loVGwzgRxVdy1QqIrxRvrHq+otYrgLREODt0FE=
X-Received: by 2002:a05:6a21:7002:b0:21c:faa4:9abb with SMTP id adf61e73a8af0-21f86725e41mr5990060637.20.1749658443790;
        Wed, 11 Jun 2025 09:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1AbsaLs+Qh4Et0Dv8tLq0lT4GI8TdVK+xPhvb4cHdeQO2njFhkxJ5Zk1PmTPCVdukje/UZw==
X-Received: by 2002:a05:6a21:7002:b0:21c:faa4:9abb with SMTP id adf61e73a8af0-21f86725e41mr5990014637.20.1749658443185;
        Wed, 11 Jun 2025 09:14:03 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482cdf1c41sm9443708b3a.149.2025.06.11.09.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:14:02 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 09:13:56 -0700
Subject: [PATCH ath-next 3/5] wifi: ath10k: Add missing include of export.h
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ath-unused-export-v1-3-c36819df7e7b@oss.qualcomm.com>
References: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
In-Reply-To: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: tyK8ynUOXptvyGZsVAHREf98Zb3QSIg0
X-Authority-Analysis: v=2.4 cv=TsLmhCXh c=1 sm=1 tr=0 ts=6849ab4c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=E42zS0385_rVDwRnvgkA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: tyK8ynUOXptvyGZsVAHREf98Zb3QSIg0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEzNiBTYWx0ZWRfXzkNS14n9LKF5
 Xg/0eJvvFY6OMWQoi3ayW7Cle17RssEBqaMnBY/uGV2quqclv7G9RIkr2E44SrhWtyn+nnzhm8d
 MHha0IGfLe/2Gs2Nio0FsmaawS0oK8TfwwIdbFCYeq3nAFTBUdKgQht2LkoQLDG5t3ZFpjaMkfM
 D6sk5L1vfSUCWRzcX50lPRl0BYP4i8BrzaRMn/igaRs9aQ3wUr/axitPvMzAXrWB6wkyY5S+FDR
 J7sTUVKUzh+dIWdJrcqKGYulQ8Y5afKhZFh8duQZfcCShjXHYBueJ5zm5PEKvCcFiejANeyj5dl
 lpobFQvUW+qJrXWz9twzsoCVSCKBeyyaesM/ethCfM60C9um1vw1aE8+JkDNLCkjuiMfEH6RpMg
 TgUVa1mZJqKq6uiRtoibwBk2TML0HhSxCW/qi9XLnzf1sMC0ywz/fIi+hE2ICYUVnmwqJ01D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110136

Commit a934a57a42f6 ("scripts/misc-check: check missing #include
<linux/export.h> when W=1") introduced a new check that is producing
the following warnings:

drivers/net/wireless/ath/ath10k/bmi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath10k/ce.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath10k/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath10k/coredump.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath10k/debug.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath10k/htc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath10k/htt_rx.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath10k/htt_tx.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath10k/mac.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath10k/trace.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

Add the missing #include to satisfy the check.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/bmi.c      | 2 ++
 drivers/net/wireless/ath/ath10k/ce.c       | 2 ++
 drivers/net/wireless/ath/ath10k/core.c     | 2 ++
 drivers/net/wireless/ath/ath10k/coredump.c | 2 ++
 drivers/net/wireless/ath/ath10k/debug.c    | 2 ++
 drivers/net/wireless/ath/ath10k/htc.c      | 3 +++
 drivers/net/wireless/ath/ath10k/htt_rx.c   | 3 +++
 drivers/net/wireless/ath/ath10k/htt_tx.c   | 2 ++
 drivers/net/wireless/ath/ath10k/mac.c      | 1 +
 drivers/net/wireless/ath/ath10k/trace.c    | 2 ++
 10 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/bmi.c b/drivers/net/wireless/ath/ath10k/bmi.c
index 48efdc71d54dc699e1d43d01507a7a30c9c495b4..52118867ecde5c71b36361e3393d7579116d8be9 100644
--- a/drivers/net/wireless/ath/ath10k/bmi.c
+++ b/drivers/net/wireless/ath/ath10k/bmi.c
@@ -3,8 +3,10 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2014,2016-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include "bmi.h"
 #include "hif.h"
 #include "debug.h"
diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index a89a7491a76c8b25c38a56cea4196bfbbae277d5..7bbda46cfd93c362b0d8c53dc5e8ad7e8621cacd 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -4,8 +4,10 @@
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018 The Linux Foundation. All rights reserved.
  * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include "hif.h"
 #include "ce.h"
 #include "debug.h"
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index fe3a8f4a1cc1b774ce27112ef7dfe6adb0b4dc2f..760d0a9ab9c2ce54717860e1c810d2b063f75e47 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -4,8 +4,10 @@
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/of.h>
diff --git a/drivers/net/wireless/ath/ath10k/coredump.c b/drivers/net/wireless/ath/ath10k/coredump.c
index bb3a276b7ed584f4d4e7418b2e4cf7d913114869..50d0c4213ecfdce975638c66bcdebe35b6ce9d3f 100644
--- a/drivers/net/wireless/ath/ath10k/coredump.c
+++ b/drivers/net/wireless/ath/ath10k/coredump.c
@@ -3,11 +3,13 @@
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "coredump.h"
 
 #include <linux/devcoredump.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/utsname.h>
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index a0c1afeda4ddf3649ceea8adbca23d771d17dc93..6410d3961e76ca2b4191052277c2072638db4b8d 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -4,10 +4,12 @@
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/module.h>
 #include <linux/debugfs.h>
+#include <linux/export.h>
 #include <linux/vmalloc.h>
 #include <linux/crc32.h>
 #include <linux/firmware.h>
diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index 2da08dfebd3e7b56b149a09b5372aa0bfb8538d1..ce9b248c12dc6c0c90a9a7e081e428d439465ede 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -3,8 +3,11 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
+
 #include "core.h"
 #include "hif.h"
 #include "debug.h"
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index fb0d5d4cae3a1c1bcb82c3bf83d57d79c3661f07..f12243d6bee171eeccf4a57e8001cbddfd26733c 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -4,8 +4,11 @@
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
+
 #include "core.h"
 #include "htc.h"
 #include "htt.h"
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 9725feecefd6fb0f073761fbacf26d6bdbaeff15..c1ddd761af3e9ff987fcfd3a55b8747e48783b9e 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -3,8 +3,10 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include <linux/etherdevice.h>
 #include "htt.h"
 #include "mac.h"
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 07fe05384cdfb13924a956f7d672042b782e166f..730a6eadf093378d93844a444841fd5826f720bf 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -9,6 +9,7 @@
 
 #include "mac.h"
 
+#include <linux/export.h>
 #include <net/cfg80211.h>
 #include <net/mac80211.h>
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/ath/ath10k/trace.c b/drivers/net/wireless/ath/ath10k/trace.c
index c7d4c97e6079f006383b864b1bdb2fc0ee1569c5..421ec47c59bdf9967ad18e2de0182a488b9c5a03 100644
--- a/drivers/net/wireless/ath/ath10k/trace.c
+++ b/drivers/net/wireless/ath/ath10k/trace.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012 Qualcomm Atheros, Inc.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include <linux/module.h>
 
 #define CREATE_TRACE_POINTS

-- 
2.42.0


