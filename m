Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7201A30EC
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 10:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgDIIa3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 04:30:29 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:28543 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgDIIa3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 04:30:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586421029; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=UhDwT9XHx9i0JJElicqUHzv8NJfJXbAaCaXgCEfyyk8=; b=KpnLjXFuBrphTPz5Am4hBzgqjdFvqvpqgbpzdhnxpXhsUBHDbx7GJR89xgp+rQjPneUSbtwh
 ysxajRIHcWFNJKhHqinNVkmjcb9SnWyoDhe393dqXh86dg1mO/i9jYrMTd5oI8LHg7LxHiJO
 A1hN9IfA+BMfYiIkwG0eJxR4Q1Y=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8edd24.7f309064bae8-smtp-out-n02;
 Thu, 09 Apr 2020 08:30:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C192EC433F2; Thu,  9 Apr 2020 08:30:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C623FC433D2;
        Thu,  9 Apr 2020 08:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C623FC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Subject: [PATCH] ath11k: set IRQ_DISABLE_UNLAZY flag for DP interrupts
Date:   Thu,  9 Apr 2020 14:00:13 +0530
Message-Id: <1586421013-23025-1-git-send-email-mpubbise@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unlike CE interrupts, DP interrupts are not enabled/disabled at
source; they are enabled/disabled only at GIC level, therefore
it is required to set IRQ_DISABLE_UNLAZY flag to avoid spurious
interrupts.

Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 59342d2..3b2b76d 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -788,7 +788,7 @@ static int ath11k_ahb_ext_irq_config(struct ath11k_base *ab)
 			irq = platform_get_irq_byname(ab->pdev,
 						      irq_name[irq_idx]);
 			ab->irq_num[irq_idx] = irq;
-			irq_set_status_flags(irq, IRQ_NOAUTOEN);
+			irq_set_status_flags(irq, IRQ_NOAUTOEN | IRQ_DISABLE_UNLAZY);
 			ret = request_irq(irq, ath11k_ahb_ext_interrupt_handler,
 					  IRQF_TRIGGER_RISING,
 					  irq_name[irq_idx], irq_grp);
-- 
2.7.4
