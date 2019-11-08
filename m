Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18378F4318
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 10:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfKHJ1O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 04:27:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfKHJ1O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 04:27:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E2DF060B10; Fri,  8 Nov 2019 09:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205233;
        bh=MXRrR272K4L57WpsQjUTIys8HBj3jgc32RjyHnjlSkg=;
        h=From:To:Cc:Subject:Date:From;
        b=e8uBCqvU2sX5L7XdQncsOktSKIRmdK1EH13Q9OM8yjnrfvGsebWeM6lmpjg6vezKx
         oebqSY5/aSvbCVFhgWqozkUEJWZMnVbOvAO5wLaowY2y+k7V4GKJ9reH4xGZ5RIiRH
         3KyZ0ynwS5vp6LNuqTp/TE+JPD7tncf+5zGuXfNo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C08F860A63;
        Fri,  8 Nov 2019 09:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205233;
        bh=MXRrR272K4L57WpsQjUTIys8HBj3jgc32RjyHnjlSkg=;
        h=From:To:Cc:Subject:Date:From;
        b=e8uBCqvU2sX5L7XdQncsOktSKIRmdK1EH13Q9OM8yjnrfvGsebWeM6lmpjg6vezKx
         oebqSY5/aSvbCVFhgWqozkUEJWZMnVbOvAO5wLaowY2y+k7V4GKJ9reH4xGZ5RIiRH
         3KyZ0ynwS5vp6LNuqTp/TE+JPD7tncf+5zGuXfNo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C08F860A63
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] ath10k: add NL80211_FEATURE_ND_RANDOM_MAC_ADDR for NLO
Date:   Fri,  8 Nov 2019 17:27:06 +0800
Message-Id: <20191108092706.17060-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add NL80211_FEATURE_ND_RANDOM_MAC_ADDR for NLO will enable the random
mac address for netdetect case.
iw command:
iw phy0 wowlan enable net-detect net-detect
randomize=AA:7B:A1:AC:B2:41/FF:FF:FF:FF:FF:FF interval 5000 delay 30
freqs 2412 matches ssid foo.
After suspend, DUT will send probe request with mac AA:7B:A1:AC:B2:41.

WCN3990, QCA9377, QCA6174 PCI also support this feature.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00029.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v2: change commit log 
drivers/net/wireless/ath/ath10k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index e8bdb2ba9b18..753a6a174106 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8911,6 +8911,7 @@ int ath10k_mac_register(struct ath10k *ar)
 			WMI_PNO_MAX_SCHED_SCAN_PLAN_INT;
 		ar->hw->wiphy->max_sched_scan_plan_iterations =
 			WMI_PNO_MAX_SCHED_SCAN_PLAN_ITRNS;
+		ar->hw->wiphy->features |= NL80211_FEATURE_ND_RANDOM_MAC_ADDR;
 	}
 
 	ar->hw->vif_data_size = sizeof(struct ath10k_vif);
-- 
2.23.0

