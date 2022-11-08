Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F8B621C94
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 19:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiKHS6T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 13:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKHS6P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 13:58:15 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B702C6A686
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 10:58:13 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s12so14315551edd.5
        for <linux-wireless@vger.kernel.org>; Tue, 08 Nov 2022 10:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMgDfV1BgAP7xkSv/7TgtM9Ajy04yiwJ9uwBrlYeE4k=;
        b=Yy0lzuy8VfKf34xbHGNgaNfOobob2FhjMEdGPtN9udt83piVBILbAEWYfkUUhiLI8B
         yycT0SK88r1cZaqsIgR1oRJ0qc/6/mgpFnw41i/ktJLLlHE0Hs+89vaSkXsITQC90th1
         dQpQdmXRc9C3zqXvWwSNoCqR3TMunikeCapoTxXfvaDvOzaUv09tPcGzIYcOIGz0vKT1
         IsindWhQESFtKbrtTjFdzwp+uMb1/cKMYfN0aVhb+JjnL7sHqIPZHEEL6R70gA2xo2cX
         zPPDIUZV6lL3hw4OraZbp/vN4pY/KAui8mu5FDGJsJH+7S5dkMbsNYz0csj6gTcTTcdR
         RVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMgDfV1BgAP7xkSv/7TgtM9Ajy04yiwJ9uwBrlYeE4k=;
        b=YPcaXZJ6bSsvXK7BOfcRbdWp3lY/SEJpyWA/94nW39vVhW2iXP1B7p118NhoBccBmO
         o2waACKJBzNe5RyfJKNhC7g7H+j9FV4X6eS2HACrqHJbZGyCdwWFzYMc/iwo5bPsRxly
         zCU+vRWrv04ZiwDC/y7h2e1M3KC6hCLBIVbol8XAmLj5UMqafrrCYp7zMA0QFeX9D5Ct
         SZskDovLVtVcs62/V9kD2SwrlUrwxNTMkuS3sbJfVs9iddCF3wNHqcV69k5Sgb/cXzOu
         oy8t5Ddos59wy0drc0WqBN7AHXvRsAGJyo+L+VESIrpybLd26CI8RQ8NRV+CnwPmBjWg
         vdgQ==
X-Gm-Message-State: ACrzQf08QcswLsXFIrZj0646eKSP362u6Zdq3aEBAn/NA9C9Eu0R/aJK
        OoPXXBMxxuAR8RkRqJ5KMt9TpSpsC6I=
X-Google-Smtp-Source: AMsMyM5Jbm1a8d7vSTbq1wrRWGMzpLFoKZBfChhQcrkzYo+5DaRl4pwN661qduvHH0ip69OFkooKoA==
X-Received: by 2002:a50:ccc2:0:b0:460:4db2:5006 with SMTP id b2-20020a50ccc2000000b004604db25006mr57097968edj.369.1667933892227;
        Tue, 08 Nov 2022 10:58:12 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170907778e00b0073c8d4c9f38sm5014044ejc.177.2022.11.08.10.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:58:11 -0800 (PST)
Message-ID: <0b053ab0-0760-485f-47df-1ab1705a011c@gmail.com>
Date:   Tue, 8 Nov 2022 20:58:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 3/3] wifi: rtl8xxxu: Use u32_get_bits in *_identify_chip
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <91f59414-86f7-f0ed-a138-19f0ab63bb0b@gmail.com>
In-Reply-To: <91f59414-86f7-f0ed-a138-19f0ab63bb0b@gmail.com>
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
This patch should be applied after my older patch:
"[PATCH v2 2/3] wifi: rtl8xxxu: Split up rtl8xxxu_identify_chip"
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
