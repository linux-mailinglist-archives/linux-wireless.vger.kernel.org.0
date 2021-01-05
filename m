Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4421A2EA9ED
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbhAELbs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 06:31:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48070 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbhAELbs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 06:31:48 -0500
X-UUID: d8253c123a34410a888c57090733751c-20210105
X-UUID: d8253c123a34410a888c57090733751c-20210105
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 548956862; Tue, 05 Jan 2021 19:31:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 19:30:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 19:30:59 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 4/4] mt76: mt7615: mt7915: disable txpower sku when testmode enabled
Date:   Tue, 5 Jan 2021 19:30:45 +0800
Message-ID: <20210105113045.17815-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210105113045.17815-1-shayne.chen@mediatek.com>
References: <20210105113045.17815-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When testmode can be enabled, the start() callback would already be
called, causing that txpower sku feature isn't really disabled after
testmode is enabled. This patch fix the issue.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/testmode.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c | 2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 3fc48aaa3b36..18e6c5aac786 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -321,7 +321,7 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 	mt7615_mac_set_timing(phy);
 	ret = mt7615_dfs_init_radar_detector(phy);
 	mt7615_mac_cca_stats_reset(phy);
-	mt7615_mcu_set_sku_en(phy, !mt76_testmode_enabled(phy->mt76));
+	mt7615_mcu_set_sku_en(phy, true);
 
 	mt7615_mac_reset_counters(dev);
 	phy->noise = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
index b82915445d0d..6c602b086a49 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
@@ -138,6 +138,8 @@ mt7615_tm_init(struct mt7615_phy *phy)
 	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
 
+	mt7615_mcu_set_sku_en(phy, phy->mt76->test.state == MT76_TM_STATE_OFF);
+
 	mutex_unlock(&dev->mt76.mutex);
 	mt7615_set_channel(phy);
 	mt7615_ops.configure_filter(phy->mt76->hw, 0, &total_flags, 0);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3e0458fee937..d8f7e8b7bbb1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -44,7 +44,7 @@ static int mt7915_start(struct ieee80211_hw *hw)
 		mt7915_mac_enable_nf(dev, 1);
 	}
 
-	mt7915_mcu_set_sku_en(phy, !mt76_testmode_enabled(phy->mt76));
+	mt7915_mcu_set_sku_en(phy, true);
 	mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 68b170308c4a..da9ec7930cef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -402,6 +402,8 @@ mt7915_tm_init(struct mt7915_phy *phy, bool en)
 	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
 
+	mt7915_mcu_set_sku_en(phy, !en);
+
 	mt7915_tm_mode_ctrl(dev, en);
 	mt7915_tm_reg_backup_restore(phy);
 	mt7915_tm_set_trx(phy, TM_MAC_TXRX, !en);
-- 
2.29.2

