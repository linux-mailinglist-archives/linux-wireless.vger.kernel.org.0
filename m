Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0FD1C694F
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 08:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgEFGrg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 02:47:36 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:30903 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727812AbgEFGrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 02:47:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588747655; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=70rgL4NE39jGfHV4AS4spCNTNUk5rYBuSykdVkZ8HhA=; b=tkZFE/VYj/Wti5Ai9ImMUbpUlfKUson3Ln0ql5OwaG18pzQtphHCCRZl0Zjqbqfin81zpEjw
 91Pg/m2sctjzRIYM0VvgdNcVCPXZFN0gbay1U/NKbGEYikf1xDrEwRLzuuIxS0zJNmNL9E/F
 4A2pqDWPlUhHnSU+fy96G66xVpE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb25d86.7f04b84db458-smtp-out-n04;
 Wed, 06 May 2020 06:47:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D919C4478C; Wed,  6 May 2020 06:47:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46DAEC43637;
        Wed,  6 May 2020 06:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46DAEC43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: fix __le32 warning in ath10k_wmi_tlv_op_gen_request_peer_stats_info()
Date:   Wed,  6 May 2020 09:47:29 +0300
Message-Id: <1588747649-18051-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

Sparse warned:

drivers/net/wireless/ath/ath10k/wmi-tlv.c:3013:34: warning: incorrect
type in assignment (different base types)
drivers/net/wireless/ath/ath10k/wmi-tlv.c:3013:34:    expected
restricted __le32 [usertype] reset_after_request
drivers/net/wireless/ath/ath10k/wmi-tlv.c:3013:34:    got unsigned int
[usertype] reset

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.

Fixes: 0f7cb26830a6 ("ath10k: add rx bitrate report for SDIO")
Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index afa03cb3aaf5..932266d1111b 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -3010,7 +3010,7 @@ ath10k_wmi_tlv_op_gen_request_peer_stats_info(struct ath10k *ar,
 	if (type == WMI_REQUEST_ONE_PEER_STATS_INFO)
 		ether_addr_copy(cmd->peer_macaddr.addr, addr);
 
-	cmd->reset_after_request = reset;
+	cmd->reset_after_request = __cpu_to_le32(reset);
 	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi tlv request peer stats info\n");
 	return skb;
 }
-- 
2.7.4
