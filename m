Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49315158B91
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 09:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgBKI7t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 03:59:49 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:11377 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727608AbgBKI7t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 03:59:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581411588; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=naIQn2hB0n/P5Vs4krn5QFMSJuLxTMUW9SG3/BdcJfE=; b=DVfPhH7NSiFyiKzffur2GSRbQNaWNuC9xaryTZN89hUY03KWNnhZ9zt758Rdi2ZbA1qOi1iN
 1sNZKxnFRtg1g3VJuSkvMS9QizYxyhCxCkvyKSTlhzb8UW0+nMKKLN5+qIGOW5L1vlqShsoU
 Hhsm14R1H/utsCebwoTftIUfzPA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e426d00.7f291b8ca880-smtp-out-n03;
 Tue, 11 Feb 2020 08:59:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A60BC4479C; Tue, 11 Feb 2020 08:59:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87E03C43383;
        Tue, 11 Feb 2020 08:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87E03C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: fix few checkpatch warnings
Date:   Tue, 11 Feb 2020 10:59:38 +0200
Message-Id: <1581411578-26388-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix warnings which were recently introduced:

drivers/net/wireless/ath/ath10k/ahb.c:462: Alignment should match open parenthesis
drivers/net/wireless/ath/ath10k/ahb.c:470: Alignment should match open parenthesis
drivers/net/wireless/ath/ath10k/sdio.c:697: space prohibited before that close parenthesis ')'

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/ahb.c  | 4 ++--
 drivers/net/wireless/ath/ath10k/sdio.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index ed87bc00f2aa..342a7e58018a 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -459,7 +459,7 @@ static int ath10k_ahb_resource_init(struct ath10k *ar)
 	ar_ahb->mem_len = resource_size(res);
 
 	ar_ahb->gcc_mem = ioremap(ATH10K_GCC_REG_BASE,
-					  ATH10K_GCC_REG_SIZE);
+				  ATH10K_GCC_REG_SIZE);
 	if (!ar_ahb->gcc_mem) {
 		ath10k_err(ar, "gcc mem ioremap error\n");
 		ret = -ENOMEM;
@@ -467,7 +467,7 @@ static int ath10k_ahb_resource_init(struct ath10k *ar)
 	}
 
 	ar_ahb->tcsr_mem = ioremap(ATH10K_TCSR_REG_BASE,
-					   ATH10K_TCSR_REG_SIZE);
+				   ATH10K_TCSR_REG_SIZE);
 	if (!ar_ahb->tcsr_mem) {
 		ath10k_err(ar, "tcsr mem ioremap error\n");
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index e5316b911e1d..2e9d78222153 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -694,7 +694,7 @@ static int ath10k_sdio_mbox_rx_fetch_bundle(struct ath10k *ar)
 		htc_hdr = (struct ath10k_htc_hdr *)(ar_sdio->vsg_buffer + pkt_offset);
 		pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
 
-		if (pkt->act_len > pkt->alloc_len ) {
+		if (pkt->act_len > pkt->alloc_len) {
 			ret = -EINVAL;
 			goto err;
 		}
-- 
2.7.4
