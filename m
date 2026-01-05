Return-Path: <linux-wireless+bounces-30351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CDECF2399
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 08:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B516301FF76
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9BF29E0F6;
	Mon,  5 Jan 2026 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cx+CKuVX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iBiJqYpw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99B2D593E
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597933; cv=none; b=K6QqcS+SMEz+8FaqH9WtdAEIO1oNYNXTpo01/5doVOhFNHa1r8ZigrJIzoYVKWTsvec8cafZlLJF+uY+GYQPx0OmG4LUbO9QtI2HZ5d+2kkSAHckSHImcMvuxe0gBUZ13qczA1CoTSANim9/xd+rPkTfx/zevt2QRr3FovUM+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597933; c=relaxed/simple;
	bh=M4+LKpLTFqeO4oAEnLiLXl155xTaKtgIbPFhF55NWkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbvdKuSyRxx2lIH3yggtm1eQkBRN5/riKT7hcOFXNJliwG6H1N78hQ836oN9OxAfLXyw07SePivXG5D+4Y6gNyMtLeHGDS9QDdpq8NycqKE1jebaz4hmxAoAG4KG54chRWrwn/0B2rBfVn61UlEpMIsLqZoZ4vtcaWeEYGKum4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cx+CKuVX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iBiJqYpw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604KLDH33356709
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 07:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=92J5xs8yKnM
	pUAnA1tkoch/nQP5MYa/YHtsxIS9ArJQ=; b=cx+CKuVXwoFpa9ttd8mPJ8kL76l
	9N4ywYIL5YILGyPxlBst/GfbVHBrIzSe//d1MBTvFAyiVvyo4M5JGXwIJKgonv74
	hD3KDXEq8LOJLkMexp9rfZfoa/2Pfc+1PWezd22FxcErKqLq277Y7G48zSAlSgoo
	FjVQqzQC+iIgMjtxjdfDOsjvu9pJRIbOf5bXwMs/sgyffN97a5c9NztsgAubU1ds
	T4xKAcfogG9ffDLnFeELRcsfuEfqHjoP7Nfiz6d3zGGSf8rlZ88vDEPN3qq9D18R
	cyTQtENFcmr4PySGDfZeW/q3rmR+DO3kl2///hrKgP/9JwTNTXv9Y5OEgUA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4beu6t3j2p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 07:25:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f25a008dbso119581615ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 23:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767597927; x=1768202727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92J5xs8yKnMpUAnA1tkoch/nQP5MYa/YHtsxIS9ArJQ=;
        b=iBiJqYpwAF76HEpg+HVREh2njZuyjN6l++1TSkr6kj6WCnDX81uONNC8EeN1wZABWS
         jyCZDRcMb0dFWdAiHfhCMV3JI8ARsTd4ETAyz21DqAUrwP1V8PxjPBwgZlaFXsFGaJ5r
         Qn7pGcrtfMq2HZXPE/1T5HCocb8CeRVMpxJ8ZHDu1LJey3yYuOCTW/r2RXJvQrTbPd5q
         AJVlICkX0mwtmnAQ1u4w+JrgPjPs3E14s7F0q1ELhoGPrQukueyJYNxOBSY1Am6cD7BA
         RldMBVP3wbTuluD1S+5pjvsNdWAYCE4YTqM9u9LQlDBR5DscKd3Ehc+wOGrwwaHYrcm2
         cUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597927; x=1768202727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=92J5xs8yKnMpUAnA1tkoch/nQP5MYa/YHtsxIS9ArJQ=;
        b=T8G3hy9gFkt+73VAMxnofwzQwx8epnZhA0ozxqL5LIZHN+kDB3HFrW1IRmgdHFe6/J
         9/5VORHbMyZqDz2tk4uWdNsg+wcE5Yjoo653g9JiPezN1RUG2c2XefPP7mas7t4lsK66
         GGmMnoFdXgZPoBrQYR9zAi6auvAMFiSPjHDF/0IW7XNV436NS9oevKVAzr3geXPd/riv
         xCHejIwqSK62Y/fK7syb0X36Azv0FQX7zSFdGeSqG/gyprg5NHNKJA3CHSoWyuzBDv3I
         l3I30vk/DPhUxzcLLlf0Zqw+cvgrJfokZ49l0CSjTt7U08ierIKLiqPCTPmzx0ctqcMW
         1rYQ==
X-Gm-Message-State: AOJu0YwzMa3eA2u7DyhsP5uXyPmKLoHf2fsXuJz0SHqlU5nzpIBZkF90
	V+yN1nAtFPrvaCqtzTkqcVHy7wPKakcVfUULgshZ9v43TIBoHulEdCGmNKpuPX4CBtUK/IPzIvF
	LUmt8zQIgb9sivTDOBGrvLZof3i2pd5cv2Q6/MDKsQJ9Rnakv7dpK+uSck8aZZwedyhr74w==
X-Gm-Gg: AY/fxX7FGMorZzTwoIVThaUx/ymBGI0bf0Sq8jsUVvmJjp13q/02UeA5qM0nu0HD+YT
	Qm0aA1goclZl/jnZEWe12GolrTeMheYwS1RQrb9MrGP61Fmu7LMsVLby4Cv6Ere42eliEgvulzb
	EzUuj2K4j9GRg2e1qg0//hwQO3X+QtKn5fMJ9cuS9/IsfDmcntgviWVRnQh6OGJb+LJEQqhpylO
	CblDV+OJSWbUGfFuuu0xbvpAeh05WLkNCIYl1D91EAYsf2hWuzpaSd+ScvBwW8mmAHW7agLiUIU
	VQZYgivVats/uxlVHtJWq73XhhKyRdNz86yZqb+xz+nKezrsWORgeDCs4yhsZ1xOd7JdJmIrhXW
	s4FJpZWz8bspUMh8b7H52xs5g+9QCBo9OP7Ie889f+A==
X-Received: by 2002:a17:903:1208:b0:297:d6c2:d06 with SMTP id d9443c01a7336-2a2f2228a47mr440236765ad.20.1767597927002;
        Sun, 04 Jan 2026 23:25:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZINL4t+QAyudh7QF5aQxIi9U2Y9s6DxXP7rSGcHsfh5JxWf0y05/bTDwaqrqjospQR2Nodg==
X-Received: by 2002:a17:903:1208:b0:297:d6c2:d06 with SMTP id d9443c01a7336-2a2f2228a47mr440236615ad.20.1767597926498;
        Sun, 04 Jan 2026 23:25:26 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm445201205ad.34.2026.01.04.23.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:25:26 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 9/9] wifi: mac80211_hwsim: Declare support for EPPKE authentication protocol
Date: Mon,  5 Jan 2026 12:54:15 +0530
Message-Id: <20260105072415.3472165-10-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
References: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA2NSBTYWx0ZWRfX98wptjw2s4Mn
 v2v3T3XfHN7+Fu4/s2CGAdlaaywsnn/mJc/TyCoIsh2MsGSFOQgnMHSu1zEwvUuMVyc/hwyYPri
 RFUglRGPQRTMtM1Ti0dC80LPvnVWSrVHCIkupzlOgeRpJOlbFUp0kC77gOkZ0BatmXNXpGtJG1f
 ucv8uNmbsXydzBJTxaAovTNrLrq3ouLwP48QbFMGaJww3Z3m16JvzRVLPG5HOa+aPR8D7ygApER
 rraaUIWpH+QkvJfsjixeUP6UYulv0ZUh9+xCceWnvBtwcEW+17uBpSZIpF3ZUHgPafSiMzZD6QH
 imvWe+Yp5losjdfmqJcv4bhlBWUNu0e73MX+GGpuI4dAa/lMQhm8wO8Q9xXBL1WHFpfuMfnEYly
 iG1kc0YqAOPhlUjY/4T55lNdQdEv8eTrs+SXp3yuHU73cjhuQa6pMvrhkMaIKeerLy8ZpnwS+vu
 JVWy1UHIQOORLZlZfDA==
X-Authority-Analysis: v=2.4 cv=HLbO14tv c=1 sm=1 tr=0 ts=695b6767 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=a1T-8RYyaUdGYqk8DgAA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: E8OUzY9H8lFIbHoMW9WnfrnQlzqsZtpz
X-Proofpoint-ORIG-GUID: E8OUzY9H8lFIbHoMW9WnfrnQlzqsZtpz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050065

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


