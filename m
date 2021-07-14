Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F793C91F8
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 22:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbhGNUWz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 16:22:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57232 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232185AbhGNUWy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 16:22:54 -0400
X-UUID: 3e74da53897242f1b5587327c384614f-20210715
X-UUID: 3e74da53897242f1b5587327c384614f-20210715
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1326171460; Thu, 15 Jul 2021 04:20:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 04:19:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 04:19:59 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] mt76: mt7915: fix endianness warnings in mu radiotap
Date:   Thu, 15 Jul 2021 04:19:57 +0800
Message-ID: <b4a1c893d91ab7cfae9765e8e7ec3369220211ad.1626293825.git.ryder.lee@mediatek.com>
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
v2 - use le32_get_bits instead of FIELD_GET.

Hi Felix, please help to fold this into the previous commit.
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f1574538315d..b74db3e61098 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -292,19 +292,16 @@ mt7915_mac_decode_he_mu_radiotap(struct sk_buff *skb,
 			 MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
 				 le32_get_bits(rxv[2], MT_CRXV_HE_NUM_USER));
 
-	he_mu->ru_ch1[0] = FIELD_GET(MT_CRXV_HE_RU0, cpu_to_le32(rxv[3]));
+	he_mu->ru_ch1[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU0);
 
 	if (status->bw >= RATE_INFO_BW_40) {
 		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
-		he_mu->ru_ch2[0] =
-			FIELD_GET(MT_CRXV_HE_RU1, cpu_to_le32(rxv[3]));
+		he_mu->ru_ch2[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU1);
 	}
 
 	if (status->bw >= RATE_INFO_BW_80) {
-		he_mu->ru_ch1[1] =
-			FIELD_GET(MT_CRXV_HE_RU2, cpu_to_le32(rxv[3]));
-		he_mu->ru_ch2[1] =
-			FIELD_GET(MT_CRXV_HE_RU3, cpu_to_le32(rxv[3]));
+		he_mu->ru_ch1[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU2);
+		he_mu->ru_ch2[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU3);
 	}
 }
 
@@ -339,7 +336,7 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
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

