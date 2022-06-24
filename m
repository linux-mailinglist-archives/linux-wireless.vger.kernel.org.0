Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7317255A196
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jun 2022 21:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiFXTNk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jun 2022 15:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiFXTNG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jun 2022 15:13:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7345FCB
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jun 2022 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=n6vH+nPkFRprnxFcyyNMoSHX9CSINWA2seA8qtmF4AI=; b=pXTN+zHSll9c+K9xUSN/f+shTI
        E5rIjLTNZH5xzM/LyLkp/bEWuEnEMTj+xDVueqIYx8v+8qpWXSLlb1aWUnF6E6uTi/QJ2NGAJ4hSK
        NsFV0AjvJsjCHmKXVrqgushI1tLr1+3wJtMcUOBNceMdiuj/gG2RrLaCt3sBy7VfogNA=;
Received: from p200300daa71a4800391046fbc91acf5a.dip0.t-ipconnect.de ([2003:da:a71a:4800:3910:46fb:c91a:cf5a] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o4ojm-0002r8-No
        for linux-wireless@vger.kernel.org; Fri, 24 Jun 2022 21:13:02 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] mt76: mt76x02: improve reliability of the beacon hang check
Date:   Fri, 24 Jun 2022 21:12:58 +0200
Message-Id: <20220624191300.52766-2-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624191300.52766-1-nbd@nbd.name>
References: <20220624191300.52766-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increment the counter only when writing beacons to the hardware in order
to avoid triggering restarts if beacons are disabled.
Additionally, avoid resetting the MAC if stopping it failed

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c |  6 +++++-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c    | 11 ++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index b72510949877..ad4dc8e17b58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -57,8 +57,11 @@ void mt76x02_mac_set_beacon(struct mt76x02_dev *dev,
 	int bcn_len = dev->beacon_ops->slot_size;
 	int bcn_addr = MT_BEACON_BASE + (bcn_len * dev->beacon_data_count);
 
-	if (!mt76x02_write_beacon(dev, bcn_addr, skb))
+	if (!mt76x02_write_beacon(dev, bcn_addr, skb)) {
+		if (!dev->beacon_data_count)
+			dev->beacon_hang_check++;
 		dev->beacon_data_count++;
+	}
 	dev_kfree_skb(skb);
 }
 EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon);
@@ -74,6 +77,7 @@ void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 	if (!dev->mt76.beacon_mask)
 		dev->tbtt_count = 0;
 
+	dev->beacon_hang_check = 0;
 	if (enable) {
 		dev->mt76.beacon_mask |= BIT(mvif->idx);
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index cf4d4110cc99..de30cf5e2d2f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -1044,10 +1044,9 @@ static void mt76x02_check_mac_err(struct mt76x02_dev *dev)
 			return;
 		}
 
-		if (++dev->beacon_hang_check < 10)
+		if (dev->beacon_hang_check < 10)
 			return;
 
-		dev->beacon_hang_check = 0;
 	} else {
 		u32 val = mt76_rr(dev, 0x10f4);
 		if (!(val & BIT(29)) || !(val & (BIT(7) | BIT(5))))
@@ -1057,10 +1056,16 @@ static void mt76x02_check_mac_err(struct mt76x02_dev *dev)
 	dev_err(dev->mt76.dev, "MAC error detected\n");
 
 	mt76_wr(dev, MT_MAC_SYS_CTRL, 0);
-	mt76x02_wait_for_txrx_idle(&dev->mt76);
+	if (!mt76x02_wait_for_txrx_idle(&dev->mt76)) {
+		dev_err(dev->mt76.dev, "MAC stop failed\n");
+		goto out;
+	}
 
+	dev->beacon_hang_check = 0;
 	mt76_set(dev, MT_MAC_SYS_CTRL, MT_MAC_SYS_CTRL_RESET_CSR);
 	udelay(10);
+
+out:
 	mt76_wr(dev, MT_MAC_SYS_CTRL,
 		MT_MAC_SYS_CTRL_ENABLE_TX | MT_MAC_SYS_CTRL_ENABLE_RX);
 }
-- 
2.36.1

