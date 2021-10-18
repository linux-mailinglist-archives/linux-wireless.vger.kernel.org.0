Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C28432A24
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhJRXRZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:17:25 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:24279 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRXRY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:17:24 -0400
X-UUID: 7956e607d85b42dd9cf9eaa47d47b2bb-20211018
X-UUID: 7956e607d85b42dd9cf9eaa47d47b2bb-20211018
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1738362701; Mon, 18 Oct 2021 16:15:09 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 16:12:34 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Oct 2021 07:12:33 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v5 15/17] mt76: mt7921: refactor mt7921_mcu_send_message
Date:   Tue, 19 Oct 2021 07:11:45 +0800
Message-ID: <273c7a880dcc283594cf375fd51cb528a1aad14a.1634598341.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1634598341.git.objelf@gmail.com>
References: <cover.1634598341.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This is a preliminary patch to introduce mt7921s support.

Refactor mt7921_mcu_send_message to be sharable between mt7921s and
mt7921e.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c    | 11 ++++-------
 .../net/wireless/mediatek/mt76/mt7921/mt7921.h |  2 +-
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c    | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index a95495069a4d..44e74e43ee78 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -224,12 +224,11 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 }
 EXPORT_SYMBOL_GPL(mt7921_mcu_parse_response);
 
-int mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			    int cmd, int *wait_seq)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	int txd_len, mcu_cmd = cmd & MCU_CMD_MASK;
-	enum mt76_mcuq_id txq = MT_MCUQ_WM;
 	struct mt7921_uni_txd *uni_txd;
 	struct mt7921_mcu_txd *mcu_txd;
 	__le32 *txd;
@@ -251,10 +250,8 @@ int mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (!seq)
 		seq = ++dev->mt76.mcu.msg_seq & 0xf;
 
-	if (cmd == MCU_CMD_FW_SCATTER) {
-		txq = MT_MCUQ_FWDL;
+	if (cmd == MCU_CMD_FW_SCATTER)
 		goto exit;
-	}
 
 	txd_len = cmd & MCU_UNI_PREFIX ? sizeof(*uni_txd) : sizeof(*mcu_txd);
 	txd = (__le32 *)skb_push(skb, txd_len);
@@ -318,9 +315,9 @@ int mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
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
index 2082b4d2a23d..f4b85ec530bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -381,7 +381,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
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

