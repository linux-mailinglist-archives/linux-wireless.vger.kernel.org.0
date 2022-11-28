Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7DE63A015
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 04:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiK1D2z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Nov 2022 22:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1D2y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Nov 2022 22:28:54 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26791180E
        for <linux-wireless@vger.kernel.org>; Sun, 27 Nov 2022 19:28:48 -0800 (PST)
X-UUID: 2ba1b438f9684ee0992ca22d91a5c592-20221128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=MaefGZzEjKv+zTIher4rYDK3FE8d4+BhG7NM2LZp8rA=;
        b=PPOQNUXRDNTRvzPg+evCKYNaI9HJ05e/x8qB3smqGVwtPZx8lLHqjoPljaZxgn4jpUy0Q/vwP3IARNPUzBT3COYB6UGXQdbZMlH9IXoQlu1NdKTXsKDka9xkC0DVrQHFZydiXB8Gk6hcagxjIWdgxs6V1TtDQvjmOMBQZ8SIPVk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a0feb8e4-02f6-4067-bd18-ffe809df729c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:1807fa2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2ba1b438f9684ee0992ca22d91a5c592-20221128
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 440216695; Mon, 28 Nov 2022 11:28:43 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 28 Nov 2022 11:28:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 28 Nov 2022 11:28:42 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7996: add missing argument in mt7996_queue_rx_skb()
Date:   Mon, 28 Nov 2022 11:28:26 +0800
Message-ID: <20221128032826.9696-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

An argument has been added in .rx_skb driver ops callback after
introducing WED RX support. Align it to fix the following compile error:

>> drivers/net/wireless/mediatek/mt76/mt7996/mmio.c:328:13: error: incompatible function pointer types initializing 'void (*)(struct mt76_dev *, enum mt76_rxq_id, struct sk_buff *, u32 *)' (aka 'void (*)(struct mt76_dev *, enum mt76_rxq_id, struct sk_buff *, unsigned int *)') with an expression of type 'void (struct mt76_dev *, enum mt76_rxq_id, struct sk_buff *)' [-Werror,-Wincompatible-function-pointer-types]
                   .rx_skb = mt7996_queue_rx_skb,
                             ^~~~~~~~~~~~~~~~~~~
   1 error generated.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
@Felix, could you please help to fold this patch? Thanks.
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 9650590a5d4b..c9c9b82352eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1514,7 +1514,7 @@ bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len)
 }
 
 void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb)
+			 struct sk_buff *skb, u32 *info)
 {
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	__le32 *rxd = (__le32 *)skb->data;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 371195e4597d..167f615f099e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -489,7 +489,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 void mt7996_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 void mt7996_tx_token_put(struct mt7996_dev *dev);
 void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb);
+			 struct sk_buff *skb, u32 *info);
 bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7996_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 void mt7996_stats_work(struct work_struct *work);
-- 
2.25.1

