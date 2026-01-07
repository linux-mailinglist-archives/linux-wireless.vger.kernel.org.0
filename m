Return-Path: <linux-wireless+bounces-30420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B19CFC242
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 07:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F151230509DE
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 06:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0546F258ED4;
	Wed,  7 Jan 2026 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XhgltAQ7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g0qGpTnq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B826E6F4
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767765787; cv=none; b=R0TYHPDdPaaGqXAIQY0BkomUzK+Q9s7aUmKWqFDZ7gfpjI74R6LUuwMYySEPkXRhXl/F7J6Zh61PmRi7KC1WESGnKqhiJgL7F1eWnVZmFO3Y37mLdVXnja7DXKeeJUyxxSaDoDdJDwKSexpoMSwR1kCyVRmLcQwINrok/L4A/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767765787; c=relaxed/simple;
	bh=oHNtGs/qCUFkBbVn+h6gCL8iMFMby0KauJny0nhQTCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SqAocgHO9fwtSqD/iXK9QF2wuGPEmWFb/adBn+wUUVga0qkexE5mE/48P++ske7kpFnWomw02Cha7F9n2CxCJDi5rZT33j8OoauZR6RlMqbij2F16m3i3WjZiyIqpaKUF6F12YK4Ni7cTgtCVeeiAquLX7M7YHC9VMZRzrxJfp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XhgltAQ7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g0qGpTnq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6074mLpg1643279
	for <linux-wireless@vger.kernel.org>; Wed, 7 Jan 2026 06:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3MvI7j0vd4F+cVEtUNueM92+VITC/CkqafR
	Nm9AbHnk=; b=XhgltAQ7KzNFUBi5O8vseUWjF4r2p/P8sbrMEBugFbk3WJuQjCN
	pEgJz7ZpWZAbMaoqN6SB345nKvjGX23OHECQUm+g2wbrAR4e8lKCklooxLUkBSYe
	po6EtgVusAzvrPTihleX36u8z2jMKRwBDvTVRRUxsJINPXOTnxVeVjSMf+syhKRB
	LlFfXz0/5iCZSbW5oH3Jm7UdlZSR5eP4B5+vbWbrFwM1OTncE2WCSbbMP+U3UqZb
	2QzQo7wFNc35Wb/RUUwE3Mgyg7FiM/1RRBagP5VZ7aU34cx5ohM0dAjSFjVykHTL
	bcrotNJGS0b1X8mFJ6aN8KSh7DwVAbIpboA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhgsfg6m3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 06:03:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0bae9acd4so14183085ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 22:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767765783; x=1768370583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3MvI7j0vd4F+cVEtUNueM92+VITC/CkqafRNm9AbHnk=;
        b=g0qGpTnqzueav1cVtxjeBq6QKwNGHytmBs1l/kb9aEmYDnNACS71IbFzEgRIouYLjA
         lRf5h992LbJa4+Fk9x7+O8IVzhj7HMw1RCcX6/TQQPBCKSXjYpkh17KkKN4/13MYU8Ns
         nUc13R/+Cq8Qag5xdwG7I4qmB95kYAXlu4zQ7jbJyRea6WSMFBKNnAqKJf1QcFvnTJKY
         BsELQ7PLxGGl3YhCHv4rwtlCW9RuJ6w3+irpkJ5pjzegIKiqQGXPMvtegDmUT0FZvDJ0
         FeaSFHwGOLjCKe5CkcKWd3Li8C5KMtiUwDQ6TWSsShIIKLWx5oSFoMDf72no0k/dUlwN
         Xogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767765783; x=1768370583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MvI7j0vd4F+cVEtUNueM92+VITC/CkqafRNm9AbHnk=;
        b=FkGr5trceQJVvxOlhHDn1+pvLo2f8ZEUsvb0ankm50sQWAhpdhzCIrSQ8bTVkmwr62
         2b1iRXJVur88n6kjU1soyxIHsA+W1HOZvaHD0lGNh9TlmlTiwNxxL1rOATDResHWZ2Vg
         xu08FZoi4fv9hT72rKfymQg9AG5Cziw8aK5+To1tSYT/Ak+Ilp/C0ShcaUlgAfrJnrD3
         K1scEhc+25rnWvKl5yupsd1fP8ANjGEw1kF26uZe7Zvz3pe5oGTu9FiC8ezJe5GFYkxZ
         S0ujOnk0jBEDG39Sb9TgRCK7MoIiVS1/wJed4MWMIK2TDgx0ml9TZU2t1UccfsT7Ja6h
         tB8g==
X-Gm-Message-State: AOJu0YzUDrYJVTuOdst9yAuJg92JjntP40ioz0CC+CDvhGctMDxy2qjs
	PbwHT9hYklNV7zPnGwKoH6xlJ/zWGT9x4rFEp78xGVUBcC2UNwKIZdzjFd6ZeGsDdEuwTmg4PBx
	dE/UWCIp6UHUpYsnsmJ7BG5PCTsW5oVI5ZI7FkbN7B4clfCWXDsym2pKrymhgLKDQCxas7g==
X-Gm-Gg: AY/fxX50LVoU4mfVyYbQglGXv0O7O6JrngBonle2PePFNsn5uy6DZLUkgNYac2o/T7V
	CNOqdR42A7xxIj76uWSp/RNxAq0fz/v6sZjCVlmgk90omRDx/xwBAMcg3uQ6cIHmzpbYBSPLQZU
	9ZegphmNfvqbXUh043/dUd8xJjvB4NEYvYkcNcCv6ixPC3+lTByGN8e4+isti2qIfB1bMzVxSW/
	MZKK6qgRbbo7BFudqEZx6J4b9YsT7GYK1BZ3U3IC115tg/1Iun7bPFbMgpKryi2UNBck4r8wU4b
	LXYfZsgBVnlCYIJJzjlHBMCxJpZmz7eDg7MUiIQLmjsC355V9VnBIn2bHDDx1mhioEsyYsTBrQ0
	rXfPgldfm6w9ZjwSGj1vvAGtFC2G4xA==
X-Received: by 2002:a17:903:1585:b0:2a3:1d78:7505 with SMTP id d9443c01a7336-2a3ee4b72c2mr12443955ad.56.1767765782945;
        Tue, 06 Jan 2026 22:03:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg5Xj3sfQhEqVVpCrMiKcrmv8NcTJfC6i4EDzIVHijtU5iCkJ6kj+BqeRF1WXao8FI89tCGw==
X-Received: by 2002:a17:903:1585:b0:2a3:1d78:7505 with SMTP id d9443c01a7336-2a3ee4b72c2mr12443675ad.56.1767765782327;
        Tue, 06 Jan 2026 22:03:02 -0800 (PST)
Received: from zhangq-gv.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2c5bsm38938905ad.58.2026.01.06.22.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:03:01 -0800 (PST)
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Qian Zhang <qian.zhang@oss.qualcomm.com>
Subject: [PATCH ath-next v1] wifi: ath11k: Fix failure to connect to a 6 GHz AP
Date: Wed,  7 Jan 2026 14:02:55 +0800
Message-Id: <20260107060255.29530-1-qian.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA0NyBTYWx0ZWRfX3t/04bgn/IA/
 2nG/uEKMtefcsS/+s9mid0ZQ9jNzI27nhBBjP1VSSnJBWX39w6Km650WINh+LCr3DRvO2lWb2U0
 aQaWBQRNVIw4/fWp/KQtwJnrfnnIyFxYe7L1eTCGVdaDWecH8aKRp5JnZmXD3X4fFreBb+Vs1pb
 0wqZJGXxuH1eBwErVisqtLt5IFtlhJu9CkaVInwHZJMY9tAh82wm7xbfzuVzTXtg/c83C7jZq0w
 VSRVC47qjCQfHT3NFmAIhIFxsJJTEF3z6hURn+quT3kC2piY1+U09qrHTwzUpCpgOvP00hLS+hG
 GG5KzFeGOnmPJjNr0SZ4cc1B5HdIJAt3a4WIO2JVJATVe4Sk79vkDcPh6TZaXUG5h7YcsZlI1sa
 QgSG56udsRdMa9eIi/fLiPg+9nh8eVUeHW6vbzYEayirG5AjApWiKnSx0VysmEbgQnP8OmzWk6k
 3rdb8JPfaCRmw0kd4mw==
X-Proofpoint-GUID: G2JWgviIUmXnozgdtiqtUKBIxmZpEsjK
X-Proofpoint-ORIG-GUID: G2JWgviIUmXnozgdtiqtUKBIxmZpEsjK
X-Authority-Analysis: v=2.4 cv=Abi83nXG c=1 sm=1 tr=0 ts=695df718 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=7kaDdzVXBmEKihqrnZAA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070047

STA fails to connect to a 6 GHz AP with the following errors:
 ath11k_pci 0000:01:00.0: failed to handle chan list with power type 1
 wlp1s0: deauthenticating from c8:a3:e8:dd:41:e3 by local choice (Reason: 3=DEAUTH_LEAVING)

ath11k_reg_handle_chan_list() treats the update as redundant and
returns -EINVAL. That causes the connection attempt to fail.

Avoid unnecessary validation during association. Apply the regulatory
redundant check only when the power type is IEEE80211_REG_UNSET_AP,
which only occurs during core initialization.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/reg.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index d62a2014315a..8786ca3870fc 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/rtnetlink.h>
 
@@ -926,8 +926,11 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 	 */
 	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
 	    !memcmp((char *)ab->default_regd[pdev_idx]->alpha2,
-		    (char *)reg_info->alpha2, 2))
-		goto retfail;
+		    (char *)reg_info->alpha2, 2)) {
+		if (power_type == IEEE80211_REG_UNSET_AP)
+			ath11k_reg_reset_info(reg_info);
+		return 0;
+	}
 
 	/* Intersect new rules with default regd if a new country setting was
 	 * requested, i.e a default regd was already set during initialization

base-commit: e33fc1c6d54ee1569a57255e11c2978ba9a42ffc
-- 
2.34.1


