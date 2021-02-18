Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7331E684
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Feb 2021 07:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhBRGwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Feb 2021 01:52:11 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:10310 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231204AbhBRGrX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Feb 2021 01:47:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613630760; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5DgHmOtgch1c2Sh6U8sVa0mpMOodaVWrZfileUSaFo4=; b=ZVR6iuztuJwWYdnRV9FOBpmtTl5cSpBZLlLwgDFdCF1Ar0sC/6ghBqegqGmJQw7L/UFoKl04
 hPfF160tXCn4ynI6vRMsDKJh4n3rb7fWCDnfOvL3vfDr73Ej6GNdNchQMuu9N9G6G4GCpjkf
 2Nm3SYQ2IRKXRX2XOBRhFLKqYA0=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 602e0cfb97484ee2ac1a9a5a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Feb 2021 06:45:15
 GMT
Sender: miaoqing=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9013FC43462; Thu, 18 Feb 2021 06:45:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from miaoqing-HP-Z220-SFF-Workstation.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11587C433ED;
        Thu, 18 Feb 2021 06:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11587C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=miaoqing@codeaurora.org
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: [PATCH] ath11k: fix potential wmi_mgmt_tx_queue race condition
Date:   Thu, 18 Feb 2021 14:45:09 +0800
Message-Id: <1613630709-704-1-git-send-email-miaoqing@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is a potential race condition between skb_queue_len()
and skb_queue_tail(), the former may get old value before
updated by the latter.

So use skb_queue_len_lockless() instead. And also use '>=',
in case we queue a few SKBs simultaneously.

Found while discussing a similar fix for ath10k:
https://patchwork.kernel.org/project/linux-wireless/patch/1608515579-1066-1-git-send-email-miaoqing@codeaurora.org/

No functional changes, compile tested only.

Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 335d49a..3c1f35a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4211,7 +4211,7 @@ static int ath11k_mac_mgmt_tx(struct ath11k *ar, struct sk_buff *skb,
 		return -ENOSPC;
 	}
 
-	if (skb_queue_len(q) == ATH11K_TX_MGMT_NUM_PENDING_MAX) {
+	if (skb_queue_len_lockless(q) >= ATH11K_TX_MGMT_NUM_PENDING_MAX) {
 		ath11k_warn(ar->ab, "mgmt tx queue is full\n");
 		return -ENOSPC;
 	}
-- 
2.7.4

