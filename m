Return-Path: <linux-wireless+bounces-37525-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tsq2E1DDJmq9kAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37525-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:27:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAAA656A17
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:27:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=fizAr6WJ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ByJwEvOj;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37525-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37525-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 237D23032803
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2183769EB;
	Mon,  8 Jun 2026 13:21:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0837268F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 13:21:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924916; cv=none; b=PqmwxqdoOApHCmo+itixRDGhtsWKx2ocjd/YZs804OXcsTuZkfxLELe+lGUc1F27OZ96WllN1Z6POLSgkDxbENVxKD2vqHHDy7b/V6JrG8Op9h5gVMXTNA2hEECLgNeyXQ94g7oTysFamoMh1yEJE9TMxL6IwMpH44MTZpErZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924916; c=relaxed/simple;
	bh=VkxPerGZYB296GcPdXlfO4kU8KJH1fEmNKrRMRIY9VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZaZLxHrO/rAV5efR7W3svmDu5W19z+GDJyLKX9eEhA3/MR/sMJcn7qeOIRTxwTXpTbefVSkjR8jpOqm6KytyMr1MCEQMXu9d1OJh+ZMyB27/nwN0dER8nicEfNYq9trg/7kWmG6FnItqRuIJFLENXfNO9fy3DuPm1F507WCOCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fizAr6WJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ByJwEvOj; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9jWL2919995
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 13:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LCvliVYqqAOKUycyeMO2VE20wOw1noVMe15EZ3nYEdM=; b=fizAr6WJ8/wuT7qD
	9KTwsWMbepAQiyETk0tm23tCsz1INbUiubjx/0D0jbSwhcRNNMXfThXRza+GrTIR
	THj12tOthyiumhHznOXw2BtfFfN7sfDZbepZLGbAlqZCyhZ+0aIkLU8SmXIwsRbr
	Fpli3j2/Z8O89Q1X1t4zARQoEwjqbWcK/RV1c7k/W+vIth9Cz6JbGOSQ5oZQwfeI
	bHhw1IgK82as7zbMDabiRqOsv0n09rqt1V+7lm4DRMLDomr5XVfRHAu1mE45GsVJ
	EwDiEk0jTLcATzxxV5gxdVgbA/sKiEFiaU+DjKgh92LrZEpP6jxdKX25LrFa7TYm
	Lhq5Ug==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgysce-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 13:21:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304f1820babso5309737eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924914; x=1781529714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCvliVYqqAOKUycyeMO2VE20wOw1noVMe15EZ3nYEdM=;
        b=ByJwEvOjfOp8jm5QsAaPfVQ6eK2uDaA3MLoXoLLWJBIlZCS2iO3Mq/kS7jnP1gkgtQ
         l+yWZw8ZEOjvaYMHMNH/wX79e1+Ysi+/HiifALjyYu5u9MW3t3C88eSPnmt3bUz+L8G0
         M8DTT5neEUAq62qqgeXr94qo1ftSt/mUS1C1oEfwuNG4vo521sSVG0qAuS873XGLHNIR
         Rg/O6BYqBNopzjZjQSz2U6XiQQ69vBTsOiZFQrQ30aqusOjXLEB6BrxiB/JDpvk+hxl/
         klrrSeSkSEt0yUCFWXK9LJubvVv5yh23JuZvBabknX7q0prl6QpvicJdl9QShC/aKmCh
         Kd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924914; x=1781529714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LCvliVYqqAOKUycyeMO2VE20wOw1noVMe15EZ3nYEdM=;
        b=mCTtycQMEObV6UKySqPM5N3Sp7uWnWfJ8NUnNttBrkM+NYZg51BMG7VbiT1A0q4tv1
         QJ3Th1duXG0vtfWpZAdon2wgoYxGml01sv/SQG2Oy/iSBZA1+jkEwHMgHsI8ZmmfZ/QS
         Ztbso0zPWcR5PWd+G7gh55Vf5+rBlL91FJ/osdvOjJU+QJx887mz2qSXXncQJy+hYrmO
         3qIsha/vJArOTXF1pI8XHM1fygIvH2Xz2qGqonhoozPqAzzmX5HFVn9pBkJj3EGF9giA
         CDOo3puC60MsZxdTrGuqVHrbCS+dV3Pfs/SaeyzNUqE4tzE9bY2d2un+PZuUyfh/k80M
         kPfQ==
X-Gm-Message-State: AOJu0YzgEMZZyj/xgiCgGgcGJE0ilXHSoM0oqLYDwcNV/FsBmk7fTo73
	DATAo+AB6LZxk5CkcX2ThVwiAX0VlRyMPkecIyQ/EBc+1YqBspskmEHphQ9sjE91EjM+VHuWqAW
	mCFIRG349oRr/rzDB7V+gXby3YsjhaL/h39TD15kr5mtycLJCnzfdfcv1oAl0/2HZ1upSng==
X-Gm-Gg: Acq92OGubSsTMRIbYK+cAQjNc0RCxI3hv6AKLylypWbnQQoNL5deU37h0XeESM5+9UU
	bcm/+zY7OjX43T2Vm+rTYzv2Qo+2CJR55jUwEmQWcAmnCZnl5OYNOAPNSgjNbYPb1/GTVP1K+Br
	GHh3KHOVlyOBsweRYpdC8CtIwEReU82Vgda+F2pSz+7UkWYb37Vi+QdEOHZJ0Ifwj872KH6hydl
	zF+Ak88o53fnpvhuKBKmuuASx90RecVPnMK5OqEjE9VzY88ByctMtonSloU1zRCSTzUBuQyEvNM
	QTgMlnAj5bAA+6EV6ROtk7lxDKfc7L7m6Isy4G5f7IFdL3RxdUo3nOwaVRRoxHC8YW3tpWK/k81
	cNU0ToXgdyzDzVMNB5WacvBHK001LBWygIIdTEeHuCWR6eO7nHCcBynTbHjifTF5uK5iICcN+uc
	BhYNnvOw9J+rI=
X-Received: by 2002:a05:693c:2d82:b0:2d9:f0b3:1d98 with SMTP id 5a478bee46e88-3077b25d0c5mr7678393eec.7.1780924913897;
        Mon, 08 Jun 2026 06:21:53 -0700 (PDT)
X-Received: by 2002:a05:693c:2d82:b0:2d9:f0b3:1d98 with SMTP id 5a478bee46e88-3077b25d0c5mr7678364eec.7.1780924913152;
        Mon, 08 Jun 2026 06:21:53 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcbe995sm21607280eec.13.2026.06.08.06.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:21:51 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 06:21:32 -0700
Subject: [PATCH ath-next v2 1/4] wifi: ath12k: Update Qualcomm copyrights
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ath12k-copyright-v2-1-37504d70b03c@oss.qualcomm.com>
References: <20260608-ath12k-copyright-v2-0-37504d70b03c@oss.qualcomm.com>
In-Reply-To: <20260608-ath12k-copyright-v2-0-37504d70b03c@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a26c1f2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=vZAPiv9bP6El6ppP23sA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 9SsvPETUfFonZUuAb2RZNCzZxA_KrauN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNiBTYWx0ZWRfXzLuw9PxQdogo
 M/pIvpTU9SqSP9hel0CsWKRD31zwAPZY/Yoaag4ZM52Wxlc2j0Hvhh4RK3jKJzWIYy/ydhLwXKj
 USMe+hLznemdK1d4n/odxTwpvkm4hcqZfQ6ANuSjTodvOWUyJA62owk/LuyAKitGHo2fKjIUvvc
 xGkoV5iqzvc3qlQM34rdgFkQdMx88WDWWD/Xq/Pzo36/Iy0I8RReBx0vtU9RtIFFEG3h+zfE5rQ
 5mbgBk8v3vex6lZvG9IKW/HwGeXJFb11MJBfm8UwmAewXzYe/1C+1QwyEjkgFvj6x+b2juckbMh
 pRq3ICTlK3TbuQzcFcAOhjGLYWrZx2Od+civ19w/30YFvJ782MAL0laR6gtmT3CHJz/t/IbmMR3
 apTgxEWuUcA39UPr/kCXDXegkRsd1Bko0O+7nrRpO+aWg0d2BQV+cN28Kzx7N4upi21E96Metsv
 Ag7unUjDqtzzEYP8UMQ==
X-Proofpoint-ORIG-GUID: 9SsvPETUfFonZUuAb2RZNCzZxA_KrauN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080126
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37525-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath10k@lists.infradead.org,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FAAA656A17

Update Qualcomm copyrights per current legal guidance.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/acpi.c        | 2 +-
 drivers/net/wireless/ath/ath12k/acpi.h        | 2 +-
 drivers/net/wireless/ath/ath12k/coredump.c    | 2 +-
 drivers/net/wireless/ath/ath12k/coredump.h    | 2 +-
 drivers/net/wireless/ath/ath12k/dbring.h      | 2 +-
 drivers/net/wireless/ath/ath12k/debug.h       | 2 +-
 drivers/net/wireless/ath/ath12k/debugfs.h     | 2 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.h | 2 +-
 drivers/net/wireless/ath/ath12k/hif.h         | 2 +-
 drivers/net/wireless/ath/ath12k/p2p.c         | 1 -
 drivers/net/wireless/ath/ath12k/p2p.h         | 2 +-
 drivers/net/wireless/ath/ath12k/reg.c         | 2 +-
 drivers/net/wireless/ath/ath12k/reg.h         | 2 +-
 drivers/net/wireless/ath/ath12k/testmode.h    | 2 +-
 drivers/net/wireless/ath/ath12k/trace.c       | 2 +-
 drivers/net/wireless/ath/ath12k/trace.h       | 2 +-
 drivers/net/wireless/ath/ath12k/wow.h         | 2 +-
 17 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index d81367ce6929..c1b9be3e03ac 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
index 3a26fea6af1a..dd80eebff96a 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.h
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #ifndef ATH12K_ACPI_H
 #define ATH12K_ACPI_H
diff --git a/drivers/net/wireless/ath/ath12k/coredump.c b/drivers/net/wireless/ath/ath12k/coredump.c
index ce1beeb54836..070512338f13 100644
--- a/drivers/net/wireless/ath/ath12k/coredump.c
+++ b/drivers/net/wireless/ath/ath12k/coredump.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/devcoredump.h>
 #include "hif.h"
diff --git a/drivers/net/wireless/ath/ath12k/coredump.h b/drivers/net/wireless/ath/ath12k/coredump.h
index 13f46a605113..584ce0a085a7 100644
--- a/drivers/net/wireless/ath/ath12k/coredump.h
+++ b/drivers/net/wireless/ath/ath12k/coredump.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #ifndef _ATH12K_COREDUMP_H_
 #define _ATH12K_COREDUMP_H_
diff --git a/drivers/net/wireless/ath/ath12k/dbring.h b/drivers/net/wireless/ath/ath12k/dbring.h
index e1c0eba774ec..780c27c570e5 100644
--- a/drivers/net/wireless/ath/ath12k/dbring.h
+++ b/drivers/net/wireless/ath/ath12k/dbring.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_DBRING_H
diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
index bf254e43a68d..658b8083c9c3 100644
--- a/drivers/net/wireless/ath/ath12k/debug.h
+++ b/drivers/net/wireless/ath/ath12k/debug.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _ATH12K_DEBUG_H_
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
index 21641a8a0346..f5dbca1b8d75 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _ATH12K_DEBUGFS_H_
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_sta.h b/drivers/net/wireless/ath/ath12k/debugfs_sta.h
index 8de924f4d7d5..44c78f3ab904 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_sta.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
- * Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _ATH12K_DEBUGFS_STA_H_
diff --git a/drivers/net/wireless/ath/ath12k/hif.h b/drivers/net/wireless/ath/ath12k/hif.h
index e8840fab6061..4de8667690e9 100644
--- a/drivers/net/wireless/ath/ath12k/hif.h
+++ b/drivers/net/wireless/ath/ath12k/hif.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_HIF_H
diff --git a/drivers/net/wireless/ath/ath12k/p2p.c b/drivers/net/wireless/ath/ath12k/p2p.c
index 19ebcd1d8eb2..ae9a8be17be4 100644
--- a/drivers/net/wireless/ath/ath12k/p2p.c
+++ b/drivers/net/wireless/ath/ath12k/p2p.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
diff --git a/drivers/net/wireless/ath/ath12k/p2p.h b/drivers/net/wireless/ath/ath12k/p2p.h
index 03ee877e6d6b..3041f88508db 100644
--- a/drivers/net/wireless/ath/ath12k/p2p.h
+++ b/drivers/net/wireless/ath/ath12k/p2p.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved..
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_P2P_H
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index d784d9ec5061..89abf2e87ad1 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/rtnetlink.h>
 #include "core.h"
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index da5128b8c97f..7c37c0d2a6f9 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_REG_H
diff --git a/drivers/net/wireless/ath/ath12k/testmode.h b/drivers/net/wireless/ath/ath12k/testmode.h
index ef6ab21d19b8..342ed0a7fa98 100644
--- a/drivers/net/wireless/ath/ath12k/testmode.h
+++ b/drivers/net/wireless/ath/ath12k/testmode.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
diff --git a/drivers/net/wireless/ath/ath12k/trace.c b/drivers/net/wireless/ath/ath12k/trace.c
index 0d0edf4204b7..772a5a7db98b 100644
--- a/drivers/net/wireless/ath/ath12k/trace.c
+++ b/drivers/net/wireless/ath/ath12k/trace.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/ath/ath12k/trace.h b/drivers/net/wireless/ath/ath12k/trace.h
index 253c67accb0e..053d681302f0 100644
--- a/drivers/net/wireless/ath/ath12k/trace.h
+++ b/drivers/net/wireless/ath/ath12k/trace.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #if !defined(_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/net/wireless/ath/ath12k/wow.h b/drivers/net/wireless/ath/ath12k/wow.h
index af9be5fadcc3..273705956815 100644
--- a/drivers/net/wireless/ath/ath12k/wow.h
+++ b/drivers/net/wireless/ath/ath12k/wow.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_WOW_H

-- 
2.43.0


