Return-Path: <linux-wireless+bounces-37521-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TxPdIcW+JmrccAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37521-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:08:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C49656730
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:08:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nkPpj9el;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=glStsN0U;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37521-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37521-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25CCB30285D0
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772A32B125;
	Mon,  8 Jun 2026 13:06:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F731A065
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 13:06:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923977; cv=none; b=Z2CCjz6jwT30krna//snf6o6nSxdPtTBHCWOvLX6nba/61YX2/zA8bPIMl+iRaJzuX6TYwYC0aDT2+eVpSzExNHtkDDOfv6Xqb/uVXBDBHj5YfYUdOuC+nZyTZfIcb77B81AHcPhCdnuZUDrsMM7uRgy71HQfjJaVh2Z76TWCaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923977; c=relaxed/simple;
	bh=VkxPerGZYB296GcPdXlfO4kU8KJH1fEmNKrRMRIY9VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcJJWg/gNuFtSFGff7GlEsPRFV80KK+WK4KZzU99muviqJnyUOcjU5DybeWszyO0WpdV7rg6TuuXNnBZwegNSETOKhz9F4kQIJsBE96+kZe5te/qppR0BUd9cnewW3al8QYDT2Vwv2hD5htmTXT5YQ+Q7PGzmpAPOkdlutehTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nkPpj9el; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=glStsN0U; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BBEdI3417181
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 13:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LCvliVYqqAOKUycyeMO2VE20wOw1noVMe15EZ3nYEdM=; b=nkPpj9elpQDZfDCc
	7vSLpk735Gx3of5MxuyIepN3pL1sBPu5C3EulPxFbeuhBkXlLI1A41rtd3NmF61p
	3iKfxbbUTNJgWqgrKGCn3Frl4xBNa9JT0tnpwPY7CTDVV/Uk8GuPAt6AHXG2Ku/v
	51d2PNg2uIHeyor8t3fYygDhvtc/rLs3mC7+nsh40glTkcxXC/pZr6A5ubYTVz5a
	Pr1xHLV1Kx5RYCezQKJz88S7bU7TkCYURrKTwFVVB0pyjFixuIPHbwZAv9dt+0Sf
	ozeBKqZnBaJPmIIcfQ1HI83kLizdEqSO2AWDBlTI0u2OEiBnJ6Y/TMPM2O+26vv9
	PmUXag==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuptgrfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 13:06:14 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30762d67a64so6017795eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780923973; x=1781528773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCvliVYqqAOKUycyeMO2VE20wOw1noVMe15EZ3nYEdM=;
        b=glStsN0UTkmdlStekn4eCukpHtSkLz6tw2GXdttBG6+ObSQA7VGMbLlk1lRNB8My71
         KQhTIhUR6cg46EA6MCUsilXowtXNind2PQlUmcmLyRt/NCnZNuCa9mDvDCKAHj9Z+m5W
         +6YdcRjtBDBHQLtQeFft0M4IohCBQgsvmfMzlwp4pk2HdrZNqEsZ3zq3UA/copLsmfDJ
         /SiuGKweYgzkOVajZCZzYH+1dox25YdIZ7q+rVEGnuhlncTME4Zl0rCQgRY0UWorDxWe
         MHWjXMsOE6wPYtwq/C1fv3bjKjAqHQ+DCduigJlsaZ9lcT9fmDfGe7wMPMGSd3IejyKI
         R4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780923973; x=1781528773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LCvliVYqqAOKUycyeMO2VE20wOw1noVMe15EZ3nYEdM=;
        b=i6N8UG4D0WXKbKhdCLKffifzGjsx7AZytK6yGc/I2BLDC9mU91LMKP22fk24Y+CFRu
         uf282iOmLC2YZl4mYKFOCRjWx4egmDQzTiHvQnz77LsZ0MkfZpgNQE3mQnql+HY5ldSL
         1NKGpNShsY8xIITcctrNtkwmaj2QdXMhrTyeC9wHMhJfT3WzvPhK5Q2pYnH5wmr1RffD
         VlNhmmuNY5ypG17xtU21H6P5KjKGBVSmniThOxyV5Fkr9IVFsK6wg8iox3jD0Q/xMELl
         3aDm29ot3jVtLz5bf02fSRb3aRVlmLmxTz8Ucooy5h6IXvEc6uWjto0ZVI3c1dyYy7bl
         Hgyw==
X-Gm-Message-State: AOJu0YwR24yn5L1G4mMMNxr9+q196LYQbqIsSFeoASIdWr5GJeUxg2bw
	u8NXfLEQWOIRWCuMT19GmwByvgpH9aoBE+gYbv8LWvnxOACnQ6raElf9fJpEuwBTAvVlHbsLmY3
	4tibufIdAfRSF+rXsJhButyi7k3YyiCTB7b+F8OjOlzPnm9gTanNDnnq2hj+7MxkeoRsSAA==
X-Gm-Gg: Acq92OH0a+52riiR+q48FK1emL8JeNZbj1CSnFDjZw70kFRQZto4EAAtW1ELevRWQSm
	Da35ztLNm1DcvcvO3vdmUuAMb68p7ev6evpsh7MerlMit0fIickri7Z5yi/Rr11DbiotmOPIE0x
	KrvSEpa0UQZBCEIPDivKvrGGN/optFCt5M/po6hvshUSR0ZJ++IR9K6DdfQkNancDMtSzPDithk
	t1HqCRl1iMS2qZBYXLJtML9dZbtybbAyQLjP5vAbTWlR3QN8ujnnJDXRWJqQsecAzRigzzH9adr
	KmGOKTiBGdl8NLg1EsS7KEw3q29OJDqOMTVGHpVXmDRN7Na+Sam+WGHxGXcHZ5hqhGQ9y4Rgm4q
	nCEpS2rDMNyeD3GoPrtm1Q6luCkXN+tbA4HCzy1FF6qchG7ErJpNsDr4MFD0gS4OoE+38jSDypQ
	HRcMf5FiGN66o=
X-Received: by 2002:a05:693c:69d9:b0:304:dfb2:2274 with SMTP id 5a478bee46e88-3077b782a7dmr5000659eec.28.1780923973126;
        Mon, 08 Jun 2026 06:06:13 -0700 (PDT)
X-Received: by 2002:a05:693c:69d9:b0:304:dfb2:2274 with SMTP id 5a478bee46e88-3077b782a7dmr5000629eec.28.1780923972432;
        Mon, 08 Jun 2026 06:06:12 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba9d43sm15666701eec.10.2026.06.08.06.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:06:10 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 06:06:06 -0700
Subject: [PATCH ath-next 1/3] wifi: ath12k: Update Qualcomm copyrights
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ath12k-copyright-v1-1-e1a71f92d447@oss.qualcomm.com>
References: <20260608-ath12k-copyright-v1-0-e1a71f92d447@oss.qualcomm.com>
In-Reply-To: <20260608-ath12k-copyright-v1-0-e1a71f92d447@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 781X8jkPXG3NXR5yrOu00WORa05XNgdO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX9z6NfUKPdzti
 cYwLKssW6vJyU5k5vobGJcSuv3iyEznW4BZ3tj9piay7Vm98OCEoFzvMRvoQYwbFHTNiez+L0UE
 0JBK11n5BAXubJrBjBQ3BOGcez4TzQef/NZHGk8LHE4vvVOBRyMWlz2/9cN7C0uuxqavbE71Ehe
 kvc26nyuEWitqHJ4pAPteQTFZ6fdfB2DUx2F0KMH09NK1CaPdak0xthvOTyvy2F6CB48VlxtiNm
 ipVN9wQWPy2MdQ+Op9fD3jbAFCor/j5NrXTRAA/+S64pVHCsPvLVhcj3mrU5v1yJzbmsYv0T5IA
 hOEnXsKPOapQ9q8L8ev8wHAJF1hL5yXYJ/j5BW73jIn2mul2V+RbZcaI1fhYTzn89TlaNLi3hAy
 a1+/BZ/6uz9YhcsBKAF/0Cs1j/6mSV+pMUtbtmM3/ASApTdOphJuAnpglxHKVVf5PhJXxrOPqwL
 AiQm2+BUyjnoZ8JqNxg==
X-Authority-Analysis: v=2.4 cv=XKAAjwhE c=1 sm=1 tr=0 ts=6a26be46 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=vZAPiv9bP6El6ppP23sA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 781X8jkPXG3NXR5yrOu00WORa05XNgdO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080124
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37521-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath10k@lists.infradead.org,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 31C49656730

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


