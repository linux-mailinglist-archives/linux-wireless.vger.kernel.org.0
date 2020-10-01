Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030BB27FC8B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbgJAJf3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 05:35:29 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:21984 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731673AbgJAJf3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 05:35:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601544928; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=HRCJZhbbxysgF2SDHvFZHDqVX8al17bZ02odqP07/Ng=; b=xHjEIEqiaRnHBGepWIXzq0Gx3zuu9HNoWzWTqYh2ztGW0/9OUOjU39Yf7HbLDuMK4R7IcIdJ
 TRRDZWdLXz9mLdcSI4SgWLCld7WISZHPmvngohI1EqOCQ9VTO/aTlNM8A+UVGHF2HNDESd0z
 zQCap7KdpkXf7ekOTWf8mnCOVOw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f75a2c87df1a00ff88cf40a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 09:35:04
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF313C433CB; Thu,  1 Oct 2020 09:35:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66215C433FE;
        Thu,  1 Oct 2020 09:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66215C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/8] ath11k: start a timer to update HP for CE pipe 4
Date:   Thu,  1 Oct 2020 12:34:48 +0300
Message-Id: <1601544890-13450-7-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
References: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For QCA6390, Start a timer to update CE pipe 4 ring HP when shadow
register is enabled. Its' to avoid that HP isn't updated to target
register.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ce.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/ce.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index caa356dde880..9d730f8ac816 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -187,6 +187,26 @@ const struct ce_attr ath11k_host_ce_config_qca6390[] = {
 
 };
 
+static bool ath11k_ce_need_shadow_fix(int ce_id)
+{
+	/* only ce4 needs shadow workaroud*/
+	if (ce_id == 4)
+		return true;
+	return false;
+}
+
+static void ath11k_ce_stop_shadow_timers(struct ath11k_base *ab)
+{
+	int i;
+
+	if (!ab->hw_params.supports_shadow_regs)
+		return;
+
+	for (i = 0; i < ab->hw_params.ce_count; i++)
+		if (ath11k_ce_need_shadow_fix(i))
+			ath11k_dp_shadow_stop_timer(ab, &ab->ce.hp_timer[i]);
+}
+
 static int ath11k_ce_rx_buf_enqueue_pipe(struct ath11k_ce_pipe *pipe,
 					 struct sk_buff *skb, dma_addr_t paddr)
 {
@@ -505,6 +525,12 @@ static int ath11k_ce_init_ring(struct ath11k_base *ab,
 
 	ce_ring->hal_ring_id = ret;
 
+	if (ab->hw_params.supports_shadow_regs &&
+	    ath11k_ce_need_shadow_fix(ce_id))
+		ath11k_dp_shadow_init_timer(ab, &ab->ce.hp_timer[ce_id],
+					    ATH11K_SHADOW_CTRL_TIMER_INTERVAL,
+					    ce_ring->hal_ring_id);
+
 	return 0;
 }
 
@@ -677,6 +703,9 @@ int ath11k_ce_send(struct ath11k_base *ab, struct sk_buff *skb, u8 pipe_id,
 
 	ath11k_hal_srng_access_end(ab, srng);
 
+	if (ath11k_ce_need_shadow_fix(pipe_id))
+		ath11k_dp_shadow_start_timer(ab, srng, &ab->ce.hp_timer[pipe_id]);
+
 	spin_unlock_bh(&srng->lock);
 
 	spin_unlock_bh(&ab->ce.ce_lock);
@@ -761,6 +790,8 @@ void ath11k_ce_cleanup_pipes(struct ath11k_base *ab)
 	struct ath11k_ce_pipe *pipe;
 	int pipe_num;
 
+	ath11k_ce_stop_shadow_timers(ab);
+
 	for (pipe_num = 0; pipe_num < ab->hw_params.ce_count; pipe_num++) {
 		pipe = &ab->ce.ce_pipe[pipe_num];
 		ath11k_ce_rx_pipe_cleanup(pipe);
@@ -874,6 +905,9 @@ void ath11k_ce_free_pipes(struct ath11k_base *ab)
 	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		pipe = &ab->ce.ce_pipe[i];
 
+		if (ath11k_ce_need_shadow_fix(i))
+			ath11k_dp_shadow_stop_timer(ab, &ab->ce.hp_timer[i]);
+
 		if (pipe->src_ring) {
 			desc_sz = ath11k_hal_ce_get_desc_size(HAL_CE_DESC_SRC);
 			dma_free_coherent(ab->dev,
diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index 26ef65e2528e..269b599ac0b0 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -168,6 +168,7 @@ struct ath11k_ce {
 	struct ath11k_ce_pipe ce_pipe[CE_COUNT_MAX];
 	/* Protects rings of all ce pipes */
 	spinlock_t ce_lock;
+	struct ath11k_hp_update_timer hp_timer[CE_COUNT_MAX];
 };
 
 extern const struct ce_attr ath11k_host_ce_config_ipq8074[];
-- 
2.7.4

