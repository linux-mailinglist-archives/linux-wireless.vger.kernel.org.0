Return-Path: <linux-wireless+bounces-28004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1317BE6424
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 06:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD323AC434
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 04:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D723E355;
	Fri, 17 Oct 2025 04:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fx0eexYe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B41758B
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674092; cv=none; b=W9Z8dO6oTdKhIwJmZnYAdCDxQZR7vAJL3pnQT8XaR6VQkVcnnvdmsD46Kg5SU1DMCwllwejkQeZrBaaoyvkwZXiPNp9y4S+4UOBs/ahj0Sk/ACQlyk+KfA4vvnKpjDqlVomsckfQdAQJgJJ80xa2vA03Rb7IaEr/ednoZwGeu5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674092; c=relaxed/simple;
	bh=F5lskrdIsNH61tGP+KaxN9hcT3B17+qf+2FmCdeHtUQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gg4umgQVHnUV0WEfhwyUgOe0qzk0fcf0RLhx98ZdPUyKZO4keuyP4XTIxMxEjWw7hvWRczH0u3mPB0cCqFpONYVxXa8sO6PzU0M9NBKvAt4v8K3imQmHWwNp9FkisjVWE3JINFr7Zzvow/133kdi+pxilhEe9I29LJym5BfRWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fx0eexYe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLOkl020186
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eIh6QDrVuJ/d1GJLBquAFX
	9AU/PpEXWmpulGYO5uhxw=; b=fx0eexYeTDSLElR2Q5M6s2tDrfIUJtt05nzPJJ
	xedsYcY5dgiNRoH9TSncQ2vQQlUnB6EopAVry0fnOvect9rqBjhmJ6vdjsK2N8nt
	Eb10uhaGTvKZsVIqYvV30X9f0g3oc4cFgjEPQy7DdKIUMhFM8A2rfPTFLssJpUBk
	I5BKRPhVW4TKeHRGH/DCeWjLEv9DNOIMhZmrZPRUe2XTlgywKIy+U+sFVVJHgUWr
	uYZ49msIxbR46jATSj4ODo8JqKamnJZGCcE1G/buxxM7C4SKSSzOzO/LGpunAx6B
	CdXig5w2uSc9w0PQKvO06xzfoqUJq58ZhqteBRGwEeisqw+w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpm642-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6ee6so16945365ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 21:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760674088; x=1761278888;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIh6QDrVuJ/d1GJLBquAFX9AU/PpEXWmpulGYO5uhxw=;
        b=tsDWW+yUkgexDQQm/+VAVWKO/dR7mnkrKZqvd71fMXYwYZQJ0siQemvRrdmn8r9uhL
         YBBHL3AEBpZCtVyqU4dGNJAUNkGltTVra5JN5+TBeMKrxZHhsFaulTS4uhGfsu7ePrdE
         CJBmldp6IgxQPEVyB+VM6m6aPTJvkegXxVUw53SY1J2lO6gbMTfDGcW7OOTGDcZqYSwR
         PZmp9lXPbUewQhgVB9dj0BPsKO0vXlne7t6T65QDjZQGE3zzAo4PSl14Yjw07RyAQeZb
         pUzksKGS2dbvImSuV/bYTn3CC8EoopHHAbl8cXK/acBgRxk4mlOUXBagTTErb08YgYmE
         LXwA==
X-Gm-Message-State: AOJu0YzAWJjl8dbKnEEHGysNo5kxZ5d9KhYahiFRPCFqzFRDncLaPQUT
	XbtGpWDZgcTnAB08qwDk0XgG087wBHs3nV6U/zKRQ+Cwi6RsOSaqn/eY2EuZFAixIAAOf4vc1vb
	rndIsP/gxc8t48rI2UY0DDsIFJQ1zMfjBcrkHr9QItXbJS0mOGTkmCkD2kTZrLiCvdCwjaw==
X-Gm-Gg: ASbGnctCjfccZwV8VfnaHPwrMYM29DY7cO9+YSn/pe60hjKkYcgeXLLou1a/y+pqU87
	LoQrTgFMYoPV9kNoi0ESnsXPpvuxsvtEg94cNQHAgRbh56hrJzP+SDSrk2eFbfNjYFLAmuQzbH9
	W41/B7aQj2HNMH/Nsfd51EJECHimw+d2bEQ+6iVGtBsyk1kHrjFRd0tfIgIljAbsFd2gLEM3n4G
	J8ZiIpRrdjoTHc6vSAfybmcGjrq39DBMBCrnJATMiQkp6S2wam5F79zlaT18lyWwCRDopktDw+c
	T00Mb6JBQmBMiEr8Y4jRelWg6BYtOl559AmBWfQRneLQp+ILjndg4cdwotj7D8TSTIy/g9Z/cTN
	zE7JNe4veVwPGMgrYTlB+62FZ/1pzm1fJhlzkDB0PgnXGHLB+HPAEwMoMDU683NiiVnGto560gT
	g6MDSGNOOO734aJXrG90xaH+c=
X-Received: by 2002:a17:902:e543:b0:267:99bf:6724 with SMTP id d9443c01a7336-290caf830f9mr30438555ad.31.1760674088602;
        Thu, 16 Oct 2025 21:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyYc6twQnPndhA3cfepRvywyPP4rwvgYtifdeLoXuii2ItyGwjzdw2RWmU5anA7cCujXlqdQ==
X-Received: by 2002:a17:902:e543:b0:267:99bf:6724 with SMTP id d9443c01a7336-290caf830f9mr30438275ad.31.1760674088123;
        Thu, 16 Oct 2025 21:08:08 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7afcbsm47635345ad.76.2025.10.16.21.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:08:07 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH ath-next 0/4] wifi: ath11k: add support for Tx Power
 insertion
Date: Fri, 17 Oct 2025 09:37:56 +0530
Message-Id: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzB8WgC/5XNTQrCMBAF4KtI1qYkkwZ/Vt5DpDTJ1Aa0qUmsF
 endHbpyoaibgcfwvvdgCaPHxLaLB4s4+ORDR0EuF8y2dXdE7h1lBgK0FGLNa+eqPFZ9uGGsfEf
 1TJUqXfs+xMxRA2jcQGkaxwjpIzZ+nAf2rM4t73DM7ECf1qcc4n1eHuT8/3VkkFxwraST2FiDD
 nchpeJyrU82nM8FnXlhgBdViq8qkCpMo6BUaoVoPqjqP1WR6oyyCq1AWOs36jRNTyTI2bSJAQA
 A
X-Change-ID: 20251008-add_tx_power_insertion_support-e5225e924bfd
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f1c129 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Tb0W7XID7D5ug3WCqewA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfX9elIa+IVw/mP
 lm73DfPR1FSMC8dmEnWGfd0hFYhBHTcK2E91se4fOe4Zkteea7SgMabZN89YjS1Tb7MPusPmg8r
 ctAqaqGqlLLROW6OPth/2/BWAUltDdvj28DCN/b/4afn0H8TwLAZLOsorLpfheFX0ZqvcZwny+p
 aba/S8zrHEH+YKf9LYWCjRu7vABPjhebYntc4IX9b+XztbApTrJKd3VJzYBxRCZ0VhF51Gbil2q
 UQpX5IoQlatXS2V6b9TeGI8jnmbk7i1ZI1XSvVCD5DimRbVhZnDbSk1qh+MFYNJWZLxRVVWYbNz
 AsE5LCJN5mHtQYeB4TJSz05kGZ3Vp9saXVeMTtI5i+7E7n8RpZ7SzF2UzrMRjdJmeOc5f2bK9vu
 42ts0Nz6eg7/uMVzLHYUtmT3LyjunA==
X-Proofpoint-ORIG-GUID: QBdWwbY6-XGF-7Nc0Wln3qrAP32vdRm7
X-Proofpoint-GUID: QBdWwbY6-XGF-7Nc0Wln3qrAP32vdRm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017

For certain action frames like the TPC Report IE in the spectrum management
TPC Report action frame, and in the Radio Measurement Link Measurement
Report action frame there is a requirement to fill in the current
and max Tx power of the device in the packet.

Add support to populate these fields in the relevant packets. Advertise
this capability from the driver using the feature flag
NL80211_FEATURE_TX_POWER_INSERTION.

In software-encrypted cases such as PMF, skip insertion since the packets
are already encrypted and cannot be modified.

Patch Overview:
Patches 1 and 2 serve as preparatory groundwork.
Patches 3 and 4 implement the core changes described.

For context, this ath11k implementation is adapted from prior ath12k work [1].

Reference:
[1] https://lore.kernel.org/linux-wireless/20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com/

---
Aditya Kumar Singh (4):
      wifi: ath11k: relocate some Tx power related functions in mac.c
      wifi: ath11k: wrap ath11k_mac_op_get_txpower() with lock-aware internal helper
      wifi: ath11k: add support for Tx Power insertion in RRM action frame
      wifi: ath11k: advertise NL80211_FEATURE_TX_POWER_INSERTION

 drivers/net/wireless/ath/ath11k/mac.c | 447 ++++++++++++++++++++++++----------
 1 file changed, 312 insertions(+), 135 deletions(-)
---
base-commit: d5ce93f136fbee2b7afbe221f34ca881036f8de3
change-id: 20251008-add_tx_power_insertion_support-e5225e924bfd


