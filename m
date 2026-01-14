Return-Path: <linux-wireless+bounces-30811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE8AD1E59C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 12:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 803A93011422
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 11:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD58936A027;
	Wed, 14 Jan 2026 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L8Djqdub";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e43RIkyS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ED32BE629
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389551; cv=none; b=kqInd7sUilCTRVXciwF6Fb1gN7QGzPXrbv9JOJ4Y8KNfLxYbc9rAo5htSZ+emVyX0kxdVrfU0Ztmkg+dy/fIW18VYuQyIIkpZuUBT/Rd7YBBcCiFiXCiIbJwhHP8+uLNwt033MLVWqEGi19f+ae9MaroEE0ZuVfPAjCfpJnAH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389551; c=relaxed/simple;
	bh=khJDswdu5TKfQF6iDU9hU5mU8lTwWnyy34AsZqhrYr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FylP0Pd9w92ZA9z2OpJPaoOYpC1uJdn6cedWhu68UFY+rs58bmnT7nyZPayz9YPlfYl8+217myrvv4Y8LTj5RBmjJBibpfkVqjz+tQlb3c3CU2T20yYuO2x12Fz1XeExZtzdy4PbtqufoqhnJAFcvdzRZcbSAk0qvSx49uRheIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L8Djqdub; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e43RIkyS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E7jYGI2082100
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=K+2QKZe9PTa7PRE4i6XKiftcnmyqvKk6FVg
	cPCnpTjI=; b=L8Djqdubd6OGk4Od/k4r09yvrGuiXrjyDLj7CvO0xzBkQBVznfp
	rN/yPokHZG2140pO6C/urapjpH6KXZ7E4ELmn1aooYC4UTflrCkP/w59p7wD4sNK
	cSuCnsFrI7orC8yKuGp4qUNdo5ssftpEeNDcf7gcq/zbE15kUiJOTZF55jRqOTXu
	ErUMimWqozLrGGzcyuhZF7Um8rn2BVFsgnkb0l4eBhtWmCLL9wbLIIrGoj7IyWlY
	19EG4TRv8NE88gBNaobIPidZKRQmF50U/4FBgVLhAqscC+Zq4Zsuzw2oeqMF6/pG
	EcJS6NOoSdndS6AlzJZZ9STXvLgycIDsCOg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnu58u4gk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c52d37d346dso3400837a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 03:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768389549; x=1768994349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+2QKZe9PTa7PRE4i6XKiftcnmyqvKk6FVgcPCnpTjI=;
        b=e43RIkySrm1UunEfajITPzjVCIUqwLqX8EiYJjSjOpMZCLqKNqr332L17NmPAFN3ZE
         nxK26mu8Hs1+sBvoWq+roSO3X5ykOEtguw6IAVeO+UDGIwXqo8sK33Xx1ck/b4DSzBAS
         WFb/lFJ3dk5EJVE+/7zDAsm9VbypwuVuL6NbM75IfFV/XEeWBxTiEsVqM4xe/AKCIlIU
         hbJxuW53jKDwMzOU4dgYbErb7FhN7q9DEiGmr81CjUgEGbGRwCAGqiVHp8VnXmdw1DUR
         /sP4369hN77RAnYMJPsWMP7lTKOVV5ahSFoyqHOzKv4ZVR4hvbtDCu1sOIJzMxDBumXy
         SClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389549; x=1768994349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+2QKZe9PTa7PRE4i6XKiftcnmyqvKk6FVgcPCnpTjI=;
        b=vhbIMVjQNrLSwj0ehTeku1m8LFAkRJp4f7aIhGcODvLZ4PNzE2zvHPQdT5qjPX2Pjw
         JNtL6GQVFpH+1WUfjyPpsXhW3yoB5iZpGifKsg7D92FpgjS3gziUZo3yq43Z375MVnXY
         ZOrIaMLxL825k3FWqKv9R03e4iKAYV119kTBUCuLGSzWyPRDCnsULe5sM0I3JKD/cNdV
         Jb8GpwpzXE4H9AUGIiOzwJoNJ4N3rRO5ndbl3V4A0AqCgqQQQt6re64tMahTxKoYXiso
         n0j3hPh8UkBQ3VZYNwrK0XM87pxJELqNatKmtXFxzVqCJQ8cyNlwGZMR95EBKjcFpNMZ
         kaUw==
X-Gm-Message-State: AOJu0Yy1ZDxLsBAG7UDfOhLR3P3aUOOt2yDwwbL8OpijmyQ/aviODGxP
	xCGCVcaUJ+jfFX4AeZANuBKbsLulEiY75mX+9yVezbPAQN+VCslaI3Zg9drfgQFPKtXYt9m6rki
	oO4UHVu1MLg57vcNtOJZB0ffTOCcZli4pMwhPfxsGLl7iYJRv9rUdyqk4vFNundzo2NTVRq4CRH
	3rSQ==
X-Gm-Gg: AY/fxX6fYgeC7wIHbm+6sAYk0Vg/TCeSZONvpHdGszsdwv/YoGuByEWTkQjcddjA6zB
	jPeTPk7rBg50gnPTMWyjxerXYxmYdYtd16SwZLKc6txzpZLTwz6vMK8wamcGmTpEp/7GwemLpmi
	vu4vF8xLyCs2QWlGn8/ANl+LI9POzfejItmktE0IVER29OdnDvs1nhlHwVIxjqxHi+kQjLUYhvq
	toFZgJCkbSZ9MOSsjsHbYmHhy8pIfR99w8mmDEhP/dxNgDEQHq1kTJsjOpzjY17BAYY36LY8Wj9
	5EE2u8KMH/TZelDjSNFMNOu8cXftt8bYgN0jqq09jbTqt18DPbmWkZyy5jLSYYc1ATKT0vBaOip
	eaQfehIKK0jJ1WJQJvS1y5KFZffPf4WPSpsiEjNBy/w==
X-Received: by 2002:a05:6a20:6a27:b0:366:58cc:b74b with SMTP id adf61e73a8af0-38bed0fd838mr2654004637.21.1768389548745;
        Wed, 14 Jan 2026 03:19:08 -0800 (PST)
X-Received: by 2002:a05:6a20:6a27:b0:366:58cc:b74b with SMTP id adf61e73a8af0-38bed0fd838mr2653965637.21.1768389548202;
        Wed, 14 Jan 2026 03:19:08 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm22402512a12.32.2026.01.14.03.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:19:07 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v4 0/9] wifi: cfg80211/mac80211: Add Support for EPPKE Authentication
Date: Wed, 14 Jan 2026 16:48:51 +0530
Message-Id: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfX7zT/uXB43AY3
 wp+2vnjyWhY2pxP+0Ep8s2BYsaviXhRFmGbaJzlnMgnomObfkhsnbo308hKR5awy05NKZ7B2WLM
 TEqh7EaycYDeBoWvF+lY9KdztLJ78/nI7J5oQiwvTT/OZVT7Q3ies7lN09SPpvY2/qo2jysn/rk
 HvfWHiae33FwZznVP6QNDmX/h1q1X5mU1PjhjeeEYlm6Ev7cfOev6GRVEwmK7VCWSPqm8dWOJAA
 lwkfznUheySHLG4Hc6Et9zIDUViLTqNfLsXMWBk4+wJGJtel9GGTwboFYrIh+8pheGnnkhU832Y
 DMczfgoDl2zhqrMv2Nmwp/DHRYpa7NWRk0vt1S54jme6zwp64SdNYINA2ZmR5xt/BQrnAGAzAGP
 T/BgZJmM1QfdwPwEGAdBVdwKNLHdp+6bFx8cps668d+rkDC35t17HFhsK7gt+zIo3n/OhK0gdjP
 n8bNx1MhhDpXsRgV+qQ==
X-Authority-Analysis: v=2.4 cv=BZnVE7t2 c=1 sm=1 tr=0 ts=69677bad cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8xgW8lJkV5295r88nJMA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: Q42hdD1wQXBX1mnxkGu63Mdt-hrMnPC3
X-Proofpoint-GUID: Q42hdD1wQXBX1mnxkGu63Mdt-hrMnPC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140093

This patch series introduces support for the Enhanced Privacy
Protection Key Exchange (EPPKE) authentication protocol, as defined in
"IEEE P802.11bi/D3.0, 12.16.9". The implementation covers both AP and
non-AP STA modes, with clear separation in the commit descriptions.

The changes have been validated end-to-end using the hwsim tool.

During development and testing of EPPKE feature, we encountered an
issue in mac80211 related to incorrect AAD/Nonce computation for
management frames when MLO address translation is involved.
Depends-on: [PATCH wireless-next] wifi: mac80211: Fix AAD/Nonce
computation for management frames with MLO

Without the patch, EPPKE functionality will fail for MLO connection.

---
Changes in v2:
        - Resolved reviewer feedback
        - Removed few patches, no longer required
---
Changes in v3:
        - Resolved reviewer feedback.
---
Changes in v4:
        - Incorporated review feeback on
          [PATCH wireless-next v3 4/9] wifi: nl80211: Add new NL
          attributes to support (Re)Association frame encryption
        - Cleanup all references to "epp_flags" since it
          is currently not being used.
--- 

Ainy Kumari (2):
  wifi: cfg80211: add support for EPPKE Authentication Protocol
  wifi: cfg80211: add feature flag for (re)association frame encryption

Kavita Kavita (6):
  wifi: cfg80211: add support for key configuration before association
  wifi: mac80211: allow key installation before association
  wifi: mac80211: Check for MLE before appending in Authentication frame
  wifi: mac80211: add support for EPPKE authentication protocol in
    non-AP STA mode
  wifi: mac80211: add support for encryption/decryption of
    (Re)Association frames
  wifi: mac80211_hwsim: Declare support for EPPKE authentication
    protocol

Sai Pratyusha Magam (1):
  wifi: nl80211: Add support for EPP peer indication

 drivers/net/wireless/virtual/mac80211_hwsim.c |  4 ++
 include/linux/ieee80211.h                     |  1 +
 include/net/cfg80211.h                        |  2 +
 include/net/mac80211.h                        |  2 +
 include/uapi/linux/nl80211.h                  | 18 +++++++
 net/mac80211/cfg.c                            | 15 +++++-
 net/mac80211/ieee80211_i.h                    | 10 +++-
 net/mac80211/mlme.c                           | 47 ++++++++++++++++---
 net/mac80211/rx.c                             |  8 ++++
 net/mac80211/tx.c                             |  4 +-
 net/mac80211/util.c                           | 12 +++--
 net/mac80211/wpa.c                            |  6 ++-
 net/wireless/nl80211.c                        | 23 +++++++--
 13 files changed, 133 insertions(+), 19 deletions(-)


base-commit: 24a57985670e9dac5547e5b7731bf8e7b03d5be8
-- 
2.34.1


