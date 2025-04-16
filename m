Return-Path: <linux-wireless+bounces-21584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7A5A8AE1E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 04:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E2516950B
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B9A15667D;
	Wed, 16 Apr 2025 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hLFWih3O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BCB13AD05
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744770024; cv=none; b=JiQl/WlHqZaEDe0Hp31I9qSopWSTzaeeHfgByo728qtbLvamT5cWC3s6JmzFn+2Q68XbnsdVLRqHQb70dfQhbGe0Ihln0PFUyGDTg+xPsU66aN3eQj4yG2oXs5Jj5eBWc5IYQST7p3QMvRWcaAc1NrcqDwqm135rCvPqUjLcxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744770024; c=relaxed/simple;
	bh=0P/Nkznr5TKzV4Eg+HMHNgn6jOFsucsSCxScO3O4KLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GX4DnQKm++dyJ+0MniIyQo0aCM3U4VRIAd7mABf5bwZ93vB0X0Q3119Fj/GMLcK/0uWhiO9Wt0g/ZB8jO/X2FrTKrJQEiYFWBT2s18CcGehbN/CmpKgm6vxKYsb9kSt7g6SXtI1Q/IJD4jDJ7m4AJaHjA4Nt9Lw+oywwx7luEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hLFWih3O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FIKTtP025102
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=AfXajbpydkkqn6KmroTCxtpMxSUpK9CjRJO
	H4jhWQSg=; b=hLFWih3Oizc4muDeQHgxQUqm7C41jIM2WW6Vk01roQpcYYLJPC4
	7W+UMtqNoJwfnytYRShs7WBt8Myjo/H6JO1H0Mg+Go0g7e2vLcrs9G86Een3dOh0
	GRmQO/I/uvAn3jkDfR39w5lWtFnhD3zL2PmmJb3aazdqBqEf6pnLMbtOkVli1DLd
	opPeUcUw4Ex+Rsnb96lMVUpM1v7/JvuNgiBEr/3ix1sVXbu7m9o6yJydceZLxhpS
	I1uudNR+rPoNrqY85xfEMvx1WLO5bTjAZ3F7JP6GnUFMV9cgETqseAqjmR/rj3k2
	LLkAEaXJhKRAsi9/CXCv77KbR5kpGUi1F0Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wj16a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:20:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-229668c8659so45395445ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744770020; x=1745374820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfXajbpydkkqn6KmroTCxtpMxSUpK9CjRJOH4jhWQSg=;
        b=Xoevfj6fmuuy9GNx4rbA5gE440iZd5F3iVZWGhun8a7QQ6WHoIX18ILz0XRPqzcx1v
         TjWcVelqOJcs207BjG0WcnjZ0XvxFfGZy9gnJ77Jln9NYECs/+XaixYbJ0ymkifSVr00
         t/Qu+LmHQtpUvY5cJWSk1EmTBUzr5VVHNRtLG6fRDwdoxScXfbFaItUh4CC5kYoj61vT
         tmtf8T8bknFtSZHhHaG+aSTENb1qVXNdu3y9HMTs3iIpsHrKWxZSoLV8JUDL6gNsjZlo
         Umw3XyeNCGOLE3JqH3zLlOUrFhUvC2yA/4g9HYIfOzbWFBpByD5Su9vhhQA7U7/JxMpf
         sxSg==
X-Gm-Message-State: AOJu0YwwtbI0zXxf5Zs+MFH07LabthCfkK4F9Ue+1W6aKc8SQufW016J
	rTiEMdgBiO7Zs5bw7uH6GCy0KPN0YLhJO45GG1/zLVfk/v4Lo5qDFcCITpv/4caPKrQ652DJz8o
	hWxRH/6BM9P9rSIE9h8gMRexYKtA5DESbova+YppaLj1rZdQqdt1CVKu4Wx+icvkw/Q==
X-Gm-Gg: ASbGnctY4lcJ3itnZdDDnh/+KTEd/Lu1HNbgBNWu4qyJ9dWaIb94FdSgnmQ9kxL6Erm
	2cko8ZqfxMnxrvhA2aDFPDjA26x6BUMZhYo8WgCgKsTnvD8XWMcdvJLjBIoQYx2OlntDeLoYuMx
	eEZbpehQ9tSFNZDMhWhQpAtzadacr2k7975A96WKV0x8oRprLc7qk2YoZq2PwTxe3r2RiIT2WAo
	MGGTHwFiBY2/KWZFXC6FmOPF4/t4ly497zWyCsOPXwbO047p9iTNZDcLxBKe14IWJ8EM+OHhrVC
	ZcsghFue1CiOx1Bcv5bkLmL6kBi6YPj78oljvG8r/l1IM5xcZZJEcwaB9MD/vyjaw1ugbKWDq0x
	d0Z2wpzSX8Ag=
X-Received: by 2002:a17:903:298d:b0:215:acb3:3786 with SMTP id d9443c01a7336-22c358ddbd0mr1584775ad.19.1744770019865;
        Tue, 15 Apr 2025 19:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgC4lUWKu9DYRUYOZwzpEjtP9K+vh0OoS3CitKmD+eOkOO4yUg3rgp8efhJFURKvXNate7/A==
X-Received: by 2002:a17:903:298d:b0:215:acb3:3786 with SMTP id d9443c01a7336-22c358ddbd0mr1584455ad.19.1744770019463;
        Tue, 15 Apr 2025 19:20:19 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33faac7asm2501935ad.137.2025.04.15.19.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 19:20:19 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v7] wifi: ath12k: delete mon reap timer
Date: Wed, 16 Apr 2025 10:20:11 +0800
Message-Id: <20250416022011.1935-1-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=67ff13e5 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=al3BB8Ul8SHi2Q__pVwA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: R_XmHHp5dITrBgsECs7FBAJdxvfRkKjJ
X-Proofpoint-GUID: R_XmHHp5dITrBgsECs7FBAJdxvfRkKjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=775 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160017

Currently mon reap timer is not used, and it is not needed anymore for
WCN7850.

So remove related code.

This change does not affect QCN9274, as the mon reap timer is not used
for QCN9274.

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---

v7:
1. remove patch#1 and #2. 
2. mention QCN9274 in commit message.
3. rebase on tag: ath-202504141512.
4. change quic email to oss email.
v6: update copyright for each patch.
v5: rebase on tag: ath/main(ath-202412191756).
v4: rebase on tag: ath/main(ath-202410161539).
v3: rebase on tag: ath/main(ath-202410111606).
v2: rebase on tag: ath-202410072115.

---
 drivers/net/wireless/ath/ath12k/core.h |  2 --
 drivers/net/wireless/ath/ath12k/dp.c   | 28 --------------------------
 2 files changed, 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 44e02ebb1071..2d7d8610a058 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1056,8 +1056,6 @@ struct ath12k_base {
 	struct ath12k_dbring_cap *db_caps;
 	u32 num_db_cap;
 
-	struct timer_list mon_reap_timer;
-
 	struct completion htc_suspend;
 
 	u64 fw_soc_drop_count;
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index b8e63f489e7d..7d820349e7b6 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -982,11 +982,6 @@ void ath12k_dp_pdev_free(struct ath12k_base *ab)
 {
 	int i;
 
-	if (!ab->mon_reap_timer.function)
-		return;
-
-	timer_delete_sync(&ab->mon_reap_timer);
-
 	for (i = 0; i < ab->num_radios; i++)
 		ath12k_dp_rx_pdev_free(ab, i);
 }
@@ -1024,27 +1019,6 @@ void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab)
 		ab->hal_rx_ops->rx_desc_get_desc_size();
 }
 
-static void ath12k_dp_service_mon_ring(struct timer_list *t)
-{
-	struct ath12k_base *ab = from_timer(ab, t, mon_reap_timer);
-	int i;
-
-	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++)
-		ath12k_dp_mon_process_ring(ab, i, NULL, DP_MON_SERVICE_BUDGET,
-					   ATH12K_DP_RX_MONITOR_MODE);
-
-	mod_timer(&ab->mon_reap_timer, jiffies +
-		  msecs_to_jiffies(ATH12K_MON_TIMER_INTERVAL));
-}
-
-static void ath12k_dp_mon_reap_timer_init(struct ath12k_base *ab)
-{
-	if (ab->hw_params->rxdma1_enable)
-		return;
-
-	timer_setup(&ab->mon_reap_timer, ath12k_dp_service_mon_ring, 0);
-}
-
 int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
@@ -1055,8 +1029,6 @@ int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 	if (ret)
 		goto out;
 
-	ath12k_dp_mon_reap_timer_init(ab);
-
 	/* TODO: Per-pdev rx ring unlike tx ring which is mapped to different AC's */
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;

base-commit: b80c52642c1159c2596776b39b06eb1c2e36baff
-- 
2.34.1


