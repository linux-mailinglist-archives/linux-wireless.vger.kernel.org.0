Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E2279EB73
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbjIMOon (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 10:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241415AbjIMOoi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 10:44:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD87DA3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 07:44:33 -0700 (PDT)
X-UUID: 09d26dda524411ee8051498923ad61e6-20230913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wNWAASQgx2yZ9Lm91xAYoMSzP8141OX6F/qxsCsRzyA=;
        b=RPWV047EHRS8uwP7TIk9RRhiECFMEUld90ykI5/E8zqY2G1E3JBRIEFvH8pWYYdKplSkBxloUei+szer3bisCEJ2/36zelVxmjNTTUplZo1XH+YskrEG0suddNaBAXBsRY45sDqNBghR1aVX8VLv+vH489tGyhmAO2XxhzoowKM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:f92921f9-67dc-4895-8061-3837ec2d57d6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:34aafcc2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 09d26dda524411ee8051498923ad61e6-20230913
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 560520384; Wed, 13 Sep 2023 22:44:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Sep 2023 22:44:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Sep 2023 22:44:23 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2 12/17] wifi: mt76: mt7925: add pci_mac.c
Date:   Wed, 13 Sep 2023 22:43:40 +0800
Message-ID: <c6ee5bd710e62e9857b47df958302477b9057b3e.1694595134.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1694595134.git.deren.wu@mediatek.com>
References: <cover.1694595134.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.114000-8.000000
X-TMASE-MatchedRID: vV20CH+NLrHKRSR886eK0gPZZctd3P4BWjWsWQUWzVpnnK6mXN72m34U
        OBQdfZJqjr9xEy4zBBUTAC2dkFyvhZG3xUgZJlVXDB+ErBr0bAMxmbT6wQT2a3yKcwQTdriq7/J
        GRZ8PgCdR7eH8LHez4UdHJ1YGcijZZ28ZQS4q9Jye7UdJp0QINbMdrMS8e/bxgGab06uiYeHV2E
        8xA5DQivrXUyTHdO2aUVb4NCvWkdXJ1LL8b7Eekr50lYduDghOfS0Ip2eEHnz3IzXlXlpamPoLR
        4+zsDTttrrTuahHzlEpVQCqK6NWihsPttO7uSATGnNmFl71h5zGPjJEnaXHLMz5F1+GfGPYf/BH
        /pcBzrDOkAfdOd9OXUCulL+REZVLEwuvGN+Oj7lJmt82E/eyBQGH0CAFIQWsmb5gmylW+PbGS+s
        eVPx64j6Qrn3xh/cy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.114000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 1AC2102303CD41BB2DE83F525E01F761B87077D43CA412AB773D463630149B6A2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7925/pci_mac.c   | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
new file mode 100644
index 000000000000..15149e9036db
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#include "mt7925.h"
+#include "../dma.h"
+#include "mac.h"
+
+int mt7925e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			   struct ieee80211_sta *sta,
+			   struct mt76_tx_info *tx_info)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct mt76_connac_hw_txp *txp;
+	struct mt76_txwi_cache *t;
+	int id, pid;
+	u8 *txwi = (u8 *)txwi_ptr;
+
+	if (unlikely(tx_info->skb->len <= ETH_HLEN))
+		return -EINVAL;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
+	t->skb = tx_info->skb;
+
+	id = mt76_token_consume(mdev, &t);
+	if (id < 0)
+		return id;
+
+	if (sta) {
+		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+
+		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
+			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			msta->last_txs = jiffies;
+		}
+	}
+
+	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
+	mt7925_mac_write_txwi(mdev, txwi_ptr, tx_info->skb, wcid, key,
+			      pid, qid, 0);
+
+	txp = (struct mt76_connac_hw_txp *)(txwi + MT_TXD_SIZE);
+	memset(txp, 0, sizeof(struct mt76_connac_hw_txp));
+	mt76_connac_write_hw_txp(mdev, tx_info, txp, id);
+
+	tx_info->skb = NULL;
+
+	return 0;
+}
+
+void mt7925_tx_token_put(struct mt792x_dev *dev)
+{
+	struct mt76_txwi_cache *txwi;
+	int id;
+
+	spin_lock_bh(&dev->mt76.token_lock);
+	idr_for_each_entry(&dev->mt76.token, txwi, id) {
+		mt7925_txwi_free(dev, txwi, NULL, false, NULL);
+		dev->mt76.token_count--;
+	}
+	spin_unlock_bh(&dev->mt76.token_lock);
+	idr_destroy(&dev->mt76.token);
+}
+
+int mt7925e_mac_reset(struct mt792x_dev *dev)
+{
+	const struct mt792x_irq_map *irq_map = dev->irq_map;
+	int i, err;
+
+	mt792xe_mcu_drv_pmctrl(dev);
+
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+
+	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+
+	mt76_txq_schedule_all(&dev->mphy);
+
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	if (irq_map->rx.data_complete_mask)
+		napi_disable(&dev->mt76.napi[MT_RXQ_MAIN]);
+	if (irq_map->rx.wm_complete_mask)
+		napi_disable(&dev->mt76.napi[MT_RXQ_MCU]);
+	if (irq_map->rx.wm2_complete_mask)
+		napi_disable(&dev->mt76.napi[MT_RXQ_MCU_WA]);
+	if (irq_map->tx.all_complete_mask)
+		napi_disable(&dev->mt76.tx_napi);
+
+	mt7925_tx_token_put(dev);
+	idr_init(&dev->mt76.token);
+
+	mt792x_wpdma_reset(dev, true);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		napi_enable(&dev->mt76.napi[i]);
+		napi_schedule(&dev->mt76.napi[i]);
+	}
+	local_bh_enable();
+
+	dev->fw_assert = false;
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+
+	mt76_wr(dev, dev->irq_map->host_irq_enable,
+		dev->irq_map->tx.all_complete_mask |
+		MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+
+	err = mt792xe_mcu_fw_pmctrl(dev);
+	if (err)
+		return err;
+
+	err = __mt792xe_mcu_drv_pmctrl(dev);
+	if (err)
+		goto out;
+
+	err = mt7925_run_firmware(dev);
+	if (err)
+		goto out;
+
+	err = mt7925_mcu_set_eeprom(dev);
+	if (err)
+		goto out;
+
+	err = mt7925_mac_init(dev);
+	if (err)
+		goto out;
+
+	err = __mt7925_start(&dev->phy);
+out:
+	clear_bit(MT76_RESET, &dev->mphy.state);
+
+	local_bh_disable();
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+	local_bh_enable();
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	return err;
+}
-- 
2.18.0

