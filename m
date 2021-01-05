Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2B22EA6CC
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 09:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbhAEI4z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 03:56:55 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43173 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726648AbhAEI4z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 03:56:55 -0500
X-UUID: b8d4330b1bea461ba3d2b5f58c6dc09b-20210105
X-UUID: b8d4330b1bea461ba3d2b5f58c6dc09b-20210105
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 8440486; Tue, 05 Jan 2021 16:56:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 16:56:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 16:56:06 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/6] mt76: testmode: make tx queued limit adjustable
Date:   Tue, 5 Jan 2021 16:55:25 +0800
Message-ID: <20210105085529.14206-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210105085529.14206-1-shayne.chen@mediatek.com>
References: <20210105085529.14206-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Originally, tx queued limit is set to 1000 to prevent from running out
of tx token. If a new testmode tx is triggered while the previous one
hasn't finished yet, we'll wait a period of time until tx_done equals to
tx_queued. Normally, current queued limit can finish in 10 seconds.

However, if ipg is configured to a larger value, less than 1000 packets
can be done in the default timeout period, which may lead to a crash
when a new testmode tx triggered.

To deal with this, make tx queued limit dynamically adjusted according
to ipg value.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 1 +
 drivers/net/wireless/mediatek/mt76/testmode.c | 9 +++++++--
 drivers/net/wireless/mediatek/mt76/testmode.h | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index cbe9689dc2ca..9de9a3b842d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -552,6 +552,7 @@ struct mt76_testmode_data {
 
 	u32 tx_pending;
 	u32 tx_queued;
+	u16 tx_queued_limit;
 	u32 tx_done;
 	struct {
 		u64 packets[__MT_RXQ_MAX];
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 74cadf51df55..cc769645afa5 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -30,6 +30,7 @@ void mt76_testmode_tx_pending(struct mt76_phy *phy)
 	struct mt76_wcid *wcid = &dev->global_wcid;
 	struct sk_buff *skb = td->tx_skb;
 	struct mt76_queue *q;
+	u16 tx_queued_limit;
 	int qid;
 
 	if (!skb || !td->tx_pending)
@@ -38,9 +39,12 @@ void mt76_testmode_tx_pending(struct mt76_phy *phy)
 	qid = skb_get_queue_mapping(skb);
 	q = phy->q_tx[qid];
 
+	tx_queued_limit = td->tx_queued_limit ? td->tx_queued_limit : 1000;
+
 	spin_lock_bh(&q->lock);
 
-	while (td->tx_pending > 0 && td->tx_queued - td->tx_done < 1000 &&
+	while (td->tx_pending > 0 &&
+	       td->tx_queued - td->tx_done < tx_queued_limit &&
 	       q->queued < q->ndesc / 2) {
 		int ret;
 
@@ -196,7 +200,8 @@ mt76_testmode_tx_stop(struct mt76_phy *phy)
 
 	mt76_worker_enable(&dev->tx_worker);
 
-	wait_event_timeout(dev->tx_wait, td->tx_done == td->tx_queued, 10 * HZ);
+	wait_event_timeout(dev->tx_wait, td->tx_done == td->tx_queued,
+			   MT76_TM_TIMEOUT * HZ);
 
 	dev_kfree_skb(td->tx_skb);
 	td->tx_skb = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.h b/drivers/net/wireless/mediatek/mt76/testmode.h
index cecdf358aa44..e4849946f180 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/testmode.h
@@ -5,6 +5,8 @@
 #ifndef __MT76_TESTMODE_H
 #define __MT76_TESTMODE_H
 
+#define MT76_TM_TIMEOUT	10
+
 /**
  * enum mt76_testmode_attr - testmode attributes inside NL80211_ATTR_TESTDATA
  *
-- 
2.29.2

