Return-Path: <linux-wireless+bounces-21097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220DBA793ED
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 19:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9D71894F14
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008651A3156;
	Wed,  2 Apr 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JcZSo2g2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720A18A6DF
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615648; cv=none; b=ZrU/ujg8ciYzDS8a2eM6AUcHEJgfymFL9FRHXw+I6RjOvT3zKMkqyCUGabEfljGaOljvp2pnFAbIpwh2bFtxI5yxw9Oz2aeBpM8qVLjzezJMaO5tgQDImI8MYvlAKmLIVTl58d8vuBbV47GNo8ft5Yp5ViXC4KHHIiT3Up6e2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615648; c=relaxed/simple;
	bh=7IAP5GUJdrx54ROd6eRaHNotTVE7/jveimbOXexb6rY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iQJLJTctDTEqqbEpTyMVwGhxFZfqlgjRNHZWHCQ+1M878VPjVZQaykbkTZs7qAvW7kR7UamtzTa5aOYN4dZ2AkyofUrOrpnn8T2JUXbrY36LzwiU6RZt1yMCBYOcb5hmqRT/PaPz0ablM3q35lI8yjqKunxVIOcmkkopobAY1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JcZSo2g2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DCZPs012642
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 17:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JlKHU2/TUa9+D8iRdr1kav334eUDJN9+DsD
	dTgSyiy0=; b=JcZSo2g2gZIohGKfkFiiI/9h/mT72xJkTnVBxMdrg/1gayJsiMm
	EET2gd9Qm2/OaPbwvjaY17dL7Zf7TdqxWVM/DG/c9U1Cavw+vYDglj6WZgWpPUyW
	7J76xGpw3vsmSxQoDvVui2+0krvWZcEiOT18cpk9pROlOFGUZPmo8Ol91h3i1rQZ
	NhsQBw5sJZzLVFC9eTB0y7Qu/L8pYsAfvwA2yiodWuyze0aT5BL7XNqa7MoKL5O9
	B0YjwjZxsbaxtoL9bkt+NlDGH6kK/Fa2YdUIGK1GXKwaXND4LFJ5tUhY+DckBZsP
	mwjFZglOX6zKkBxQwN2KEHfPr4iBaIhay3Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rxbf25dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 17:40:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2264e5b2b7cso917725ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 10:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743615644; x=1744220444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlKHU2/TUa9+D8iRdr1kav334eUDJN9+DsDdTgSyiy0=;
        b=RqwhmfoSYCJKxfcXZOkbbiWN7IJJYi8vVeLyAGiLbxjNLarzqUksv1NyGe+gkQgqGD
         IJfqdlG25cE8h+X5DH9fzu2cQl9Jw6ONXnbNtitcF2s13QLB8jQVCYFDRFflKRz6bMTM
         RIYv0WQKwHG9d1QgBu4Q+VUG5UPFUONr5QiDEegicXYofMti+o5tLYBliITgv0cbVBv5
         dM/f6DiaqjJvxVrbXVjGR4ZBnZQE1AUg7rvxmidgUewXFfhXSBH36SE4BDvjcisKwCrj
         eyZFfxd+rsOE3WClXTMEwfoRRhkdgtPZZnXaamXOvNp9m+t7wAbrERJKA51IZTZiH7PF
         DWxw==
X-Gm-Message-State: AOJu0Yy++m7XUlJnwEFM43qhvIiLJ4I473ScKwrQpcwZm1K5W14R1/No
	28w/WOvh9tAmi+b+lE2j28FxOCTQyr/4Dh+G1jzrGaV6Yk2CCMNaTF/Stq7PU4njLrNCawV/K9z
	j99MUD0v138xL1x+cKez9QlulBAMSBihgu24zQ1GehgXqaKkSxf6iz21+e12abGsyTwm5s6CfAA
	==
X-Gm-Gg: ASbGncsrEApB0mUpX5rbvWk61PQ5OnaD2KqR5+2pnbxXK4Wnq5EkHGoxoLAZ9iTLb6M
	1x4ehJkMwhUP5HnTLSGREx/BAKsZX3tXA9xbLC4WCeCH5WMxE5cPQ4xcRvvNFm45RmLH5uX5FSi
	1oWJEdd+GHcdoA9IwQAYPsFOidyhqvL9sK9iRf5uObwKXCHwsiQgsU4Wyw/gJIhmcmnq/WGAO5/
	8BZaffQOO2vgs/oTtAEtE+RkgkYP3o2lDbkufpWkHkj0WGdZ5uPi+SOdMiKe3vbm5a5ie46GMVj
	K1jccBfBClwvnOCVXH3BXmsMfmSNmGmVJgaIbrQg2R/155cJZshByvGGP/kx6vinF0/J3+1Snq7
	O7XZd1aE3K1aiTZBLgOBT+rFwVzhSZZvk7g==
X-Received: by 2002:a17:902:da8b:b0:224:2a6d:55ae with SMTP id d9443c01a7336-2292fa028b9mr251921385ad.48.1743615643890;
        Wed, 02 Apr 2025 10:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbhl/rK4DR0thjK2YCbyuMDFzwjSnm9zjq9KVnDpPzHZ0Of6yFS1mesY18ojgTn5yM8dDcoQ==
X-Received: by 2002:a17:902:da8b:b0:224:2a6d:55ae with SMTP id d9443c01a7336-2292fa028b9mr251921095ad.48.1743615643459;
        Wed, 02 Apr 2025 10:40:43 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f7ccdsm111510425ad.239.2025.04.02.10.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 10:40:43 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath12k: Fix memory leak during vdev_id mismatch
Date: Wed,  2 Apr 2025 23:10:32 +0530
Message-Id: <20250402174032.2651221-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WTIZingoKqoDZUjgmFDZl-lLbBvP0llY
X-Proofpoint-ORIG-GUID: WTIZingoKqoDZUjgmFDZl-lLbBvP0llY
X-Authority-Analysis: v=2.4 cv=F/5XdrhN c=1 sm=1 tr=0 ts=67ed769d cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=G60vcV2tWwDvXW3nvSsA:9 a=RVmHIydaz68A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_07,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=1 mlxlogscore=999 phishscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 bulkscore=1 clxscore=1015 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020113

Currently driver enables vdev_id check as part of the bank configuration
in ath12k_dp_tx_get_vdev_bank_config(). This check ensures that the vdev_id
configured in the bank register aligns with the vdev_id in the packet's
address search table within the firmware. If there is a mismatch, the
firmware forwards the packet with the HTT status
HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH. Since driver does not
handle this vdev_id mismatch HTT status, the corresponding buffers are not
freed properly, causing a memory leak. Fix this issue by adding handling to
free the buffers when a vdev_id mismatch HTT status is encountered.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c    | 1 +
 drivers/net/wireless/ath/ath12k/hal_desc.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 29e2715024ce..b93669348f35 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -586,6 +586,7 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT:
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH:
 		ath12k_dp_tx_free_txbuf(ab, msdu, mac_id, tx_ring);
 		break;
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY:
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 3e8983b85de8..63d279fab322 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include "core.h"
 
@@ -1298,6 +1298,7 @@ enum hal_wbm_htt_tx_comp_status {
 	HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ,
 	HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT,
 	HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY,
+	HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH,
 	HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX,
 };
 
-- 
2.34.1


