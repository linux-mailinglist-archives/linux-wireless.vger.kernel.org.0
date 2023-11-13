Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAA47E99C1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 11:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjKMKGz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 05:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjKMKGx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 05:06:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18184D55
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 02:06:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26617C433C7;
        Mon, 13 Nov 2023 10:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699870010;
        bh=EUSlVaf2acA1x8lSu9xYBFHoIjC5uHvh5joOYcs8pww=;
        h=From:To:Cc:Subject:Date:From;
        b=tIVlJPBbyfqCXvlVw0vngHGmMFWAdKV8nFeTJ4Vh5TYayKzNtgzagRmGAgMCfWZ9f
         LPb6ClUwvJP5+atMNeKbLaQkkHLLf5RIHi//QJ5TKu2GeRGfG8k8YTFfVwsdGQK+uH
         oYAUpD0idTKBCwWMRifRfAQKw7a6L2/W3JBQEaHGZPv9xlSAekzzCYse/3hgxn1P5T
         MyUfVqv+xCDUZUN7ImSnKzwezGtsyrEXkCntN+wJTMcEI3eTNAKm6k5YgBFyV1qryN
         Dgmfko9JUwVL+DZid6BJoFKZJ6YTdJkkeS4McO+OWLhEBbBj7uPpuehN3/hPPuX01d
         x8NnA+IxzUgbQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name, sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH wireless] wifi: mt76: mt7925: fix typo in mt7925_init_he_caps
Date:   Mon, 13 Nov 2023 11:06:33 +0100
Message-ID: <7de6e939dc75ee08f05bf1ee73253aa7eeccf28e.1699869649.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use iftype for interface type switch in mt7925_init_he_caps routine

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 15c2fb0bcb1b..aa918b9b0469 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -14,7 +14,7 @@
 static void
 mt7925_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
 		    struct ieee80211_sband_iftype_data *data,
-			enum nl80211_iftype iftype)
+		    enum nl80211_iftype iftype)
 {
 	struct ieee80211_sta_he_cap *he_cap = &data->he_cap;
 	struct ieee80211_he_cap_elem *he_cap_elem = &he_cap->he_cap_elem;
@@ -53,7 +53,7 @@ mt7925_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
 		IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
 		IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
 
-	switch (i) {
+	switch (iftype) {
 	case NL80211_IFTYPE_AP:
 		he_cap_elem->mac_cap_info[2] |=
 			IEEE80211_HE_MAC_CAP2_BSR;
-- 
2.41.0

