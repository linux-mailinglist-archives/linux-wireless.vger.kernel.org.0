Return-Path: <linux-wireless+bounces-23728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72291ACE922
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 07:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A592173866
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 05:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0A19D07E;
	Thu,  5 Jun 2025 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jjExmvvT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A424B26
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 05:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749099849; cv=none; b=oO+5aF2Pw/iBZ7uifuGDgOidBu+zTsPh5W6XAy6aSmHXoAfyXtqxsnFtz8UgchXZPSvtzxPFW8VFJ0gXPM2K0+Bzio3xQ9YQZDISIGGTWj76C1XXpbq4BahPit4fMDfjpCZBTndzhSPhMwv8HP398dqfY9sunJXT5WSi3P+R12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749099849; c=relaxed/simple;
	bh=we7bg66PvbO8qEjX2VAzDTsmclsMY56SH9w4rtlVKgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MvRFxzqDWdK5WSKXjqwyhmo3Au0S4/h1u1l6a6UKeCpGHEfKVdiHSl5AcgIJ4b/5PnoGhgkjI5sBXawmR6ePqoZMXhMJEQhoa73nUK5VabJVGe87d9SQiK5FisyV9IIbpQx5YlJjvFWoytoKf/iPPdgZ61/uP+d82aW17MicKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jjExmvvT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554HEBWd027543
	for <linux-wireless@vger.kernel.org>; Thu, 5 Jun 2025 05:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=sX5qD6gyPEWF32QtSDMR7E/1T4f6HYVyEgp
	9L+B6/SE=; b=jjExmvvTXDsRuZmRmOASQayRYwQIy6fJK0gFFKa7D7Id4+gg8uQ
	9Vaukui+2Hi4E9/ajYG+Ajj86e57euadNke2WC4DC839/3PG8Ef8PgDU0Q9rnPbB
	Dbn7K7F4gPbISu4ob1yuAYtu+z9jsPMa/efETs9yoKXLWM5Ytusix2EzWGHmuCth
	L1k3N7tpZzQjuZS1Q7QAVgx7svQv6LTtZ9b1Q1uqtKg3TWipolun2fU+UAKkw+rB
	ZvB5zacJiy/FnhS9QDbPIPu7FXT0KyuEgXC+WI5uiN/J4VAGHkhyEYivd2IzefYd
	iw3qW8AcqizLE4ZQkDP0MdA4/G/G5/jAVsQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t848x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Jun 2025 05:04:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2355651d204so5395555ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 22:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749099836; x=1749704636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sX5qD6gyPEWF32QtSDMR7E/1T4f6HYVyEgp9L+B6/SE=;
        b=AxarxP0sL6R7u4MNMdRayRJpYl60r+xV8sTiD8cWeOxO34StCjSme53K1P6Evi29YX
         nfRHunYihZOF6XFMEGWs8Cq7u35irAr8Ds4LiEifeM/7a4SS+f1ghx0ktEwRppYt0jGZ
         3qaA+fUXti7aHxCSHPK3zLuLtXghvGGvNzNv3RTeVjcdwLG1W4KBsdTDWLPaC51YJOhA
         gwJdiTehPH5lgL4nJMu7vJwVxqodww8muCZspSuFlV8jk5Vhu9Sa+47hOjoLMU1CqLQF
         /vLD7eMs5KTmaR88sHGT1sdKi0PxsDK5TJbE6m1XOPwXI4osTKnMxs+4+RjCvu9XakNQ
         i9zw==
X-Gm-Message-State: AOJu0YwgZ5XzJhA0mcKAlltyWhLlgihUD8Dcdg7V4pg38VxCI+k/1qVJ
	HviNsvMYzy+zfpUnPaExDudshauICpCx/e0ELoG/d3ysUN9KK2ZfuMX/tPn1bwbNdu4z2VspTB0
	0y+rvbF1AUkNTRmBzh6v6ZOY2YufBV39Ua3sfzXLt5WTFZOQIomqwA6NYAD2CZpaS+sJUzZkKBW
	HM8w==
X-Gm-Gg: ASbGnctiFzDHWDQipqAL06+4YG2jWx1Mgu/dEqD2YZymCPvPZfTnYoC886SyRKmLkLy
	Up7goA6JwNP6GCEWmHZlcUxwqZzo8Q7Zz2zFjBsh6eBjF040DT3i8zIlnNFR5EjVJd1QS0bAVuG
	FYiNVuN5nYXox/7DVVosxz0GYSS4PXFQoC+NPJwAY1/jJ11XmcYHDB2kLi3P+U0bJy52aCDo/qd
	bbTcN8zBPYWNDJUTHSLY3zONyzspVW8VGAPgAMjIQAy1qLltLsljWnLiVq/2X0dsQa+7ETgEToP
	k3u0YZiEfCEZTEhq2TCeluytOOWgCBt1fNJoSYHpdgulvI3yFipCrW8DKl3gzkkgs7hfHxvUXrg
	MXhTMbeNHuaEi0Nf9RLxLM97pqX6jBQ==
X-Received: by 2002:a17:903:1245:b0:235:2e0:ab8 with SMTP id d9443c01a7336-235e111f2edmr64256695ad.6.1749099836042;
        Wed, 04 Jun 2025 22:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmOhn7HowKVgRR38Ows7HbGLwK8NasZwHVY4O0MdR3/Zh1Vyq2eb54sN3MiL+8NIRRAXjEUw==
X-Received: by 2002:a17:903:1245:b0:235:2e0:ab8 with SMTP id d9443c01a7336-235e111f2edmr64256375ad.6.1749099835682;
        Wed, 04 Jun 2025 22:03:55 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506be23c1sm111842045ad.78.2025.06.04.22.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 22:03:55 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: set RX_FLAG_SKIP_MONITOR in WBM error path
Date: Thu,  5 Jun 2025 10:31:35 +0530
Message-Id: <20250605050135.1802902-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eJQTjGp1 c=1 sm=1 tr=0 ts=68412544 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=iJxYE32BEC57r-YmU5AA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: c1cH1rXQ7I56hr-bnYou8gdECaEOzhaO
X-Proofpoint-GUID: c1cH1rXQ7I56hr-bnYou8gdECaEOzhaO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA0MiBTYWx0ZWRfX4rNXIsP4I3ES
 4M2SFip3FP8PvNJhV/BDEAvjivbQ+hDGskXSLKZd9s3Lw8u8hmsCCmSTXRwwluDr/dS7hZuAAOG
 JzGYyNiTT8hnJp6+1TDTPjAMisz2196Uh9qW8wxHeCE52DcbjwGSKMF/D5qWVI+6xq39f69+jS8
 C9KPYeLiBBSEoGzOWfSL33lQKbc2SIBHWJ7TbvcZN7j/ok+emKFiBxYcG+Il6OFapo25d1n/QhV
 Z49jHr/w+88WgB7j6Qp/u/DwnIypxLJZClKbnHQo/OQywY+911ceCzhssK1mCgKz2Tw5c/IJW0g
 bHNmz3SqfX1wry2ejt85FPsBFz7+79tVDuXxN8VeEXH36B8NuOc+rgO6kggT9ubJu4bX34tbhNg
 +Ot8hAwALp642MT9rN3SPl8ndMTZIaD///07/0bbcIX29s205od8MBlzlAEC0NzjcIptU0jU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=982 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050042

Packets delivered to mac80211 from the WBM error path currently do not
have the RX_FLAG_SKIP_MONITOR flag set in status->flag. As a result,
mac80211 performs unnecessary monitor mode checks on each packet, even
though these packets are not intended for monitor mode processing.
In regular rx path, this flag is explicitly set to avoid such overhead.
Align the WBM error path behavior by setting RX_FLAG_SKIP_MONITOR to
prevent redundant per-packet checks in mac80211.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 7e1a8f29c7b6..2bf1fa9c83b0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -4007,6 +4007,8 @@ static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
 		return;
 	}
 
+	rx_info.rx_status->flag |= RX_FLAG_SKIP_MONITOR;
+
 	ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_info);
 }
 

base-commit: 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21
-- 
2.34.1


