Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDD540BD28
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 03:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhIOB0i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 21:26:38 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:53475 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhIOB0i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 21:26:38 -0400
X-UUID: 5c3ebdeeeda14d98acc7616cf8967cfe-20210914
X-UUID: 5c3ebdeeeda14d98acc7616cf8967cfe-20210914
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2138603018; Tue, 14 Sep 2021 18:25:18 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 18:15:51 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 09:15:50 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <steve.lee@mediatek.com>, <jemele@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 14/16] mt76: mt7921: refactor mt7921_mcu_send_message
Date:   Wed, 15 Sep 2021 09:14:47 +0800
Message-ID: <e9bd7131bf2bbd490912ddf6e64c0bc267a3e380.1631667941.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1631667941.git.objelf@gmail.com>
References: <cover.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This is a preliminary patch to introduce mt7921s support.

Refactor mt7921_mcu_send_message to be sharable between mt7921e and
mt7921e.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c    | 11 ++++-------
 .../net/wireless/mediatek/mt76/mt7921/mt7921.h |  2 +-
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c    | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index b3e257594f92..2de5a2ba43b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -227,12 +227,11 @@ EXPORT_SYMBOL_GPL(mt7921_mcu_parse_response);
 
 
 int
-mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			int cmd, int *wait_seq)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	int txd_len, mcu_cmd = cmd & MCU_CMD_MASK;
-	enum mt76_mcuq_id txq = MT_MCUQ_WM;
 	struct mt7921_uni_txd *uni_txd;
 	struct mt7921_mcu_txd *mcu_txd;
 	__le32 *txd;
@@ -254,10 +253,8 @@ mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (!seq)
 		seq = ++dev->mt76.mcu.msg_seq & 0xf;
 
-	if (cmd == MCU_CMD_FW_SCATTER) {
-		txq = MT_MCUQ_FWDL;
+	if (cmd == MCU_CMD_FW_SCATTER)
 		goto exit;
-	}
 
 	txd_len = cmd & MCU_UNI_PREFIX ? sizeof(*uni_txd) : sizeof(*mcu_txd);
 	txd = (__le32 *)skb_push(skb, txd_len);
@@ -321,9 +318,9 @@ mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (wait_seq)
 		*wait_seq = seq;
 
-	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(mt7921_mcu_send_message);
+EXPORT_SYMBOL_GPL(mt7921_mcu_fill_message);
 
 static void
 mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index bd52e39e8181..01c356b315ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -376,7 +376,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 			   bool beacon);
 void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
 void mt7921_mac_sta_poll(struct mt7921_dev *dev);
-int mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			    int cmd, int *wait_seq);
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index 9ac3bc25f067..583a89a34734 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -18,6 +18,24 @@ static int mt7921e_driver_own(struct mt7921_dev *dev)
 	return 0;
 }
 
+static int
+mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			int cmd, int *seq)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	enum mt76_mcuq_id txq = MT_MCUQ_WM;
+	int ret;
+
+	ret = mt7921_mcu_fill_message(mdev, skb, cmd, seq);
+	if (ret)
+		return ret;
+
+	if (cmd == MCU_CMD_FW_SCATTER)
+		txq = MT_MCUQ_FWDL;
+
+	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
+}
+
 int mt7921e_mcu_init(struct mt7921_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7921_mcu_ops = {
-- 
2.25.1

