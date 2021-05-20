Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDA0389C04
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 05:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhETDsS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 23:48:18 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41011 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229554AbhETDsS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 23:48:18 -0400
X-UUID: f836aa21dde044bb930e82c11c20b709-20210520
X-UUID: f836aa21dde044bb930e82c11c20b709-20210520
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 397042348; Thu, 20 May 2021 11:46:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 May 2021 11:46:52 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 May 2021 11:46:52 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 4/7] mt76: mt7921: avoid unnecessary consecutive WiFi resets
Date:   Thu, 20 May 2021 11:46:38 +0800
Message-ID: <1621482401-29025-4-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1621482401-29025-1-git-send-email-sean.wang@mediatek.com>
References: <1621482401-29025-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Avoid unnecessary consecutive WiFi resets by dropping reset
request when reset work is working.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index ebd365ceb70d..fdc69f306f7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1312,6 +1312,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	int i;
 
 	dev_err(dev->mt76.dev, "chip reset\n");
+	dev->hw_full_reset = true;
 	ieee80211_stop_queues(hw);
 
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
@@ -1338,6 +1339,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 		ieee80211_scan_completed(dev->mphy.hw, &info);
 	}
 
+	dev->hw_full_reset = false;
 	ieee80211_wake_queues(hw);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -1349,7 +1351,8 @@ void mt7921_reset(struct mt76_dev *mdev)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 
-	queue_work(dev->mt76.wq, &dev->reset_work);
+	if (!dev->hw_full_reset)
+		queue_work(dev->mt76.wq, &dev->reset_work);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 03bcb210c357..710ad242fd53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -156,6 +156,7 @@ struct mt7921_dev {
 	u16 chainmask;
 
 	struct work_struct reset_work;
+	bool hw_full_reset;
 
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
-- 
2.25.1

