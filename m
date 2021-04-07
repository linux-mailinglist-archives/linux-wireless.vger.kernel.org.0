Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804E53565CD
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 09:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhDGHvd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 03:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233775AbhDGHvc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 03:51:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A8A061222;
        Wed,  7 Apr 2021 07:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617781883;
        bh=YeFq8MoE7/5wFqdk4IhoYzWdYzfRAPRDBT7Df8hD4yA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CJI2efqRU/QtJldhAIaph1+dZ5okkIe1rO3jd/ukRNXctcmhHfxckbvAC/euNIiax
         1oMu9rFolf628YNSsIfRj/P8Cu7bMbOT0NguvrWJUigJWcmcn65/lfMU7/73XA6LgP
         1o+F76QXesGqLqnkpDe9AAsSPgzfr+7RVSM0WFN9aUHiAB5MU2MZ8wlTo8YgoMj2nB
         d26DpfrHgKX7phzZYZL+DGsA+ksP3dZfZL2QG6iQfpG2BZBfsJ55cts7VQzKnebocM
         xUknGM9X3ei7JLqZvSGr+vmdky/cI+2NaLXOE05Zrgk3fYncbZoBhIlHHYbiBGekKw
         hGECYthX4xxxg==
Date:   Wed, 7 Apr 2021 09:51:20 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
In-Reply-To: <b71f7f03-fa87-74ab-4f10-5cebe3e70b60@gmail.com>
Message-ID: <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm>
References: <b71f7f03-fa87-74ab-4f10-5cebe3e70b60@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 7 Apr 2021, Heiner Kallweit wrote:

> Same fix as in 2800aadc18a6 ("iwlwifi: Fix softirq/hardirq disabling in
> iwl_pcie_enqueue_hcmd()") is needed for iwl_pcie_gen2_enqueue_hcmd.
> I get the same lockdep warning on AX210.

Makes sense, it's being called from exactly the same contexts.



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_gen2_enqueue_hcmd()

Analogically to what we did in 2800aadc18a6 ("iwlwifi: Fix 
softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()"), we must apply the 
same fix to iwl_pcie_gen2_enqueue_hcmd(), as it's being called from 
exactly the same contexts.

Reported-by: Heiner Kallweit <hkallweit1@gmail.com
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
--- 

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 4456abb9a074..34bde8c87324 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -40,6 +40,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 	const u8 *cmddata[IWL_MAX_CMD_TBS_PER_TFD];
 	u16 cmdlen[IWL_MAX_CMD_TBS_PER_TFD];
 	struct iwl_tfh_tfd *tfd;
+	unsigned long flags;
 
 	copy_size = sizeof(struct iwl_cmd_header_wide);
 	cmd_size = sizeof(struct iwl_cmd_header_wide);
@@ -108,14 +109,14 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 		goto free_dup_buf;
 	}
 
-	spin_lock_bh(&txq->lock);
+	spin_lock_irqsave(&txq->lock, flags);
 
 	idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
 	tfd = iwl_txq_get_tfd(trans, txq, txq->write_ptr);
 	memset(tfd, 0, sizeof(*tfd));
 
 	if (iwl_txq_space(trans, txq) < ((cmd->flags & CMD_ASYNC) ? 2 : 1)) {
-		spin_unlock_bh(&txq->lock);
+		spin_unlock_irqrestore(&txq->lock, flags);
 
 		IWL_ERR(trans, "No space in command queue\n");
 		iwl_op_mode_cmd_queue_full(trans->op_mode);
@@ -250,7 +251,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 	spin_unlock(&trans_pcie->reg_lock);
 
 out:
-	spin_unlock_bh(&txq->lock);
+	spin_unlock_irqrestore(&txq->lock, flags);
 free_dup_buf:
 	if (idx < 0)
 		kfree(dup_buf);

-- 
Jiri Kosina
SUSE Labs

