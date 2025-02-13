Return-Path: <linux-wireless+bounces-18946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0611AA3519F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 23:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE203ACECA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 22:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECD82753E6;
	Thu, 13 Feb 2025 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mFKHTeqg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD602753EB
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487045; cv=none; b=lIR/EpvSiPa6DIt3uyvb5OrM9B7vH0AWCz5gOLAeHQqKdA3F5bInw1Anr4601xJqnbiH2qfKP6nPHFVkEiat45YPYJVLl6dNsw/CtBhZGlgJDRkrsP4q/8uLmv3Txmib/2bUPdp6OVUBUZj5LMlhJL3bM17tuZApWTT43Znq9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487045; c=relaxed/simple;
	bh=qVh0BZtZjqyzEN/iwEFMVwTc3cYk7eaD7R8vdOzqACc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QF3rW0dJyn2tyiMXiYlcVB83i65fPCD5Zjw5w8Terui57v0yQEa1KiJO90F63Q/Dlb/dMHy0gfovb6R5SV3PNB25W7OacE1BLgXa1K+RLbMhVlRkkKPmXPcmqjA99sCJctLylX/ucQvp8F6xlC/icsJSloTiDGBFUIiNRD8E5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mFKHTeqg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DH7qbL008066
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 22:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YiPCc7qo1slWwUbvldpsloDABzCQSVSIH8q
	lxnEks1A=; b=mFKHTeqgkVCSnSMOOOBCwLK08nP6Wg+Er9td8UVX7ll2ZQfj0ce
	JSL9i3D/gOqV5W2FtmCw9pJ9xkgAkP547HZt1XSazlMXJUo9/1vL8YnGUy5nKDyS
	eJJ0TcBkX5m+TIWcfFOqt6GEGP0NrdXMBgTWf6me7j7wrYPIHkxiaq3H1VUGGDga
	JPqoszyxqnR/aUObKlFX0VDz+p71u83yDpMvEeZwbq4MWEa8xnBfoMQEpIrUihLZ
	Gf2/fGxgUm0TSSPcIXpdL5S0bFLecOJHaHREUujFvjK4kDNMFBQ6k0zVUxbtV5uo
	QZbXombQ3p3ZpOHK1eU8VeUtv/+eB1C0d8g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rr1qwew4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 22:50:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f6890d42dso45791435ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 14:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487041; x=1740091841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiPCc7qo1slWwUbvldpsloDABzCQSVSIH8qlxnEks1A=;
        b=BiAAlkb6ALKgi0DynVjqtAe65Zn4FZt7cNnsoWKKXatFF4q5XxXgqvV+sKzmlVtj49
         BTDz7ZMG5qwKWW/r5KYHMGMYXcy5Akxs4Lv9pUumMuShIN8yQI5CzRxPpZz12BPoIuMo
         iYKbBuj5FkuvqLdh1EPgwCY7kLohveaSBTtrhFyq+WEBt0W1rQL0g6Sz/+hFb3RoakvB
         dcDGkdrokJ48pMeGsT8vbqfm9AMMFKe3x/2zkfYSxHfACRkm1pHbhoTWa8G5+z+f/bhO
         QczyqdxwTuSlxSV+F+NsSVxpsSMW5glEaXuiXy5NPmY4EV/5Yc/oaVhoNURb/y4GTBpN
         WdMA==
X-Forwarded-Encrypted: i=1; AJvYcCVPkrfagfXDr7SVA8YAVtR00dSPJ1Y1r879z9fnBCPpYLofQ/TAtRoJFJwBQ1Pot/2D0B7cfyLjJhFffsLW2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGrtttejd5d4k2MvNWc9XSNcyw8i/o2DDmCdEe9F0MpSiwiaM
	sd5pdblIE7C2Di6bRElErStr2r4K2ExzY63m0ogG6gT5JaygZdZjkON1Zk8tuafH3YkvDkg34i0
	l0Pgebroam3GHGegJyPbbVFTd3Hl3HKzM1rGgElgKNCvPItKhnhVQOU8LJNmuJ1ajyQ==
X-Gm-Gg: ASbGnctISGbq16t8Hg0sRYZid726denTt6HTeHUf+Cu80p0oCu/tee5AftGYPV9OnJZ
	UbtvLC73y1w6MgJvyPqrIVn8z0PjSiYpfdx/C9lBu5oTByWZf4cYjHRFA5h7z0K0vnm9UCkTr2a
	okTFfC9lXSWtPVvu+73UiPaM1s4rFC1PxBgjoDCewmVNMwThCnek4nUGzfV+MmKIOn2f96238Dq
	U6Nuf1ifZAlhsYrp8zDpcEVAn/LGUgBgYHIkdpQHwwJYPP2VcKOI2D7UBzcx6LClPpyidYC4+9A
	UtK+fR+r9O2u+cVeIRqEKjn71o+J3Jfrfn/3fqg6IYRaY1/UMCeRiYDwTJHU
X-Received: by 2002:a17:902:d4cb:b0:220:ecf7:4b5c with SMTP id d9443c01a7336-220ecf756b0mr10126585ad.14.1739487041510;
        Thu, 13 Feb 2025 14:50:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEv/kalfsIxEucHlCrhFEgr4i2VTH8S9l6syDYVfSvpZEcEpr/m+JPOwAIHTEeXXVI6ky8Skg==
X-Received: by 2002:a17:902:d4cb:b0:220:ecf7:4b5c with SMTP id d9443c01a7336-220ecf756b0mr10126165ad.14.1739487041081;
        Thu, 13 Feb 2025 14:50:41 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55916c7sm17571665ad.243.2025.02.13.14.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:50:40 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v3 0/3] wifi: MBSSID support in MLO
Date: Thu, 13 Feb 2025 14:50:33 -0800
Message-Id: <20250213225036.3118133-1-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: diRIGYS51MhdEdBAUHCZriwbeNJHpWrN
X-Proofpoint-ORIG-GUID: diRIGYS51MhdEdBAUHCZriwbeNJHpWrN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=485 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130160

During non-transmitted (nontx) profile configuration, interface
index of the transmitted (tx) profile is used to retrieve the
wireless device (wdev) associated with it. With MLO, this 'wdev'
may be part of an MLD with more than one link, hence only
interface index is not sufficient anymore to retrieve the correct
tx profile. Add a new attribute to configure link id of tx profile.

Similarly, storing 'vif' of tx profile inside 'vif' for nontx
profiles is not sufficient for MLO, instead store tx link data
inside each nontx link data structure.

Depends-on: 
https://patchwork.kernel.org/project/linux-wireless/list/?series=932457&state=%2A&archive=both
Above series cleans up ath12k driver code so that this current
series requires minimal changes in the driver after changing
mac80211 data structures. The same patches appear below in the
"prerequisite-patch-id" list.

This is a new version for
https://patchwork.kernel.org/project/linux-wireless/list/?series=902914&state=%2A&archive=both

Rameshkumar Sundaram (3):
  wifi: nl80211: add link id of transmitted profile for MLO MBSSID
  wifi: mac80211: restructure tx profile retrieval for MLO MBSSID
  wifi: ath12k: use link ID for CSA finish

 drivers/net/wireless/ath/ath11k/mac.c         | 20 +++--
 drivers/net/wireless/ath/ath12k/mac.c         | 33 ++++++---
 drivers/net/wireless/ath/ath12k/wmi.c         |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  2 +-
 include/net/cfg80211.h                        |  2 +
 include/net/mac80211.h                        |  7 +-
 include/uapi/linux/nl80211.h                  |  6 ++
 net/mac80211/cfg.c                            | 64 ++++++++++------
 net/mac80211/ieee80211_i.h                    |  2 +
 net/mac80211/iface.c                          | 73 +++++++++++++------
 net/wireless/nl80211.c                        | 14 ++++
 11 files changed, 159 insertions(+), 66 deletions(-)


base-commit: c61da149b9c2e439abe27845a71dae5ce5f5985c
prerequisite-patch-id: f0bc71c13dd8ade295b0b02a265a83fba85b8e95
prerequisite-patch-id: ec61eaf1e5f291f9baa173de729257a2dd4f9ac4
prerequisite-patch-id: e864d8cb444ecb525204ab91e0ccab55116dfa33
prerequisite-patch-id: 7397bc61b307254df3cdf6e64d4d6b4063df8b4d
prerequisite-patch-id: 996b954de755f1690325c2b59b5073d945733347
-- 
2.34.1


