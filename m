Return-Path: <linux-wireless+bounces-22028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D63A9BC4D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 03:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4F13A7A09
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 01:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D109635959;
	Fri, 25 Apr 2025 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4gImfD8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B526AEC
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745544498; cv=none; b=TN+mFghk/n8Ap/OKKxW0Hlq76S32g+mXGRXIuqCzImedQ0mEFbBOZs2GwlDBoz9RTgxfurevgHgKolLe24TxSw6SQRBpAT8TkPoGDaaTJZ6VV9rItYSyS9pIKHvquwoQZYgAI8qrVD57BPjpgh1PVuOB33LPyxwTdDe3hqmispQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745544498; c=relaxed/simple;
	bh=2bKM1APFgtVSflDq//Uus8QggO6uZzj9lDTfo6xIZyA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AYEgj21dA1DXPSuDymknVFWNCA/NZD7lDSTP0JOI9Bo4nhZBObFLC1kP1tDYXEJ05KAoOWp11JnxYFzaWoZ44QaYwAFbX55KEu1lEDwvZSsCrHNni3nKo1uIKyXzZflca/nKwYsPMvu9wftXqF++Kmq1ycj3+o6YdZsCU0EhnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4gImfD8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P17ERN004463
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=RlA8tRbnOU7B
	9FL4oicCKzLnllOZdDGh7muFuKJaVEg=; b=g4gImfD8xYrtDlkA9P4mh7evffMb
	21Nr8VgIMzGP2U9y/PKRSFQXPt2hVt2IF2WMXgaJVVODOIb1d9J7LZ0j7u4sMGIP
	jZiSFpV+9ly0sGsE6SUO0sEmBA2vfVmDtl4NeO/HQM742JU+YDiEVdPA+y/5mPjB
	URAKDlvkMznSwLz8x7r4Fo/aoUVIWTNdEu9XevAuf6q1jGBVvuG3EmsK4wlKyITP
	gnbVpbVs7ZMV4pO73N+Jo6WXZRid1T7rYBjEn/R+gCDpaUxKuBuw1fHlQ1jnShpy
	vENKCdUrUY39YM73+wJwllN3sdM+RGsghfuaEtB8tCseY5eSCFUr94UVJA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh17887-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:28:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso2382112a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 18:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745544494; x=1746149294;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlA8tRbnOU7B9FL4oicCKzLnllOZdDGh7muFuKJaVEg=;
        b=WA84tcZ3wibab7Y/cki9DanmpIDD1D4ZBoXiSc34fykffEoUNeVq18IGTL4Q0YdLDm
         aQRWEBh6V/MEeY1F0jDj4EdxvSKHH5qNbRHGzxQ+y3xnpvW4bdNMWTU+sBW+5k2dtuT4
         LmFow42VXcnfWXY3R6824aTonWTlqHT/+b7F0wkARGVhHZKBhHlp+zy4edCgN/Ui3NfF
         vOrA/GMI8/w1kMY0Y/4st3y7LRg3YwkelKEsF9Z2fJX03WVkt8Y/Ya4HEw6MVF9xm2+e
         XpvmdhOmuaQYkrmaqCa0KA0U3Ukg5jXbkHE3tG0ne5o1ZNA+KlfBH8BjayGHGUpdly7U
         kcfQ==
X-Gm-Message-State: AOJu0YzOJiy8xYXNdOQwb5jpJ8cXoxuJdlMT3e827EyN4QbYWnKVqa/n
	g5+LJt3Ht5zUA+VaIqMw7LXo56z3lTyEX2nMNvFbgejCk1JcZjrtpYm0AoW3bQ4XgHXi6ZAOkmc
	pVMGTv+blcB1ZgeBzebU8PjJCb4nVskG77sZBqQHyeME3zvKP+anY7K9EF1WsQEjxJoMPQTDKuw
	==
X-Gm-Gg: ASbGncuJIsDRj77luxpZcSnJlUBVRFAdZoJgYhelaGUiFNDuGCP57QR4ZFhnrvUJFnO
	vq7m2rqh0gcLiZYmpolFEwD55m/qkDjkHdqCtVRiXYedgnuY0EUKpHTtvtbx5BfTOvo8ro9WYCC
	NzaXRV9sDx4MizahpditQH74ei4uZqdOhzZnmw/h8UZtnkVj5HjUux2SIdXpTBVN3xWSZBKvlD+
	QCB9CgKKjHl8X7OA8vqDKRg8qi2XAzflVPkTNOu9eeJ4c3gXl45dt4Y7xMNzFRslYCuSWdqKzfg
	4HNxQfQP/htv+KuhfB9lTS8W82EswM6arywtAWD1YL1UTHpq4Dk3+eTVBNohg3N4d0xt+8wqDMk
	DfssFy7KtCyT2TR4SPNMqMfPgZwtiQ/edodDB3CQGysb8Hw==
X-Received: by 2002:a17:90b:2d48:b0:309:d115:b5f7 with SMTP id 98e67ed59e1d1-309f7e702b7mr983429a91.24.1745544493310;
        Thu, 24 Apr 2025 18:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDHdbOLbRUs7slkIl9ET+p5e8fC88JyP7k5nDxCQWDICNXG64PQVvmPjBEREcSUhFb4ydyrA==
X-Received: by 2002:a17:90b:2d48:b0:309:d115:b5f7 with SMTP id 98e67ed59e1d1-309f7e702b7mr983407a91.24.1745544492909;
        Thu, 24 Apr 2025 18:28:12 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb1asm2160107a91.7.2025.04.24.18.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 18:28:12 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next 0/3] wifi: ath12k: Add device dp stats support
Date: Fri, 25 Apr 2025 06:57:59 +0530
Message-Id: <20250425012802.698914-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: fWNo9Rszta9DhfwgUa5yN8cRRaelJDsu
X-Authority-Analysis: v=2.4 cv=OY6YDgTY c=1 sm=1 tr=0 ts=680ae52f cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=t5_hsKz-ZbAw1yxjjTUA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: fWNo9Rszta9DhfwgUa5yN8cRRaelJDsu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAwOCBTYWx0ZWRfXwNETaPEP+Mkb GAwHNiy/GdeaVL8cb5/WoH86yzpUgwFvh2upDbVdwFtn9xf4PkcvFo7QK3pwrLly4qMzL27yOlq sM8xXX2K1fd75/+O+HqMNj0pkMoHGIi5JlcI3pQhWrovD094DV9F6WM/DnladPqjcDF9SBK7SXZ
 sF9xLXg/rvyOmLL8+CV4vgtSllbuoek9iRogs8wVdXGXc80y/y2yWaGGyTYyg0zjTbahm2C2Jcj wUNQASxE9wNS2P2+0oc8PRTSsnQC+YZ+jE0wtgzkLU0OoDpr/FN7QkBZO+Th0HwgoKMw73RCTLK 4Gr07jf1tzx/NJhRS/yPT+Wzn8/4dv60o7Y/vUD/qRErmTjre12fCBzaNk2DbdKm+itqBv2JGp3
 IvmGEw+dy+jRKVHolnEgmV9l8d0tGlrDaryZuppcf4fh5kMPZagToQgIUJUkgfaoalQiDN5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=984 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250008
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Add support for data path related device specific stats. This
information helps to debug connectivity and performance issues
in AP, STA, and Mesh modes.

Depends-on:https://lore.kernel.org/all/20250417065237.2507613-1-maharaja.kennadyrajan@oss.qualcomm.com/

Vinith Kumar R (3):
  wifi: ath12k: change soc name to device name
  wifi: ath12k: Add device dp stats support
  wifi: ath12k: print device dp stats in debugfs

 drivers/net/wireless/ath/ath12k/core.c     |   6 +-
 drivers/net/wireless/ath/ath12k/core.h     |  23 ++-
 drivers/net/wireless/ath/ath12k/debugfs.c  | 199 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/dp.h       |   3 +
 drivers/net/wireless/ath/ath12k/dp_rx.c    |  44 +++--
 drivers/net/wireless/ath/ath12k/dp_tx.c    |  28 ++-
 drivers/net/wireless/ath/ath12k/hal_desc.h |   5 +
 drivers/net/wireless/ath/ath12k/hal_rx.c   |   6 +-
 8 files changed, 272 insertions(+), 42 deletions(-)


base-commit: d33705bb41ff786b537f8ed50a187a474db111c1
prerequisite-patch-id: 0962b21db0b615497d326193d1590f93621936c7
-- 
2.17.1


