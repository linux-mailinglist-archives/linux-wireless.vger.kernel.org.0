Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E243F2A777C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 07:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgKEGdZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 01:33:25 -0500
Received: from z5.mailgun.us ([104.130.96.5]:51115 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbgKEGdZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 01:33:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604558004; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4nxJBCC+CMwclD07P+yaOByA7QtxUjtpGNp3zfpDsS0=; b=WXhKo6DWZpSUvt2+rbbUW7qaub4/edZmtZc1wBZEgwNYpmFE/ayZo7ovGjz4kbrOOqPM3TO9
 2mkg3i9UqcwRWlmQ2DUBuPHu6/7LLc8Bwf/uHWAoKe5l5TUpYF+cB/4fz0HJdelLR7qcqSOR
 IQ2k9AycW+N+eGlfivKWyJF7L74=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fa39c948dd4beedee22c97a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 06:32:52
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7B47C433C9; Thu,  5 Nov 2020 06:32:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D91EC433C6;
        Thu,  5 Nov 2020 06:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D91EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath10k: cancel rx worker in hif_stop for SDIO
Date:   Thu,  5 Nov 2020 14:33:56 +0800
Message-Id: <1604558036-4056-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The rx worker of SDIO should be cancelled after disable interrupt, and
release rx sk_buff in queue, otherwise the rx worker maybe still run
after hif_stop. And it should be cancelled before napi_synchronize in
hif_stop, because the rx worker of SDIO will call napi_schedule, it
should have no napi_schedule before napi_synchronize, otherwise it
lead napi_synchronize wait untill napi_complete.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 81ddaafb6721..2c619ef8a87c 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1962,9 +1962,15 @@ static void ath10k_sdio_hif_stop(struct ath10k *ar)
 {
 	struct ath10k_sdio_bus_request *req, *tmp_req;
 	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
+	struct sk_buff *skb;
 
 	ath10k_sdio_irq_disable(ar);
 
+	cancel_work_sync(&ar_sdio->async_work_rx);
+
+	while (skb = skb_dequeue(&ar_sdio->rx_head))
+		dev_kfree_skb_any(skb);
+
 	cancel_work_sync(&ar_sdio->wr_async_work);
 
 	spin_lock_bh(&ar_sdio->wr_async_lock);
-- 
2.23.0

