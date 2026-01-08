Return-Path: <linux-wireless+bounces-30516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D69D00ED6
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 04:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A00873020170
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 03:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4E2877ED;
	Thu,  8 Jan 2026 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mH+5SE5E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zg3r7GBQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644628642D
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 03:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843980; cv=none; b=PU/EB9cqjLpoTuC941FWC6fjPJmPO3vZK5kMbm19VOftmHzL9qxUMhat5y2wvmmTgTBE1q2Z2HaWV4BNa0NIsNE0PrNlsg8VBrO9IfmBZYoyrwiXHHMzP9Z5NPr2oUNW27eT1fWVz794l0f/lwVDkYne7VonQXQJmHLbX6jnCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843980; c=relaxed/simple;
	bh=NEkmkcSVdA2YbgQ0ZSxtt0+iCpMDNy/n20X3uQ9vBTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CFopwJN+IN+NA31F+EF7OyO3QrKRg7i8ZW0rqE+kQgX3isywP8BhfgWixhnKveHwgWzICOli2v66sFQaMeE+xjULo7K0jeKD427eAzfEwcUJJyJQEndhnzJCnJT5MeMUHHCIM+WIvmkIDhZhkDG3K/lUqkEAW3abts23ifTMLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mH+5SE5E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zg3r7GBQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607H7efo3672962
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 03:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=X8KmdR+T61aSIYfW+HbPKLU9ZV6zlFQqA8w
	LR8dZ4wc=; b=mH+5SE5EIy7G7DGE8jB0bleIMTvNj3Mh/Z/0OVs/5NpPQaDFW1P
	AVoEaxvP28mAFzm4oqMc7RFfaBmhwKr0dI4gfaHPPghfaK7K0kev3IyQPsuf95fu
	1dSbtgGJHCao656497KuzATGi+jzYCFgI7gAIp4EcPR8C8rj962rBOFUkYVX0KpD
	aRZuSb9LMM/TP8SwivYduoxhYt2wfEtHyJ8yNUE2bHukGEIQ8sjvzFOJNGagq6eX
	bFISXcb/RVbduXqpqnHr0RqYLDZKFdPDNTAyyVVT0PRlFEXt+vYPjBr2E3qpp47Q
	XglBxXha4urEmIB0X4V4dmOSuJUNlryiUVg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhum51n5u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 03:46:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c904a1168so3919552a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 19:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767843976; x=1768448776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8KmdR+T61aSIYfW+HbPKLU9ZV6zlFQqA8wLR8dZ4wc=;
        b=Zg3r7GBQP38Sq6vsvNfzSJnaUSseP6f0ucG/UA34NUqmZhgjRSbTHr1x0GA8za6d/5
         qTOcBkHMAGTLWfr0wCT3NbADYmFNXLysAq3KERDT77m3OMljyI50QXcUQd88jVZE6vWF
         ouWbw1/ul38KviKQWf7WrVK0Dx3/yf/wrIB5XU0CKKXFYKUPRR6RYLczOZ34Nh0r3FnO
         mfbqIx8WDwZTBuiiAdYIK+qZgvGISY8TrQRCe9E7pXMeOLDcHertoctR+FpbaBXfGIwR
         jycnVxmf4eAeckWJJwGQzmxKYgK00+aOLkHpLb53HGYY7yJECWd/wxzGTxXGftNOYmJ7
         fKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767843976; x=1768448776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8KmdR+T61aSIYfW+HbPKLU9ZV6zlFQqA8wLR8dZ4wc=;
        b=HTki7yurGfGDXS8Eg9yHU5JHgxVfq/xvzaFTG3FtXK5ewSs35svPrMBHCrZe0YcZ5s
         DY/RmsSidMJ2KepN8URgts3jAZqJIrVHocXT/Zp6Tv+YZlb5JlZWYBJ8Lp0+ZpOwY46I
         Z0UcV4kRVihqxasDHoFZW6VmHyX+FMBTiBcrrJQ3PNCtcUXffsX/NYpeP/Ty1E2e8L6F
         k2XO+vmTvs/WLErztLLFAenPUCDA32vlEhJgGC8ei7ZCPKmd7fqX1iI8IgqO508mfIxC
         mfXjOdFkV3NinRkab+vNEUnvvRNThCHJTQEkL3u8qLaSA4W8FXmQhGUOUEK8Fn9BrcfA
         RP4Q==
X-Gm-Message-State: AOJu0Yx9ZH/vULu2co9B24b3GX3LNyMALRI6EWIa7xT/7EBjsIGXDnpP
	hSxReJUN+oO0bi8/+jWRXsG3Dj3JSRP95AdIwF0gNjKMACv/TtrGoCjFzcmQTgNNHKF0cJPbEQ5
	dL+6F8/HnFlf/MM04ZnUvS022ldKwAWzrhpS9Q8Sb7Ymc0E6AvPtAYiSBvQ7SBekAZeH0rg==
X-Gm-Gg: AY/fxX6hfpqv4JZ1LzS4rekfxFkeGK7B2j4cHWiBfzBKYLYyLhdSOrsmyzDEpS0vZs7
	zX9KtD6GBoqJ2nCValsQoR6oezAdh0BgShkw0/kh/7YBcv9zMFvpDBY7oNHrCv7LopnFDn/Poi8
	uCyb9n+t4coZ3WsOP+8pTDeT5pC3iPYUMZwN4mPfhL46/Tt0JjM0MeBpMiODjlSer+otGi1UJZS
	RmwSvYCoM2+o8u4zHZwYw4DFr/d7uEiFnQnpnyDoUE1EfTEsJbu5Nt08coUCdKIy2Yus26fSHev
	/PPQ0VdEL7YKucsb61Xhw+U5Hbfcp9P+OV3P6srfRQJXvXM8VgrQTpLV08GuSubKeapBlKKlQHG
	YWTc+2pqQIEGDK8IDE/tqGm+MHppEhg==
X-Received: by 2002:a05:6a20:3d86:b0:366:1a31:a70a with SMTP id adf61e73a8af0-3898f888af4mr4372138637.10.1767843976302;
        Wed, 07 Jan 2026 19:46:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuKtz1HgzsDQSYlMSF0IneA8k2lMSH184tr4ZuJR8aqEaV+XhheuHZfMh0A3YbdXqSeXUCTA==
X-Received: by 2002:a05:6a20:3d86:b0:366:1a31:a70a with SMTP id adf61e73a8af0-3898f888af4mr4372118637.10.1767843975747;
        Wed, 07 Jan 2026 19:46:15 -0800 (PST)
Received: from zhangq-gv.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc05cd9d9sm6785013a12.16.2026.01.07.19.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:46:15 -0800 (PST)
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Qian Zhang <qian.zhang@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath11k: Fix failure to connect to a 6 GHz AP
Date: Thu,  8 Jan 2026 11:46:07 +0800
Message-Id: <20260108034607.812885-1-qian.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: y752yqrwC0qIJbUjgMgi-d4IfnRwInNt
X-Proofpoint-ORIG-GUID: y752yqrwC0qIJbUjgMgi-d4IfnRwInNt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDAyMyBTYWx0ZWRfX+cwJ3sMO8Rdg
 YxTxvaJwhrqf0micl0DI7Nnj+YHwGWxigVx2BH3HINUgHoJV/ZzTx46ozvcW3WerlzB+pIXjwbw
 9K4gAVWImOhnM0Opsl8LQn+/vLgIKhnz1U8i+v0DbPaseZ5PgpKk/ta4E2jKDVmrRulrOcYX0DO
 OYiEZoVsnAdhtRgzNt+/WtGWTok0EKnUjm6GqAhZApMHA0XZSgVAHm53MbqCHClE5n3OXhwWQaw
 hBR+omnT3oiYwwMN1tcjmOHaIrycENWpcGJSVFspYxSE7DWxz97wSr4h0ZQ/7i1uHkUvl9VuuGS
 v6uwAAWV9+fKL8tERkl3OMEK1ffV16rArScWdyeu6y5aFVUqQPIXAkEFrbqoot40347srmGVq4j
 WwF7YDFRDJcvkxC9nXRU/69tGSEmQZGnabFRcpt2P4f2AwipwFxF3iiwON2fukrzuaHNp1HCdzX
 4umhItGLo2Pdowwpa9w==
X-Authority-Analysis: v=2.4 cv=KNZXzVFo c=1 sm=1 tr=0 ts=695f2889 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=OMkZRiVep83eAS_9AiQA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_05,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080023

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
Changes in v2:
- only return in IEEE80211_REG_UNSET_AP cases
---
 drivers/net/wireless/ath/ath11k/reg.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index d62a2014315a..49b79648752c 100644
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
+		    (char *)reg_info->alpha2, 2) &&
+	    power_type == IEEE80211_REG_UNSET_AP) {
+		ath11k_reg_reset_info(reg_info);
+		return 0;
+	}
 
 	/* Intersect new rules with default regd if a new country setting was
 	 * requested, i.e a default regd was already set during initialization

base-commit: e33fc1c6d54ee1569a57255e11c2978ba9a42ffc
-- 
2.34.1


