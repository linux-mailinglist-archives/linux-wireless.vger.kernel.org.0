Return-Path: <linux-wireless+bounces-21773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A92A94B0C
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4517A71F2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77711E98EA;
	Mon, 21 Apr 2025 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ngWAxCRx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CAD44C63
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202940; cv=none; b=rORYnauWK7C8sLTaJE5U6YNPIZz71BtjIh/yDt/9smGFKvYOWP8PQ0PxoELYUmRbak57pEERVAx4XhBE/Xe+lWzRjgFKauqdlQJmPd/gcb3fX7AR2+oTXl3S7UMcx/jmQzyh9GeQfyWg1+OywBp3WQmVXNyOlRGWpl0gmJHaY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202940; c=relaxed/simple;
	bh=FbQG37UzK5XB0vzPgovjxCGZbV56d8kL6EjLW9x0tSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h29gmal2IzQU+8/j5nDAOYFTwE8ECgovGQPfLUXFrDJoTTL7PdNHtd9waYi166VQJmWYt3umBFdSPsNgQF2Nl6zRbUzCpKfhXwJ81MZa358QFw6huJhYEwip2o0WQDlVpeVek9xuli82Oq6bXLph1veaR+kCMz3hed0OQYhrSLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ngWAxCRx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KMPAvW013841
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=F/0lxe84XJz
	nWjf2P/60iOZ5+OXxV9SomLFyZxivZLw=; b=ngWAxCRx7y3Rz8gIt2jo0FSPoY4
	QW2L6CAHnv/+iGl6L8F6ciBDRhoPgDCGcGJcAd6wCdbYnhe6Gj/fu+kYPEpzZhzY
	IpL7tpX8LK6PnK6xAkjC4o5A5NNrotsrKue20aHu87WFYWWZZZ4dqOF612xh3KVr
	6lXMUTn8gExsz3gQ1vEYn4XlXW50L7fPkoGZ6edM5wgNOtiQg7wQ/e0fG6jSjWKk
	gzIrz2mdA9iUUH7kXrDQ4Dpu9+xg8PF6ZfO87iYdAN+K+tXyO9rEtcmiw9XLwwCC
	Iiy9beR7PFUZobGVpK4j0Kr/Z6Hx7TJT14b3jiDPfvL8K6a6lsz2AqGZTHQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46454bjpu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-227a8cdd272so30310575ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202937; x=1745807737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/0lxe84XJznWjf2P/60iOZ5+OXxV9SomLFyZxivZLw=;
        b=AaOujB3tO6mPbTJN6bcPoWLaTqmoE9yCKOgFWXd++P/r0TYW7xphkkgnn7WLrR1FQH
         lVOLcXKannWNQx5w8V8dA1fTQqNd6CZ257gYQeMUDXvQ8xGoXhxgvNraKfJ5ZQpRfLS6
         mXXq6AsZl/YmezArCBWarDo3AYtDcm+30udQcXfMmng6AP7hSux+v00iM8J9ftFssHs7
         rlTwyokokGdPCGqkuJKv5bjIfLuoLhqRhRdraKWZ7G7tvbodchNJeOTnqImFKUaWX8+h
         kWwj2sSzgDmjKIIDp/0oOdR8qghZrT5aRjUW4ZBYU3iBGB0DpW4haPdTlD6Q8DKt+cPo
         oV2g==
X-Gm-Message-State: AOJu0YwO/IoYG4GMwNOWcURigpEs4kTh8UbKa5TSoccma32RDNugZp5z
	zy/muqXhBfH7iCCCfaNOBdKV9C0zE2zU3T1Dc/Dq/rPIY+ttDZ7Ki+66U8SARElbLzc+M59rdSi
	sEL0nslPmBqFuFcdtBBURBBM68g31iXM/n6onjoxiXn5GnJ9jGLLWU7Zg5XXikoCi+Tn85CGdVd
	M8
X-Gm-Gg: ASbGncu/9MfqRjxuxvtzinmYQTj4/PP890E2KUM90E76MUlWgXt/Ik6ADDfLRfpa1nH
	146P942ILteUVdVU1dxAfP1bKoS73eKIZqhIJrJgSyv69GMDThjOrbIPzVVnhAvXfbZI+2k8/ix
	3QcOlF1NY+PKGMUISpp8xgEDSYQB1EH17W71UmVkBH8RuwJJPJglXzDThWF6y/j9/znDEhWB6kC
	DDhUo8T3rZS12t/kM/MgSTVMA2VI78OdV9CKKPI20sPiykKa4icFP0VpeZxN6gA+vGTwvTvVaHR
	njANhrd0bbROptiUa4t0z6grCTHTHj8DcQeg5nXMZpTd/7ymhD98h7p7dZkPHSN6NQ/RrD1guTz
	F6fPgUB6pe6Q=
X-Received: by 2002:a17:903:98c:b0:224:1780:c1ec with SMTP id d9443c01a7336-22c5360dc12mr180997535ad.35.1745202936758;
        Sun, 20 Apr 2025 19:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq65mC6OoIEizuH+antbg5u43zDy2K9uh6Jfs02F6+tCcXiuhMp7miRMqAwHqfSQiJRlO/Vw==
X-Received: by 2002:a17:903:98c:b0:224:1780:c1ec with SMTP id d9443c01a7336-22c5360dc12mr180997315ad.35.1745202936404;
        Sun, 20 Apr 2025 19:35:36 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:36 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 11/13] wifi: ath12k: init monitor parameters for WCN7850
Date: Mon, 21 Apr 2025 10:34:42 +0800
Message-Id: <20250421023444.1778-12-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cdrSrmDM c=1 sm=1 tr=0 ts=6805aef9 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=qa2sE8eil9VosqwbHagA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: WIWeJwv0tFwgExgrm1bbd2CXNPBXU7Xc
X-Proofpoint-GUID: WIWeJwv0tFwgExgrm1bbd2CXNPBXU7Xc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=969 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210018

Some monitor parameters are only initialized for QCN9274, but WCN7850
also needs them, so initialize them for WCN7850 as well.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index b3f638af1717..828ed55f83f5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -4606,17 +4606,15 @@ int ath12k_dp_rx_pdev_mon_attach(struct ath12k *ar)
 		return ret;
 	}
 
-	/* if rxdma1_enable is false, no need to setup
-	 * rxdma_mon_desc_ring.
-	 */
+	pmon->mon_last_linkdesc_paddr = 0;
+	pmon->mon_last_buf_cookie = DP_RX_DESC_COOKIE_MAX + 1;
+	spin_lock_init(&pmon->mon_lock);
+
 	if (!ar->ab->hw_params->rxdma1_enable)
 		return 0;
 
-	pmon->mon_last_linkdesc_paddr = 0;
-	pmon->mon_last_buf_cookie = DP_RX_DESC_COOKIE_MAX + 1;
 	INIT_LIST_HEAD(&pmon->dp_rx_mon_mpdu_list);
 	pmon->mon_mpdu = NULL;
-	spin_lock_init(&pmon->mon_lock);
 
 	return 0;
 }
-- 
2.34.1


