Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D141948C5BB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 15:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354008AbiALOO6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 09:14:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34220 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354009AbiALOOj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 09:14:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EEECB81EF9
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 14:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E256C36AEA;
        Wed, 12 Jan 2022 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641996877;
        bh=Q9os2ABSFl47QrbnsOTijsCUiUYHfX39UMIdxfxkTg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0DfC5d9LXx4ETqrJ8mvX/dNikVBp3wwb6ScSA+oxtZWIILaA2jTKUdeM+Knw2pRl
         tdedIWaGDqASZ3gFolIGMiFPwcc0ANMZwZ726rMLFYx+hH0mDvBJ0Ae0xkvsif4ge4
         xj5Pj/X+dJvaZIVjhBo+p3rQWiSfxfJ6hOKSF8Sv5fnVwhyx0XiqkHTO3K/cgXSlUv
         y42X21mf7fEVbMScPU/LGBMozc/XucbkasOGC+TOZDxnMmjHeh+gXeMwjmsbRPk+kz
         RG/kpx2XC4Qr+Pd1vnxFpzcbSrkPJCnBtTt00aDoIxnNpdqPNAWC83ZU48TCZXBr9M
         hFt+5NDbzX5kA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com
Subject: [PATCH 4/6] mt76: mt7915: report radar pattern if detected by rdd2
Date:   Wed, 12 Jan 2022 15:13:51 +0100
Message-Id: <db122b67bacde6e00677494a66ce6080b59f9924.1641996493.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641996493.git.lorenzo@kernel.org>
References: <cover.1641996493.git.lorenzo@kernel.org>
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

