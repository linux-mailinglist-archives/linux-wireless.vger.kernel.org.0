Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0326297B2
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Nov 2022 12:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiKOLou (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Nov 2022 06:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKOLot (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Nov 2022 06:44:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02A725EAD
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 03:44:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DB75616C6
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 11:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50659C433C1;
        Tue, 15 Nov 2022 11:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668512687;
        bh=h88wpqaZUXmSS/gbvvuw/l0owrcNjjD5NkdvpYSxmsw=;
        h=From:To:Cc:Subject:Date:From;
        b=ObRpJXAOLsgSOBBVS2AEy/gWAhtIsgJifct0ga2Cik6/KtaYrE62GDvvxdfiHE1Ci
         BNP1tYxKe6J318RmIw+slCFKm9hKt3J5iz9dHudUwmjH8t1eoIGwagx4t67AR0jMvl
         FCnBJGymsJw3dJ1WhDJw30cG7Iqg7anBmm5Zc6E38cxWbNDSbvpPZKZhQki1QXVgAG
         6xyg10OpERAlLmU0kgI9Sb4YJLzoXNBWLRyBekcYs23Ftykoc6oY2l1h8AvkQJfT7E
         J0Qj1vJwtjtHQw3fp3k8z0t+cMDMO+7jwjrdl/E0wA4/rVuGYytqXyyganiz6wUl1h
         X38BVK307YqZw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7996: fix uninitialized variable warnings
Date:   Tue, 15 Nov 2022 12:44:40 +0100
Message-Id: <11522a6a898ae04a5e1cdc805603ed7e6bd14f7a.1668507269.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix uninitialized variable warnings in mt7996/mac.c and mt7996/mcu.c

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index d0a32638a65b..9650590a5d4b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -200,11 +200,11 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 			break;
 		}
 
+		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 6);
+		val = mt76_rr(dev, addr);
 		if (rate->flags & RATE_INFO_FLAGS_HE_MCS) {
 			u8 offs = 24 + 2 * bw;
 
-			addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 6);
-			val = mt76_rr(dev, addr);
 			rate->he_gi = (val & (0x3 << offs)) >> offs;
 		} else if (rate->flags &
 			   (RATE_INFO_FLAGS_VHT_MCS | RATE_INFO_FLAGS_MCS)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 9ce249ac7097..adc80b9930bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -700,15 +700,14 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct cfg80211_chan_def *chandef = &phy->chandef;
 	struct mt76_connac_bss_basic_tlv *bss;
+	u32 type = CONNECTION_INFRA_AP;
 	struct tlv *tlv;
-	u32 type;
 	int idx;
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MONITOR:
-		type = CONNECTION_INFRA_AP;
 		break;
 	case NL80211_IFTYPE_STATION:
 		if (enable) {
-- 
2.38.1

