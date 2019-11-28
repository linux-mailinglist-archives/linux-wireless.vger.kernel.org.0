Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5F10C4DF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 09:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfK1IVq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 03:21:46 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:54578
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbfK1IVq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 03:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574929305;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=sEGOELBgXukVU9+vmbil9rrl31RCGE4lmVVW+Rgl6ao=;
        b=AzysRx/4DWFV8KcMP/q7eKFtyu/EaxyQmSUL7z0iBdZft/SWrRk3gemhQ11YuaC9
        +JUk454CyczW5WndUfpsL1Sba3Qr4lXe/sk8l/CS39lvJXnWKxGjZE3SJzJehAwoQA4
        vh/peC3pOS/4DLZkiV4+Xl+GWz6UF8p3Pp1efXjM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574929305;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=sEGOELBgXukVU9+vmbil9rrl31RCGE4lmVVW+Rgl6ao=;
        b=BWV+oAQ4n1bjBysAIHaCdb9wtPZv7dC0z0+pEA4GPrhTaqKHx/J66EvtcHBRfrik
        pnqMd87BkDr+cK23rVlZZoT0jyqnoI2L66ySjIgpH6o874ViCMU3Gjayk3TcxTtSy5/
        JM74qR96CVl2sApoZWGD1NFS+K8Klgmc1bmTmjc0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46A36C447A6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 1/9] ath11k: Update tx and rx chain count properly on drv_set_antenna
Date:   Thu, 28 Nov 2019 08:21:45 +0000
Message-ID: <0101016eb11a10c9-dd904af5-539a-4c05-9ffc-3a1cc33b99f5-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
References: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.28-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sriram R <srirrama@codeaurora.org>

Set the number of tx and rx chains properly on drv_set_antenna().
This will ensure the related ht/vht/he caps are properly recalculated
based on the tx/rx chains set.

Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 5231c4fa0e38..5ee7c2a1c611 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3480,6 +3480,8 @@ static int __ath11k_set_antenna(struct ath11k *ar, u32 tx_ant, u32 rx_ant)
 		return ret;
 	}
 
+	ar->num_tx_chains = get_num_chains(tx_ant);
+
 	ret = ath11k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_RX_CHAIN_MASK,
 					rx_ant, ar->pdev->pdev_id);
 	if (ret) {
@@ -3488,6 +3490,8 @@ static int __ath11k_set_antenna(struct ath11k *ar, u32 tx_ant, u32 rx_ant)
 		return ret;
 	}
 
+	ar->num_rx_chains = get_num_chains(rx_ant);
+
 	/* Reload HT/VHT/HE capability */
 	ath11k_mac_setup_ht_vht_cap(ar, &ar->pdev->cap, NULL);
 	ath11k_mac_setup_he_cap(ar, &ar->pdev->cap);
-- 
2.7.4

