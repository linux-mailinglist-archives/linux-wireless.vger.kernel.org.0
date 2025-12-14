Return-Path: <linux-wireless+bounces-29729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD2ECBB62C
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 03:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5BC7301141C
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 02:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76832E62AC;
	Sun, 14 Dec 2025 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdizD84Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eP360zFc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE51E8826
	for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765680803; cv=none; b=ehbXTIM9+pLoADt2hyQyUuZ1SQfeNpNlrKeczBjFVFBlZrUgg8jdJgIjxBxPhOovj1hjlUMPjVrFsBBNqAOwn3wSO1Xn3p/MZ6CYB7jKBvsH6XwUlxKOrOn3fhCt0nY/7YNqBwIPB5axiyYptjD7M2b4J2U7W9JO/sjtglMUURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765680803; c=relaxed/simple;
	bh=qqD9m19Ci1t53e4d8zwce9Bd+IeTsxjth7cVzm2/ZwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jJhb/u0QqmFNQNQe1+1CRz6WGc9BAV8R0XZTnMWW3Fu5v5ePL9syTQERNytOUpvjBFG6HOgdX8fjCpAF9c6tFvmVgF8DQGIajIwW3IqyhQ16FbOCVaUZN5DbD91gJkYdkRaEees1LR3xbhHwdq0zdCedQvjz5vKxHaFO2Wjyk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdizD84Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eP360zFc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BE2cixv1176899
	for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 02:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=aH8VFuNHZzzxxgVJ76CVEsKdT0fPzmeMSK5
	/kOVfaco=; b=cdizD84ZXFf3mFCJUxnmt9E8b5HrgpyYJcqkmBavTaMnQduwp3q
	Dejmzv7QsWY43tgDz/8uiExP9hG7JC3Xwa0uFyS6vwsSCwNjMYP4I/BnaC4jS95F
	qchbEdlvblQpLYMAtsVhWYuoFG9r33vJL3aN2yI1HC1U+QJySz9WmAPRHmmpTnVS
	b62k0ucpPV4CsbGy1OTV+Whg77REi0rog+chEu6F6M1yHSMXO5N4xmDqBtKd7dTq
	DZezlw2wp93OnIapAGqbVhjtlTOf9DBQrt+EmyrS16lKJDdjbj/MaFeuT5ezcA6V
	IAXYyYiXTO/IAjyfvLbY7YHPyDS4DXLUWYQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b11avhbdx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 02:53:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297f587dc2eso50028565ad.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 Dec 2025 18:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765680798; x=1766285598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aH8VFuNHZzzxxgVJ76CVEsKdT0fPzmeMSK5/kOVfaco=;
        b=eP360zFcQqQwu5VHok6tSqQgsJZls7wtQaHwTqtq2+JANavoj8Y0gUl04CFgyWufdB
         90AVusGqI5mKJaXvc644X3tNoDgdYYE+GcqPGEPXCQNshJfKEiyNLNnYdBDBSUOFhWIZ
         /hXXVoCiqwglWVbR8WjH30CfuiGvh4MKnvTxXjHrrXnSbtG1yQkYcfMyBlyNWNJc5DU+
         qaaibr4nk41Ikl6VbnMVr7AS7XXGhUAOm/YORjdLKmf4rYOmys+K6k3KEcMb2l9txZZO
         lTzqRNXzduG+ZBoa5aJRe2RSQ++M7DvkcbF8kXHRAym4EfXtJhLFRmMuRUFDOWNfN38O
         sD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765680798; x=1766285598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH8VFuNHZzzxxgVJ76CVEsKdT0fPzmeMSK5/kOVfaco=;
        b=o7oFJoH2p+OeodEi03MUX6aM9bBMYKYZIPiQkz8NzR/CBlmqAbIRuS9x2DxyL/Qk3I
         yEW0nu431iNnj/LgfJw9UmsAkrU+4lGr3rJytM9SOYqO/heycDnooRPrUGHYjg6/opWW
         9pGNzAfEESlMzUz2XczLfkcd7ODuKa0m+ur4Xv8RqwjZ7KDzInpFwLyKOZmFyzRBWGm/
         2Dr0BJLFZFergia6JDyQuSC8fxUBru4hogm4hZh1NnHfhSsxsVzqdWmhlddXhoqm44hA
         h0AaUc9pdZJxoAk3pe+PqT59Bm4uOF09bViZudksxFiGpdFvgY8Iq/aBRfm5Hzm3QaIu
         7nlg==
X-Forwarded-Encrypted: i=1; AJvYcCWjVYeS/ZZYRUv2OPqXvDotpYPZ+vxuisH+g82KO9yzTPG3TPCyl/jdpavZjBeXqKQ4J74AshAAOkL/C2DKGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YySRxNKtIcqFc/fuV2s39Oj/UWsEpontZe5qicPlxnrreuNewg7
	A9Xx3Hlv8A3FGIDY/Pwpocd+Oc14fbZf4AeuKM0CaK8g4Swc5XoAz6SYPXWIr8b42U3URY09cAx
	OlWveflXREVGFkNlJ611xSu35Y93dgLejLwaymEa2ncoPtQrAszY4RzO7z0qXyaNxmUVtiGzpBs
	Uhm/jB
X-Gm-Gg: AY/fxX7XQMDO8OgNAbtZVO7Qfjm40TLAmhAzmYlXQ69CsMlscotD4Z8v33Oi8gsFJRd
	GLrXJXwkUekhLc5JJvnywDQLBMXvaBPKBdA/IeuleN/p6AXAvUtbKCGd7a+5/VqqcaTyNczlJiC
	GKKLMdz+L9p6/4fqf/Y9MG4LzDjftjxmE3EzDx8VjaO9BIyzgZPH8as+Ey6yX56k95TUaczw488
	Qn+iKTdnBBa601z9zIc6BjasejaUBa8MmPtPyZRfJZN2XmCk3t8vVZ+z2jOiRIh7COb3m9OK58+
	yPAfESzfH0d809wkmRLoSvZARseYQ9QeUfmqWEA6C+DfNgDg0acVmJBO4koq6E2cBvmP3HFYYyx
	/ZXIlWKEXox3xZLE72cT7aOOOaMN8bx6GEMrjPebTxw56QLaUah//Xy1NnJIKM0TL1V/8
X-Received: by 2002:a17:903:41c2:b0:2a0:9923:6954 with SMTP id d9443c01a7336-2a099236ad5mr32744525ad.27.1765680798505;
        Sat, 13 Dec 2025 18:53:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuk7ieLO0eMdTzrYSJ4YJIVDoooCUAXe6905vxnet9/eygsLEDZVvbYuTQMTm6OPuQCO86gg==
X-Received: by 2002:a17:903:41c2:b0:2a0:9923:6954 with SMTP id d9443c01a7336-2a099236ad5mr32744315ad.27.1765680798056;
        Sat, 13 Dec 2025 18:53:18 -0800 (PST)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea01723bsm94148115ad.62.2025.12.13.18.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 18:53:17 -0800 (PST)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzk@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH v2 ath-current 0/2]] wifi: ath11k: add usecase firmware handling based on device compatible
Date: Sun, 14 Dec 2025 10:52:28 +0800
Message-Id: <20251214025230.716387-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE0MDAyNSBTYWx0ZWRfX77sFZNoVMHhh
 9Lq39JGK9S/Q8iwIBLX4a+fAyG2muNdOO6s4gA1FyGHWL/nxbRWhpXChPgmdL5iY/IkK4lO7paf
 t5wqeCISbW4L69hJS7z0jPdS9KDmMUZS4G8ghdsKLZS6sNT0MpFB0Rm/IRdzEpGcs2icxOqLC0x
 bSYI1GH+iXrdxY+7R71kszNSmSuH/4HRan4KxM0McQyLBkEpgED85X2gtHFNfVBRTLlxZ80/zWW
 ES2y9CdY74iCRtwGPCandrQa9JcYhJgo1uSYW2AIAHr/0jJzhKraNKHKZG+59MtHevbfJttDazM
 blNznCB8gdY+M2hJ7PZXWT+PWcO91C+au1uTPp1Q6WFc9+NaHH2yYuaJ037k7G4NA+5db/dKOir
 xr/WP2hkjdXt/0WDaXUeAufdld7iCQ==
X-Proofpoint-GUID: 1D_s96FRvz8hVWPmfpKera-jjVJXra7X
X-Authority-Analysis: v=2.4 cv=PJQCOPqC c=1 sm=1 tr=0 ts=693e269f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ibBZ5ciJxtvWWn4BFuIA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 1D_s96FRvz8hVWPmfpKera-jjVJXra7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512140025

The 'firmware-name' property was introduced to allow end-users and
integrators to select use-case-specific firmware for the WCN6855.
But for M.2 WLAN chips, there is no suitable DTS node to specify
the 'firmware-name' property. In addition, assigning firmware for
the M.2 PCIe interface causes chips that do not use use-case-specific
firmware to fail. Therefore, abandoning the approach of specifying
firmware in DTS. As an alternative, propose a static lookup table
mapping device compatible to firmware names.

The driver has removed all support for firmware-name, and no upstream
Device Tree files reference this property. Therefore, this patch
removes the property from the binding and marks it as obsolete.

This is a DT ABI-breaking change, but safe since there are no in-tree
users.

---
v2:
- Drops `firmware-name` from completely.
- Updates the commit message to clearly state that the property is
  obsolete and the change is ABI-breaking but safe for upstream.
---

Miaoqing Pan (2):
  wifi: ath11k: add usecase firmware handling based on device compatible
  dt-bindings: net: wireless: ath11k-pci: remove obsolete firmware-name
    property

 .../net/wireless/qcom,ath11k-pci.yaml         |  6 ---
 drivers/net/wireless/ath/ath11k/core.c        | 37 ++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/core.h        |  7 ++--
 3 files changed, 39 insertions(+), 11 deletions(-)


base-commit: c99ebb6132595b4b288a413981197eb076547c5a
-- 
2.34.1


