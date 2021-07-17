Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355B73CC154
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jul 2021 07:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhGQFIy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Jul 2021 01:08:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57584 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229778AbhGQFIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Jul 2021 01:08:54 -0400
X-UUID: a9e856aee7ed4097a738b911c1719cb7-20210717
X-UUID: a9e856aee7ed4097a738b911c1719cb7-20210717
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 791011969; Sat, 17 Jul 2021 13:05:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 17 Jul 2021 13:05:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 17 Jul 2021 13:05:53 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7921: send EAPOL frames at lowest rate
Date:   Sat, 17 Jul 2021 13:05:49 +0800
Message-ID: <089a52032471c2f058e0837582b21f6e9b039fba.1626498075.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <aea4d98082bea79c7e116fc56d2b0e0c1442deae.1626498075.git.ryder.lee@mediatek.com>
References: <aea4d98082bea79c7e116fc56d2b0e0c1442deae.1626498075.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The firmware rate control may choose the high rate for EAPOL frames,
so checking IEEE80211_TX_CTL_USE_MINRATE to use the lowest TX rate.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 7fe2e3a50428..eb0d98c8d5d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -702,7 +702,8 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
 		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
 	}
 
-	if (!ieee80211_is_data(fc) || multicast)
+	if (!ieee80211_is_data(fc) || multicast ||
+	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
 		val |= MT_TXD2_FIX_RATE;
 
 	txwi[2] |= cpu_to_le32(val);
-- 
2.18.0

