Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424A431C6C9
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Feb 2021 08:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhBPH0A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Feb 2021 02:26:00 -0500
Received: from z11.mailgun.us ([104.130.96.11]:10219 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhBPHZ6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Feb 2021 02:25:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613460316; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=sfa4zshTQA5vOm9ovAyQGJXLn6zV4taiMCEtBh2yJB0=; b=dwBa8bnaRcmTFzYqkv1kWACmfEKfbHJx4MeJe/J47UWf5SYto8nYNevgSbVt+ymayY/xarhI
 Hbj8UX9Hq5yDOF+ZMcx0wuViDsdgJYuNHLXq9kPRrwkPgR4ygscwY9vjQK8uRiChbJzQpn7V
 lT1KDiVnUDT0vM4tqxVum37X70E=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 602b733d7bd8735272376a4a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Feb 2021 07:24:45
 GMT
Sender: lavaks=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 41B42C433ED; Tue, 16 Feb 2021 07:24:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from lavaks-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: lavaks)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6006BC433CA;
        Tue, 16 Feb 2021 07:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6006BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=lavaks@codeaurora.org
From:   Lavanya Suresh <lavaks@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Lavanya Suresh <lavaks@codeaurora.org>
Subject: [PATCH] ath11k: Enable radar detection for 160MHz secondary segment
Date:   Tue, 16 Feb 2021 12:54:36 +0530
Message-Id: <1613460276-25469-1-git-send-email-lavaks@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WMI_CHAN_INFO_DFS_FREQ2 needs to be set in wmi vdev start command chan
info parameter, to enable radar detection for secondary segment in 160MHz.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01717-QCAHKSWPL_SILICONZ-1

Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 893d74a..8dae097 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5757,13 +5757,14 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 		arg.channel.chan_radar =
 			!!(chandef->chan->flags & IEEE80211_CHAN_RADAR);
 
+		arg.channel.freq2_radar =
+			!!(chandef->chan->flags & IEEE80211_CHAN_RADAR);
+
 		arg.channel.passive = arg.channel.chan_radar;
 
 		spin_lock_bh(&ab->base_lock);
 		arg.regdomain = ar->ab->dfs_region;
 		spin_unlock_bh(&ab->base_lock);
-
-		/* TODO: Notify if secondary 80Mhz also needs radar detection */
 	}
 
 	arg.channel.passive |= !!(chandef->chan->flags & IEEE80211_CHAN_NO_IR);
-- 
2.7.4

