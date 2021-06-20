Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A123ADD79
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jun 2021 09:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhFTHua (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Jun 2021 03:50:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38844 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229558AbhFTHu3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Jun 2021 03:50:29 -0400
X-UUID: 478acd45b79046d68dd1c9989ffb2965-20210620
X-UUID: 478acd45b79046d68dd1c9989ffb2965-20210620
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1459100602; Sun, 20 Jun 2021 15:48:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 20 Jun 2021 15:48:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 20 Jun 2021 15:48:10 +0800
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
Subject: [PATCH 2/2] mt76: fix build error implicit enumeration conversion
Date:   Sun, 20 Jun 2021 15:48:07 +0800
Message-ID: <62c5ed786f81ddea6d3587647520e9e4254c8612.1624174954.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <9b704807383f3048898944d2b9cb74e6b4e8d83d.1624174954.git.objelf@gmail.com>
References: <9b704807383f3048898944d2b9cb74e6b4e8d83d.1624174954.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:114:10: error: implicit
conversion from enumeration type 'enum mt76_cipher_type' to different
enumeration type 'enum mcu_cipher_type' [-Werror,-Wenum-conversion]
                return MT_CIPHER_NONE;
                ~~~~~~ ^~~~~~~~~~~~~~

drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:114:10: error: implicit
conversion from enumeration type 'enum mt76_cipher_type' to different
enumeration type 'enum mcu_cipher_type' [-Werror,-Wenum-conversion]
                return MT_CIPHER_NONE;
                ~~~~~~ ^~~~~~~~~~~~~~

Fixes: c368362c36d3 ("mt76: fix iv and CCMP header insertion")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h | 3 ++-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 863aa18b3024..c2e537a9c1dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -111,7 +111,7 @@ mt7915_mcu_get_cipher(int cipher)
 	case WLAN_CIPHER_SUITE_SMS4:
 		return MCU_CIPHER_WAPI;
 	default:
-		return MT_CIPHER_NONE;
+		return MCU_CIPHER_NONE;
 	}
 }
 
@@ -1201,7 +1201,7 @@ mt7915_mcu_sta_key_tlv(struct mt7915_sta *msta, struct sk_buff *skb,
 		u8 cipher;
 
 		cipher = mt7915_mcu_get_cipher(key->cipher);
-		if (cipher == MT_CIPHER_NONE)
+		if (cipher == MCU_CIPHER_NONE)
 			return -EOPNOTSUPP;
 
 		sec_key = &sec->key[0];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index edd3ba3a0c2d..5b9b425bd836 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -1073,7 +1073,8 @@ enum {
 };
 
 enum mcu_cipher_type {
-	MCU_CIPHER_WEP40 = 1,
+	MCU_CIPHER_NONE,
+	MCU_CIPHER_WEP40,
 	MCU_CIPHER_WEP104,
 	MCU_CIPHER_WEP128,
 	MCU_CIPHER_TKIP,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index c2c4dc196802..81633be09e90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -111,7 +111,7 @@ mt7921_mcu_get_cipher(int cipher)
 	case WLAN_CIPHER_SUITE_SMS4:
 		return MCU_CIPHER_WAPI;
 	default:
-		return MT_CIPHER_NONE;
+		return MCU_CIPHER_NONE;
 	}
 }
 
@@ -619,7 +619,7 @@ mt7921_mcu_sta_key_tlv(struct mt7921_sta *msta, struct sk_buff *skb,
 		u8 cipher;
 
 		cipher = mt7921_mcu_get_cipher(key->cipher);
-		if (cipher == MT_CIPHER_NONE)
+		if (cipher == MCU_CIPHER_NONE)
 			return -EOPNOTSUPP;
 
 		sec_key = &sec->key[0];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index d76cf8f8dfdf..3334afd8aea9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -199,7 +199,8 @@ struct sta_rec_sec {
 } __packed;
 
 enum mcu_cipher_type {
-	MCU_CIPHER_WEP40 = 1,
+	MCU_CIPHER_NONE,
+	MCU_CIPHER_WEP40,
 	MCU_CIPHER_WEP104,
 	MCU_CIPHER_WEP128,
 	MCU_CIPHER_TKIP,
-- 
2.25.1

