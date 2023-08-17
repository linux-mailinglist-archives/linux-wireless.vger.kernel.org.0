Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2749277FB3E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353376AbjHQPx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 11:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353352AbjHQPxI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 11:53:08 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E39230D8
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PgneEFBKzSE4xiC9OJT2Trsi866BPZ1ALzfqWOhuXnU=; b=eWId/yhw3y2yUNnM7Q/i16X2eb
        3C+iy1UfNKuVAatbQR4jJwOR0jFTj51cwFx38AwVlCH1eAI472+JN66sSikUpjgGaCEBO4twgnxr6
        hev6+bgv1dKKPOb7NXDw9I9Ixmtm8fRpkQTgMdfysjhAD8eJr1oUjAWwxkEAc8d7NPaE=;
Received: from 134.101.185.184.dynamic-pppoe.dt.ipv4.wtnet.de ([134.101.185.184] helo=Maecks.fritz.box)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qWfJ2-00AmKH-Jh
        for linux-wireless@vger.kernel.org; Thu, 17 Aug 2023 17:53:04 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/5] wifi: mt76: mt7603: disable A-MSDU tx support on MT7628
Date:   Thu, 17 Aug 2023 17:52:58 +0200
Message-ID: <20230817155258.62636-5-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817155258.62636-1-nbd@nbd.name>
References: <20230817155258.62636-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It was reported that this can cause the PSE hang issues, even with a low
number of fragments.

Link: https://github.com/openwrt/mt76/issues/793#issuecomment-1676529138
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index c0ff36a98bed..481c55fe9a66 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -453,7 +453,8 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
 	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
 
-	if (!(dev->drv->drv_flags & MT_DRV_AMSDU_OFFLOAD)) {
+	if (!(dev->drv->drv_flags & MT_DRV_AMSDU_OFFLOAD) &&
+	    hw->max_tx_fragments > 1) {
 		ieee80211_hw_set(hw, TX_AMSDU);
 		ieee80211_hw_set(hw, TX_FRAG_LIST);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index dd3c96f96999..6c55c72f28a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -524,6 +524,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	hw->max_rates = 3;
 	hw->max_report_rates = 7;
 	hw->max_rate_tries = 11;
+	hw->max_tx_fragments = 1;
 
 	hw->radiotap_timestamp.units_pos =
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
-- 
2.41.0

