Return-Path: <linux-wireless+bounces-30345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CF3CF2387
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 08:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 188C830245EB
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 07:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF38E23AB90;
	Mon,  5 Jan 2026 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+QO4NWL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SctGBL16"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF02D839D
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597919; cv=none; b=jd7cdewOW+RhNjJNk1J6zCrfekO1MscHVSFuITJqOoTROx7bCc/uvwBvG1dh0NXCvOZBJDASa4z0LPNlBPaFkJMXrflHAFGURTuEUZ/oMsAOzfblEKXcybRBXD4hmHa5Svek7xkHDQKEWV7RK7NPztfXBFIC1vt7NAXrCnDvjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597919; c=relaxed/simple;
	bh=svNzjMNjb8Mqaf3eVANV15nBqPBed3pMqotiUZ2VDBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JsiO4YoBzvbt4XxUW5nD3LjS5o5vpuE1IEPAJKUeVmVIPYsHe02sbeL5eqWiELRCy2T9+KMr70G+cAgv9MFKcygCdrX1BdMVgJBuWNKBcURNUzgqsdhIUxz7m/y/Ow+6R//5ESHjFntWh4jokTgX/G2R08oGk6Xk9SWM9qFxm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+QO4NWL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SctGBL16; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604JhfKl3667695
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 07:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=clR2v4v3SzD
	h7FiaefSEqRWAogVMdXmSoly/ZmH279g=; b=P+QO4NWL5VhmkxS0iYIgBIWTEAU
	Z3QeJWxb/2fK1xknEFZ2fEFhQAYlxzJOPQTfCPIgKQFBKe2y+x4qjDDBdIuPxi8s
	RJ1oSTJbI8MAS0gSVtc6llPTnK8yiz8ZqOAaFKXKyN+o18uFMF/fVfbhrMx6LNM/
	qD/r6iELCFtbcyqToswvFKTaCoEIQrtJADgSs/00/zzhbSaQhsjSVKgkrgOYflbx
	dY/NEsDv9M1zBDSCwyCBRzYuwGsvfCred/7x3d5D5AySeM78Ud26Vblwmuj8FScd
	gJDLKdC7NSBM5hyJXPzLob/bmiYRMBA8TngPIjKDWqfggv5U92KgEmTkmNw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bet463np5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 07:25:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0f4822f77so374323755ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 23:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767597912; x=1768202712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clR2v4v3SzDh7FiaefSEqRWAogVMdXmSoly/ZmH279g=;
        b=SctGBL16lg3E1nK6u9hAKSXKB+KF5yoxV2VA02WLJrkxSeYlHWK1C+vO3KtlPj6K+w
         TjKPNURwK20QNsi2B50M/TXZ+RgOFTCTOvAj/TMhBaXvLK2iLKRjaaR7tisXiIn3r1b8
         TQy33hjWuOSeo+pjWcg4ZD6kDGoVugcXxJQddzNaw+GQKlHCXHykUZlbm5QM3ojUWfJ2
         O99eNYfpmDeKzo1egof2vBbIUlY28AyBXu8AWAr0RWNpPTR6phzPoz/i3uL0YtTEQTWg
         W/CsWMTRrmcA3Mi9JK1K/RnIb+NZu2aBzvEnkPVTYMUVSHBMZ9kvXjo83VspCJd2bcnm
         HnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597912; x=1768202712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=clR2v4v3SzDh7FiaefSEqRWAogVMdXmSoly/ZmH279g=;
        b=V5znADCj52LE5Qt7zIOFWDukTFRluOJlvo4mks3fbc6oyC8RTCA47APN/a7FHNuW4G
         55uPojS95acZTyDVPfHxPGG/53iCHsrQu3idIKuMfx4s/B26xnb4ghvYAd7D2tJThLsx
         Deo2XmLG7OY6mX7MudC+hXssDkiXJ4qchaIwBANDG0iihNSMVsfWrjy6+nxajytCQpCf
         BFLCeH9n5hGJbzdH7NsL6gf1mTp+bacsg3gJR2c1c+prDivFDiwH1h+YyInHw6T3vXA5
         rOUqcrMwU0eXfdYj/mnaXCn4A7HnW8sx5GX2sT/2bxK/bPT2+3iOVrilNYSHfch0TArb
         hIrg==
X-Gm-Message-State: AOJu0YyahbhMMpwYfez9/SImkfaO7rEe4lFFw5Lb8f3nfNKn0wdg3Vy3
	XOxnN5KHV1cbgKvcIZtOXjHswR2HFY7irEjkndR1qtKe/ENvpvfbqH22BF5/oqeRv+kKT4b3HUL
	pvCr2VTaAfd9XGRusdGdvjxNZUH2BmyIihlcqSIXHyIAkxx1GrjWBeVCo3yr8d8rbwF2h0g==
X-Gm-Gg: AY/fxX6Q06z5ZjbER1gZPc095815UZ91YQtfmFbdN0zHtLd5ef2WqNFVijclMoLckT8
	omqi1aeDyXuoAOQWV1qFBpG1KwskgpLxxa4aPCQTz6zFvB4yMysaqdgasNCdC32BNdrIw2wQbM+
	/smONTftxV4o1+64FRcf9veiFgXAI4xh9IPAZ7dUT5mMpZfWYGPlUTltGs51F+CGDEM9lJiHj0v
	BHvH5RHaIZVNM9l1BwAbHfjOGd/WaXoiMPiA2ur8mIeluJDD1bmsu5oXecWA2bHzKUu4jCEfLZ6
	+nMWAt5smt88P9IIqA4eSP6B6SzjdCo5WDGlxLYMHcSP+wI83YGa6Q9Lql2dGFLbpewr+HPR52Q
	3M1gIrGey1yAynJYuZTKwpnrYW1ePRJePYSta1LvkaA==
X-Received: by 2002:a17:903:1105:b0:2a0:9ca7:7405 with SMTP id d9443c01a7336-2a2f2836959mr438105105ad.36.1767597912045;
        Sun, 04 Jan 2026 23:25:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuxV8ghvoyIC8KMBkviyevB8VZc5Azc/B/fd3Cx87I+F1ImYpnkEU24wWJOkVM0zzcJEJrzw==
X-Received: by 2002:a17:903:1105:b0:2a0:9ca7:7405 with SMTP id d9443c01a7336-2a2f2836959mr438104875ad.36.1767597911545;
        Sun, 04 Jan 2026 23:25:11 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm445201205ad.34.2026.01.04.23.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:25:11 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 3/9] wifi: cfg80211: add support for key configuration before association
Date: Mon,  5 Jan 2026 12:54:09 +0530
Message-Id: <20260105072415.3472165-4-kavita.kavita@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA2NSBTYWx0ZWRfX89p8fmzh3oHW
 KSUsMC3QHP1SvC2e2sPrkwszMonNbBa/7zmULlJA3FSA9N9eAYJCdgq8xUeFJlLk++FvVmEfzXs
 /O3B+8tR10Xq+6rkRDJSE1sC/GCnerltnQ2WPheOE7pe4BX1HZsQPsnuq9H0KNZUNeUHhaI4IEm
 /ntEelKuns+D5tFs6vMJnz/2f1RmrumK7eALvyTbmbnD/ItrKd8rIcWjydQTTs2odeEKBrNAe5/
 ygXxT7ISzr+OQ8FWhBaM93cUhLem6ZZhcGfSd3zH8hg2MRfQ0wR+nlNwnq37wHE0zk5BMTGS7Uh
 MguCCPCYSYiZVN385lyzYZ5+6KSuyiYFgSriiUhE5zepIvTAFmfisyQSp+32JDlrrPLyWuhzwfc
 kdNkottyxL0KOW8GE2gXh8A7x5E7gUdXRX+agGdYG/zojQkvBc4p8w2qG3VCD7CCuiHq1F33+fO
 Pv2gIy4bVxeTCxWGawQ==
X-Authority-Analysis: v=2.4 cv=UuVu9uwB c=1 sm=1 tr=0 ts=695b6759 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xf8xhSOHqnjMiTY4RNsA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: c0JwwfmtjwXEsZbnIAhJFPC_t9jqf2LW
X-Proofpoint-ORIG-GUID: c0JwwfmtjwXEsZbnIAhJFPC_t9jqf2LW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050065

Currently, cfg80211 does not allow key installation, removal, or
modification prior to association in non-AP STA mode. However,
Enhanced Privacy Protection Key Exchange (EPPKE) requires encryption
keys to be managed before association.

Add support to manage keys before association in non-AP STA mode when
the NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION feature flag is set.
If the flag is not set, reject the encryption keys.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/wireless/nl80211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2ac31a1d4ce0..c464c449cb0b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1675,7 +1675,9 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 		return -ENOLINK;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-		if (wdev->connected)
+		if (wdev->connected ||
+		    (wiphy_ext_feature_isset(wdev->wiphy,
+					     NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION)))
 			return 0;
 		return -ENOLINK;
 	case NL80211_IFTYPE_NAN:
-- 
2.34.1


