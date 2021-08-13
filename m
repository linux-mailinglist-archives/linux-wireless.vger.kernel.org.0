Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBC03EB484
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 13:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbhHML11 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 07:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234969AbhHML11 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 07:27:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA90261038;
        Fri, 13 Aug 2021 11:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628854020;
        bh=zzhGvJRgBx3D+SBZ3b1EU28dNhTHsiqgMRk/uIKHqOg=;
        h=From:To:Cc:Subject:Date:From;
        b=d+ABPF5xOYEVA0HpSNtTGH3GTMvsTOPDyuZihqVvtb/atdu4hlFc6bwkfiftNZcf6
         bcF1sjj+jl9+uNyiVdzV5fFpWxHRInt2ulmHjqpS2zwGYizQcJsQijfU9mEVQQUeaP
         6gHu6x1/PNGBijY8p2m1kRt8HAtvKDshp0virUzq0cuC40n4uSNoO+1filsxVY8e0q
         Ic3abE/hxM/H0a98sJj7UCazNMgB4NPvpRf7NW5DclbRR/WrR/tBJG2RVb3PQXjmSG
         gJZPYqNyJdvqmx6se/eeAtHf/9le0Ee305qX/BFEirYpq24XOHAxGRD6cVJz5pyNbP
         H2h/VgiAD3i+Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: fix endianness warnings in mt7921_mac_decode_he_mu_radiotap
Date:   Fri, 13 Aug 2021 13:26:53 +0200
Message-Id: <dd56fef20ebb3901438faaccbf67686e958ae0a8.1628853985.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse endianness warnings

drivers/net/wireless/mediatek/mt76/mt7921/mac.c:212:28: warning: cast from restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:212:28: warning: cast to restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:212:28: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:212:28: warning: cast from restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:212:28: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:217:25: warning: cast from restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:217:25: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:217:25: warning: cast from restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:217:25: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:222:25: warning: cast from restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:222:25: warning: cast to restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:222:25: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:222:25: warning: cast from restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:222:25: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:224:25: warning: cast from restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:224:25: warning: cast to restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:224:25: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:224:25: warning: cast from restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:224:25: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:259:13: warning: cast from restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:259:13: warning: restricted __le32 degrades to integer

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index df3d2b637fae..b0905d80837b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -194,7 +194,7 @@ mt7921_mac_decode_he_mu_radiotap(struct sk_buff *skb,
 		.flags2 = HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN) |
 			  HE_BITS(MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN),
 	};
-	struct ieee80211_radiotap_he_mu *he_mu = NULL;
+	struct ieee80211_radiotap_he_mu *he_mu;
 
 	he_mu = skb_push(skb, sizeof(mu_known));
 	memcpy(he_mu, &mu_known, sizeof(mu_known));
@@ -209,19 +209,19 @@ mt7921_mac_decode_he_mu_radiotap(struct sk_buff *skb,
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
 
@@ -256,7 +256,7 @@ mt7921_mac_decode_he_radiotap(struct sk_buff *skb,
 	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
 		    le16_encode_bits(ltf_size,
 				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
-	if (cpu_to_le32(rxv[0]) & MT_PRXV_TXBF)
+	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
 		he->data5 |= HE_BITS(DATA5_TXBF);
 	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
 		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
-- 
2.31.1

