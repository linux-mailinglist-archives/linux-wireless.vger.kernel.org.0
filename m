Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE30E27D43F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 19:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgI2RPx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 13:15:53 -0400
Received: from z5.mailgun.us ([104.130.96.5]:48740 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729492AbgI2RPw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 13:15:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601399751; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=kF0Z8GrkSH+y3X1WIh/HFk26AQ06DZ7f/hWeBbCC3IY=; b=VJ1JjXWCdCG/Vv4ZStrQZRliS0tFUOPbSg8QZcs01BnySCmip8B4dSv5gduh8gT0NrdKN1rP
 glXGQrtdwWFkR1tpOQ8s8KBi0pLCKnn12E3MRhXTkMlSq6zDs6RIII0E2CU/rFBUiwPyZhKW
 srruNASebfBYF6j/0K+bV5XEiik=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f736bc7cc21f6157aab0d44 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 17:15:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B4DA8C4339C; Tue, 29 Sep 2020 17:15:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 749CAC433C8;
        Tue, 29 Sep 2020 17:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 749CAC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 7/8] ath11k: Use GFP_ATOMIC instead of GFP_KERNEL in ath11k_dp_htt_get_ppdu_desc
Date:   Tue, 29 Sep 2020 20:15:35 +0300
Message-Id: <1601399736-3210-8-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601399736-3210-1-git-send-email-kvalo@codeaurora.org>
References: <1601399736-3210-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

With SLUB DEBUG CONFIG below crash is seen as kmem_cache_alloc
is being called in non-atomic context.

To fix this issue, use GFP_ATOMIC instead of GFP_KERNEL kzalloc.

[  357.217088] BUG: sleeping function called from invalid context at mm/slab.h:498
[  357.217091] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
[  357.217092] INFO: lockdep is turned off.
[  357.217095] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.9.0-rc5-wt-ath+ #196
[  357.217096] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0049.2018.0801.1601 08/01/2018
[  357.217097] Call Trace:
[  357.217098]  <IRQ>
[  357.217107]  ? ath11k_dp_htt_get_ppdu_desc+0xa9/0x170 [ath11k]
[  357.217110]  dump_stack+0x77/0xa0
[  357.217113]  ___might_sleep.cold+0xa6/0xb6
[  357.217116]  kmem_cache_alloc_trace+0x1f2/0x270
[  357.217122]  ath11k_dp_htt_get_ppdu_desc+0xa9/0x170 [ath11k]
[  357.217129]  ath11k_htt_pull_ppdu_stats.isra.0+0x96/0x270 [ath11k]
[  357.217135]  ath11k_dp_htt_htc_t2h_msg_handler+0xe7/0x1d0 [ath11k]
[  357.217137]  ? trace_hardirqs_on+0x1c/0x100
[  357.217143]  ath11k_htc_rx_completion_handler+0x207/0x370 [ath11k]
[  357.217149]  ath11k_ce_recv_process_cb+0x15e/0x1e0 [ath11k]
[  357.217151]  ? handle_irq_event+0x70/0xa8
[  357.217154]  ath11k_pci_ce_tasklet+0x10/0x30 [ath11k_pci]
[  357.217157]  tasklet_action_common.constprop.0+0xd4/0xf0
[  357.217160]  __do_softirq+0xc9/0x482
[  357.217162]  asm_call_on_stack+0x12/0x20
[  357.217163]  </IRQ>
[  357.217166]  do_softirq_own_stack+0x49/0x60
[  357.217167]  irq_exit_rcu+0x9a/0xd0
[  357.217169]  common_interrupt+0xa1/0x190
[  357.217171]  asm_common_interrupt+0x1e/0x40
[  357.217173] RIP: 0010:cpu_idle_poll.isra.0+0x2e/0x60
[  357.217175] Code: 8b 35 26 27 74 69 e8 11 c8 3d ff e8 bc fa 42 ff e8 e7 9f 4a ff fb 65 48 8b 1c 25 80 90 01 00 48 8b 03 a8 08 74 0b eb 1c f3 90 <48> 8b 03 a8 08 75 13 8b 0
[  357.217177] RSP: 0018:ffffffff97403ee0 EFLAGS: 00000202
[  357.217178] RAX: 0000000000000001 RBX: ffffffff9742b8c0 RCX: 0000000000b890ca
[  357.217180] RDX: 0000000000b890ca RSI: 0000000000000001 RDI: ffffffff968d0c49
[  357.217181] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
[  357.217182] R10: ffffffff9742b8c0 R11: 0000000000000046 R12: 0000000000000000
[  357.217183] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000066fdf520
[  357.217186]  ? cpu_idle_poll.isra.0+0x19/0x60
[  357.217189]  do_idle+0x5f/0xe0
[  357.217191]  cpu_startup_entry+0x14/0x20
[  357.217193]  start_kernel+0x443/0x464
[  357.217196]  secondary_startup_64+0xa4/0xb0

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 345eaa4f20f3..96828af58d28 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1478,7 +1478,7 @@ struct htt_ppdu_stats_info *ath11k_dp_htt_get_ppdu_desc(struct ath11k *ar,
 	}
 	spin_unlock_bh(&ar->data_lock);
 
-	ppdu_info = kzalloc(sizeof(*ppdu_info), GFP_KERNEL);
+	ppdu_info = kzalloc(sizeof(*ppdu_info), GFP_ATOMIC);
 	if (!ppdu_info)
 		return NULL;
 
-- 
2.7.4

