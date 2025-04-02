Return-Path: <linux-wireless+bounces-21101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCFFA794C3
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 20:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFF93AD757
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C915CD46;
	Wed,  2 Apr 2025 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eKH1Ujca"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C79186287
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743616654; cv=none; b=kBSwU/cV/CuUS85srUpsNSMA0d75/UxeOkAwYUliegOnsNtHNtytP6MJRg1ybEN+7FfryfJeUTCCgSbLyfDFToB5LfKKXqTlaPSKpqxultPpjPvhK3cQGryfFiPNjn33736yH61zfOFQgNkYKY5EmIXJlo00h/pSHCsXpKWYKsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743616654; c=relaxed/simple;
	bh=ydu4bB+IZKtYMlrH8kAwNkzl/Lxme7fGI+/0pSmwXag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EK0GNYA9cPtiH+5lhTPiIkQis+DeirZPyt3Tpc2r7S/C33rAV2Du8fK2ZOYNz5b0SerwVsuRf/2PJDyF2hAPEvYWcYkd/3ZJ8rjGjwCv/uILcTN+H81uQcEwDbrKSvngftj70OFloRg/YyFadLkLHYsOTk0hB5WcnRmJZUKjMhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eKH1Ujca; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532A5qS3028288
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 17:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qEUXBk6klBeSZKXlhsLnnQbIGUHKLNJO/j0
	4SlxMffI=; b=eKH1Ujca95BAluZwM8vdhy/qci8905FIrI8vlDCQreSo7rAHNMT
	8M2E2JbgfiyP9RAG4kRuGulRaSjqPqHnnyaZYl/18ZDgqRDuMTUCsEU3+hTGgL2K
	PzHeeYtODpx9q/4vAbBCyiLAn6qGW3gOLAjZQ6wRLi9DDrAkL3r6gqWD/mUc6/04
	xP7fPaCsWv0v3MVtVC3/guzIt0UuCWFKNzwIRNNfHtWXkYLxXFhiJUhZFtHlOowM
	Ero0N0r/QBX0J1tGGR0+QxdSjZkeZ6RSrVan1BzHPJXffN16/tlNAobsQMV6Bywe
	DOqq4e8/7WJ8l5sEhynqFNc1I7rL2dwNmZw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45s36a1905-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 17:57:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-225974c6272so613125ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 10:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743616649; x=1744221449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEUXBk6klBeSZKXlhsLnnQbIGUHKLNJO/j04SlxMffI=;
        b=bKWVvtbP2iWNl2zTFOmT7i22Cglb6T7Gvgu/DIWIyPhxJl69L8Jho8hJQARSZh6NG7
         wF9pUX3zW93nDG+tUABCMdEEvFwvkgTLk8pH4TojHnHLr4+lzmdkGm4BpwjY2WJs6abW
         3uUDewOdEPbvkYDhWrCfTkKnwtp+mECL+r+jtUFS5utZ9F3o5Fv66F/csaf6AyT0WhIk
         XSOGpJsr82AEXZhV4vPmvMD8VSfg9Zx2lClr6QHhlzmi4Y5AQvnJPh6Fq93CoYtTi0o4
         lSwF0lllirFiIqGldVCsSZoNnCyD2t0ASe/t7QTCMk9SP6Y8UmGCaKtlCKMw7/gLL+B3
         4VnA==
X-Gm-Message-State: AOJu0Yys4JjE5bELpwCJ+M/1ezxiD+h87jLG/Okl3oydCRRltJt1KphW
	UAyJc0n+QTrHJ3ZLuD4sRkWAr0GWE0Xpqk9+TT8HXpjfqdYkgTcyUNf5ATW3Vf4hlSbq1CxRu3d
	V9dEnlixZOlQkKjuo+2rB9w2NzDNRAfMEWESebAC+r5qlN/OqyQYKjwuUw3wG0qgkrfkvtfNceQ
	==
X-Gm-Gg: ASbGncs2ycvnO48XdY/hQjXx2jRnktO2GT4t/RIkRWZzs+sXkVovy30UKQHHI6H5JcD
	akifBnnPLNUC1JtSyuPHJjdSVorgWfWhKq/gscg7dij+Cg8yfVlGRePv6j4cID6bjj7b/W6Opuq
	J8FVbxsNBflJCq0udqVEYKM2MJya7QHXBAQCgupD6Zq6qYZxbRWlDAY1/8ajvs7AMGseqdhaSxz
	UQvf6cSLJQTO4QJYOcP6cXkmQntNzXKURwvCA8Rb4bA0vfbWtqZFCG8TOeyvV2Ti5QBIIgnICfI
	KM7VRT+kqQ3DkGgZHMq8pyA2SKj/5l5yqqtgchahr5q+lOK85/+/o2aLwwEWgOyaCn7dbQT+7Cf
	ySK7o+Gq7cx4uFU7i2zLeFSm6JwTfzheV9Q==
X-Received: by 2002:a17:903:8c3:b0:21f:6ce8:29df with SMTP id d9443c01a7336-229765a48a0mr6068255ad.3.1743616648867;
        Wed, 02 Apr 2025 10:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzaLxOYupk4yzNKqDaP5LtWI0Rcx+fUIcvnq+y10gZE7lDourTrM/E0tBG7HjD4rLOwZW4KA==
X-Received: by 2002:a17:903:8c3:b0:21f:6ce8:29df with SMTP id d9443c01a7336-229765a48a0mr6067935ad.3.1743616648437;
        Wed, 02 Apr 2025 10:57:28 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970deef9dsm11312234b3a.23.2025.04.02.10.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 10:57:28 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath12k: Fix memory corruption during MLO multicast tx
Date: Wed,  2 Apr 2025 23:27:14 +0530
Message-Id: <20250402175714.2667270-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W6M4VQWk c=1 sm=1 tr=0 ts=67ed7a8a cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=7ECTBQRQhtQV3OkP7bIA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: ZKvD9WZTpxPeE3lxu1MA9zPa0tFC0hhd
X-Proofpoint-GUID: ZKvD9WZTpxPeE3lxu1MA9zPa0tFC0hhd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=824 mlxscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020114

The struct sk_buff's control buffer is shared by mac80211's struct
ieee80211_tx_info and ath12k's struct ath12k_skb_cb. When the driver wants
to transmit an skb, it caches all the mac80211-specific information from
struct ieee80211_tx_info, then performs a memset on the control buffer
before writing the ath12k-specific information using struct ath12k_skb_cb.
However, during multicast tx, the key is being filled into the driver data,
which overwrites some crucial members like link_id and flags in struct
ath12k_skb_cb. This causes invalid information retrieval when the driver
accesses these fields during ath12k_dp_tx(). Fix this issue by removing
the key filling logic during MLO multicast tx, as it is not used anywhere
in the tx path.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 2f50de725677 ("wifi: ath12k: Add support for MLO Multicast handling in driver")
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f2fddf213afb..8aeba791dbc5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7467,7 +7467,6 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 								info_flags);
 
 			skb_cb = ATH12K_SKB_CB(msdu_copied);
-			info = IEEE80211_SKB_CB(msdu_copied);
 			skb_cb->link_id = link_id;
 
 			/* For open mode, skip peer find logic */
@@ -7490,7 +7489,6 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 			if (key) {
 				skb_cb->cipher = key->cipher;
 				skb_cb->flags |= ATH12K_SKB_CIPHER_SET;
-				info->control.hw_key = key;
 
 				hdr = (struct ieee80211_hdr *)msdu_copied->data;
 				if (!ieee80211_has_protected(hdr->frame_control))

base-commit: ba613742db305037ca2193b2b552b769c4f2a5f7
-- 
2.34.1


