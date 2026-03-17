Return-Path: <linux-wireless+bounces-33356-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JjQMH+auWn5KwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33356-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 19:16:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B83A2B0C61
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 19:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A989531EC85C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D7537F8DC;
	Tue, 17 Mar 2026 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mk49nYIk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UvxyofV7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF33F661E
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770940; cv=none; b=dOMS4UUuWWLQvrn4thJlV7QqD/XYTlfUrcfZ1etZFLnbi+QF2giinCzalDJ5T9aESreer90W4oEnXYJ2sM+uNOyDyihEgPBJ9w89pl/z2c4Gw9efXBbz/FicTmELKsB6syFIQf6MTGUrH3pYEazowxhmA/A6MulcduHXjeIulRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770940; c=relaxed/simple;
	bh=ko7PLPlB9WIDqZ8HM7fY0FuhJa09ALvtcl7dCPd2/AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIQZowKOfCBS3KJM25Evf7NAC/cBvWa/6vhvsJkTp+4LrA8BQGOa8xM8fxw9da59K9BOXWWhKZssT/eP3n2p1SowI5P0V8KPNdkKim1qSB6I6VCW7QY95LQz3Da3Jh5izGvsdVwxN7whTCAmf0CYyK4+aMVsTKHKd8cEBRtdxjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mk49nYIk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UvxyofV7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HG9wlh2006504
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 18:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Rmu91ZOlkBlRgG8B13OKfLVMrQD3YYnQngV
	2MlJEfFw=; b=Mk49nYIk7ZnuEPJasHlRpYRKKc5eT9b2s3qF6ljsghjDlGxV5xT
	2fa+JkJHqngW2LNCCK6KzVy6FBEfHT+pLwsaplapo341KJhnOQovYfQ/XzF9g56G
	VP8Neil4Dm7Bj3jEtlBCqlBR/zA0gq3hUU7yhKRbliDpQiafC+rPwiW6T4zoLtVU
	S+zjjkPMatvswqavF/AxSsezD52hjIZ9vVn41ehHKZZ/cTtFpBSdhiCfw3l06S7b
	FksnC5Eom7HnjUDfplwTZ24qInn5/GJZblDPATvl8/yGoGX5kkbaF3cJhoXi03Bh
	+INIhFqhUeKKYw3XyCLXMcJKEHYhAVAdBog==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cya83rf7y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 18:08:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd827a356aso559371685a.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773770936; x=1774375736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rmu91ZOlkBlRgG8B13OKfLVMrQD3YYnQngV2MlJEfFw=;
        b=UvxyofV7vEp/kPJCkHAzFw+K4xorWhxmJcfs4z/OCy8mHmN2zaJSw5ooFvyCrFVXCA
         YliDL66E3AV/kyANh9VLpxXwu2RwHhF9ojx2EXih0hfOkMMgH2Khy6rOndPfSkiO7jzJ
         yx+Ea9kT8ex2e8xZ1NoQ3CZBX+/EQwMqxQh0kHHPpZzZ5AO6ominVRp8UTu0Bk4ZzM3D
         eJ+q9hTsjQvSHJ5L5BjJTd8cS2pboNr7xiID98VvBHoUvik773IZ9WQ2wAzjQ4r1rd24
         ck6cHauu2STn6xbCA6UPmCm9vg2mex2xhUHxRWc1KEuDvUeLuwJTwjGRqifhnOT2/HGj
         sVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773770936; x=1774375736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rmu91ZOlkBlRgG8B13OKfLVMrQD3YYnQngV2MlJEfFw=;
        b=sI+AxXOEsifyH0fpKEj2hiBvpLbKU3nLjaw0IDiw85+VTbNcc2qeIGn/y5eqoG+CqZ
         bv9Kvd8W2iPJ5eWIOQlTiM3d2+XoX13foBuBfYweE1396puk9yZe/Ep5W0lJGAy0qQxX
         WHYMW62N/9j7HpYCD9/qyXO9DjU6vRclF1M0E7NHE7LNntPN5yTe12P3biR9SnAfs7xI
         kOu5wnM1bUMdq2qane/p9nO5/MNqR36D1oTRQN2jFLaQXfQEuzGlCBiRiDWkxEp+Chpw
         y/3p0aWy6rTF4xxn8nKSK+gq0RVxLQcojo1NW9whbgQnWtra9PUWs0T2WV6QUcCDmWWV
         e3bQ==
X-Gm-Message-State: AOJu0Yx6HHCOYxDG79/iZg5mIsIADd/sK8M6euloy4PbkzSfnqcJjlMo
	qZGGWwz7vUORLvrSyzyoX608Q1iOHySx9hqQturt6/Tn0FJAyrcRhK8efXv3PeFdH3xfIXtPvdA
	GI3EXLqA4qbOs3WIZjaqyGKcx9nn4jI2/r331LuflTUzqmRL44rT1LzG0swJxCXyU1cq6Qh+EI7
	aELw==
X-Gm-Gg: ATEYQzy2HKkedQZuCctesZUzwXvdWDMfp3/UL7jIq8a1RcoYD+ovz1g3Ny4O5nIPtKl
	M7PCRoyijxYosO4e8G+y/uxh9C4W2t6sFSm87ffAXrLrJlXo69ytWLr9RNIyWvw/Wrzwey1DowG
	W5oNXOdj6kkVjTCCiwpPbtxU698kH3PwALq98Gv50lNH0tWJWP5a6txH6sa4hzIVszwjEd6DcZ/
	qsCTqED68rRLOGOXghQUx5efvVCn9gFSelR2bLDpnLZuRunIqQKBMgBtGm5EhdKDmKAO3ggioJO
	A+aeuIJHbGsxqaGNdoUIyBEImsGMJhIrKA7EaiqfwktHgU0RSg5IJoicCSH+1jnLgkpBeuaq7IE
	O+57bZu4dc+NWaMMWWmKmLYdF7sPdBkVsYWxWijOHIZYXrjUjlA==
X-Received: by 2002:a05:620a:1706:b0:8cb:3288:6777 with SMTP id af79cd13be357-8cfad1e452cmr74868385a.28.1773770936009;
        Tue, 17 Mar 2026 11:08:56 -0700 (PDT)
X-Received: by 2002:a05:620a:1706:b0:8cb:3288:6777 with SMTP id af79cd13be357-8cfad1e452cmr74864285a.28.1773770935576;
        Tue, 17 Mar 2026 11:08:55 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:67fb:53f6:20ba:ff45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4614c4dsm1501765e9.16.2026.03.17.11.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 11:08:54 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER),
        ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER),
        linux-kernel@vger.kernel.org (open list),
        ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER)
Subject: [PATCH] wifi: ath: Fix the license marking
Date: Tue, 17 Mar 2026 19:08:32 +0100
Message-ID: <20260317180833.3061582-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: u2Emd4e31OKTGl-TJ6K4XNSe_qrx3kNq
X-Proofpoint-GUID: u2Emd4e31OKTGl-TJ6K4XNSe_qrx3kNq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE1OSBTYWx0ZWRfX1DRUU+HiDhcp
 eaZWPhSwewvGHD/PdzmYDQOJBadDs647bUlmMsjP1Ar6wxK01yZRGfyhpHLS09LbRBHvNVQdUw3
 +YjZMti6phRTQT4oPeKcRlG47gx8WJJNKR0SpT8BC8LvEoZkm1K5AiutzehMMpJ2bXtorHQy2Rt
 jIspMxwHRS7DY0H9syXETZjjSRCwpFavdLhi49WMnjmnwcMTjSAx0C8S4fnA1MY/whC9K94WJ2p
 0JbEw0n3z6U9xx2upM9Ibs+YST0HQVRM/VsYYVOeRIqJEXJF0bJx90HxUI+tFo7m9RcTrG1AbhH
 eEMOOZZlR4twf7frTBgL5LT2R0RstdBnnwAYPkd8yfRGWtBanIh1FZFXPbwgqOuICyQ2G4l1XoJ
 haFB0OPuO64UZll+/sZI++Rv6TzhaQVIXkI3VIQ73SQE5t3gOJssZ+oetrb4PD5oGkaAPFBXZWW
 qOzn4pJVhPzPOeMGR1A==
X-Authority-Analysis: v=2.4 cv=Y8n1cxeN c=1 sm=1 tr=0 ts=69b998b9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=GxoTDrp_cBUVqGJeqSQA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170159
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33356-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1B83A2B0C61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Copyright for Qualcomm changed its format and replaces the old
Qualcomm Innovative Center by Qualcomm Technology Inc.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/qmi.c | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 4fdd0af415d5..acad75d49d98 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2018 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/completion.h>
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 1397756d6251..410a7ee076a0 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
-- 
2.43.0


