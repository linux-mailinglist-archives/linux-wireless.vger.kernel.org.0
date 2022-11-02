Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8542B6162C6
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 13:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiKBMfU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiKBMfQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 08:35:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A3529802
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 05:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B14B6B82277
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 12:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B4CC433D6;
        Wed,  2 Nov 2022 12:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667392506;
        bh=lluLYtvfpm5KFxMnC2C9jDsIlb35Evi28ahB/ZQFe5o=;
        h=From:To:Cc:Subject:Date:From;
        b=VJpbkKEf1wUXMzGUug4vnW4/Aep8Z6Aq4HukaNEneRsk5lPY9r3Gdvr+8A0rkolsM
         g6O6XPGbxh4hCvXBmNaSD42GFH4SdRJIkeZN4rtmlZrgaHV/ftJa98LKTnBhm9h7iL
         LvaEOheJbfka4als8o8H5oHik7mxFQvRB22HDaesNK42Ah3RwpiQ5XqkRkZjf8OGh4
         8J1UE6rfo5KiD+xpXzv0qKaz7ff5OiUyaUgeBJy0EJd/KMUhhtZnuUadZFxKQnTcEX
         D/AztBjHHoke+Qd1doIH9Jh3runfI32tr+JTuThwlt8HDX9VQJtXyNy1DURTb0yKYy
         ZmeuWGNKuv6Aw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] wifi: mt76: mt7915: fix reporting of TX AGGR histogram
Date:   Wed,  2 Nov 2022 13:35:01 +0100
Message-Id: <33a05d9d25e43fbb880bea5e1ad52c92f1ad2e27.1667392073.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix stats clash between bins [4-7] in 802.11 tx aggregation histogram.

Fixes: e57b7901469fc ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 324f0f58572b..830a8e3b7196 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1611,7 +1611,7 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 
 	aggr0 = phy->band_idx ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	if (is_mt7915(&dev->mt76)) {
-		for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
+		for (i = 0, aggr1 = aggr0 + 8; i < 4; i++) {
 			val = mt76_rr(dev, MT_MIB_MB_SDR1(phy->band_idx, (i << 4)));
 			mib->ba_miss_cnt +=
 				FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
-- 
2.38.1

