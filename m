Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC7A1B3A82
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDVIsG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 04:48:06 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:23125 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbgDVIsG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 04:48:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587545285; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=U5XjU8OF/7fOaST2iHHrzf1k4iXFdOXagWvhDgQwyLw=; b=Vf/WdY075yd+p8QQwiXnMMuFhKomwvRNkCuRweOPJo0ooZj/LHuq6wyjGXEq9/0d7Nn3o6Ve
 BzGZYkeUBh7VkNIELOUC7/83Wdm1mIPsitLL6FRtie9+V6lmuTf4HpYPg8MwTySMFxW3XQKc
 aLoWZMhQzzAiqL/2LPXKCBvhZUQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea004b6.7fb526dc9500-smtp-out-n03;
 Wed, 22 Apr 2020 08:47:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CEE8BC433BA; Wed, 22 Apr 2020 08:47:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2135EC433F2;
        Wed, 22 Apr 2020 08:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2135EC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2] ath10k: drop the TX packet which size exceed credit size for sdio
Date:   Wed, 22 Apr 2020 16:47:19 +0800
Message-Id: <20200422084719.3479-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

sdio chip use DMA buffer to receive TX packet from ath10k, and it has
limitation of each buffer, if the packet size exceed the credit size,
it will trigger error in firmware.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v2: rebase to ath-next
 drivers/net/wireless/ath/ath10k/htc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index 58ceba75d20a..31df6dd04bf6 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -846,6 +846,11 @@ int ath10k_htc_send_hl(struct ath10k_htc *htc,
 	struct ath10k_htc_ep *ep = &htc->endpoint[eid];
 	struct ath10k *ar = htc->ar;
 
+	if (sizeof(struct ath10k_htc_hdr) + skb->len > ep->tx_credit_size) {
+		ath10k_dbg(ar, ATH10K_DBG_HTC, "tx exceed max len %d\n", skb->len);
+		return -ENOMEM;
+	}
+
 	ath10k_dbg(ar, ATH10K_DBG_HTC, "htc send hl eid %d bundle %d tx count %d len %d\n",
 		   eid, ep->bundle_tx, skb_queue_len(&ep->tx_req_head), skb->len);
 
-- 
2.23.0
