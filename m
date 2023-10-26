Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AE47D88AA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 21:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjJZTBM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjJZTBL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 15:01:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029491AD
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 12:01:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6046BC433C8;
        Thu, 26 Oct 2023 19:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698346868;
        bh=Mi4aTHxhbyBlRBqh76YLWHt6c+16AklrlDx3sfrx72o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAkdRLjA61W3Ktzh9IbwOCsXNiZhot4KgDdzprssd/zIJaMrcpdb2onMuzuhCq4uF
         An74eusMcumPerPd84tihOdB2hun8pnuaKruMxCg33YTkq4iaYDkL1eTB3PG8iH6D1
         kZWTvGILKBuHbZ8ulWGXvT1IkT45oi0qm7IQe4u09jsG3C/H4kycCls3CHL6NZRldL
         t+lMgul1689kWR+xEM6/tH+3DMHLoNVU95VSXOt1vQteqo41ivHJg3b80PBgtLOkad
         hVy8LyazzmapXP87aZIrwkuXuniRI3ajwfISeFNrVnB/LX4W33fDIOvZcYPGu89WUc
         nIw9Zpo3lwVIQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org
Subject: [PATCH net-next 1/4] net: fill in MODULE_DESCRIPTION()s in kuba@'s modules
Date:   Thu, 26 Oct 2023 12:00:58 -0700
Message-ID: <20231026190101.1413939-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026190101.1413939-1-kuba@kernel.org>
References: <20231026190101.1413939-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Fill it in for the modules I maintain.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: linux-wireless@vger.kernel.org
---
 drivers/net/netdevsim/netdev.c              | 1 +
 drivers/net/wireless/mediatek/mt7601u/usb.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 2eac92f49631..aecaf5f44374 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -470,4 +470,5 @@ static void __exit nsim_module_exit(void)
 module_init(nsim_module_init);
 module_exit(nsim_module_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Simulated networking device for testing");
 MODULE_ALIAS_RTNL_LINK(DRV_NAME);
diff --git a/drivers/net/wireless/mediatek/mt7601u/usb.c b/drivers/net/wireless/mediatek/mt7601u/usb.c
index cc772045d526..d2ee6540ebb2 100644
--- a/drivers/net/wireless/mediatek/mt7601u/usb.c
+++ b/drivers/net/wireless/mediatek/mt7601u/usb.c
@@ -365,6 +365,7 @@ static int mt7601u_resume(struct usb_interface *usb_intf)
 
 MODULE_DEVICE_TABLE(usb, mt7601u_device_table);
 MODULE_FIRMWARE(MT7601U_FIRMWARE);
+MODULE_DESCRIPTION("MediaTek MT7601U USD Wireless LAN driver");
 MODULE_LICENSE("GPL");
 
 static struct usb_driver mt7601u_driver = {
-- 
2.41.0

