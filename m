Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421CD4DCBF8
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 18:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiCQRDz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiCQRDw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 13:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93001C903
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 10:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73BDB611A6
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 17:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92053C340E9;
        Thu, 17 Mar 2022 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647536554;
        bh=rHkv7zFMNLNacif7jLSCtm6fwSLh4fs+hXMjRd56Nyc=;
        h=From:To:Cc:Subject:Date:From;
        b=oddoC/0/4ESdGWS8h9+IFszW37yTjeGP+NhtQFfVbLH74zbGs7coQDTsciN0ykJ3U
         0TS0bX2MreCgt7RU+hMPmsoO+MMOwfZuuEbQKkFcMPvYCB3qfHtdpgmYbomEkZ3rr+
         vuC9jiLakBMsblkHRK2VqkiSAqeghwCE9NGXalajYkmFigXlq6FpPQOrU69Efsc0HN
         jk8rNyy0BMEO/8z4hEXVJlX8RL55vjCNJnHPNE+8u8e2pmxMy5y1NUbCTIe4rIW5W8
         R+SBkNGE+PN+dCCFdxma1UYZE88xO8desJeHvG9LJ58yYE7AloBQzzPbcqHYCTl7Dc
         UN6NK0lxPpIwQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: mt7921: rely on mt76_dev rxfilter in mt7921_configure_filter
Date:   Thu, 17 Mar 2022 18:02:22 +0100
Message-Id: <5844ea2be0fd3926791f5ede09aa160ebc37b66b.1647536389.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7921 is currently using rxfilter defined in mt76_dev for rx filter
configuration. Fix mt7921_configure_filter implementation.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 29 +++++++++----------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 -
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index fdaf2451bc1d..3c56b1108265 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -566,7 +566,6 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 				    u64 multicast)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
 			MT_WF_RFCR1_DROP_BF_POLL |
 			MT_WF_RFCR1_DROP_BA |
@@ -576,23 +575,23 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 
 #define MT76_FILTER(_flag, _hw) do {					\
 		flags |= *total_flags & FIF_##_flag;			\
-		phy->rxfilter &= ~(_hw);				\
-		phy->rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
+		dev->mt76.rxfilter &= ~(_hw);				\
+		dev->mt76.rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
 	} while (0)
 
 	mt7921_mutex_acquire(dev);
 
-	phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
-			   MT_WF_RFCR_DROP_OTHER_BEACON |
-			   MT_WF_RFCR_DROP_FRAME_REPORT |
-			   MT_WF_RFCR_DROP_PROBEREQ |
-			   MT_WF_RFCR_DROP_MCAST_FILTERED |
-			   MT_WF_RFCR_DROP_MCAST |
-			   MT_WF_RFCR_DROP_BCAST |
-			   MT_WF_RFCR_DROP_DUPLICATE |
-			   MT_WF_RFCR_DROP_A2_BSSID |
-			   MT_WF_RFCR_DROP_UNWANTED_CTL |
-			   MT_WF_RFCR_DROP_STBC_MULTI);
+	dev->mt76.rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
+				MT_WF_RFCR_DROP_OTHER_BEACON |
+				MT_WF_RFCR_DROP_FRAME_REPORT |
+				MT_WF_RFCR_DROP_PROBEREQ |
+				MT_WF_RFCR_DROP_MCAST_FILTERED |
+				MT_WF_RFCR_DROP_MCAST |
+				MT_WF_RFCR_DROP_BCAST |
+				MT_WF_RFCR_DROP_DUPLICATE |
+				MT_WF_RFCR_DROP_A2_BSSID |
+				MT_WF_RFCR_DROP_UNWANTED_CTL |
+				MT_WF_RFCR_DROP_STBC_MULTI);
 
 	MT76_FILTER(OTHER_BSS, MT_WF_RFCR_DROP_OTHER_TIM |
 			       MT_WF_RFCR_DROP_A3_MAC |
@@ -606,7 +605,7 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 			     MT_WF_RFCR_DROP_NDPA);
 
 	*total_flags = flags;
-	mt76_wr(dev, MT_WF_RFCR(0), phy->rxfilter);
+	mt76_wr(dev, MT_WF_RFCR(0), dev->mt76.rxfilter);
 
 	if (*total_flags & FIF_CONTROL)
 		mt76_clear(dev, MT_WF_RFCR1(0), ctl_flags);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 459226c5bb11..eae223a31000 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -155,7 +155,6 @@ struct mt7921_phy {
 
 	struct ieee80211_sband_iftype_data iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
 
-	u32 rxfilter;
 	u64 omac_mask;
 
 	u16 noise;
-- 
2.35.1

