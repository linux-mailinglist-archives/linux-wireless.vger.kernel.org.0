Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45C03D8388
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jul 2021 00:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhG0W72 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 18:59:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37948 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233302AbhG0W7X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 18:59:23 -0400
X-UUID: 52f9af9241ba41758991c87ea8a39045-20210728
X-UUID: 52f9af9241ba41758991c87ea8a39045-20210728
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 379729850; Wed, 28 Jul 2021 06:59:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 06:59:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Jul 2021 06:59:18 +0800
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
Subject: [PATCH 1/2] mt76: connac: fix GTK rekey offload failure on WPA mixed mode
Date:   Wed, 28 Jul 2021 06:59:16 +0800
Message-ID: <1627426757-14811-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Leon Yen <Leon.Yen@mediatek.com>

Update the proper firmware programming sequence to fix GTK rekey
offload failure on WPA mixed mode.

In the mt76_connac_mcu_key_iter,
gtk_tlv->proto should be only set up on pairwise key
and gtk_tlk->group_cipher should be only set up on the group key.

Otherwise, those parameters required by firmware would be set
incorrectly to cause GTK rekey offload failure on WPA mixed mode
and then disconnection follows.

Fixes: b47e21e75c80 ("mt76: mt7615: add gtk rekey offload support")
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c  | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index a2555dc0f003..d71393b1c5e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1957,19 +1957,22 @@ mt76_connac_mcu_key_iter(struct ieee80211_hw *hw,
 	    key->cipher != WLAN_CIPHER_SUITE_TKIP)
 		return;
 
-	if (key->cipher == WLAN_CIPHER_SUITE_TKIP) {
-		gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_1);
+	if (key->cipher == WLAN_CIPHER_SUITE_TKIP)
 		cipher = BIT(3);
-	} else {
-		gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_2);
+	else
 		cipher = BIT(4);
-	}
 
 	/* we are assuming here to have a single pairwise key */
 	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
+		if (key->cipher == WLAN_CIPHER_SUITE_TKIP)
+			gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_1);
+		else
+			gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_2);
+
 		gtk_tlv->pairwise_cipher = cpu_to_le32(cipher);
-		gtk_tlv->group_cipher = cpu_to_le32(cipher);
 		gtk_tlv->keyid = key->keyidx;
+	} else {
+		gtk_tlv->group_cipher = cpu_to_le32(cipher);
 	}
 }
 
-- 
2.25.1

