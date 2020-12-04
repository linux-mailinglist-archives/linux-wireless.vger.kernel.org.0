Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9483E2CEB12
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 10:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgLDJi3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 04:38:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52962 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725866AbgLDJi3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 04:38:29 -0500
X-UUID: 85d5a77a64f241cc8a1ac777ab95e4a8-20201204
X-UUID: 85d5a77a64f241cc8a1ac777ab95e4a8-20201204
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1594686488; Fri, 04 Dec 2020 17:37:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Dec 2020 17:37:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Dec 2020 17:37:17 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 3/5] mt76: testmode: move mtd part to mt76_dev
Date:   Fri, 4 Dec 2020 17:36:57 +0800
Message-ID: <20201204093659.20384-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201204093659.20384-1-shayne.chen@mediatek.com>
References: <20201204093659.20384-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A00DEBCF65E99FBD6D07904414DF9A35D5ED59FC22E894ED589AD254CB8769712000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move testmode mtd variables to mt76_dev, since they are the same on
each phy.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c   | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h     | 7 ++++---
 drivers/net/wireless/mediatek/mt76/testmode.c | 6 +++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index ffc9d547f4fe..665b54c5c8ae 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -75,8 +75,8 @@ mt76_get_of_eeprom(struct mt76_dev *dev, int len)
 	}
 
 #ifdef CONFIG_NL80211_TESTMODE
-	dev->phy.test.mtd_name = devm_kstrdup(dev->dev, part, GFP_KERNEL);
-	dev->phy.test.mtd_offset = offset;
+	dev->test_mtd.name = devm_kstrdup(dev->dev, part, GFP_KERNEL);
+	dev->test_mtd.offset = offset;
 #endif
 
 out_put_node:
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8752890fc61e..367bbc9b40a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -543,9 +543,6 @@ struct mt76_testmode_data {
 	u8 tx_power[4];
 	u8 tx_power_control;
 
-	const char *mtd_name;
-	u32 mtd_offset;
-
 	u32 tx_pending;
 	u32 tx_queued;
 	u32 tx_done;
@@ -663,6 +660,10 @@ struct mt76_dev {
 
 #ifdef CONFIG_NL80211_TESTMODE
 	const struct mt76_testmode_ops *test_ops;
+	struct {
+		const char *name;
+		u32 offset;
+	} test_mtd;
 #endif
 	struct workqueue_struct *wq;
 
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 184964b9bd42..8b14620e16fc 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -482,9 +482,9 @@ int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 	if (nla_put_u32(msg, MT76_TM_ATTR_STATE, td->state))
 		goto out;
 
-	if (td->mtd_name &&
-	    (nla_put_string(msg, MT76_TM_ATTR_MTD_PART, td->mtd_name) ||
-	     nla_put_u32(msg, MT76_TM_ATTR_MTD_OFFSET, td->mtd_offset)))
+	if (dev->test_mtd.name &&
+	    (nla_put_string(msg, MT76_TM_ATTR_MTD_PART, dev->test_mtd.name) ||
+	     nla_put_u32(msg, MT76_TM_ATTR_MTD_OFFSET, dev->test_mtd.offset)))
 		goto out;
 
 	if (nla_put_u32(msg, MT76_TM_ATTR_TX_COUNT, td->tx_count) ||
-- 
2.17.1

