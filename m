Return-Path: <linux-wireless+bounces-29761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE41CBF49A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AFDE30041B2
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 17:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFA422157E;
	Mon, 15 Dec 2025 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nStNHAhD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fEdkBrm9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0877255E26
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765820824; cv=none; b=llErv5njcqdlaY5dOGn44aTGXsLXOyNok7l2Q3QOquQv1Sq7F+pl3SbTj+Cf9B3bOIVXWKEoNbxssqXklbMVHYndaOP4WG6cb2cL5xpEsRuETWLBA7urt0sUpFoj1mYcp7s4syRMVZ0dMKeMpQov2VPZRY3i0/6e2+pbWrQvqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765820824; c=relaxed/simple;
	bh=U8ek7klNCaCOlBVTXJonZPzdx97vG1o9NHroXlcTHmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KFlMEi8rf78lwuq3G1O2kbJcsW4ggI2Ntorh/C3I8Q696jB/ilgSuOa1V4vb10CbQI8pORr1J6Ovq6Xwc0xIsd0KUS+dSaLRWZ4WbxkwGl7McmnfZ5kFFe6jjNv64arIBIWlqtKj4j0TLdneyUN5DgrCfk56E/jL74PE1qYMf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nStNHAhD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fEdkBrm9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFGPDCB1399778
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 17:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=m7jVS6G0DL0bUNDufA3kyCL0KUgzub180wq
	vH6O1rRg=; b=nStNHAhDeAbR37rpAstJ7XF1OFE9sB5xEjaDU+Htjd/Y3yZNbVG
	NklEMwxd8NjZtKUrSj5NWYC8CVxYILMIBpIpkrI/zV+HeSQWVEaezrGe2xuuv2VT
	zcFLvqJ4cMVyFu7C5Ddfi6e6MzFpYJSXC8NKfEV3a4IuI3U4Quq5blO9jgAIo72O
	kLmIviA4pz5YGrtfUY58+L8gt5dcZiyL6WYnX8qP/jotJDSvmbh9P6B2K0pt/HbG
	RovCwRU3MB9IX1UpHy60Uz0cjE23HbSj1VmDNt0yjenNSoBU/SVjaGCjAPFU4khq
	TcEA3dCu9VGFg3XwZqgqs2y2hXXwSSmQ35g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2nu1g7t3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 17:47:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f8e6a5de4so30936875ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 09:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765820820; x=1766425620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m7jVS6G0DL0bUNDufA3kyCL0KUgzub180wqvH6O1rRg=;
        b=fEdkBrm9enCyIw0hOkR9nGp5a2pxV+fqk3FmeuTiDjN+qAM256aYqz6bVH4DvEJT/b
         UM2N5r/E9+3EaOm5c2xzvpY+pjAwbtAo0kIaRBepB3HgXBJA0IkeF+5i1H6k+xXuvTrK
         QWf4gDDjtxqHbpIA80mxiUENhJd1znDhsRssVk+cU77tgb3BJBNLVd8F/Thyxxgpav1q
         /q8sha1nJ7xkwitoBr/fxX2kf4w/9YGdZC6xReOfLiWJAmD1gKsQHt3OysisH4TMyLvP
         yX/HEIiPuSP6MUTq3ANJdwSFm5v9IcrU+iz6oEcjc6RL0wfXbl8FpTtrqfkU6J6CiEdK
         SLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765820820; x=1766425620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7jVS6G0DL0bUNDufA3kyCL0KUgzub180wqvH6O1rRg=;
        b=spiJvmjiw5V92BOQwWZxZF2+dr4PE4clUxmpdS6U2wd5w8V0N+1FTdM0UEYFhnyAxD
         Z4PHoxvGcvEN/UM5Attlrh0LIiqBQrkaIx9iOVlXYqbuYLLLSruWjWmi9hU0yqnh7L7e
         7Fl8XwJmAf45xpHO2mbQDv3Up8wIQR2AMi2srrDw0UMZ1APsRblljbVspjm6ANdLTb5J
         9Eo6xSfUii5Uw6C4HKu9k/Jx8oboaInP+szDlVnIE8G/k5xI/RVDQl1iuAajHc6SONZ1
         vuhzDWfaYVVOPmvc9Kewz177JuVHaeE2C3y++lpA/yuJIlkCwmfuEiXtyffyKTQTsQqR
         JJsA==
X-Forwarded-Encrypted: i=1; AJvYcCVwjM4iGMhk8IDEopZel4291l3Hi8oCbsmYJ6HgZqG5kuCPldIgeHLlD1W2SYMmofzLQED2bvTFHYvhsg7XSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZas9KIOIE55x4ssz0P1Bok4rKllDuZJHP3/jI/WHLDtPdT/+
	l3UF0WLvPwZztm2jPfaB2qnFEjxqmxg58J6yk+fp6Z2KUC+uPbZUfpGN+Vgnh8wJMMLwMY4Wi7+
	dh+FatroH/Z30GQQN1/naH/1HMD7GTIYik8i3kIIdtwg03honlmxkucKTZvGSTwwxs6bjL4cFhR
	O+Tw==
X-Gm-Gg: AY/fxX4niZm1mlYgiZLmQrpE/UNS8ZP6Ttll3Wd9nUCwFsHKJuHeqJuAEnB7+nfVpBC
	cLAUJ/dHemyxBH3j/Hd300+dLxXbzdY4/6YjdmebFkOx6xz6AMKFb1xs2s3KAOr9gHladUsDQRk
	2aD2Gnm1wM/m2KREPts4C4jH47GugclLEXbEH8b10Al6/cRTZxbJU/k7G/mF7LoY4SPCA4hnpHi
	AAD3V22PN5MCfXDYC7z6UXOTdtrFFZD9ekiqlr1SGk/dhP53ExmgJARCaa3h+Yo2T9ocScFsqim
	lAqY/2MZRdf9SD66502lc68z5owLcAAF29x4mCMVaXKcw8AZPoF1WjsxnAw/JKfUgMGBq52gAyG
	C6Wg3LZOYM/KfUSlImmjRu7deM1rMY1Kir7mFPG7OoepQJG4+M31Ww4vroUGxHWoi
X-Received: by 2002:a17:903:2ca:b0:2a0:d596:a88d with SMTP id d9443c01a7336-2a0d596ab66mr55424475ad.26.1765820820314;
        Mon, 15 Dec 2025 09:47:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGis1O+qQCJSDnX7iv9xJeRaHrBFDw0NCC365TwTTCnbu4IKVbaB9t/rUBMoOSslzRWW8Zrjw==
X-Received: by 2002:a17:903:2ca:b0:2a0:d596:a88d with SMTP id d9443c01a7336-2a0d596ab66mr55424025ad.26.1765820819570;
        Mon, 15 Dec 2025 09:46:59 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a094398eedsm78650325ad.37.2025.12.15.09.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 09:46:59 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH wireless 0/1] wifi: mac80211: do not use old MBSSID
Date: Mon, 15 Dec 2025 09:46:55 -0800
Message-Id: <20251215174656.2866319-1-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ifp7bK-h3qhbdhEbkeiOmEcRtGSy1vcf
X-Proofpoint-GUID: Ifp7bK-h3qhbdhEbkeiOmEcRtGSy1vcf
X-Authority-Analysis: v=2.4 cv=AOuEbwt4 c=1 sm=1 tr=0 ts=69404995 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Pfd7lTaxnOKxeV6gd_YA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDE1NCBTYWx0ZWRfXxqB0Ty2LwenV
 KfgqnTu2O13QN0gCmAyWzKhHqMNuKySrlumXVTlXR2pM/ILjfM6HXtLeT70thQLfrVs3nrHutZs
 3hjU+w+3dx4qC80d47nnYlRgX/Yt9SPHNypGX0aXQmqmiib72GFffF7L+IbkWpelErMP2iZ97Y/
 gXE7JfuHivc3Olg/amfYkWeYC7uRh7Y77xFok5OEFPFw0VXa667FGsjBWmp7I0CzFeXJkImFTmu
 njOgcCu7nUTRzAf6V50Tm9zKiR5ObndynxmlYNLOhTDQMKj8zMI+95shFmFkGtNpAIzisu46vFF
 LeTf5ARkC3rEo9OjPxnSX/CVtnkT2oZsb45rkxammGSpX0J4A5+mmLJtYlXwfsL+bAcfIu3XHRP
 WWgAgO4ZV/sP/NYN2AY1u0Vy3yv94Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512150154

This patch skips including MBSSID elements from old Beacon
template if the userspace has not provided this information
with the command currently getting processed. The reasoning
is given in the patch description - incorrect Beacons after
deleting nonTx profiles.

Hostapd always includes these elements, if available, for both
NL80211_CMD_START_AP and NL80211_CMD_SET_BEACON. Hence no
impact on applications using hostapd, as is, for this feature.

But the patch assumes that all other applications have similar
handling, if not then there will be impact.

The issue of incorrect Beacon frames still needs to be solved.
So the other option would be to add empty attribute similar to
NL80211_ATTR_FILS_DISCOVERY to indicate that kernel should
not include old elements.

Thoughts?


Aloka Dixit (1):
  wifi: mac80211: do not use old MBSSID elements

 net/mac80211/cfg.c | 10 ----------
 1 file changed, 10 deletions(-)


base-commit: 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88
-- 
2.34.1


