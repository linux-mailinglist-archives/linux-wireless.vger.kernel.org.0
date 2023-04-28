Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E1C6F104E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 04:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbjD1C0g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 22:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjD1C0f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 22:26:35 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Apr 2023 19:26:33 PDT
Received: from mail.kevlo.org (ns.kevlo.org [220.134.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29012690
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 19:26:33 -0700 (PDT)
Received: from localhost (ns.kevlo.org [local])
        by ns.kevlo.org (OpenSMTPD) with ESMTPA id 2e0bd63c;
        Fri, 28 Apr 2023 10:19:50 +0800 (CST)
Date:   Fri, 28 Apr 2023 10:19:50 +0800
From:   Kevin Lo <kevlo@kevlo.org>
To:     linux-wireless@vger.kernel.org
Cc:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH] wifi: rtl8xxxu: 8188f: no need to initialize interrupts
Message-ID: <ZEstRr5LwGqphsvi@ns.kevlo.org>
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

Signed-off-by: Kevin Lo <kevlo@kevlo>
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
