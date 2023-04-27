Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD686F0314
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 11:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbjD0JKV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 05:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243389AbjD0JJ4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 05:09:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486B830FC
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 02:09:53 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682586587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJan1WNMcFcfwXTFXtQ1gfptIcRdldF7K7is6hG3+ys=;
        b=bucvyzZH+vO5XmhmjoqMIJUkychG94N+WlEgt56tGAJ+4+bqMjnnpN+ci7fay734+LRNUW
        btgc9AbHv10abnFQ+iigj5H6ecehaw6fTuJp14MHixsTRAkYAYoML9HBj+mKl7/WIKtTUX
        iEqGMoJK0IQFcoM06GnLds4vCcKro9XEjAPPnnoZC/gZMOA86Rid/6Uiw0SPTgPycLpcVS
        7zrYNQ/H8Pp7xdaZW22zSPVWhnE66L84Zmj64Wfdk5voK0TuqeHBHhppuobp+Nv50ZjiAB
        VJd5VKtOUeI42cTss7sBmaDUpOtrvfw/7C9TyTXD44XWT8V5FbaX9i+rPWo2+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682586587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJan1WNMcFcfwXTFXtQ1gfptIcRdldF7K7is6hG3+ys=;
        b=+shwgfPj5oIae/tlA5gqljHenmXAguOlRP+r2VkXpRY/cxKw8inxu/Djw8+CUluZU1i6sp
        8wne79Y52e09G8Cw==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 14/18] wifi: rtl8xxxu: Clean up filter configuration
Date:   Thu, 27 Apr 2023 11:09:18 +0200
Message-Id: <20230427090922.165088-15-martin.kaistra@linutronix.de>
In-Reply-To: <20230427090922.165088-1-martin.kaistra@linutronix.de>
References: <20230427090922.165088-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When RCR_CHECK_BSSID_MATCH is set in AP mode, we don't receive any data
frames. Rearrange RCR bits to filter flags to match other realtek drivers
and remove RCR_CHECK_BSSID_MATCH in AP mode.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 5aecd2b9184b9..3b34e4164ac72 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6688,22 +6688,22 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 	 */
 
 	if (*total_flags & FIF_BCN_PRBRESP_PROMISC)
-		rcr &= ~RCR_CHECK_BSSID_BEACON;
+		rcr &= ~(RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH);
 	else
-		rcr |= RCR_CHECK_BSSID_BEACON;
+		rcr |= RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH;
+
+	if (priv->vif && priv->vif->type == NL80211_IFTYPE_AP)
+		rcr &= ~RCR_CHECK_BSSID_MATCH;
 
 	if (*total_flags & FIF_CONTROL)
 		rcr |= RCR_ACCEPT_CTRL_FRAME;
 	else
 		rcr &= ~RCR_ACCEPT_CTRL_FRAME;
 
-	if (*total_flags & FIF_OTHER_BSS) {
+	if (*total_flags & FIF_OTHER_BSS)
 		rcr |= RCR_ACCEPT_AP;
-		rcr &= ~RCR_CHECK_BSSID_MATCH;
-	} else {
+	else
 		rcr &= ~RCR_ACCEPT_AP;
-		rcr |= RCR_CHECK_BSSID_MATCH;
-	}
 
 	if (*total_flags & FIF_PSPOLL)
 		rcr |= RCR_ACCEPT_PM;
-- 
2.30.2

