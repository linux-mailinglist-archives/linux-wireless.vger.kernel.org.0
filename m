Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037A132E3E5
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Mar 2021 09:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhCEIqy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Mar 2021 03:46:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60173 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229558AbhCEIqs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Mar 2021 03:46:48 -0500
X-UUID: 2e6eecb41bd04971800f177d1f68bc76-20210305
X-UUID: 2e6eecb41bd04971800f177d1f68bc76-20210305
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 978736947; Fri, 05 Mar 2021 16:46:44 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Mar 2021 16:46:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Mar 2021 16:46:42 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix possible deadlock while mt7915_register_ext_phy()
Date:   Fri, 5 Mar 2021 16:46:41 +0800
Message-ID: <96aaea810b92f701e74b27cf030f9ddced6f4a63.1614932804.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_register_hw() is called with rtnl_lock held, and this could be
caused lockdep from a work item that's on a workqueue that is flushed
with the rtnl held.

Move mt7915_register_ext_phy() outside the init_work().

Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 7 ++++---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 165be6abcc96..2ffadd22c259 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -181,8 +181,6 @@ static void mt7915_mac_init(struct mt7915_dev *dev)
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 	for (i = 0; i < 2; i++)
 		mt7915_mac_init_band(dev, i);
-
-	mt7915_mcu_set_rts_thresh(&dev->phy, 0x92b);
 }
 
 static int mt7915_txbf_init(struct mt7915_dev *dev)
@@ -295,7 +293,6 @@ static void mt7915_init_work(struct work_struct *work)
 	mt7915_mac_init(dev);
 	mt7915_init_txpower(dev);
 	mt7915_txbf_init(dev);
-	mt7915_register_ext_phy(dev);
 }
 
 static int mt7915_init_hardware(struct mt7915_dev *dev)
@@ -677,6 +674,10 @@ int mt7915_register_device(struct mt7915_dev *dev)
 
 	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
 
+	ret = mt7915_register_ext_phy(dev);
+	if (ret)
+		return ret;
+
 	return mt7915_init_debugfs(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 255f87aa1830..cde8c1ce3ae0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -65,6 +65,10 @@ static int mt7915_start(struct ieee80211_hw *hw)
 		mt7915_mac_enable_nf(dev, 1);
 	}
 
+	ret = mt7915_mcu_set_rts_thresh(phy, 0x92b);
+	if (ret)
+		goto out;
+
 	ret = mt7915_mcu_set_sku_en(phy, true);
 	if (ret)
 		goto out;
-- 
2.18.0

