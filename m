Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE23D3A4864
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jun 2021 20:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhFKSGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Jun 2021 14:06:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58595 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231197AbhFKSGa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Jun 2021 14:06:30 -0400
X-UUID: de2149642a3845a3b70b0f13b866347c-20210612
X-UUID: de2149642a3845a3b70b0f13b866347c-20210612
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1140872981; Sat, 12 Jun 2021 02:04:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 12 Jun 2021 02:04:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 12 Jun 2021 02:04:27 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>
Subject: [PATCH 2/2] mt76: fix iv and CCMP header insertion
Date:   Sat, 12 Jun 2021 02:04:21 +0800
Message-ID: <7e5151dacb48b002f0abe720615b9b39844c2300.1623434432.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <28077c152c43d40f78252efb39d77ed5fca18028.1623434432.git.ryder.lee@mediatek.com>
References: <28077c152c43d40f78252efb39d77ed5fca18028.1623434432.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The iv from RXD is only for TKIP_RSC/CCMP_PN/GCMP_PN, and add checks for
CCMP header insertion.

Signed-off-by: Xing Song <xing.song@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 29 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7603/regs.h  |  4 +++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 29 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |  3 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 29 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7915/mac.h   | 16 ++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 29 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 16 ++++++++++
 8 files changed, 122 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 8435e9597688..d760b48b4ece 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -550,14 +550,27 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 		u8 *data = (u8 *)rxd;
 
 		if (status->flag & RX_FLAG_DECRYPTED) {
-			status->iv[0] = data[5];
-			status->iv[1] = data[4];
-			status->iv[2] = data[3];
-			status->iv[3] = data[2];
-			status->iv[4] = data[1];
-			status->iv[5] = data[0];
-
-			insert_ccmp_hdr = FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+			switch (FIELD_GET(MT_RXD2_NORMAL_SEC_MODE, rxd2)) {
+			case MT_CIPHER_AES_CCMP:
+			case MT_CIPHER_CCMP_CCX:
+			case MT_CIPHER_CCMP_256:
+				insert_ccmp_hdr =
+					FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+				fallthrough;
+			case MT_CIPHER_TKIP:
+			case MT_CIPHER_TKIP_NO_MIC:
+			case MT_CIPHER_GCMP:
+			case MT_CIPHER_GCMP_256:
+				status->iv[0] = data[5];
+				status->iv[1] = data[4];
+				status->iv[2] = data[3];
+				status->iv[3] = data[2];
+				status->iv[4] = data[1];
+				status->iv[5] = data[0];
+				break;
+			default:
+				break;
+			}
 		}
 
 		rxd += 4;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
index 6741e6907194..201b39e9b8e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
@@ -775,6 +775,10 @@ enum mt7603_cipher_type {
 	MT_CIPHER_BIP_CMAC_128,
 	MT_CIPHER_WEP128,
 	MT_CIPHER_WAPI,
+	MT_CIPHER_CCMP_CCX,
+	MT_CIPHER_CCMP_256,
+	MT_CIPHER_GCMP,
+	MT_CIPHER_GCMP_256,
 };
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index a48c198fb9cd..7261005ad538 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -313,14 +313,27 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		u8 *data = (u8 *)rxd;
 
 		if (status->flag & RX_FLAG_DECRYPTED) {
-			status->iv[0] = data[5];
-			status->iv[1] = data[4];
-			status->iv[2] = data[3];
-			status->iv[3] = data[2];
-			status->iv[4] = data[1];
-			status->iv[5] = data[0];
-
-			insert_ccmp_hdr = FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+			switch (FIELD_GET(MT_RXD2_NORMAL_SEC_MODE, rxd2)) {
+			case MT_CIPHER_AES_CCMP:
+			case MT_CIPHER_CCMP_CCX:
+			case MT_CIPHER_CCMP_256:
+				insert_ccmp_hdr =
+					FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+				fallthrough;
+			case MT_CIPHER_TKIP:
+			case MT_CIPHER_TKIP_NO_MIC:
+			case MT_CIPHER_GCMP:
+			case MT_CIPHER_GCMP_256:
+				status->iv[0] = data[5];
+				status->iv[1] = data[4];
+				status->iv[2] = data[3];
+				status->iv[3] = data[2];
+				status->iv[4] = data[1];
+				status->iv[5] = data[0];
+				break;
+			default:
+				break;
+			}
 		}
 		rxd += 4;
 		if ((u8 *)rxd - skb->data >= skb->len)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index d17bf200d8de..309c40f5bf72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -394,7 +394,8 @@ enum mt7615_cipher_type {
 	MT_CIPHER_BIP_CMAC_128,
 	MT_CIPHER_WEP128,
 	MT_CIPHER_WAPI,
-	MT_CIPHER_CCMP_256 = 10,
+	MT_CIPHER_CCMP_CCX,
+	MT_CIPHER_CCMP_256,
 	MT_CIPHER_GCMP,
 	MT_CIPHER_GCMP_256,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index c093c13bf1f1..ab190508416f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -413,14 +413,27 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		u8 *data = (u8 *)rxd;
 
 		if (status->flag & RX_FLAG_DECRYPTED) {
-			status->iv[0] = data[5];
-			status->iv[1] = data[4];
-			status->iv[2] = data[3];
-			status->iv[3] = data[2];
-			status->iv[4] = data[1];
-			status->iv[5] = data[0];
-
-			insert_ccmp_hdr = FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+			switch (FIELD_GET(MT_RXD1_NORMAL_SEC_MODE, rxd1)) {
+			case MT_RX_CIPHER_AES_CCMP:
+			case MT_RX_CIPHER_CCMP_CCX:
+			case MT_RX_CIPHER_CCMP_256:
+				insert_ccmp_hdr =
+					FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+				fallthrough;
+			case MT_RX_CIPHER_TKIP:
+			case MT_RX_CIPHER_TKIP_NO_MIC:
+			case MT_RX_CIPHER_GCMP:
+			case MT_RX_CIPHER_GCMP_256:
+				status->iv[0] = data[5];
+				status->iv[1] = data[4];
+				status->iv[2] = data[3];
+				status->iv[3] = data[2];
+				status->iv[4] = data[1];
+				status->iv[5] = data[0];
+				break;
+			default:
+				break;
+			}
 		}
 		rxd += 4;
 		if ((u8 *)rxd - skb->data >= skb->len)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index eb1885f4bd8e..a25254e6b3d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -150,6 +150,22 @@ enum rx_pkt_type {
 #define MT_CRXV_FOE_HI		GENMASK(6, 0)
 #define MT_CRXV_FOE_SHIFT	13
 
+enum rx_cipher_type {
+	MT_RX_CIPHER_NONE,
+	MT_RX_CIPHER_WEP40,
+	MT_RX_CIPHER_TKIP,
+	MT_RX_CIPHER_TKIP_NO_MIC,
+	MT_RX_CIPHER_AES_CCMP,
+	MT_RX_CIPHER_WEP104,
+	MT_RX_CIPHER_BIP_CMAC_128,
+	MT_RX_CIPHER_WEP128,
+	MT_RX_CIPHER_WAPI,
+	MT_RX_CIPHER_CCMP_CCX,
+	MT_RX_CIPHER_CCMP_256,
+	MT_RX_CIPHER_GCMP,
+	MT_RX_CIPHER_GCMP_256,
+};
+
 enum tx_header_format {
 	MT_HDR_FORMAT_802_3,
 	MT_HDR_FORMAT_CMD,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 5af3a958e5b0..8f09b40d329d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -433,14 +433,27 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 		u8 *data = (u8 *)rxd;
 
 		if (status->flag & RX_FLAG_DECRYPTED) {
-			status->iv[0] = data[5];
-			status->iv[1] = data[4];
-			status->iv[2] = data[3];
-			status->iv[3] = data[2];
-			status->iv[4] = data[1];
-			status->iv[5] = data[0];
-
-			insert_ccmp_hdr = FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+			switch (FIELD_GET(MT_RXD1_NORMAL_SEC_MODE, rxd1)) {
+			case MT_RX_CIPHER_AES_CCMP:
+			case MT_RX_CIPHER_CCMP_CCX:
+			case MT_RX_CIPHER_CCMP_256:
+				insert_ccmp_hdr =
+					FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+				fallthrough;
+			case MT_RX_CIPHER_TKIP:
+			case MT_RX_CIPHER_TKIP_NO_MIC:
+			case MT_RX_CIPHER_GCMP:
+			case MT_RX_CIPHER_GCMP_256:
+				status->iv[0] = data[5];
+				status->iv[1] = data[4];
+				status->iv[2] = data[3];
+				status->iv[3] = data[2];
+				status->iv[4] = data[1];
+				status->iv[5] = data[0];
+				break;
+			default:
+				break;
+			}
 		}
 		rxd += 4;
 		if ((u8 *)rxd - skb->data >= skb->len)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index 3af67fac213d..020c1e4ebe2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -155,6 +155,22 @@ enum rx_pkt_type {
 #define MT_CRXV_FOE_HI		GENMASK(6, 0)
 #define MT_CRXV_FOE_SHIFT	13
 
+enum rx_cipher_type {
+	MT_RX_CIPHER_NONE,
+	MT_RX_CIPHER_WEP40,
+	MT_RX_CIPHER_TKIP,
+	MT_RX_CIPHER_TKIP_NO_MIC,
+	MT_RX_CIPHER_AES_CCMP,
+	MT_RX_CIPHER_WEP104,
+	MT_RX_CIPHER_BIP_CMAC_128,
+	MT_RX_CIPHER_WEP128,
+	MT_RX_CIPHER_WAPI,
+	MT_RX_CIPHER_CCMP_CCX,
+	MT_RX_CIPHER_CCMP_256,
+	MT_RX_CIPHER_GCMP,
+	MT_RX_CIPHER_GCMP_256,
+};
+
 enum tx_header_format {
 	MT_HDR_FORMAT_802_3,
 	MT_HDR_FORMAT_CMD,
-- 
2.18.0

