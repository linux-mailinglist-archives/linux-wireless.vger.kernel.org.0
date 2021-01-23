Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EE03013FD
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 09:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbhAWIhf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 03:37:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50200 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726934AbhAWIhX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 03:37:23 -0500
X-UUID: f3cd9087624c473488dbcc1ca73cfdee-20210123
X-UUID: f3cd9087624c473488dbcc1ca73cfdee-20210123
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1441380308; Sat, 23 Jan 2021 16:35:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 23 Jan 2021 16:35:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Jan 2021 16:35:17 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v7 18/22] mt76: mt7921: introduce regdomain notifier support
Date:   Sat, 23 Jan 2021 16:35:09 +0800
Message-ID: <6104d5fa9558ab2687c790690afdde55b35a8235.1611389300.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611389300.git.objelf@gmail.com>
References: <cover.1611389300.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Register regdomain notifier to determine the channel domain the hw scan
should rely on.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index efc3e94f89d5..2a80b68a588a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -52,6 +52,21 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	}
 };
 
+static void
+mt7921_regd_notifier(struct wiphy *wiphy,
+		     struct regulatory_request *request)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
+	dev->mt76.region = request->dfs_region;
+
+	mt7921_mutex_acquire(dev);
+	mt76_connac_mcu_set_channel_domain(hw->priv);
+	mt7921_mutex_release(dev);
+}
+
 static void
 mt7921_init_wiphy(struct ieee80211_hw *hw)
 {
@@ -78,6 +93,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->max_match_sets = MT76_CONNAC_MAX_SCAN_MATCH;
 	wiphy->max_sched_scan_reqs = 1;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	wiphy->reg_notifier = mt7921_regd_notifier;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
 
-- 
2.25.1

