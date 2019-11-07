Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD10F2CCD
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 11:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfKGKvD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 05:51:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58056 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfKGKvD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 05:51:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A93E60A1B; Thu,  7 Nov 2019 10:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573123861;
        bh=LOcMY5sQJkRQiah+/yf73QQL0fTF1BGHLYaI6N12Bgg=;
        h=From:To:Cc:Subject:Date:From;
        b=KnCq1uPsh3ILruKaxqMdjmsieSqfjCFhziitN9PfDFucqSOQjzvWtk2VD5Eoo+360
         tJFBXGkugiAtOWKpm7vKdgqBE48CxAqiBFBkWnw+2GTIeAemRaH0/qp6DU7OKBQXS3
         /tmVfpoa5wXHeuu2gXzltgr5n7PT4Wt2BU6Gpo1I=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 798AC60721;
        Thu,  7 Nov 2019 10:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573123860;
        bh=LOcMY5sQJkRQiah+/yf73QQL0fTF1BGHLYaI6N12Bgg=;
        h=From:To:Cc:Subject:Date:From;
        b=PCoQ9Yan1bpiE8cxerM4/u+yQ4ITZzTL6T3aUx+J5uWEzywstjNMnQI/3yCWNXDc2
         TMNIqKYD/TItF3aF2T9r/5VKYkBfd3SHP5/qWnLsdVfBG1+htR1oc98Vgzl9ap2YkZ
         WLnV+3EKjuNI5PDVbQROH8bqoBsEYFOvBefrQ+VM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 798AC60721
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: add NL80211_FEATURE_ND_RANDOM_MAC_ADDR for NLO
Date:   Thu,  7 Nov 2019 18:50:47 +0800
Message-Id: <20191107105047.24084-1-wgong@codeaurora.org>
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

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00029.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
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

