Return-Path: <linux-wireless+bounces-34194-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KeLFRTgymnEAwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34194-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:41:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2BF3610DA
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76B523046B88
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 20:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D336F39D6C5;
	Mon, 30 Mar 2026 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LkYcWa/L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qn6y+Al8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257439C003
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903164; cv=none; b=N0Ix0OH6OdgWBiDXQnPWrhRiYr+q4cLKJh7H8ZAhzAWqt1ThbVNjpt5/F+yo44vJRmAon2AqpTWPe4jHHrcuBZEMZWo9t7+YnuCAljb/K6SZHykFnh5YcyA8Mngp/uifP1g6VEvWcfQI5ygSnxp3ermQmRFWOjELf3VZVNehFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903164; c=relaxed/simple;
	bh=7feR8JXOW8roAqvni7qC46BUe3HpOJFdYh26onFNy4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqIfv2L9BHDDazi9XFKk9txnVgINXPUxWCdiMlZOgNGfTo4F0XlAGNHhM8yBxzLYUGJor88wzxevb9czcXA5WFS4h9k9n1H35qiavC74yyt8y7EWE4RBjoS6/bdiQN3KuLhasMkySsV9F7n82djRl6tOGP0c1pQtKqES91YG1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LkYcWa/L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qn6y+Al8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UEWsOh3721893
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hHWj4m5kp7X9p0xcITcipoqa6X4UhFrBaGVb5fpuBNQ=; b=LkYcWa/LzlP1B607
	QnljtAkg0WxbUKfmzal0zwXu4FG9yrTzXSSI2kNW1zZoPMdDDWQYVRCfpxNDhrL3
	bNzxe4Oxaqev4zLYR52KOd/w46xizFUa5321ZH4Ef2FRSjLj5saWTvEbQYGCtYw/
	9Lg9AXju8PEMgjz+aD6dQQHs/q7TCHUBFEqMoiahEK5XwhD6xrsEgLk3Bgpb1okI
	QxVyYZ8H8y849RoA23uVZ6lUDoPLKZarFA4Uo/GyWcUwFB9dnnzHWBMGTqM/bBcq
	6tXQCIQzWry5QsAQTVlWLHi2/9ArSur1G5iEjiFu4AEE+vl60sHodHtJR2dPcKwb
	Br8B9w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7pvmtg4b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b242b9359aso25216705ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774903160; x=1775507960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHWj4m5kp7X9p0xcITcipoqa6X4UhFrBaGVb5fpuBNQ=;
        b=Qn6y+Al8YddrzPyIyMSLerz8KD0aps0s8WiFerXDwa5B0R2bgqdDoZxWYhhgIfBP8U
         him8pW+gThkzp26/N03R24itaswGzuEIYjfzKQITSByc/fduch9RIBUoeAp8+q+tJ2Vd
         sx7IQ3xfaHyYJ2NVZW9KvrOgVouOb9fJ36MIRcINfOpmR7m2aQzKfpZ0NE4V8JbIySt2
         cyThqiUTAWu7y/KsxX/ljTfhbxopCP6L+WnLYPfxO6ZZnSHoU069Ojs8UZZMSHzrYc55
         qGsN3YeKHudfMoq05UnCHlg7fggcAM6SXnUi3Uh8EDBCGVtxy+hrzdPopfcC/EhrCtfm
         JVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903160; x=1775507960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hHWj4m5kp7X9p0xcITcipoqa6X4UhFrBaGVb5fpuBNQ=;
        b=kNwZIQbc0zFnf3Jfuxx9DP79g1Lm1/qXlMe5BFlM7jO+hXGFAA7t65B+78iVFck+Rl
         t3Ca82UIn8WJa+FP8tMpmspDIeFYRO7h7OwHXuiDeVzQujGykHOTPaFDMpOmjAd1nIIO
         xXk1F7CZE1f1aUcVv83xh7b/mVFqttBKKHg8CZgRglDA5Dw6nou6lBkud5cc/ZeQ10I7
         g9Wfetm/7aXRv7BWPHV/gq5lX9qfGaO6m1d7UGhIydQyMD4LIXglInpeGw9Makyk9L1m
         SJUq2IydMPEh4kZz7JCMr35RwjtU3ZuV9OX3+6JBD1IrrttiVl3t20GlgxTiZnN//mDJ
         496w==
X-Gm-Message-State: AOJu0YzqQOR1BpPDqkNhb+RSi72sgL3c7NKKz5ybWi4u6MFwpWVU2huh
	PF7irL0txSYUItApaeAv0FQq7xP/VHe5qHHAIZOXlTFA63egPYYEm0oNzkD1aV3wV+FuPR3EBrh
	97wFjygpPrG1wCsZu5/fP2tzdKdOCDNbhY8U9Niv0Z0GCMG1LIXJX+MtTmidSS/dWKnf4Qw==
X-Gm-Gg: ATEYQzxEyiupIpGtA6dXRgrXQVfLAbS50/fm3iIA0WxUQGVmkyl9zvKbFPPsJAci1Ij
	+Ycs2w7hCZZEKSiY4FH5xQDgweIcXSh5OinIyBxqHqeDbOerFdKrzwIvn03fJAHC6MHc3ZLRs+Y
	YNErrLVdRw7cTBsH8Ii9yrpgD6eGin7vU3JPve2WSOVnRHrhBi0v0RhQEg7Z+mecgs3Ptv0UiHd
	arr88XkSfH+dFGT30eEQL6SDmkkSyiQcvS310kSdB1CkkVtGURNqqVQLl+bQ1RCzujitQdOfY/H
	usELWtwN7BD4orFzVJUDWR5BwR4dYrAaLEXEw/9Upi87I+k4QhucG9hfWNgPBedng7cI2fec3iA
	lpv4jPEfQpTQ+X0DTEpRdd0pizkHAaeOftvCKqXPKU5wOYVZjCFH336I7JrTVjZv494ErT+270l
	bYkMzHbrQvL/2MWuBJOISnAcvWsY50K5fNBKOO9n8=
X-Received: by 2002:a17:903:98f:b0:2b0:9a61:9e9 with SMTP id d9443c01a7336-2b0cdcb7d56mr153261205ad.32.1774903160005;
        Mon, 30 Mar 2026 13:39:20 -0700 (PDT)
X-Received: by 2002:a17:903:98f:b0:2b0:9a61:9e9 with SMTP id d9443c01a7336-2b0cdcb7d56mr153260995ad.32.1774903159492;
        Mon, 30 Mar 2026 13:39:19 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c3a4esm113517195ad.78.2026.03.30.13.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:39:19 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:09:06 +0530
Subject: [PATCH ath-next v3 1/6] dt-bindings: net: wireless: add ath12k
 wifi device IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-ath12k-ipq5424-v3-1-1455b9cae29c@oss.qualcomm.com>
References: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
In-Reply-To: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Proofpoint-GUID: V_uxczZtb7YzGZnMhvnPmHS0ifwdVIfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3NCBTYWx0ZWRfX61NEOu2PPqHP
 jqQVbeptYgrZPwwkkBKlCSgiMmXR5nXw2lALLpEvzAw9d1OKXFqOLS0VzcXK1QteW6fX+oLdpsK
 cBczffk3tdnI3lIueGGe7D5DsFMynTc1uPXhIXWEaWhpcGMmGTVlv7rNJqcHJbuydv0UQloWV7z
 CN24uHz/6DhSuLxhDJ3D46fs3mBLNfO0cdDtCwH9xTalZJ+kiV9KGHAt1R6tjAkgeQocxXw6wkq
 3cUd5rUv09Pm1wxLjhs3oX0XJ7EwzOdJlbsTDeewZH7YwFB2EU800vaoZpkV8a2m6KSnjLfxn/B
 yR0YvbsIUGb2e2ht1i11S3o9S6VmcPIDGo2MiiKybfGmtjGT0Gq7fm+jYnt5mCUexcW2vBVebcV
 xC4V3rQd9QDfq1CFDbWUsuK6hrPBRWpA2lmgjZNaY9HutsRXyTFtjzZ18Duy4mfJHCaSgVMH/4/
 BSyihh7t8sZ9fCS0gDA==
X-Proofpoint-ORIG-GUID: V_uxczZtb7YzGZnMhvnPmHS0ifwdVIfR
X-Authority-Analysis: v=2.4 cv=S9rUAYsP c=1 sm=1 tr=0 ts=69cadf78 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=D60P_gS81Jvdon0wwAAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300174
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34194-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1E2BF3610DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the device-tree bindings for the ATH12K AHB wifi device IPQ5424.

Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
index 363a0ecb6ad9..b30f639b4c91 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-# Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/net/wireless/qcom,ipq5332-wifi.yaml#
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,ipq5332-wifi
+      - qcom,ipq5424-wifi
 
   reg:
     maxItems: 1

-- 
2.34.1


