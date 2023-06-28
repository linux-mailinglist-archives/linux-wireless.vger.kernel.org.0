Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CCA740A01
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjF1H4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:56:11 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41380 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229877AbjF1HyM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:12 -0400
X-UUID: a8bf7a04158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dVe4k/Rn+DcjBSH4JWRc4NQwfN692T8yUnDggT+CmXw=;
        b=c1LBsc7DhFqKwAcBrY0YLzeSEosnhcq4XKo1HH5eJ+8O7AFS061QqxJWhp16qA/U2NUWDNBhCQnjfZlV7ugULQiEOoPZCBMf2BBW2deGVkNx7H8w2MM3OQUoVyRHjiRckhLjuntJBNUfMUt0Gw98SmLRbUjVu7EoQYoKux/kvXI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:a850c482-4eff-4b90-a7fb-59f35b1fdb41,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.27,REQID:a850c482-4eff-4b90-a7fb-59f35b1fdb41,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:01c9525,CLOUDID:2e899b0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:230628150904MO8CV022,BulkQuantity:0,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: a8bf7a04158211ee9cb5633481061a41-20230628
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 646737589; Wed, 28 Jun 2023 15:09:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:09:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:09:00 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 09/11] wifi: mt76: mt792x: move MT7921_PM_TIMEOUT and MT7921_HW_SCAN_TIMEOUT in common code
Date:   Wed, 28 Jun 2023 15:07:22 +0800
Message-ID: <95218a7dc09f2020ef3bf02b17d46fcfa2f6c513.1687920269.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687920269.git.deren.wu@mediatek.com>
References: <cover.1687920269.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

MT7921_PM_TIMEOUT is shared between mt7925 and mt7921 so move it in
mt792x module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 3 ---
 drivers/net/wireless/mediatek/mt76/mt792x.h        | 3 +++
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 7b8876bf8fc8..ff63f37f67d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -217,7 +217,7 @@ int mt7921_register_device(struct mt792x_dev *dev)
 	timer_setup(&dev->phy.roc_timer, mt792x_roc_timer, 0);
 	init_waitqueue_head(&dev->phy.roc_wait);
 
-	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
+	dev->pm.idle_timeout = MT792x_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
 	if (!mt76_is_usb(&dev->mt76)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 4b77d95af958..90c93970acab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -167,7 +167,7 @@ mt7921_mcu_scan_event(struct mt792x_dev *dev, struct sk_buff *skb)
 	spin_unlock_bh(&dev->mt76.lock);
 
 	ieee80211_queue_delayed_work(mphy->hw, &phy->scan_work,
-				     MT7921_HW_SCAN_TIMEOUT);
+				     MT792x_HW_SCAN_TIMEOUT);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index e458ddb7d99a..0f8b93a2be3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -7,9 +7,6 @@
 #include "../mt792x.h"
 #include "regs.h"
 
-#define MT7921_PM_TIMEOUT		(HZ / 12)
-#define MT7921_HW_SCAN_TIMEOUT		(HZ / 10)
-
 #define MT7921_TX_RING_SIZE		2048
 #define MT7921_TX_MCU_RING_SIZE		256
 #define MT7921_TX_FWDL_RING_SIZE	128
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 700cd0ccc5d3..d80f80bc7656 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -11,6 +11,9 @@
 #include "mt792x_regs.h"
 #include "mt792x_acpi_sar.h"
 
+#define MT792x_PM_TIMEOUT	(HZ / 12)
+#define MT792x_HW_SCAN_TIMEOUT	(HZ / 10)
+
 #define MT792x_MAX_INTERFACES	4
 #define MT792x_WTBL_SIZE	20
 #define MT792x_WTBL_RESERVED	(MT792x_WTBL_SIZE - 1)
-- 
2.18.0

