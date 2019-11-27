Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6BB10B0E4
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 15:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfK0OI7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 09:08:59 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:60528
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727028AbfK0OI6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 09:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574863737;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=CGkP6mfdXMFi153HECcp6YM7zGCP5SXP0zGbtk0+pTU=;
        b=HVzdyK+X3BP2yz1wF6xh7VerkZRxiwTomlFAAfKFFLDCCqWth8A6X7jxUhsUpSKv
        KrrYg0RN8YQDabfaTA/UOZaSmXtqL5OAUsPoLBYrddwzj6LYKml5GReclFUNvecMggk
        PgCVh1R/IegFn/Jw111Jjtjc61t/acMo0J5cR+fE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574863737;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=CGkP6mfdXMFi153HECcp6YM7zGCP5SXP0zGbtk0+pTU=;
        b=X/kjd6HAQJINb0e0Gm1YviWJRUtEit1aC3pY3z/SC4vOL6IcInZgRNf9M3hA5CvD
        o5eJHs+7mWrgUz7hzF3PIO6s4/c+AVtscc5NE3QIxUq3zMUaFAYbh82Bkx6cWrIijxO
        C25kF7AUXYpRF8wvLvI7QAMLDZ6+gBHopqH1aLaU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9F69C48B02
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 07/10] ath11k: update bawindow size in delba process
Date:   Wed, 27 Nov 2019 14:08:57 +0000
Message-ID: <0101016ead319335-51f84b3b-8c6c-41c9-a1be-18e62aead1b6-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
References: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.27-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <vnaralas@codeaurora.org>

Currenly in delba process calling ath11k_peer_rx_tid_delete() updates
reo with desc invalid and add tid queue to the flush list. If station
send data traffic without addba req and before tid flush, hw gives
those packets as invalid desc reo error. Since we are dropping these
invalid desc packets results in traffic stall.

This patch fix this issue by updating the reo queue with bawindow size 1
instead of tid removal in delba process.

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index f87bd327b082..8c21925a522a 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -641,7 +641,8 @@ void ath11k_peer_rx_tid_cleanup(struct ath11k *ar, struct ath11k_peer *peer)
 static int ath11k_peer_rx_tid_reo_update(struct ath11k *ar,
 					 struct ath11k_peer *peer,
 					 struct dp_rx_tid *rx_tid,
-					 u32 ba_win_sz, u16 ssn)
+					 u32 ba_win_sz, u16 ssn,
+					 bool update_ssn)
 {
 	struct ath11k_hal_reo_cmd cmd = {0};
 	int ret;
@@ -649,10 +650,13 @@ static int ath11k_peer_rx_tid_reo_update(struct ath11k *ar,
 	cmd.addr_lo = lower_32_bits(rx_tid->paddr);
 	cmd.addr_hi = upper_32_bits(rx_tid->paddr);
 	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
-	cmd.upd0 = HAL_REO_CMD_UPD0_BA_WINDOW_SIZE |
-		   HAL_REO_CMD_UPD0_SSN;
+	cmd.upd0 = HAL_REO_CMD_UPD0_BA_WINDOW_SIZE;
 	cmd.ba_window_size = ba_win_sz;
-	cmd.upd2 = FIELD_PREP(HAL_REO_CMD_UPD2_SSN, ssn);
+
+	if (update_ssn) {
+		cmd.upd0 |= HAL_REO_CMD_UPD0_SSN;
+		cmd.upd2 = FIELD_PREP(HAL_REO_CMD_UPD2_SSN, ssn);
+	}
 
 	ret = ath11k_dp_tx_send_reo_cmd(ar->ab, rx_tid,
 					HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
@@ -722,7 +726,7 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 	if (rx_tid->active) {
 		paddr = rx_tid->paddr;
 		ret = ath11k_peer_rx_tid_reo_update(ar, peer, rx_tid,
-						    ba_win_sz, ssn);
+						    ba_win_sz, ssn, true);
 		spin_unlock_bh(&ab->base_lock);
 		if (ret) {
 			ath11k_warn(ab, "failed to update reo for rx tid %d\n", tid);
@@ -832,12 +836,18 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
 	paddr = peer->rx_tid[params->tid].paddr;
 	active = peer->rx_tid[params->tid].active;
 
-	ath11k_peer_rx_tid_delete(ar, peer, params->tid);
+	if (!active) {
+		spin_unlock_bh(&ab->base_lock);
+		return 0;
+	}
 
+	ret = ath11k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
 	spin_unlock_bh(&ab->base_lock);
-
-	if (!active)
-		return 0;
+	if (ret) {
+		ath11k_warn(ab, "failed to update reo for rx tid %d: %d\n",
+			    params->tid, ret);
+		return ret;
+	}
 
 	ret = ath11k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id,
 						     params->sta->addr, paddr,
-- 
2.7.4

