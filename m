Return-Path: <linux-wireless+bounces-35459-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJHvFjd98GlSUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35459-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:26:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 800DE4815D4
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5961530C940B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD423DEAC0;
	Tue, 28 Apr 2026 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pwHbdrg+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BMBgqNzE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF03D8916
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367382; cv=none; b=aBMtbA8b0z/YgVIhrIiGBe4r9P2w7tVFhT6ISrN/sxF5HT9PJyT1Nixxyobt0ElwAkVUTg6SJkCFzzsx2Z/NB0mgVYmr0KCskjS9sHnLrIYxzXSBYhAo+9BSh6JaCqsQid4OqHRvCX+I785K5fX9v2O98kiO7wA6QfcajpFgIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367382; c=relaxed/simple;
	bh=gfQW70BGaDeiOYc7g09LwaMgZyLe2NEVnRdgVOxOCh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XjKgpeBK0UEze/Rvnth4LGaDOFk8iNLz9wVGBB34HVGPYZKoPr4wVP9QYIdgJuReCqvpfxKeT7fk/zhlGsqLxpEXpa8MnPY2GxOtHN00BiKoH/5hDkPGKKNB/o9NOWtcmrjkFk5V44XQjI8u5Wp1Mm/qGRk3ANIC7fWIiJXIAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pwHbdrg+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BMBgqNzE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7vq6o1744983
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=rejcaKQbQVspiMP7zsAnb21Ngjza9DO2Llg
	iZ+FNct0=; b=pwHbdrg+tMwyh9A9T8NCLZtZuM0bKI36BFe57YIpEQ/y/VPE2e4
	GyC6Af51oCjsmtoZy2fkta7/u+pwDg4YRDkFUhvbSQ5QaCvdvl+qQlG6qeclJ13m
	bmZmoWbcYZnrYOZ1Fu1H6g/FCFgrVem++o9yWGDEV2SCigJMyY3TqfCDn6nuEEN6
	icb5rvX4Yu/CZCEhqIN8EZUeza+HE7aC527IaZicp1d2miJflkKHohDY54ynuDmZ
	IYgBHrwCI7sT4zF3TfcaOhUeZe6gy8Qljip496vJfRSIox/Gs8GYtE29ImtpfuKN
	kCJBkRy9h+7J6Fuo+yt7FQNnctJLHuvsqRw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtryd88xr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35daf3d3030so11844628a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777367379; x=1777972179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rejcaKQbQVspiMP7zsAnb21Ngjza9DO2LlgiZ+FNct0=;
        b=BMBgqNzEd4cVL7dN10yxreb9zudxduFusPGxufT8cwPB3i5bfwMctJe3asomyHW7uV
         F9HZdedsvTRyUbERsMN9tGM+OsmHpm+hcT3wRJN0rlnLk1oUg+cZHhVxtA2p6QgZwHqK
         sW1VH/L8jsmmDuxk/+HpKwg/DJSjk95HH7ckSHa8u8nPISkzFEgzPZ+qWeAl4UQIl8uj
         jm9yUrmIJlHDZMV7kkplXjpbMraN6Jrdi/8jNP61AULzyq30BH4jGHZtrHW8lq1ZYsO0
         gvFQTIR0pVyQHcXZiVeaGwuKj77d0Uy/7KLTkwWXdnd+wGAX9KL+t5TKPTdwNAy/DZ1Z
         k/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367379; x=1777972179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rejcaKQbQVspiMP7zsAnb21Ngjza9DO2LlgiZ+FNct0=;
        b=C2Uj6VDQ00snyqoZ0tIU+lUiaZyuF/ZeHlXYN/f/bGCXXHRoj4OInWy+yQX/jOpVlt
         MJDahN9PU0SLYR85155u6uTlL+Ra1ZpbIi5xV1L01H6OjPQIz90BetoNvUjTu5TyWpFW
         C1hMZ6sguXI8jP2zEo29WLKzjdKWV0OuzCifETgyQc3JN50V7y7NcPWV3meNDPO5bVrW
         mRTyRnXuaXBIfDn31k0N2HlRQafGU/uyuvZdw1TfO4eaVRFUN5XPKatTTh/CqesERoDa
         s3DJb/jcLlBk+iRg2BLDfYnL+HZo0MvyBJqcxtc56FAbzX2M06R76yRaKK1MRY4qz34+
         LgmA==
X-Gm-Message-State: AOJu0YzWQiFP9S1UyedoFQ86088bQey40AnZVyX8/yG200CpFgPd5cRj
	3Uqg/aXk//brgb8uBPN0c45u2GOn0pp2BtpIKAx9Gn2YYfPkHyU4IVTfmjhplqxBdBgJtb9JcmT
	z2zMzq+OGwUMSw/wyYgksSJYEwZaGRZcddyDkioRq9Vf0Q0mtRNLo7E4hYFwEpsmnfPOvUg==
X-Gm-Gg: AeBDieuJQZnNOeFFM9E8FgMZFkBPGYbcxWcU/7taiYWapHWIo8Cn8tPo5CigzwbV8m3
	zRKlQuLjQ9WmNptmSEKVa68S6UpyJgBOmpOIkR3/8uhQXczdSVpi/sBxJgn13vmkfl9IB2NPcK+
	mBF33phbZgtz7GWQw5LndQUxNf8sAlM26/FPpu6+c1BYl4bXuf8Q7wXvNDeO3BR1LfbVH+95XF3
	Pqqzobo092W/1OVN+soVU2s6HTikzxd71PeT8S5zH2KsaAXFeeBgCKQ7/D2VExtUljeQnsZ3YL1
	huUUT0dEeReXoFEkbbGgl+N7pbXg/SYWXxzVon4l/Vx7ZqkQ8W9nAVE9y/dKdstqNL9pzQK4YYP
	f2lPG247Ql2LG/zexD7LxRK/D/A6fYZS1ultXPOUJwWmbGqR7eIVNUdTLpJdOXjmo/y6IuFQROw
	ppKHfmnpc+dfR3iEDyVMcr0bd5FiorkHTTDnH+0pRQQCBliLr5NeMJmQ==
X-Received: by 2002:a17:90a:da87:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-36491fbc576mr2408571a91.9.1777367379463;
        Tue, 28 Apr 2026 02:09:39 -0700 (PDT)
X-Received: by 2002:a17:90a:da87:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-36491fbc576mr2408542a91.9.1777367378925;
        Tue, 28 Apr 2026 02:09:38 -0700 (PDT)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc33d5a53sm1898177a12.22.2026.04.28.02.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:09:38 -0700 (PDT)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH wireless-next 0/2] wifi: cfg80211/mac80211: optimize station info handling
Date: Tue, 28 Apr 2026 14:39:17 +0530
Message-Id: <20260428090919.1798601-1-sarika.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0e6l4Xzw-uCk5I7UBky2Uv_OTfHEJNW5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MSBTYWx0ZWRfX8/7/QRRM0bAn
 FRuMKixHpb1ynFjW+vHb9BKL3fnPdFWrbqxwew6n+Y/1Vqze01/urCdt1eXxX46XI9bIUvH+jcz
 sv/ztZBfv5WtGvOlke5DGj2sNFLBEU90RW5QcEXm45TDrf663aYqufVRQGucosTdeFVTqJX4mHK
 QdCF/hQi2f4uP+aPL3yb4GrZkqAeNBGqqx296Jbmn+U0ZM+Qv7fUxqecxWP7zDElgknYbdeV+7v
 N/fMTiXCkR5QCS2/0t3x9ECgHCNd0EXRSnJc9pfPlclvIs56ixzfKJpCD+ug9m95zvV7H2Ps+++
 AMyE7/Vk05WIfx8kzEYKCMvITL78gwwz5TWwr9cI+ySp291+KrflFlikR/2bTQePS1FLOA2dtoy
 UN/ftP9DsjpBgkcBOlX69XOFW9+Fp4uDhSluKNI3HIkc0v3C619Q/W9cv071MUnRkizOpz7ReOa
 HR1SfZ71WyC9cYwTXWQ==
X-Proofpoint-ORIG-GUID: 0e6l4Xzw-uCk5I7UBky2Uv_OTfHEJNW5
X-Authority-Analysis: v=2.4 cv=cMnQdFeN c=1 sm=1 tr=0 ts=69f07954 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=5koZO7XqIq10IgpX1VoA:9
 a=zZCYzV9kfG8A:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280081
X-Rspamd-Queue-Id: 800DE4815D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35459-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sarika.sharma@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

This series improve memory and logic efficiency in cfg80211 and
mac80211 during NL80211_CMD_GET_STATION. Allocate link_sinfo and
link tidstats objects only for valid links to reduce memory usage.
Avoid setting non-MLO applicable fields for MLO stations to
eliminate redundant operations and simplify the code path.

Sarika Sharma (2):
  wifi: cfg80211/mac80211: change memory allocation for link_sinfo
    structure
  wifi: cfg80211/mac80211: set only non-MLO-applicable fields for
    non-MLO stations

 include/net/cfg80211.h  | 29 ++++++++++++++++---
 net/mac80211/ethtool.c  |  4 +++
 net/mac80211/sta_info.c | 63 ++++++++++++++++++++++++-----------------
 net/wireless/nl80211.c  | 35 ++++-------------------
 net/wireless/util.c     | 21 ++++++++++++++
 5 files changed, 93 insertions(+), 59 deletions(-)


base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
-- 
2.34.1


