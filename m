Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033027409FF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjF1H4F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:56:05 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41312 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230313AbjF1HyL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:11 -0400
X-UUID: a8ae8032158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=x/GB2Ybn4AH+QkUsnhFIXbSYB/1BRktYCsmkQyeUsUU=;
        b=TwRFdA1jZKrE30xbst1/kb61RlnE73qqn7I8TzuORbh6FJuZ53QIbJHjMAIyb7IOqfU0wsy86JeG5beMbwY3LAXGyXoqWMW9GwtxlCIGW9uVwn5jhLYk6pzgmhzgn/prBbeZq8nkI+E4qcSu8mxAtsK/6LMyJw9qh2Lb3uUSmks=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:19c6b862-0e82-47fa-9966-41c208a8cefb,IP:0,U
        RL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-35
X-CID-META: VersionHash:01c9525,CLOUDID:2d774f0d-26a8-467f-b838-f99719a9c083,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a8ae8032158211ee9cb5633481061a41-20230628
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1476871299; Wed, 28 Jun 2023 15:09:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:08:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:08:58 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 08/11] wifi: mt76: mt76_connac3: move lmac queue enumeration in mt76_connac3_mac.h
Date:   Wed, 28 Jun 2023 15:07:21 +0800
Message-ID: <02453eb49f241a464cded2781c13053d0a86d64a.1687920269.git.deren.wu@mediatek.com>
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

This is a preliminary patch to introduce mt7925 chip support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  | 14 ++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 6663a0b46541..68ca0844cbbf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -4,6 +4,20 @@
 #ifndef __MT76_CONNAC3_MAC_H
 #define __MT76_CONNAC3_MAC_H
 
+enum {
+	MT_CTX0,
+	MT_HIF0 = 0x0,
+
+	MT_LMAC_AC00 = 0x0,
+	MT_LMAC_AC01,
+	MT_LMAC_AC02,
+	MT_LMAC_AC03,
+	MT_LMAC_ALTX0 = 0x10,
+	MT_LMAC_BMC0,
+	MT_LMAC_BCN0,
+	MT_LMAC_PSMP0,
+};
+
 #define MT_CT_PARSE_LEN			72
 #define MT_CT_DMA_BUF_NUM		2
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 726c222e8e1e..7354e5cf8e67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -254,20 +254,6 @@ enum {
 	__MT_WFDMA_MAX,
 };
 
-enum {
-	MT_CTX0,
-	MT_HIF0 = 0x0,
-
-	MT_LMAC_AC00 = 0x0,
-	MT_LMAC_AC01,
-	MT_LMAC_AC02,
-	MT_LMAC_AC03,
-	MT_LMAC_ALTX0 = 0x10,
-	MT_LMAC_BMC0,
-	MT_LMAC_BCN0,
-	MT_LMAC_PSMP0,
-};
-
 enum {
 	MT_RX_SEL0,
 	MT_RX_SEL1,
-- 
2.18.0

