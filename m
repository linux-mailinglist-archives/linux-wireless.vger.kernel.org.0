Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102AC50BADC
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Apr 2022 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449008AbiDVO6j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Apr 2022 10:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449031AbiDVO6c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Apr 2022 10:58:32 -0400
X-Greylist: delayed 280 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 07:55:38 PDT
Received: from mail.kevlo.org (mail.kevlo.org [220.134.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0241B5AA61
        for <linux-wireless@vger.kernel.org>; Fri, 22 Apr 2022 07:55:38 -0700 (PDT)
Received: from localhost (ns.kevlo.org [local])
        by ns.kevlo.org (OpenSMTPD) with ESMTPA id 62f7c6f5;
        Fri, 22 Apr 2022 22:50:54 +0800 (CST)
Date:   Fri, 22 Apr 2022 22:50:54 +0800
From:   Kevin Lo <kevlo@kevlo.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] rtw88: use the correct bit in the REG_HCI_OPT_CTRL register
Message-ID: <YmLAzuyPr0P4Y6BP@ns.kevlo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Write the BIT_USB_SUS_DIS bit rather than BIT_BT_DIG_CLK_EN to the
REG_HCI_OPT_CTRL register for fixing failure to PCIe power on.

Signed-off-by: Kevin Lo <kevlo@kevlo.org>
---
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index d1678aed9d9c..caf2603da2d6 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -75,7 +75,7 @@ static int rtw_mac_pre_system_cfg(struct rtw_dev *rtwdev)
 
 	switch (rtw_hci_type(rtwdev)) {
 	case RTW_HCI_TYPE_PCIE:
-		rtw_write32_set(rtwdev, REG_HCI_OPT_CTRL, BIT_BT_DIG_CLK_EN);
+		rtw_write32_set(rtwdev, REG_HCI_OPT_CTRL, BIT_USB_SUS_DIS);
 		break;
 	case RTW_HCI_TYPE_USB:
 		break;
