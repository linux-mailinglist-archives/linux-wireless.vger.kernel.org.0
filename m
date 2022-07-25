Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557D657FB4E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 10:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiGYI0x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jul 2022 04:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiGYI0w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jul 2022 04:26:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E4213EB6
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 01:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FE3DB80DDC
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 08:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E062EC341C6;
        Mon, 25 Jul 2022 08:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658737609;
        bh=n99uiIVC7o0JNSaC+a7Vh38gD9FGqPW5VPi3XvbwKW0=;
        h=From:To:Cc:Subject:Date:From;
        b=VOF1l6xFUIHAq7HQoNo/YhJmvofL3Ny3SwL4SFEJc7ovFftivyqTZX6JxhbPrEpMh
         D4OTIufGxad4Dxxm6+lqRGcSrzpQk2cIFcyq3mpaudUnIBEmzVsWAyA2AutPpR9bgf
         ymLAywdkPYGGR6dJT2MGDYPzVg+lUo1+QQSNSohQ2i04LbxUsjT225DBdXfX1HBmJh
         L/p5Vjy7swVg22h7UCCrNTe6xpSsZj0T1FbD+xwcjj9XJ0HYjvTncznCKwlcsMClkJ
         l+CzJyiDdQR64k6lOmbbXj3znOc85+N6s7FcSfNA93NAxjOfAbJwtL0UNuEeWccU0j
         blZnR2Zobd8BQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: add mt7615_mutex_acquire/release in mt7615_sta_set_decap_offload
Date:   Mon, 25 Jul 2022 10:26:40 +0200
Message-Id: <8f71863b5d10cad0b1b3e3c653c40d8b2a787102.1658737542.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7921 driver, introduce mt7615_mutex_acquire/release in
mt7615_sta_set_decap_offload in order to avoid sending mcu commands
while the device is in low-power state.

Fixes: d4b98c63d7a77 ("mt76: mt7615: add support for rx decapsulation offload")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 9bf8545c8c17..8d4733f87cda 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1195,12 +1195,16 @@ static void mt7615_sta_set_decap_offload(struct ieee80211_hw *hw,
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
 
+	mt7615_mutex_acquire(dev);
+
 	if (enabled)
 		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
 	else
 		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
 
 	mt7615_mcu_set_sta_decap_offload(dev, vif, sta);
+
+	mt7615_mutex_release(dev);
 }
 
 #ifdef CONFIG_PM
-- 
2.36.1

