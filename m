Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AF15539B4
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 20:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiFUSss (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 14:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiFUSsr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 14:48:47 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC713CD1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=L1FRchUF7jIw9REJ5HkNxIoNqZqIMcTdaZriLqrKW70=; b=HrTvW806k7IBVZU0/OdpCthedj
        GRVrocqcLmufXXoKP3xVvzGWMdkvbf+rlXN+5wYOWtWA29mlQ+AVj0BPbhTBaFCZ/mSJnZRhqNyyv
        HsP4uRL8pGIQ970a/JurwGI7HUr5gEcS5N6nNXKfA0kgBjUzwz5BwW/379zXRWDiin90=;
Received: from p200300daa70a4300f0c34ff46113bff0.dip0.t-ipconnect.de ([2003:da:a70a:4300:f0c3:4ff4:6113:bff0] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o3ivb-0006gO-GB
        for linux-wireless@vger.kernel.org; Tue, 21 Jun 2022 20:48:43 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: disable UL MU-MIMO for mt7915
Date:   Tue, 21 Jun 2022 20:48:41 +0200
Message-Id: <20220621184841.77194-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After initially establishing a connection, it can produce multi-second latency
spikes and tx hangs when pushing traffic.
It should work better for MT7916 and MT7986, so leave it enabled there

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 7 ++++---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  | 9 +++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 2764c22179fb..6bdbc59beada 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -753,9 +753,10 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_dev *dev,
 
 	elem->phy_cap_info[7] &= ~IEEE80211_HE_PHY_CAP7_MAX_NC_MASK;
 
-	c = IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
-	    IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
-	    IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
+	c = IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US;
+	if (!is_mt7915(&dev->mt76))
+		c |= IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
+		     IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
 	elem->phy_cap_info[2] |= c;
 
 	c = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 207fd0b83417..6b0b9a86b9d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -826,8 +826,8 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 }
 
 static void
-mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
-			struct ieee80211_vif *vif)
+mt7915_mcu_sta_muru_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
+			struct ieee80211_sta *sta, struct ieee80211_vif *vif)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct ieee80211_he_cap_elem *elem = &sta->deflink.he_cap.he_cap_elem;
@@ -845,7 +845,8 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	muru->cfg.mimo_dl_en = mvif->cap.he_mu_ebfer ||
 			       mvif->cap.vht_mu_ebfer ||
 			       mvif->cap.vht_mu_ebfee;
-	muru->cfg.mimo_ul_en = true;
+	if (!is_mt7915(&dev->mt76))
+		muru->cfg.mimo_ul_en = true;
 	muru->cfg.ofdma_dl_en = true;
 
 	if (sta->deflink.vht_cap.vht_supported)
@@ -1647,7 +1648,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		/* starec he */
 		mt7915_mcu_sta_he_tlv(skb, sta, vif);
 		/* starec muru */
-		mt7915_mcu_sta_muru_tlv(skb, sta, vif);
+		mt7915_mcu_sta_muru_tlv(dev, skb, sta, vif);
 		/* starec bfee */
 		mt7915_mcu_sta_bfee_tlv(dev, skb, vif, sta);
 	}
-- 
2.36.1

