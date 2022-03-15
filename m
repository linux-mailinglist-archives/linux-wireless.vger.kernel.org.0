Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E44DA33F
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 20:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349427AbiCOT0b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345075AbiCOT03 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 15:26:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024FDDF78
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 12:25:12 -0700 (PDT)
X-UUID: b4bab388bb5e49adb12f12719c61ab7d-20220316
X-UUID: b4bab388bb5e49adb12f12719c61ab7d-20220316
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 489296570; Wed, 16 Mar 2022 03:25:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Mar 2022 03:25:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Mar 2022 03:25:04 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: mt7921: don't enable beacon filter when IEEE80211_CONF_CHANGE_MONITOR is set
Date:   Wed, 16 Mar 2022 03:25:03 +0800
Message-ID: <c7708dc79cff3ee66e4e60f48e9023ad0cece33a.1647372083.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

IEEE80211_CONF_CHANGE_MONITOR would be set every time even when vif runs as
sta mode.

If vif runs as sta mode, the beacon filter would be falsely enabled
earlier than the associated state.

That is not the behavior the firmware expects and also breaks the original
logic of sta mode. Thus, we only limit the operation to set the beacon
filter only for monitor mode when IEEE80211_CONF_CHANGE_MONITOR is set.

Fixes: 4ad65a54617c ("mt76: mt7921: toggle runtime-pm adding a monitor vif")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index e5dcf1615f17..cfa813bd627a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -484,9 +484,17 @@ mt7921_sniffer_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	struct mt7921_dev *dev = priv;
 	struct ieee80211_hw *hw = mt76_hw(dev);
-	bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+	struct mt76_connac_pm *pm = &dev->pm;
+	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+	mt7921_mcu_set_sniffer(dev, vif, monitor);
+	pm->enable = !monitor;
+	pm->ds_enable = !monitor;
+
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 
-	mt7921_mcu_set_sniffer(dev, vif, enabled);
+	if (monitor)
+		mt7921_mcu_set_beacon_filter(dev, vif, false);
 }
 
 void mt7921_set_runtime_pm(struct mt7921_dev *dev)
@@ -530,7 +538,6 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 						    IEEE80211_IFACE_ITER_RESUME_ALL,
 						    mt7921_sniffer_interface_iter, dev);
 		dev->mt76.rxfilter = mt76_rr(dev, MT_WF_RFCR(0));
-		mt7921_set_runtime_pm(dev);
 	}
 
 out:
-- 
2.25.1

