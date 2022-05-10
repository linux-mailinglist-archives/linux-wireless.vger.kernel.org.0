Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF152246F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbiEJS4n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 14:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiEJS4k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 14:56:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822B56278
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gLHV2zxZlzihBFrzOKFTcBn8ev25R0fv7cd+k2LoKAg=;
        t=1652208999; x=1653418599; b=GVMRBZDnxYH3nxAeEyhOCINnnmlStrT2D2RshpVUJlvT/NK
        lUZWdBpBizfWhskaeCpAojnCs5/Oymt5WGVWECYZ54Fw9kZCdQqHqQFsG+rienQPSWA0ltFDfQKfi
        v30Sf8utjBo9+ueNomecYuqI+0YFWYsFLgJKg1d15Aaxay3sOkU1q2bXZiSoEqJ/G6kB9b1ew3ebR
        1mgCFM7tTLopLqjeU9sw3njZ/VZOepPEd0VaLu7OqFGfW0JXhewSOn12TYBbEZ1cj+gSxNe/Mhk8c
        sUowPMtLB73TfsPDJxLSzsp0EufUTLqimrOsuAGkx3PBAAKjQ0nA6t4QKMy6ED/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1noV2D-007vCS-1l;
        Tue, 10 May 2022 20:56:37 +0200
Message-ID: <156bf8c8d9cbda8b7ff958b2b91837483b16570c.camel@sipsolutions.net>
Subject: Re: iwlwifi fw reset handshake
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Chris Rogers <crogers122@gmail.com>, linux-wireless@vger.kernel.org
Date:   Tue, 10 May 2022 20:56:36 +0200
In-Reply-To: <CAC4Yorhi_Zf-xcSJFOsJja-ZdLJYh6V-_hfkidzfQJ_+HeHX1Q@mail.gmail.com>
References: <CAC4Yorhi_Zf-xcSJFOsJja-ZdLJYh6V-_hfkidzfQJ_+HeHX1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-04-13 at 12:31 -0400, Chris Rogers wrote:
> In commit 906d4eb84408a4bfd63eef0de4f1bd5262f73ac0, a firmware reset
> handshake was introduced to iwlwifi. This code looks for the
> MSIX_HW_INT_CAUSES_REG_RESET_DONE interrupt in
> iwl_pcie_irq_msix_handler in rx.c, but it does not appear to handle
> anything along the MSI path.

Uh, oops.

> My environment is:
> - AX210 card, xen pci passthrough in MSI mode
> - linux v5.15.32
> 
> Based on some testing I've done, the wait_event_timeout in
> pcie/trans-gen2.c always times out.  The result is the "firmware
> didn't ACK the reset - continue anyway" message and a dump before it
> continues on.  Is the reset handshake something that should be handled
> on the MSI path? Given what's defined in iwl-csr.h, I'm not sure how
> to listen for a response from the card to wake_up the fw_reset_waitq
> like the MSI-X path.
> 

Do you get a print like

	Unhandled INTA bits 0x00000004

by any chance?

I think the number should be the same, so something like this perhaps:

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 3ed4e8f69f28..cf5462186f36 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1892,7 +1892,13 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		iwl_disable_interrupts(trans);
 
 		isr_stats->hw++;
-		iwl_pcie_irq_handle_error(trans);
+
+		if (trans_pcie->fw_reset_state == FW_RESET_REQUESTED) {
+			trans_pcie->fw_reset_state = FW_RESET_ERROR;
+			wake_up(&trans_pcie->fw_reset_waitq);
+		} else {
+			iwl_pcie_irq_handle_error(trans);
+		}
 
 		handled |= CSR_INT_BIT_HW_ERR;
 
@@ -2025,6 +2031,14 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		}
 	}
 
+	/* same bit for MSI/MSI-X */
+	if (inta & MSIX_HW_INT_CAUSES_REG_RESET_DONE) {
+		handled |= MSIX_HW_INT_CAUSES_REG_RESET_DONE;
+		IWL_DEBUG_ISR(trans, "Reset flow completed\n");
+		trans_pcie->fw_reset_state = FW_RESET_OK;
+		wake_up(&trans_pcie->fw_reset_waitq);
+	}
+
 	if (inta & ~handled) {
 		IWL_ERR(trans, "Unhandled INTA bits 0x%08x\n", inta & ~handled);
 		isr_stats->unhandled++;


If you can test it that'd be nice, I'm not sure how I can force anything
into MSI vs. MSI-X.

johannes
