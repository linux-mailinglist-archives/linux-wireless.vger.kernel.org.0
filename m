Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A534F61DF32
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Nov 2022 23:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKEWy3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Nov 2022 18:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEWy2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Nov 2022 18:54:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB538BCBF
        for <linux-wireless@vger.kernel.org>; Sat,  5 Nov 2022 15:54:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a13so12488589edj.0
        for <linux-wireless@vger.kernel.org>; Sat, 05 Nov 2022 15:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPonL1kzn6t52tZSdbeInrDs/7NEivmcdWyTUEnqOQQ=;
        b=NZOn8hd7b3duA9IyXci8eeg9QoYWCHBZAag11o0FheE3gBgTEa5FkBsaG9sMyLguqg
         Xh4cvXmpNlHZJhzB1Wl6Fmxl7Nd0vQyOkAGXQE8V/FAcKOcolZ3xWMGNLKqNiomsT+wO
         Z3zhZEgRMd9xLDTCTRV4zwOT7YnQZxI2UBSzK3cBgh6SwHf1con1fDj472zjqlzJI281
         aV/nqRwvIM5AVWsVIHhA12ExZrBMCqmponzfwCd0qH+fSMyJSARLD6yd54U6kx7Jr3xL
         xigVOyhI8Jv0SnvqTAjrXhEQflbrbfm8NZeKr8QbygWJxvJ/kKFXZrN+6njVx5Y1lAoH
         q/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPonL1kzn6t52tZSdbeInrDs/7NEivmcdWyTUEnqOQQ=;
        b=XoKnc8BH3OdAjvsUwrST7yDd+SRLJsxjjPOi6pnJ2HQ00L/PHWBM6LzRZMPEGMesCe
         0rLDUDQlYEV4QpFhuMlzR6Uauwt0ry1G1mvQL1iLa038ha6LfMRgwz5e/ohjEQ/a/e/K
         8BO15PABc2DMVOqa1wvl/pxVKY+gJothPKJTlaqLE2O1jZSNdhO2MxspK9YbFn2Oacmr
         Os15g2ALlMaJKzRGN0g+f8nv8/7T2TNdG7EOGQ/Q1S+UiJqtc3WxrM4GyjPDsengQ/Lo
         s/S2Fbqn2ZyAOL/CGtchkeLQH+/bfN9WqSVeOqky4yfSc1WniBppD7kaih6tLpI5tPjl
         H9Ng==
X-Gm-Message-State: ACrzQf3QUI3vHxUQSclhndCwWr7GYkSNu82WoNJb1nk5Byx/fDBKuhOe
        OYHl6lwDGkv6gqpC+cRDsfqy1LhYMZ0=
X-Google-Smtp-Source: AMsMyM6Tu/y98dpTPl5cPESOHA03KTYM+9YTtZ6+z/cUrGPAE4kCed8IVp9+XtEU0c/5a2mJRmoYLg==
X-Received: by 2002:a50:871a:0:b0:461:52a9:1da6 with SMTP id i26-20020a50871a000000b0046152a91da6mr41879410edb.94.1667688864171;
        Sat, 05 Nov 2022 15:54:24 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id s7-20020a056402014700b00461a98a2128sm1761376edu.26.2022.11.05.15.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 15:54:23 -0700 (PDT)
Message-ID: <b268b5cf-071c-6292-0d90-0573e4fb2228@gmail.com>
Date:   Sun, 6 Nov 2022 00:54:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 2/3] wifi: rtl8xxxu: Split up rtl8xxxu_identify_chip
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com>
In-Reply-To: <bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com>
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

Move the reusable parts into separate functions and create one
identify_chip function for each chip type.

This is preparation for supporting the RTL8710BU chip, which would
need too many ugly changes to this function. Another reason to do this
is to get rid of the long and scary if..else if..else block in the
middle of the function.

Everything should still work the same as before.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Make rtl8192cu_identify_chip and rtl8192eu_identify_chip static.
   Reported-by: kernel test robot <lkp@intel.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |   5 +
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  32 +++
 .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         |  60 +++++
 .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         |  49 +++++
 .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         |  51 +++++
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |  49 +++++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 207 +++++-------------
 7 files changed, 297 insertions(+), 156 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 9f8b23160ed0..136992f0200c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1470,6 +1470,7 @@ struct rtl8xxxu_tx_urb {
 };
 
 struct rtl8xxxu_fileops {
+	int (*identify_chip) (struct rtl8xxxu_priv *priv);
 	int (*parse_efuse) (struct rtl8xxxu_priv *priv);
 	int (*load_firmware) (struct rtl8xxxu_priv *priv);
 	int (*power_on) (struct rtl8xxxu_priv *priv);
@@ -1562,6 +1563,10 @@ int rtl8xxxu_init_phy_regs(struct rtl8xxxu_priv *priv,
 int rtl8xxxu_load_firmware(struct rtl8xxxu_priv *priv, char *fw_name);
 void rtl8xxxu_firmware_self_reset(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_power_off(struct rtl8xxxu_priv *priv);
+void rtl8xxxu_identify_vendor_1bit(struct rtl8xxxu_priv *priv, u32 vendor);
+void rtl8xxxu_identify_vendor_2bits(struct rtl8xxxu_priv *priv, u32 vendor);
+void rtl8xxxu_config_endpoints_sie(struct rtl8xxxu_priv *priv);
+int rtl8xxxu_config_endpoints_no_sie(struct rtl8xxxu_priv *priv);
 int rtl8xxxu_read_efuse8(struct rtl8xxxu_priv *priv, u16 offset, u8 *data);
 void rtl8xxxu_reset_8051(struct rtl8xxxu_priv *priv);
 int rtl8xxxu_auto_llt_table(struct rtl8xxxu_priv *priv);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 5eadeb02a762..4d044a8baa30 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -321,6 +321,37 @@ static const struct rtl8xxxu_rfregval rtl8188fu_cut_b_radioa_init_table[] = {
 	{0xff, 0xffffffff}
 };
 
+static int rtl8188fu_identify_chip(struct rtl8xxxu_priv *priv)
+{
+	struct device *dev = &priv->udev->dev;
+	u32 sys_cfg, vendor;
+	int ret = 0;
+
+	sprintf(priv->chip_name, "8188FU");
+	priv->rtl_chip = RTL8188F;
+	priv->rf_paths = 1;
+	priv->rx_paths = 1;
+	priv->tx_paths = 1;
+	priv->has_wifi = 1;
+
+	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
+	priv->chip_cut = (sys_cfg & SYS_CFG_CHIP_VERSION_MASK) >>
+		SYS_CFG_CHIP_VERSION_SHIFT;
+	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
+		dev_info(dev, "Unsupported test chip\n");
+		ret = -ENOTSUPP;
+		goto out;
+	}
+
+	vendor = sys_cfg & SYS_CFG_VENDOR_EXT_MASK;
+	rtl8xxxu_identify_vendor_2bits(priv, vendor);
+
+	ret = rtl8xxxu_config_endpoints_no_sie(priv);
+
+out:
+	return ret;
+}
+
 static void rtl8xxxu_8188f_channel_to_group(int channel, int *group, int *cck_group)
 {
 	if (channel < 3)
@@ -1690,6 +1721,7 @@ static s8 rtl8188f_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
 }
 
 struct rtl8xxxu_fileops rtl8188fu_fops = {
+	.identify_chip = rtl8188fu_identify_chip,
 	.parse_efuse = rtl8188fu_parse_efuse,
 	.load_firmware = rtl8188fu_load_firmware,
 	.power_on = rtl8188fu_power_on,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index 9dfeeaa74927..815c1e278e4e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -326,6 +326,65 @@ static const struct rtl8xxxu_rfregval rtl8188ru_radioa_1t_highpa_table[] = {
 	{0xff, 0xffffffff}
 };
 
+static int rtl8192cu_identify_chip(struct rtl8xxxu_priv *priv)
+{
+	struct device *dev = &priv->udev->dev;
+	u32 val32, bonding, sys_cfg, vendor;
+	int ret = 0;
+
+	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
+	priv->chip_cut = (sys_cfg & SYS_CFG_CHIP_VERSION_MASK) >>
+		SYS_CFG_CHIP_VERSION_SHIFT;
+	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
+		dev_info(dev, "Unsupported test chip\n");
+		ret = -ENOTSUPP;
+		goto out;
+	}
+
+	if (sys_cfg & SYS_CFG_TYPE_ID) {
+		bonding = rtl8xxxu_read32(priv, REG_HPON_FSM);
+		bonding &= HPON_FSM_BONDING_MASK;
+		if (bonding == HPON_FSM_BONDING_1T2R) {
+			sprintf(priv->chip_name, "8191CU");
+			priv->tx_paths = 1;
+			priv->usb_interrupts = 1;
+			priv->rtl_chip = RTL8191C;
+		} else {
+			sprintf(priv->chip_name, "8192CU");
+			priv->tx_paths = 2;
+			priv->usb_interrupts = 0;
+			priv->rtl_chip = RTL8192C;
+		}
+		priv->rf_paths = 2;
+		priv->rx_paths = 2;
+	} else {
+		sprintf(priv->chip_name, "8188CU");
+		priv->rf_paths = 1;
+		priv->rx_paths = 1;
+		priv->tx_paths = 1;
+		priv->rtl_chip = RTL8188C;
+		priv->usb_interrupts = 0;
+	}
+	priv->has_wifi = 1;
+
+	vendor = sys_cfg & SYS_CFG_VENDOR_ID;
+	rtl8xxxu_identify_vendor_1bit(priv, vendor);
+
+	val32 = rtl8xxxu_read32(priv, REG_GPIO_OUTSTS);
+	priv->rom_rev = (val32 & GPIO_RF_RL_ID) >> 28;
+
+	rtl8xxxu_config_endpoints_sie(priv);
+
+	/*
+	 * Fallback for devices that do not provide REG_NORMAL_SIE_EP_TX
+	 */
+	if (!priv->ep_tx_count)
+		ret = rtl8xxxu_config_endpoints_no_sie(priv);
+
+out:
+	return ret;
+}
+
 static int rtl8192cu_load_firmware(struct rtl8xxxu_priv *priv)
 {
 	char *fw_name;
@@ -541,6 +600,7 @@ static int rtl8192cu_power_on(struct rtl8xxxu_priv *priv)
 }
 
 struct rtl8xxxu_fileops rtl8192cu_fops = {
+	.identify_chip = rtl8192cu_identify_chip,
 	.parse_efuse = rtl8192cu_parse_efuse,
 	.load_firmware = rtl8192cu_load_firmware,
 	.power_on = rtl8192cu_power_on,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 973a02afc82b..7a182073832b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -478,6 +478,54 @@ static const struct rtl8xxxu_rfregval rtl8192eu_radiob_init_table[] = {
 	{0xff, 0xffffffff}
 };
 
+static int rtl8192eu_identify_chip(struct rtl8xxxu_priv *priv)
+{
+	struct device *dev = &priv->udev->dev;
+	u32 val32, bonding, sys_cfg, vendor;
+	int ret = 0;
+
+	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
+	priv->chip_cut = (sys_cfg & SYS_CFG_CHIP_VERSION_MASK) >>
+		SYS_CFG_CHIP_VERSION_SHIFT;
+	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
+		dev_info(dev, "Unsupported test chip\n");
+		ret = -ENOTSUPP;
+		goto out;
+	}
+
+	bonding = rtl8xxxu_read32(priv, REG_HPON_FSM);
+	bonding &= HPON_FSM_BONDING_MASK;
+	if (bonding == HPON_FSM_BONDING_1T2R) {
+		sprintf(priv->chip_name, "8191EU");
+		priv->tx_paths = 1;
+		priv->rtl_chip = RTL8191E;
+	} else {
+		sprintf(priv->chip_name, "8192EU");
+		priv->tx_paths = 2;
+		priv->rtl_chip = RTL8192E;
+	}
+	priv->rf_paths = 2;
+	priv->rx_paths = 2;
+	priv->has_wifi = 1;
+
+	vendor = sys_cfg & SYS_CFG_VENDOR_EXT_MASK;
+	rtl8xxxu_identify_vendor_2bits(priv, vendor);
+
+	val32 = rtl8xxxu_read32(priv, REG_GPIO_OUTSTS);
+	priv->rom_rev = (val32 & GPIO_RF_RL_ID) >> 28;
+
+	rtl8xxxu_config_endpoints_sie(priv);
+
+	/*
+	 * Fallback for devices that do not provide REG_NORMAL_SIE_EP_TX
+	 */
+	if (!priv->ep_tx_count)
+		ret = rtl8xxxu_config_endpoints_no_sie(priv);
+
+out:
+	return ret;
+}
+
 static void
 rtl8192e_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 {
@@ -1693,6 +1741,7 @@ static s8 rtl8192e_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
 }
 
 struct rtl8xxxu_fileops rtl8192eu_fops = {
+	.identify_chip = rtl8192eu_identify_chip,
 	.parse_efuse = rtl8192eu_parse_efuse,
 	.load_firmware = rtl8192eu_load_firmware,
 	.power_on = rtl8192eu_power_on,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index 8d8eb16a0970..33a1114a5853 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -129,6 +129,56 @@ static const struct rtl8xxxu_rfregval rtl8723au_radioa_1t_init_table[] = {
 	{0xff, 0xffffffff}
 };
 
+static int rtl8723au_identify_chip(struct rtl8xxxu_priv *priv)
+{
+	struct device *dev = &priv->udev->dev;
+	u32 val32, sys_cfg, vendor;
+	int ret = 0;
+
+	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
+	priv->chip_cut = (sys_cfg & SYS_CFG_CHIP_VERSION_MASK) >>
+		SYS_CFG_CHIP_VERSION_SHIFT;
+	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
+		dev_info(dev, "Unsupported test chip\n");
+		ret = -ENOTSUPP;
+		goto out;
+	}
+
+	sprintf(priv->chip_name, "8723AU");
+	priv->usb_interrupts = 1;
+	priv->rtl_chip = RTL8723A;
+
+	priv->rf_paths = 1;
+	priv->rx_paths = 1;
+	priv->tx_paths = 1;
+
+	val32 = rtl8xxxu_read32(priv, REG_MULTI_FUNC_CTRL);
+	if (val32 & MULTI_WIFI_FUNC_EN)
+		priv->has_wifi = 1;
+	if (val32 & MULTI_BT_FUNC_EN)
+		priv->has_bluetooth = 1;
+	if (val32 & MULTI_GPS_FUNC_EN)
+		priv->has_gps = 1;
+	priv->is_multi_func = 1;
+
+	vendor = sys_cfg & SYS_CFG_VENDOR_ID;
+	rtl8xxxu_identify_vendor_1bit(priv, vendor);
+
+	val32 = rtl8xxxu_read32(priv, REG_GPIO_OUTSTS);
+	priv->rom_rev = (val32 & GPIO_RF_RL_ID) >> 28;
+
+	rtl8xxxu_config_endpoints_sie(priv);
+
+	/*
+	 * Fallback for devices that do not provide REG_NORMAL_SIE_EP_TX
+	 */
+	if (!priv->ep_tx_count)
+		ret = rtl8xxxu_config_endpoints_no_sie(priv);
+
+out:
+	return ret;
+}
+
 static int rtl8723au_parse_efuse(struct rtl8xxxu_priv *priv)
 {
 	struct rtl8723au_efuse *efuse = &priv->efuse_wifi.efuse8723;
@@ -409,6 +459,7 @@ s8 rtl8723a_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
 }
 
 struct rtl8xxxu_fileops rtl8723au_fops = {
+	.identify_chip = rtl8723au_identify_chip,
 	.parse_efuse = rtl8723au_parse_efuse,
 	.load_firmware = rtl8723au_load_firmware,
 	.power_on = rtl8723au_power_on,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 27df8805cb18..558572bdd2c8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -304,6 +304,54 @@ static const struct rtl8xxxu_rfregval rtl8723bu_radioa_1t_init_table[] = {
 	{0xff, 0xffffffff}
 };
 
+static int rtl8723bu_identify_chip(struct rtl8xxxu_priv *priv)
+{
+	struct device *dev = &priv->udev->dev;
+	u32 val32, sys_cfg, vendor;
+	int ret = 0;
+
+	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
+	priv->chip_cut = (sys_cfg & SYS_CFG_CHIP_VERSION_MASK) >>
+		SYS_CFG_CHIP_VERSION_SHIFT;
+	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
+		dev_info(dev, "Unsupported test chip\n");
+		ret = -ENOTSUPP;
+		goto out;
+	}
+
+	sprintf(priv->chip_name, "8723BU");
+	priv->rtl_chip = RTL8723B;
+	priv->rf_paths = 1;
+	priv->rx_paths = 1;
+	priv->tx_paths = 1;
+
+	val32 = rtl8xxxu_read32(priv, REG_MULTI_FUNC_CTRL);
+	if (val32 & MULTI_WIFI_FUNC_EN)
+		priv->has_wifi = 1;
+	if (val32 & MULTI_BT_FUNC_EN)
+		priv->has_bluetooth = 1;
+	if (val32 & MULTI_GPS_FUNC_EN)
+		priv->has_gps = 1;
+	priv->is_multi_func = 1;
+
+	vendor = sys_cfg & SYS_CFG_VENDOR_EXT_MASK;
+	rtl8xxxu_identify_vendor_2bits(priv, vendor);
+
+	val32 = rtl8xxxu_read32(priv, REG_GPIO_OUTSTS);
+	priv->rom_rev = (val32 & GPIO_RF_RL_ID) >> 28;
+
+	rtl8xxxu_config_endpoints_sie(priv);
+
+	/*
+	 * Fallback for devices that do not provide REG_NORMAL_SIE_EP_TX
+	 */
+	if (!priv->ep_tx_count)
+		ret = rtl8xxxu_config_endpoints_no_sie(priv);
+
+out:
+	return ret;
+}
+
 static void rtl8723bu_write_btreg(struct rtl8xxxu_priv *priv, u8 reg, u8 data)
 {
 	struct h2c_cmd h2c;
@@ -1668,6 +1716,7 @@ static s8 rtl8723b_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
 }
 
 struct rtl8xxxu_fileops rtl8723bu_fops = {
+	.identify_chip = rtl8723bu_identify_chip,
 	.parse_efuse = rtl8723bu_parse_efuse,
 	.load_firmware = rtl8723bu_load_firmware,
 	.power_on = rtl8723bu_power_on,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 282ad8a9b73d..839e0546f5ec 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1589,148 +1589,40 @@ static void rtl8xxxu_print_chipinfo(struct rtl8xxxu_priv *priv)
 	dev_info(dev, "RTL%s MAC: %pM\n", priv->chip_name, priv->mac_addr);
 }
 
-static int rtl8xxxu_identify_chip(struct rtl8xxxu_priv *priv)
+void rtl8xxxu_identify_vendor_1bit(struct rtl8xxxu_priv *priv, u32 vendor)
 {
-	const struct usb_device_descriptor *descriptor = &priv->udev->descriptor;
-	struct device *dev = &priv->udev->dev;
-	struct ieee80211_hw *hw = priv->hw;
-	u32 val32, bonding, sys_cfg;
-	u16 val16;
-
-	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
-	priv->chip_cut = (sys_cfg & SYS_CFG_CHIP_VERSION_MASK) >>
-		SYS_CFG_CHIP_VERSION_SHIFT;
-	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
-		dev_info(dev, "Unsupported test chip\n");
-		return -ENOTSUPP;
-	}
-
-	if (descriptor->idVendor == USB_VENDOR_ID_REALTEK &&
-	    descriptor->idProduct == 0xf179) {
-		sprintf(priv->chip_name, "8188FU");
-		priv->rtl_chip = RTL8188F;
-		priv->rf_paths = 1;
-		priv->rx_paths = 1;
-		priv->tx_paths = 1;
-		priv->has_wifi = 1;
-		goto skip_complicated_chip_detection;
-	}
-
-	if (sys_cfg & SYS_CFG_BT_FUNC) {
-		if (priv->chip_cut >= 3) {
-			sprintf(priv->chip_name, "8723BU");
-			priv->rtl_chip = RTL8723B;
-		} else {
-			sprintf(priv->chip_name, "8723AU");
-			priv->usb_interrupts = 1;
-			priv->rtl_chip = RTL8723A;
-		}
-
-		priv->rf_paths = 1;
-		priv->rx_paths = 1;
-		priv->tx_paths = 1;
-
-		val32 = rtl8xxxu_read32(priv, REG_MULTI_FUNC_CTRL);
-		if (val32 & MULTI_WIFI_FUNC_EN)
-			priv->has_wifi = 1;
-		if (val32 & MULTI_BT_FUNC_EN)
-			priv->has_bluetooth = 1;
-		if (val32 & MULTI_GPS_FUNC_EN)
-			priv->has_gps = 1;
-		priv->is_multi_func = 1;
-	} else if (sys_cfg & SYS_CFG_TYPE_ID) {
-		bonding = rtl8xxxu_read32(priv, REG_HPON_FSM);
-		bonding &= HPON_FSM_BONDING_MASK;
-		if (priv->fops->tx_desc_size ==
-		    sizeof(struct rtl8xxxu_txdesc40)) {
-			if (bonding == HPON_FSM_BONDING_1T2R) {
-				sprintf(priv->chip_name, "8191EU");
-				priv->rf_paths = 2;
-				priv->rx_paths = 2;
-				priv->tx_paths = 1;
-				priv->rtl_chip = RTL8191E;
-			} else {
-				sprintf(priv->chip_name, "8192EU");
-				priv->rf_paths = 2;
-				priv->rx_paths = 2;
-				priv->tx_paths = 2;
-				priv->rtl_chip = RTL8192E;
-			}
-		} else if (bonding == HPON_FSM_BONDING_1T2R) {
-			sprintf(priv->chip_name, "8191CU");
-			priv->rf_paths = 2;
-			priv->rx_paths = 2;
-			priv->tx_paths = 1;
-			priv->usb_interrupts = 1;
-			priv->rtl_chip = RTL8191C;
-		} else {
-			sprintf(priv->chip_name, "8192CU");
-			priv->rf_paths = 2;
-			priv->rx_paths = 2;
-			priv->tx_paths = 2;
-			priv->usb_interrupts = 0;
-			priv->rtl_chip = RTL8192C;
-		}
-		priv->has_wifi = 1;
+	if (vendor) {
+		sprintf(priv->chip_vendor, "UMC");
+		priv->vendor_umc = 1;
 	} else {
-		sprintf(priv->chip_name, "8188CU");
-		priv->rf_paths = 1;
-		priv->rx_paths = 1;
-		priv->tx_paths = 1;
-		priv->rtl_chip = RTL8188C;
-		priv->usb_interrupts = 0;
-		priv->has_wifi = 1;
+		sprintf(priv->chip_vendor, "TSMC");
 	}
+}
 
-skip_complicated_chip_detection:
-
-	hw->wiphy->available_antennas_tx = BIT(priv->tx_paths) - 1;
-	hw->wiphy->available_antennas_rx = BIT(priv->rx_paths) - 1;
-
-	switch (priv->rtl_chip) {
-	case RTL8188E:
-	case RTL8188F:
-	case RTL8192E:
-	case RTL8723B:
-		switch (sys_cfg & SYS_CFG_VENDOR_EXT_MASK) {
-		case SYS_CFG_VENDOR_ID_TSMC:
-			sprintf(priv->chip_vendor, "TSMC");
-			break;
-		case SYS_CFG_VENDOR_ID_SMIC:
-			sprintf(priv->chip_vendor, "SMIC");
-			priv->vendor_smic = 1;
-			break;
-		case SYS_CFG_VENDOR_ID_UMC:
-			sprintf(priv->chip_vendor, "UMC");
-			priv->vendor_umc = 1;
-			break;
-		default:
-			sprintf(priv->chip_vendor, "unknown");
-		}
+void rtl8xxxu_identify_vendor_2bits(struct rtl8xxxu_priv *priv, u32 vendor)
+{
+	switch (vendor) {
+	case SYS_CFG_VENDOR_ID_TSMC:
+		sprintf(priv->chip_vendor, "TSMC");
+		break;
+	case SYS_CFG_VENDOR_ID_SMIC:
+		sprintf(priv->chip_vendor, "SMIC");
+		priv->vendor_smic = 1;
+		break;
+	case SYS_CFG_VENDOR_ID_UMC:
+		sprintf(priv->chip_vendor, "UMC");
+		priv->vendor_umc = 1;
 		break;
 	default:
-		if (sys_cfg & SYS_CFG_VENDOR_ID) {
-			sprintf(priv->chip_vendor, "UMC");
-			priv->vendor_umc = 1;
-		} else {
-			sprintf(priv->chip_vendor, "TSMC");
-		}
+		sprintf(priv->chip_vendor, "unknown");
 	}
+}
 
-	val32 = rtl8xxxu_read32(priv, REG_GPIO_OUTSTS);
-	priv->rom_rev = (val32 & GPIO_RF_RL_ID) >> 28;
+void rtl8xxxu_config_endpoints_sie(struct rtl8xxxu_priv *priv)
+{
+	u16 val16;
 
-	/*
-	 * 8188FU vendor driver doesn't use REG_NORMAL_SIE_EP_TX,
-	 * it just decides the queue mapping based on nr_out_eps.
-	 * However, reading the register returns "0x321" which
-	 * results in a wrong ep_tx_count of 3 and most frames
-	 * not being transmitted.
-	 */
-	if (priv->rtl_chip == RTL8188F)
-		val16 = 0;
-	else
-		val16 = rtl8xxxu_read16(priv, REG_NORMAL_SIE_EP_TX);
+	val16 = rtl8xxxu_read16(priv, REG_NORMAL_SIE_EP_TX);
 
 	if (val16 & NORMAL_SIE_EP_TX_HIGH_MASK) {
 		priv->ep_tx_high_queue = 1;
@@ -1746,29 +1638,29 @@ static int rtl8xxxu_identify_chip(struct rtl8xxxu_priv *priv)
 		priv->ep_tx_low_queue = 1;
 		priv->ep_tx_count++;
 	}
+}
 
-	/*
-	 * Fallback for devices that do not provide REG_NORMAL_SIE_EP_TX
-	 */
-	if (!priv->ep_tx_count) {
-		switch (priv->nr_out_eps) {
-		case 4:
-		case 3:
-			priv->ep_tx_low_queue = 1;
-			priv->ep_tx_count++;
-			fallthrough;
-		case 2:
-			priv->ep_tx_normal_queue = 1;
-			priv->ep_tx_count++;
-			fallthrough;
-		case 1:
-			priv->ep_tx_high_queue = 1;
-			priv->ep_tx_count++;
-			break;
-		default:
-			dev_info(dev, "Unsupported USB TX end-points\n");
-			return -ENOTSUPP;
-		}
+int rtl8xxxu_config_endpoints_no_sie(struct rtl8xxxu_priv *priv)
+{
+	struct device *dev = &priv->udev->dev;
+
+	switch (priv->nr_out_eps) {
+	case 4:
+	case 3:
+		priv->ep_tx_low_queue = 1;
+		priv->ep_tx_count++;
+		fallthrough;
+	case 2:
+		priv->ep_tx_normal_queue = 1;
+		priv->ep_tx_count++;
+		fallthrough;
+	case 1:
+		priv->ep_tx_high_queue = 1;
+		priv->ep_tx_count++;
+		break;
+	default:
+		dev_info(dev, "Unsupported USB TX end-points\n");
+		return -ENOTSUPP;
 	}
 
 	return 0;
@@ -6937,12 +6829,15 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	if (ret)
 		goto err_set_intfdata;
 
-	ret = rtl8xxxu_identify_chip(priv);
+	ret = priv->fops->identify_chip(priv);
 	if (ret) {
 		dev_err(&udev->dev, "Fatal - failed to identify chip\n");
 		goto err_set_intfdata;
 	}
 
+	hw->wiphy->available_antennas_tx = BIT(priv->tx_paths) - 1;
+	hw->wiphy->available_antennas_rx = BIT(priv->rx_paths) - 1;
+
 	ret = rtl8xxxu_read_efuse(priv);
 	if (ret) {
 		dev_err(&udev->dev, "Fatal - failed to read EFuse\n");
-- 
2.38.0
