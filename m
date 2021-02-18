Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8F31E3F5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Feb 2021 02:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhBRBfe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Feb 2021 20:35:34 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39778 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229993AbhBRBfb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Feb 2021 20:35:31 -0500
X-UUID: b97938a56a674f168c6a9c2f38f0f44f-20210218
X-UUID: b97938a56a674f168c6a9c2f38f0f44f-20210218
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1417638374; Thu, 18 Feb 2021 09:34:44 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Feb 2021 09:34:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Feb 2021 09:34:43 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/3] mt76: mt7615: add rx checksum offload support
Date:   Thu, 18 Feb 2021 09:34:39 +0800
Message-ID: <5986dbd65f23d49aaf7656e0a4b4750985188f36.1613603857.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <b7883f5ee09d13f7cbdf5ab1d5fef61ebc79dcc4.1613603857.git.ryder.lee@mediatek.com>
References: <b7883f5ee09d13f7cbdf5ab1d5fef61ebc79dcc4.1613603857.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set skb->ip_summed to CHECKSUM_UNNECESSARY if the hardware has validated
the IP and TCP/UDP checksum

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index a97cc723094c..fd38737a27bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -329,6 +329,7 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	hw->max_rates = 3;
 	hw->max_report_rates = 7;
 	hw->max_rate_tries = 11;
+	hw->netdev_features = NETIF_F_RXCSUM;
 
 	phy->slottime = 9;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 928edd158f64..340beff0e121 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -234,6 +234,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	u32 rxd0 = le32_to_cpu(rxd[0]);
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
+	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
 	__le32 rxd12 = rxd[12];
 	bool unicast, remove_pad, insert_ccmp_hdr = false;
 	int phy_idx;
@@ -271,6 +272,9 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		spin_unlock_bh(&dev->sta_poll_lock);
 	}
 
+	if ((rxd0 & csum_mask) == csum_mask)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
 	if (rxd2 & MT_RXD2_NORMAL_FCS_ERR)
 		status->flag |= RX_FLAG_FAILED_FCS_CRC;
 
-- 
2.18.0

