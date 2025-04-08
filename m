Return-Path: <linux-wireless+bounces-21249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1DBA7F4CB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D3616AC49
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953FD2063DB;
	Tue,  8 Apr 2025 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lSiXy1CT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ABE33FE
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092839; cv=none; b=fo3H8TlyjBwZcNZNRCZZUty/RQQXKeTuAfc2bw5bpZG7s9AnCPNKYSSliGZ2kxT4UMLN6yKcOkaFVmXR7uDW9PpPMCzlXx84VcZKptWjBkmdeOswk4Og6QKKbQ4AGy5iutHeJ4xAqepwLFpKRwKGlNsr+NCO79YlLUDfn06SAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092839; c=relaxed/simple;
	bh=vTRGqAgB+gukNDjm5UFb6wjWdLmPU7XfpJUN/8uzwoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TpWmC6vq48PnEV0wHWMUw8zaWELQ6PTGAzLK6XKFr7XJwTc2TaR/7WtnzawIrCmpMZrIYuOofpvoIrDmI6Bv1LhauLB2DvmV3imGSMesSAGUWBwG8fYTs6FjZ0EMF2PQlyYj03F2P6EqUeRFJqYVlKGT3eumV8tsSfwneg/VhxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lSiXy1CT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GONT032623
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8/9KKlybY73Cq9H/djgojnh/GJRKoGH3oTb
	ztLqHc2I=; b=lSiXy1CTkgibVeIGQmcc+nNKs3loq8FXrRl67hQMejkN5O2/B5q
	j3KsqLo7oXkVHEMXnhl3sUrKakIkfZvX5Gs3FA5/9xMyjyGNSQnausn4tSZJuKZV
	0xaDs1KRqJelJ8Pg8VDwgdLb3iX22cwRZqbrreYocLzMfmt17xFew8vj8acr5WSR
	eiDN751mhc5lE5T16OEUHkAAPYfx344dqQW1joYxt+dnswomUKQnBqqin57sP63V
	vMi6lYwBYVzBEtvMvxu7fkmtn39CTLNbaK0Iju0kUTaVfHvJLMASv6y+LEvrmVUN
	2yVMER8RPulj5jT9B+7XqpcLxP3ASM0IG5A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfkekey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:13:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-af5329791f1so3870626a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092835; x=1744697635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/9KKlybY73Cq9H/djgojnh/GJRKoGH3oTbztLqHc2I=;
        b=t7anHbcJM3/Fy5oAt9XHSn5wTGmXUfp+NvdJW9a8JOw3exRiLd+gD0p4eUNdx5XjRl
         wY/pfSoT+LG9s9Qn57QAHT5Hvq2DUEqjeVGUog4ucqzmb/dTRKc4d/vtDqgsrDP4uBQ3
         ZycCWghVsCdXWBfqNObOnfIHQntX3mj/nGZACG17KW9cpQGzgaBueaPwnwKoMbfr+Zw/
         VH1d9IVlAuR/XGF5QdaYeBClCo1J38boIPC08/yEboJ4DjxtXPSKxvOzfFaXIGcaurKF
         6zwCW9WA0Pzu0GT0cQum/JEdg3RWKVOUc5yY2r6V4KF7qXEVupYOm3Ybo8SJJgvUd+Vo
         Mpvw==
X-Gm-Message-State: AOJu0Yweky1RTxo+X4KwuS16eoXywY2+ow6rLhQWMYmPjxj0s0r+4nL0
	gRsbQ3J7tFIXffdiS10ZLc9ZcNwRV7ES8DYaYklSN99zlv0gjr6O1mcJ2gOXpCjWh7TGE/q4S8D
	KCTb7ohYQjmDIUTrLeVCQ+QBU0lUrQXyTwGxuo5xMQQFEBjrUoJ095NpJffiEu79iSA==
X-Gm-Gg: ASbGncuxN3nNWt7Ac2PzsfuYm8AZWcJ+9MuDgw/QJukS0/sYnaP1hF2rc/W2QhR2+Cq
	Qm3yF8BY2ZT+uQin8xBqirIIsNA/MTAU+i+JNojnXONGIzDf+XjRRQuQ/caiyfLbUZYq9dx2iwL
	33hpt+nc/m2NZFa0yuhH4srBpOJQiGviqtB/X71q/ygphkVU+kWWYPMhug/JwWmVN1fNX9aaLo3
	VDbLCor30uy2myHKBOnaHRrYcb0Feo3puYUaVXFVLZPmpvgVV8fN6xPKlEz0G731/9LjCm/qMyM
	rL8K2v0V78mFKaPSRmXdAi4zKzpg/cowvYQxAUOJuL48SLxkDxk1DuMRw4ltW7h/Be69Por9q8k
	qNZa6OvHuVcBOClzKgEZeTkHLpalRMWSKPg==
X-Received: by 2002:a17:90b:51d1:b0:2fa:3174:e344 with SMTP id 98e67ed59e1d1-306d0d1d6afmr3204626a91.14.1744092835252;
        Mon, 07 Apr 2025 23:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHADd2iN49Q/pgPB5M2VZ4/dQ/gJ4REj1JRFF/Ov4z2SUraiFMqs8oUOS2HsGAhV+d59+yhLw==
X-Received: by 2002:a17:90b:51d1:b0:2fa:3174:e344 with SMTP id 98e67ed59e1d1-306d0d1d6afmr3204597a91.14.1744092834745;
        Mon, 07 Apr 2025 23:13:54 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb94f4esm10258444a91.46.2025.04.07.23.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:13:54 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v2 0/4] wifi: ath12k: Fix multicast memory leak in tx path
Date: Tue,  8 Apr 2025 11:43:39 +0530
Message-Id: <20250408061343.2774345-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QoNlv94XsYOmyCOzVle4zn6p5XCkNVGS
X-Proofpoint-ORIG-GUID: QoNlv94XsYOmyCOzVle4zn6p5XCkNVGS
X-Authority-Analysis: v=2.4 cv=b7Oy4sGx c=1 sm=1 tr=0 ts=67f4bea4 cx=c_pps a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=O8uiHmLsffw2fOifbccA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=662 bulkscore=1 lowpriorityscore=1
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080043

Address the memory leak caused by extended skb allocation observed during
multicast transmission in this series.

---
v2:
	- Rebased on top of TOT.
---

P Praneesh (4):
  wifi: ath12k: Handle error cases during extended skb allocation
  wifi: ath12k: Refactor tx descriptor handling in tx completion handler
  wifi: ath12k: Fix memory leak during extended skb allocation
  wifi: ath12k: Use skb->len for dma_unmap_single() length parameter

 drivers/net/wireless/ath/ath12k/dp.c    | 10 ++-
 drivers/net/wireless/ath/ath12k/dp.h    |  7 ++
 drivers/net/wireless/ath/ath12k/dp_tx.c | 87 ++++++++++++++-----------
 3 files changed, 64 insertions(+), 40 deletions(-)


base-commit: ac17b1211841c98a9b4c2900ba2a7f457c80cf90
-- 
2.34.1


