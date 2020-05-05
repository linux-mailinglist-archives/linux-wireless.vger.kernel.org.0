Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA71D1C4B83
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 03:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgEEB14 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 21:27:56 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:34459 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726516AbgEEB14 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 21:27:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588642075; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GYSaXza1LZAix+M2M6XPoWGbGirsGfyhkv5RBLqTrxc=; b=I1bqZ2jaSmNd/jzZ27TUqtTxqhao8lHs7kOTiugsaHnJsALGLfB5PFS7mNInF5+vDQyNtIqZ
 TWRSdkDjt5F2D4ygJP32+N2nU/k2DlWUVhIUM0jNxrKDjnyk7oMail/4GrrmwAwTTzXQY6sS
 wZCPQDcZkoGmPJfaGV3ep/VpjnU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb0c116.7fe699a4d3e8-smtp-out-n01;
 Tue, 05 May 2020 01:27:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 23533C433BA; Tue,  5 May 2020 01:27:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66CF1C433CB;
        Tue,  5 May 2020 01:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66CF1C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Miles Hu <milehu@codeaurora.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH] ath11k: remove stale monitor status descriptor
Date:   Mon,  4 May 2020 18:27:43 -0700
Message-Id: <1588642063-6950-1-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miles Hu <milehu@codeaurora.org>

The driver is not handling monitor status descriptor whenever
the done bit of status descriptor is not set by hardware. This leave
a stale entry in monitor status ring and flooding warning message.
Fix that by removing the descriptor and move forward to next one
in monitor status ring.

Co-developed-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
Signed-off-by: Miles Hu <milehu@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 47ad3bd9e1c6..27d17b8db662 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2722,7 +2722,7 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 				ath11k_warn(ab, "rx monitor status with invalid buf_id %d\n",
 					    buf_id);
 				spin_unlock_bh(&rx_ring->idr_lock);
-				continue;
+				goto move_next;
 			}
 
 			idr_remove(&rx_ring->bufs_idr, buf_id);
@@ -2741,13 +2741,16 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 			tlv = (struct hal_tlv_hdr *)skb->data;
 			if (FIELD_GET(HAL_TLV_HDR_TAG, tlv->tl) !=
 					HAL_RX_STATUS_BUFFER_DONE) {
-				ath11k_hal_srng_src_get_next_entry(ab, srng);
-				continue;
+				ath11k_warn(ab, "mon status DONE not set %lx\n",
+					    FIELD_GET(HAL_TLV_HDR_TAG,
+						      tlv->tl));
+				dev_kfree_skb_any(skb);
+				goto move_next;
 			}
 
 			__skb_queue_tail(skb_list, skb);
 		}
-
+move_next:
 		skb = ath11k_dp_rx_alloc_mon_status_buf(ab, rx_ring,
 							&buf_id, GFP_ATOMIC);
 
-- 
2.7.4
