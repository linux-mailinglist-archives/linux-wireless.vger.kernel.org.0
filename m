Return-Path: <linux-wireless+bounces-23502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F01B2AC8738
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 06:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EDCD7A70B2
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 04:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E102AF14;
	Fri, 30 May 2025 04:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NYkwmPaJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F61E3DDB
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 04:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748578195; cv=none; b=iL/qoKc8laTp4KoHPL1VP+jR7a0uCSYw1ppSdgKDfidWv9wIumqHwB/YBYujFATWfRIHYRJIGYhu3oDSiXxwLLwAe6FkbJZLzO9MGp3jiNrNPOny7OIa+xrmb9DGjRXRHxxU2pHoKME1k3T/M1DMLVzVwhtfokdJZeXhErcHCtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748578195; c=relaxed/simple;
	bh=CLd5dQ0A0Lm5lUzYrmBHYzLlvs+Psyas2t1OvCzbRCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t6JQbK69sSp7JbsXTtfsR0QsknP/x24g5ThMqEjLuAxqFgqQO/9SIM12kGV3QexVK+RwkxAXeLZhgUD8PNz9AIZnzvDswfqD4u6vovCUVRhQo6lQZQ7zLyr7MzQULkj6OzbjjMI2TqVwyYqPeBgZ3+hTthuL4/0VfnohfRFbiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NYkwmPaJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U1H3hm024410
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 04:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kzmLxlo17WdCDlkPI3D/G/+jUiBvsIx4Sau
	cDIBs8+g=; b=NYkwmPaJNEIbacbrMpZbC8VQu2XeFBjh9FC3vvAITCxRigAhroV
	LQRzCF6MMdxbANaT1H87TTat0a6hDldWoNIS1ChrYual4wnvQJBq7Vo8CyWDkZh5
	sZ7a3WDcYwqtUMPYhWGPfjDdB9NdPKq0Plc0ucO55aur4cSZV5cQW6dPUs8Dlaz6
	r2ktE5ILAm8TaQSATXXxFnT/6kiSD3dAzH7NyDQOixR93K91IVGZGJS9jbh3UCVp
	u7v52oNPYnDa+QexfBUBPHesMy6IuGiHR9H9TcDWvvQHAww1IxwbGuXXl3HFanlT
	6RaN+KRyK4FMn7VJdn56F90n5CsGdHdKECg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x03mx1gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 04:09:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b26e120e300so1471708a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 21:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748578191; x=1749182991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzmLxlo17WdCDlkPI3D/G/+jUiBvsIx4SaucDIBs8+g=;
        b=MbEgnvegxCn/Vl/Zuj/I/ZBfqTmdDnU0E3ufAnXOe5La5NzhMGZE3gSTqkG/MfjLun
         WK/R811PS/y4sdSNPKt6UMm3xtOrPm1CbIXEoWfhRSD1bhV8Z2Sz2OclYBZn+XP7G2Sb
         AdIXWTp2FEvCDMkRdC3QuI1L8tnQJgTYg4A5RtBsWE1XbBIR5iyvB6+jZi101gno+jUb
         tX253DIHTeUOgJwDMNDVp0MfG85Mf1HXd95AJR8vg+MQRq0X6wb/L98LUENPjNtqbAWS
         bLXcy35xT2nr13CpzMhHPFCBBfPyfV7GAtf7HJmYKOZxMDN3JGGRCl9Mh+E0i2SZOPNs
         xrzg==
X-Gm-Message-State: AOJu0Yx5MdlockQIR2utr1Te+gHYGSqYdiDvSlfcNhBFXK5G6UwE48/e
	+qhFUcNwoEGJm9XyHwklHx7FaquxIrFvVj2bog4S8sIaVIV2EdQ+ECU6IlSSk6gg6JTAbDcKjP7
	YUci+RxVxmncYV5K+EWOPy80sMTZVWWvo8tfmxmX1Bu4FMvyMcvEmP2wSGOnO6SBM61Vg9is92D
	sYAw==
X-Gm-Gg: ASbGncu3D0Hk/wcyEx9PwE1696SZTTYKGmjdc84ozAkFlIvis5q0ylYvA3UaMOblQML
	JdEVamTI/tb1+qQP+BXQAxOysZHDtF5iQ1Wr2PAhmLl1jYItNrDn9BJ+ZzGqdDZB4MJgc7hYVoK
	3OlPwlFU6Ici4hxHDOl40zkFTqnpGzZUi6/yYQSuuKtKjYPzQLadeisWHy5HIGTf2Rq+mf980mr
	wYEa09LZflL2s7YvnrfeGyPzFKmfOZbv4u/w6ftQycXIPIIDloEYF6zvjBscr9MJdb+39Y/508d
	lG26HtBulBlBHtho9A2c/TOcZw1aY4R15wRCQpmn/3sKx9qrPHgr3C58EAXoXncnhIHMwi4yo1z
	cePAtul8Hl82s06pM3xoRQtpGut6HobY6QxoiGaQg
X-Received: by 2002:a05:6a20:3944:b0:203:bb65:995a with SMTP id adf61e73a8af0-21ad9799507mr3568592637.30.1748578190946;
        Thu, 29 May 2025 21:09:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOuKqbuABO5IL9edcelwHEaKaHbmQVZGXg1YDuZDVgWZYdooUfotYUUMZs3Yy7SJsvk4TzAA==
X-Received: by 2002:a05:6a20:3944:b0:203:bb65:995a with SMTP id adf61e73a8af0-21ad9799507mr3568569637.30.1748578190566;
        Thu, 29 May 2025 21:09:50 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeaeedbsm2177502b3a.69.2025.05.29.21.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 21:09:50 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: mac80211: Fix bssid_indicator for MBSSID in AP mode
Date: Fri, 30 May 2025 09:39:40 +0530
Message-Id: <20250530040940.3188537-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4dPM3NeebdgflEwc984vllLdEXKeMuZW
X-Authority-Analysis: v=2.4 cv=FuAF/3rq c=1 sm=1 tr=0 ts=68392f90 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=Z8sUZ-xROK5Aofzi708A:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 4dPM3NeebdgflEwc984vllLdEXKeMuZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDAzMiBTYWx0ZWRfXzcKOjnmX5Aub
 JuTlW87c/IXVHiAkJc0a+vlqipSyZiW2h/UqeA83wgukz/RGtW1Gd+HTBf3QpUseT21QhCCkopS
 1O9IF9HfgKvs0ZCXEkMsAvboP3qDxK3NgR4yiSavF9iuitxAs75sbR3NGwSCtph7hWmUc+0cWHO
 F9dQEp8GfO3/HpQeYIOtHhKWXA7EQguzyfUPfEqp+CvN/eesx8x88DFwwPVoU03le4Uh/YH/Oeg
 PmRKQW9Is/Sbk+hZ6s2gEIxIzwoKaqZ1GLxN1c0VyXetwAYYvc148mArUb1Uv06eCvbETsRRm+a
 S7lq+oSz0hXB3/JS2Xf08eE17vkQQWiC7a+ZMz+IFTChQ5EWYJJ5hx53CpZfprDXII7ezMmsDlZ
 5jFTFwdbJUaFlh+MFjnGRs7aLDuLzcE3BAHrebkzdQSU8lS+edBTqYvA6gnA/LBykWKRlwS4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_01,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300032

Currently, in ieee80211_assign_beacon() mbssid count is updated as link's
bssid_indicator. mbssid count is the total number of MBSSID elements in
the beacon instead of Max BSSID indicator of the Multiple BSS set.
This will result in drivers obtaining an invalid bssid_indicator for BSSes
in a Multiple BSS set.
Fix this by updating link's bssid_indicator from MBSSID element for
Transmitting BSS and update the same for all of its Non-Transmitting BSSes.

Fixes: dde78aa52015 ("mac80211: update bssid_indicator in ieee80211_assign_beacon")
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2cd8731d8275..83f62772f762 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -178,6 +178,7 @@ static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
 
 		link_conf->nontransmitted = true;
 		link_conf->bssid_index = params->index;
+		link_conf->bssid_indicator = tx_bss_conf->bssid_indicator;
 	}
 	if (params->ema)
 		link_conf->ema_ap = true;
@@ -1218,8 +1219,11 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 			ieee80211_copy_rnr_beacon(pos, new->rnr_ies, rnr);
 		}
 		/* update bssid_indicator */
-		link_conf->bssid_indicator =
-			ilog2(__roundup_pow_of_two(mbssid->cnt + 1));
+		if (new->mbssid_ies->cnt && new->mbssid_ies->elem[0].len > 2)
+			link_conf->bssid_indicator =
+					*(new->mbssid_ies->elem[0].data + 2);
+		else
+			link_conf->bssid_indicator = 0;
 	}
 
 	if (csa) {

base-commit: 63a9a727d373fa5b8ce509eef50dbc45e0f745b9
-- 
2.34.1


