Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188A6573D0F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiGMTQq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 15:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiGMTQp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 15:16:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB920F6F
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 12:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=kVzNHTKPx/kYwgVbVryJmiX9fph9WDwMDjg4g/RtMG4=; t=1657739804; x=1658949404; 
        b=yQxJusednHOYpx1P+LvNVmeC5Lmw7O6YdADN/Gyy6d3Y/DNWnPs4gJ8telblZT3NuvvhQPFdg+J
        NKtlqchtSpGVmc9M4KVd9IwjLOKilrMTAR4ieTFtTMUc+6ef3nPclRZBh8BVeX9iTMl1TFVgFFCWN
        tzNndUhdVseGlttI9XrYkTHUXGAfqbAufa9sK7kHCLVJxtHGGHMJ2is5Sj3VveZ50+HfFCdoeQElN
        /XkQRFJJRmtbCusvAcW+ii2J6kM6ywPchMnfMhMqzB/OXet/tSUdUGKyY12uqgJORPdNo5hTu8l/C
        haHaivyU2MMXOQmAAPf287J/Baz3tHMsHpQQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBhqk-00ErDg-Ba;
        Wed, 13 Jul 2022 21:16:42 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: rsi: remove unused variable
Date:   Wed, 13 Jul 2022 21:16:37 +0200
Message-Id: <20220713211636.2b8abe6f376b.I514ed31bfbc8b5958c73685a89124cf54152bcc8@changeid>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Remove a variable here that was now set but never used.

Fixes: f276e20b182d ("wifi: mac80211: move interface config to new struct")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/rsi/rsi_91x_hal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index 40f9a31f9ca7..c61f83a7333b 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -334,7 +334,6 @@ int rsi_send_mgmt_pkt(struct rsi_common *common,
 		      struct sk_buff *skb)
 {
 	struct rsi_hw *adapter = common->priv;
-	struct ieee80211_bss_conf *bss;
 	struct ieee80211_hdr *wh;
 	struct ieee80211_tx_info *info;
 	struct skb_info *tx_params;
@@ -359,7 +358,6 @@ int rsi_send_mgmt_pkt(struct rsi_common *common,
 		return status;
 	}
 
-	bss = &info->control.vif->bss_conf;
 	wh = (struct ieee80211_hdr *)&skb->data[header_size];
 	mgmt_desc = (struct rsi_mgmt_desc *)skb->data;
 	xtend_desc = (struct rsi_xtended_desc *)&skb->data[FRAME_DESC_SZ];
-- 
2.36.1

