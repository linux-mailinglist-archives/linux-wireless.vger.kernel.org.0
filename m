Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825C1455F8C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhKRPeA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 10:34:00 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:26687 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhKRPdy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 10:33:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637249449; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=l1loVmW1RjXrsW56hTFBKN42k0XbXDloDMuDK0Tg1ks=; b=Qpkz80jDC9BKDIalCayd0f+nxuK+lNcPRolqqofOiDURnKerx69aeAZKKxD8GgdUOLbJJrlr
 JgASUPctAcvKQlELqN0uTLqZLvY2EMLj+tQunT0IYv8325lJL33nQH7z4o7D2bZPUBpdLAjp
 MK3EoQW10a80xEwGpSfq4VPoF3I=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 619671a4638a2f4d613df939 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Nov 2021 15:30:44
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D2CD0C43619; Thu, 18 Nov 2021 15:30:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0DD6EC43460;
        Thu, 18 Nov 2021 15:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0DD6EC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH] ath11k: Fix mon status ring rx tlv processing
Date:   Thu, 18 Nov 2021 21:00:33 +0530
Message-Id: <1637249433-10316-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In HE monitor capture, HAL_TLV_STATUS_PPDU_DONE is received
on processing multiple skb. Do not clear the ppdu_info
till the HAL_TLV_STATUS_PPDU_DONE is received.

This fixes below warning and packet drops in monitor mode.
 "Rate marked as an HE rate but data is invalid: MCS: 6, NSS: 0"
 WARNING: at
 PC is at ieee80211_rx_napi+0x624/0x840 [mac80211]

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01693-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index c5320847b80a..f7968aefaabc 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3064,10 +3064,10 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 	if (!num_buffs_reaped)
 		goto exit;
 
-	while ((skb = __skb_dequeue(&skb_list))) {
-		memset(&ppdu_info, 0, sizeof(ppdu_info));
-		ppdu_info.peer_id = HAL_INVALID_PEERID;
+	memset(&ppdu_info, 0, sizeof(ppdu_info));
+	ppdu_info.peer_id = HAL_INVALID_PEERID;
 
+	while ((skb = __skb_dequeue(&skb_list))) {
 		if (ath11k_debugfs_is_pktlog_lite_mode_enabled(ar)) {
 			log_type = ATH11K_PKTLOG_TYPE_LITE_RX;
 			rx_buf_sz = DP_RX_BUFFER_SIZE_LITE;
@@ -3095,10 +3095,7 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 			ath11k_dbg(ab, ATH11K_DBG_DATA,
 				   "failed to find the peer with peer_id %d\n",
 				   ppdu_info.peer_id);
-			spin_unlock_bh(&ab->base_lock);
-			rcu_read_unlock();
-			dev_kfree_skb_any(skb);
-			continue;
+			goto next_skb;
 		}
 
 		arsta = (struct ath11k_sta *)peer->sta->drv_priv;
@@ -3107,10 +3104,13 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		if (ath11k_debugfs_is_pktlog_peer_valid(ar, peer->addr))
 			trace_ath11k_htt_rxdesc(ar, skb->data, log_type, rx_buf_sz);
 
+next_skb:
 		spin_unlock_bh(&ab->base_lock);
 		rcu_read_unlock();
 
 		dev_kfree_skb_any(skb);
+		memset(&ppdu_info, 0, sizeof(ppdu_info));
+		ppdu_info.peer_id = HAL_INVALID_PEERID;
 	}
 exit:
 	return num_buffs_reaped;
-- 
2.7.4

