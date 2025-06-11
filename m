Return-Path: <linux-wireless+bounces-23997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277E8AD5B99
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 18:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60EF16EED4
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A224A1E5205;
	Wed, 11 Jun 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pRSNC7R6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B93205AA8
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658448; cv=none; b=l0HKt/D3x2llXKbsrcz/0S1AVAx4XSTgP7jLuMPX55M/x0RI0LqXMBUJZCLVdQh36HGo8HuRQmcPD7I6+cIx+drqO49itWLpAeA5XOTN55XoiV/SaGCkrYNWSpXnjZVxHMuwQrOCEdlpWrLYQMk+8fujG5DiK/wEMyTxx5y98nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658448; c=relaxed/simple;
	bh=KgmN6Z5U1HBDuCEx3knea+7L6zP1BXlcij2mPYCuio8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXGTO4VMrzHbiDSd9OlNVNhmL5gT9gErPV7U1q+wSAte7R/kXQx3LLd7HXJS7SNVpdx5Im64BTN4k3HaMhRTrXkPyBOTj58lG4ieJT9G4feJUd7IiqBBRfqKogJxdKY4zHEy0KH5pmyi1DO41qRpz/rdgBNFct5pCuyvocrTYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pRSNC7R6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DIF1013866
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GH2j/JcGCi/wRGQ9dQsBU2fKYdtjABlsIMmBhcg0SgE=; b=pRSNC7R6l5HnmRsq
	Scnjy8EdxHE1eJmHy9ZUbZAHkX8hC30QotCClFjZ3pNSON3KxyhSz6Oo0+F/24WE
	5r/hzrSpnTcFpocwRCW0w26zWx/n6q9ptqLi9ABqjXZ4R8i+rtzZu8uM9v13astM
	YIxexQdGRM7WMPScyf3oLUwix5uCDdN2pIhqfRtoUFk/i8yNBQuUnTUuvoGtC7rW
	H9sH8oS+0VDXP5mONn5IBw0Ng+gDpkJaX/9alty3gELd7c4145JggGTHAKMyTWXl
	BGqleD2qrXDTtFhVE8Nxi3Sva+otxjR8V2KcTQYF4tTWQUOjyfFN4DR9n6l3HkcN
	fRoN6A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476fmnd7fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-747af0bf0ebso40744b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749658445; x=1750263245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH2j/JcGCi/wRGQ9dQsBU2fKYdtjABlsIMmBhcg0SgE=;
        b=aM61zVzVNyo15QXVlVmckE4VDtH4qB05/9/nTFTN6baM1d4uhTMcb9KOx4M+V76sMw
         SF9+eaqIV7Gis64ij2YcG4v/o+0Dq42wqq9e5zsL8JXWHH/CzJf/om/TeZEOGZCuMJq8
         vbkinrZUqL/uFcs6+zptiTupCA8VpC4TvB72w470Cx3ITXqlc5HBRpzcW4+oFQ2xiFwF
         YSjMG9rKlFm043Md2N2n+9ivo5j678rqozqpnQfwNa9yWaePzr5jyGk2yarn/STFsaWr
         X3DBZ7jeOLt7dnvRC23TSfvMQ1W6YIb2/JSvE+fFIYD/hotLkKtJUjGk3DUvFrtMf0KC
         agoA==
X-Gm-Message-State: AOJu0Yw/XjUUvr9YhpDIV4+2f+TKFcp1ndIyx/X13FJHIgY7RnxkmrOu
	EmoX6hWExG+bmLfwR5o1/9iQqbP3pSPykqzr/TpYxLjM+oi1guGNpMZ0X8QBwAMPkvKMrv5cYxD
	chAzsd6Iihr0l4dazk6h1BVGGGv9ONB4bKrugmrf96naxYebVuUdf+2tOY+9UNFx49TD0QA==
X-Gm-Gg: ASbGncueL2dj7wWx+A3GyHfLO8JPj+u1JoXlkzQt6GiNuncrs/OEWODWqHLw2mSc3la
	gAldPFs2OGtvwFB0manjx1mcsM5DStXtBSeJy3GTOV2xeZqen0IZfp2PbKQLxyCy6VmK19Uc1vP
	JwJl0JogBybUY3riLOIFBlJTN6cX4Vb04Wo2dBjJG6jdvcPkTEaxkZyPI1NJJ9a6MgB2ur6LhbE
	uPZsvjI92T1c7/xWrWwvLWuTSBJKsoUsm8xOvQ13+YQkvc6R2hGlcgUHl4A+5g5PFhdFZ8keGQz
	XiWALvAn9/aNSvhmj4NtRFH0KzYYym0gzVuO4yaQsmjeg8Q2aAmXIMjwrmE=
X-Received: by 2002:a05:6a21:3943:b0:215:dfd0:fd21 with SMTP id adf61e73a8af0-21f8672f2a9mr6863599637.34.1749658445459;
        Wed, 11 Jun 2025 09:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhF50A00ZTd8vFQ+6dCgRXF844Xy0RmBjMaSc4ILELsZo+JvEhAIFYPQ0WDZr7mZZy0t8u+A==
X-Received: by 2002:a05:6a21:3943:b0:215:dfd0:fd21 with SMTP id adf61e73a8af0-21f8672f2a9mr6863542637.34.1749658444992;
        Wed, 11 Jun 2025 09:14:04 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482cdf1c41sm9443708b3a.149.2025.06.11.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:14:04 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 09:13:58 -0700
Subject: [PATCH ath-next 5/5] wifi: ath12k: Add missing include of export.h
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ath-unused-export-v1-5-c36819df7e7b@oss.qualcomm.com>
References: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
In-Reply-To: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: kCzHlqx0xeLsoYPpOvp2F7VM3jXcFshC
X-Proofpoint-GUID: kCzHlqx0xeLsoYPpOvp2F7VM3jXcFshC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEzNiBTYWx0ZWRfX7QnHpE4jVRYi
 0+t4/jQK/1S0g1AHXgavTjTrD1efO6WZmcRs4mnUzzVqdyYt/hV2kkbs9oos8nOdOI6GSap9FUq
 4xYakL6T47GZRn078Y7mRw/N+OzzMFANUwPX+0pWA1q4W6U3RTstDTP71w7QIAs9JajCDtTqBHK
 neegp3xWNiVAdTxEwiNr7MBMiRNpzHj2ecm3i/CYe/68JmNyW1A9AHvqdYeyK/AaTcXSWPvupg/
 OdyOli6J8/SR+d+MirTCHWaOwYfUZJg9fGvkM4M3WjtaSM9UbAdMYPPxvmY/GccJfO3Hf1YVEJ+
 oDfs45tzV28xzWsya8CDayejsxOQsdqpGKl+Lc5YeiYY/42zQH84RfHops3/epjV6b5BLTgYfgq
 vw8IROmu0qo3KZZZ9+i9/39fUjaiUtpsq8F3DUVfydHg+4c9MB+271fzlHJvGvtN3QiQpYPT
X-Authority-Analysis: v=2.4 cv=K8wiHzWI c=1 sm=1 tr=0 ts=6849ab4e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=xduYLtDgZ1illbjtIHAA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110136

Commit a934a57a42f6 ("scripts/misc-check: check missing #include
<linux/export.h> when W=1") introduced a new check that is producing
the following warning:

drivers/net/wireless/ath/ath12k/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

Add the missing #include to satisfy the check.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index ebc0560d40e3419130e4caf01c9b91bd9affb3bd..ee0ac2e4e74b4b7a700b68a2077aa5b9938362c0 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -2,8 +2,10 @@
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/remoteproc.h>

-- 
2.42.0


