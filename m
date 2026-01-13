Return-Path: <linux-wireless+bounces-30727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 160BCD16BB3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 06:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 714F1300387C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 05:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD202BDC28;
	Tue, 13 Jan 2026 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RSPq7YFi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UWIEeoJg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C4299929
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768283203; cv=none; b=WaqGoYpYxaG/A7IdY34cDctzQOWcrg1Rt5K6oMCiMGDHi1oGQhUazxFKhv04bc7ExntCbwNMztwIqmLnQ4WLq9nooKjLj5E1Glnu8tSkFesfTxfdmSnuLrGAgftFp8Tt4DspYT3bWR21egUV1koEr+UEa/2mfldjA83/F8KwUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768283203; c=relaxed/simple;
	bh=h6sz1Pld1cJ7zUeN7soT/PQGFP6HVdPwMSi4SUbVNAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q6MnolG14V/rNQi0qvgHSSEawICm6wWSefk3f9nVUUyYGaK2+VFdJrZ948DjG5743Pyq4q0kCwwdEBXFLIggT5LQyGKOFnCfaKfgQuBo2bbkLZK2OcvTJ5IfaHZ55fVxRoc00nvigwKOObYAdcs2djxr8FrDaHX3jQ822oTei7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RSPq7YFi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UWIEeoJg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1tTj02751272
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 05:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tU/KRnYAILDO3dB1Azc+pM/mtMZvzE4x8ge
	T7Su0Pyk=; b=RSPq7YFi+FTwr53tcfFuJ4rsqH1chiruMjac53rht0M64cASezC
	BSi3q9a1OKC3cN0wtN+EZdGVg3xS0b7PEkyDzzrYfIhYzzat/62HUAZaKrEhVfUV
	HZmYyNIctBtlPZ0fz6yI+CM1VRP3g+08zx4N9e64scRCgQR34wpQDwbq+8TABvqa
	G520JrHwcwErVyF7jyHdzC+P+8f9hOddYLAPiZOcv7xP4jwnG6zLgErJMPm8NbPr
	vMC1cCvfAfRPpEKBqGTHz+oETJjY4ckHJXr5RTHpKrBNzZ/qQ5vRNZ2dJIKoLuHm
	eRxThcHphsljKwu8V5TdIo9grE3Wt+HJXsw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnctjrj41-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 05:46:41 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-11dd10b03c6so10599270c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 21:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768283200; x=1768888000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tU/KRnYAILDO3dB1Azc+pM/mtMZvzE4x8geT7Su0Pyk=;
        b=UWIEeoJgKse2qYoMBnMMkFgyLu+48Wy3j6+//WqocfiqxWNd1Dmr7Ic2kE4dze8+al
         xEnmrnDmvSjJBgxTALMgEdRXLHyHOvgJoluw6r4xO867eZzFyK/9OZu1oLIPys+4kc84
         zcAx2DW62BSzMobAsHI0MK4JGtVtVir9QyjZFfYCMEGr+Yc5CRWfU7NunORacKLc0N/p
         WajXEun3a1cQc2Zv/zyXUVBeGz3cNILVUt8IimVxoI/9zXl5DpJHKA5Qfh+8Qt5cgabj
         jwt6NIIFKzmj1opxlTckH87K7e6K7bHeJReXvh08Ky4gTQNMDJy+EJEuM1wRbdYob8Si
         gPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768283200; x=1768888000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tU/KRnYAILDO3dB1Azc+pM/mtMZvzE4x8geT7Su0Pyk=;
        b=LsyhujHdmaXhAFc1bgTtyzK/Su0ouQmmSXd8ZU4TR2R8xiEtn1mLMuXclux+N0ZxHX
         QDD+lAfpkjbjWh31Bfm2lXox7nkQVLS9YUedgIMNnOcwpzfKnNEbPgvq980veXSbFJFz
         UbCJRc84BSKuhD2leskHfCD+8OTtVwmunVK3kpsp78eW/AGEtJjggmusrw6o4BGnu4P/
         Wd6/Kfy7jjv1UlXktFjJt3YFl0qdwBbIKCJhnPqTbmD7O1JdReZ/baoNt580AHVTHyAL
         Nk3w8sN1j7ozHaoZJoDNdBxLGH3ww6XpgKH6kzgOc7k7dNIqxznH9B+aXKWsC/oht7pi
         TOAw==
X-Gm-Message-State: AOJu0YxhPwUSAsWRkDmhxDDEendd6GYgTEIESgDIazfzw69caPevBicR
	31f9bmpzAWeSL9Uwyxfum7OInBaup0+c2EL9MM8OTCgtMc2YV9pLIVvIugW78qXDID2BoK+RuAE
	lrM0EGHOqXux2ixmwrkXlzTYGhQ78OKpDA54rp6hrLKJw9qtiJBT02AxC73savtHyAylnmEB9uL
	3KYA==
X-Gm-Gg: AY/fxX7TZYpqZHmrzTNexB8AQ5QDszmlgCQzmJpAClsAnXVYEfIhHPUDWYeBtGNvOzb
	XMY++FWQqds7LZSC0zX5k3Ymr274A+jMtQKxxrJUc3VHOGMwxMkFoQnKOaDusBeSIAzpfSEGZm4
	EiOqkcBeD7HDVbFnqn52a9qXPgAonmm2075jDcstnvDDup1ZaPkSr4HwzCEvhRHHh0FOtmiU9B7
	yffyFn27VACeD7zAQz4+Y3mAAZBBWNq58NUvutdX92xbpP927FmnUxZHm5H1YqF7cxuG+qr61sM
	fPkCA/ugBJuXWd6UY/0z5kCq9UKtfKQcyD5hl37Fz6HzYKTr8mtex+XhmdJC0Stnf5F4Wou0ahl
	E2gE1d6qgqVRUPSD2A2LspZagQmm/xNIWj1L8HCtjjXoVXsXzFZuWx9m6O3cO4EmC
X-Received: by 2002:a05:7022:118:b0:11b:65e:f35 with SMTP id a92af1059eb24-121f8afc59emr17921980c88.7.1768283200301;
        Mon, 12 Jan 2026 21:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq/sH/GSbEemIBwDDxPWkUQ6BoWEy4MTQOBcAtcPuMD1IdoI3ztfh0bidQtJfCCH2UatIzAg==
X-Received: by 2002:a05:7022:118:b0:11b:65e:f35 with SMTP id a92af1059eb24-121f8afc59emr17921952c88.7.1768283199775;
        Mon, 12 Jan 2026 21:46:39 -0800 (PST)
Received: from hu-yintang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673bc0sm17879256eec.5.2026.01.12.21.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 21:46:39 -0800 (PST)
From: Yingying Tang <yingying.tang@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com,
        yingying.tang@oss.qualcomm.com
Subject: [PATCH ath-current] wifi: ath12k: Fix wrong P2P device link id issue
Date: Tue, 13 Jan 2026 13:46:36 +0800
Message-Id: <20260113054636.2620035-1-yingying.tang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA0NSBTYWx0ZWRfX/jLbfzqKIseo
 vVBu3Gt4t2jmr2mVIVX2sBXpCqv1dpYswxhLdRPnKWDnG73sUG/L8ISMie2AjMtvgKhBtoDGkTb
 V7J8E4JJKnxqO3PZdwZFGe1cvt0vvAUFPwE9N6PDlTwrQBkfLNJ9JTYP+zf2kqFkv7hU30EPaoT
 0lWQwmWnM4fz/7vG2s6I7qY76RUg+4phIhSIaD33bhhGabUxYL8DZx2hWi2mW5xL4m1CaywMP+D
 aMdx2cb/J//Tf2ux3imMz3RFBwcAsWc/kBcnk48cpMV/oWtlo3FQfsU6NX84TJMZxSqUd9HiA8j
 J1b3cAdBUaz7ltKjSjm9PYuW2nrj3uDEhd6w598b0nMP8CFRXhr45tMBw53/Jcyff4wMjF5pQKj
 lLBgyoOcAfKzI/fwIYnIsSReAduVURbfCpiQlJHobNQKRPPLAj2iqXIVeb3FRkKSJ+FXfG7lf4g
 8vNs1xSwN5WYKy5gpvQ==
X-Authority-Analysis: v=2.4 cv=Ls2fC3dc c=1 sm=1 tr=0 ts=6965dc41 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tX-LjxTrKDr3nCdR25UA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: pT2Bkc6N-G1gHSDHmYcR-Kw281kCfM3h
X-Proofpoint-GUID: pT2Bkc6N-G1gHSDHmYcR-Kw281kCfM3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130045

Wrong P2P device link id value of 0 was introduced in ath12k_mac_op_tx() by [1].

During the P2P negotiation process, there is only one scan vdev with link ID 15.
Currently, the device link ID is incorrectly set to 0 in ath12k_mac_op_tx()
during the P2P negotiation process, which leads to TX failures.

Set the correct P2P device link ID to 15 to fix the TX failure issue.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 648a121bafa3 ("wifi: ath12k: ath12k_mac_op_tx(): MLO support") # [1]
Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index db351c922018..32cdf6d73ac0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8838,7 +8838,10 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 			return;
 		}
 	} else {
-		link_id = 0;
+		if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
+			link_id = ATH12K_FIRST_SCAN_LINK;
+		else
+			link_id = 0;
 	}
 
 	arvif = rcu_dereference(ahvif->link[link_id]);
-- 
base-commit: d0309c054362a235077327b46f727bc48878a3bc


