Return-Path: <linux-wireless+bounces-8014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDEC8CD60A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD271C212A1
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312A913E032;
	Thu, 23 May 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU7cWh5D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46329CEB
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475424; cv=none; b=YCLMNCi5cJLCpEX7m8eFJWso/ukRqndXeZ4BrqINJbFCYAm/8w/RpZ9yTzO8E88xRRgttf6fCR+ShE18CbzGs5V5dYgKjEoLpgv3zK+t2t9s10xWL17IxiG0i2oGzrayxgLmQ/Yktx93P0xE6HzzoP2EQO46ubquT40EpRN5Rv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475424; c=relaxed/simple;
	bh=aD0t+7I8S6xdqmj//FJ5jRCR1mvDdb/TXZQUgn6auyM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IMy0S1v++z3NvQLngjXLs6iLs7NTE//ZBSwx6oQEW5BhddRJypUgcbPDT5IiWsneIxyzBpg04wOMNgFQ4DD7eePSu0k95WqL3Frg7KINj3h0CyhekF8b10XVZvp1wsWI/XUlCnGyGA6Jukjnc87rnHJvV5DtPavcHR29ufoCuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NU7cWh5D; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59ad12efe3so548669266b.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716475420; x=1717080220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DUMljYDL9VZcHBgT9mWGsbRE0Woo/KHV4KLGdrEqE2c=;
        b=NU7cWh5DwF6nBaA0OIEyvbG/gqcZMhjlblxXyYUqgEgfUiso10RyXIuH3XP6aLLitP
         uFAh6iRSA5ecsL47FZ+OaGuvL6z/3KCksjcPvOsWEPD9rXTU4M324UylkIU0bPRF4XeY
         bBKpb93uQibijBTXZ1azyW1UBgf4EYp3L8f1/DV+DZFeX6Xfhcv5UIIObqmb3R/JtSmH
         QbmuzRQb2NtiV5l70OYWVPZHCM6I5p23fjc11a5c0NhHSPFSRid0XhvcPSms94U+MFyT
         S953N9tmlbOpGSW8In7UyBgrc59tFdUNrdOBGZy2agkEyfpduxQucZhVPJ+qtElPdKoR
         pffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475420; x=1717080220;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUMljYDL9VZcHBgT9mWGsbRE0Woo/KHV4KLGdrEqE2c=;
        b=UodzWmHSz1mCHOgtkT9Y+euwT25V07VZ5uBmXZ3AvL3ihncNs7B9OQMpCuWkDmYMI1
         axhCSxvDMTyocCxRqGPjsxcKnpVYWm/2yE9ydELej/tZOVaaiv0m17nlp8w+ueLjajS4
         uQV9ixbjhCJZwsa2Lt/s4MzuXdFYkFqf6OIwXYHHic7ZgKvZIUr+S6jWDpur3bzU8OF6
         x0Etpe36eXWFnFYuBqDHVmhpPsQI0uBpEFBoEi1L0vQyiE/ounOLXFrjayfSdYsV4o+a
         Qwxa40dh8FsaK2szrYxHHZgi9k7PVlRzNf/Df7G+CZdKFon2a79qONJAxfX4bdhtPLRE
         EksA==
X-Gm-Message-State: AOJu0YyIoLmUB05RhJU8QL9WVGSo9DM8WozU9MBQWuCUSFHCPX9u9id1
	vIMtcXA0aPWhuS6yknMw3QolXgZGHkhtFbBW8fiftj9nH4bF2pX6tUb7gg==
X-Google-Smtp-Source: AGHT+IGwN6ZTdte0Skt6pu/+Kqx7zgtu8cnqvRc8WnqSapjKr591H+5UiZGjr1GeiCG/BxdRhWdUMQ==
X-Received: by 2002:a05:6402:3494:b0:578:34a4:261 with SMTP id 4fb4d7f45d1cf-57834a4085emr5069860a12.27.1716475419546;
        Thu, 23 May 2024 07:43:39 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c323887sm20174287a12.89.2024.05.23.07.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 07:43:38 -0700 (PDT)
Message-ID: <abe3624d-f986-4a24-966c-67defa962e3f@gmail.com>
Date: Thu, 23 May 2024 17:43:37 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 01/12] wifi: rtlwifi: rtl8192d: Use "rtl92d" prefix
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
Content-Language: en-US
In-Reply-To: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some functions moved from rtl8192de still use the "rtl92de" prefix.
Rename them.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v7:
 - Patch is new in v7.
---
 .../realtek/rtlwifi/rtl8192d/hw_common.c      | 94 +++++++++----------
 .../realtek/rtlwifi/rtl8192d/hw_common.h      | 28 +++---
 .../realtek/rtlwifi/rtl8192d/trx_common.c     | 92 +++++++++---------
 .../realtek/rtlwifi/rtl8192d/trx_common.h     | 16 ++--
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   | 18 ++--
 .../wireless/realtek/rtlwifi/rtl8192de/sw.c   | 20 ++--
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  |  2 +-
 7 files changed, 135 insertions(+), 135 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
index 6570d5e168e9..97e0d9c01e0a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
@@ -14,7 +14,7 @@
 #include "hw_common.h"
 #include "phy_common.h"
 
-void rtl92de_stop_tx_beacon(struct ieee80211_hw *hw)
+void rtl92d_stop_tx_beacon(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 tmp1byte;
@@ -27,9 +27,9 @@ void rtl92de_stop_tx_beacon(struct ieee80211_hw *hw)
 	tmp1byte &= ~(BIT(0));
 	rtl_write_byte(rtlpriv, REG_TBTT_PROHIBIT + 2, tmp1byte);
 }
-EXPORT_SYMBOL_GPL(rtl92de_stop_tx_beacon);
+EXPORT_SYMBOL_GPL(rtl92d_stop_tx_beacon);
 
-void rtl92de_resume_tx_beacon(struct ieee80211_hw *hw)
+void rtl92d_resume_tx_beacon(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 tmp1byte;
@@ -42,7 +42,7 @@ void rtl92de_resume_tx_beacon(struct ieee80211_hw *hw)
 	tmp1byte |= BIT(0);
 	rtl_write_byte(rtlpriv, REG_TBTT_PROHIBIT + 2, tmp1byte);
 }
-EXPORT_SYMBOL_GPL(rtl92de_resume_tx_beacon);
+EXPORT_SYMBOL_GPL(rtl92d_resume_tx_beacon);
 
 void rtl92d_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 {
@@ -285,7 +285,7 @@ void rtl92d_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 }
 EXPORT_SYMBOL_GPL(rtl92d_set_hw_reg);
 
-bool rtl92de_llt_write(struct ieee80211_hw *hw, u32 address, u32 data)
+bool rtl92d_llt_write(struct ieee80211_hw *hw, u32 address, u32 data)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	bool status = true;
@@ -307,9 +307,9 @@ bool rtl92de_llt_write(struct ieee80211_hw *hw, u32 address, u32 data)
 	} while (++count);
 	return status;
 }
-EXPORT_SYMBOL_GPL(rtl92de_llt_write);
+EXPORT_SYMBOL_GPL(rtl92d_llt_write);
 
-void rtl92de_enable_hw_security_config(struct ieee80211_hw *hw)
+void rtl92d_enable_hw_security_config(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 sec_reg_value;
@@ -334,16 +334,16 @@ void rtl92de_enable_hw_security_config(struct ieee80211_hw *hw)
 		"The SECR-value %x\n", sec_reg_value);
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
 }
-EXPORT_SYMBOL_GPL(rtl92de_enable_hw_security_config);
+EXPORT_SYMBOL_GPL(rtl92d_enable_hw_security_config);
 
 /* don't set REG_EDCA_BE_PARAM here because
  * mac80211 will send pkt when scan
  */
-void rtl92de_set_qos(struct ieee80211_hw *hw, int aci)
+void rtl92d_set_qos(struct ieee80211_hw *hw, int aci)
 {
 	rtl92d_dm_init_edca_turbo(hw);
 }
-EXPORT_SYMBOL_GPL(rtl92de_set_qos);
+EXPORT_SYMBOL_GPL(rtl92d_set_qos);
 
 static enum version_8192d _rtl92d_read_chip_version(struct ieee80211_hw *hw)
 {
@@ -362,8 +362,8 @@ static enum version_8192d _rtl92d_read_chip_version(struct ieee80211_hw *hw)
 	return version;
 }
 
-static void _rtl92de_readpowervalue_fromprom(struct txpower_info *pwrinfo,
-					     u8 *efuse, bool autoloadfail)
+static void _rtl92d_readpowervalue_fromprom(struct txpower_info *pwrinfo,
+					    u8 *efuse, bool autoloadfail)
 {
 	u32 rfpath, eeaddr, group, offset, offset1, offset2;
 	u8 i, val8;
@@ -500,8 +500,8 @@ static void _rtl92de_readpowervalue_fromprom(struct txpower_info *pwrinfo,
 	}
 }
 
-static void _rtl92de_read_txpower_info(struct ieee80211_hw *hw,
-				       bool autoload_fail, u8 *hwinfo)
+static void _rtl92d_read_txpower_info(struct ieee80211_hw *hw,
+				      bool autoload_fail, u8 *hwinfo)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
@@ -509,7 +509,7 @@ static void _rtl92de_read_txpower_info(struct ieee80211_hw *hw,
 	u8 tempval[2], i, pwr, diff;
 	u32 ch, rfpath, group;
 
-	_rtl92de_readpowervalue_fromprom(&pwrinfo, hwinfo, autoload_fail);
+	_rtl92d_readpowervalue_fromprom(&pwrinfo, hwinfo, autoload_fail);
 	if (!autoload_fail) {
 		/* bit0~2 */
 		rtlefuse->eeprom_regulatory = (hwinfo[EEPROM_RF_OPT1] & 0x7);
@@ -613,8 +613,8 @@ static void _rtl92de_read_txpower_info(struct ieee80211_hw *hw,
 	}
 }
 
-static void _rtl92de_read_macphymode_from_prom(struct ieee80211_hw *hw,
-					       u8 *content)
+static void _rtl92d_read_macphymode_from_prom(struct ieee80211_hw *hw,
+					      u8 *content)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
@@ -636,15 +636,15 @@ static void _rtl92de_read_macphymode_from_prom(struct ieee80211_hw *hw,
 	}
 }
 
-static void _rtl92de_read_macphymode_and_bandtype(struct ieee80211_hw *hw,
-						  u8 *content)
+static void _rtl92d_read_macphymode_and_bandtype(struct ieee80211_hw *hw,
+						 u8 *content)
 {
-	_rtl92de_read_macphymode_from_prom(hw, content);
+	_rtl92d_read_macphymode_from_prom(hw, content);
 	rtl92d_phy_config_macphymode(hw);
 	rtl92d_phy_config_macphymode_info(hw);
 }
 
-static void _rtl92de_efuse_update_chip_version(struct ieee80211_hw *hw)
+static void _rtl92d_efuse_update_chip_version(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	enum version_8192d chipver = rtlpriv->rtlhal.version;
@@ -676,7 +676,7 @@ static void _rtl92de_efuse_update_chip_version(struct ieee80211_hw *hw)
 	rtlpriv->rtlhal.version = chipver;
 }
 
-static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
+static void _rtl92d_read_adapter_info(struct ieee80211_hw *hw)
 {
 	static const int params_pci[] = {
 		RTL8190_EEPROM_ID, EEPROM_VID, EEPROM_DID,
@@ -706,8 +706,8 @@ static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
 	if (rtl_get_hwinfo(hw, rtlpriv, HWSET_MAX_SIZE, hwinfo, params))
 		goto exit;
 
-	_rtl92de_efuse_update_chip_version(hw);
-	_rtl92de_read_macphymode_and_bandtype(hw, hwinfo);
+	_rtl92d_efuse_update_chip_version(hw);
+	_rtl92d_read_macphymode_and_bandtype(hw, hwinfo);
 
 	/* Read Permanent MAC address for 2nd interface */
 	if (rtlhal->interfaceindex != 0)
@@ -717,7 +717,7 @@ static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_ETHER_ADDR,
 				      rtlefuse->dev_addr);
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
-	_rtl92de_read_txpower_info(hw, rtlefuse->autoload_failflag, hwinfo);
+	_rtl92d_read_txpower_info(hw, rtlefuse->autoload_failflag, hwinfo);
 
 	/* Read Channel Plan */
 	switch (rtlhal->bandset) {
@@ -739,7 +739,7 @@ static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
 	kfree(hwinfo);
 }
 
-void rtl92de_read_eeprom_info(struct ieee80211_hw *hw)
+void rtl92d_read_eeprom_info(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
@@ -760,15 +760,15 @@ void rtl92de_read_eeprom_info(struct ieee80211_hw *hw)
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
 
 		rtlefuse->autoload_failflag = false;
-		_rtl92de_read_adapter_info(hw);
+		_rtl92d_read_adapter_info(hw);
 	} else {
 		pr_err("Autoload ERR!!\n");
 	}
 }
-EXPORT_SYMBOL_GPL(rtl92de_read_eeprom_info);
+EXPORT_SYMBOL_GPL(rtl92d_read_eeprom_info);
 
-static void rtl92de_update_hal_rate_table(struct ieee80211_hw *hw,
-					  struct ieee80211_sta *sta)
+static void rtl92d_update_hal_rate_table(struct ieee80211_hw *hw,
+					 struct ieee80211_sta *sta)
 {
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -851,9 +851,9 @@ static void rtl92de_update_hal_rate_table(struct ieee80211_hw *hw,
 		rtl_read_dword(rtlpriv, REG_ARFR0));
 }
 
-static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
-					 struct ieee80211_sta *sta,
-					 u8 rssi_level, bool update_bw)
+static void rtl92d_update_hal_rate_mask(struct ieee80211_hw *hw,
+					struct ieee80211_sta *sta,
+					u8 rssi_level, bool update_bw)
 {
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -1009,20 +1009,20 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 		sta_entry->ratr_index = ratr_index;
 }
 
-void rtl92de_update_hal_rate_tbl(struct ieee80211_hw *hw,
-				 struct ieee80211_sta *sta,
-				 u8 rssi_level, bool update_bw)
+void rtl92d_update_hal_rate_tbl(struct ieee80211_hw *hw,
+				struct ieee80211_sta *sta,
+				u8 rssi_level, bool update_bw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (rtlpriv->dm.useramask)
-		rtl92de_update_hal_rate_mask(hw, sta, rssi_level, update_bw);
+		rtl92d_update_hal_rate_mask(hw, sta, rssi_level, update_bw);
 	else
-		rtl92de_update_hal_rate_table(hw, sta);
+		rtl92d_update_hal_rate_table(hw, sta);
 }
-EXPORT_SYMBOL_GPL(rtl92de_update_hal_rate_tbl);
+EXPORT_SYMBOL_GPL(rtl92d_update_hal_rate_tbl);
 
-void rtl92de_update_channel_access_setting(struct ieee80211_hw *hw)
+void rtl92d_update_channel_access_setting(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -1036,9 +1036,9 @@ void rtl92de_update_channel_access_setting(struct ieee80211_hw *hw)
 		sifs_timer = 0x1010;
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_SIFS, (u8 *)&sifs_timer);
 }
-EXPORT_SYMBOL_GPL(rtl92de_update_channel_access_setting);
+EXPORT_SYMBOL_GPL(rtl92d_update_channel_access_setting);
 
-bool rtl92de_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
+bool rtl92d_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
@@ -1093,11 +1093,11 @@ bool rtl92de_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 	*valid = 1;
 	return !ppsc->hwradiooff;
 }
-EXPORT_SYMBOL_GPL(rtl92de_gpio_radio_on_off_checking);
+EXPORT_SYMBOL_GPL(rtl92d_gpio_radio_on_off_checking);
 
-void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
-		     u8 *p_macaddr, bool is_group, u8 enc_algo,
-		     bool is_wepkey, bool clear_all)
+void rtl92d_set_key(struct ieee80211_hw *hw, u32 key_index,
+		    u8 *p_macaddr, bool is_group, u8 enc_algo,
+		    bool is_wepkey, bool clear_all)
 {
 	static const u8 cam_const_addr[4][6] = {
 		{0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
@@ -1222,4 +1222,4 @@ void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(rtl92de_set_key);
+EXPORT_SYMBOL_GPL(rtl92d_set_key);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.h
index 2c07f5cc5766..4da1bab15f36 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.h
@@ -4,21 +4,21 @@
 #ifndef __RTL92D_HW_COMMON_H__
 #define __RTL92D_HW_COMMON_H__
 
-void rtl92de_stop_tx_beacon(struct ieee80211_hw *hw);
-void rtl92de_resume_tx_beacon(struct ieee80211_hw *hw);
+void rtl92d_stop_tx_beacon(struct ieee80211_hw *hw);
+void rtl92d_resume_tx_beacon(struct ieee80211_hw *hw);
 void rtl92d_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val);
 void rtl92d_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val);
-bool rtl92de_llt_write(struct ieee80211_hw *hw, u32 address, u32 data);
-void rtl92de_enable_hw_security_config(struct ieee80211_hw *hw);
-void rtl92de_set_qos(struct ieee80211_hw *hw, int aci);
-void rtl92de_read_eeprom_info(struct ieee80211_hw *hw);
-void rtl92de_update_hal_rate_tbl(struct ieee80211_hw *hw,
-				 struct ieee80211_sta *sta,
-				 u8 rssi_level, bool update_bw);
-void rtl92de_update_channel_access_setting(struct ieee80211_hw *hw);
-bool rtl92de_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid);
-void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
-		     u8 *p_macaddr, bool is_group, u8 enc_algo,
-		     bool is_wepkey, bool clear_all);
+bool rtl92d_llt_write(struct ieee80211_hw *hw, u32 address, u32 data);
+void rtl92d_enable_hw_security_config(struct ieee80211_hw *hw);
+void rtl92d_set_qos(struct ieee80211_hw *hw, int aci);
+void rtl92d_read_eeprom_info(struct ieee80211_hw *hw);
+void rtl92d_update_hal_rate_tbl(struct ieee80211_hw *hw,
+				struct ieee80211_sta *sta,
+				u8 rssi_level, bool update_bw);
+void rtl92d_update_channel_access_setting(struct ieee80211_hw *hw);
+bool rtl92d_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid);
+void rtl92d_set_key(struct ieee80211_hw *hw, u32 key_index,
+		    u8 *p_macaddr, bool is_group, u8 enc_algo,
+		    bool is_wepkey, bool clear_all);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
index 72d2b7426d82..9f9a34492030 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
@@ -7,8 +7,8 @@
 #include "def.h"
 #include "trx_common.h"
 
-static long _rtl92de_translate_todbm(struct ieee80211_hw *hw,
-				     u8 signal_strength_index)
+static long _rtl92d_translate_todbm(struct ieee80211_hw *hw,
+				    u8 signal_strength_index)
 {
 	long signal_power;
 
@@ -17,13 +17,13 @@ static long _rtl92de_translate_todbm(struct ieee80211_hw *hw,
 	return signal_power;
 }
 
-static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
-				       struct rtl_stats *pstats,
-				       __le32 *pdesc,
-				       struct rx_fwinfo_92d *p_drvinfo,
-				       bool packet_match_bssid,
-				       bool packet_toself,
-				       bool packet_beacon)
+static void _rtl92d_query_rxphystatus(struct ieee80211_hw *hw,
+				      struct rtl_stats *pstats,
+				      __le32 *pdesc,
+				      struct rx_fwinfo_92d *p_drvinfo,
+				      bool packet_match_bssid,
+				      bool packet_toself,
+				      bool packet_beacon)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
@@ -203,8 +203,8 @@ static void rtl92d_loop_over_paths(struct ieee80211_hw *hw,
 	}
 }
 
-static void _rtl92de_process_ui_rssi(struct ieee80211_hw *hw,
-				     struct rtl_stats *pstats)
+static void _rtl92d_process_ui_rssi(struct ieee80211_hw *hw,
+				    struct rtl_stats *pstats)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rt_smooth_data *ui_rssi;
@@ -226,15 +226,15 @@ static void _rtl92de_process_ui_rssi(struct ieee80211_hw *hw,
 	if (ui_rssi->index >= PHY_RSSI_SLID_WIN_MAX)
 		ui_rssi->index = 0;
 	tmpval = ui_rssi->total_val / ui_rssi->total_num;
-	rtlpriv->stats.signal_strength = _rtl92de_translate_todbm(hw, (u8)tmpval);
+	rtlpriv->stats.signal_strength = _rtl92d_translate_todbm(hw, (u8)tmpval);
 	pstats->rssi = rtlpriv->stats.signal_strength;
 
 	if (!pstats->is_cck && pstats->packet_toself)
 		rtl92d_loop_over_paths(hw, pstats);
 }
 
-static void _rtl92de_update_rxsignalstatistics(struct ieee80211_hw *hw,
-					       struct rtl_stats *pstats)
+static void _rtl92d_update_rxsignalstatistics(struct ieee80211_hw *hw,
+					      struct rtl_stats *pstats)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	int weighting = 0;
@@ -249,8 +249,8 @@ static void _rtl92de_update_rxsignalstatistics(struct ieee80211_hw *hw,
 		5 + pstats->recvsignalpower + weighting) / 6;
 }
 
-static void _rtl92de_process_pwdb(struct ieee80211_hw *hw,
-				  struct rtl_stats *pstats)
+static void _rtl92d_process_pwdb(struct ieee80211_hw *hw,
+				 struct rtl_stats *pstats)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -276,7 +276,7 @@ static void _rtl92de_process_pwdb(struct ieee80211_hw *hw,
 			      (pstats->rx_pwdb_all)) / (RX_SMOOTH_FACTOR);
 		}
 		rtlpriv->dm.undec_sm_pwdb = undec_sm_pwdb;
-		_rtl92de_update_rxsignalstatistics(hw, pstats);
+		_rtl92d_update_rxsignalstatistics(hw, pstats);
 	}
 }
 
@@ -301,8 +301,8 @@ static void rtl92d_loop_over_streams(struct ieee80211_hw *hw,
 	}
 }
 
-static void _rtl92de_process_ui_link_quality(struct ieee80211_hw *hw,
-					     struct rtl_stats *pstats)
+static void _rtl92d_process_ui_link_quality(struct ieee80211_hw *hw,
+					    struct rtl_stats *pstats)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rt_smooth_data *ui_link_quality;
@@ -330,24 +330,24 @@ static void _rtl92de_process_ui_link_quality(struct ieee80211_hw *hw,
 	rtl92d_loop_over_streams(hw, pstats);
 }
 
-static void _rtl92de_process_phyinfo(struct ieee80211_hw *hw,
-				     u8 *buffer,
-				     struct rtl_stats *pcurrent_stats)
+static void _rtl92d_process_phyinfo(struct ieee80211_hw *hw,
+				    u8 *buffer,
+				    struct rtl_stats *pcurrent_stats)
 {
 	if (!pcurrent_stats->packet_matchbssid &&
 	    !pcurrent_stats->packet_beacon)
 		return;
 
-	_rtl92de_process_ui_rssi(hw, pcurrent_stats);
-	_rtl92de_process_pwdb(hw, pcurrent_stats);
-	_rtl92de_process_ui_link_quality(hw, pcurrent_stats);
+	_rtl92d_process_ui_rssi(hw, pcurrent_stats);
+	_rtl92d_process_pwdb(hw, pcurrent_stats);
+	_rtl92d_process_ui_link_quality(hw, pcurrent_stats);
 }
 
-static void _rtl92de_translate_rx_signal_stuff(struct ieee80211_hw *hw,
-					       struct sk_buff *skb,
-					       struct rtl_stats *pstats,
-					       __le32 *pdesc,
-					       struct rx_fwinfo_92d *p_drvinfo)
+static void _rtl92d_translate_rx_signal_stuff(struct ieee80211_hw *hw,
+					      struct sk_buff *skb,
+					      struct rtl_stats *pstats,
+					      __le32 *pdesc,
+					      struct rx_fwinfo_92d *p_drvinfo)
 {
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -375,15 +375,15 @@ static void _rtl92de_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 	packet_toself = packet_matchbssid &&
 			ether_addr_equal(praddr, rtlefuse->dev_addr);
 	packet_beacon = ieee80211_is_beacon(fc);
-	_rtl92de_query_rxphystatus(hw, pstats, pdesc, p_drvinfo,
-				   packet_matchbssid, packet_toself,
-				   packet_beacon);
-	_rtl92de_process_phyinfo(hw, tmp_buf, pstats);
+	_rtl92d_query_rxphystatus(hw, pstats, pdesc, p_drvinfo,
+				  packet_matchbssid, packet_toself,
+				  packet_beacon);
+	_rtl92d_process_phyinfo(hw, tmp_buf, pstats);
 }
 
-bool rtl92de_rx_query_desc(struct ieee80211_hw *hw, struct rtl_stats *stats,
-			   struct ieee80211_rx_status *rx_status,
-			   u8 *pdesc8, struct sk_buff *skb)
+bool rtl92d_rx_query_desc(struct ieee80211_hw *hw, struct rtl_stats *stats,
+			  struct ieee80211_rx_status *rx_status,
+			  u8 *pdesc8, struct sk_buff *skb)
 {
 	__le32 *pdesc = (__le32 *)pdesc8;
 	struct rx_fwinfo_92d *p_drvinfo;
@@ -423,17 +423,17 @@ bool rtl92de_rx_query_desc(struct ieee80211_hw *hw, struct rtl_stats *stats,
 	if (phystatus) {
 		p_drvinfo = (struct rx_fwinfo_92d *)(skb->data +
 						     stats->rx_bufshift);
-		_rtl92de_translate_rx_signal_stuff(hw, skb, stats, pdesc,
-						   p_drvinfo);
+		_rtl92d_translate_rx_signal_stuff(hw, skb, stats, pdesc,
+						  p_drvinfo);
 	}
 	/*rx_status->qual = stats->signal; */
 	rx_status->signal = stats->recvsignalpower + 10;
 	return true;
 }
-EXPORT_SYMBOL_GPL(rtl92de_rx_query_desc);
+EXPORT_SYMBOL_GPL(rtl92d_rx_query_desc);
 
-void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc8, bool istx,
-		      u8 desc_name, u8 *val)
+void rtl92d_set_desc(struct ieee80211_hw *hw, u8 *pdesc8, bool istx,
+		     u8 desc_name, u8 *val)
 {
 	__le32 *pdesc = (__le32 *)pdesc8;
 
@@ -473,10 +473,10 @@ void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc8, bool istx,
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(rtl92de_set_desc);
+EXPORT_SYMBOL_GPL(rtl92d_set_desc);
 
-u64 rtl92de_get_desc(struct ieee80211_hw *hw,
-		     u8 *p_desc8, bool istx, u8 desc_name)
+u64 rtl92d_get_desc(struct ieee80211_hw *hw,
+		    u8 *p_desc8, bool istx, u8 desc_name)
 {
 	__le32 *p_desc = (__le32 *)p_desc8;
 	u32 ret = 0;
@@ -513,4 +513,4 @@ u64 rtl92de_get_desc(struct ieee80211_hw *hw,
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(rtl92de_get_desc);
+EXPORT_SYMBOL_GPL(rtl92d_get_desc);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h
index 87d956d771eb..528182b1eba6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h
@@ -393,13 +393,13 @@ struct rx_fwinfo_92d {
 #endif
 } __packed;
 
-bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,
-			   struct rtl_stats *stats,
-			   struct ieee80211_rx_status *rx_status,
-			   u8 *pdesc, struct sk_buff *skb);
-void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
-		      u8 desc_name, u8 *val);
-u64 rtl92de_get_desc(struct ieee80211_hw *hw,
-		     u8 *p_desc, bool istx, u8 desc_name);
+bool rtl92d_rx_query_desc(struct ieee80211_hw *hw,
+			  struct rtl_stats *stats,
+			  struct ieee80211_rx_status *rx_status,
+			  u8 *pdesc, struct sk_buff *skb);
+void rtl92d_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
+		     u8 desc_name, u8 *val);
+u64 rtl92d_get_desc(struct ieee80211_hw *hw,
+		    u8 *p_desc, bool istx, u8 desc_name);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
index 73b81e60cfa9..03f4314bdb2e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
@@ -181,7 +181,7 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		u8 btype_ibss = val[0];
 
 		if (btype_ibss)
-			rtl92de_stop_tx_beacon(hw);
+			rtl92d_stop_tx_beacon(hw);
 		_rtl92de_set_bcn_ctrl_reg(hw, 0, BIT(3));
 		rtl_write_dword(rtlpriv, REG_TSFTR,
 				(u32) (mac->tsf & 0xffffffff));
@@ -189,7 +189,7 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 				(u32) ((mac->tsf >> 32) & 0xffffffff));
 		_rtl92de_set_bcn_ctrl_reg(hw, BIT(3), 0);
 		if (btype_ibss)
-			rtl92de_resume_tx_beacon(hw);
+			rtl92d_resume_tx_beacon(hw);
 
 		break;
 	}
@@ -295,13 +295,13 @@ static bool _rtl92de_llt_table_init(struct ieee80211_hw *hw)
 
 	/* 18.  LLT_table_init(Adapter);  */
 	for (i = 0; i < (txpktbuf_bndy - 1); i++) {
-		status = rtl92de_llt_write(hw, i, i + 1);
+		status = rtl92d_llt_write(hw, i, i + 1);
 		if (!status)
 			return status;
 	}
 
 	/* end of list */
-	status = rtl92de_llt_write(hw, (txpktbuf_bndy - 1), 0xFF);
+	status = rtl92d_llt_write(hw, (txpktbuf_bndy - 1), 0xFF);
 	if (!status)
 		return status;
 
@@ -310,13 +310,13 @@ static bool _rtl92de_llt_table_init(struct ieee80211_hw *hw)
 	/* config this MAC as two MAC transfer. */
 	/* Otherwise used as local loopback buffer.  */
 	for (i = txpktbuf_bndy; i < maxpage; i++) {
-		status = rtl92de_llt_write(hw, i, (i + 1));
+		status = rtl92d_llt_write(hw, i, (i + 1));
 		if (!status)
 			return status;
 	}
 
 	/* Let last entry point to the start entry of ring buffer */
-	status = rtl92de_llt_write(hw, maxpage, txpktbuf_bndy);
+	status = rtl92d_llt_write(hw, maxpage, txpktbuf_bndy);
 	if (!status)
 		return status;
 
@@ -688,7 +688,7 @@ int rtl92de_hw_init(struct ieee80211_hw *hw)
 
 	/* reset hw sec */
 	rtl_cam_reset_all_entry(hw);
-	rtl92de_enable_hw_security_config(hw);
+	rtl92d_enable_hw_security_config(hw);
 
 	/* Read EEPROM TX power index and PHY_REG_PG.txt to capture correct */
 	/* TX power index for different rate set. */
@@ -742,11 +742,11 @@ static int _rtl92de_set_media_status(struct ieee80211_hw *hw,
 
 	if (type == NL80211_IFTYPE_UNSPECIFIED ||
 	    type == NL80211_IFTYPE_STATION) {
-		rtl92de_stop_tx_beacon(hw);
+		rtl92d_stop_tx_beacon(hw);
 		_rtl92de_enable_bcn_sub_func(hw);
 	} else if (type == NL80211_IFTYPE_ADHOC ||
 		type == NL80211_IFTYPE_AP) {
-		rtl92de_resume_tx_beacon(hw);
+		rtl92d_resume_tx_beacon(hw);
 		_rtl92de_disable_bcn_sub_func(hw);
 	} else {
 		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
index 5f6311c2aac4..f5ce4889523e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
@@ -187,7 +187,7 @@ static void rtl92d_deinit_sw_vars(struct ieee80211_hw *hw)
 static struct rtl_hal_ops rtl8192de_hal_ops = {
 	.init_sw_vars = rtl92d_init_sw_vars,
 	.deinit_sw_vars = rtl92d_deinit_sw_vars,
-	.read_eeprom_info = rtl92de_read_eeprom_info,
+	.read_eeprom_info = rtl92d_read_eeprom_info,
 	.interrupt_recognized = rtl92de_interrupt_recognized,
 	.hw_init = rtl92de_hw_init,
 	.hw_disable = rtl92de_card_disable,
@@ -197,30 +197,30 @@ static struct rtl_hal_ops rtl8192de_hal_ops = {
 	.disable_interrupt = rtl92de_disable_interrupt,
 	.set_network_type = rtl92de_set_network_type,
 	.set_chk_bssid = rtl92de_set_check_bssid,
-	.set_qos = rtl92de_set_qos,
+	.set_qos = rtl92d_set_qos,
 	.set_bcn_reg = rtl92de_set_beacon_related_registers,
 	.set_bcn_intv = rtl92de_set_beacon_interval,
 	.update_interrupt_mask = rtl92de_update_interrupt_mask,
 	.get_hw_reg = rtl92de_get_hw_reg,
 	.set_hw_reg = rtl92de_set_hw_reg,
-	.update_rate_tbl = rtl92de_update_hal_rate_tbl,
+	.update_rate_tbl = rtl92d_update_hal_rate_tbl,
 	.fill_tx_desc = rtl92de_tx_fill_desc,
 	.fill_tx_cmddesc = rtl92de_tx_fill_cmddesc,
-	.query_rx_desc = rtl92de_rx_query_desc,
-	.set_channel_access = rtl92de_update_channel_access_setting,
-	.radio_onoff_checking = rtl92de_gpio_radio_on_off_checking,
+	.query_rx_desc = rtl92d_rx_query_desc,
+	.set_channel_access = rtl92d_update_channel_access_setting,
+	.radio_onoff_checking = rtl92d_gpio_radio_on_off_checking,
 	.set_bw_mode = rtl92d_phy_set_bw_mode,
 	.switch_channel = rtl92d_phy_sw_chnl,
 	.dm_watchdog = rtl92de_dm_watchdog,
 	.scan_operation_backup = rtl_phy_scan_operation_backup,
 	.set_rf_power_state = rtl92d_phy_set_rf_power_state,
 	.led_control = rtl92de_led_control,
-	.set_desc = rtl92de_set_desc,
-	.get_desc = rtl92de_get_desc,
+	.set_desc = rtl92d_set_desc,
+	.get_desc = rtl92d_get_desc,
 	.is_tx_desc_closed = rtl92de_is_tx_desc_closed,
 	.tx_polling = rtl92de_tx_polling,
-	.enable_hw_sec = rtl92de_enable_hw_security_config,
-	.set_key = rtl92de_set_key,
+	.enable_hw_sec = rtl92d_enable_hw_security_config,
+	.set_key = rtl92d_set_key,
 	.get_bbreg = rtl92d_phy_query_bb_reg,
 	.set_bbreg = rtl92d_phy_set_bb_reg,
 	.get_rfreg = rtl92d_phy_query_rf_reg,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index 2b9b352f7783..91bf399c9ef1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -292,7 +292,7 @@ bool rtl92de_is_tx_desc_closed(struct ieee80211_hw *hw,
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl8192_tx_ring *ring = &rtlpci->tx_ring[hw_queue];
 	u8 *entry = (u8 *)(&ring->desc[ring->idx]);
-	u8 own = (u8)rtl92de_get_desc(hw, entry, true, HW_DESC_OWN);
+	u8 own = (u8)rtl92d_get_desc(hw, entry, true, HW_DESC_OWN);
 
 	/* a beacon packet will only use the first
 	 * descriptor by defaut, and the own bit may not
-- 
2.45.1


