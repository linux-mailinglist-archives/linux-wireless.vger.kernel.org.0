Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DD2564E25
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 09:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiGDHDH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 03:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiGDHDG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 03:03:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304055F61
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 00:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C045860AE3
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 07:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDCCC3411E;
        Mon,  4 Jul 2022 07:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656918185;
        bh=gPBKz03Kjd23CBZEb09Rd1lRdEcQiYY480RKXu2MaS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ph95+tBsGYWFTUsO6R7rIOAQyFGx2ZDJ2jHRh1P5Fk2RGfWiVJMWmEtkNcp+bmQGi
         5O54HmTfypnXheTJ6MgpAS7lf5KKcs4ePvo12fMULuUnI7kynK0f9LiAlflv78xY4g
         ASdwiuPkln18dv5nNFk/vzR2k4Ff/Dzry+QWi3eYnDe6hz2RVyDW67+sQNaL8V9pqf
         g5j4OO66th1mIRfkyeHNJZjnLeKpCnuXpvOfzspYPwnnZ57RPqekWC7OjK7YU9WSOm
         CnEi0tobeBDhAvEwoezJj29t1RHBB98oAdVYHO+nyOmBrxj2oOFqE2QTJCDNWLX6Ec
         IajCe1H0Z7exA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        bo.jiao@mediatek.com
Subject: [PATCH v3 5/5] mt76: get rid of mt76_wcid_hw routine
Date:   Mon,  4 Jul 2022 09:02:23 +0200
Message-Id: <a95b1d28da4be38459cafd4d1aab7807f38ddfc8.1656917976.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656917976.git.lorenzo@kernel.org>
References: <cover.1656917976.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76_wcid_hw() is no longer used.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 11ce4617ba11..5f7b548908ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -894,16 +894,6 @@ extern struct ieee80211_rate mt76_rates[12];
 
 #define mt76_hw(dev) (dev)->mphy.hw
 
-static inline struct ieee80211_hw *
-mt76_wcid_hw(struct mt76_dev *dev, u16 wcid)
-{
-	if (wcid <= MT76_N_WCIDS &&
-	    mt76_wcid_mask_test(dev->wcid_phy_mask, wcid))
-		return dev->phys[MT_BAND1]->hw;
-
-	return dev->phy.hw;
-}
-
 bool __mt76_poll(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 		 int timeout);
 
-- 
2.36.1

