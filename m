Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E25534C4D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346837AbiEZJJI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 05:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346835AbiEZJJE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 05:09:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AF4C6E49
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 02:09:01 -0700 (PDT)
X-UUID: a88613c285364827a982c8be6bf8b3fb-20220526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:41f0d90f-2433-450b-b548-1b8bf7d213d4,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:41f0d90f-2433-450b-b548-1b8bf7d213d4,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:25d69147-4fb1-496b-8f1d-39e733fed1ea,C
        OID:e897e63fc246,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: a88613c285364827a982c8be6bf8b3fb-20220526
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1107625935; Thu, 26 May 2022 17:08:58 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 26 May 2022 17:08:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 26 May 2022 17:08:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 26 May 2022 17:08:57 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH 2/2] mt76: add DBDC rxq handlings into mac_reset_work
Date:   Thu, 26 May 2022 17:08:55 +0800
Message-ID: <864fffa767f9fb007c7682ad7bb67ee68cfb2844.1653555432.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <53fffc4aad9d92f7ae5da7e3e9aa1f59033bb662.1653555432.git.ryder.lee@mediatek.com>
References: <53fffc4aad9d92f7ae5da7e3e9aa1f59033bb662.1653555432.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable/disable rx napi for DBDC.

Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7615/pci_mac.c    | 14 +++++++-------
 .../net/wireless/mediatek/mt76/mt7915/mac.c    | 18 +++++++-----------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index d1806f198aed..73298dce35b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -268,6 +268,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	struct mt76_phy *ext_phy;
 	struct mt7615_dev *dev;
 	unsigned long timeout;
+	int i;
 
 	dev = container_of(work, struct mt7615_dev, reset_work);
 	ext_phy = dev->mt76.phy2;
@@ -299,8 +300,8 @@ void mt7615_mac_reset_work(struct work_struct *work)
 		mt76_txq_schedule_all(ext_phy);
 
 	mt76_worker_disable(&dev->mt76.tx_worker);
-	napi_disable(&dev->mt76.napi[0]);
-	napi_disable(&dev->mt76.napi[1]);
+	mt76_for_each_q_rx(&dev->mt76, i)
+		napi_disable(&dev->mt76.napi[i]);
 	napi_disable(&dev->mt76.tx_napi);
 
 	mt7615_mutex_acquire(dev);
@@ -330,11 +331,10 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	napi_enable(&dev->mt76.tx_napi);
 	napi_schedule(&dev->mt76.tx_napi);
 
-	napi_enable(&dev->mt76.napi[0]);
-	napi_schedule(&dev->mt76.napi[0]);
-
-	napi_enable(&dev->mt76.napi[1]);
-	napi_schedule(&dev->mt76.napi[1]);
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		napi_enable(&dev->mt76.napi[i]);
+		napi_schedule(&dev->mt76.napi[i]);
+	}
 	local_bh_enable();
 
 	ieee80211_wake_queues(mt76_hw(dev));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f59662af3d9d..27b3080469a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2124,6 +2124,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	struct mt7915_phy *phy2;
 	struct mt76_phy *ext_phy;
 	struct mt7915_dev *dev;
+	int i;
 
 	dev = container_of(work, struct mt7915_dev, reset_work);
 	ext_phy = dev->mt76.phy2;
@@ -2145,9 +2146,8 @@ void mt7915_mac_reset_work(struct work_struct *work)
 		cancel_delayed_work_sync(&phy2->mt76->mac_work);
 	}
 	mt76_worker_disable(&dev->mt76.tx_worker);
-	napi_disable(&dev->mt76.napi[0]);
-	napi_disable(&dev->mt76.napi[1]);
-	napi_disable(&dev->mt76.napi[2]);
+	mt76_for_each_q_rx(&dev->mt76, i)
+		napi_disable(&dev->mt76.napi[i]);
 	napi_disable(&dev->mt76.tx_napi);
 
 	mutex_lock(&dev->mt76.mutex);
@@ -2170,14 +2170,10 @@ void mt7915_mac_reset_work(struct work_struct *work)
 		clear_bit(MT76_RESET, &phy2->mt76->state);
 
 	local_bh_disable();
-	napi_enable(&dev->mt76.napi[0]);
-	napi_schedule(&dev->mt76.napi[0]);
-
-	napi_enable(&dev->mt76.napi[1]);
-	napi_schedule(&dev->mt76.napi[1]);
-
-	napi_enable(&dev->mt76.napi[2]);
-	napi_schedule(&dev->mt76.napi[2]);
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		napi_enable(&dev->mt76.napi[i]);
+		napi_schedule(&dev->mt76.napi[i]);
+	}
 	local_bh_enable();
 
 	tasklet_schedule(&dev->irq_tasklet);
-- 
2.29.2

