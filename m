Return-Path: <linux-wireless+bounces-16972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6922F9FF493
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 17:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B283A1AD7
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9631E1C33;
	Wed,  1 Jan 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAuLER+r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933B863D
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735749515; cv=none; b=hMy7zRK/9lqY0H2Lc+xj1bCUIi4LVuOx+RCimMxlZGup00KWO42Q+5EN6SsSN5EqfY7dq7W2UxaqOR/Hj4vk+AO7V4OTjOCnBX19KrzqU97n95i71mgZLvrybOc/EZ3KCHs97R8Zp3mLjihCDv25+4L//KxwKffcXr63M8w7tiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735749515; c=relaxed/simple;
	bh=459p/kKtvW7t3Biy1j9QQyzjKkIaotvCXg5V9EgcnXk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dFs1pH9eZ0CfxeawpkLFQ+rKgZo5/idUzJOiaxKk8MdD431N35zLbNpZWrcMk4dm7wePAQCYoATWEQ+oHopYhR9zx33SESMNEBYbOiYX65Xwo1oyikhLiz5BLAjYySn9lagVLhMjeCieujEOr1a1jKBOwPKDy0gQfoesS/J7xtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAuLER+r; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so14884322a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jan 2025 08:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735749512; x=1736354312; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM1yIPQXijrU9hwiTYFhMnDPClkwU1WvUyiNtZhKCIA=;
        b=KAuLER+rBwxkFbaY+QrCwQHGfJ69o1TLWjIScZXZrKnPVdDW57mlBV9eD52U+nLpTC
         p8lGuPrE8EMzOi5iJxLW7r3+OCGufoeb1CpxF/aHECNRwXhT7m1feePU4jUaAXBxosdC
         r7tF8kPbakp7DePBgUBY/o36S/Nml/BZB8/uBqmxmWKDMNqXIR93NqdULR8UCQMtG5Oh
         1Oe8wf1YlNaJFrbUxLfvEBvtymmj6+hQYB/7F7/iPJezORqDcGIO7W3zzLq5zrDOgW2e
         ITap+eKYqBqdXrFn+yiIQ+igB77RXJwpbsXyvjt1w9C7iBJEnGF2MHaf5JHF28mDYtkf
         kOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735749512; x=1736354312;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JM1yIPQXijrU9hwiTYFhMnDPClkwU1WvUyiNtZhKCIA=;
        b=wjaLFRnlRmtcqJpT6D3RTwx4oDo8XawTJ1nvIXBEUCVGaxnnop0PmoF6w7eyYZTJx2
         NNlFoqFA+WSkQey8wHWPZp7HSHWoxOU+hG/G+T+CDxJlYa4U5jcW1N4XX8Us7OsfqvT9
         fOHRSaJkF6Z7rfh1eiB2McOIH86pCakT5NxNqiIdr3Nz2gpqRITWelLDQ38Uz4zRIOVQ
         m1JzUm0OFycLjhLp1Acjwgz+mJslXbWTyKTHf7pPb6DxLE+9271Ti+oGhsujfGPg2/YE
         MtrJhlciXLEKyeNU0+Vf1FofALRGUPREUAtaOlqD30Cl09eBaWEKYGnbYbvLHrYNinl+
         hg/A==
X-Gm-Message-State: AOJu0YzvA9OpSpmJqC9n83owpg3OGcde3jdsMZ2WdG9LZUm3iyvMSSA4
	DQu29p+Z0mwaADINXvsywbWtJ8D+gqhISFKKX+ua8NA6sf21fBnvStS8ug==
X-Gm-Gg: ASbGncupDp2irDr9QczMVIFirKqOBmjLzx5PkpfK2eAiiezIGK8rvRYqQyLG8ZvddZc
	tGJzOxcVMg4DPazCvJjAQNRQUbH+iwm8ZtBHW7KL9850FPvyt6/K2iFvi+BFP3eckw/VbVD8vBJ
	rP3dljRx9Ofqfit8gB5xe+JDzl8PnwDsNa5NCDflll7rrxLDy5u81nA00X1/9z4TPHWJCDrVpjC
	N9yEPzXMBHF9/MnqEnXxFWzp1TK4NOTyeWMltGBMrmPbv3dHiyDL2TKqGvRVRkT
X-Google-Smtp-Source: AGHT+IFI+DD8z6NkoVUW4R3qNt6GHAqVPfUMfsoDsEWa3WLccW0MYIEuGvcjdPLwvfJxTz5oMxDOJA==
X-Received: by 2002:a05:6402:3224:b0:5d0:d3eb:a78f with SMTP id 4fb4d7f45d1cf-5d81dc79cadmr104344137a12.0.1735749511625;
        Wed, 01 Jan 2025 08:38:31 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82ede9sm1681389266b.2.2025.01.01.08.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2025 08:38:31 -0800 (PST)
Message-ID: <1dfa20d1-5fee-4e75-a2db-a59d723babe2@gmail.com>
Date: Wed, 1 Jan 2025 18:38:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: Add support for LED blinking
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Register a struct led_classdev with the kernel's LED subsystem and
create a throughput-based trigger for it. Then mac80211 makes the LED
blink.

Tested with Tenda U12 (RTL8812AU), Tenda U9 (RTL8811CU), TP-Link Archer
T2U Nano (RTL8811AU), TP-Link Archer T3U Plus (RTL8812BU), Edimax
EW-7611UCB (RTL8821AU), LM842 (RTL8822CU).

Also tested with devices which don't have LEDs: the laptop's internal
RTL8822CE and a no-name RTL8723DU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     | 91 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  9 ++
 drivers/net/wireless/realtek/rtw88/reg.h      | 12 +++
 drivers/net/wireless/realtek/rtw88/rtw8812a.c | 23 +++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.c | 32 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 25 +++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 25 +++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 25 +++++
 8 files changed, 240 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 6993f93c8f06..387940839f8b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2221,6 +2221,86 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw_core_deinit);
 
+#ifdef CONFIG_LEDS_CLASS
+
+static int rtw_led_set_blocking(struct led_classdev *led,
+				enum led_brightness brightness)
+{
+	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
+
+	rtwdev->chip->ops->led_set(led, brightness);
+
+	return 0;
+}
+
+static void rtw_led_init(struct rtw_dev *rtwdev)
+{
+	static const struct ieee80211_tpt_blink rtw_tpt_blink[] = {
+		{ .throughput = 0 * 1024, .blink_time = 334 },
+		{ .throughput = 1 * 1024, .blink_time = 260 },
+		{ .throughput = 5 * 1024, .blink_time = 220 },
+		{ .throughput = 10 * 1024, .blink_time = 190 },
+		{ .throughput = 20 * 1024, .blink_time = 170 },
+		{ .throughput = 50 * 1024, .blink_time = 150 },
+		{ .throughput = 70 * 1024, .blink_time = 130 },
+		{ .throughput = 100 * 1024, .blink_time = 110 },
+		{ .throughput = 200 * 1024, .blink_time = 80 },
+		{ .throughput = 300 * 1024, .blink_time = 50 },
+	};
+	struct led_classdev *led = &rtwdev->led_cdev;
+	int err;
+
+	if (!rtwdev->chip->ops->led_set)
+		return;
+
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB)
+		led->brightness_set_blocking = rtw_led_set_blocking;
+	else
+		led->brightness_set = rtwdev->chip->ops->led_set;
+
+	snprintf(rtwdev->led_name, sizeof(rtwdev->led_name),
+		 "rtw88-%s", dev_name(rtwdev->dev));
+
+	led->name = rtwdev->led_name;
+	led->max_brightness = LED_ON;
+	led->default_trigger =
+		ieee80211_create_tpt_led_trigger(rtwdev->hw,
+						 IEEE80211_TPT_LEDTRIG_FL_RADIO,
+						 rtw_tpt_blink,
+						 ARRAY_SIZE(rtw_tpt_blink));
+
+	err = led_classdev_register(rtwdev->dev, led);
+	if (err) {
+		rtw_warn(rtwdev, "Failed to register the LED, error %d\n", err);
+		return;
+	}
+
+	rtwdev->led_registered = true;
+}
+
+static void rtw_led_deinit(struct rtw_dev *rtwdev)
+{
+	struct led_classdev *led = &rtwdev->led_cdev;
+
+	if (!rtwdev->led_registered)
+		return;
+
+	rtwdev->chip->ops->led_set(led, LED_OFF);
+	led_classdev_unregister(led);
+}
+
+#else
+
+static void rtw_led_init(struct rtw_dev *rtwdev)
+{
+}
+
+static void rtw_led_deinit(struct rtw_dev *rtwdev)
+{
+}
+
+#endif
+
 int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 {
 	bool sta_mode_only = rtwdev->hci.type == RTW_HCI_TYPE_SDIO;
@@ -2292,16 +2372,18 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 		return ret;
 	}
 
+	rtw_led_init(rtwdev);
+
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
 		rtw_err(rtwdev, "failed to register hw\n");
-		return ret;
+		goto led_deinit;
 	}
 
 	ret = rtw_regd_hint(rtwdev);
 	if (ret) {
 		rtw_err(rtwdev, "failed to hint regd\n");
-		return ret;
+		goto led_deinit;
 	}
 
 	rtw_debugfs_init(rtwdev);
@@ -2310,6 +2392,10 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	rtwdev->bf_info.bfer_su_cnt = 0;
 
 	return 0;
+
+led_deinit:
+	rtw_led_deinit(rtwdev);
+	return ret;
 }
 EXPORT_SYMBOL(rtw_register_hw);
 
@@ -2320,6 +2406,7 @@ void rtw_unregister_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	ieee80211_unregister_hw(hw);
 	rtw_unset_supported_band(hw, chip);
 	rtw_debugfs_deinit(rtwdev);
+	rtw_led_deinit(rtwdev);
 }
 EXPORT_SYMBOL(rtw_unregister_hw);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 6ba9e0dcf9fd..39ab3f8b4a47 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -887,6 +887,9 @@ struct rtw_chip_ops {
 			       bool is_tx2_path);
 	void (*config_txrx_mode)(struct rtw_dev *rtwdev, u8 tx_path,
 				 u8 rx_path, bool is_tx2_path);
+#ifdef CONFIG_LEDS_CLASS
+	void (*led_set)(struct led_classdev *led, enum led_brightness brightness);
+#endif
 	/* for USB/SDIO only */
 	void (*fill_txdesc_checksum)(struct rtw_dev *rtwdev,
 				     struct rtw_tx_pkt_info *pkt_info,
@@ -2097,6 +2100,12 @@ struct rtw_dev {
 	struct completion fw_scan_density;
 	bool ap_active;
 
+#ifdef CONFIG_LEDS_CLASS
+	bool led_registered;
+	char led_name[32];
+	struct led_classdev led_cdev;
+#endif
+
 	/* hci related data, must be last */
 	u8 priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 95a39ae74cd3..e438405fba56 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -78,7 +78,19 @@
 #define BIT_PAPE_SEL_EN		BIT(25)
 #define BIT_DPDT_WL_SEL		BIT(24)
 #define BIT_DPDT_SEL_EN		BIT(23)
+#define BIT_GPIO13_14_WL_CTRL_EN	BIT(22)
+#define BIT_LED2_SV		BIT(19)
+#define BIT_LED2_CM		GENMASK(18, 16)
+#define BIT_LED1_SV		BIT(11)
+#define BIT_LED1_CM		GENMASK(10, 8)
+#define BIT_LED0_SV		BIT(3)
+#define BIT_LED0_CM		GENMASK(2, 0)
+#define BIT_LED_MODE_SW_CTRL	0
+#define BIT_LED_MODE_RX		6
+#define BIT_LED_MODE_TX		4
+#define BIT_LED_MODE_TRX	2
 #define REG_LEDCFG2		0x004E
+#define REG_GPIO_PIN_CTRL_2	0x0060
 #define REG_PAD_CTRL1		0x0064
 #define BIT_BT_BTG_SEL		BIT(31)
 #define BIT_PAPE_WLBT_SEL	BIT(29)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812a.c b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
index 21795286a1a0..e16ba8d8a792 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
@@ -868,6 +868,26 @@ static void rtw8812a_pwr_track(struct rtw_dev *rtwdev)
 	dm_info->pwr_trk_triggered = false;
 }
 
+#ifdef CONFIG_LEDS_CLASS
+
+static void rtw8812a_led_set(struct led_classdev *led,
+			     enum led_brightness brightness)
+{
+	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
+	u8 ledcfg;
+
+	ledcfg = rtw_read8(rtwdev, REG_LED_CFG);
+	ledcfg &= BIT(6) | BIT(4);
+	ledcfg |= BIT(5);
+
+	if (brightness == LED_OFF)
+		ledcfg |= BIT(3);
+
+	rtw_write8(rtwdev, REG_LED_CFG, ledcfg);
+}
+
+#endif
+
 static void rtw8812a_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 					  struct rtw_tx_pkt_info *pkt_info,
 					  u8 *txdesc)
@@ -916,6 +936,9 @@ static const struct rtw_chip_ops rtw8812a_ops = {
 	.config_bfee		= NULL,
 	.set_gid_table		= NULL,
 	.cfg_csi_rate		= NULL,
+#ifdef CONFIG_LEDS_CLASS
+	.led_set		= rtw8812a_led_set,
+#endif
 	.fill_txdesc_checksum	= rtw8812a_fill_txdesc_checksum,
 	.coex_set_init		= rtw8812a_coex_cfg_init,
 	.coex_set_ant_switch	= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
index dafab2af33bc..62070843f2b0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
@@ -706,6 +706,35 @@ static void rtw8821a_pwr_track(struct rtw_dev *rtwdev)
 	dm_info->pwr_trk_triggered = false;
 }
 
+#ifdef CONFIG_LEDS_CLASS
+
+static void rtw8821a_led_set(struct led_classdev *led,
+			     enum led_brightness brightness)
+{
+	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
+	u32 gpio8_cfg;
+	u8 ledcfg;
+
+	if (brightness == LED_OFF) {
+		gpio8_cfg = rtw_read32(rtwdev, REG_GPIO_PIN_CTRL_2);
+		gpio8_cfg &= ~BIT(24);
+		gpio8_cfg |= BIT(16) | BIT(8);
+		rtw_write32(rtwdev, REG_GPIO_PIN_CTRL_2, gpio8_cfg);
+	} else {
+		ledcfg = rtw_read8(rtwdev, REG_LED_CFG + 2);
+		gpio8_cfg = rtw_read32(rtwdev, REG_GPIO_PIN_CTRL_2);
+
+		ledcfg &= BIT(7) | BIT(6);
+		rtw_write8(rtwdev, REG_LED_CFG + 2, ledcfg);
+
+		gpio8_cfg &= ~(BIT(24) | BIT(8));
+		gpio8_cfg |= BIT(16);
+		rtw_write32(rtwdev, REG_GPIO_PIN_CTRL_2, gpio8_cfg);
+	}
+}
+
+#endif
+
 static void rtw8821a_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 					  struct rtw_tx_pkt_info *pkt_info,
 					  u8 *txdesc)
@@ -853,6 +882,9 @@ static const struct rtw_chip_ops rtw8821a_ops = {
 	.config_bfee		= NULL,
 	.set_gid_table		= NULL,
 	.cfg_csi_rate		= NULL,
+#ifdef CONFIG_LEDS_CLASS
+	.led_set		= rtw8821a_led_set,
+#endif
 	.fill_txdesc_checksum	= rtw8821a_fill_txdesc_checksum,
 	.coex_set_init		= rtw8821a_coex_cfg_init,
 	.coex_set_ant_switch	= rtw8821a_coex_cfg_ant_switch,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 0270225b9c20..8c09cde96506 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1206,6 +1206,28 @@ static void rtw8821c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
 			 dm_info->cck_pd_default + new_lvl * 2);
 }
 
+#ifdef CONFIG_LEDS_CLASS
+
+static void rtw8821c_led_set(struct led_classdev *led,
+			     enum led_brightness brightness)
+{
+	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
+	u32 ledcfg;
+
+	ledcfg = rtw_read32(rtwdev, REG_LED_CFG);
+	u32p_replace_bits(&ledcfg, BIT_LED_MODE_SW_CTRL, BIT_LED2_CM);
+	ledcfg &= ~BIT_GPIO13_14_WL_CTRL_EN;
+
+	if (brightness == LED_OFF)
+		ledcfg |= BIT_LED2_SV;
+	else
+		ledcfg &= ~BIT_LED2_SV;
+
+	rtw_write32(rtwdev, REG_LED_CFG, ledcfg);
+}
+
+#endif
+
 static void rtw8821c_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 					  struct rtw_tx_pkt_info *pkt_info,
 					  u8 *txdesc)
@@ -1655,6 +1677,9 @@ static const struct rtw_chip_ops rtw8821c_ops = {
 	.config_bfee		= rtw8821c_bf_config_bfee,
 	.set_gid_table		= rtw_bf_set_gid_table,
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
+#ifdef CONFIG_LEDS_CLASS
+	.led_set		= rtw8821c_led_set,
+#endif
 	.fill_txdesc_checksum	= rtw8821c_fill_txdesc_checksum,
 
 	.coex_set_init		= rtw8821c_coex_cfg_init,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 739809f4cab5..580e418a3fdd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1566,6 +1566,28 @@ static void rtw8822b_adaptivity(struct rtw_dev *rtwdev)
 	rtw_phy_set_edcca_th(rtwdev, l2h, h2l);
 }
 
+#ifdef CONFIG_LEDS_CLASS
+
+static void rtw8822b_led_set(struct led_classdev *led,
+			     enum led_brightness brightness)
+{
+	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
+	u32 ledcfg;
+
+	ledcfg = rtw_read32(rtwdev, REG_LED_CFG);
+	u32p_replace_bits(&ledcfg, BIT_LED_MODE_SW_CTRL, BIT_LED2_CM);
+	ledcfg &= ~BIT_GPIO13_14_WL_CTRL_EN;
+
+	if (brightness == LED_OFF)
+		ledcfg |= BIT_LED2_SV;
+	else
+		ledcfg &= ~BIT_LED2_SV;
+
+	rtw_write32(rtwdev, REG_LED_CFG, ledcfg);
+}
+
+#endif
+
 static void rtw8822b_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 					  struct rtw_tx_pkt_info *pkt_info,
 					  u8 *txdesc)
@@ -2146,6 +2168,9 @@ static const struct rtw_chip_ops rtw8822b_ops = {
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
 	.adaptivity_init	= rtw8822b_adaptivity_init,
 	.adaptivity		= rtw8822b_adaptivity,
+#ifdef CONFIG_LEDS_CLASS
+	.led_set		= rtw8822b_led_set,
+#endif
 	.fill_txdesc_checksum	= rtw8822b_fill_txdesc_checksum,
 
 	.coex_set_init		= rtw8822b_coex_cfg_init,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index af6b76937f1d..8feede61cd11 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4537,6 +4537,28 @@ static void rtw8822c_adaptivity(struct rtw_dev *rtwdev)
 	rtw_phy_set_edcca_th(rtwdev, l2h, h2l);
 }
 
+#ifdef CONFIG_LEDS_CLASS
+
+static void rtw8822c_led_set(struct led_classdev *led,
+			     enum led_brightness brightness)
+{
+	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
+	u32 ledcfg;
+
+	ledcfg = rtw_read32(rtwdev, REG_LED_CFG);
+	u32p_replace_bits(&ledcfg, BIT_LED_MODE_SW_CTRL, BIT_LED2_CM);
+	ledcfg &= ~BIT_GPIO13_14_WL_CTRL_EN;
+
+	if (brightness == LED_OFF)
+		ledcfg |= BIT_LED2_SV;
+	else
+		ledcfg &= ~BIT_LED2_SV;
+
+	rtw_write32(rtwdev, REG_LED_CFG, ledcfg);
+}
+
+#endif
+
 static void rtw8822c_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 					  struct rtw_tx_pkt_info *pkt_info,
 					  u8 *txdesc)
@@ -4964,6 +4986,9 @@ static const struct rtw_chip_ops rtw8822c_ops = {
 	.cfo_track		= rtw8822c_cfo_track,
 	.config_tx_path		= rtw8822c_config_tx_path,
 	.config_txrx_mode	= rtw8822c_config_trx_mode,
+#ifdef CONFIG_LEDS_CLASS
+	.led_set		= rtw8822c_led_set,
+#endif
 	.fill_txdesc_checksum	= rtw8822c_fill_txdesc_checksum,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,

base-commit: 104372ff359486b26b5a2db33b8e1dc6bfb39812
prerequisite-patch-id: ffa5686d26c03c3bd942dd0e0c4e85d6cc1141c0
prerequisite-patch-id: 5fe117f3707ee7525549baaeea323157019be897
prerequisite-patch-id: f733af9c741a3e02f8dd374a402da4b07c51f97a
prerequisite-patch-id: 26c5a5c5739a581686f97ff17916b9c641a0d189
prerequisite-patch-id: 73580f2822eceab5e3a1d7291beebd362b9af45f
prerequisite-patch-id: ebd38e2e7e1f7731046d8641dbaaa2bcc9a385fe
prerequisite-patch-id: ebc85d1f7996a01b46f27e78dc6ebfb5c5a8c013
prerequisite-patch-id: 4cb1a033c2beec35dfbee0cddb8c8d1df80f2994
prerequisite-patch-id: 3887710d4f2069a49bdeb35d6e17144fe9da9c84
prerequisite-patch-id: 6b23ff2c45082cbce357c8547e5582455b160649
-- 
2.47.1


