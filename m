Return-Path: <linux-wireless+bounces-4639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90EC879E65
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 23:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC82284C19
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F6D144044;
	Tue, 12 Mar 2024 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ6Dp+OY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0714403B
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282057; cv=none; b=MvZkUH3iATw7aj42ZM7ps6t+YdmSVNSHPVMr2sWmVZaLRbo4QvbVU+Uqnd4NeJuTDlQyLWBCKwkHngxLOSmNONz6IY/gYFq+wKPjjsfGrqERpaZhQCVi3i53mqghOK8UD+TNJ/GgP7vsu2QreErSq79kvz4ATVtzpBSSsoipvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282057; c=relaxed/simple;
	bh=awu9h9IzkVIbc25OgttWTWXNydXKOsGCRds62U6jCEQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KwSM3WmssNArx/pJ4OpHmKUMv87AFRqRkIEFGbQQfjrErZ2cBbXHbKoVjhvh04dU8HP+GUcSORewnWvh6ljkhhO1PuaK3p2dImf/OERch44jDy5PBMq/lYWX5/u6zUYPrZwybCNP/KensVCe5q1Xrc+/oHnAaMWnuRj08XFPcSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQ6Dp+OY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5684c3313cdso3812435a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710282053; x=1710886853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNXdSPy7hLgETibYIcrT6E2Z1zLfvr+g1U0k75tMraQ=;
        b=KQ6Dp+OYqTpt+HhKGew+ROVY2e9vt/GdeQLGo8xPFFawQAjTkPxb/jF1TynsY9W0kh
         3b8SxhfdLR3xwB9P/4/OeyB3+c64WX2rlAEzl0/El5Ozax9oYts8ZVjZ2R9Vij8Z+wUT
         al8ZUJsYDAPm/GKuS5GZqyRVb/6LFhbfUMtkbMGcHSANB3Ay6ep9+Oa9UGBpXaw5G6yp
         lyn7bSaBwzgcaQz4Kw+Zixulsqvp/tibmkymvTsDzUdeb8bwTCL/nT3Nf8TPgxKLkTi6
         ETeKXYS09gCIGzP93OC2FWdPrTQG5W1ZPwxowGivS+FfOmrj6PeRyTG+Yrg3+mLZqTst
         He+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710282053; x=1710886853;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNXdSPy7hLgETibYIcrT6E2Z1zLfvr+g1U0k75tMraQ=;
        b=icsKIvkRGUUOm3jaBSBS7TL+DVrPepmKFcNmmUB15FxaYmEhCaoobKSoU7JmW53kZv
         V9pgtXul1q0vHhCAHtPQxMpmcBBatBtyid4/Y0i9LHONE/0r2JdftfFgUAnW70TTWU9j
         Mmu5tvVzG/eAQpuMqDxkhPGG7zF5CNJrfWRmi55T3ul7j+N058ol80WoAMfOjZIr/Sem
         6kTVTSAQDYUNW+GDgR7E9DJY+DlCndgj7WxNJRraTaxxpwlS4JwcqAHppyQ49KzOpQ6v
         A2mrOsOxhYFqH/DA9ycEqz3uNe2xl4mf0/ODfEEHUiZMH8H8BYo0qGTyip/9EKAvsEHM
         3taQ==
X-Gm-Message-State: AOJu0Yz1k7nmeww9vbYbshpIJLOV7nJuDGY4hrrEvMKM7cXhh51kTAz7
	1iTId8RJeRNiPPUuf38NrutUHiX7PXmoWtXu+E1u46EzcqYIn62lhz/6ta5l
X-Google-Smtp-Source: AGHT+IF9ajxMW0ElVIBVONpjiHk7oJydDce+pidm+ELKI+3W/uv8Yng2iCCFw3xmTc8XMPN3ewGPWg==
X-Received: by 2002:a17:906:a84e:b0:a46:5598:3430 with SMTP id dx14-20020a170906a84e00b00a4655983430mr123962ejb.9.1710282053055;
        Tue, 12 Mar 2024 15:20:53 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id k13-20020a1709065fcd00b00a44f0d99d58sm4205973ejv.208.2024.03.12.15.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 15:20:52 -0700 (PDT)
Message-ID: <d70dc39c-a3e5-43f6-9cb4-612d08035c57@gmail.com>
Date: Wed, 13 Mar 2024 00:20:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] wifi: rtlwifi: Adjust rtl8192d-common for USB
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
In-Reply-To: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A few of the shared functions need small changes for the USB driver.

Also, add a few macros to wifi.h and initialise rtlhal.interfaceindex
for USB devices.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../wireless/realtek/rtlwifi/rtl8192d/def.h   |   2 +
 .../realtek/rtlwifi/rtl8192d/fw_common.c      |  19 +++
 .../realtek/rtlwifi/rtl8192d/hw_common.c      |  46 ++++--
 .../realtek/rtlwifi/rtl8192d/phy_common.c     |  26 ++-
 .../realtek/rtlwifi/rtl8192d/phy_common.h     |   6 +
 .../wireless/realtek/rtlwifi/rtl8192d/reg.h   | 156 +++++++++++++++---
 drivers/net/wireless/realtek/rtlwifi/usb.c    |   3 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |   5 +
 8 files changed, 222 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/def.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/def.h
index 21726d9b4aef..ee45f51fcf71 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/def.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/def.h
@@ -116,6 +116,8 @@ enum version_8192d {
 #define IS_92D_E_CUT(version)		((IS_92D(version)) ?		\
 				 ((GET_CVID_CUT_VERSION(version) ==	\
 				 CHIP_92D_E_CUT) ? true : false) : false)
+#define IS_NORMAL_CHIP(version)	\
+	((version & NORMAL_CHIP) ? true : false)
 
 enum rf_optype {
 	RF_OP_BY_SW_3WIRE = 0,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
index e333275c51c3..ac48bd9dcc9f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
@@ -94,9 +94,22 @@ EXPORT_SYMBOL_GPL(rtl92d_fw_free_to_go);
 void rtl92d_firmware_selfreset(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	u8 u1b_tmp;
 	u8 delay = 100;
 
+	if (rtlhal->interface == INTF_USB) {
+		delay *= 60;
+
+		rtl_write_byte(rtlpriv, REG_FSIMR, 0);
+
+		/* We need to disable other HRCV INT to influence 8051 reset. */
+		rtl_write_byte(rtlpriv, REG_FWIMR, 0x20);
+
+		/* Close mask to prevent incorrect FW write operation. */
+		rtl_write_byte(rtlpriv, REG_FTIMR, 0);
+	}
+
 	/* Set (REG_HMETFR + 3) to  0x20 is reset 8051 */
 	rtl_write_byte(rtlpriv, REG_HMETFR + 3, 0x20);
 	u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
@@ -107,6 +120,12 @@ void rtl92d_firmware_selfreset(struct ieee80211_hw *hw)
 		udelay(50);
 		u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
 	}
+
+	if (rtlhal->interface == INTF_USB) {
+		if ((u1b_tmp & BIT(2)) && delay == 0)
+			rtl_write_byte(rtlpriv, REG_FWIMR, 0);
+	}
+
 	WARN_ONCE((delay <= 0), "rtl8192de: 8051 reset failed!\n");
 	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
 		"=====> 8051 reset success (%d)\n", delay);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
index ada08f82adff..b9bc2fdde5e2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
@@ -622,9 +622,14 @@ static void _rtl92de_read_macphymode_from_prom(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	u8 macphy_crvalue = content[EEPROM_MAC_FUNCTION];
+	bool is_single_mac = true;
 
-	if (macphy_crvalue & BIT(3)) {
+	if (rtlhal->interface == INTF_PCI)
+		is_single_mac = !!(content[EEPROM_MAC_FUNCTION] & BIT(3));
+	else if (rtlhal->interface == INTF_USB)
+		is_single_mac = !(content[EEPROM_ENDPOINT_SETTING] & BIT(0));
+
+	if (is_single_mac) {
 		rtlhal->macphymode = SINGLEMAC_SINGLEPHY;
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 			"MacPhyMode SINGLEMAC_SINGLEPHY\n");
@@ -663,6 +668,7 @@ static void _rtl92de_efuse_update_chip_version(struct ieee80211_hw *hw)
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "D-CUT!!!\n");
 		break;
 	case 0xCC33:
+	case 0x33CC:
 		chipver |= CHIP_92D_E_CUT;
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "E-CUT!!!\n");
 		break;
@@ -679,14 +685,22 @@ static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	int params[] = {RTL8190_EEPROM_ID, EEPROM_VID, EEPROM_DID,
-			EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR_MAC0_92D,
-			EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
-			COUNTRY_CODE_WORLD_WIDE_13};
+	int params_pci[] = {RTL8190_EEPROM_ID, EEPROM_VID, EEPROM_DID,
+			    EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR_MAC0_92D,
+			    EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
+			    COUNTRY_CODE_WORLD_WIDE_13};
+	int params_usb[] = {RTL8190_EEPROM_ID, EEPROM_VID_USB, EEPROM_PID_USB,
+			    EEPROM_VID_USB, EEPROM_PID_USB, EEPROM_MAC_ADDR_MAC0_92DU,
+			    EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
+			    COUNTRY_CODE_WORLD_WIDE_13};
+	int *params = params_pci;
 	int i;
 	u16 usvalue;
 	u8 *hwinfo;
 
+	if (rtlhal->interface == INTF_USB)
+		params = params_usb;
+
 	hwinfo = kzalloc(HWSET_MAX_SIZE, GFP_KERNEL);
 	if (!hwinfo)
 		return;
@@ -858,7 +872,7 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 							1 : 0;
 	enum wireless_mode wirelessmode = 0;
 	bool shortgi = false;
-	u32 value[2];
+	u8 rate_mask[5];
 	u8 macid = 0;
 	u8 mimo_ps = IEEE80211_SMPS_OFF;
 
@@ -966,12 +980,17 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 		break;
 	}
 
-	value[0] = (ratr_bitmap & 0x0fffffff) | (ratr_index << 28);
-	value[1] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
+	*(u32 *)&rate_mask = (ratr_bitmap & 0x0fffffff) |
+				     (ratr_index << 28);
+	rate_mask[4] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
 	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
-		"ratr_bitmap :%x value0:%x value1:%x\n",
-		ratr_bitmap, value[0], value[1]);
-	rtl92d_fill_h2c_cmd(hw, H2C_RA_MASK, 5, (u8 *) value);
+	"Rate_index:%x, ratr_val:%x, %5phC\n",
+		ratr_index, ratr_bitmap, rate_mask);
+	memcpy(rtlpriv->rate_mask, rate_mask, 5);
+	/* rtl92d_fill_h2c_cmd() does USB I/O and will result in a
+	 * "scheduled while atomic" if called directly
+	 */
+	schedule_work(&rtlpriv->works.fill_h2c_cmd);
 	if (macid != 0)
 		sta_entry->ratr_index = ratr_index;
 }
@@ -1015,7 +1034,8 @@ bool rtl92de_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 	bool actuallyset = false;
 	unsigned long flag;
 
-	if (rtlpci->being_init_adapter)
+	if (rtlpriv->rtlhal.interface == INTF_PCI &&
+	    rtlpci->being_init_adapter)
 		return false;
 	if (ppsc->swrf_processing)
 		return false;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
index 487628ac491b..1e39940a3ba7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
@@ -81,11 +81,13 @@ u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		regaddr, rfpath, bitmask);
-	spin_lock(&rtlpriv->locks.rf_lock);
+	if (rtlpriv->rtlhal.interface == INTF_PCI)
+		spin_lock(&rtlpriv->locks.rf_lock);
 	original_value = _rtl92d_phy_rf_serial_read(hw, rfpath, regaddr);
 	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
-	spin_unlock(&rtlpriv->locks.rf_lock);
+	if (rtlpriv->rtlhal.interface == INTF_PCI)
+		spin_unlock(&rtlpriv->locks.rf_lock);
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
 		regaddr, rfpath, bitmask, original_value);
@@ -105,7 +107,8 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 		regaddr, bitmask, data, rfpath);
 	if (bitmask == 0)
 		return;
-	spin_lock(&rtlpriv->locks.rf_lock);
+	if (rtlpriv->rtlhal.interface == INTF_PCI)
+		spin_lock(&rtlpriv->locks.rf_lock);
 	if (rtlphy->rf_mode != RF_OP_BY_FW) {
 		if (bitmask != RFREG_OFFSET_MASK) {
 			original_value = _rtl92d_phy_rf_serial_read(hw,
@@ -116,7 +119,8 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 		}
 		_rtl92d_phy_rf_serial_write(hw, rfpath, regaddr, data);
 	}
-	spin_unlock(&rtlpriv->locks.rf_lock);
+	if (rtlpriv->rtlhal.interface == INTF_PCI)
+		spin_unlock(&rtlpriv->locks.rf_lock);
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		regaddr, bitmask, data, rfpath);
@@ -642,6 +646,8 @@ static void rtl92d_phy_set_io(struct ieee80211_hw *hw)
 	case IO_CMD_PAUSE_DM_BY_SCAN:
 		rtlphy->initgain_backup.xaagccore1 = de_digtable->cur_igvalue;
 		de_digtable->cur_igvalue = 0x37;
+		if (rtlpriv->rtlhal.interface == INTF_USB)
+			de_digtable->cur_igvalue = 0x17;
 		rtl92d_dm_write_dig(hw);
 		break;
 	default:
@@ -698,22 +704,28 @@ void rtl92d_phy_config_macphymode(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	u8 offset = REG_MAC_PHY_CTRL_NORMAL;
+	u8 temp = 0xf0;
+
+	if (rtlhal->interface == INTF_USB) {
+		temp = rtl_read_byte(rtlpriv, offset);
+		temp &= ~(BIT(0) | BIT(1) | BIT(2));
+	}
 
 	switch (rtlhal->macphymode) {
 	case DUALMAC_DUALPHY:
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 			"MacPhyMode: DUALMAC_DUALPHY\n");
-		rtl_write_byte(rtlpriv, offset, 0xF3);
+		rtl_write_byte(rtlpriv, offset, temp | BIT(0) | BIT(1));
 		break;
 	case SINGLEMAC_SINGLEPHY:
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 			"MacPhyMode: SINGLEMAC_SINGLEPHY\n");
-		rtl_write_byte(rtlpriv, offset, 0xF4);
+		rtl_write_byte(rtlpriv, offset, temp | BIT(2));
 		break;
 	case DUALMAC_SINGLEPHY:
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 			"MacPhyMode: DUALMAC_SINGLEPHY\n");
-		rtl_write_byte(rtlpriv, offset, 0xF1);
+		rtl_write_byte(rtlpriv, offset, temp | BIT(0));
 		break;
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
index 071776d05eb9..5649a11f4405 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
@@ -41,6 +41,9 @@ static inline void rtl92d_acquire_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
+	if (rtlpriv->rtlhal.interface == INTF_USB)
+		return;
+
 	if (rtlpriv->rtlhal.interfaceindex == 1)
 		spin_lock_irqsave(&rtlpriv->locks.cck_and_rw_pagea_lock, *flag);
 }
@@ -50,6 +53,9 @@ static inline void rtl92d_release_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
+	if (rtlpriv->rtlhal.interface == INTF_USB)
+		return;
+
 	if (rtlpriv->rtlhal.interfaceindex == 1)
 		spin_unlock_irqrestore(&rtlpriv->locks.cck_and_rw_pagea_lock,
 			*flag);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h
index 2783d7e7b227..1f2daf779539 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h
@@ -51,6 +51,8 @@
 #define REG_HMEBOX_EXT_2		0x008C
 #define REG_HMEBOX_EXT_3		0x008E
 
+#define REG_EFUSE_ACCESS		0x00CF
+
 #define REG_BIST_SCAN			0x00D0
 #define REG_BIST_RPT			0x00D4
 #define REG_BIST_ROM_RPT		0x00D8
@@ -86,6 +88,7 @@
 #define REG_CPWM			0x012F
 #define REG_FWIMR			0x0130
 #define REG_FWISR			0x0134
+#define REG_FTIMR			0x0138
 #define REG_PKTBUF_DBG_CTRL		0x0140
 #define REG_PKTBUF_DBG_DATA_L		0x0144
 #define REG_PKTBUF_DBG_DATA_H		0x0148
@@ -197,6 +200,8 @@
 #define REG_POWER_STAGE1		0x04B4
 #define REG_POWER_STAGE2		0x04B8
 #define REG_PKT_LIFE_TIME		0x04C0
+#define REG_PKT_VO_VI_LIFE_TIME		0x04C0
+#define REG_PKT_BE_BK_LIFE_TIME		0x04C2
 #define REG_STBC_SETTING		0x04C4
 #define REG_PROT_MODE_CTRL		0x04C8
 #define REG_MAX_AGGR_NUM		0x04CA
@@ -233,6 +238,7 @@
 #define REG_RD_NAV_NXT			0x0544
 #define REG_NAV_PROT_LEN		0x0546
 #define REG_BCN_CTRL			0x0550
+#define REG_BCN_CTRL_1			0x0551
 #define REG_MBID_NUM			0x0552
 #define REG_DUAL_TSF_RST		0x0553
 #define REG_BCN_INTERVAL		0x0554
@@ -319,6 +325,8 @@
 #define REG_BT_COEX_TABLE		0x06C0
 #define REG_WMAC_RESP_TXINFO		0x06D8
 
+#define REG_USB_Queue_Select_MAC0	0xFE44
+#define REG_USB_Queue_Select_MAC1	0xFE47
 
 /* ----------------------------------------------------- */
 /*	Redifine 8192C register definition for compatibility */
@@ -355,27 +363,27 @@
 #define	RRSR_RSC_UPSUBCHNL		0x400000
 #define	RRSR_RSC_LOWSUBCHNL		0x200000
 #define	RRSR_SHORT			0x800000
-#define	RRSR_1M				BIT0
-#define	RRSR_2M				BIT1
-#define	RRSR_5_5M			BIT2
-#define	RRSR_11M			BIT3
-#define	RRSR_6M				BIT4
-#define	RRSR_9M				BIT5
-#define	RRSR_12M			BIT6
-#define	RRSR_18M			BIT7
-#define	RRSR_24M			BIT8
-#define	RRSR_36M			BIT9
-#define	RRSR_48M			BIT10
-#define	RRSR_54M			BIT11
-#define	RRSR_MCS0			BIT12
-#define	RRSR_MCS1			BIT13
-#define	RRSR_MCS2			BIT14
-#define	RRSR_MCS3			BIT15
-#define	RRSR_MCS4			BIT16
-#define	RRSR_MCS5			BIT17
-#define	RRSR_MCS6			BIT18
-#define	RRSR_MCS7			BIT19
-#define	BRSR_ACKSHORTPMB		BIT23
+#define	RRSR_1M				BIT(0)
+#define	RRSR_2M				BIT(1)
+#define	RRSR_5_5M			BIT(2)
+#define	RRSR_11M			BIT(3)
+#define	RRSR_6M				BIT(4)
+#define	RRSR_9M				BIT(5)
+#define	RRSR_12M			BIT(6)
+#define	RRSR_18M			BIT(7)
+#define	RRSR_24M			BIT(8)
+#define	RRSR_36M			BIT(9)
+#define	RRSR_48M			BIT(10)
+#define	RRSR_54M			BIT(11)
+#define	RRSR_MCS0			BIT(12)
+#define	RRSR_MCS1			BIT(13)
+#define	RRSR_MCS2			BIT(14)
+#define	RRSR_MCS3			BIT(15)
+#define	RRSR_MCS4			BIT(16)
+#define	RRSR_MCS5			BIT(17)
+#define	RRSR_MCS6			BIT(18)
+#define	RRSR_MCS7			BIT(19)
+#define	BRSR_ACKSHORTPMB		BIT(23)
 
 /* ----------------------------------------------------- */
 /*       8192C Rate Definition  */
@@ -600,7 +608,11 @@
 #define EEPROM_SVID			0x2C /* SE Vendor ID.E-F */
 #define EEPROM_SMID			0x2E /* SE PCI Subsystem ID. 10-11 */
 
+#define EEPROM_VID_USB				0xC
+#define EEPROM_PID_USB				0xE
+#define EEPROM_ENDPOINT_SETTING			0x10
 #define EEPROM_MAC_ADDR			0x16 /* SEMAC Address. 12-17 */
+#define EEPROM_MAC_ADDR_MAC0_92DU		0x19
 #define EEPROM_MAC_ADDR_MAC0_92D	0x55
 #define EEPROM_MAC_ADDR_MAC1_92D	0x5B
 
@@ -915,6 +927,43 @@
 #define BD_HCI_SEL				BIT(26)
 #define TYPE_ID					BIT(27)
 
+#define HCI_TXDMA_EN				BIT(0)
+#define HCI_RXDMA_EN				BIT(1)
+#define TXDMA_EN				BIT(2)
+#define RXDMA_EN				BIT(3)
+#define PROTOCOL_EN				BIT(4)
+#define SCHEDULE_EN				BIT(5)
+#define MACTXEN					BIT(6)
+#define MACRXEN					BIT(7)
+#define ENSWBCN					BIT(8)
+#define ENSEC					BIT(9)
+
+#define HQSEL_VOQ				BIT(0)
+#define HQSEL_VIQ				BIT(1)
+#define HQSEL_BEQ				BIT(2)
+#define HQSEL_BKQ				BIT(3)
+#define HQSEL_MGTQ				BIT(4)
+#define HQSEL_HIQ				BIT(5)
+
+#define _TXDMA_HIQ_MAP(x)			(((x) & 0x3) << 14)
+#define _TXDMA_MGQ_MAP(x)			(((x) & 0x3) << 12)
+#define _TXDMA_BKQ_MAP(x)			(((x) & 0x3) << 10)
+#define _TXDMA_BEQ_MAP(x)			(((x) & 0x3) <<  8)
+#define _TXDMA_VIQ_MAP(x)			(((x) & 0x3) <<  6)
+#define _TXDMA_VOQ_MAP(x)			(((x) & 0x3) <<  4)
+
+#define QUEUE_LOW				1
+#define QUEUE_NORMAL				2
+#define QUEUE_HIGH				3
+
+#define _HPQ(x)					((x) & 0xFF)
+#define _LPQ(x)					(((x) & 0xFF) << 8)
+#define _PUBQ(x)				(((x) & 0xFF) << 16)
+#define _NPQ(x)					((x) & 0xFF)
+#define LD_RQPN					BIT(31)
+
+#define DROP_DATA_EN				BIT(9)
+
 /* LLT_INIT */
 #define _LLT_NO_ACTIVE				0x0
 #define _LLT_WRITE_ACCESS			0x1
@@ -929,6 +978,9 @@
 /* ----------------------------------------------------- */
 /*	0x0400h ~ 0x047Fh	Protocol Configuration	 */
 /* ----------------------------------------------------- */
+/* FWHW_TXQ_CTRL */
+#define EN_AMPDU_RTY_NEW			BIT(7)
+
 #define	RETRY_LIMIT_SHORT_SHIFT			8
 #define	RETRY_LIMIT_LONG_SHIFT			0
 
@@ -942,6 +994,9 @@
 #define AC_PARAM_ECW_MIN_OFFSET			8
 #define AC_PARAM_AIFS_OFFSET			0
 
+/* REG_RD_CTRL */
+#define DIS_EDCA_CNT_DWN			BIT(11)
+
 /* ACMHWCTRL */
 #define	ACMHW_HWEN				BIT(0)
 #define	ACMHW_BEQEN				BIT(1)
@@ -1073,6 +1128,11 @@
 #define	RCCK0_FACOUNTERLOWER			0xa5c
 #define	RCCK0_FACOUNTERUPPER			0xa58
 
+#define	RPDP_ANTA				0xb00
+#define	RCONFIG_ANTA				0xb68
+#define	RCONFIG_ANTB				0xb6c
+#define	RPDP_ANTB				0xb70
+
 /* 6. PageC(0xC00) */
 #define	ROFDM0_LSTF				0xc00
 
@@ -1126,6 +1186,7 @@
 #define	ROFDM0_TXPSEUDONOISEWGT			0xce4
 #define	ROFDM0_FRAMESYNC			0xcf0
 #define	ROFDM0_DFSREPORT			0xcf4
+#define	ROFDM0_RXIQEXTANTA			0xca0
 #define	ROFDM0_TXCOEFF1				0xca4
 #define	ROFDM0_TXCOEFF2				0xca8
 #define	ROFDM0_TXCOEFF3				0xcac
@@ -1184,17 +1245,70 @@
 #define	RTXAGC_B_MCS15_MCS12			0x868
 #define	RTXAGC_B_CCK11_A_CCK2_11		0x86c
 
+#define	RFPGA0_IQK				0xe28
+#define	RTX_IQK_TONE_A				0xe30
+#define	RRX_IQK_TONE_A				0xe34
+#define	RTX_IQK_PI_A				0xe38
+#define	RRX_IQK_PI_A				0xe3c
+
+#define	RTX_IQK					0xe40
+#define	RRX_IQK					0xe44
+#define	RIQK_AGC_PTS				0xe48
+#define	RIQK_AGC_RSP				0xe4c
+#define	RTX_IQK_TONE_B				0xe50
+#define	RRX_IQK_TONE_B				0xe54
+#define	RTX_IQK_PI_B				0xe58
+#define	RRX_IQK_PI_B				0xe5c
+#define	RIQK_AGC_CONT				0xe60
+
+#define	RBLUE_TOOTH				0xe6c
+#define	RRX_WAIT_CCA				0xe70
+#define	RTX_CCK_RFON				0xe74
+#define	RTX_CCK_BBON				0xe78
+#define	RTX_OFDM_RFON				0xe7c
+#define	RTX_OFDM_BBON				0xe80
+#define	RTX_TO_RX				0xe84
+#define	RTX_TO_TX				0xe88
+#define	RRX_CCK					0xe8c
+
+#define	RTX_POWER_BEFORE_IQK_A			0xe94
+#define	RTX_POWER_AFTER_IQK_A			0xe9c
+
+#define	RRX_POWER_BEFORE_IQK_A			0xea0
+#define	RRX_POWER_BEFORE_IQK_A_2		0xea4
+#define	RRX_POWER_AFTER_IQK_A			0xea8
+#define	RRX_POWER_AFTER_IQK_A_2			0xeac
+
+#define	RTX_POWER_BEFORE_IQK_B			0xeb4
+#define	RTX_POWER_AFTER_IQK_B			0xebc
+
+#define	RRX_POWER_BEFORE_IQK_B			0xec0
+#define	RRX_POWER_BEFORE_IQK_B_2		0xec4
+#define	RRX_POWER_AFTER_IQK_B			0xec8
+#define	RRX_POWER_AFTER_IQK_B_2			0xecc
+
+#define	MASK_IQK_RESULT				0x03ff0000
+
+#define	RRX_OFDM				0xed0
+#define	RRX_WAIT_RIFS				0xed4
+#define	RRX_TO_RX				0xed8
+#define	RSTANDBY				0xedc
+#define	RSLEEP					0xee0
+#define	RPMPD_ANAEN				0xeec
+
 /* RL6052 Register definition */
 #define	RF_AC					0x00
 
 #define	RF_IQADJ_G1				0x01
 #define	RF_IQADJ_G2				0x02
+#define	RF_BS_PA_APSET_G1_G4			0x03
 #define	RF_POW_TRSW				0x05
 
 #define	RF_GAIN_RX				0x06
 #define	RF_GAIN_TX				0x07
 
 #define	RF_TXM_IDAC				0x08
+#define	RF_TXPA_AG				0x0B
 #define	RF_BS_IQGEN				0x0F
 
 #define	RF_MODE1				0x10
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 6e8c87a2fae4..2ea72d9e3957 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -979,6 +979,9 @@ int rtl_usb_probe(struct usb_interface *intf,
 	usb_priv->dev.intf = intf;
 	usb_priv->dev.udev = udev;
 	usb_set_intfdata(intf, hw);
+	/* For dual MAC RTL8192DU, which has two interfaces. */
+	rtlpriv->rtlhal.interfaceindex =
+		intf->altsetting[0].desc.bInterfaceNumber;
 	/* init cfg & intf_ops */
 	rtlpriv->rtlhal.interface = INTF_USB;
 	rtlpriv->cfg = rtl_hal_cfg;
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 9fabf597cfd6..c45463744f16 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -20,6 +20,7 @@
 #define	MASKBYTE1				0xff00
 #define	MASKBYTE2				0xff0000
 #define	MASKBYTE3				0xff000000
+#define	MASKH3BYTES				0xffffff00
 #define	MASKHWORD				0xffff0000
 #define	MASKLWORD				0x0000ffff
 #define	MASKDWORD				0xffffffff
@@ -48,6 +49,10 @@
 #define	MASK20BITS				0xfffff
 #define RFREG_OFFSET_MASK			0xfffff
 
+/* For dual MAC RTL8192DU */
+#define	MAC0_ACCESS_PHY1			0x4000
+#define	MAC1_ACCESS_PHY0			0x2000
+
 #define RF_CHANGE_BY_INIT			0
 #define RF_CHANGE_BY_IPS			BIT(28)
 #define RF_CHANGE_BY_PS				BIT(29)
-- 
2.43.2

