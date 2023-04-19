Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F456E7713
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjDSKCm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjDSKCT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A9AB759
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:17 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+rS0TSKT4q674y2NlyHuepF+qK+0VF3K9UGMkt4m6I=;
        b=UeBr1FcF5Y9p+yzjGSUxjQQdbe7uexa5SUZMaKoyvYSkP1joL7YMsFr5EJlcqZrbF784NY
        Rc0g63Ic4ruNeW7UaYyW6H5wgMRP8gGuB1LJN3qljp/n0ZSp7YSvMPxE76d0/OLKP8mALw
        vtU9W1qgAfTiU4K4LgCtQD4tHNfdtlNpCHiyEgvm3rw/Xd960SKp7Z+k/Ivk4ItTm6/8Px
        bH10W9QUrKUWvmkxGNsaoDttGCep2tPg2fdUmMmKuPyfi2RvJzEopVYMv9qufvlkWzLXvn
        LG/Bin5n6GsIMkXCfIUcgHMqff0AWQcEY66OrWrtHl3LWKhRiadhVnd6Jeolkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+rS0TSKT4q674y2NlyHuepF+qK+0VF3K9UGMkt4m6I=;
        b=aBg3jkaZVu9ekmilvAiDsIwwLyt/KtN1EtTRCvQFGS+3kD46UpQa9VbTbfEg4BuTXU1Agc
        XbOFhuUJskdNlRDQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 14/18] wifi: rtl8xxxu: Clean up filter configuration
Date:   Wed, 19 Apr 2023 12:01:41 +0200
Message-Id: <20230419100145.159191-15-martin.kaistra@linutronix.de>
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

When RCR_CHECK_BSSID_MATCH is set in AP mode, we don't receive any data
frames. Rearrange RCR bits to filter flags to match other realtek drivers
and remove RCR_CHECK_BSSID_MATCH in AP mode.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index cff465c7cda30..f5b6ff3351e5a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6619,22 +6619,22 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
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

