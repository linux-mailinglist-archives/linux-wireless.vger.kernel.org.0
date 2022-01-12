Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810F248CA75
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 18:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355828AbiALRyz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 12:54:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46354 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355832AbiALRyX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 12:54:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6AA36192E;
        Wed, 12 Jan 2022 17:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2D8C36AE5;
        Wed, 12 Jan 2022 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642010062;
        bh=Q9os2ABSFl47QrbnsOTijsCUiUYHfX39UMIdxfxkTg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YqUOfzGtYQ1Bbk6P8Ahyxz0+JULEYlyCFmoWwJ2FVx+efB1ocGYlZdZOGCGCuViP2
         Nnu33tmFC0kw5JXULrOW+wP+N5BKbUkSHBuHpqqzy00C49Q+DEWmojTMlEQGt2qVAJ
         k5eVSKKt68kYJBByXtBfe3QkKkPbIjLk6Q3NNNFZt8fi8/0OMy0SR/K1R/2Z5yrgiX
         tLzUiFl59Qz+NyySJSRfk7jZ7OJMgHOQEwJ84fTW5LOCif4Q9PwJqY8eFMM+I4wZLj
         EGxD/VNfwaPwSjQudFXyiQWHIfB14spDtTNjW//jKzAIWH3G9SprbwLBE2y4ZnXh9C
         PMtdFns59xGDw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com, devicetree@vger.kernel.org, robh@kernel.org
Subject: [PATCH v2 4/6] mt76: mt7915: report radar pattern if detected by rdd2
Date:   Wed, 12 Jan 2022 18:53:53 +0100
Message-Id: <db122b67bacde6e00677494a66ce6080b59f9924.1642009736.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642009736.git.lorenzo@kernel.org>
References: <cover.1642009736.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report radar pattern to mac80211 if detected by the
offchannel chain.

Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index dddefeebc7dd..e42900b2545f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -358,7 +358,12 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (r->band_idx && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
-	ieee80211_radar_detected(mphy->hw);
+	if (r->band_idx == MT_RX_SEL2)
+		cfg80211_background_radar_event(mphy->hw->wiphy,
+						&dev->rdd2_chandef,
+						GFP_ATOMIC);
+	else
+		ieee80211_radar_detected(mphy->hw);
 	dev->hw_pattern++;
 }
 
-- 
2.34.1

