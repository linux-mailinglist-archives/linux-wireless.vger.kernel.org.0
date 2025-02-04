Return-Path: <linux-wireless+bounces-18364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14229A26B06
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866BE3A19CC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7001F9F5C;
	Tue,  4 Feb 2025 04:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DgqKHV0h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1CA19E83E
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 04:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643045; cv=none; b=QVvB/mC+REf+V5qh0dSMegzP5nTc5MzD+HbYPMYcLsEFOytRdFC1CCGT6DgA4U2vmTa/pxSh/iVuDv0q5zJewOz1pGoZ6dew/MzL3vhwZO8ciuwr+C89zIpNc3kXOpPo8tuDePXzIaUXmcyY+c3IKqknF2n3x/p0F2A3aMSqDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643045; c=relaxed/simple;
	bh=0cHLir5zfTlkMC+MP5DQJQztPNl5cmEGqQ2sJzIMWiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hv7YsZcYxX6TtNrmch6iAvXxDV1g0QNxY8B6yZ5IcjBiosVAf+8VEbA14QGKsqwEeFHNomvz/MmciHLWScbeM2bBUyyjjH7idHLxp4P2dO7LXwYuBD1BjR8zU2lGbFGPnglBFRxN/sxkiBmVLALCd0ctufA3DXN8m/xU42e4So4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DgqKHV0h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513LdOwE030234
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 04:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tuQlDAC1uyRPPd0Q4t6t3ezvkbclNHfIbx+5IkTBwug=; b=DgqKHV0h1jrfEX/d
	rh8PTezs0abJW+KW4BAl/Sg6Rd70DaUtuAQJJ94j/stW8Mfl/FZ0IgPxFcrKaHzQ
	VRK5aJVgD3QDot8LFoxaOKGxRZguloKI3GwkP/HQVG2dkhKU5axEyvO15FBsqNIW
	BMSyXlmeclJtjLltsSZWD9tBI19Wb7YRhxH38A+tYuh/j1ZO6i0oUvt2ebEVHCGw
	jmEZNHWEm0pjTefi9as/3ve4BcneeFrEjJbucdoK2zDoPBiDnUOf11wygoUuL14c
	HsYAEniao7nSSa+HnkMuo23Nb1emRYXtGwvPvDA8/C3UupCSC8g/wUmsaaVOyxld
	jp0jAA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k5w5rnbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 04:24:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f075a828bso1970565ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 20:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738643042; x=1739247842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuQlDAC1uyRPPd0Q4t6t3ezvkbclNHfIbx+5IkTBwug=;
        b=DW80C0J3i7fpy4wryVJm4TJGEfJEkjp1p71mZS1sypiuUpHADDAigtX1L8Hik2QpAY
         xdsfg8UosT7xYyzAmB6wTyqFnoUJvUEp5JCnWMrRaSUIYwKEqhOLg2GEr+Z2XfIPUXZJ
         XTj3+nGIMXjYq3C8xvPVvwq2S+EBVeFdQJYJ4avEwXziAiDSpBElfEWS+DIoCLZY2rAj
         CjSeDk4dwIky6IzAYCwvB/oDl32JuD1h1ZBgZYbFEKSg0EeAn6RgkggvV/quUrtAyEVE
         Txf0Mjp10k1fOqXK8WlevKf93lFPPpHTX4uSbfMw6CmYKJp0TqQZXgpOnxKUH9R+n2/5
         9/mg==
X-Gm-Message-State: AOJu0YwAn35INadrlUiew0mzYooEaJ5xe5FJG54T5J2Q5ZZ1EGD+Q5jk
	j5WcKELgCwRtoj48phWjflBnx9j3Nuz5gN6sOEB18l0wTgqRbq2MbwH9qx/1prdJtAPnnpEtBHL
	zBAYbC2YZedWC4Y+VEM7dPNajvfajJVbb86sRSzb5bkZljoiYjKuRzXjYovw3tWEB5Q==
X-Gm-Gg: ASbGncvN5CZsh1TCaKM2iDQEgQ4TWC5RBSQgKabYBTRJMD8cFlukS7TP2Fj6oTKBBfs
	dZT62b/0wNVHaSUwr3Oz32te0QuFbhhhZ8ObkARrPkHTaXg8PueCBM3Ii0nhD983NL7s65rvTGB
	9uijt+99+sG5wMH4D+4UB53piRHSYS/xB9KV1FfG5O1Neuxwv/O+xRCGf+gI+8DXoKpkXOR9mhB
	3P4qVYJfLCB2n1rwyPHu0cWV6a2xy5vMI+tQ0jRfPZbiXDwzNBi8Ys/5e8yHc5us8cP4dqCTEAx
	s/EkF/mQP2HwtA4juDtNrDHFu4nSQw1C6w44yxJ6yISWDUPwGt39/TwoVzlDdj5pJbUSVr7RApt
	kzL9xqvGT0SJUcezviScwV3sZCsr6lg==
X-Received: by 2002:a05:6a21:789b:b0:1eb:7da4:305d with SMTP id adf61e73a8af0-1ed7a5fb009mr40651214637.18.1738643042512;
        Mon, 03 Feb 2025 20:24:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENPasXrHF+Zec4r5yajnE82atYqWgoMYGed6rRtM6Ksm5rh+X8ASOmkezqS1ZZD4BU6HbCbg==
X-Received: by 2002:a05:6a21:789b:b0:1eb:7da4:305d with SMTP id adf61e73a8af0-1ed7a5fb009mr40651164637.18.1738643041997;
        Mon, 03 Feb 2025 20:24:01 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04796e1sm8897144a12.58.2025.02.03.20.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:24:01 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 09:53:42 +0530
Subject: [PATCH 2/8] wifi: ath12k: introduce ath12k_generic_dbg()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v1-2-675bd4cea339@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: uQlJM7i6LEF9DPIogBNTi-bku5CzjItz
X-Proofpoint-ORIG-GUID: uQlJM7i6LEF9DPIogBNTi-bku5CzjItz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=987 spamscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502040032

There might be instances where ath12k_dbg() is needed, but access to
struct ath12k_base (ab) is not readily available. To address this, add
support to print the debug message using printk() when ab is not present.

To avoid the need to explicitly pass NULL each time, introduce a new macro
ath12k_generic_dbg() which resolves to ath12k_dbg() with ab set to NULL.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/debug.c | 5 ++++-
 drivers/net/wireless/ath/ath12k/debug.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/debug.c b/drivers/net/wireless/ath/ath12k/debug.c
index fd9796b5ad3b9feea5c7e78e8a88d361049e08df..5ce100cd9a9d16f7fcc2dc0a5522b341ebbff8a3 100644
--- a/drivers/net/wireless/ath/ath12k/debug.c
+++ b/drivers/net/wireless/ath/ath12k/debug.c
@@ -63,7 +63,10 @@ void __ath12k_dbg(struct ath12k_base *ab, enum ath12k_debug_mask mask,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	dev_printk(KERN_DEBUG, ab->dev, "%pV", &vaf);
+	if (likely(ab))
+		dev_printk(KERN_DEBUG, ab->dev, "%pV", &vaf);
+	else
+		printk(KERN_DEBUG "ath12k: %pV", &vaf);
 
 	/* TODO: trace log */
 
diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
index ba0e4da3bb761a49fb81e3efcb61557df8ad1942..48916e4e1f6014055bbd56d5c71ef9182c78f3b6 100644
--- a/drivers/net/wireless/ath/ath12k/debug.h
+++ b/drivers/net/wireless/ath/ath12k/debug.h
@@ -69,4 +69,7 @@ do {								\
 		__ath12k_dbg(ab, mask, fmt, ##__VA_ARGS__);	\
 } while (0)
 
+#define ath12k_generic_dbg(dbg_mask, fmt, ...)			\
+	ath12k_dbg(NULL, dbg_mask, fmt, ##__VA_ARGS__)
+
 #endif /* _ATH12K_DEBUG_H_ */

-- 
2.34.1


