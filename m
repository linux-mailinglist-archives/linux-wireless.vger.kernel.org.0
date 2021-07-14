Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AFA3C8CE6
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 21:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhGNTnJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 15:43:09 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44048 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235149AbhGNTmi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 15:42:38 -0400
X-UUID: ddf618cde6504df6a151497ff0c0b790-20210715
X-UUID: ddf618cde6504df6a151497ff0c0b790-20210715
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 119359865; Thu, 15 Jul 2021 03:39:44 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 03:39:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 03:39:42 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix endianness warnings in mu radiotap
Date:   Thu, 15 Jul 2021 03:39:41 +0800
Message-ID: <042666b307b7a424680bd20b6ac3bd3a74e3a1f7.1626291427.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix sparse: sparse: restricted __le32 degrades to integer

Fixes: e63fadb87fe1 ("mt76: mt7915: report HE MU radiotap")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
Hi Felix, could you help to fold this into previous commit?
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f1574538315d..cb7397f53045 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -292,19 +292,19 @@ mt7915_mac_decode_he_mu_radiotap(struct sk_buff *skb,
 			 MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
 				 le32_get_bits(rxv[2], MT_CRXV_HE_NUM_USER));
 
-	he_mu->ru_ch1[0] = FIELD_GET(MT_CRXV_HE_RU0, cpu_to_le32(rxv[3]));
+	he_mu->ru_ch1[0] = FIELD_GET(MT_CRXV_HE_RU0, le32_to_cpu(rxv[3]));
 
 	if (status->bw >= RATE_INFO_BW_40) {
 		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
 		he_mu->ru_ch2[0] =
-			FIELD_GET(MT_CRXV_HE_RU1, cpu_to_le32(rxv[3]));
+			FIELD_GET(MT_CRXV_HE_RU1, le32_to_cpu(rxv[3]));
 	}
 
 	if (status->bw >= RATE_INFO_BW_80) {
 		he_mu->ru_ch1[1] =
-			FIELD_GET(MT_CRXV_HE_RU2, cpu_to_le32(rxv[3]));
+			FIELD_GET(MT_CRXV_HE_RU2, le32_to_cpu(rxv[3]));
 		he_mu->ru_ch2[1] =
-			FIELD_GET(MT_CRXV_HE_RU3, cpu_to_le32(rxv[3]));
+			FIELD_GET(MT_CRXV_HE_RU3, le32_to_cpu(rxv[3]));
 	}
 }
 
@@ -339,7 +339,7 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
 		    le16_encode_bits(ltf_size,
 				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
-	if (cpu_to_le32(rxv[0]) & MT_PRXV_TXBF)
+	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
 		he->data5 |= HE_BITS(DATA5_TXBF);
 	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
 		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
-- 
2.29.2

