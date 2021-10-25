Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BAB4390FB
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 10:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhJYITN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 04:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJYITN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 04:19:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D9C061745
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 01:16:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d3so7103036wrh.8
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/ONHwovzGtX6c4QtNm3dsEQglHqM8sqBpiVTMmVOH/E=;
        b=iSk33Ikv4ZsQOw+/PcaHGspL+SDokjPfkC0ZtGZIpGxaQyk4Sn3FNO7KwZ1IkeAY6C
         Oqo1WlySWRS3Xx33kaIVxgE3PB00n8WCJSU4HWzsjkgcN5sGCnzdq7/UTff1oSEsntrc
         pHViH+xb7/mUccTwDjtOK7bE/Op+TFLCyNn42OB2nTHFNqd3v2bTZBLK+Dp6gBLhpxmQ
         kHRsoWXHZACOjz4KHFUEqlXG/yMKzB6M3BuFGlANcq1KIeJa0fHxRo64GYTdG3SSXv3N
         iWCi3ZgJ90cTSBn0JlXCmf+5tOkvh3hAexJVP9iY0UFMUWimO3ihY0JcIGhGmgsOf/xl
         MqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ONHwovzGtX6c4QtNm3dsEQglHqM8sqBpiVTMmVOH/E=;
        b=f36sCNKtPhgowvflYJaeXTC/bdEfX+Ch3xfi2ogcqjrqCtr3ZvpIIhng/7kim59528
         gdpQLdTK11CyIPKnVqfCs/ThtC5yTQlT32WlIVimQxU5mHbS3zMLZeeKcrdmKtpBqKG8
         PiFr0/QQrbIJfsFGRj6uwTuCoAlwWr6aTdtWKfNL987ZBQCO3cQoljVaMLAeIFj/WwD/
         FQbyDMFKf3wvEH/7km9paftuc4P4nozzbe6MXRj6s2jqZz7byQhubtqDrMJbdm2FEfX3
         c2k3iWQOTbsu9Aqano4S/Pe532TO9zVdgXK7r3y2fDDqLMYFG3lxz/7T0UlijyEGj8Ja
         23OQ==
X-Gm-Message-State: AOAM531lqK4aEaC0Yf4SkywSGuzKWJwKxovmSEOX5r5A/lzowJQ0rj6w
        wgpr1kSsFkeS3qUmKqyKNW1P1w==
X-Google-Smtp-Source: ABdhPJyaKZkr61uCpnaLAvqlIj+zkqC/xnMu2Er/c2CZOlrOm96Lut2Xne4rTrwQFGNsP0wZSaTwgA==
X-Received: by 2002:adf:e0c1:: with SMTP id m1mr21987545wri.241.1635149809805;
        Mon, 25 Oct 2021 01:16:49 -0700 (PDT)
Received: from localhost.localdomain ([88.160.176.23])
        by smtp.gmail.com with ESMTPSA id 12sm6409449wmk.34.2021.10.25.01.16.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 01:16:49 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] wcn36xx: Fix packet drop on resume
Date:   Mon, 25 Oct 2021 10:28:16 +0200
Message-Id: <1635150496-19290-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the system is resumed because of an incoming packet, the wcn36xx RX
interrupts is fired before actual resuming of the wireless/mac80211
stack, causing any received packets to be simply dropped. E.g. a ping
request causes a system resume, but is dropped and so never forwarded
to the IP stack.

This change fixes that, disabling DMA interrupts on suspend to no pass
packets until mac80211 is resumed and ready to handle them.

Note that it's not incompatible with RX irq wake.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index a42eae6..a650b9e 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1137,6 +1137,13 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 			goto out;
 		ret = wcn36xx_smd_wlan_host_suspend_ind(wcn);
 	}
+
+	/* Disable IRQ, we don't want to handle any packet before mac80211 is
+	 * resumed and ready to receive packets.
+	 */
+	disable_irq(wcn->tx_irq);
+	disable_irq(wcn->rx_irq);
+
 out:
 	mutex_unlock(&wcn->conf_mutex);
 	return ret;
@@ -1159,6 +1166,10 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 		wcn36xx_smd_ipv6_ns_offload(wcn, vif, false);
 		wcn36xx_smd_arp_offload(wcn, vif, false);
 	}
+
+	enable_irq(wcn->tx_irq);
+	enable_irq(wcn->rx_irq);
+
 	mutex_unlock(&wcn->conf_mutex);
 
 	return 0;
-- 
2.7.4

