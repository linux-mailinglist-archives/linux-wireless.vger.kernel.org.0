Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95BA3C77B5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jul 2021 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhGMUTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jul 2021 16:19:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38934 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234947AbhGMUS7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jul 2021 16:18:59 -0400
X-UUID: 12ff7fae6d4c48dd96e06ef4661b6e30-20210714
X-UUID: 12ff7fae6d4c48dd96e06ef4661b6e30-20210714
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1474067305; Wed, 14 Jul 2021 04:16:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Jul 2021 04:16:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 04:16:06 +0800
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
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 3/4] mt76: mt7921: fix mgmt frame using unexpected bitrate
Date:   Wed, 14 Jul 2021 04:16:00 +0800
Message-ID: <3d68ff612bacf2c8d2b7b414f2b3cf14daf443f8.1626207204.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <92a8ecfdf198b34f98d5c1489a83adf151657760.1626207204.git.objelf@gmail.com>
References: <92a8ecfdf198b34f98d5c1489a83adf151657760.1626207204.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fix the current driver mgmt frame is not respecting the basic rates field
provided by the AP and then unconditionally is using the lowest (1 or 6
Mbps) rate.

For example, if the AP only supported basic rate {24, 36, 48, 54} Mbps,
mt7921 cannot send mgmt frame with the rate not in the group. So,
instead, we pick up the lowest basic rate the AP can support to send.

Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:  1. introduce another patch ("mt76: fix mt76_rates for the multiple devices")
	for those devices which have the same issue.
     2. drop the own mt7921_rates, the unused macro and variable.
v3:  1. introduce and rely on another patch
	("mt76: add mt76_default_basic_rate more devices can rely on").
     2. add Fixes tag.
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 5 +----
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 7fe2e3a50428..a4ce362286eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -815,10 +815,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 		/* hardware won't add HTC for mgmt/ctrl frame */
 		txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
 
-		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
-			rate = MT7921_5G_RATE_DEFAULT;
-		else
-			rate = MT7921_2G_RATE_DEFAULT;
+		rate = mt76_default_basic_rate(mphy, vif);
 
 		val = MT_TXD6_FIXED_BW |
 		      FIELD_PREP(MT_TXD6_TX_RATE, rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 2d8bd6bfc820..be16d528a923 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -38,8 +38,6 @@
 
 #define MT7921_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
 #define MT7921_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
-#define MT7921_5G_RATE_DEFAULT		0x4b	/* OFDM 6M */
-#define MT7921_2G_RATE_DEFAULT		0x0	/* CCK 1M */
 
 #define MT7921_SKU_RATE_NUM		161
 #define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
-- 
2.25.1

