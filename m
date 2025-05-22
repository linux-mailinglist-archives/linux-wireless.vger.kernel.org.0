Return-Path: <linux-wireless+bounces-23308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A950CAC0B5C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 14:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169137AE4C6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 12:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3948C28A70A;
	Thu, 22 May 2025 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XsXq3n1c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA0289E35
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915802; cv=none; b=flkfuMUK/8sP5HkBW7wLrtTqwjxh9EktMz8o2/uEvFK2VJuYABS0CBj3II2t+3TjplofGR3rJ3bonBExLCRFzL6vytEF4rjLx9ZclD0TFX7e1ELLJcm0fKiCgento0DhoQ3V+FCR7KKkUn4ClfiwVd6gPt/vtj5dokNKKSy0KTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915802; c=relaxed/simple;
	bh=vdpLvPa4DdIrSlqr2RfkcA2HLo8qaEdoi6QsXkxVwro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VvF4U6nohPkjuXcCM+9TeogKkFDs9Q194fBqFRMTA6A3fuhx23FaEXmxhlbglldf1/s+x29coGBxKCCeUyN3EbZkBd0wHt+nYMGgJqZaSOnlHOIP0yJUMCCsSE8cD49HGTlksdrj6pxYJTLKqD5nxyOwqcCcyNHRKG3hzn8e/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XsXq3n1c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M86Ak0024983
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 12:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uyNt/sGsuh4XmreLRg9Ey2fKbNrRvAZ0N+H
	8+xGYyLM=; b=XsXq3n1crRGCcoXxLKR69OsEkQqaPb7J9rItUxkG7jW48iq5fOF
	UMG3HjOzSFiBkNhkcior+hfhAUmQ4xpjV3dg7UQUxFguFjiP7+x2637soAqR28vS
	Z6PLwgD6nohn/0siJIz5lHPlvo0Wv1r9ipsKuPY16kasLEJqfKe/bmKyKSfBWSsq
	Ywjekhpy6YvG5Jq4FnoGRso3NnWuDWkG0syNhgW1yjnAU09XrK5Uoq5+4ZwPydXS
	jhkjGXhX9puE7EhAkZnoDAntAmZhYV2t4yLr22Z23UqF/CxjCfKL0v8LcWXEdQW1
	UnH6Wcj89dqaKWLYBCK7vZGPp/eKB8DJoaA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4x6tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 12:09:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4769a1db721so185045891cf.3
        for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 05:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747915798; x=1748520598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyNt/sGsuh4XmreLRg9Ey2fKbNrRvAZ0N+H8+xGYyLM=;
        b=hbWgrAhQt3HQpRGWyrSWaoDMWVQqXWMiD+KQJprGQLu6NBaZEFP1uR5J6Kx3sB1sRi
         tkybCPIYekjssodTfrl5pLiUUCJdtKxyjjPJHwgSeVVHu0/+hMMOPXm3E14DmtCm+dlE
         3BZG/1R1gGrvDIS3bb0/ent/LCYPu+b+L/GTPaVsjA+m+N0To7ncihqecKCO5hfnHcr7
         D3l7uO6QVahukOmB/pBE4ETWMrz4HdQxZOjfPHVsDQVXFlhaQ0T9jkbG4cgXN71ytNY6
         UF1y16DlxDyKnDD/w+KFKOFOAu7/1M6v8kdvOqZ3XTsnl1gizU0qQT4N/Pgte/vftVYf
         4BoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtIW2LYoysOvj9GYCgxwzDTBX76wJ/w0EFj4Sr5SKgSpOMxUXWGwtBuPG5hyH3oA6rUniCt+VX06YMSJ89Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2tWyMu6vq0wyfCvgBGfI7Th/9fyMWHYY48PoYp87JZBKbTHV
	nc2U2VhvlibIgesNe5HbUAOnerfsRvLqchL5bMEtTpjGdVQlxxgc67P+LBA70ROKX/L3mfQSA2v
	eaKDLrG5WYIb7dig7LbLDsWN/GT9eXvdKjb4n9YG6hpKlK+562MBD03/JDZLEyUJ5yxJ61w==
X-Gm-Gg: ASbGncvGzzFtj3UJjcPfprD/1uZEV/LxgSoCoWSfox8OAnzs1Wl4GeLgX3JDqojC1/C
	MtuVj8NnYoySxgg64G1sOzP1VoglcsCB3W313eOYnFsaiUP/urx168bAuOVsI3wOlpvsul2IMt4
	Nplvs3P13snTsugD6XMSw2jMN/kmw3KyztsO7OM12Ssb9XiMDpNzdGsKgiOASKShslIK7EwT1xZ
	CH9dFBZU1XDQt/0lzRKJfqUZUWPL6Sq4OeSbG+Mc1Nwyrs5CBnxtcNU1a3Xl8zsSpCuPpBrUKR/
	sxca4BjCfvy27ZgLAEBOFl7qV7QdMiJ89eJXno5Jn5SJQao=
X-Received: by 2002:a05:622a:4d99:b0:474:e75e:fccc with SMTP id d75a77b69052e-494b09365fcmr402457791cf.35.1747915797961;
        Thu, 22 May 2025 05:09:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAn3tchLVOZhxfq6SRKcs3/R+CiOHJ02G89e2dun7MvAPb41vaKHUcUKztCzIq8nhPcsDS5A==
X-Received: by 2002:a05:622a:4d99:b0:474:e75e:fccc with SMTP id d75a77b69052e-494b09365fcmr402457301cf.35.1747915797488;
        Thu, 22 May 2025 05:09:57 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:e5bc:5c94:e4b3:3c4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a36a83b63bsm17102665f8f.97.2025.05.22.05.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 05:09:56 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: kvalo@kernel.org, quic_svishnoi@quicinc.com, quic_pillair@quicinc.com,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH] wifi: ath10k: Fix unbalanced IRQ enabling
Date: Thu, 22 May 2025 14:09:54 +0200
Message-Id: <20250522120954.605722-1-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8IQhDrkddGdXZ2Ha8sZalpjPTPpP2XXy
X-Proofpoint-ORIG-GUID: 8IQhDrkddGdXZ2Ha8sZalpjPTPpP2XXy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEyMyBTYWx0ZWRfX6f/YZrvKVKnL
 p/GyQDzfHsQeUqyUNPMjJOXo4iacpvogtTUKLardf2aL2+o52yQVK38H2+EHsZTuz6FRCYXM71h
 ecTmBmK9tBvy8gx+9KMUPkU7mM0Bk+S9LxkpTsU8NoLkIzYggefrGvDXtj9ynhXQJnlPuLiUq+m
 Je0Mr/QGrTHqZA+qBIJ46GllNVvXjflQ3fbdjQVTHncNescXiDPegDtX++GZfho7mTOLz43Bynk
 3SeCtVhh68AjTMiInwGIU+IArJ6cKPTJWHOhj6hcaDMceFcF45q0+223vqH3wnP00esDe7rJFXl
 Mb/+/SSSw1WflIPaDmtjV6qxjOTPwATDLo5PjzodybxEr2wVOcOea/j9fVA/LuMWa0IHcicsQlT
 M6mFF0747dM4f0CTTOxTboKTEQrqbK3bYGrTe1/cW6BRahj6pwWrRRzqDYbVL37+kItRRHkm
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682f1417 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=EUspDBNiAAAA:8 a=OyT9LloaJ-PC7jRUisgA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=514 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220123

When the firmware goes down, both RECOVERY and CRASH_FLUSH flags are set,
triggering a full recovery sequence once the firmware is back up. This
includes stopping and restarting the SNOC interface.

However, this sequence leads to an Unbalanced IRQ warning:

------------[ cut here ]------------
Unbalanced enable for IRQ 112
WARNING: CPU: 2 PID: 120 at kernel/irq/manage.c:792 __enable_irq+0x4c/0x7c
CPU: 2 UID: 0 PID: 120 Comm: kworker/2:4 Not tainted [...] #234 PREEMPT
Hardware name: Qualcomm Technologies, Inc. Robotics RB1 (DT)
Workqueue: events_freezable ieee80211_restart_work
pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __enable_irq+0x4c/0x7c
lr : __enable_irq+0x4c/0x7c
sp : ffff800081b3bab0
[...]
Call trace:
 __enable_irq+0x4c/0x7c (P)
 enable_irq+0x48/0x9c
 ath10k_snoc_hif_start+0x6c/0x13c
 ath10k_core_start+0x360/0x1344
 ath10k_start+0x100/0x8fc
 drv_start+0x34/0x58
 ieee80211_reconfig+0xf4/0xfc0
 ieee80211_restart_work+0x110/0x17c
 process_one_work+0x150/0x294
 worker_thread+0x2dc/0x3dc
 kthread+0x130/0x204
 ret_from_fork+0x10/0x20
---

This can be reproduced by restarting rmtfs or triggering remoteproc restart
via sysfs.

The root cause is that IRQs are not disabled during SNOC stop in recovery
scenarios, but are unconditionally re-enabled during SNOC start, leading to
an imbalance.

Fix this by skipping IRQ re-enablement in `ath10k_snoc_hif_start()` if a
firmware recovery is in progress, restoring IRQ state symmetry.

Fixes: 0e622f67e041 ("ath10k: add support for WCN3990 firmware crash recovery")
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 866bad2db334..e15e1ab30458 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -937,7 +937,8 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	dev_set_threaded(ar->napi_dev, true);
 	ath10k_core_napi_enable(ar);
-	ath10k_snoc_irq_enable(ar);
+	if (!test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
+		ath10k_snoc_irq_enable(ar);
 	ath10k_snoc_rx_post(ar);
 
 	clear_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags);
-- 
2.34.1


