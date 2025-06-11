Return-Path: <linux-wireless+bounces-23998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87607AD5B9C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 18:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775A816A2DD
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC77C21421D;
	Wed, 11 Jun 2025 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JVyAEcOb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17792040AB
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658449; cv=none; b=sRk9VQgj1dxzt+64ZrZvGZmaLhOZEPSEfuHX2r7GFsmWMBirjIBK9i3OLJi03L8BAjGticJusSS0C2RnlHVDLA5LdrMg9WO0y/Ii63dXIAVLOBKdpAGDQxMilyg53o0shsrBmzImkZuqOeTYMrxb54KogDl2T9kS9Wz+gvSP4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658449; c=relaxed/simple;
	bh=yAS113Xi1m+ciU6dFoTzkx8/2yKanZ8kYO9L7kVEHJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pv+2sxMtc6G0LMfFnLUtUfCZZXqz7JxoczCu6OUOKGBOsel2TQtzlyVqCoiQOP/nsFKkhoWAz1i3XrLSODIM1ZoORt7XfG3V1YNAluJ+pWMoKLNEiJtp8R+Rm++bweQbfbkm4XYeBWFbmRgnhQmQ5louKVWrZDQmooqa/3v3ue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JVyAEcOb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DE9D026015
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6ntrnFQnFlaMDLEgX3jLGjQPUfBCLZxowGvuanAy/QY=; b=JVyAEcObVEi4bHU6
	JnyhrkFu0tqKg7KtLj50sPg9AF2COQfppr5+yCrbKo4TTTNitLZ+2UaMR0zCH1Jb
	dv5F77y11Lmh/5hEKyUtsiM9dPU0TUOBOS0KpLWqPlfqkAUsu3pmRQBNUgQTvFD0
	OmNXfzss5//jumu6hrPdOsqYuGg5ZXxlTEjPltPaGH+YEuCsX1YqQQJkJtX4ue94
	jAVcxsCSKAw1yw4HNVN0Ks6Luz0fuhvv7tZwQZ9Kxei+4INRfQltKARwYisswgpv
	TPiPpiBXiGATYkIWiv8RjRjlqcNN6v4iJT/6b0fKNr51PoPZw+g24Gz8uAliGaWL
	IAGxCA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475v2y8edd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:05 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2fa1a84568so692740a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749658445; x=1750263245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ntrnFQnFlaMDLEgX3jLGjQPUfBCLZxowGvuanAy/QY=;
        b=bLMqoE0ZJQqFQSwKFTJd9Uk15frj4hqDkbDFuUXBRQG1sN+QXjeteAMlEufmqgqtRa
         3EA4XP20vNaXajMSQb2HhKtl+4dSI8Hs8FmR/dwCl3NtGKNP3O8MbagjNzvM573wouKL
         KWaj5EM8AMGCT/IE26AfH0asfvNle0r0T3A497mtbziiLgR/7V2ApZLUpQgdbxWIvEd4
         b5SBaHevkKpBEOvv9bH7nyyd49WH4NbkzEo4H+iLQdZB66b3+4rrKZJ8Bg0t5F4g3Y+2
         6yGxXEWYW99TZgmEGPtwj9qQ+cIckLkZxarq8f2v6cLoSlitSmh6zDiA+NPI+bJyR9Go
         B6nA==
X-Gm-Message-State: AOJu0Yzp6T7ko64T+o27WYrHhGadEnkCBuQkWeZ4bxKWoyHgCM4DDNX+
	Ja0XklLBF9IJN1BFcTNGnyXFEB8/u5ETmVLTjrNwxcoJgW657iJfeIF7n7OecXmNxbkqNli8eK7
	5o8OWXwoetB7bLXbfI9Hp03j1MywFIi4YmB3DKbpq60fdi6HlzQ/DU3LLzYW8596gOmI9/A==
X-Gm-Gg: ASbGncvIZshm+av7DYgGgZwkMk+b88Ck8DHI1FzD9Un+CgMATUUIV9g2TxIu6XsqD3/
	TDONMm7SAbQ+IOGbU/kLB9l/7iM4xFiQxknP3JowHsX3rqvrE0KhWmGjqequkzC4UmiiedSM1dM
	7DYkJxAHlOMOHFKS9HMAnUTLS2qhB9UwCmbj3ayNSI5mlMIxLsBoU1nBzpoBLxVU2NXyfnRtY6A
	ymd0Pm6gRbVW2fwCzwt3UdTrxUmDxOONmnUs1F2pTG6yWC3KfFSHYx6oanlZJQPrh/A1890pFA0
	tJ6L5zihRB1qD8oqg3m/yFQsI1bpTTUmZWeWKViLajy5yqAMLb5d4NjWqGE=
X-Received: by 2002:a05:6a20:12c5:b0:21f:52ed:23cc with SMTP id adf61e73a8af0-21f9907d403mr19899637.15.1749658444827;
        Wed, 11 Jun 2025 09:14:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb8WD5APlMYAYThMqyu8snrm9sea4wCkCVmMFKUdMbnqcbZXi7yzDm09p6baWlyksh96erOg==
X-Received: by 2002:a05:6a20:12c5:b0:21f:52ed:23cc with SMTP id adf61e73a8af0-21f9907d403mr19836637.15.1749658444120;
        Wed, 11 Jun 2025 09:14:04 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482cdf1c41sm9443708b3a.149.2025.06.11.09.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:14:03 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 09:13:57 -0700
Subject: [PATCH ath-next 4/5] wifi: ath11k: Add missing include of export.h
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ath-unused-export-v1-4-c36819df7e7b@oss.qualcomm.com>
References: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
In-Reply-To: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEzNiBTYWx0ZWRfX5syR6lNSNpAi
 oDDiraHL78uttH/JAL/gCjHhVj0AQUPihCPYQu4FlsdbJTlnJ3LqdrjYNmd/AQPKnxlD9Qp7DTK
 GdYQTA6jAFTbpqCU02OTyDmfLyXtJhlUS+9PcYmS6CjC80RNKEHmqRLjaglqFp0c3MErOMSidGm
 d3Ctpn7Vsf0jNAQe4rEdhugY12p63M697Zg/irhMVLLN5+TM7HM25Lhg+JG2tqNh0UyhBV78Udm
 gElgPW4DDIBhooc025yznkHRd9w8YuNYeub3Doud3AuN5yfe9VGw0xonHByATYBElIbbRp9671B
 /ryZL1Nt3g6iGgpR2FNzVTtpew2AXWy9+R7Pcq7otopAwmVCDxj5TxHYM+qi9Xqix5W8siP0M0f
 ousYySEyB5xqgg+NkaakQ8nvCHJIAMfeidqgvMKRmu+0A5dtvFc0CKnj9bxR4nHv9DTdx1Vv
X-Proofpoint-GUID: xLw5-i9UCBhSMNX7DcgcZ9qybqTGUR0q
X-Proofpoint-ORIG-GUID: xLw5-i9UCBhSMNX7DcgcZ9qybqTGUR0q
X-Authority-Analysis: v=2.4 cv=f+BIBPyM c=1 sm=1 tr=0 ts=6849ab4d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=NVuY5FSQAfTDsjSPyz0A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110136

Commit a934a57a42f6 ("scripts/misc-check: check missing #include
<linux/export.h> when W=1") introduced a new check that is producing
the following warnings:

drivers/net/wireless/ath/ath11k/ce.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath11k/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath11k/coredump.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath11k/debug.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath11k/debugfs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath11k/dp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath11k/fw.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath11k/hal.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath11k/pcic.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath11k/qmi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath11k/trace.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

Add the missing #include to satisfy the check.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/ce.c       | 2 ++
 drivers/net/wireless/ath/ath11k/core.c     | 2 ++
 drivers/net/wireless/ath/ath11k/coredump.c | 2 ++
 drivers/net/wireless/ath/ath11k/debug.c    | 2 ++
 drivers/net/wireless/ath/ath11k/debugfs.c  | 2 ++
 drivers/net/wireless/ath/ath11k/dp.c       | 2 ++
 drivers/net/wireless/ath/ath11k/fw.c       | 2 ++
 drivers/net/wireless/ath/ath11k/hal.c      | 2 ++
 drivers/net/wireless/ath/ath11k/pcic.c     | 2 ++
 drivers/net/wireless/ath/ath11k/qmi.c      | 2 ++
 drivers/net/wireless/ath/ath11k/trace.c    | 2 ++
 11 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index 746038006eb46586c0e47fdeb89faf1ccc4f0c28..be9395f2ed8b35f0c46ae7adbec9f2f9b0a4d7ba 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -2,8 +2,10 @@
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include "dp_rx.h"
 #include "debug.h"
 #include "hif.h"
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 22a10113613503bb2cf97185d2f6ccd7921e243d..48d81b82f8954acb74701ff86aa58c9ff6f20810 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2,8 +2,10 @@
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/remoteproc.h>
diff --git a/drivers/net/wireless/ath/ath11k/coredump.c b/drivers/net/wireless/ath/ath11k/coredump.c
index b8bad358cebec99af186d1b9d5f86a8ce5651177..1949d57b007a172465fd05fdf473b4a136cf814f 100644
--- a/drivers/net/wireless/ath/ath11k/coredump.c
+++ b/drivers/net/wireless/ath/ath11k/coredump.c
@@ -2,8 +2,10 @@
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
  * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/devcoredump.h>
+#include <linux/export.h>
 #include "hif.h"
 #include "coredump.h"
 #include "debug.h"
diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 2b8544355fc1a6bf43d2c917d8354c3d8749bd1a..37d23a559ba3e55458fee4181116b935925b3c4c 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -2,8 +2,10 @@
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include <linux/vmalloc.h>
 #include "core.h"
 #include "debug.h"
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 5d46f8e4c231fb75577d997e24730f8c87033ec7..906df3b13f4f0a84a76c71d336bb5c16f9477aba 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -2,8 +2,10 @@
 /*
  * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include <linux/vmalloc.h>
 
 #include "debugfs.h"
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index bf3928ada995fe015ddbe455083f4125fa136749..4661e0d64dd979ea0ec23fedd10d7c1ec91b141f 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -2,9 +2,11 @@
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <crypto/hash.h>
+#include <linux/export.h>
 #include "core.h"
 #include "dp_tx.h"
 #include "hal_tx.h"
diff --git a/drivers/net/wireless/ath/ath11k/fw.c b/drivers/net/wireless/ath/ath11k/fw.c
index cbbd8e57119f28d580aff74da9fcb7c3dbb33615..07d775a7b5281ad39f8b9b2dfe74e42e540a95af 100644
--- a/drivers/net/wireless/ath/ath11k/fw.c
+++ b/drivers/net/wireless/ath/ath11k/fw.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include "core.h"
 
 #include "debug.h"
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 8cb1505a5a0c3f64af0225ae59d9fd3f5f33055b..f1d76839a87bb2f2a3e425760883dd9fa4e52e57 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -2,8 +2,10 @@
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/dma-mapping.h>
+#include <linux/export.h>
 #include "hal_tx.h"
 #include "debug.h"
 #include "hal_desc.h"
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index 3fe77310c71fcb094b84baee0f87e106566a5097..fc6e7da05c6028e30facf10d38a55f614067e44b 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -2,8 +2,10 @@
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include "core.h"
 #include "pcic.h"
 #include "debug.h"
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 2782f4723e4138d37a6a567ae5f0ddc5bbd79767..378ac96b861b70799a1a8dfe1ec187f69a83794e 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2,9 +2,11 @@
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/elf.h>
+#include <linux/export.h>
 
 #include "qmi.h"
 #include "core.h"
diff --git a/drivers/net/wireless/ath/ath11k/trace.c b/drivers/net/wireless/ath/ath11k/trace.c
index 6620650d784502c51b7507b8cb2b9b95e04849f7..44ff8e9eff5d4d7f248716ebeab6257238fdcbdc 100644
--- a/drivers/net/wireless/ath/ath11k/trace.c
+++ b/drivers/net/wireless/ath/ath11k/trace.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include <linux/module.h>
 
 #define CREATE_TRACE_POINTS

-- 
2.42.0


