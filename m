Return-Path: <linux-wireless+bounces-30410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A385ACF90BD
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 16:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC53C3024267
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970DC345743;
	Tue,  6 Jan 2026 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bmg67UpW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BHLGTfo5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE6F314A8E
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713139; cv=none; b=qKuJrX9VEoQ8sieSEhSJ8Tgge1Z7S9CLejGocK3kue937Dn5pH3hqAaHKYuZT5QWM81tbRzu77VLtKgb8UKhsBijVK96IiW4+jJXXVqVIdTu3WEPbmTbaEhcV9c2ZakSkTRTiEwLG2Iz613EBjFBkGlr38FAeb4IIV+N2Qzj4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713139; c=relaxed/simple;
	bh=M4+LKpLTFqeO4oAEnLiLXl155xTaKtgIbPFhF55NWkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZauapKW97Y0FgFRmL+7e12NSpMlDM/zj32V7dzgtORY1xl50vascx1A2f3gllHQFK6GNL7509QIB46+GmabAwy97mPj/gV2txjPIcXF2+FfOqEd3Hx4+VcJQGDWTlfroFrtwFl9u5qlnHm+24kqYTAlrJCuQdld8hHbY02Y468U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bmg67UpW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BHLGTfo5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606CAEcn4048524
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 15:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=92J5xs8yKnM
	pUAnA1tkoch/nQP5MYa/YHtsxIS9ArJQ=; b=bmg67UpWmb+r5BvFqMCyxt6m775
	oU/0DTNSlRKm3+OmCaYHE0qmAcZ9lzpdEQPXxalWVpBYhfvfvam5LFbTydJlNkMO
	mJOsXjrO1qwUvClC4FKbvnudIoqt1Y1OxarJuLdE6oF+UOmloCq5WZu5nN/C0Jlz
	JqPCnReowfiIp6KTyQxJMMmJ4Po8jIGnUTlL7N+pueOD+uCyL0gJ8RXUpcFJIKzJ
	zv8ibikZj9CCcFSmWm30stFrCMAktCYYU4SFoBgCnMVOhDMHpezQCFcQmExN4YxT
	5lOIqAakkKWvzlXmYuNvjQkH7ScYJyhulo8HF2PuXkQeJjagq9fxfKDDeIA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh25rrj4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 15:25:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f29ae883bso13907915ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767713137; x=1768317937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92J5xs8yKnMpUAnA1tkoch/nQP5MYa/YHtsxIS9ArJQ=;
        b=BHLGTfo5Q8IiUlx6+ZJWyBFTmr4PM3QPhRfUVMcgivKYsIyvUCDZYBNsccoOjuUW5M
         c026aVLFP3flycY6N16N8iQ/fXQ9MJf4DxQPKh9i53yL8ybz7iRfvrRggCkMu1v/ns2T
         3+zy5Xba1FzD96z6T4MOkdIpDzwrtAzP9dD8fBcJyq/+6I3/mWjM/vMFwmuL8ukG9Bmg
         hTeJpThESATnhhl9mGEUx0TAiJdIJR0UKQeGEooENfX8W5w9ucmKcOFgORzhBMzx60o6
         EYDig9viha/ekh0WYAGvs6whrRt656gF0//Yn0aqYcdplHv/nkAI7SxAtBrRatyQqIUS
         Qxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713137; x=1768317937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=92J5xs8yKnMpUAnA1tkoch/nQP5MYa/YHtsxIS9ArJQ=;
        b=sYs+OA98r/tu3fNZQZ8WwiClI+guBjfG5DHjopP+YB+z+KVfeSpqwpX1NHiQ1oHJ5H
         ANN7ZGfjczZnqYoe4OC7M+1ZGUyRJ6heF8kcJ1Phee/fqmQ8frnl0r+CjMYHl56E487n
         ulB/Z736TKq9MAE0veddnLw3ok0WIb487I1Gelo5Jhg1c55pxvnh8yOuxqHy3XdL+3t8
         /rBe4u0GECNM9b7ITcDLh4D5ddl12CLs49yG/GUNbDgoRyoyzgoYw3T5hnZbEdBfHcUZ
         G2KkRZ7zIC1MjkGJsPcdRotsdKGsKNMvs6cl7vFn2PFuvR1/5ZzQ5RWx9XO8W/r6aw0S
         XwsQ==
X-Gm-Message-State: AOJu0YyCmbHZR91uQ9M0y5/CyfdIUxeHJIzjMv6eszxz+SttXnJgPuRE
	5AP3lA6x0UNTM3CkBZ8cbeazA0w3rwnEbWPIN0dPvUhbX5xgeBDiQP0C1DhTzfH3HpXAl7xvR89
	KdggL4Jo+aXtwmXHLbyM8aRgN10AM9trfUNhYKfRxTsE36C1N2gEvJKbVFGnDibpNxXRpjw==
X-Gm-Gg: AY/fxX7sFlbK980gWsroHfTz5o+w4xHRFd8qFgxrelaBHjwkB5Di/wSfSoxFEMlK6P9
	BDDJ4RXD8XoZeXSu139c17XDxbtuqWeyu50O3kb4y7nOfF19+p7IhgrXYj1j2dGhz47M23aP8bT
	irGaSYfNu1L5UIPPFQ98ciSq0WtEB63QGDDzB1XcQik9nUw4l57rTGIp5YSwQfeGI5rlUReCaPr
	S6yXbO+aLsAIyNqtORv3M2pK/DrynOOOehG38awY4wnAIsD9Ko0FM0EeL/LqGcWyK65bNPMwc+b
	xYn9XhKOqw9M6aSbz/yparaDSqgVwQr17caehrSUCAYCU3rz0FwD4we/aL4e4LuRzoLHEKoZJSF
	rLabOwCzSZF+857BDzCVskXsBE54RQayCpCvypdjGOg==
X-Received: by 2002:a17:903:37c3:b0:2a0:e80e:b118 with SMTP id d9443c01a7336-2a3e2c8f951mr32247045ad.7.1767713136775;
        Tue, 06 Jan 2026 07:25:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqRflGDrvTO1mCeCM+NmwMrZrc3/y8wshGKcCtfvYkGUKRHIgAEXadgp34j9glFc9OHkssSw==
X-Received: by 2002:a17:903:37c3:b0:2a0:e80e:b118 with SMTP id d9443c01a7336-2a3e2c8f951mr32246765ad.7.1767713136259;
        Tue, 06 Jan 2026 07:25:36 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2ea0sm26343595ad.62.2026.01.06.07.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:25:36 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 9/9] wifi: mac80211_hwsim: Declare support for EPPKE authentication protocol
Date: Tue,  6 Jan 2026 20:55:03 +0530
Message-Id: <20260106152503.223216-10-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qxZmFY5kFnGNexEMyBWDRclqwxgyguhD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzNCBTYWx0ZWRfX7Mwgizj0CbaP
 dRiM4r7AOx9QRfqwW8xWtKScRV6uly86bGxjN6WQx/4foTgItmO5G8fPuQtsrsoHGg+58tnSvea
 0pm4kryKWlbogeFivB0z5kMlqofAxnJhhcw/E8AX8Jj2F6UBeRHnGhdClBhWMkbGdNtZgjWlUho
 p+yjMzMIoMV+g2Nk0c7jaNMgLRJOVe3O3R1nd7GEcK6j5ayT01nsiLJak/KUbepjs2cuf4uh36V
 5TtxZBeXhnXQ2aovfL4TsmLVc9zsWvB7s3hQYIcEBBuRl15K8f/b/BimU7iqEUAJoE2VqSFuRyK
 Sp6Cry+ymljbgzocSJrZ1jEq1pfII0xIUR/IgD28S42sNxlAWzfLc6yFBnSK+cIu4xmrE6sE5aT
 hwkkF1Hmd/n/p+ct6i5FGvK/e0WVwN1a76DzwrbG0fRhVJbhM+TI+o2PXgd6lg6meIkHTFSTQpT
 96sY9K+ndu0dykmEGoQ==
X-Proofpoint-ORIG-GUID: qxZmFY5kFnGNexEMyBWDRclqwxgyguhD
X-Authority-Analysis: v=2.4 cv=G48R0tk5 c=1 sm=1 tr=0 ts=695d2971 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=a1T-8RYyaUdGYqk8DgAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060134

Advertise support for Enhanced Privacy Protection Key Exchange (EPPKE)
authentication protocol for testing scenarios.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 551f5eb4e747..5c36eb959514 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5640,6 +5640,10 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_BSS_COLOR);
 
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_EPPKE);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION);
+
 	hw->wiphy->interface_modes = param->iftypes;
 
 	/* ask mac80211 to reserve space for magic */
-- 
2.34.1


