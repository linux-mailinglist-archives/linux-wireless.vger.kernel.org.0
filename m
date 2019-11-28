Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 132FE10C4E0
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 09:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfK1IVs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 03:21:48 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:41290
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbfK1IVs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 03:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574929307;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=v5x3u/SOMrsGref20eNJy3xwG6ss0dzL+7zh2dH5bTE=;
        b=KbGpLuUFO2Twcn7ioEm3SVbTWzpns9BixdiWUbh8wTYTw71HMy+kipTpEO9cmQ/z
        kfnyaeKjj4S0BYPFjrV2l5tV5bmIu2WAEtu3o5nXfdF6kK/W88cgCkgfAAJKXFxrq+/
        X4vAtJl6QT1y+e15rIgIWu724LVt/1l+CkbqQGOA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574929307;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=v5x3u/SOMrsGref20eNJy3xwG6ss0dzL+7zh2dH5bTE=;
        b=CMPNBR4jlGeF34b1z0DB7w5exxblkTKrgKzXIzBVaqjK7U/xnMEzkaTS7rkpdUq4
        d9cAc/BIQcVrAqQEj2eMVRFmsOFwTF2kKq4oHOccWLPT9MgS8tvGxwt2PFiANK7ynVO
        hQ33XVK1dVKMg2QoIHbOlQntn8gj+OlIcrAM2lN4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A85F0C447AF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 2/9] ath11k: Advertise MPDU start spacing as no restriction
Date:   Thu, 28 Nov 2019 08:21:47 +0000
Message-ID: <0101016eb11a16cc-733e674c-13f1-45bb-8822-0f2225eaa4a5-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
References: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.28-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <vnaralas@codeaurora.org>

Adverise MPDU start spacing as no restriction in ht capabilities,
Since IPQ8074 hw support all sorts of mpdu start spcing. With this
observed minor uplink performance improvement in lower data frame
size case with Veriwave clients.

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 5ee7c2a1c611..b048057b398f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3089,7 +3089,7 @@ ath11k_create_ht_cap(struct ath11k *ar, u32 ar_ht_cap, u32 rate_cap_rx_chainmask
 
 	ht_cap.ht_supported = 1;
 	ht_cap.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
-	ht_cap.ampdu_density = IEEE80211_HT_MPDU_DENSITY_8;
+	ht_cap.ampdu_density = IEEE80211_HT_MPDU_DENSITY_NONE;
 	ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
 	ht_cap.cap |= IEEE80211_HT_CAP_DSSSCCK40;
 	ht_cap.cap |= WLAN_HT_CAP_SM_PS_STATIC << IEEE80211_HT_CAP_SM_PS_SHIFT;
-- 
2.7.4

