Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF41F3E59
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 16:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgFIOh4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 10:37:56 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:53358 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgFIOhz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 10:37:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591713474; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=x3xaCreLDWCWMm/61Pzv9QVhDGp7Kp5XpItDeIrb15s=; b=L3f4T7A2aBSORgVXMQGYxJ9nOaKuv6qshVhq+2fb2wnVM0eeCjGvgj9/oInKFoeA3QRJSJEE
 +4CSYnD2gtCNaX7mJlOJLNboTxCgwGsZclcvT2rzIqtDh3+/mDOOZWcAR/40ctxPy3LlibF7
 b85Wn6H215+oHzTE5ZhaDgGu41w=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5edf9ec18fe116ddd9e96159 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 14:37:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F2512C43387; Tue,  9 Jun 2020 14:37:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from ssreeela-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ssreeela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C14AC433CA;
        Tue,  9 Jun 2020 14:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C14AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ssreeela@codeaurora.org
From:   Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Subject: [PATCH] ath11k: removing redundant reo unlock followed by immediate lock
Date:   Tue,  9 Jun 2020 20:07:12 +0530
Message-Id: <1591713432-26426-1-git-send-email-ssreeela@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Removed reo cmd lock and unlock which was acquiring the lock immediately
after unlock. Done for code clean up.

Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index a54610d..a010cf7 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -653,10 +653,8 @@ static void ath11k_dp_rx_tid_del_func(struct ath11k_dp *dp, void *ctx,
 	spin_lock_bh(&dp->reo_cmd_lock);
 	list_add_tail(&elem->list, &dp->reo_cmd_cache_flush_list);
 	dp->reo_cmd_cache_flush_count++;
-	spin_unlock_bh(&dp->reo_cmd_lock);
 
 	/* Flush and invalidate aged REO desc from HW cache */
-	spin_lock_bh(&dp->reo_cmd_lock);
 	list_for_each_entry_safe(elem, tmp, &dp->reo_cmd_cache_flush_list,
 				 list) {
 		if (dp->reo_cmd_cache_flush_count > DP_REO_DESC_FREE_THRESHOLD ||
-- 
2.7.4

