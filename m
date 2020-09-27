Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D617627A1FF
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 19:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgI0RS4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 13:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgI0RSz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 13:18:55 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE56C0613D4
        for <linux-wireless@vger.kernel.org>; Sun, 27 Sep 2020 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dZnHe2jLwdtBgthKgZO6QJCRLXX/5rfQXUloZEPEtgo=; b=hYISNVTV4inUIxxIxCSh8OBv2K
        c81DtdQIQAYsqB0UiztlFvlZ4KO1s8XPDx6lNOfuPXoAcDZSAyOF6JknMoDQgo0xqBUgo1VyXzqcQ
        2JeYh0FP5ECenv1+u1+tPBAkKp3rrmTtdLDmSy35h/6okd9sfC29cLwG83H+tkuYJ7m0=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kMaK6-0002oU-7B
        for linux-wireless@vger.kernel.org; Sun, 27 Sep 2020 19:18:54 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/8] mt76: do not set NEEDS_UNIQUE_STA_ADDR for 7615 and 7915
Date:   Sun, 27 Sep 2020 19:18:49 +0200
Message-Id: <20200927171852.48669-5-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200927171852.48669-1-nbd@nbd.name>
References: <20200927171852.48669-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The newer chipsets can deal with the same STA on multiple interfaces
Preparation for supporting more station interfaces

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c     | 1 -
 drivers/net/wireless/mediatek/mt76/mt7603/init.c  | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 4e0ed9c79d50..a778ecc65261 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -314,7 +314,6 @@ mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, MFP_CAPABLE);
 	ieee80211_hw_set(hw, AP_LINK_PS);
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
-	ieee80211_hw_set(hw, NEEDS_UNIQUE_STA_ADDR);
 
 	wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 	wiphy->interface_modes =
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index c4848fafd270..619a97a8ea21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -557,6 +557,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 	ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
+	ieee80211_hw_set(hw, NEEDS_UNIQUE_STA_ADDR);
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 11b769af2f8f..ea31650a01b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -186,6 +186,7 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 
 	ieee80211_hw_set(hw, SUPPORTS_HT_CCK_RATES);
 	ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
+	ieee80211_hw_set(hw, NEEDS_UNIQUE_STA_ADDR);
 
 	dev->mt76.global_wcid.idx = 255;
 	dev->mt76.global_wcid.hw_key_idx = -1;
-- 
2.28.0

