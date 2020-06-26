Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE3220B793
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgFZRxC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 13:53:02 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:51043 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbgFZRxC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 13:53:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593193980; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=M4/z7Iy1EOU+9x5PhIFOztWGXMqQ//hsEw96CNbfFnc=; b=WtfMOq8hJu61SLid5PwUO3N+HBQyG9Xj0QE55ypYll+nn6Bck8HQ+tQilW/Ceuc+owK4KYft
 za3LpASj32l0oVSyq7zjRWrJu5YzCNuaURh4CxtI2JRqENB8u76n/oStc0aKqHziY9DKZ9El
 Yp974hvX/5jqOj0FNAV1HBV5aX0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5ef635fbbfb34e631cdab8f3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 17:52:59
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F13F3C433C8; Fri, 26 Jun 2020 17:52:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8B28C433C6;
        Fri, 26 Jun 2020 17:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8B28C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH] ath10k: Add interrupt summary based CE processing
Date:   Fri, 26 Jun 2020 23:22:47 +0530
Message-Id: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently the NAPI processing loops through all
the copy engines and processes a particular copy
engine is the copy completion is set for that copy
engine. The host driver is not supposed to access
any copy engine register after clearing the interrupt
status register.

This might result in kernel crash like the one below
[ 1159.220143] Call trace:
[ 1159.220170]  ath10k_snoc_read32+0x20/0x40 [ath10k_snoc]
[ 1159.220193]  ath10k_ce_per_engine_service_any+0x78/0x130 [ath10k_core]
[ 1159.220203]  ath10k_snoc_napi_poll+0x38/0x8c [ath10k_snoc]
[ 1159.220270]  net_rx_action+0x100/0x3b0
[ 1159.220312]  __do_softirq+0x164/0x30c
[ 1159.220345]  run_ksoftirqd+0x2c/0x64
[ 1159.220380]  smpboot_thread_fn+0x1b0/0x288
[ 1159.220405]  kthread+0x11c/0x12c
[ 1159.220423]  ret_from_fork+0x10/0x18

To avoid such a scenario, we generate an interrupt
summary by reading the copy completion for all the
copy engine before actually processing any of them.
This will avoid reading the interrupt status register
for any CE after the interrupt status is cleared.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/ce.c | 63 ++++++++++++++++++++++--------------
 drivers/net/wireless/ath/ath10k/ce.h |  5 +--
 2 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index ffdd4b9..1e16f26 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -481,15 +481,38 @@ static inline void ath10k_ce_engine_int_status_clear(struct ath10k *ar,
 	ath10k_ce_write32(ar, ce_ctrl_addr + wm_regs->addr, mask);
 }
 
-static inline bool ath10k_ce_engine_int_status_check(struct ath10k *ar,
-						     u32 ce_ctrl_addr,
-						     unsigned int mask)
+static bool ath10k_ce_engine_int_status_check(struct ath10k *ar, u32 ce_ctrl_addr,
+					      unsigned int mask)
 {
 	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
 
 	return ath10k_ce_read32(ar, ce_ctrl_addr + wm_regs->addr) & mask;
 }
 
+u32 ath10k_ce_gen_interrupt_summary(struct ath10k *ar)
+{
+	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
+	struct ath10k_ce_pipe *ce_state;
+	struct ath10k_ce *ce;
+	u32 irq_summary = 0;
+	u32 ctrl_addr;
+	u32 ce_id;
+
+	ce = ath10k_ce_priv(ar);
+
+	for (ce_id = 0; ce_id < CE_COUNT; ce_id++) {
+		ce_state = &ce->ce_states[ce_id];
+		ctrl_addr = ce_state->ctrl_addr;
+		if (ath10k_ce_engine_int_status_check(ar, ctrl_addr,
+						      wm_regs->cc_mask)) {
+			irq_summary |= BIT(ce_id);
+		}
+	}
+
+	return irq_summary;
+}
+EXPORT_SYMBOL(ath10k_ce_gen_interrupt_summary);
+
 /*
  * Guts of ath10k_ce_send.
  * The caller takes responsibility for any needed locking.
@@ -1308,32 +1331,24 @@ void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id)
 	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
 	u32 ctrl_addr = ce_state->ctrl_addr;
 
-	spin_lock_bh(&ce->ce_lock);
-
-	if (ath10k_ce_engine_int_status_check(ar, ctrl_addr,
-					      wm_regs->cc_mask)) {
-		/* Clear before handling */
-		ath10k_ce_engine_int_status_clear(ar, ctrl_addr,
-						  wm_regs->cc_mask);
-
-		spin_unlock_bh(&ce->ce_lock);
-
-		if (ce_state->recv_cb)
-			ce_state->recv_cb(ce_state);
-
-		if (ce_state->send_cb)
-			ce_state->send_cb(ce_state);
-
-		spin_lock_bh(&ce->ce_lock);
-	}
-
 	/*
+	 * Clear before handling
+	 *
 	 * Misc CE interrupts are not being handled, but still need
 	 * to be cleared.
+	 *
+	 * NOTE: When the last copy engine interrupt is cleared the
+	 * hardware will go to sleep.  Once this happens any access to
+	 * the CE registers can cause a hardware fault.
 	 */
-	ath10k_ce_engine_int_status_clear(ar, ctrl_addr, wm_regs->wm_mask);
+	ath10k_ce_engine_int_status_clear(ar, ctrl_addr,
+					  wm_regs->cc_mask | wm_regs->wm_mask);
 
-	spin_unlock_bh(&ce->ce_lock);
+	if (ce_state->recv_cb)
+		ce_state->recv_cb(ce_state);
+
+	if (ce_state->send_cb)
+		ce_state->send_cb(ce_state);
 }
 EXPORT_SYMBOL(ath10k_ce_per_engine_service);
 
diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index 75df79d..a440aaf 100644
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -259,6 +259,8 @@ int ath10k_ce_disable_interrupts(struct ath10k *ar);
 void ath10k_ce_enable_interrupts(struct ath10k *ar);
 void ath10k_ce_dump_registers(struct ath10k *ar,
 			      struct ath10k_fw_crash_data *crash_data);
+
+u32 ath10k_ce_gen_interrupt_summary(struct ath10k *ar);
 void ath10k_ce_alloc_rri(struct ath10k *ar);
 void ath10k_ce_free_rri(struct ath10k *ar);
 
@@ -369,7 +371,6 @@ static inline u32 ath10k_ce_base_address(struct ath10k *ar, unsigned int ce_id)
 	(((x) & CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_MASK) >> \
 		CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_LSB)
 #define CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS			0x0000
-#define CE_INTERRUPT_SUMMARY		(GENMASK(CE_COUNT_MAX - 1, 0))
 
 static inline u32 ath10k_ce_interrupt_summary(struct ath10k *ar)
 {
@@ -380,7 +381,7 @@ static inline u32 ath10k_ce_interrupt_summary(struct ath10k *ar)
 			ce->bus_ops->read32((ar), CE_WRAPPER_BASE_ADDRESS +
 			CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS));
 	else
-		return CE_INTERRUPT_SUMMARY;
+		return ath10k_ce_gen_interrupt_summary(ar);
 }
 
 /* Host software's Copy Engine configuration. */
-- 
2.7.4

