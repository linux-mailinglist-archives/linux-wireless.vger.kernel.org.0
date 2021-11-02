Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE46E4426D7
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Nov 2021 06:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhKBFoU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Nov 2021 01:44:20 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46993 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbhKBFoT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Nov 2021 01:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635831705; x=1667367705;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=h/R3ybRNJOwRMKQUJ9PXBt3E9jGLPafBWDnsilxKGKI=;
  b=FuOmHN781Igw4NPijeHd6WZ2HkOnepv7XqO4zDRCtxzLvyVW6kE0mMq5
   0P1YyHulr8wGlYMmx3D1Jt2Oeqm2GeJCVEcG+5UecmaaNldj+U7OJEr9f
   yZ7jRem/6MxuMrAF6NzxKjjIbvc2cFGjyZKyyXBHZtEyawpVFcEU0ZIyD
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Nov 2021 22:41:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 22:41:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 1 Nov 2021 22:41:44 -0700
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 1 Nov 2021 22:41:42 -0700
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH] ath11k: use cache line aligned buffers for dbring
Date:   Tue, 2 Nov 2021 11:11:33 +0530
Message-ID: <1635831693-15962-1-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The DMA buffers of dbring which is used for spectral/cfr
starts at certain offset from original kmalloc() returned buffer.
This is not cache line aligned.
And also driver tries to access the data that is immediately before
this offset address (i.e. buff->paddr) after doing dma map.
This will cause cache line sharing issues and data corruption,
if CPU happen to write back cache after HW has dma'ed the data.

Fix this by mapping a cache line aligned buffer to dma.

Tested on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dbring.c | 16 ++++++++++++----
 drivers/net/wireless/ath/ath11k/dbring.h |  2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index fd98ba5..de220a1 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -87,17 +87,23 @@ static int ath11k_dbring_fill_bufs(struct ath11k *ar,
 	req_entries = min(num_free, ring->bufs_max);
 	num_remain = req_entries;
 	align = ring->buf_align;
-	size = sizeof(*buff) + ring->buf_sz + align - 1;
+	size = ring->buf_sz + align - 1;
 
 	while (num_remain > 0) {
-		buff = kzalloc(size, GFP_ATOMIC);
+		buff = kzalloc(sizeof(*buff), GFP_ATOMIC);
 		if (!buff)
 			break;
 
+		buff->payload = kzalloc(size, GFP_ATOMIC);
+		if (!buff->payload) {
+			kfree(buff);
+			break;
+		}
 		ret = ath11k_dbring_bufs_replenish(ar, ring, buff);
 		if (ret) {
 			ath11k_warn(ar->ab, "failed to replenish db ring num_remain %d req_ent %d\n",
 				    num_remain, req_entries);
+			kfree(buff->payload);
 			kfree(buff);
 			break;
 		}
@@ -282,7 +288,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 
 	srng = &ab->hal.srng_list[ring->refill_srng.ring_id];
 	num_entry = ev->fixed.num_buf_release_entry;
-	size = sizeof(*buff) + ring->buf_sz + ring->buf_align - 1;
+	size = ring->buf_sz + ring->buf_align - 1;
 	num_buff_reaped = 0;
 
 	spin_lock_bh(&srng->lock);
@@ -319,7 +325,8 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 			ring->handler(ar, &handler_data);
 		}
 
-		memset(buff, 0, size);
+		buff->paddr = 0;
+		memset(buff->payload, 0, size);
 		ath11k_dbring_bufs_replenish(ar, ring, buff);
 	}
 
@@ -346,6 +353,7 @@ void ath11k_dbring_buf_cleanup(struct ath11k *ar, struct ath11k_dbring *ring)
 		idr_remove(&ring->bufs_idr, buf_id);
 		dma_unmap_single(ar->ab->dev, buff->paddr,
 				 ring->buf_sz, DMA_FROM_DEVICE);
+		kfree(buff->payload);
 		kfree(buff);
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/dbring.h b/drivers/net/wireless/ath/ath11k/dbring.h
index f7fce9e..78a985f 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.h
+++ b/drivers/net/wireless/ath/ath11k/dbring.h
@@ -13,7 +13,7 @@
 
 struct ath11k_dbring_element {
 	dma_addr_t paddr;
-	u8 payload[0];
+	u8 *payload;
 };
 
 struct ath11k_dbring_data {
-- 
2.7.4

