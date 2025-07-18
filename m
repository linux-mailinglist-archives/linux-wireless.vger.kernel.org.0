Return-Path: <linux-wireless+bounces-25626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F51B099F7
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 04:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0BC3B9FB6
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 02:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D171A23A0;
	Fri, 18 Jul 2025 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JSYrzEaz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171FA923
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752807329; cv=none; b=YKuMspTAgCc375lJVTuA7pDQb/dbQefjnMY3vzqkNroNGcTtKU/xogR4oCbY6LYi0XvrPgZoFHtq8Glvqpc6LSaALxld6qRbygRD+WQEUEWf/dqzIUM7qZzt0+l7YKMaMnW9cwv2LQKSs8ONP0NTyQONoXfH4TZZTEJDNdYprTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752807329; c=relaxed/simple;
	bh=EJsV7u4Y62k53o8IUW8IOEccOvUAb9endBiMaqk+3xE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=W7h3dZ9MzJHoGF+FsD/PKHqoqhTijI24K3du04hAU+coyZ6VmE3GwHqDf/CXDKnjKlx2WWzLyezIZRvRnJQ2DPU/80d0C8y7Ne2sJrop8wGryzXEe/8YME4Ri3tU5TeOAXMIe4Yg+zau+8TqntXbW+8tJrLk9ITpo5lCDcWbKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JSYrzEaz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HKjTsJ020661
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=mRzmcWz7R+mL
	eW6KePbkFbqE+CyDHllGwyZr73meTP8=; b=JSYrzEazvtdBzRWq2ccTV0cgkwRC
	HZ7DrLL5xrn0Xt7RZY1Fp71k/Hfk2Uodj6Mf7qB+h5pzmzRJ+s8VyC44Za0wG7mH
	+KsYIFTlLkQl7of8lJIg0UU6B3yUSNcqLK7KpqQjh+b/g3Whsx30TkN8ZWJ9oqri
	4sfYNlwFLErPR4ekvXbVHkD2oBduK5qTkmvXSCfk4fYh+WtOpleNNjbmshzpCQeK
	EjjKjPTtao3AYnABNSjYU+NLd0qEGaBXrc436wfh6tqmbzipU3qQFMo7A1KKJdGb
	UvY5WdHtl2l1Yjf7WkBGdJDQRz3MCGy8EzXnDrheHYc1eG6+TTT0hdl/tQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpn07k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:55:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74ea5d9982cso1253077b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 19:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752807326; x=1753412126;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRzmcWz7R+mLeW6KePbkFbqE+CyDHllGwyZr73meTP8=;
        b=EMQ7rEocBUkVc638/qlVJQ4PTmeSIcQYUIbBDis0SZOWS5OY3OmLmDezDWRxF2VQr5
         PLJErNEpuaBSqiKE3A3cn8RKYxRF3UYhY0JHaZTwtSa7KQ97XUTJsugpbz5/LeoUE5qp
         b9GCKkFbJULzX77Bhj0jp9qofw3/aeL6u+KEKA7oyvmmOdJomvuK8c1FadwZ1YSSkMXv
         3Nme09SaAJnFc3y+YLyDxa7FA5aRnOpUZvBPT5OHcm4OhkkHxtmX1MI7j0Hk4Q94WGaw
         jBgvN6uRIdxumjFV0KXMGJ2URxHFRuT5VIBI5EUNGg+Vj6lOonPEnwA1ft4wO0bMpuUz
         XsMQ==
X-Gm-Message-State: AOJu0Yw6NRw5Lv6Fd7ksl97N0nbCcUOegAfwhwQh8VusZIFj9YRA42kY
	CpDaIEgfPj4+4RNFPfbVnmVdUyoPEf8qr3Cve+0qhB8+wkWAUEs1iih8GTO+e6P47ptPFXoTP4x
	zO5QiYBSzleY/FEFNUZ1In3Kz/w5cutZbf2OeNMEhAewCjZTbJyz0Rj7wfctu5U1L+xwdeA==
X-Gm-Gg: ASbGncvMFyv91QDPUXE4EaJXKgK6PKTCJrmcLJRSNKTivjSsdikExTVnHWJ+I+60FAk
	onmj/iz2MNFyuOrpS8enX2fnKeB5qMJ8uatebYkED0z3waSFoCVJ6CDdY/B6vnsFTNw2yFsgkLm
	BxjISenCZoS2DVe3srz915PfRgsRL/65xmVr75z08X9xGaDBiov4ooCBywhEpOXoJuTL26UP6QD
	6GKg6DLeY8m37FSF5qhfa1jepIpuw9umXOWHq3ywWuZlUzBnYyMMfB/v8ISWII8cDKwuROlYTiH
	+4l4tSSl7xdPALdQt86+sEmnA1FsH5NtdZSVOYDfTH5POc4VieULU7G5/60zI3RJWbE9P4SZaKX
	TYMwB5bQsA8K3P7Mu/zU28UbzO/4aaFIBBqVAli2+r34gXqCCBN2wWrWzP1SusTyvKiaTsmW0rg
	==
X-Received: by 2002:a05:6a00:4642:b0:747:ab61:e4fa with SMTP id d2e1a72fcca58-759ad4012efmr1623653b3a.14.1752807326375;
        Thu, 17 Jul 2025 19:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvfOSBqPPcq0Kq8bI80tZsHjU/F3kMUGLuQZu9TUFeQgRVXxb+GPqY2FCFWtTaRGqr3eHcvA==
X-Received: by 2002:a05:6a00:4642:b0:747:ab61:e4fa with SMTP id d2e1a72fcca58-759ad4012efmr1623628b3a.14.1752807325907;
        Thu, 17 Jul 2025 19:55:25 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68095sm255334b3a.139.2025.07.17.19.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 19:55:25 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next v2 0/3] wifi: ath12k: Add 802.11 encap/decap offload support 
Date: Fri, 18 Jul 2025 08:25:10 +0530
Message-Id: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDAyMSBTYWx0ZWRfX8FfwEu1+zXKr
 JlgWSYtyNMIeudEwf3MPyFrUksfzLXwu5U/zBfrF935M7E2B85FHLwzP51FVENAfXi6cBWwoHpc
 XSLu86+ImPNWt/3SltkevcDala2tnaC9wl0IlWsuXDwtB9eRbFSfGr+zqbOxQpFF3rWyukuWUhc
 N4aBr0/OO11ovMl7UUMgAe8252Aa68R/qSjSes5bs9zJdi5AMGY2ilqiD2q8ch4WYBXcczpl4G4
 OcMm+cI1hFebawBYCsOyXGErneW/+237IWkhFAciV30qzIjWz9I7e0frNzYezpwd9YYKuShikH6
 dlDtKSoewwvFJnG/Phu8dNUFZmsjHjnBo+YPmLE57m+mrDD3emIlkTv6RwpqJKW1NtA8Mwu9zeb
 mNT95aNoOnR0ZTJbxP5I7LhdKsnkDtjeVcnYFgHWSfJa1uTKcc2rukvX9CSOFSVdxh1+OsNG
X-Proofpoint-GUID: nJqJZTD2JAtSBf0kjZ5DA-8otlTAo4u2
X-Proofpoint-ORIG-GUID: nJqJZTD2JAtSBf0kjZ5DA-8otlTAo4u2
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6879b79f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=87EwTfTGHB7IU8INq4wA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=944 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180021
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, the mac80211 layer handles construction and parsing
of 802.11 headers during packet transmission and reception.
Offloading encapsulation and decapsulation to hardware can
significantly enhance performance. This can be achieved by
having the driver advertise hardware support to mac80211 to
bypass 802.11 header processing

v1 -> v2:
- Rebased on ToT
- Firmware service bit check added for EAPOL ETH offload support
- skb free handled in tx completion station negetive case

Nithyanantham Paramasivam (3):
  wifi: ath12k: Fix the handling of TX packets in Ethernet mode
  wifi: ath12k: Fix TX status reporting to mac80211 when offload is
    enabled
  wifi: ath12k: Advertise encapsulation/decapsulation offload support to
    mac80211

 drivers/net/wireless/ath/ath12k/dp_tx.c | 102 +++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/mac.c   |   6 ++
 drivers/net/wireless/ath/ath12k/wmi.h   |   1 +
 3 files changed, 98 insertions(+), 11 deletions(-)


base-commit: 45bbd91fc41b7cb6319e45e6fd732c5c8a0c44e3
prerequisite-patch-id: 1d3bf121aa8bf03dd29436bd0df63de74f753027
prerequisite-patch-id: 0847395767a6f49458db6b857a9be81d12dc534c
-- 
2.17.1


