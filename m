Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7077A362ECE
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 11:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhDQJOK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 05:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235961AbhDQJOI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 05:14:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 910E4610CC;
        Sat, 17 Apr 2021 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618650822;
        bh=AxHF839jlot7CSgkb5XujKJlRTyGdKmSNFo1d2vkFbI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=s2uk5n7n+KHzePsxR7M8UCm8clFtcFJQH6yV/XvKnpVpKg81COkrIlDbSdbcOz0rw
         0SqcP5WI3bOIaBErpsUN3HhU6lQMjENMaZTt+4cPzZKIpk3t7BvFcyyY7Z4GjuNks3
         TOMa0DdiUtkiYXfJHsX+30Reji1rtH3H5fwK6vWdubUploOQdE5DMYHFEfynWiMtGd
         Wo/qt6oTZ45kM44yBP061aZo07td6EhMt/MofOfZE3Bk46UE436wT6zfFJuSynUjWm
         PwKY7IxkgunCL35vzj9bdoA2OEy3KS11WeNxnx3a4CpFCaLneN2JBmdf30i1wqsw4s
         tmJsPBKPh6Npg==
Date:   Sat, 17 Apr 2021 11:13:39 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
In-Reply-To: <nycvar.YFH.7.76.2104171105580.18270@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2104171112390.18270@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm> <20210417085010.58522C433C6@smtp.codeaurora.org> <nycvar.YFH.7.76.2104171105580.18270@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Analogically to what we did in 2800aadc18a6 ("iwlwifi: Fix softirq/hardirq 
disabling in iwl_pcie_enqueue_hcmd()"), we must apply the same fix to 
iwl_pcie_gen2_enqueue_hcmd(), as it's being called from exactly the same 
contexts.

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


