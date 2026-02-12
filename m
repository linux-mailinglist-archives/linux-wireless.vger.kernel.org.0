Return-Path: <linux-wireless+bounces-31777-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NvKJ+gMjmmS+wAAu9opvQ
	(envelope-from <linux-wireless+bounces-31777-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:24:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0516D12FE07
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F17030500F7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE195223DFF;
	Thu, 12 Feb 2026 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NyMahovS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jD05gSo7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97316214A8B
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917057; cv=none; b=An8cvwC0/iscJZdMo2U/KJ/dQE94bgPZ0jURipYzMEUkdasj6nvtK5Agi/PtyjXd1n98ZntvZThh3jivHVN89MuoeCLSWf89Ekwaq3p+ZIZFHRo+UzRJxuUzRQ0fiG1gPBNrIHMFmtl2lCEYSq9OS57wUw4+ctqh9YReYrSaQwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917057; c=relaxed/simple;
	bh=mRVhgEOzsTFPEuyvcMho6Gd9SZg6DCpdUsgyGo9inzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HC5+KB4yjP6/LrOJPvfNFeJkka6o4MsXlAat++wjSuxgS8EkV4Cmi2peB8I9nvbwKM+9zLKo7JrGbyA8x5TuIpaQfCr7aXniGegGeR6kdt2piHilDLoJZCoIjt53j1NGMU0/FdpSzU9UHI550FSEeJ5+R6np8NjcKE0r3wTVh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NyMahovS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jD05gSo7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CHHjBw1844944
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=sAEB+xpA/m7DLe8vYLgtlF8UQMruQWOmggF
	hyyqifcc=; b=NyMahovSHXTT0XGvczh8gbPDHICquL0bVZ00YgTVa1SkNULoDPU
	oD3X49bUbFoIyK4s/pSp+cronlILavNp1x6a9CfsagG7W0XSkWaQzSe8l1dsmg9i
	j5/TNs2cQUubkGcRPS8WF021Ta6p/KRiNPBIEU0iWISI/LFlclKHnd1b1P8vsyyU
	8rLlOFhf5KqizaeZbP6vdzu1B/+HAdF26or3saU4uHRJIKFG9M5nVD2UXPPJM1+3
	iU+ghZri4KvTNME/PkMKy3lZ3bk0Oor/U9+RnTRTMlZoXUIPS160G3zNaZ/COgMf
	3lsvKPzgCLIe+R5ZNK99oG38dF8L90HU7QA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9k4w80k7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:24:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a755a780caso15260445ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 09:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770917055; x=1771521855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAEB+xpA/m7DLe8vYLgtlF8UQMruQWOmggFhyyqifcc=;
        b=jD05gSo70OuckCdi+AUYWg4c57TCSQG4nwjP9f4CEoad+ar3/GO6ueYcEJBqI3PrII
         Xox751LUeHvu0usE5sHAmeI8CNeD1D5/RhNu2+PbATYhKDsWoYDoRoD5Dxwhn+waiYly
         V+FjSSUgz8E9ULfM+u0h1O7aXEu1ZzpVDJpYMPZ6yLho3AN7yyjtie2DvS3ylRKqJE7e
         Fe1Xeo9BlLK5s9NkyV29aK90T6mT7JF3i7eOPlGW0j7D0nH1SQkg83kCCIZgq8JjGZOg
         cEyvRXSQt1rLovcBi5RneVzlsSjsggUOxB4PBy7dR753bcln9X778VfvwVrdxMbk+rvw
         nkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917055; x=1771521855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAEB+xpA/m7DLe8vYLgtlF8UQMruQWOmggFhyyqifcc=;
        b=ujKC0beVj2UsVBbXX6nLDVIoJCVeVj16x3XnPLi8nYm0v7OBKX/VoY9chhbDzGNdZ5
         OAqUQ9kZKg/DePQ/Bp2pWtejY1KJ6vjDgHNIAQklDXW0o+0vLEz2W3FfkWIe8iokyf1V
         Lm/99XUKRhX7vLlFph14lslWzuHZ45fs++sZZrdLvSjibMqOqy3rMF87bCSeYH6EeHEF
         Sj+TbMPu/EvcCulEECKjGWc1KCjjRttoF5BbO9K33Nwrt1Hy/ccip27wmCctgncHGDlm
         KeWdrP1Es/VCcTT4mIg+36EjfXe3MFOYgcF8W9g3LKASn1P2lV78ogwNRp3RWRGm4wvY
         KmzQ==
X-Gm-Message-State: AOJu0YwT7Wy9ErT2T87b8LoPxS1UJky/3RzxXpwZGoy147tA637nQjmd
	BTVNEdY9X5c7+NPwUauH5KKYu5axzdiFpKSzOji6pdUs3h7EZC0shPQi4c4fPidsMSnGwpQzd4S
	cw98AecmldRmCVAHR3lZhBwwkoyXj+R2EMVO9pUI6TyDMGNmUI2Ymcj1JkYQmImcLupK6oZzBVB
	v+2A==
X-Gm-Gg: AZuq6aJyNu4z3OhvzDy7SrJq/uu3Q9y8Ii3FkKX5zlC6nchs1SFicHNix9hpONDMDCh
	UObfuZvIwRGwOqmeUzkyJ/U4SwDNLsLCGz5QxteqRo2w6W0Mj7Mw+Qibba+mAU+po90hXeQXvKf
	JsKwZMgAlw1jm+RT2NKxswPSUabJ53Fv+n1OOOnAfh8i+xBZ0ianAiA2uMQdoj1PGFYU8b0+S1b
	9z0rV0b6oWmh9HlBUYcmsyKwHv4++76HAQFUth7urHOdKSC0nINcjGR4spl3olkpBWOtMQC8w2B
	2oCTjCeUkoKVwWust9py66ZoFWZIC2SJesa+QNsSHmG0hA65iRIyQ8wsO2QFfe8xnMBSEh8x33/
	1cWs8Y/Qd4EC02sqFVhpYZ0aQkTRwFCfc4ACYhp9IKj4TUYZhKEhAMLgjfzMd82IXQA==
X-Received: by 2002:a17:902:ec84:b0:2a7:bd50:27fb with SMTP id d9443c01a7336-2ab3abc3fdfmr37582785ad.16.1770917054847;
        Thu, 12 Feb 2026 09:24:14 -0800 (PST)
X-Received: by 2002:a17:902:ec84:b0:2a7:bd50:27fb with SMTP id d9443c01a7336-2ab3abc3fdfmr37582565ad.16.1770917054330;
        Thu, 12 Feb 2026 09:24:14 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2999879dsm57697675ad.80.2026.02.12.09.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 09:24:13 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 00/02] wifi: ieee80211/mac80211: Add UHR (802.11bn) Capability and Operation parsing helpers
Date: Thu, 12 Feb 2026 22:53:59 +0530
Message-Id: <20260212172401.234059-1-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vly6NqwscueG_sAOg1Ov2AHgqtIqJbPT
X-Authority-Analysis: v=2.4 cv=bfZmkePB c=1 sm=1 tr=0 ts=698e0cbf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=9AfIhKOTUZz-8RWr15wA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEzMyBTYWx0ZWRfXzmre+b8jDjZa
 r1kMAc6gLB+Y+HXCBSi14XyIgIBz2qAihvOgU4WKXFV/Pd8pSDzKEaXybFPLPDseg4jcgjbSBZ3
 vixY3HMrJvtixGLecWAXpS4Am44L7A/P5iTGLaHQ+lpfs62oZjo4H6o+zB9ONraG9ldHjChlZCW
 TTEqioqjpOJdx9/rp8CBN8GXffk0cilvId7qFS7beItGU5xKzbmq2dkDjn1SA4I8uiZylNdex9L
 j6qjO2jQEQf3D3WWikma9tADNyF1jOcuniTOWGcdcs0MayE5NL+Io2eJoFMbbXlE1VEp/SCptAV
 wF2MomNo2AOue3mBueep5k+EqrImyLFSd6dcTUfZEcF2nsMWem/lIbEy37g6NBlywoLL51angzi
 L+NGDyOCVf+gOUPrEZJ1j/71b0UbrE/yJCVjvDNA2S2C+9qHL+xHJ4OWt48HPypwhApaa0jG9Ce
 1XryIZAVSB6kfpRqShQ==
X-Proofpoint-GUID: vly6NqwscueG_sAOg1Ov2AHgqtIqJbPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120133
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31777-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0516D12FE07
X-Rspamd-Action: no action

This series covers support for UHR capability and operation (11bn)
parsing helpers for DPS/DBE/P-EDCA, and adds mac80211 hwsim changes.

The code changes are based on the IEEE 802.11bn Draft P802.11bn/D1.3.
There may be changes in the code to adopt upcoming 11bn spec changes.

---
v2:
	- Rebased the changes on top of Johannes's initial UHR commits
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 288 ++++++++++++++++++
 include/linux/ieee80211-uhr.h                 | 239 ++++++++++++++-
 2 files changed, 520 insertions(+), 7 deletions(-)

base-commit: 333225e1e9ead7b06e5363389403bdac72ba3046
-- 
2.34.1


