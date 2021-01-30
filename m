Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EAD309518
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Jan 2021 13:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhA3M3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Jan 2021 07:29:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:32786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhA3M3j (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Jan 2021 07:29:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B468264E0A;
        Sat, 30 Jan 2021 12:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612009738;
        bh=Gwc7vUiEZvimS+IIMKUpR78vlH/Cub57vXOGFvL0r0w=;
        h=From:To:Cc:Subject:Date:From;
        b=AUAzPVv3swYXRlEssz8PjLSI4TTwJO9O4xJAt14DuGWt7FKP5elkpCWSeKnlAf7Fk
         EaG294t1FLbqCp8U+Tsp47r1pKnJkLOnRQV1sTaSQUAzlvtadrkyIHnGwmFb7145N5
         1xgbS+jbwAbxx6KS1kzJf4fE4305SoFeD18BeCmqkeAsU43B/ChasDOnMKqueYyrzi
         nE/1svSB4kggZ/I+J3lLL4j6KshYTuC0PTxdVT4cJABvPQDHXKfHdTLwQFWxcMRwSC
         VBlYcbF++ig+R9G6+hqFphRkd+UVn1PXVZXy+IRtcRgrDMj+Y0vFlh6A3C5tTDanxW
         jfF4naO0s/I6A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: enable random mac addr during scanning
Date:   Sat, 30 Jan 2021 13:28:36 +0100
Message-Id: <1de60edd8de6da4d482eed80908d510fd55dd79f.1612009684.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Notify mac80211 mt7921 devices support random mac address during hw
frequency scanning

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 89a13b4a74a4..4070f7156aa5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -95,6 +95,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	wiphy->reg_notifier = mt7921_regd_notifier;
 
+	wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
 
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
-- 
2.29.2

