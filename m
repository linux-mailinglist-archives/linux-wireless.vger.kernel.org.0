Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112AB2694D6
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Sep 2020 20:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgINS3P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Sep 2020 14:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgINS3J (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Sep 2020 14:29:09 -0400
Received: from lore-desk.redhat.com (unknown [151.66.80.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D38D321974;
        Mon, 14 Sep 2020 18:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600108148;
        bh=OFrX7REPwlOGbZ8yK/n5ZSUmMQtL7PizlZZOqvNmDa0=;
        h=From:To:Cc:Subject:Date:From;
        b=uqfX53nIfb6oMXQbM1MExi8GGB+pkAPqLpHs0t0xeWUxgbSgvEajmu2iqUb5sDV26
         hptV/pN0blxA6UmHyGDAbkrMT/+jgx9VyqnHrJ+OMOGMbiJYzNPKKgn6whUQFUvqGv
         sWV7VvuzG/wTKoUERG8IHuwdVYDlHC84B6iLAwS0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7915: fix possible memory leak in mt7915_mcu_add_beacon
Date:   Mon, 14 Sep 2020 20:29:01 +0200
Message-Id: <a253c785429964042a2978862a21ae357753d344.1600107907.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Release mcu message memory in case of failure in mt7915_mcu_add_beacon
routine

Fixes: e57b7901469fc ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c    | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index d43de4334617..c1b3b7a6548a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2428,14 +2428,6 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 	struct bss_info_bcn *bcn;
 	int len = MT7915_BEACON_UPDATE_SIZE + MAX_BEACON_SIZE;
 
-	rskb = mt7915_mcu_alloc_sta_req(dev, mvif, NULL, len);
-	if (IS_ERR(rskb))
-		return PTR_ERR(rskb);
-
-	tlv = mt7915_mcu_add_tlv(rskb, BSS_INFO_OFFLOAD, sizeof(*bcn));
-	bcn = (struct bss_info_bcn *)tlv;
-	bcn->enable = en;
-
 	skb = ieee80211_beacon_get_template(hw, vif, &offs);
 	if (!skb)
 		return -EINVAL;
@@ -2446,6 +2438,16 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 		return -EINVAL;
 	}
 
+	rskb = mt7915_mcu_alloc_sta_req(dev, mvif, NULL, len);
+	if (IS_ERR(rskb)) {
+		dev_kfree_skb(skb);
+		return PTR_ERR(rskb);
+	}
+
+	tlv = mt7915_mcu_add_tlv(rskb, BSS_INFO_OFFLOAD, sizeof(*bcn));
+	bcn = (struct bss_info_bcn *)tlv;
+	bcn->enable = en;
+
 	if (mvif->band_idx) {
 		info = IEEE80211_SKB_CB(skb);
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
-- 
2.26.2

