Return-Path: <linux-wireless+bounces-27920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66021BC8EA0
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498D21A623FB
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D832E0927;
	Thu,  9 Oct 2025 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqPQ85h9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E66F2E040E
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010914; cv=none; b=DlEpG3ob+HV4FDjYvtJidlXr9et9F8F9VQHetHGqGpfvKsvnxyIpo+UNlGqzmL7Eh587iCzgjvVooGexh17bY8tO1TBk/+/rT0ybGQ3pNexwqH0a+DAimlfZ/3TwLeDe0WXa6kou/s4XITy2StRoOumHUy7+AWMbPu7E7yFl2Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010914; c=relaxed/simple;
	bh=9G0W4RplccC5rFkYPB5nxHEW7SPCvIgHuQwZmauxi0U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B9gECLzyL4o5b8CWzJgTRuyCd05YCqSLxzlV/JXKQLhWUanJ4DdRvE7V5pMujEnz6WDkAalAN49/SwnAOjjYqemSPFhedF0euGT8JI5fagd83t4kCOZHvAzcqdT/XkM75tmX/Hm11bYLegX07WlOLZAHJtCoytPoBYmAybbp9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqPQ85h9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e326e4e99so9767525e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Oct 2025 04:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760010910; x=1760615710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GVWgZLoRg9Lh/Ws3oWvekkk/RoLxzBVS4ZETEdc5+Uw=;
        b=eqPQ85h9csF3e1sZocwC4af+QoQrwDBOtDQB6r7LtDVhUOJeWWApdUP2Azant0DSDE
         KQxCIGhjNBLuFnq5Sc8U6fqB9ddiupECokAxsunB8+V2hcVVp29OUljYio+1ZvtPXtEB
         ET/pEGpzINXnfFvKZUBag9THFf9Uf8unpXbuq1Uu1HdT0ly/neij4BudeW4teY7GXEVY
         H443xjVlml8xqtD2uXW8kgXDsxBdQz5hWcHZO9WxLrLL1D6BYGIkfSgdX6yrezy76Qd6
         t48xbqvAz3N4nEI8QditgyBSUmw1ZXW1YWUyoC/pK9hxqqZxjDK3xtHivxrLP/2TEJ4o
         tm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760010910; x=1760615710;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVWgZLoRg9Lh/Ws3oWvekkk/RoLxzBVS4ZETEdc5+Uw=;
        b=YrVmPKIwXbf6DZfCkDavbq6G3H6IUcnTnvnuvSk+e0DvN+YLtL5YkScBlc+iVFD8N3
         l+K1Ur886Quc6vhXyTQUHHkNsnG+4QMOFdLEzY4C9Ncm1qCgVVUvhYSa7j04qgsm0Jjn
         rQ03UnHnMClL7QIyayCYFAQ/Z27X7u4PRdynk427S5oszYK4V4AcHXC14DRjOsic9P8K
         1vdwphqVo58SFexK3z1ePVJgqUVWdMI8d4RC915YI9LQwtoSKWapIWKX0P7x5xdeL+dp
         XlArCo8CAyR4yMU9hW4CHR9zJ807ggKKEki7w98GJ/T8LdekiD8JVpyBZO6zx3AG78h8
         +W2w==
X-Gm-Message-State: AOJu0Yyip99zOUzLy0whWTY84Yhk2h1KdtWHB/vfPSrWy+hp71F0L8dE
	qdYH8TcxZi3FvCbvFqOx6jYnYwBAGMBi01f1BsOCNHW0d9yFidHfQ/K7QCjCnA==
X-Gm-Gg: ASbGncufSMDacpeIa1nDZcyXHt08Ic0sehFHl5e7SmtAUBy3VHjLu+ORqTspVDyVfgj
	9kJgTwxRpGw1l86ivXAjgviZIJt1A2QQJMptRj0E4orF55SohWU3THJGqYozqRTCUusknmNplO9
	5144uas+6R7I4c6qDntdD5Jj2Nku+3BfZPF14g39/NOuqcOT7+D7NB7fvhf09WXTEtg4EAXXVxS
	HTj+gizn9N83mOr3ZwYQg2HGRDjOgbttroIdox5PNhBMQLsNBN4R0MmC3ihfJoJOo45ta91fkfT
	h9qRS8wiSc7x8GD+ZYLsCwA0JkCd+HsHzBwLtj1FA4x6JYjheHboq9/RwgB1XsT8NEamZnJKMkh
	AntwGANzvIXk81DJdQz3dJjdkQ3Lw8lyn+t0PuPww05FgkSOIOzLvju0=
X-Google-Smtp-Source: AGHT+IEt/SBzLHwkhWJCJDFQrmBD9nUXNwmqhCIXQtbIg3SedNm23JipFa7ifsr3fv47vb5Gxwbjjg==
X-Received: by 2002:a05:600c:1277:b0:46c:adf8:cd82 with SMTP id 5b1f17b1804b1-46fa2952c02mr52187705e9.3.1760010910119;
        Thu, 09 Oct 2025 04:55:10 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf11197esm46249295e9.6.2025.10.09.04.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 04:55:09 -0700 (PDT)
Message-ID: <b9d3f137-12ce-4bd9-8ada-3b8874bc3615@gmail.com>
Date: Thu, 9 Oct 2025 14:55:08 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 3/3] wifi: rtl8xxxu: Use correct power off sequence
 for RTL8192CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
References: <cdbe1a18-f6f1-4575-bad9-e85db8101247@gmail.com>
Content-Language: en-US
In-Reply-To: <cdbe1a18-f6f1-4575-bad9-e85db8101247@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8192CU disappears and reappears when rtl8xxxu is unloaded:

usbcore: deregistering interface driver rtl8xxxu
wlp3s0f3u2: deauthenticating from ... by local choice (Reason: 3=DEAUTH_LEAVING)
usb 1-2: rtl8xxxu_active_to_emu: Disabling MAC timed out
usb 1-2: USB disconnect, device number 7
usb 1-2: disconnecting
usb 1-2: new high-speed USB device number 8 using xhci_hcd
usb 1-2: New USB device found, idVendor=0bda, idProduct=8178, bcdDevice= 2.00
usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-2: Product: 802.11n WLAN Adapter
usb 1-2: Manufacturer: Realtek
usb 1-2: SerialNumber: 00e04c000001

This is because rtl8xxxu is using the power off sequence for RTL8723AU.
Add the correct power off sequence for RTL8192CU.

rtl8xxxu_power_off(), rtl8xxxu_active_to_emu(), and
rtl8xxxu_emu_to_disabled() are now only used for RTL8723AU, so move
them to 8723a.c and rename them to have the "rtl8723au" prefix.

Tested only with RTL8192CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c |  80 +++++++++++-
 drivers/net/wireless/realtek/rtl8xxxu/8723a.c | 115 +++++++++++++++-
 drivers/net/wireless/realtek/rtl8xxxu/core.c  | 123 ------------------
 drivers/net/wireless/realtek/rtl8xxxu/regs.h  |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |   1 -
 5 files changed, 194 insertions(+), 126 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
index 73034e7e41d1..444872131c66 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
@@ -593,6 +593,84 @@ static int rtl8192cu_power_on(struct rtl8xxxu_priv *priv)
 	return 0;
 }
 
+static void rtl8192cu_power_off(struct rtl8xxxu_priv *priv)
+{
+	u32 val32;
+	u16 val16;
+	u8 val8;
+	int i;
+
+	/*
+	 * Workaround for 8188RU LNA power leakage problem.
+	 */
+	if (priv->rtl_chip == RTL8188R) {
+		val32 = rtl8xxxu_read32(priv, REG_FPGA0_XCD_RF_PARM);
+		val32 |= BIT(1);
+		rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_PARM, val32);
+	}
+
+	/* _DisableRFAFEAndResetBB */
+	rtl8xxxu_write8(priv, REG_TXPAUSE, 0xff);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_AC, 0xff, 0);
+
+	rtl8xxxu_write8_set(priv, REG_APSD_CTRL, APSD_CTRL_OFF);
+	rtl8xxxu_write32_set(priv, REG_FPGA0_XCD_RF_PARM, FPGA0_RF_PARM_CLK_GATE);
+
+	rtl8xxxu_write8(priv, REG_SYS_FUNC,
+			SYS_FUNC_USBA | SYS_FUNC_USBD | SYS_FUNC_BB_GLB_RSTN);
+	rtl8xxxu_write8(priv, REG_SYS_FUNC, SYS_FUNC_USBA | SYS_FUNC_USBD);
+
+	/* _ResetDigitalProcedure1 */
+	if (rtl8xxxu_read8(priv, REG_MCU_FW_DL) & MCU_FW_DL_READY) {
+		rtl8xxxu_write8(priv, REG_MCU_FW_DL, 0x00);
+
+		rtl8xxxu_write8(priv, REG_FWIMR, 0x20);
+
+		rtl8xxxu_write8(priv, REG_HMTFR + 3, 0x20);
+
+		for (i = 0; i < 100; i++) {
+			val16 = rtl8xxxu_read16(priv, REG_SYS_FUNC);
+			if (!(val16 & SYS_FUNC_CPU_ENABLE))
+				break;
+
+			fsleep(50);
+		}
+
+		if (i == 100) {
+			rtl8xxxu_write8(priv, REG_SYS_FUNC + 1,
+					(SYS_FUNC_HWPDN | SYS_FUNC_ELDR) >> 8);
+			msleep(10);
+		}
+	}
+
+	val8 = (SYS_FUNC_HWPDN | SYS_FUNC_ELDR | SYS_FUNC_CPU_ENABLE) >> 8;
+	rtl8xxxu_write8(priv, REG_SYS_FUNC + 1, val8);
+
+	/* _DisableGPIO */
+	rtl8xxxu_write16(priv, REG_GPIO_PIN_CTRL + 2, 0);
+	val32 = rtl8xxxu_read32(priv, REG_GPIO_PIN_CTRL) & 0xffff00ff;
+	val32 |= (val32 & 0xff) << 8;
+	val32 |= 0x00ff0000;
+	rtl8xxxu_write32(priv, REG_GPIO_PIN_CTRL, val32);
+
+	rtl8xxxu_write8(priv, REG_GPIO_MUXCFG + 3, 0);
+	val16 = rtl8xxxu_read16(priv, REG_GPIO_MUXCFG + 2) & 0xff0f;
+	val16 |= (val16 & 0xf) << 4;
+	val16 |= 0x0780;
+	rtl8xxxu_write16(priv, REG_GPIO_MUXCFG + 2, val16);
+
+	/* _DisableAnalog */
+	val8 = 0x23;
+	if (priv->vendor_umc && priv->chip_cut == 1)
+		val8 |= BIT(3);
+	rtl8xxxu_write8(priv, REG_SPS0_CTRL, val8);
+
+	val16 = APS_FSMCO_HOST | APS_FSMCO_HW_SUSPEND | APS_FSMCO_PFM_ALDN;
+	rtl8xxxu_write16(priv, REG_APS_FSMCO, val16);
+
+	rtl8xxxu_write8(priv, REG_RSV_CTRL, 0x0e);
+}
+
 static int rtl8192cu_led_brightness_set(struct led_classdev *led_cdev,
 					enum led_brightness brightness)
 {
@@ -618,7 +696,7 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.parse_efuse = rtl8192cu_parse_efuse,
 	.load_firmware = rtl8192cu_load_firmware,
 	.power_on = rtl8192cu_power_on,
-	.power_off = rtl8xxxu_power_off,
+	.power_off = rtl8192cu_power_off,
 	.read_efuse = rtl8xxxu_read_efuse,
 	.reset_8051 = rtl8xxxu_reset_8051,
 	.llt_init = rtl8xxxu_init_llt_table,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
index ecbc324e4609..4f4493d0bfc2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
@@ -411,6 +411,119 @@ static int rtl8723au_power_on(struct rtl8xxxu_priv *priv)
 	return ret;
 }
 
+static int rtl8723au_active_to_emu(struct rtl8xxxu_priv *priv)
+{
+	u8 val8;
+	int count, ret = 0;
+
+	/* Start of rtl8723AU_card_enable_flow */
+	/* Act to Cardemu sequence*/
+	/* Turn off RF */
+	rtl8xxxu_write8(priv, REG_RF_CTRL, 0);
+
+	/* 0x004E[7] = 0, switch DPDT_SEL_P output from register 0x0065[2] */
+	val8 = rtl8xxxu_read8(priv, REG_LEDCFG2);
+	val8 &= ~LEDCFG2_DPDT_SELECT;
+	rtl8xxxu_write8(priv, REG_LEDCFG2, val8);
+
+	/* 0x0005[1] = 1 turn off MAC by HW state machine*/
+	val8 = rtl8xxxu_read8(priv, REG_APS_FSMCO + 1);
+	val8 |= BIT(1);
+	rtl8xxxu_write8(priv, REG_APS_FSMCO + 1, val8);
+
+	for (count = RTL8XXXU_MAX_REG_POLL; count; count--) {
+		val8 = rtl8xxxu_read8(priv, REG_APS_FSMCO + 1);
+		if ((val8 & BIT(1)) == 0)
+			break;
+		udelay(10);
+	}
+
+	if (!count) {
+		dev_warn(&priv->udev->dev, "%s: Disabling MAC timed out\n",
+			 __func__);
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	/* 0x0000[5] = 1 analog Ips to digital, 1:isolation */
+	val8 = rtl8xxxu_read8(priv, REG_SYS_ISO_CTRL);
+	val8 |= SYS_ISO_ANALOG_IPS;
+	rtl8xxxu_write8(priv, REG_SYS_ISO_CTRL, val8);
+
+	/* 0x0020[0] = 0 disable LDOA12 MACRO block*/
+	val8 = rtl8xxxu_read8(priv, REG_LDOA15_CTRL);
+	val8 &= ~LDOA15_ENABLE;
+	rtl8xxxu_write8(priv, REG_LDOA15_CTRL, val8);
+
+exit:
+	return ret;
+}
+
+static int rtl8723au_emu_to_disabled(struct rtl8xxxu_priv *priv)
+{
+	u8 val8;
+
+	/* 0x0007[7:0] = 0x20 SOP option to disable BG/MB */
+	rtl8xxxu_write8(priv, REG_APS_FSMCO + 3, 0x20);
+
+	/* 0x04[12:11] = 01 enable WL suspend */
+	val8 = rtl8xxxu_read8(priv, REG_APS_FSMCO + 1);
+	val8 &= ~BIT(4);
+	val8 |= BIT(3);
+	rtl8xxxu_write8(priv, REG_APS_FSMCO + 1, val8);
+
+	val8 = rtl8xxxu_read8(priv, REG_APS_FSMCO + 1);
+	val8 |= BIT(7);
+	rtl8xxxu_write8(priv, REG_APS_FSMCO + 1, val8);
+
+	/* 0x48[16] = 1 to enable GPIO9 as EXT wakeup */
+	val8 = rtl8xxxu_read8(priv, REG_GPIO_INTM + 2);
+	val8 |= BIT(0);
+	rtl8xxxu_write8(priv, REG_GPIO_INTM + 2, val8);
+
+	return 0;
+}
+
+static void rtl8723au_power_off(struct rtl8xxxu_priv *priv)
+{
+	u8 val8;
+	u16 val16;
+
+	rtl8xxxu_flush_fifo(priv);
+
+	rtl8xxxu_active_to_lps(priv);
+
+	/* Turn off RF */
+	rtl8xxxu_write8(priv, REG_RF_CTRL, 0x00);
+
+	/* Reset Firmware if running in RAM */
+	if (rtl8xxxu_read8(priv, REG_MCU_FW_DL) & MCU_FW_RAM_SEL)
+		rtl8xxxu_firmware_self_reset(priv);
+
+	/* Reset MCU */
+	val16 = rtl8xxxu_read16(priv, REG_SYS_FUNC);
+	val16 &= ~SYS_FUNC_CPU_ENABLE;
+	rtl8xxxu_write16(priv, REG_SYS_FUNC, val16);
+
+	/* Reset MCU ready status */
+	rtl8xxxu_write8(priv, REG_MCU_FW_DL, 0x00);
+
+	rtl8723au_active_to_emu(priv);
+	rtl8723au_emu_to_disabled(priv);
+
+	/* Reset MCU IO Wrapper */
+	val8 = rtl8xxxu_read8(priv, REG_RSV_CTRL + 1);
+	val8 &= ~BIT(0);
+	rtl8xxxu_write8(priv, REG_RSV_CTRL + 1, val8);
+
+	val8 = rtl8xxxu_read8(priv, REG_RSV_CTRL + 1);
+	val8 |= BIT(0);
+	rtl8xxxu_write8(priv, REG_RSV_CTRL + 1, val8);
+
+	/* RSV_CTRL 0x1C[7:0] = 0x0e  lock ISO/CLK/Power control register */
+	rtl8xxxu_write8(priv, REG_RSV_CTRL, 0x0e);
+}
+
 #define XTAL1	GENMASK(23, 18)
 #define XTAL0	GENMASK(17, 12)
 
@@ -492,7 +605,7 @@ struct rtl8xxxu_fileops rtl8723au_fops = {
 	.parse_efuse = rtl8723au_parse_efuse,
 	.load_firmware = rtl8723au_load_firmware,
 	.power_on = rtl8723au_power_on,
-	.power_off = rtl8xxxu_power_off,
+	.power_off = rtl8723au_power_off,
 	.read_efuse = rtl8xxxu_read_efuse,
 	.reset_8051 = rtl8xxxu_reset_8051,
 	.llt_init = rtl8xxxu_init_llt_table,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 3a2cb06fa905..1b15fc3ead99 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -3637,54 +3637,6 @@ static void rtl8xxxu_set_ampdu_min_space(struct rtl8xxxu_priv *priv, u8 density)
 	rtl8xxxu_write8(priv, REG_AMPDU_MIN_SPACE, val8);
 }
 
-static int rtl8xxxu_active_to_emu(struct rtl8xxxu_priv *priv)
-{
-	u8 val8;
-	int count, ret = 0;
-
-	/* Start of rtl8723AU_card_enable_flow */
-	/* Act to Cardemu sequence*/
-	/* Turn off RF */
-	rtl8xxxu_write8(priv, REG_RF_CTRL, 0);
-
-	/* 0x004E[7] = 0, switch DPDT_SEL_P output from register 0x0065[2] */
-	val8 = rtl8xxxu_read8(priv, REG_LEDCFG2);
-	val8 &= ~LEDCFG2_DPDT_SELECT;
-	rtl8xxxu_write8(priv, REG_LEDCFG2, val8);
-
-	/* 0x0005[1] = 1 turn off MAC by HW state machine*/
-	val8 = rtl8xxxu_read8(priv, REG_APS_FSMCO + 1);
-	val8 |= BIT(1);
-	rtl8xxxu_write8(priv, REG_APS_FSMCO + 1, val8);
-
-	for (count = RTL8XXXU_MAX_REG_POLL; count; count--) {
-		val8 = rtl8xxxu_read8(priv, REG_APS_FSMCO + 1);
-		if ((val8 & BIT(1)) == 0)
-			break;
-		udelay(10);
-	}
-
-	if (!count) {
-		dev_warn(&priv->udev->dev, "%s: Disabling MAC timed out\n",
-			 __func__);
-		ret = -EBUSY;
-		goto exit;
-	}
-
-	/* 0x0000[5] = 1 analog Ips to digital, 1:isolation */
-	val8 = rtl8xxxu_read8(priv, REG_SYS_ISO_CTRL);
-	val8 |= SYS_ISO_ANALOG_IPS;
-	rtl8xxxu_write8(priv, REG_SYS_ISO_CTRL, val8);
-
-	/* 0x0020[0] = 0 disable LDOA12 MACRO block*/
-	val8 = rtl8xxxu_read8(priv, REG_LDOA15_CTRL);
-	val8 &= ~LDOA15_ENABLE;
-	rtl8xxxu_write8(priv, REG_LDOA15_CTRL, val8);
-
-exit:
-	return ret;
-}
-
 int rtl8xxxu_active_to_lps(struct rtl8xxxu_priv *priv)
 {
 	u8 val8;
@@ -3761,31 +3713,6 @@ void rtl8xxxu_disabled_to_emu(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write8(priv, REG_APS_FSMCO + 1, val8);
 }
 
-static int rtl8xxxu_emu_to_disabled(struct rtl8xxxu_priv *priv)
-{
-	u8 val8;
-
-	/* 0x0007[7:0] = 0x20 SOP option to disable BG/MB */
-	rtl8xxxu_write8(priv, REG_APS_FSMCO + 3, 0x20);
-
-	/* 0x04[12:11] = 01 enable WL suspend */
-	val8 = rtl8xxxu_read8(priv, REG_APS_FSMCO + 1);
-	val8 &= ~BIT(4);
-	val8 |= BIT(3);
-	rtl8xxxu_write8(priv, REG_APS_FSMCO + 1, val8);
-
-	val8 = rtl8xxxu_read8(priv, REG_APS_FSMCO + 1);
-	val8 |= BIT(7);
-	rtl8xxxu_write8(priv, REG_APS_FSMCO + 1, val8);
-
-	/* 0x48[16] = 1 to enable GPIO9 as EXT wakeup */
-	val8 = rtl8xxxu_read8(priv, REG_GPIO_INTM + 2);
-	val8 |= BIT(0);
-	rtl8xxxu_write8(priv, REG_GPIO_INTM + 2, val8);
-
-	return 0;
-}
-
 int rtl8xxxu_flush_fifo(struct rtl8xxxu_priv *priv)
 {
 	struct device *dev = &priv->udev->dev;
@@ -3863,56 +3790,6 @@ void rtl8xxxu_gen2_usb_quirks(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write32(priv, REG_TXDMA_OFFSET_CHK, val32);
 }
 
-void rtl8xxxu_power_off(struct rtl8xxxu_priv *priv)
-{
-	u8 val8;
-	u16 val16;
-	u32 val32;
-
-	/*
-	 * Workaround for 8188RU LNA power leakage problem.
-	 */
-	if (priv->rtl_chip == RTL8188R) {
-		val32 = rtl8xxxu_read32(priv, REG_FPGA0_XCD_RF_PARM);
-		val32 |= BIT(1);
-		rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_PARM, val32);
-	}
-
-	rtl8xxxu_flush_fifo(priv);
-
-	rtl8xxxu_active_to_lps(priv);
-
-	/* Turn off RF */
-	rtl8xxxu_write8(priv, REG_RF_CTRL, 0x00);
-
-	/* Reset Firmware if running in RAM */
-	if (rtl8xxxu_read8(priv, REG_MCU_FW_DL) & MCU_FW_RAM_SEL)
-		rtl8xxxu_firmware_self_reset(priv);
-
-	/* Reset MCU */
-	val16 = rtl8xxxu_read16(priv, REG_SYS_FUNC);
-	val16 &= ~SYS_FUNC_CPU_ENABLE;
-	rtl8xxxu_write16(priv, REG_SYS_FUNC, val16);
-
-	/* Reset MCU ready status */
-	rtl8xxxu_write8(priv, REG_MCU_FW_DL, 0x00);
-
-	rtl8xxxu_active_to_emu(priv);
-	rtl8xxxu_emu_to_disabled(priv);
-
-	/* Reset MCU IO Wrapper */
-	val8 = rtl8xxxu_read8(priv, REG_RSV_CTRL + 1);
-	val8 &= ~BIT(0);
-	rtl8xxxu_write8(priv, REG_RSV_CTRL + 1, val8);
-
-	val8 = rtl8xxxu_read8(priv, REG_RSV_CTRL + 1);
-	val8 |= BIT(0);
-	rtl8xxxu_write8(priv, REG_RSV_CTRL + 1, val8);
-
-	/* RSV_CTRL 0x1C[7:0] = 0x0e  lock ISO/CLK/Power control register */
-	rtl8xxxu_write8(priv, REG_RSV_CTRL, 0x0e);
-}
-
 void rtl8723bu_set_ps_tdma(struct rtl8xxxu_priv *priv,
 			   u8 arg1, u8 arg2, u8 arg3, u8 arg4, u8 arg5)
 {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/regs.h b/drivers/net/wireless/realtek/rtl8xxxu/regs.h
index 61c0c0ec07b3..0741db8d08bf 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/regs.h
@@ -40,6 +40,7 @@
 #define  APS_FSMCO_SW_LPS		BIT(10)
 #define  APS_FSMCO_HW_SUSPEND		BIT(11)
 #define  APS_FSMCO_PCIE			BIT(12)
+#define  APS_FSMCO_HOST			BIT(14)
 #define  APS_FSMCO_HW_POWERDOWN		BIT(15)
 #define  APS_FSMCO_WLON_RESET		BIT(16)
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index f42463e595cc..9fb2583ffffc 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -2078,7 +2078,6 @@ int rtl8xxxu_init_phy_regs(struct rtl8xxxu_priv *priv,
 			   const struct rtl8xxxu_reg32val *array);
 int rtl8xxxu_load_firmware(struct rtl8xxxu_priv *priv, const char *fw_name);
 void rtl8xxxu_firmware_self_reset(struct rtl8xxxu_priv *priv);
-void rtl8xxxu_power_off(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_identify_vendor_1bit(struct rtl8xxxu_priv *priv, u32 vendor);
 void rtl8xxxu_identify_vendor_2bits(struct rtl8xxxu_priv *priv, u32 vendor);
 void rtl8xxxu_config_endpoints_sie(struct rtl8xxxu_priv *priv);
-- 
2.51.0


