Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5311A6593
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2020 13:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgDMLVu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Apr 2020 07:21:50 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:54496 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728826AbgDMLVt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Apr 2020 07:21:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586776909; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=iBqud1oCsvUfEQjL5hlZ+sakjB+UhQOh81+t2E+YEbY=; b=NAo3FcSLUP7sDZFF71IfndT1gPZ6LP5/JnZxhHzrpfAklXpp63A9gV714u99zUiHwzygtr4P
 OAlBl8cSwA4N5l31nUhNqQBQ/P3vSJw2AtY8NL6EhXtrt3PST2TAAwki0ZzyhLG7e7MRm/gS
 2AMILp87mdwJSrlb8f6Nkcb2IT4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e944b4c.7f14545cf8f0-smtp-out-n02;
 Mon, 13 Apr 2020 11:21:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD17DC433BA; Mon, 13 Apr 2020 11:21:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from c-gsamin-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gsamin)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3E26C433F2;
        Mon, 13 Apr 2020 11:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3E26C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=gsamin@codeaurora.org
From:   Govindaraj Saminathan <gsamin@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>
Subject: [PATCH] ath11k: cleanup reo command error code overwritten
Date:   Mon, 13 Apr 2020 16:51:12 +0530
Message-Id: <1586776872-25766-1-git-send-email-gsamin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

should not overwrite the error code. No buffer available then return
invalid. For other failures return the error code of actual failure.

Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 7aac4b0..6f40e72 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -543,8 +543,12 @@ int ath11k_dp_tx_send_reo_cmd(struct ath11k_base *ab, struct dp_rx_tid *rx_tid,
 	cmd_ring = &ab->hal.srng_list[dp->reo_cmd_ring.ring_id];
 	cmd_num = ath11k_hal_reo_cmd_send(ab, cmd_ring, type, cmd);
 
+	/* cmd_num should start from 1, during failure return the error code */
+	if (cmd_num < 0)
+		return cmd_num;
+
 	/* reo cmd ring descriptors has cmd_num starting from 1 */
-	if (cmd_num <= 0)
+	if (cmd_num == 0)
 		return -EINVAL;
 
 	if (!cb)
-- 
1.9.1
