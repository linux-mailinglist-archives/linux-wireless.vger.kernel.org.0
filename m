Return-Path: <linux-wireless+bounces-6576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCDC8AAF88
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3201F21518
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305B2128366;
	Fri, 19 Apr 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvFzv0dw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E291E867
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533971; cv=none; b=Nw9ciP/VqQwSYco16Aloo8LqWeAiI+ua1Y4+GacErpyq8HB3RmJ7Y7sqzUGh0UMfQ4HXsy/jzBL/mrEem+LKlvdtgiQpcJWbI5OcBvLw7FnbPEq1LjIKR8nAYeV6xRk2tcchDs+DB32kMVsdCSvNC4d7gA6lgr/4k/SeI426xtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533971; c=relaxed/simple;
	bh=0wYVxlp1NrRdpRqjAsQwiMqTCKDoM52S/gxZsxX3ruU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tbhCihNMuTIKAxj+S0HcZCz7J1tmf+E5NZ4+aD5yA2eQk92BynJHSlhlz7JFJcGrUVEJbG+pqAU6ahCB5A6fcZmG9MiLMMkAnXwgwIyaUXaqiMNYeiXXRHBPn4qwJOMoqKY4QWS7FXIO6tB2mSx1pilaAmxxKYHMf5qAy67vqb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvFzv0dw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a556d22fa93so242813366b.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713533967; x=1714138767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zXtkYlVyWLheVTtcondXbeYx/586TWa7N50UTSr/c6A=;
        b=FvFzv0dwUYzpRY3k8GO4rU70W5ulccyXMHfCElVaPGyQIGPT4NlkMv+DV6sHaHDNSP
         H/ZKaVarzkntuxYvykFgMwWcMyNvcu2G8o5VynKcHvqqlhk3r0OpEL/Hv7qS9GtwdfiI
         7dNuPl/G5Uw1crpvOv+N/f8GndnJnilkc0JFuYaV7DjuaEfjVgoWexLDWhyEP96DY15m
         1lh3Q0RUXWDWWWBxGw5dkGMR6Ff11cKlAFDKL2/BIqH8YG86VbAH2esD/UsW//uTZg2f
         It+ZsC9bZ6y2Fxw0EricnWzmkaoWJRk5I9CmJbM3eInrMGnom9t59nGyXUxqlhKeLMPH
         ygCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713533967; x=1714138767;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXtkYlVyWLheVTtcondXbeYx/586TWa7N50UTSr/c6A=;
        b=AVCnSwWul95QLspmM7ZNL8mu06+O8p+CYsbn9V+Zll/koZ4TS+1d55C71nWizd4Ahd
         UcEEwmuWRTae2rrgFMpqS14hGpHIZugi/ifDbtt4juqk+6BFk/TxIF3BelQMpTMxsr14
         EYlX41KK6p/HFijolWGctWMTSNMdqv4jaZsaZtp1MwO34kJqvnKGUsKmtnyulwjvCPIv
         U+RY/ri3CWNzN/cEtjLeu5ohfQewJkZnXgJ0ygBmyRdBMHDWYwPZdfPOecwMi8QLoP74
         MYsZOEEN4Q/UED3Sl3M+wwkQ3qEzYtpeEx74bG6a9oEU8abYKJwNSZDN2dz4PLemp3Bx
         rGKQ==
X-Gm-Message-State: AOJu0YzHCX2ahW91U92/h9S8wGyONInxvtA39r0Cpba7iulQLPQ+3W04
	eJd/YUlMaUhEcFw0Ydq6FM10CTK1IptK59r3zbsIRrTKaeCru2NKfv6vwmuC
X-Google-Smtp-Source: AGHT+IEt2z//eZ+CxXqnCc3eqDt7Gg/N0744e4Mw1RFBMM6RwYD52fqjfowTHNUAyUM47wCPu7hUBg==
X-Received: by 2002:a17:907:3d92:b0:a52:3efe:88d3 with SMTP id he18-20020a1709073d9200b00a523efe88d3mr1727084ejc.67.1713533966593;
        Fri, 19 Apr 2024 06:39:26 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090648c700b00a5195edf8e8sm2223589ejt.62.2024.04.19.06.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 06:39:26 -0700 (PDT)
Message-ID: <45848eb2-9c52-4aac-b7b0-b584955e41d7@gmail.com>
Date: Fri, 19 Apr 2024 16:39:25 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 6/6] wifi: rtlwifi: Adjust rtl8192d-common for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
Content-Language: en-US
In-Reply-To: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A few of the shared functions need small changes for the USB driver:
 - firmware loading
 - efuse reading
 - rate mask updating
 - rf register reading
 - initial gain for scanning

Also, add a few macros to wifi.h and initialise rtlhal.interfaceindex
for USB devices.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v6:
 - Remove the things added to struct rtl_priv in v4 of this patch.
   They will be added in a later patch.

v5:
 - No change.

v4:
 - Update the commit message.
 - Move _rtl92d_pci_lock and _rtl92d_pci_unlock to phy_common.h to
   silence a checkpatch warning.
 - Move rate_mask declaration higher (sorted by length).
 - Add some bit definitions to reg.h.
 - Add to struct rtl_priv the things shared by the two USB interfaces
   of a dual MAC RTL8192DU:
	u32 *curveindex_2g;
	u32 *curveindex_5g;
	struct mutex *mutex_for_power_on_off;
	struct mutex *mutex_for_hw_init;

v3:
 - Silence sparse warnings about locks in phy_common.c by using helper
   functions _rtl92d_pci_lock() and _rtl92d_pci_unlock().

v2:
 - Delete the macro IS_NORMAL_CHIP. It wasn't actually used.
 - Add RTL_USB_DELAY_FACTOR macro.
 - Use FEN_CPUEN macro.
 - Make params_pci and params_usb arrays static const, and make
   rtl_get_hwinfo() take a const pointer.
 - Put the rate mask, macid, etc. in a struct in
   rtl92de_update_hal_rate_mask().
 - Use sizeof(rtlpriv->rate_mask) in memcpy instead of hardcoded 5.
 - Rename temp variable to phy_ctrl.
 - Define _TXDMA_*_MAP and _HPQ, _LPQ, _PUBQ macros using GENMASK and
   remove the leading underscore.
 - Delete _NPQ macro because it's not very useful.
---
 drivers/net/wireless/realtek/rtlwifi/efuse.c  |   2 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.h  |   2 +-
 .../realtek/rtlwifi/rtl8192d/fw_common.c      |  23 ++-
 .../realtek/rtlwifi/rtl8192d/fw_common.h      |  10 ++
 .../realtek/rtlwifi/rtl8192d/hw_common.c      |  53 ++++--
 .../realtek/rtlwifi/rtl8192d/phy_common.c     |  22 ++-
 .../realtek/rtlwifi/rtl8192d/phy_common.h     |  24 +++
 .../wireless/realtek/rtlwifi/rtl8192d/reg.h   | 160 +++++++++++++++---
 drivers/net/wireless/realtek/rtlwifi/usb.c    |   3 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |   5 +
 10 files changed, 260 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.c b/drivers/net/wireless/realtek/rtlwifi/efuse.c
index c1fbc29d5ca1..82cf5fb5175f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
+++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
@@ -1211,7 +1211,7 @@ static u8 efuse_calculate_word_cnts(u8 word_en)
 }
 
 int rtl_get_hwinfo(struct ieee80211_hw *hw, struct rtl_priv *rtlpriv,
-		   int max_size, u8 *hwinfo, int *params)
+		   int max_size, u8 *hwinfo, const int *params)
 {
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	struct rtl_pci_priv *rtlpcipriv = rtl_pcipriv(hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.h b/drivers/net/wireless/realtek/rtlwifi/efuse.h
index 4821625ad1e5..e250ffb0f4b2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/efuse.h
+++ b/drivers/net/wireless/realtek/rtlwifi/efuse.h
@@ -89,7 +89,7 @@ void efuse_force_write_vendor_id(struct ieee80211_hw *hw);
 void efuse_re_pg_section(struct ieee80211_hw *hw, u8 section_idx);
 void efuse_power_switch(struct ieee80211_hw *hw, u8 write, u8 pwrstate);
 int rtl_get_hwinfo(struct ieee80211_hw *hw, struct rtl_priv *rtlpriv,
-		   int max_size, u8 *hwinfo, int *params);
+		   int max_size, u8 *hwinfo, const int *params);
 void rtl_fill_dummy(u8 *pfwbuf, u32 *pfwlen);
 void rtl_fw_page_write(struct ieee80211_hw *hw, u32 page, u8 *buffer,
 		       u32 size);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
index ecdbe3cd5161..aa54dbde6ea8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
@@ -98,24 +98,45 @@ int rtl92d_fw_free_to_go(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL_GPL(rtl92d_fw_free_to_go);
 
+#define RTL_USB_DELAY_FACTOR		60
+
 void rtl92d_firmware_selfreset(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	u8 u1b_tmp;
 	u8 delay = 100;
 
+	if (rtlhal->interface == INTF_USB) {
+		delay *= RTL_USB_DELAY_FACTOR;
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
 
-	while (u1b_tmp & BIT(2)) {
+	while (u1b_tmp & (FEN_CPUEN >> 8)) {
 		delay--;
 		if (delay == 0)
 			break;
 		udelay(50);
 		u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
 	}
+
+	if (rtlhal->interface == INTF_USB) {
+		if ((u1b_tmp & (FEN_CPUEN >> 8)) && delay == 0)
+			rtl_write_byte(rtlpriv, REG_FWIMR, 0);
+	}
+
 	WARN_ONCE((delay <= 0), "rtl8192de: 8051 reset failed!\n");
 	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
 		"=====> 8051 reset success (%d)\n", delay);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
index 4e8e2b716f88..4b73e0bd4ac4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
@@ -25,6 +25,16 @@
 #define GET_FIRMWARE_HDR_SUB_VER(__fwhdr)		\
 	le32_get_bits(*(__le32 *)((__fwhdr) + 4), GENMASK(23, 16))
 
+#define RAID_MASK               GENMASK(31, 28)
+#define RATE_MASK_MASK          GENMASK(27, 0)
+#define SHORT_GI_MASK           BIT(5)
+#define MACID_MASK              GENMASK(4, 0)
+
+struct rtl92d_rate_mask_h2c {
+	__le32 rate_mask_and_raid;
+	u8 macid_and_short_gi;
+} __packed;
+
 bool rtl92d_is_fw_downloaded(struct rtl_priv *rtlpriv);
 void rtl92d_enable_fw_download(struct ieee80211_hw *hw, bool enable);
 void rtl92d_write_fw(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
index 40aadb9c4609..73e8fd0212d7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
@@ -618,9 +618,14 @@ static void _rtl92de_read_macphymode_from_prom(struct ieee80211_hw *hw,
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
@@ -659,6 +664,7 @@ static void _rtl92de_efuse_update_chip_version(struct ieee80211_hw *hw)
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "D-CUT!!!\n");
 		break;
 	case 0xCC33:
+	case 0x33CC:
 		chipver |= CHIP_92D_E_CUT;
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "E-CUT!!!\n");
 		break;
@@ -672,15 +678,27 @@ static void _rtl92de_efuse_update_chip_version(struct ieee80211_hw *hw)
 
 static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
 {
+	static const int params_pci[] = {
+		RTL8190_EEPROM_ID, EEPROM_VID, EEPROM_DID,
+		EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR_MAC0_92D,
+		EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
+		COUNTRY_CODE_WORLD_WIDE_13
+	};
+	static const int params_usb[] = {
+		RTL8190_EEPROM_ID, EEPROM_VID_USB, EEPROM_PID_USB,
+		EEPROM_VID_USB, EEPROM_PID_USB, EEPROM_MAC_ADDR_MAC0_92DU,
+		EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
+		COUNTRY_CODE_WORLD_WIDE_13
+	};
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	int params[] = {RTL8190_EEPROM_ID, EEPROM_VID, EEPROM_DID,
-			EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR_MAC0_92D,
-			EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
-			COUNTRY_CODE_WORLD_WIDE_13};
+	const int *params = params_pci;
 	u8 *hwinfo;
 
+	if (rtlhal->interface == INTF_USB)
+		params = params_usb;
+
 	hwinfo = kzalloc(HWSET_MAX_SIZE, GFP_KERNEL);
 	if (!hwinfo)
 		return;
@@ -842,6 +860,7 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	struct rtl_sta_info *sta_entry = NULL;
+	struct rtl92d_rate_mask_h2c rate_mask;
 	enum wireless_mode wirelessmode;
 	bool shortgi = false;
 	u8 curshortgi_40mhz;
@@ -849,7 +868,6 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 	u8 curtxbw_40mhz;
 	u32 ratr_bitmap;
 	u8 ratr_index;
-	u32 value[2];
 	u8 macid = 0;
 	u8 mimo_ps;
 
@@ -965,12 +983,20 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 		break;
 	}
 
-	value[0] = (ratr_bitmap & 0x0fffffff) | (ratr_index << 28);
-	value[1] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
+	le32p_replace_bits(&rate_mask.rate_mask_and_raid, ratr_bitmap, RATE_MASK_MASK);
+	le32p_replace_bits(&rate_mask.rate_mask_and_raid, ratr_index, RAID_MASK);
+	u8p_replace_bits(&rate_mask.macid_and_short_gi, macid, MACID_MASK);
+	u8p_replace_bits(&rate_mask.macid_and_short_gi, shortgi, SHORT_GI_MASK);
+	u8p_replace_bits(&rate_mask.macid_and_short_gi, 1, BIT(7));
+
 	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
-		"ratr_bitmap :%x value0:%x value1:%x\n",
-		ratr_bitmap, value[0], value[1]);
-	rtl92d_fill_h2c_cmd(hw, H2C_RA_MASK, 5, (u8 *)value);
+		"Rate_index:%x, ratr_val:%x, %5phC\n",
+		ratr_index, ratr_bitmap, &rate_mask);
+	memcpy(rtlpriv->rate_mask, &rate_mask, sizeof(rtlpriv->rate_mask));
+	/* rtl92d_fill_h2c_cmd() does USB I/O and will result in a
+	 * "scheduled while atomic" if called directly
+	 */
+	schedule_work(&rtlpriv->works.fill_h2c_cmd);
 	if (macid != 0)
 		sta_entry->ratr_index = ratr_index;
 }
@@ -1014,7 +1040,8 @@ bool rtl92de_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 	bool actuallyset = false;
 	unsigned long flag;
 
-	if (rtlpci->being_init_adapter)
+	if (rtlpriv->rtlhal.interface == INTF_PCI &&
+	    rtlpci->being_init_adapter)
 		return false;
 	if (ppsc->swrf_processing)
 		return false;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
index dbc8ea39d6fc..228c84ab5b90 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
@@ -89,11 +89,11 @@ u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		regaddr, rfpath, bitmask);
-	spin_lock(&rtlpriv->locks.rf_lock);
+	rtl92d_pci_lock(rtlpriv);
 	original_value = _rtl92d_phy_rf_serial_read(hw, rfpath, regaddr);
 	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
-	spin_unlock(&rtlpriv->locks.rf_lock);
+	rtl92d_pci_unlock(rtlpriv);
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
 		regaddr, rfpath, bitmask, original_value);
@@ -113,7 +113,7 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 		regaddr, bitmask, data, rfpath);
 	if (bitmask == 0)
 		return;
-	spin_lock(&rtlpriv->locks.rf_lock);
+	rtl92d_pci_lock(rtlpriv);
 	if (rtlphy->rf_mode != RF_OP_BY_FW) {
 		if (bitmask != RFREG_OFFSET_MASK) {
 			original_value = _rtl92d_phy_rf_serial_read(hw,
@@ -125,7 +125,7 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 		}
 		_rtl92d_phy_rf_serial_write(hw, rfpath, regaddr, data);
 	}
-	spin_unlock(&rtlpriv->locks.rf_lock);
+	rtl92d_pci_unlock(rtlpriv);
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		regaddr, bitmask, data, rfpath);
@@ -650,6 +650,8 @@ static void rtl92d_phy_set_io(struct ieee80211_hw *hw)
 	case IO_CMD_PAUSE_DM_BY_SCAN:
 		rtlphy->initgain_backup.xaagccore1 = de_digtable->cur_igvalue;
 		de_digtable->cur_igvalue = 0x37;
+		if (rtlpriv->rtlhal.interface == INTF_USB)
+			de_digtable->cur_igvalue = 0x17;
 		rtl92d_dm_write_dig(hw);
 		break;
 	default:
@@ -710,22 +712,28 @@ void rtl92d_phy_config_macphymode(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	u8 offset = REG_MAC_PHY_CTRL_NORMAL;
+	u8 phy_ctrl = 0xf0;
+
+	if (rtlhal->interface == INTF_USB) {
+		phy_ctrl = rtl_read_byte(rtlpriv, offset);
+		phy_ctrl &= ~(BIT(0) | BIT(1) | BIT(2));
+	}
 
 	switch (rtlhal->macphymode) {
 	case DUALMAC_DUALPHY:
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 			"MacPhyMode: DUALMAC_DUALPHY\n");
-		rtl_write_byte(rtlpriv, offset, 0xF3);
+		rtl_write_byte(rtlpriv, offset, phy_ctrl | BIT(0) | BIT(1));
 		break;
 	case SINGLEMAC_SINGLEPHY:
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 			"MacPhyMode: SINGLEMAC_SINGLEPHY\n");
-		rtl_write_byte(rtlpriv, offset, 0xF4);
+		rtl_write_byte(rtlpriv, offset, phy_ctrl | BIT(2));
 		break;
 	case DUALMAC_SINGLEPHY:
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 			"MacPhyMode: DUALMAC_SINGLEPHY\n");
-		rtl_write_byte(rtlpriv, offset, 0xF1);
+		rtl_write_byte(rtlpriv, offset, phy_ctrl | BIT(0));
 		break;
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
index f9b5d0d3a7e6..0f794557af47 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
@@ -32,6 +32,9 @@ static inline void rtl92d_acquire_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
+	if (rtlpriv->rtlhal.interface == INTF_USB)
+		return;
+
 	if (rtlpriv->rtlhal.interfaceindex == 1)
 		spin_lock_irqsave(&rtlpriv->locks.cck_and_rw_pagea_lock, *flag);
 }
@@ -41,6 +44,9 @@ static inline void rtl92d_release_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
+	if (rtlpriv->rtlhal.interface == INTF_USB)
+		return;
+
 	if (rtlpriv->rtlhal.interfaceindex == 1)
 		spin_unlock_irqrestore(&rtlpriv->locks.cck_and_rw_pagea_lock,
 				       *flag);
@@ -84,4 +90,22 @@ void rtl92d_acquire_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
 void rtl92d_release_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
 				       unsigned long *flag);
 
+/* Without these helpers and the declarations sparse warns about
+ * context imbalance.
+ */
+static inline void rtl92d_pci_lock(struct rtl_priv *rtlpriv)
+{
+	if (rtlpriv->rtlhal.interface == INTF_PCI)
+		spin_lock(&rtlpriv->locks.rf_lock);
+}
+
+static inline void rtl92d_pci_unlock(struct rtl_priv *rtlpriv)
+{
+	if (rtlpriv->rtlhal.interface == INTF_PCI)
+		spin_unlock(&rtlpriv->locks.rf_lock);
+}
+
+void rtl92d_pci_lock(struct rtl_priv *rtlpriv);
+void rtl92d_pci_unlock(struct rtl_priv *rtlpriv);
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h
index 1dc52abe3d0d..b5b906b799cb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h
@@ -52,6 +52,8 @@
 #define REG_HMEBOX_EXT_3		0x008E
 #define SIZE_OF_REG_HMEBOX_EXT		2
 
+#define REG_EFUSE_ACCESS		0x00CF
+
 #define REG_BIST_SCAN			0x00D0
 #define REG_BIST_RPT			0x00D4
 #define REG_BIST_ROM_RPT		0x00D8
@@ -87,6 +89,7 @@
 #define REG_CPWM			0x012F
 #define REG_FWIMR			0x0130
 #define REG_FWISR			0x0134
+#define REG_FTIMR			0x0138
 #define REG_PKTBUF_DBG_CTRL		0x0140
 #define REG_PKTBUF_DBG_DATA_L		0x0144
 #define REG_PKTBUF_DBG_DATA_H		0x0148
@@ -199,6 +202,8 @@
 #define REG_POWER_STAGE1		0x04B4
 #define REG_POWER_STAGE2		0x04B8
 #define REG_PKT_LIFE_TIME		0x04C0
+#define REG_PKT_VO_VI_LIFE_TIME		0x04C0
+#define REG_PKT_BE_BK_LIFE_TIME		0x04C2
 #define REG_STBC_SETTING		0x04C4
 #define REG_PROT_MODE_CTRL		0x04C8
 #define REG_MAX_AGGR_NUM		0x04CA
@@ -235,6 +240,7 @@
 #define REG_RD_NAV_NXT			0x0544
 #define REG_NAV_PROT_LEN		0x0546
 #define REG_BCN_CTRL			0x0550
+#define REG_BCN_CTRL_1			0x0551
 #define REG_MBID_NUM			0x0552
 #define REG_DUAL_TSF_RST		0x0553
 #define REG_BCN_INTERVAL		0x0554
@@ -321,6 +327,8 @@
 #define REG_BT_COEX_TABLE		0x06C0
 #define REG_WMAC_RESP_TXINFO		0x06D8
 
+#define REG_USB_Queue_Select_MAC0	0xFE44
+#define REG_USB_Queue_Select_MAC1	0xFE47
 
 /* ----------------------------------------------------- */
 /*	Redifine 8192C register definition for compatibility */
@@ -357,27 +365,27 @@
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
@@ -602,7 +610,11 @@
 #define EEPROM_SVID			0x2C /* SE Vendor ID.E-F */
 #define EEPROM_SMID			0x2E /* SE PCI Subsystem ID. 10-11 */
 
+#define EEPROM_VID_USB				0xC
+#define EEPROM_PID_USB				0xE
+#define EEPROM_ENDPOINT_SETTING			0x10
 #define EEPROM_MAC_ADDR			0x16 /* SEMAC Address. 12-17 */
+#define EEPROM_MAC_ADDR_MAC0_92DU		0x19
 #define EEPROM_MAC_ADDR_MAC0_92D	0x55
 #define EEPROM_MAC_ADDR_MAC1_92D	0x5B
 
@@ -917,6 +929,42 @@
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
+#define TXDMA_HIQ_MAP				GENMASK(15, 14)
+#define TXDMA_MGQ_MAP				GENMASK(13, 12)
+#define TXDMA_BKQ_MAP				GENMASK(11, 10)
+#define TXDMA_BEQ_MAP				GENMASK(9, 8)
+#define TXDMA_VIQ_MAP				GENMASK(7, 6)
+#define TXDMA_VOQ_MAP				GENMASK(5, 4)
+
+#define QUEUE_LOW				1
+#define QUEUE_NORMAL				2
+#define QUEUE_HIGH				3
+
+#define HPQ_MASK				GENMASK(7, 0)
+#define LPQ_MASK				GENMASK(15, 8)
+#define PUBQ_MASK				GENMASK(23, 16)
+#define LD_RQPN					BIT(31)
+
+#define DROP_DATA_EN				BIT(9)
+
 /* LLT_INIT */
 #define _LLT_NO_ACTIVE				0x0
 #define _LLT_WRITE_ACCESS			0x1
@@ -931,6 +979,10 @@
 /* ----------------------------------------------------- */
 /*	0x0400h ~ 0x047Fh	Protocol Configuration	 */
 /* ----------------------------------------------------- */
+/* FWHW_TXQ_CTRL */
+#define EN_AMPDU_RTY_NEW			BIT(7)
+#define EN_BCNQ_DL				BIT(22)
+
 #define	RETRY_LIMIT_SHORT_SHIFT			8
 #define	RETRY_LIMIT_LONG_SHIFT			0
 
@@ -944,6 +996,13 @@
 #define AC_PARAM_ECW_MIN_OFFSET			8
 #define AC_PARAM_AIFS_OFFSET			0
 
+/* REG_RD_CTRL */
+#define DIS_EDCA_CNT_DWN			BIT(11)
+
+/* REG_BCN_CTRL */
+#define EN_BCN_FUNCTION				BIT(3)
+#define DIS_TSF_UDT				BIT(4)
+
 /* ACMHWCTRL */
 #define	ACMHW_HWEN				BIT(0)
 #define	ACMHW_BEQEN				BIT(1)
@@ -1075,6 +1134,11 @@
 #define	RCCK0_FACOUNTERLOWER			0xa5c
 #define	RCCK0_FACOUNTERUPPER			0xa58
 
+#define	RPDP_ANTA				0xb00
+#define	RCONFIG_ANTA				0xb68
+#define	RCONFIG_ANTB				0xb6c
+#define	RPDP_ANTB				0xb70
+
 /* 6. PageC(0xC00) */
 #define	ROFDM0_LSTF				0xc00
 
@@ -1128,6 +1192,7 @@
 #define	ROFDM0_TXPSEUDONOISEWGT			0xce4
 #define	ROFDM0_FRAMESYNC			0xcf0
 #define	ROFDM0_DFSREPORT			0xcf4
+#define	ROFDM0_RXIQEXTANTA			0xca0
 #define	ROFDM0_TXCOEFF1				0xca4
 #define	ROFDM0_TXCOEFF2				0xca8
 #define	ROFDM0_TXCOEFF3				0xcac
@@ -1186,17 +1251,70 @@
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
index 098db85e381c..4f1c21c130f4 100644
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
2.44.0


