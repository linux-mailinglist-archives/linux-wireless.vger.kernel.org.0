Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F3E4977AE
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jan 2022 04:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbiAXD21 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Jan 2022 22:28:27 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:54570 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241038AbiAXD20 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Jan 2022 22:28:26 -0500
X-UUID: 9e059a6af36148fdb4724737b9f63c95-20220124
X-UUID: 9e059a6af36148fdb4724737b9f63c95-20220124
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <xing.song@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1614654800; Mon, 24 Jan 2022 11:28:23 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Jan 2022 11:28:22 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 Jan
 2022 11:28:19 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 24 Jan 2022 11:28:18 +0800
From:   Xing Song <xing.song@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Xing Song" <xing.song@mediatek.com>
Subject: [PATCH] mt76: stop the radar detector after leaving dfs channel
Date:   Mon, 24 Jan 2022 11:28:11 +0800
Message-ID: <20220124032811.47087-1-xing.song@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The radar detctor is used for dfs channel. So it will start after switching
to dfs channel and will stop after leaving. The TX will be blocked if radar
detctor isn't stopped in non-dfs channel.

This patch resets the dfs state to indicate the radar detector needs to be
stopped.

Signed-off-by: Xing Song <xing.song@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 9f7ac78f1222..a5432fd5cb93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -291,7 +291,8 @@ static void mt7615_init_dfs_state(struct mt7615_phy *phy)
 	if (hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		return;
 
-	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
+	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
+	    !(mphy->chandef.chan->flags & IEEE80211_CHAN_RADAR))
 		return;
 
 	if (mphy->chandef.chan->center_freq == chandef->chan->center_freq &&
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 41b0a4d8b93e..7e03b2a137af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -311,7 +311,8 @@ static void mt7915_init_dfs_state(struct mt7915_phy *phy)
 	if (hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		return;
 
-	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
+	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
+	    !(mphy->chandef.chan->flags & IEEE80211_CHAN_RADAR))
 		return;
 
 	if (mphy->chandef.chan->center_freq == chandef->chan->center_freq &&
-- 
2.17.0

