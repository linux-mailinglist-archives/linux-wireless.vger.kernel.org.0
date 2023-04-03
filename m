Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1311A6D4221
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 12:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjDCKed (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 06:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjDCKe1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 06:34:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E699683C1
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 03:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F329B81106
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 10:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15E6C433D2;
        Mon,  3 Apr 2023 10:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680518061;
        bh=F5rfzGUyGVLrsyXECLJ4liKHzkbIaxbyn7XiKYgHvbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrK7kEmX4xTLsKkzqElSl9LvU13K3lZnr8EdN8c8/vfcCKTnv9LqUuHxipHInAbcn
         SNuv4vpGE516Ebnv0vaYIPUOopr2zALYkr/2FSPRWli7sRHykJZFKCX++jDKOLnj79
         IM6btPMS9Atoq+04Z0Kya93MYZtQfQpHH19xRjNrmTJXHuhrXC+w0H61KMh8SS5WQO
         +d9/qff+CMqC5gxZyP7mJ/W4v+mSTUpoz3MKK0j/Kwfh7epQecMmv+4uwRHNUeH2gZ
         d8Sv/OwB8BVXNnT2PuTmpQrNvsn8/r9NBeW2OV/TpaOIF277/wnAkxKzKipCzvRosG
         JxLxC8EIYh0yw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/6] wifi: mt76: add mt76_connac_gen_ppe_thresh utility routine
Date:   Mon,  3 Apr 2023 12:33:58 +0200
Message-Id: <87d2ad9cd8cc6b349a2ad983f07a0fb1c9dbe507.1680517676.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680517676.git.lorenzo@kernel.org>
References: <cover.1680517676.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

gen_ppe_thresh routine is shared between mt7615, mt7915, mt7921 and
mt7996 so move it in mt76_connac module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  1 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 21 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 23 +------------------
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 23 +------------------
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 23 +------------------
 5 files changed, 25 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 84974dfe1953..fc8e999a431a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -359,6 +359,7 @@ mt76_connac_mutex_release(struct mt76_dev *dev, struct mt76_connac_pm *pm)
 	mutex_unlock(&dev->mutex);
 }
 
+void mt76_connac_gen_ppe_thresh(u8 *he_ppet, int nss);
 int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
 			       int ring_base, u32 flags);
 void mt76_connac_write_hw_txp(struct mt76_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index aed4ee95fb2e..ef55fd06c889 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -9,6 +9,27 @@
 #define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
 						 IEEE80211_RADIOTAP_HE_##f)
 
+void mt76_connac_gen_ppe_thresh(u8 *he_ppet, int nss)
+{
+	static const u8 ppet16_ppet8_ru3_ru0[] = { 0x1c, 0xc7, 0x71 };
+	u8 i, ppet_bits, ppet_size, ru_bit_mask = 0x7; /* HE80 */
+
+	he_ppet[0] = FIELD_PREP(IEEE80211_PPE_THRES_NSS_MASK, nss - 1) |
+		     FIELD_PREP(IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK,
+				ru_bit_mask);
+
+	ppet_bits = IEEE80211_PPE_THRES_INFO_PPET_SIZE *
+		    nss * hweight8(ru_bit_mask) * 2;
+	ppet_size = DIV_ROUND_UP(ppet_bits, 8);
+
+	for (i = 0; i < ppet_size - 1; i++)
+		he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3];
+
+	he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3] &
+			 (0xff >> (8 - (ppet_bits - 1) % 8));
+}
+EXPORT_SYMBOL_GPL(mt76_connac_gen_ppe_thresh);
+
 int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 {
 	struct mt76_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 0d52c30ff8fd..538ec0f8e630 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -931,27 +931,6 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
 	}
 }
 
-static void
-mt7915_gen_ppe_thresh(u8 *he_ppet, int nss)
-{
-	u8 i, ppet_bits, ppet_size, ru_bit_mask = 0x7; /* HE80 */
-	static const u8 ppet16_ppet8_ru3_ru0[] = {0x1c, 0xc7, 0x71};
-
-	he_ppet[0] = FIELD_PREP(IEEE80211_PPE_THRES_NSS_MASK, nss - 1) |
-		     FIELD_PREP(IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK,
-				ru_bit_mask);
-
-	ppet_bits = IEEE80211_PPE_THRES_INFO_PPET_SIZE *
-		    nss * hweight8(ru_bit_mask) * 2;
-	ppet_size = DIV_ROUND_UP(ppet_bits, 8);
-
-	for (i = 0; i < ppet_size - 1; i++)
-		he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3];
-
-	he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3] &
-			 (0xff >> (8 - (ppet_bits - 1) % 8));
-}
-
 static int
 mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 		    struct ieee80211_sband_iftype_data *data)
@@ -1101,7 +1080,7 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 		if (he_cap_elem->phy_cap_info[6] &
 		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-			mt7915_gen_ppe_thresh(he_cap->ppe_thres, nss);
+			mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss);
 		} else {
 			he_cap_elem->phy_cap_info[9] |=
 				u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index a72964e7a807..e419458e54f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -9,27 +9,6 @@
 #include "mt7921.h"
 #include "mcu.h"
 
-static void
-mt7921_gen_ppe_thresh(u8 *he_ppet, int nss)
-{
-	u8 i, ppet_bits, ppet_size, ru_bit_mask = 0x7; /* HE80 */
-	static const u8 ppet16_ppet8_ru3_ru0[] = {0x1c, 0xc7, 0x71};
-
-	he_ppet[0] = FIELD_PREP(IEEE80211_PPE_THRES_NSS_MASK, nss - 1) |
-		     FIELD_PREP(IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK,
-				ru_bit_mask);
-
-	ppet_bits = IEEE80211_PPE_THRES_INFO_PPET_SIZE *
-		    nss * hweight8(ru_bit_mask) * 2;
-	ppet_size = DIV_ROUND_UP(ppet_bits, 8);
-
-	for (i = 0; i < ppet_size - 1; i++)
-		he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3];
-
-	he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3] &
-			 (0xff >> (8 - (ppet_bits - 1) % 8));
-}
-
 static int
 mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 		    struct ieee80211_sband_iftype_data *data)
@@ -168,7 +147,7 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 		if (he_cap_elem->phy_cap_info[6] &
 		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-			mt7921_gen_ppe_thresh(he_cap->ppe_thres, nss);
+			mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss);
 		} else {
 			he_cap_elem->phy_cap_info[9] |=
 				u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 98bfd94bb632..bb5cf2f5b9df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -552,27 +552,6 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 	elem->phy_cap_info[7] |= c;
 }
 
-static void
-mt7996_gen_ppe_thresh(u8 *he_ppet, int nss)
-{
-	u8 i, ppet_bits, ppet_size, ru_bit_mask = 0x7; /* HE80 */
-	static const u8 ppet16_ppet8_ru3_ru0[] = {0x1c, 0xc7, 0x71};
-
-	he_ppet[0] = FIELD_PREP(IEEE80211_PPE_THRES_NSS_MASK, nss - 1) |
-		     FIELD_PREP(IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK,
-				ru_bit_mask);
-
-	ppet_bits = IEEE80211_PPE_THRES_INFO_PPET_SIZE *
-		    nss * hweight8(ru_bit_mask) * 2;
-	ppet_size = DIV_ROUND_UP(ppet_bits, 8);
-
-	for (i = 0; i < ppet_size - 1; i++)
-		he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3];
-
-	he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3] &
-			 (0xff >> (8 - (ppet_bits - 1) % 8));
-}
-
 static void
 mt7996_init_he_caps(struct mt7996_phy *phy, enum nl80211_band band,
 		    struct ieee80211_sband_iftype_data *data,
@@ -678,7 +657,7 @@ mt7996_init_he_caps(struct mt7996_phy *phy, enum nl80211_band band,
 	memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 	if (he_cap_elem->phy_cap_info[6] &
 	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-		mt7996_gen_ppe_thresh(he_cap->ppe_thres, nss);
+		mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss);
 	} else {
 		he_cap_elem->phy_cap_info[9] |=
 			u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
-- 
2.39.2

