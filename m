Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1873A275FC8
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Sep 2020 20:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIWS0I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Sep 2020 14:26:08 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:21195 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgIWS0H (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Sep 2020 14:26:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600885567; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=iVhmGH5diRPbgyxf6v1F5VmtVZp7NDdEZrIEJJI4kLg=; b=e3FLUeGdMjHVgNQBaj+pnSP7tdMkpAOEWygIYHSwYYd3TNB3vn+HLM2n+PlrudwIlczPQyb1
 F1Qd6sVKSm4gAyYzZjguqP1WCQkJtBerapTzx7afARC23AP0EEJCx+CvX50rPbWJGiIBzIny
 HgvJ12tBcNNBDrmr+3yjaRsPT1E=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f6b931a31df7883e55eed9a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Sep 2020 18:25:29
 GMT
Sender: kathirve=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EA025C433C8; Wed, 23 Sep 2020 18:25:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from akalaise-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirve)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A5DAC433CA;
        Wed, 23 Sep 2020 18:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A5DAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kathirve@codeaurora.org
From:   Karthikeyan Kathirvel <kathirve@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <kathirve@codeaurora.org>
Subject: [PATCH] ath11k: removing the ath11k debugfs dir properly
Date:   Wed, 23 Sep 2020 23:55:19 +0530
Message-Id: <1600885519-29535-1-git-send-email-kathirve@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath11k_debug_pdev_destroy was not called for proper cleaning of debug
files when destroying the pdev, this results in not removing the ath11k
directory in debugfs folder even after rmmod of ath11k. So when next
time doing insmod of ath11k prevents creating another ath11k directory,
hence causing ipq8074_2 to get created in parent dir of debugfs.

Signed-off-by: Karthikeyan Kathirvel <kathirve@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 0ba234a..c4759bb 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -973,6 +973,7 @@ void ath11k_debug_soc_destroy(struct ath11k_base *ab)
 {
 	debugfs_remove_recursive(ab->debugfs_soc);
 	ab->debugfs_soc = NULL;
+	ath11k_debug_pdev_destroy(ab);
 }
 
 void ath11k_debug_fw_stats_init(struct ath11k *ar)
-- 
2.7.4

