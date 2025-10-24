Return-Path: <linux-wireless+bounces-28213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C4C04584
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 06:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C150119A76F5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 04:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9C2125A9;
	Fri, 24 Oct 2025 04:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fwbCcWe/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3C26F299
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 04:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761280621; cv=none; b=CPfKPy8DRK2M4AstHfwRLOp5VkwAeEAYKq5hOczGSjFmDU9bMySkXu6PUiSC7RtCqdiYl0EixPx043RLtiFjAQZrSah05G8bRMXGhdc8Iv0c+TE4X8sJM7RUJU4BE7Ohik6PGd7HEzG4iz/sJRU6M4jPXZGYtiCW3MOXd0H2LaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761280621; c=relaxed/simple;
	bh=C6qYUx+o8lVTnrJ5qeF8LZta2Yed8AVwAESyDhW8FL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f87Wi3IGaxUW2YeMBjdXJWo73Lk6BDDPVdaoYwCpdMKb9ys3Hx83qsurlRydJ2U+G7eoDFWRXhs7zBewRbiO53kCLzfw8O3+CCZQOtkPMIBM9sW4JVcaKXbjmZ4mzbZ/yG+5UHES1QF/3UTvNU54UPNeHY7lK9/s0eGHpqQoPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fwbCcWe/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FTrD003638
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 04:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=HbXgG/TmBKSw+IXuoLF5GYrDORjh7XXFpRj
	JBGBbqBY=; b=fwbCcWe/EaVNea0TwJkhoPFD/mvahaOzuhnVwFm08a+0oj2HvWh
	SAodIjdVYwV4s6Y8d1zs52W3aTCrt5WmnIKccPl+rNC4ydWCaN4AJSDQ3lczvU/S
	RLpQjul03WiUhSAyFJL6tuNZeEpJe9mTy68tYrln4Ghi5jnei5qH6ZdNw50V5tpZ
	2AV4nAAWYyCUZBuohL8GyBKfb3GI70eB+OfwhclR/yxMNsJpNLmkbhNz6U0OyUvX
	CTKyEEG6SC/OYvdob1G8pQgQm1JKX0WDmP4MsdyoELDq16ERaQhAZZYuaH8pwkBY
	z9t2FIAm2CZFXGyk6H/QRuHyUxBpiyDygTg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2geasg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 04:36:58 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6cf50cbd2cso1238781a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 21:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761280617; x=1761885417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbXgG/TmBKSw+IXuoLF5GYrDORjh7XXFpRjJBGBbqBY=;
        b=umKrayf00q39t/Btl4BKcQuVHof0a8PmfEPWpzHmRf6iErJKmjERALYuM0Jux5bKR9
         mO5bOzxmQX2VKN06TI5ZgFaL5L85hS3yrEwuoTui8FObrHOiOOXtvcXDCY+d6mmbe8+o
         ssYHJduAGP6pXO5OTWc95N3xg2dTNyIwW2plwtdatZhRT0CREpIIDVBp7kIehlMKX8lZ
         ln49Z7yyXfPmA6Q2vl3y0wDWz3vcZtvA54dLXHIszEJ76uFtK8J0KhGFAQrwpNZhvMdv
         z2j5OoLGNLFST2ab+GEDu0t1sgi5mndkOTkrnzyF9i588p1gVCBH1yWBd48qv+G534Ng
         HMtg==
X-Gm-Message-State: AOJu0YyzpIi9l/zMyjSJbAY0+1K8ieNSoUsLrKvY3JTAbmd9pBOHF+nY
	Me3WlfloHBeqOKBPlhX2RrE+LTtJdIzHv+vcuCOfrMOaxqkuuyCt5Ikjcp7VabjJQ7gU8PLkljk
	oU7C2qNGmTMRAZUidlLSCniRkA7XFdi5mEn4bbmtybXEsZUGQhzKcfy1GSCJJcZdqINxo6II7d4
	oWqQ==
X-Gm-Gg: ASbGncvYl2NgVrfDvIDlLXuEiZ5YXBPDiIXzS+rQkxOQzt1M2eZPj5ekt1P5e//O51d
	9qLi42eTUWPiW7eOW7zSF546LsW9xIxmx0bC5Ss71SesTjlIt0ORew1W1VnISKTy+b7G1ZaAPIS
	L6Dn6s8YDlZBaQ05ML87k3zg3AWA24uiHL6P0CslqwcfONWBLbo0BMgt03sZlbcw5+a1Bd6pfqo
	IKz+fuQOnGVYiD2ERTUOxbb5jQz5UcbY9kDCJG1Ayc/TQyup2Brv4NMRCQKbbAgbu9mjtVC5cCv
	EFK2zDvb2f6dX2AHRGDz/PUHseutqDDDPJxLQRJgMZr+AROYkvrCgxr3cTSYW00Y9RQWhuqK8l0
	w1U3JsD2DhodZBwmBicDKYe/5B/4uEj7o6mrocZAqTfykbVIybYtPCdVvCRm4P09h7My0pkjkGR
	PeJfkJMOkD2wRGjdrR/YMn
X-Received: by 2002:a17:902:f688:b0:28d:c790:43d0 with SMTP id d9443c01a7336-2948ba0d566mr10755195ad.29.1761280616618;
        Thu, 23 Oct 2025 21:36:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0CFaqwWzBZ2M7ItIBkQEv+Rq6hH1iXb9SiXv2S86uZllktCCMFBhBB/gVl2VHELKsygwCCQ==
X-Received: by 2002:a17:902:f688:b0:28d:c790:43d0 with SMTP id d9443c01a7336-2948ba0d566mr10754945ad.29.1761280616072;
        Thu, 23 Oct 2025 21:36:56 -0700 (PDT)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfd050fsm40457485ad.62.2025.10.23.21.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 21:36:55 -0700 (PDT)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: mac80211: fix missing RX bitrate update for mesh forwarding path
Date: Fri, 24 Oct 2025 10:06:27 +0530
Message-Id: <20251024043627.1640447-1-sarika.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX4H8kTByqclqE
 01luBVnBZsT0y+XvdjIZotf63Zj+jKsWMdz4LiCrMTwHnDSh5LmBM6HrAet14YbsIL0MqHN4Nud
 d909fEXUGcHZmrYlW5KNOzTsYkeWWuEl/6e/wxmHLg3L28ZgJEBC20mKl2y1MKEgctBa7kcrE1v
 /DH7OUR0vGe0NT51FcxPN+Zn+g4N2VAvXpW0SHi4JOZr7z5GFy5qLteYomqrPZYSjc/2BfFUvJk
 05EbhJuStMKs83/5h4VV8VlJRjHjwHrDWA8WKdzesme9LprBAnTg1cslhvHTVx/7huT2GzuLnBX
 uSDlZ8p0k2j5v1ibN7QzShyXCk3JocDtIGu8FCOO1AqPAP4QYqYleEPbeEDEV7YkbM0oEhDL1JK
 eXwPquaMT4MsnKYkjcdFTS0k7rE25Q==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fb026a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=ORGBUgWhjCuPX_p6B_oA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: TeCGwMSmuJHTKgccUY1eJJzYBupDSKN3
X-Proofpoint-ORIG-GUID: TeCGwMSmuJHTKgccUY1eJJzYBupDSKN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

Currently, RX bitrate statistics are not updated for packets received
on the mesh forwarding path during fast RX processing. This results in
incomplete RX rate tracking in station dump outputs for mesh scenarios.

Update ieee80211_invoke_fast_rx() to record the RX rate using
sta_stats_encode_rate() and store it in the last_rate field of
ieee80211_sta_rx_stats when RX_QUEUED is returned from
ieee80211_rx_mesh_data(). This ensures that RX bitrate is properly
accounted for in both RSS and non-RSS paths.

Signed-off-by: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
---
 net/mac80211/rx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6af43dfefdd6..5a18389c1608 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4903,6 +4903,11 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 
 	/* after this point, don't punt to the slowpath! */
 
+	if (fast_rx->uses_rss)
+		stats = this_cpu_ptr(rx->link_sta->pcpu_rx_stats);
+	else
+		stats = &rx->link_sta->rx_stats;
+
 	if (rx->key && !(status->flag & RX_FLAG_MIC_STRIPPED) &&
 	    pskb_trim(skb, skb->len - fast_rx->icv_len))
 		goto drop;
@@ -4937,6 +4942,8 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	res = ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb);
 	switch (res) {
 	case RX_QUEUED:
+		stats->last_rx = jiffies;
+		stats->last_rate = sta_stats_encode_rate(status);
 		return true;
 	case RX_CONTINUE:
 		break;
@@ -4950,11 +4957,6 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
  drop:
 	dev_kfree_skb(skb);
 
-	if (fast_rx->uses_rss)
-		stats = this_cpu_ptr(rx->link_sta->pcpu_rx_stats);
-	else
-		stats = &rx->link_sta->rx_stats;
-
 	stats->dropped++;
 	return true;
 }

base-commit: 55db64ddd6a12c5157a61419a11a18fc727e8286
-- 
2.34.1


