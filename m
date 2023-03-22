Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962BB6C524B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjCVRUc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCVRUU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:20:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9FD637F7
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:19:56 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679505553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fph4T2xaOX0oNuJ6cdp1BCvyr+8ZBy6nRmcuYdvAbpc=;
        b=D+JWmFHCgXiexRAiCnUaAaropQTpcWkXau53sxQxHjC7/6eK62h2EgO31BJXwg4OAGch/B
        cMVGafjUx7KU/8o9CzzjuTWzV9lfXcveWATtLmuGoiQhJgVoUpfnaFiWLl1JiMSe/b8UGA
        BB4NwRJh6tW33Q1FFqzcoAMYuLzeSiDqaueZwy0OliJ+vpbz8EpWU0kFs/BlFV8QpEsN2f
        OMErpIjiISYRLwHVdRs/bcC0hKTKQ8Vosxsi0Eb9iJrwA4aTcu46AuCV+SnS4Fz4AkXYtn
        QBD38H9EtDw3GWPksBihBvIeHkGMR2XykzpHTaq+WW4XUrCztNDVq+Cku7BLkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679505553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fph4T2xaOX0oNuJ6cdp1BCvyr+8ZBy6nRmcuYdvAbpc=;
        b=xsVze5ktYcfc7Jbxjfox1F8hvxPlzYlNhHTYbp6lxWuJZBT6tZC+hUFXrv7inQYa2UjjPa
        mGEcxlpgoKD2ykBg==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 13/14] wifi: rtl8xxxu: Clean up filter configuration
Date:   Wed, 22 Mar 2023 18:19:04 +0100
Message-Id: <20230322171905.492855-14-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-1-martin.kaistra@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In AP mode, RCR_CHECK_BSSID_MATCH should not be set. Rearrange RCR bits
to filter flags to match other realtek drivers and don't set
RCR_CHECK_BSSID_BEACON and RCR_CHECK_BSSID_MATCH in AP mode.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 82fbe778fc5ec..b6f811ad01333 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6597,23 +6597,24 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 	 * FIF_PLCPFAIL not supported?
 	 */
 
-	if (*total_flags & FIF_BCN_PRBRESP_PROMISC)
-		rcr &= ~RCR_CHECK_BSSID_BEACON;
-	else
-		rcr |= RCR_CHECK_BSSID_BEACON;
+	if (priv->vif->type != NL80211_IFTYPE_AP) {
+		if (*total_flags & FIF_BCN_PRBRESP_PROMISC)
+			rcr &= ~(RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH);
+		else
+			rcr |= RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH;
+	} else {
+		rcr &= ~RCR_CHECK_BSSID_MATCH;
+	}
 
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

