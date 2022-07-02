Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C33564229
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Jul 2022 20:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiGBSrx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jul 2022 14:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiGBSrx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jul 2022 14:47:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738EEDFD9
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 11:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F028B60FF8
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 18:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0409EC34114;
        Sat,  2 Jul 2022 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656787671;
        bh=Q4RikUHQGb5HU9nyk2ZjuTUdNvj6gA2L5Kf01vZey8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlmipGXQcnoylRX6cyhg5W1gKA/yCdaSj7f+U5s2HdUIbX1lGX2IhMJ2f6vzEakLX
         CgN9R78ubrPJpPQ62ScdS+mEles7196jIfNofqiTIy5q7TSsjnlDHGJmTUyWq2clAh
         8xYu6EUZrhiROfhzSLTDYd7McWLnsB9exkwj1UVujOCzq9xksOxeorr0nrd9j9m2QN
         B9xnGDsreQlT7uDAdllEDc62DZd/h5F+Hew0EhVW1P0GszmrHDNwQuKEG3x5JSXKrr
         0L6KXOfeXcmZbEh2Q2em+yT/qkUop3x53lp0FX/XnNCkXT9e3nb8eOhJ6hMEXPLEPb
         XAnhr5c370+Ww==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        bo.jiao@mediatek.com
Subject: [PATCH v2 5/5] mt76: get rid of mt76_wcid_hw routine
Date:   Sat,  2 Jul 2022 20:47:24 +0200
Message-Id: <21b3c99b722e626ed5cc584ea09d17e1159ff273.1656787439.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656787439.git.lorenzo@kernel.org>
References: <cover.1656787439.git.lorenzo@kernel.org>
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

