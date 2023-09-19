Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421D17A6BBA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjISTr4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 15:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjISTrz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 15:47:55 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091058F
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=r3AVtS8LMx42sab67/4YxULBiSv25yNlWWhJqXo7gp4=; b=Pn/WrIvxASiJkNwhJZVg1vO547
        EL31pQ/alIRummt80zh5rolUxfe/cGbVSx6nKXbMbNP4FWiAi/HBWhTIxYrOQZ2XYYrTEzoucKPFy
        ljkH5zGY0+rm5Vtb3mtoVM7tg+zc/HpAu+jasmfeMkpBQisCmQY3sV6V59DXc8wtyAdw=;
Received: from p54ae986d.dip0.t-ipconnect.de ([84.174.152.109] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qighI-004UxW-5j; Tue, 19 Sep 2023 21:47:48 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH wireless] wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling
Date:   Tue, 19 Sep 2023 21:47:47 +0200
Message-ID: <20230919194747.31647-1-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On MT76x0, LNA gain should be applied for both external and internal LNA.
On MT76x2, LNA gain should be treated as 0 for external LNA.
Move the LNA type based logic to mt76x2 in order to fix mt76x0.

Fixes: 2daa67588f34 ("mt76x0: unify lna_gain parsing")
Reported-by: Shiji Yang <yangshiji66@outlook.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c |  7 -------
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c  | 13 +++++++++++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
index 0acabba2d1a5..5d402cf2951c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
@@ -131,15 +131,8 @@ u8 mt76x02_get_lna_gain(struct mt76x02_dev *dev,
 			s8 *lna_2g, s8 *lna_5g,
 			struct ieee80211_channel *chan)
 {
-	u16 val;
 	u8 lna;
 
-	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_2G)
-		*lna_2g = 0;
-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_5G)
-		memset(lna_5g, 0, sizeof(s8) * 3);
-
 	if (chan->band == NL80211_BAND_2GHZ)
 		lna = *lna_2g;
 	else if (chan->hw_value <= 64)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
index d5809408d1d3..8c01855885ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
@@ -256,7 +256,8 @@ void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
 	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	int channel = chan->hw_value;
 	s8 lna_5g[3], lna_2g;
-	u8 lna;
+	bool use_lna;
+	u8 lna = 0;
 	u16 val;
 
 	if (chan->band == NL80211_BAND_2GHZ)
@@ -275,7 +276,15 @@ void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
 	dev->cal.rx.mcu_gain |= (lna_5g[1] & 0xff) << 16;
 	dev->cal.rx.mcu_gain |= (lna_5g[2] & 0xff) << 24;
 
-	lna = mt76x02_get_lna_gain(dev, &lna_2g, lna_5g, chan);
+	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
+	if (chan->band == NL80211_BAND_2GHZ)
+		use_lna = !(val & MT_EE_NIC_CONF_1_LNA_EXT_2G);
+	else
+		use_lna = !(val & MT_EE_NIC_CONF_1_LNA_EXT_5G);
+
+	if (use_lna)
+		lna = mt76x02_get_lna_gain(dev, &lna_2g, lna_5g, chan);
+
 	dev->cal.rx.lna_gain = mt76x02_sign_extend(lna, 8);
 }
 EXPORT_SYMBOL_GPL(mt76x2_read_rx_gain);
-- 
2.41.0

