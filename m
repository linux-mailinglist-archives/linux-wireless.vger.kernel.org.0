Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138896E7700
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjDSKC1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjDSKCQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AE91FFE
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:12 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jfPVn1JsmdpXPaYpl1fgad0GrPGNrvWlTlIPqneMTY=;
        b=SDpU96PmaVGc7afoLNsSR1NpQDuNzbjJKuvD/fHIrbWuiqZB/jqkYh52d2QMd1iLabklZd
        rBkUSC39Lji1DSmvEFLTAG/snND9D4nC44d+BNVX5HgfUrkjssMxtggxpYSvCqgC3QlOgc
        gnkeQ9dGbxnPW/73SgGGGM7mQXEFZknEhrJn8WWyWQvxG87NopOvBfzYtm1nreHQLoEVTf
        bQdwWawcywfPPwUL8oZrKYUODMkWSblXqJxeoTUL7i5+OmPtzKKUz5qHyw18fWEwtMUnw5
        GyPIgl6VmYc4XLals8CMXadhjMkqFyw9pCWqACia+YHJAHpgCfb8UcrP3BUVkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jfPVn1JsmdpXPaYpl1fgad0GrPGNrvWlTlIPqneMTY=;
        b=NTJ1xR6GNtTU+6azhS+6QW+2gzHAmcC7vXNzlGixUdqHd97ytg0NLQXf2NLmNmdwPfvXZg
        Twb2Ogwaqm8RAaBw==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 04/18] wifi: rtl8xxxu: Add set_tim() callback
Date:   Wed, 19 Apr 2023 12:01:31 +0200
Message-Id: <20230419100145.159191-5-martin.kaistra@linutronix.de>
In-Reply-To: <20230419100145.159191-1-martin.kaistra@linutronix.de>
References: <20230419100145.159191-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update beacon content if TIM bitmap maintained by mac80211 is changed.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 960e3efcb0ee2..6a354165224a8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4428,6 +4428,16 @@ int rtl8xxxu_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 	return 0;
 }
 
+static int rtl8xxxu_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+			    bool set)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+
+	schedule_work(&priv->update_beacon_work);
+
+	return 0;
+}
+
 static void rtl8xxxu_sw_scan_start(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif, const u8 *mac)
 {
@@ -7126,6 +7136,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.ampdu_action = rtl8xxxu_ampdu_action,
 	.sta_statistics = rtl8xxxu_sta_statistics,
 	.get_antenna = rtl8xxxu_get_antenna,
+	.set_tim = rtl8xxxu_set_tim,
 };
 
 static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
-- 
2.30.2

