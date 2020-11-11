Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6B2AEEE2
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 11:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgKKKjd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 05:39:33 -0500
Received: from z5.mailgun.us ([104.130.96.5]:47525 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKKKjc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 05:39:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605091171; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Mzo0wjgLtM4+U8Upgrt0WCr4pnhikwIBupANOZ6rKLg=; b=CXQGA2n1QEnp4CKMBiihXcLJmXeAHGAwn975ZAtcJ8uJedlKuvvkX5IIfd0yyMUjKLjGfELg
 M+o+bB9WTocEa2zJW6XNTb9i+OK7RQyIxIJLSHB9BURSlft+18vfgoIF4MKWvRhB83R6S4k/
 D+Xc4GmdoIOf7rrSJNkB3/pNThc=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fabbf5937ede2253b229a8e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 10:39:21
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DA208C433C8; Wed, 11 Nov 2020 10:39:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ssreeela-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D95C7C433C6;
        Wed, 11 Nov 2020 10:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D95C7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH v2] ath11k: Fix the rx_filter flag setting for peer rssi stats
Date:   Wed, 11 Nov 2020 16:08:37 +0530
Message-Id: <1605091117-11005-1-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set the rx_filter in ath11k_mac_config_mon_status_default(),
only when the rx_filter value exists in ath11k_debug_rx_filter().

Without this change, rx_filter gets set to 0 and peer rssi stats
aren't updating properly from firmware.

Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01230-QCAHKSWPL_SILICONZ-4

Fixes: ec48d28ba291 ("ath11k: Fix rx_filter flags setting for per peer rx_stats")

Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---

    V2: Added the "Fixes" tag in the commit message.

 drivers/net/wireless/ath/ath11k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 591dceb..cad4402 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4144,7 +4144,8 @@ static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 
 	if (enable) {
 		tlv_filter = ath11k_mac_mon_status_filter_default;
-		tlv_filter.rx_filter = ath11k_debugfs_rx_filter(ar);
+		if (ath11k_debugfs_rx_filter(ar))
+			tlv_filter.rx_filter = ath11k_debugfs_rx_filter(ar);
 	}
 
 	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
-- 
2.7.4

