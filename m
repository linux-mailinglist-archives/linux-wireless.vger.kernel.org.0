Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7792562579
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jun 2022 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbiF3Vlz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jun 2022 17:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbiF3Vlx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jun 2022 17:41:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF4F53D1C
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 14:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9C6A623C3
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 21:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7959C34115;
        Thu, 30 Jun 2022 21:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656625312;
        bh=Q4RikUHQGb5HU9nyk2ZjuTUdNvj6gA2L5Kf01vZey8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pb/2TG8S7609MSFMF+HDGJ6BBkGVsGhhxQ3UFbQu5+iG9x+4SU8j/if9PkHYokmjA
         pdPQyrnb0pcl7s7G98O3IgaxX3Mv9Zb7OfyMYM5pwaXLxLKBVN7v5tEAzHZOWHT+kI
         vwvARcOPq2rcEhwDUoujIhfl/F5uROpptvnTsiBmyH3M1dZF4EaAjJ0MaujbZbgWWV
         v4Qq894a8BfgA5B1oHYCbHulsR3BKCiHzCMUsPXtALwrVJ1TPGfoxgls0Th4PKuNvx
         aB5K73U/eWfqrCBifjS1hmqCYd0FzoAS5A7EoC3Cc6KBaDzfHrSDAz2MEO5+Xb6Rh8
         omNm+NkHMlcJg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        sean.wang@mediatek.com
Subject: [PATCH 5/5] mt76: get rid of mt76_wcid_hw routine
Date:   Thu, 30 Jun 2022 23:41:16 +0200
Message-Id: <363aeaceebe4499d08e1248cdecdda16bb1e1fdc.1656624320.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656624320.git.lorenzo@kernel.org>
References: <cover.1656624320.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index c69ee9532a8c..279e0f8e07e4 100644
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

