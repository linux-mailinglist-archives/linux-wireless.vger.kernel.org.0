Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F1929ACBB
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Oct 2020 14:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbgJ0NFN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Oct 2020 09:05:13 -0400
Received: from z5.mailgun.us ([104.130.96.5]:27809 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbgJ0NFN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Oct 2020 09:05:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603803911; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ULmo3j5OXw2sTBu3Gdgl1t11oxfoXfA9LuPfpNMwEvI=; b=kvloTJFzFHbkF5tgM35N8m1ezjRBo3e02iQ5II0pmkRwtAtRmsK1cmI8HpbdywBFNe4vEDXI
 dwcXyx17otSGjBupoo87GbnCerGq+8iJdPPMPND+EkOCPmSXYWJHmCZTZRI6cDyeY3Xg59DT
 Onpy2DsxxQgpjuJG6ff/RXUjxT0=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f981a3e2421c5ebfb4682f5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Oct 2020 13:01:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6AA52C433CB; Tue, 27 Oct 2020 13:01:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A53FC433CB;
        Tue, 27 Oct 2020 13:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A53FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: remove repeated words in comments and warnings
Date:   Tue, 27 Oct 2020 15:01:45 +0200
Message-Id: <1603803705-22447-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Found by latest checkpatch.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.c       | 2 +-
 drivers/net/wireless/ath/ath11k/dp.h       | 2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c    | 6 +++---
 drivers/net/wireless/ath/ath11k/hal_desc.h | 2 +-
 drivers/net/wireless/ath/ath11k/rx_desc.h  | 2 +-
 drivers/net/wireless/ath/ath11k/testmode.c | 4 ++--
 drivers/net/wireless/ath/ath11k/wmi.c      | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 59dd185a0cfc..f977056ae5e8 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -381,7 +381,7 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 					   HAL_WBM2SW_RELEASE, i, 0,
 					   DP_TX_COMP_RING_SIZE);
 		if (ret) {
-			ath11k_warn(ab, "failed to set up tcl_comp ring ring (%d) :%d\n",
+			ath11k_warn(ab, "failed to set up tcl_comp ring (%d) :%d\n",
 				    i, ret);
 			goto err;
 		}
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index ee8db812589b..d4fd02375fad 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -423,7 +423,7 @@ enum htt_srng_ring_id {
  *                     Used only by Consumer ring to generate ring_sw_int_p.
  *                     Ring entries low threshold water mark, that is used
  *                     in combination with the interrupt timer as well as
- *                     the the clearing of the level interrupt.
+ *                     the clearing of the level interrupt.
  *           b'16:18 - prefetch_timer_cfg:
  *                     Used only by Consumer ring to set timer mode to
  *                     support Application prefetch handling.
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 01625327eef7..571722baa0b3 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -377,7 +377,7 @@ static int ath11k_dp_rxdma_buf_ring_free(struct ath11k *ar,
 	spin_lock_bh(&rx_ring->idr_lock);
 	idr_for_each_entry(&rx_ring->bufs_idr, skb, buf_id) {
 		idr_remove(&rx_ring->bufs_idr, buf_id);
-		/* TODO: Understand where internal driver does this dma_unmap of
+		/* TODO: Understand where internal driver does this dma_unmap
 		 * of rxdma_buffer.
 		 */
 		dma_unmap_single(ar->ab->dev, ATH11K_SKB_RXCB(skb)->paddr,
@@ -399,7 +399,7 @@ static int ath11k_dp_rxdma_buf_ring_free(struct ath11k *ar,
 	spin_lock_bh(&rx_ring->idr_lock);
 	idr_for_each_entry(&rx_ring->bufs_idr, skb, buf_id) {
 		idr_remove(&rx_ring->bufs_idr, buf_id);
-		/* XXX: Understand where internal driver does this dma_unmap of
+		/* XXX: Understand where internal driver does this dma_unmap
 		 * of rxdma_buffer.
 		 */
 		dma_unmap_single(ar->ab->dev, ATH11K_SKB_RXCB(skb)->paddr,
@@ -960,7 +960,7 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 
 	rx_tid->ba_win_sz = ba_win_sz;
 
-	/* TODO: Optimize the memory allocation for qos tid based on the
+	/* TODO: Optimize the memory allocation for qos tid based on
 	 * the actual BA window size in REO tid update path.
 	 */
 	if (tid == HAL_DESC_REO_NON_QOS_TID)
diff --git a/drivers/net/wireless/ath/ath11k/hal_desc.h b/drivers/net/wireless/ath/ath11k/hal_desc.h
index 8a592814efa0..ceebdc28ddeb 100644
--- a/drivers/net/wireless/ath/ath11k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath11k/hal_desc.h
@@ -716,7 +716,7 @@ struct hal_reo_dest_ring {
  *
  * rx_msdu_info
  *		General information related to the MSDU that is passed
- *		on from RXDMA all the way to to the REO destination ring.
+ *		on from RXDMA all the way to the REO destination ring.
  *
  * queue_addr_lo
  *		Address (lower 32 bits) of the REO queue descriptor.
diff --git a/drivers/net/wireless/ath/ath11k/rx_desc.h b/drivers/net/wireless/ath/ath11k/rx_desc.h
index 1c4264637a41..86494da1069a 100644
--- a/drivers/net/wireless/ath/ath11k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath11k/rx_desc.h
@@ -170,7 +170,7 @@ struct rx_attention {
  *
  * ast_index_not_found
  *		Only valid when first_msdu is set. Indicates no AST matching
- *		entries within the the max search count.
+ *		entries within the max search count.
  *
  * ast_index_timeout
  *		Only valid when first_msdu is set. Indicates an unsuccessful
diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index d2dc9db01491..4bf1931adbaa 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -51,7 +51,7 @@ bool ath11k_tm_event_wmi(struct ath11k *ar, u32 cmd_id, struct sk_buff *skb)
 	ret = nla_put_u32(nl_skb, ATH11K_TM_ATTR_CMD, ATH11K_TM_CMD_WMI);
 	if (ret) {
 		ath11k_warn(ar->ab,
-			    "failed to to put testmode wmi event cmd attribute: %d\n",
+			    "failed to put testmode wmi event cmd attribute: %d\n",
 			    ret);
 		kfree_skb(nl_skb);
 		goto out;
@@ -60,7 +60,7 @@ bool ath11k_tm_event_wmi(struct ath11k *ar, u32 cmd_id, struct sk_buff *skb)
 	ret = nla_put_u32(nl_skb, ATH11K_TM_ATTR_WMI_CMDID, cmd_id);
 	if (ret) {
 		ath11k_warn(ar->ab,
-			    "failed to to put testmode wmi even cmd_id: %d\n",
+			    "failed to put testmode wmi even cmd_id: %d\n",
 			    ret);
 		kfree_skb(nl_skb);
 		goto out;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 8eca92520837..6e173737c0eb 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -362,7 +362,7 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
 	 * For example, for 4x4 capable macphys, first 4 chains can be used for first
 	 * mac and the remaing 4 chains can be used for the second mac or vice-versa.
 	 * In this case, tx/rx chainmask 0xf will be advertised for first mac and 0xf0
-	 * will be advertised for second mac or vice-versa. Compute the shift value for
+	 * will be advertised for second mac or vice-versa. Compute the shift value
 	 * for tx/rx chainmask which will be used to advertise supported ht/vht rates to
 	 * mac80211.
 	 */
-- 
2.7.4

