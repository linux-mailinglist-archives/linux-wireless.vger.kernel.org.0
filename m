Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77ED4383E2
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 15:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhJWNwO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 09:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhJWNwN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 09:52:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4F4660FE3;
        Sat, 23 Oct 2021 13:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634996994;
        bh=sydh8B5e0hVv4DBbKuOJXv84Y8w5A7lZam+qirHyxCA=;
        h=From:To:Cc:Subject:Date:From;
        b=Lxbkw5H05oyiWGMlWDEabbDk6BWm6ZMEHjwAwNkLRxT0Zf+jLM7VZdipFMJWH02cZ
         LDaLJ4y55ofAq4bPZwxMP9U0vgm0ya0M1QyPctXJ9SPB+UKtdy/9vRsCXl0J0yVgAH
         tX0S/TaEJfTZXBaGiCn+WpAlzMAaCvtL+ef6bT1JYwYav1uhDKzfKbqdMhDkUhXTaM
         CDagsTx21ffPvVIG7HN90FrTP5AapngM4hLRvQ01RQPABDbfgrxYlu3sgTYf4CqG2k
         4zXav4HKopr++U+5i1tSG3q9rdVRfEYFk/njB5jML91Bko0FkhF/DtrNwmZBS5X2gg
         jTzsbTDne3yFw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7915: get rid of mt7915_mcu_set_fixed_rate routine
Date:   Sat, 23 Oct 2021 15:49:38 +0200
Message-Id: <d09619456ba3bf2d83b8929aefe00915ecce6b55.1634996863.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning removing mt7915_mcu_set_fixed_rate
since it is no longer used:
warning: symbol 'mt7915_mcu_set_fixed_rate' was not declared.
Should it be static?

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 47 -------------------
 1 file changed, 47 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0b86ac2941d2..861099970aa3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2397,53 +2397,6 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
-int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
-			      struct ieee80211_sta *sta, u32 rate)
-{
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct mt7915_vif *mvif = msta->vif;
-	struct sta_rec_ra_fixed *ra;
-	struct sk_buff *skb;
-	struct tlv *tlv;
-	int len = sizeof(struct sta_req_hdr) + sizeof(*ra);
-
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_RA_UPDATE, sizeof(*ra));
-	ra = (struct sta_rec_ra_fixed *)tlv;
-
-	if (!rate) {
-		ra->field = cpu_to_le32(RATE_PARAM_AUTO);
-		goto out;
-	}
-
-	ra->field = cpu_to_le32(RATE_PARAM_FIXED);
-	ra->phy.type = FIELD_GET(RATE_CFG_PHY_TYPE, rate);
-	ra->phy.bw = FIELD_GET(RATE_CFG_BW, rate);
-	ra->phy.nss = FIELD_GET(RATE_CFG_NSS, rate);
-	ra->phy.mcs = FIELD_GET(RATE_CFG_MCS, rate);
-	ra->phy.stbc = FIELD_GET(RATE_CFG_STBC, rate);
-
-	if (ra->phy.bw)
-		ra->phy.ldpc = 7;
-	else
-		ra->phy.ldpc = FIELD_GET(RATE_CFG_LDPC, rate) * 7;
-
-	/* HT/VHT - SGI: 1, LGI: 0; HE - SGI: 0, MGI: 1, LGI: 2 */
-	if (ra->phy.type > MT_PHY_TYPE_VHT) {
-		ra->phy.he_ltf = FIELD_GET(RATE_CFG_HE_LTF, rate) * 85;
-		ra->phy.sgi = FIELD_GET(RATE_CFG_GI, rate) * 85;
-	} else {
-		ra->phy.sgi = FIELD_GET(RATE_CFG_GI, rate) * 15;
-	}
-
-out:
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD(STA_REC_UPDATE), true);
-}
-
 int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, bool enable)
 {
-- 
2.31.1

