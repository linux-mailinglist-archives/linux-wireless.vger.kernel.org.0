Return-Path: <linux-wireless+bounces-32455-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNUQJAj0p2mtmwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32455-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 09:57:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B11FD055
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 09:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8777630B3779
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 08:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700FD382F30;
	Wed,  4 Mar 2026 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EMXJNdyw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bwFdM/pM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E038642C
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614447; cv=none; b=nOF9BXeoEQSLnQx86+o8quDjGWbb5JC2PvUW99eKJfCdvPtpqaRmzDiRp/QNVCbf0Boj2KecH6pHlRuO1U3WebHJnpMUXHvbt4Kaxt708QCpQ3+ugRh3eF1Dow93yrwdYVwt5SG4bVOGaRfeXGV4pUKOVF/pEezDuIroxdB++KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614447; c=relaxed/simple;
	bh=1UJwj0YarudP3fchhpS7NabacgKhtSwOKcEjuHqcB2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FcNMC1auXDDiNUFHxYyQLBZIfGqXsy6P3RkLUsjZYU42O2E7Jqt5HiA0U9wmKL28dgXqTVcZaHzqExl+F/vD/wL+af2ETQKHJnRNJC9PydaFfX5JumZdlBsABaxMh4/7R+dR/YTcb6VRnS06sj3WfXnrCgx1Z/s7B65JTZ8OGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EMXJNdyw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bwFdM/pM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245TC6D946662
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 08:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KqCQTN0mpKgKHcGY9unMdelUAmpcagrmaV/
	BIIbHl28=; b=EMXJNdyw3CwHchkrLP9ZPgunK26GidPzXytbIx0JtFr+NhWRVxg
	p1DMq4aCDpToOopxq0Jb552T4OBbyrrkK58LZSKW5TYDMEE2htQGDeZla9jVNZvD
	NUo49ivu2CStTF/2EY3rdxhdkqhgSvqo8MGQqhu4XYZEbmFN2OKyrC8sgk89VCfN
	lUCvgC9IY7hPSthBIDBzrSJIQKKKxUyhL+tvOfTjf7ZaT9V7bdcwni3oVsjrbccI
	ShzY20KaahKaQYd2odaffHuGT72mXG8gBlFSZoBFXv2Vqx6xYk5xzqpngoRb46DA
	LGUCojGyFAn7r8A8QivojAgxMbX2LrzhaHQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvxfcbt7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 08:54:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c70ea677571so4012715a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 00:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772614444; x=1773219244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqCQTN0mpKgKHcGY9unMdelUAmpcagrmaV/BIIbHl28=;
        b=bwFdM/pMZBKxB5HpE2pattD9SpHOcM99cFYnmdK9ZLMqceZtlgqwiakgy/X7Zl6yGv
         6QodJgn5LLGu9hFhsE/e3+81woyuDctalVSTbCxSwPtWVBrqkZOAvTgLrOVbiIOBPHcP
         +dY1DwJnA5lmsZlqKHx+4S8PtF9z4iVj89FzKBe16ktOzqMIJTULmkbNDO9VUKbSTU8f
         rwVs74Z/XymaKs/hy1zlJ3GjppOoU0G4mOckdvZBxx4/3N3TG8SMC/1zC7A/dLki2F5x
         nsv2u62C63LGVdoumF8RMx+L2blaslptpF/qiRNgCeCEYp+9KfWqXH0oNJ4Ci2tY/FT2
         K2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772614444; x=1773219244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqCQTN0mpKgKHcGY9unMdelUAmpcagrmaV/BIIbHl28=;
        b=FKuTzyr8b1Pq4XW19q3r2g6jQeQ8H7uRoc9BO+ThiEtnL547TXJYcuF3AK0ZrVuWe3
         Zup/z+mC+7K7Q3NFU3DHKqQtXdHwKq2ZaazWQTuzUghg+JWgtP3i/gfBPbbjGM1sIi0s
         g2sbbMDpSyp+MqqTM9VHF8Bj0xArXiphbZfZzOXgG98N8IMfISZtN3mE5TSPJsC7AhZb
         F+mr8qIZAZdMnmorV8pGY1GZM1hXY+oZLU8nC++hBegZCad8gjddoEZVUeg0hxamxouW
         IzdAFTm58+VaDmA8g9Fve0LSDIr0/qV95KZj2siVPaxQSuQhSuol6kWpYUfS2wwqr9e2
         7wPQ==
X-Gm-Message-State: AOJu0YxV25Bmaf2yOrWi5RrYqSH/DMRhjGbigF/xVWdEzpkjSOxPQ0mu
	hHRKVLisdjOql2yIkTZMVM9hTOqTPboFd3h8KKQsruGp99YCkqKHJ/oOSFwTBt6S8tcFoxbFCP7
	Jb83IA2OqAyH1fjbAu0N1ah3sR0TvyGl/iLh43LuFm1WxSV5T2KweXJIj5EFoeBMF/Gn6bw==
X-Gm-Gg: ATEYQzyc3cQfNA0p/DjEmghaf2hksiVM6i4Nfmq8tEvRic/bOVZK9jj9BgreuyHPtp4
	iSEKtVo+G8dtNdVEh3gFY2WVoixsVpvsyoIbHdXHjBGLH7JeJ82+KFkgUBCC91KRAUb2X5nnjfY
	KGSTxUKlffb9MfF9Wnv4SzbVYUI6Q4hp0y9jkp2ofaIPBcCGiuDUowsbk+f3N8iWm33dsNu7tAw
	aSiKKl168XxTDLF62RG5GaGgPE50rIE6u02yqToKmxhygC6Ry4KXpwYk4eQPFb7Wj+hmQbtdq/k
	Tvu/j6wAwAfVfkfZ01atl7gfAuGdmz1rVyPjfKPN5SqhvP+AHMK909LJIsvttdbwgPdV/3zWbch
	96OJxsKZtvrmEgs3W6ir/rbickRGFcdvJgZC27ffwjQ+AemPbSzfATCfm39OFjtqnlA==
X-Received: by 2002:a05:6a00:2195:b0:7e8:4398:b34f with SMTP id d2e1a72fcca58-82972c9e7d7mr1219355b3a.34.1772614444078;
        Wed, 04 Mar 2026 00:54:04 -0800 (PST)
X-Received: by 2002:a05:6a00:2195:b0:7e8:4398:b34f with SMTP id d2e1a72fcca58-82972c9e7d7mr1219268b3a.34.1772614437061;
        Wed, 04 Mar 2026 00:53:57 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01a9dasm18205140b3a.49.2026.03.04.00.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:53:56 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH wireless-next v5 00/02] wifi: ieee80211/mac80211: Add UHR (802.11bn) Capability and Operation parsing helpers
Date: Wed,  4 Mar 2026 14:23:41 +0530
Message-Id: <20260304085343.1093993-1-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfX7cDvhMlqoZM7
 44US5UpCa5RdByyIAhip8EbMrXRoUFJMzZ/q7cWqa72HLCAObDHPfDiaLz7mmMaMII0doti1WR0
 P7BLldFOLoNUfQ5rgD7behOpxJAuK2rvYNFj+Ht7g1NJ3wwZVXRiEGPPQBzIkuue3y5odeKzPhf
 Xi3kwS6b8fwLrjb4VxvutnM/3B5XsOcSZS4xiDL3fvc9eehwIN0zmB9oAX0z1lJa9qIqJRJ5H/z
 wfOGTKRUj3tSO5psuz5lxtV/VJKvyMfyoSjs9Ssr8vACkCYStacxAmi0bD680CT7BF8vOPHkAjp
 1I2i1Mb81puY/yYpiQ6m12xMaQzhutb2UmhvAo/BcQEvGEdfCBn1FivIqPN0gkiJT3KIyQU2HtI
 zqoKElacwMujeb2EuVVL6/CM/D8iAQ1XddxkEz4PbWZUuDfxfup1vIm11o2/3D/udjhiMliIH6G
 j5n4z4Oqa4Jt7F0RXxQ==
X-Proofpoint-ORIG-GUID: S1JlHlc07J7q7qUxfNf7lI_1liE16Vyd
X-Authority-Analysis: v=2.4 cv=S+HUAYsP c=1 sm=1 tr=0 ts=69a7f32d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=syIFNRD9xIPPAOLOExcA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: S1JlHlc07J7q7qUxfNf7lI_1liE16Vyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040067
X-Rspamd-Queue-Id: 034B11FD055
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32455-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This series covers support for UHR capability and operation (11bn)
parsing helpers for DPS/DBE/P-EDCA, and adds mac80211 hwsim changes.

The code changes are based on the IEEE 802.11bn Draft P802.11bn/D1.3.
There may be changes in the code to adopt upcoming 11bn spec changes.

Karthikeyan Kathirvel (2):
  wifi: UHR: define DPS/DBE/P-EDCA elements and fix size parsing
  wifi: mac80211_hwsim: Add UHR capabilities to the driver

 drivers/net/wireless/virtual/mac80211_hwsim.c | 246 ++++++++++++++++
 include/linux/ieee80211-uhr.h                 | 271 +++++++++++++++++-
 2 files changed, 511 insertions(+), 6 deletions(-)
---
v5:
	- Addressed Johannes's comments
	- Modified hwsim UHR MAC and PHY Caps as per spec

v4:
	- Addressed Pablo's comment on mac80211_hwsim

v3:
	- Addressed Johannes's comments
	- Removed reserved macros and unwanted
	  IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP

v2:
	- Rebased the changes on top of Johannes's initial UHR commits
---

base-commit: 0314e382cf02983eb3c33ac537ad9701e7858bc9
-- 
2.34.1


