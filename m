Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C0F1AC02F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2020 13:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506664AbgDPLvQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Apr 2020 07:51:16 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53928 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2504790AbgDPLvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Apr 2020 07:51:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587037871; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=8JsMUVvug5gkrIsVmNFW/hmGCWdIBnEHirHTipJ7CuI=; b=oygvvlN55gqvFKGR0Av0YmdOM3QBTLlLZ9kG5aWIRD/ozj5nr87zPS+XzOFpRrYTU2TwPkM8
 VXTRX3Dgs6BecFDX3c/LfbtaeOGXyETYg+uwfbURB2SukVpCkUGYmoEq9TpSyc248Tg3o/9w
 yASvxlSAt7r9aUhlTqPAGY9FzPI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9846aa.7f59ad174f48-smtp-out-n03;
 Thu, 16 Apr 2020 11:51:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 01B4BC432C2; Thu, 16 Apr 2020 11:51:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A943C433F2;
        Thu, 16 Apr 2020 11:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A943C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/4] ath10k: rename ath10k_hif_swap_mailbox() to ath10k_hif_start_post()
Date:   Thu, 16 Apr 2020 14:50:56 +0300
Message-Id: <1587037859-28873-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587037859-28873-1-git-send-email-kvalo@codeaurora.org>
References: <1587037859-28873-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert ath10k_hif_swap_mailbox() to a more generic op so that bus drivers can
do more than just swap the mailbox, for example set power save settings like in
the following sdio patch.

No functional changes, compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 2 +-
 drivers/net/wireless/ath/ath10k/hif.h  | 8 ++++----
 drivers/net/wireless/ath/ath10k/sdio.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 52472bbcee1f..5926281c7e05 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2714,7 +2714,7 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
 		goto err_hif_stop;
 	}
 
-	status = ath10k_hif_swap_mailbox(ar);
+	status = ath10k_hif_start_post(ar);
 	if (status) {
 		ath10k_err(ar, "failed to swap mailbox: %d\n", status);
 		goto err_hif_stop;
diff --git a/drivers/net/wireless/ath/ath10k/hif.h b/drivers/net/wireless/ath/ath10k/hif.h
index 0dd8973d0acf..2c5d61d98337 100644
--- a/drivers/net/wireless/ath/ath10k/hif.h
+++ b/drivers/net/wireless/ath/ath10k/hif.h
@@ -54,7 +54,7 @@ struct ath10k_hif_ops {
 	 */
 	void (*stop)(struct ath10k *ar);
 
-	int (*swap_mailbox)(struct ath10k *ar);
+	int (*start_post)(struct ath10k *ar);
 
 	int (*get_htt_tx_complete)(struct ath10k *ar);
 
@@ -139,10 +139,10 @@ static inline void ath10k_hif_stop(struct ath10k *ar)
 	return ar->hif.ops->stop(ar);
 }
 
-static inline int ath10k_hif_swap_mailbox(struct ath10k *ar)
+static inline int ath10k_hif_start_post(struct ath10k *ar)
 {
-	if (ar->hif.ops->swap_mailbox)
-		return ar->hif.ops->swap_mailbox(ar);
+	if (ar->hif.ops->start_post)
+		return ar->hif.ops->start_post(ar);
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 943db9f401d8..184b3545324e 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1725,7 +1725,7 @@ static int ath10k_sdio_hif_diag_write_mem(struct ath10k *ar, u32 address,
 	return 0;
 }
 
-static int ath10k_sdio_hif_swap_mailbox(struct ath10k *ar)
+static int ath10k_sdio_hif_start_post(struct ath10k *ar)
 {
 	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
 	u32 addr, val;
@@ -2047,7 +2047,7 @@ static const struct ath10k_hif_ops ath10k_sdio_hif_ops = {
 	.exchange_bmi_msg	= ath10k_sdio_bmi_exchange_msg,
 	.start			= ath10k_sdio_hif_start,
 	.stop			= ath10k_sdio_hif_stop,
-	.swap_mailbox		= ath10k_sdio_hif_swap_mailbox,
+	.start_post		= ath10k_sdio_hif_start_post,
 	.get_htt_tx_complete	= ath10k_sdio_get_htt_tx_complete,
 	.map_service_to_pipe	= ath10k_sdio_hif_map_service_to_pipe,
 	.get_default_pipe	= ath10k_sdio_hif_get_default_pipe,
-- 
2.7.4
