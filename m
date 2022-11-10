Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9076243C7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 15:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiKJOBX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 09:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJOBW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 09:01:22 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA521DD
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 06:01:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5so1200988wmo.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 06:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4Owka3zXw7FCcRApOZHVfZ/AlQV5eZ52vqP+e4YGZg=;
        b=Y7f13J7jAPfk3kJFcXiBWnn+1T2ugoLoD5/gxpEGpkmjBZoiZaaId9HpO16/9DUThO
         FPjFUnm4qJgk4gm5+ORJZYlcSoa/K9guYcnM2vGbXEHW6WIggHogIUpPT0ERmmBxfwK7
         Vvq1wWmOMwjVFiNdHVq6OS36ciknssQlpk6FsnVzyvyaOha3H1wyEOoNH5YNT7WWa6ZP
         qke/fgNe36XrkCDxbHvyVpqQmGh0WDcpKF/3pfGjrPyQxUPmfHvKwsEywtxk+F89KMO4
         1/uDXKq4twUi47RKTbPSHvzexrSrNb/5MQFbnIGpPK9mrtLYTAOoko2dqM5XWDC3u/bE
         IrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4Owka3zXw7FCcRApOZHVfZ/AlQV5eZ52vqP+e4YGZg=;
        b=kJodYxsSXy9EkZYeM6WSjtVDQFiV5li/nd0ftqqvmSBNaAYlyQFFOuP/SIwNj4jE/i
         2tUtXT09/URLyEIyShPRry/JhR6qXORc/sGGyC/GA/YuHmXVeJoctBVU0UCQ3g8g95E4
         MuYsGFI1+ZjUBEV6wEgIQOI3YWRaPMR3iH8L3IsWAlq3wuZ1WFugZ40/0wC/0BItOPvo
         /NV5yCwdhlSE0IEn7aeLT3dQko1fUS644Mv1KXC/17ZNAHwPDN7Ip8lKS7C7/mhTBp4o
         GPVnfbtWGFty7tiw/Xi6YbiW8e00GJVDssCyoc5ju5rFKA8zNcoKS7oc7lVHy6vQtVHp
         J80Q==
X-Gm-Message-State: ACrzQf1HtwgIxxDX71AVe72giSDpeskwEW5DqhvKBoM0rHfkOK7Tdf5a
        WoNmJ8pDqgdNdmnqAKNilWSeDKVnYjM=
X-Google-Smtp-Source: AMsMyM7QGjRVPyR680y/VmlrvcNdeurRkvJ9GJf31IcUr6AtlHM/7TI9iqx0qaqY2lUjL+JRzAkdtg==
X-Received: by 2002:a05:600c:491c:b0:3cf:7336:8704 with SMTP id f28-20020a05600c491c00b003cf73368704mr36279127wmp.101.1668088879713;
        Thu, 10 Nov 2022 06:01:19 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id u24-20020a7bc058000000b003b476cabf1csm5134689wmc.26.2022.11.10.06.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 06:01:19 -0800 (PST)
Message-ID: <68f94284-3728-7b75-2b7b-64fae8af6bc5@gmail.com>
Date:   Thu, 10 Nov 2022 16:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 3/3] wifi: rtl8xxxu: Use u32_get_bits in *_identify_chip
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <e7d05bd9-e096-8361-f1b4-3c8b8599a7eb@gmail.com>
In-Reply-To: <e7d05bd9-e096-8361-f1b4-3c8b8599a7eb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It simplifies the code a bit.

Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 3 +--
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c | 5 ++---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c | 5 ++---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c | 5 ++---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 5 ++---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h  | 1 -
 6 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index ef38891ddbd1..2c4f403ba68f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -335,8 +335,7 @@ static int rtl8188fu_identify_chip(struct rtl8xxxu_priv *priv)
 	priv->has_wifi = 1;
 
 	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
-	priv->chip_cut = (sys_cfg & SYS_CFG_CHIP_VERSION_MASK) >>
-		SYS_CFG_CHIP_VERSION_SHIFT;
+	priv->chip_cut = u32_get_bits(sys_cfg, SYS_CFG_CHIP_VERSION_MASK);
 	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
 		dev_info(dev, "Unsupported test chip\n");
 		ret = -ENOTSUPP;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index 6c443e4822d8..e7190cb2e5a3 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -333,8 +333,7 @@ int rtl8192cu_identify_chip(struct rtl8xxxu_priv *priv)
 	int ret = 0;
 
 	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
-	priv->chip_cut = (sys_cfg & SYS_CFG_CHIP_VERSION_MASK) >>
-		SYS_CFG_CHIP_VERSION_SHIFT;
+	priv->chip_cut = u32_get_bits(sys_cfg, SYS_CFG_CHIP_VERSION_MASK);
 	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
 		dev_info(dev, "Unsupported test chip\n");
 		ret = -ENOTSUPP;
@@ -371,7 +370,7 @@ int rtl8192cu_identify_chip(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_identify_vendor_1bit(priv, vendor);
 
 	val32 = rtl8xxxu_read32(priv, REG_GPIO_OUTSTS);
-	priv->rom_rev = (val32 & GPIO_RF_RL_ID) >> 28;
+	priv->rom_rev = u32_get_bits(val32, GPIO_RF_RL_ID);
 
 	rtl8xxxu_config_endpoints_sie(priv);
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index fc3336f18892..bdb79dc18f06 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -485,8 +485,7 @@ int rtl8192eu_identify_chip(struct rtl8xxxu_priv *priv)
 	int ret = 0;
 
 	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
-	priv->chip_cut = (sys_cfg & SYS_CFG_CHIP_VERSION_MASK) >>
-		SYS_CFG_CHIP_VERSION_SHIFT;
+	priv->chip_cut = u32_get_bits(sys_cfg, SYS_CFG_CHIP_VERSION_MASK);
 	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
 		dev_info(dev, "Unsupported test chip\n");
 		ret = -ENOTSUPP;
@@ -512,7 +511,7 @@ int rtl8192eu_identify_chip(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_identify_vendor_2bits(priv, vendor);
 
 	val32 = rtl8xxxu_read32(priv, REG_GPIO_OUTSTS);
-	priv->rom_rev = (val32 & GPIO_RF_RL_ID) >> 28;
+	priv->rom_rev = u32_get_bits(val32, GPIO_RF_RL_ID);
 
 	rtl8xxxu_config_endpoints_sie(priv);
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index c8ab71ed4ff4..707ac48ecc83 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -136,8 +136,7 @@ static int rtl8723au_identify_chip(struct rtl8xxxu_priv *priv)
 	int ret = 0;
 
 	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
-	priv->chip_cut = (sys_cfg & SYS_CFG_CHIP_VERSION_MASK) >>
-		SYS_CFG_CHIP_VERSION_SHIFT;
+	priv->chip_cut = u32_get_bits(sys_cfg, SYS_CFG_CHIP_VERSION_MASK);
 	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
 		dev_info(dev, "Unsupported test chip\n");
 		ret = -ENOTSUPP;
@@ -165,7 +164,7 @@ static int rtl8723au_identify_chip(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_identify_vendor_1bit(priv, vendor);
 
 	val32 = rtl8xxxu_read32(priv, REG_GPIO_OUTSTS);
-	priv->rom_rev = (val32 & GPIO_RF_RL_ID) >> 28;
+	priv->rom_rev = u32_get_bits(val32, GPIO_RF_RL_ID);
 
 	rtl8xxxu_config_endpoints_sie(priv);
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index ece82e613bf0..a0ec895b61a4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -311,8 +311,7 @@ static int rtl8723bu_identify_chip(struct rtl8xxxu_priv *priv)
 	int ret = 0;
 
 	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
-	priv->chip_cut = (sys_cfg & SYS_CFG_CHIP_VERSION_MASK) >>
-		SYS_CFG_CHIP_VERSION_SHIFT;
+	priv->chip_cut = u32_get_bits(sys_cfg, SYS_CFG_CHIP_VERSION_MASK);
 	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
 		dev_info(dev, "Unsupported test chip\n");
 		ret = -ENOTSUPP;
@@ -338,7 +337,7 @@ static int rtl8723bu_identify_chip(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_identify_vendor_2bits(priv, vendor);
 
 	val32 = rtl8xxxu_read32(priv, REG_GPIO_OUTSTS);
-	priv->rom_rev = (val32 & GPIO_RF_RL_ID) >> 28;
+	priv->rom_rev = u32_get_bits(val32, GPIO_RF_RL_ID);
 
 	rtl8xxxu_config_endpoints_sie(priv);
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index 5d4cac4f4c06..3e79efdfb4c2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -315,7 +315,6 @@
 #define  SYS_CFG_SPS_SEL		BIT(24) /*  1:LDO regulator mode;
 						    0:Switching regulator mode*/
 #define  SYS_CFG_CHIP_VERSION_MASK	0xf000	/* Bit 12 - 15 */
-#define  SYS_CFG_CHIP_VERSION_SHIFT	12
 
 #define REG_GPIO_OUTSTS			0x00f4	/*  For RTL8723 only. */
 #define  GPIO_EFS_HCI_SEL		(BIT(0) | BIT(1))
-- 
2.38.0
