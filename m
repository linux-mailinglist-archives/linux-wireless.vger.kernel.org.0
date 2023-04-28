Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EFB6F105C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 04:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344379AbjD1CeW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 22:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344285AbjD1CeW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 22:34:22 -0400
Received: from mail.kevlo.org (ns.kevlo.org [220.134.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E76268D
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 19:34:20 -0700 (PDT)
Received: from localhost (ns.kevlo.org [local])
        by ns.kevlo.org (OpenSMTPD) with ESMTPA id 799a2ac0;
        Fri, 28 Apr 2023 10:34:17 +0800 (CST)
Date:   Fri, 28 Apr 2023 10:34:17 +0800
From:   Kevin Lo <kevlo@kevlo.org>
To:     linux-wireless@vger.kernel.org
Cc:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v2] wifi: rtl8xxxu: 8188f: no need to initialize interrupts
Message-ID: <ZEswqUHBXPHC/znL@ns.kevlo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There's no need to initialize interrupts for RTL8188FTV like the vendor driver.

Signed-off-by: Kevin Lo <kevlo@kevlo.org>
---
v2:
 - Fix my email address.
---
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 620a5cc2bfdd..7f620dc47ee0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4023,9 +4023,6 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	if (priv->rtl_chip == RTL8192E) {
 		rtl8xxxu_write32(priv, REG_HIMR0, 0x00);
 		rtl8xxxu_write32(priv, REG_HIMR1, 0x00);
-	} else if (priv->rtl_chip == RTL8188F) {
-		rtl8xxxu_write32(priv, REG_HISR0, 0xffffffff);
-		rtl8xxxu_write32(priv, REG_HISR1, 0xffffffff);
 	} else if (priv->rtl_chip == RTL8188E) {
 		rtl8xxxu_write32(priv, REG_HISR0, 0xffffffff);
 		val32 = IMR0_PSTIMEOUT | IMR0_TBDER | IMR0_CPWM | IMR0_CPWM2;
@@ -4035,7 +4032,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		val8 = rtl8xxxu_read8(priv, REG_USB_SPECIAL_OPTION);
 		val8 |= USB_SPEC_INT_BULK_SELECT;
 		rtl8xxxu_write8(priv, REG_USB_SPECIAL_OPTION, val8);
-	} else {
+	} else if (priv->rtl_chip != RTL8188F) {
 		/*
 		 * Enable all interrupts - not obvious USB needs to do this
 		 */
