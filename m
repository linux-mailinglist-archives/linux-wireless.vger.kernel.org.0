Return-Path: <linux-wireless+bounces-20353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2FBA60252
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 21:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE8C167C56
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8AC157E88;
	Thu, 13 Mar 2025 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gidlHq2C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513A1F463B
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897138; cv=none; b=oThJSCVXBfn8KhIiILnJu6j2nmxmeCYn/Ac0+HyevNBdPaHWoTS18DjZvQUUOFkRUlFwJ4fz/rImM9NWPKujc/9oF42ePIvvswHj6YdC1uvxSS5AeI/dcuBVeYiG4SAE75UGDpnVQF4XXaTbhbyAHkdVvJKQphHH8nmiAzDkwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897138; c=relaxed/simple;
	bh=e37sf8/fT/rYGX+m5VGvL1kbqgaMRT6r35qL0p+keuY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G+h/4ANwyLIxHNW1xJi3L3xWjE/10l9T2R82pgnNGips4RbYDz+oY+Nhm7+RGqYNDEjoRyjDnIfavJR/LPSCRsGdmKDkXzGItdLC8lWUePTLNrLk4LjzFuLDuiZe3vKu/fAiO71Orwl2/SyIsrg3kYuUjPFDvRA78lYuhJu2DwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gidlHq2C; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so2285508a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 13:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897134; x=1742501934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dTENzkWxxIM8acUHka698+woGh2MOTam2MW4l72Z+bY=;
        b=gidlHq2CZtPclZetm1t0NVtEeX2KdqfODTJ9emZSW+imjs6/vcEUPE1CO2Y8SmTQUI
         oMKkAeh5eZ9b8bHooLLl8uYO0LW4jReF2mgOAl6BuPdZp2EpJYYicJSEJ1tMDwGb/gsl
         LNgfd9BWXxjiUB4QUzZJi6MTxIdXcxRCETQYNPeyFxWCrxcfh/KtiONLQ4rSeWRBDfdn
         i7EtcQoNr2MqGR8obBIOgZJTCORaYf+J1vaDeQKGxlz1iEa6XOij0OL+wmX7284cszT6
         5ku90rqIkP2+57MOj9j3FBeLCJKBlCrJoV1kUEgqQZxW8wSlz6HMmPqXe8gZs77hXEEq
         z2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897134; x=1742501934;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTENzkWxxIM8acUHka698+woGh2MOTam2MW4l72Z+bY=;
        b=WxP0dg6AMOPg/9EgN7kwr9yk582ThiaYwvnxQRQld/N7uQIgsbpjsWME3s4XTPgjIf
         cMDnNS004XAIgAKbbV8rYK5AZ3zinLSyBgyIgSQ2YEiVHAF/GFlr+XPkeRKvE1dUwiRm
         fD1s5n6b6MwraYFHGTLwVOe4tzsnzvZaxfbPZrKhIGIFb3TuUNwz6eJMa47hKNOb5c6E
         I+WDUc6azD6d9GCB+4uWB0tyaVHP8go/F7lT2a/JvuN/RUjWc0YWFOPBB7lvIVaGB4tu
         D1gU6QctXi+t3w3/IUJx+wOCekOBzwIgBzQVMZIgYF74jZih6BYSZmzrP8PdiECi9Gzi
         8snQ==
X-Gm-Message-State: AOJu0YysPnPmMqdJBPkAy+nGDAeaTH5dpQovzdEk7zRojToRQOw3mT52
	8BMKAdPDwy4OzED1VJy7lS8oHAtjNVSRc0tlN9oeTAg9udPS8ih7H1K/zw==
X-Gm-Gg: ASbGncuxLe4OgaXxmoC9+iJ832Kx48TkXatX8/U1K3UKMo+Z53mv6H8BrKuWogWTZ6Z
	iNPD5oZZcrmu+TdIvx69y7zNIvbVBzaSR3bF08Ey2MerfnTtKIZRUAvHpgG6JEb0x+rpiX8PKk2
	da9TLcRytwxEgwwtjJIOK2rGObtJaXUtztN4q3y/f0te8h7Af+Qa0fuyE1XtXDgb4CCE/au5+pU
	HYfixMBj6hloZsIaR6n1r6/BgQi2xZqXUBrMpkOF4LuCQvouyynChkrDrAolFEihUmYXu6H7mqw
	cbDUAEMfEvh/+wqZyq404jDHkql5supq/3yNEJDX1bunstMccPDIcg==
X-Google-Smtp-Source: AGHT+IHB1bgJPXAHtW3JzQ+nbJuQUlJ2GMss2INR/O1rdNjDL+zeNvVBsUVZ/vcMVy6TAvXxk/RC8g==
X-Received: by 2002:a05:6402:4301:b0:5e5:c847:1a56 with SMTP id 4fb4d7f45d1cf-5e89f154754mr71046a12.10.1741897134250;
        Thu, 13 Mar 2025 13:18:54 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e67bsm1067793a12.15.2025.03.13.13.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 13:18:53 -0700 (PDT)
Message-ID: <289795d5-49ae-4789-8f14-b2d016843a53@gmail.com>
Date: Thu, 13 Mar 2025 22:18:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
Content-Language: en-US
In-Reply-To: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tell the chip the maximum AMPDU size supported by the AP. This greatly
improves the TX speed of RTL8814AU in the 2.4 GHz band. Before: ~90
Mbps. After: ~300 Mbps.

Add this configuration for all the chips, even if it only has an effect
on RTL8814AU in my tests. Surely they all need this.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 ++
 drivers/net/wireless/realtek/rtw88/main.c     | 32 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  3 ++
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |  8 +++++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h |  6 ++++
 drivers/net/wireless/realtek/rtw88/rtw8812a.c | 11 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8814a.c |  8 +++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.c | 11 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  6 ++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  6 ++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  6 ++++
 13 files changed, 101 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 026fbf4ad9cc..77f9fbe1870c 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -396,6 +396,8 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			if (rtw_bf_support)
 				rtw_bf_assoc(rtwdev, vif, conf);
 
+			rtw_set_ampdu_factor(rtwdev, vif, conf);
+
 			rtw_fw_beacon_filter_config(rtwdev, true, vif);
 		} else {
 			rtw_leave_lps(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 959f56a3cc1a..bc2c1a5a30b3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2447,6 +2447,38 @@ void rtw_core_enable_beacon(struct rtw_dev *rtwdev, bool enable)
 	}
 }
 
+void rtw_set_ampdu_factor(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *bss_conf)
+{
+	const struct rtw_chip_ops *ops = rtwdev->chip->ops;
+	struct ieee80211_sta *sta;
+	u8 factor = 0xff;
+
+	if (!ops->set_ampdu_factor)
+		return;
+
+	rcu_read_lock();
+
+	sta = ieee80211_find_sta(vif, bss_conf->bssid);
+	if (!sta) {
+		rcu_read_unlock();
+		rtw_warn(rtwdev, "%s: failed to find station %pM\n",
+			 __func__, bss_conf->bssid);
+		return;
+	}
+
+	if (sta->deflink.vht_cap.vht_supported)
+		factor = u32_get_bits(sta->deflink.vht_cap.cap,
+				      IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK);
+	else if (sta->deflink.ht_cap.ht_supported)
+		factor = sta->deflink.ht_cap.ampdu_factor;
+
+	rcu_read_unlock();
+
+	if (factor != 0xff)
+		ops->set_ampdu_factor(rtwdev, factor);
+}
+
 MODULE_AUTHOR("Realtek Corporation");
 MODULE_DESCRIPTION("Realtek 802.11ac wireless core module");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 02343e059fd9..f410c554da58 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -878,6 +878,7 @@ struct rtw_chip_ops {
 			   u32 antenna_rx);
 	void (*cfg_ldo25)(struct rtw_dev *rtwdev, bool enable);
 	void (*efuse_grant)(struct rtw_dev *rtwdev, bool enable);
+	void (*set_ampdu_factor)(struct rtw_dev *rtwdev, u8 factor);
 	void (*false_alarm_statistics)(struct rtw_dev *rtwdev);
 	void (*phy_calibration)(struct rtw_dev *rtwdev);
 	void (*dpk_track)(struct rtw_dev *rtwdev);
@@ -2272,4 +2273,6 @@ void rtw_update_channel(struct rtw_dev *rtwdev, u8 center_channel,
 void rtw_core_port_switch(struct rtw_dev *rtwdev, struct ieee80211_vif *vif);
 bool rtw_core_check_sta_active(struct rtw_dev *rtwdev);
 void rtw_core_enable_beacon(struct rtw_dev *rtwdev, bool enable);
+void rtw_set_ampdu_factor(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *bss_conf);
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 1d232adbdd7e..47392edd3638 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -1904,6 +1904,7 @@ static const struct rtw_chip_ops rtw8703b_ops = {
 	.set_antenna		= NULL,
 	.cfg_ldo25		= rtw8723x_cfg_ldo25,
 	.efuse_grant		= rtw8723x_efuse_grant,
+	.set_ampdu_factor	= rtw8723x_set_ampdu_factor,
 	.false_alarm_statistics	= rtw8723x_false_alarm_statistics,
 	.phy_calibration	= rtw8703b_phy_calibration,
 	.dpk_track		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 87715bd54860..5acddd80fed0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1404,6 +1404,7 @@ static const struct rtw_chip_ops rtw8723d_ops = {
 	.set_antenna		= NULL,
 	.cfg_ldo25		= rtw8723x_cfg_ldo25,
 	.efuse_grant		= rtw8723x_efuse_grant,
+	.set_ampdu_factor	= rtw8723x_set_ampdu_factor,
 	.false_alarm_statistics	= rtw8723x_false_alarm_statistics,
 	.phy_calibration	= rtw8723d_phy_calibration,
 	.cck_pd_set		= rtw8723d_phy_cck_pd_set,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
index 69f73cb5b4cd..3129493d610c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
@@ -374,6 +374,13 @@ static void __rtw8723x_efuse_grant(struct rtw_dev *rtwdev, bool on)
 	}
 }
 
+static void __rtw8723x_set_ampdu_factor(struct rtw_dev *rtwdev, u8 factor)
+{
+	factor = min_t(u8, factor, IEEE80211_HT_MAX_AMPDU_32K);
+
+	rtw_write32(rtwdev, REG_AMPDU_MAX_LENGTH, (8192 << factor) - 1);
+}
+
 static void __rtw8723x_false_alarm_statistics(struct rtw_dev *rtwdev)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
@@ -704,6 +711,7 @@ const struct rtw8723x_common rtw8723x_common = {
 	.cfg_ldo25 = __rtw8723x_cfg_ldo25,
 	.set_tx_power_index = __rtw8723x_set_tx_power_index,
 	.efuse_grant = __rtw8723x_efuse_grant,
+	.set_ampdu_factor = __rtw8723x_set_ampdu_factor,
 	.false_alarm_statistics = __rtw8723x_false_alarm_statistics,
 	.iqk_backup_regs = __rtw8723x_iqk_backup_regs,
 	.iqk_restore_regs = __rtw8723x_iqk_restore_regs,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.h b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
index a99af527c92c..5d756c4933f0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723x.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
@@ -140,6 +140,7 @@ struct rtw8723x_common {
 	void (*cfg_ldo25)(struct rtw_dev *rtwdev, bool enable);
 	void (*set_tx_power_index)(struct rtw_dev *rtwdev);
 	void (*efuse_grant)(struct rtw_dev *rtwdev, bool on);
+	void (*set_ampdu_factor)(struct rtw_dev *rtwdev, u8 factor);
 	void (*false_alarm_statistics)(struct rtw_dev *rtwdev);
 	void (*iqk_backup_regs)(struct rtw_dev *rtwdev,
 				struct rtw8723x_iqk_backup_regs *backup);
@@ -398,6 +399,11 @@ static inline void rtw8723x_efuse_grant(struct rtw_dev *rtwdev, bool on)
 	rtw8723x_common.efuse_grant(rtwdev, on);
 }
 
+static inline void rtw8723x_set_ampdu_factor(struct rtw_dev *rtwdev, u8 factor)
+{
+	rtw8723x_common.set_ampdu_factor(rtwdev, factor);
+}
+
 static inline void rtw8723x_false_alarm_statistics(struct rtw_dev *rtwdev)
 {
 	rtw8723x_common.false_alarm_statistics(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812a.c b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
index f9ba2aa2928a..88daab22cdd6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
@@ -78,6 +78,16 @@ static void rtw8812a_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 {
 }
 
+static void rtw8812a_set_ampdu_factor(struct rtw_dev *rtwdev, u8 factor)
+{
+	u32 len;
+
+	factor = min_t(u8, factor, IEEE80211_VHT_MAX_AMPDU_128K);
+	len = BIT(31) | ((8192 << factor) - 1);
+
+	rtw_write32(rtwdev, REG_AMPDU_MAX_LENGTH, len);
+}
+
 static void rtw8812a_do_lck(struct rtw_dev *rtwdev)
 {
 	u32 cont_tx, lc_cal, i;
@@ -925,6 +935,7 @@ static const struct rtw_chip_ops rtw8812a_ops = {
 	.set_tx_power_index	= rtw88xxa_set_tx_power_index,
 	.cfg_ldo25		= rtw8812a_cfg_ldo25,
 	.efuse_grant		= rtw88xxa_efuse_grant,
+	.set_ampdu_factor	= rtw8812a_set_ampdu_factor,
 	.false_alarm_statistics	= rtw88xxa_false_alarm_statistics,
 	.phy_calibration	= rtw8812a_phy_calibration,
 	.cck_pd_set		= rtw88xxa_phy_cck_pd_set,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814a.c b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
index cfd35d40d46e..57d8920832a3 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8814a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
@@ -1332,6 +1332,13 @@ static void rtw8814a_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 {
 }
 
+static void rtw8814a_set_ampdu_factor(struct rtw_dev *rtwdev, u8 factor)
+{
+	factor = min_t(u8, factor, IEEE80211_VHT_MAX_AMPDU_256K);
+
+	rtw_write32(rtwdev, REG_AMPDU_MAX_LENGTH, (8192 << factor) - 1);
+}
+
 static void rtw8814a_false_alarm_statistics(struct rtw_dev *rtwdev)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
@@ -2051,6 +2058,7 @@ static const struct rtw_chip_ops rtw8814a_ops = {
 	.set_antenna		= NULL,
 	.cfg_ldo25		= rtw8814a_cfg_ldo25,
 	.efuse_grant		= rtw8814a_efuse_grant,
+	.set_ampdu_factor	= rtw8814a_set_ampdu_factor,
 	.false_alarm_statistics	= rtw8814a_false_alarm_statistics,
 	.phy_calibration	= rtw8814a_phy_calibration,
 	.cck_pd_set		= rtw8814a_phy_cck_pd_set,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
index f68239b07319..73e2bb4d5d79 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
@@ -49,6 +49,16 @@ static void rtw8821a_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 {
 }
 
+static void rtw8821a_set_ampdu_factor(struct rtw_dev *rtwdev, u8 factor)
+{
+	u32 len;
+
+	factor = min_t(u8, factor, IEEE80211_VHT_MAX_AMPDU_64K);
+	len = BIT(31) | ((8192 << factor) - 1);
+
+	rtw_write32(rtwdev, REG_AMPDU_MAX_LENGTH, len);
+}
+
 #define CAL_NUM_8821A 3
 #define MACBB_REG_NUM_8821A 8
 #define AFE_REG_NUM_8821A 4
@@ -871,6 +881,7 @@ static const struct rtw_chip_ops rtw8821a_ops = {
 	.set_tx_power_index	= rtw88xxa_set_tx_power_index,
 	.cfg_ldo25		= rtw8821a_cfg_ldo25,
 	.efuse_grant		= rtw88xxa_efuse_grant,
+	.set_ampdu_factor	= rtw8821a_set_ampdu_factor,
 	.false_alarm_statistics	= rtw88xxa_false_alarm_statistics,
 	.phy_calibration	= rtw8821a_phy_calibration,
 	.cck_pd_set		= rtw88xxa_phy_cck_pd_set,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 0ade7f11cbd2..e99ea716b64f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -719,6 +719,11 @@ static void rtw8821c_set_tx_power_index(struct rtw_dev *rtwdev)
 	}
 }
 
+static void rtw8821c_set_ampdu_factor(struct rtw_dev *rtwdev, u8 factor)
+{
+	rtw_write32(rtwdev, REG_AMPDU_MAX_LENGTH, (8192 << factor) - 1);
+}
+
 static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
@@ -1668,6 +1673,7 @@ static const struct rtw_chip_ops rtw8821c_ops = {
 	.set_antenna		= NULL,
 	.set_tx_power_index	= rtw8821c_set_tx_power_index,
 	.cfg_ldo25		= rtw8821c_cfg_ldo25,
+	.set_ampdu_factor	= rtw8821c_set_ampdu_factor,
 	.false_alarm_statistics	= rtw8821c_false_alarm_statistics,
 	.phy_calibration	= rtw8821c_phy_calibration,
 	.cck_pd_set		= rtw8821c_phy_cck_pd_set,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index b4934da88e33..ef08729b9f4a 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1018,6 +1018,11 @@ static void rtw8822b_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 	rtw_write8(rtwdev, REG_LDO_EFUSE_CTRL + 3, ldo_pwr);
 }
 
+static void rtw8822b_set_ampdu_factor(struct rtw_dev *rtwdev, u8 factor)
+{
+	rtw_write32(rtwdev, REG_AMPDU_MAX_LENGTH, (8192 << factor) - 1);
+}
+
 static void rtw8822b_false_alarm_statistics(struct rtw_dev *rtwdev)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
@@ -2158,6 +2163,7 @@ static const struct rtw_chip_ops rtw8822b_ops = {
 	.set_tx_power_index	= rtw8822b_set_tx_power_index,
 	.set_antenna		= rtw8822b_set_antenna,
 	.cfg_ldo25		= rtw8822b_cfg_ldo25,
+	.set_ampdu_factor	= rtw8822b_set_ampdu_factor,
 	.false_alarm_statistics	= rtw8822b_false_alarm_statistics,
 	.phy_calibration	= rtw8822b_phy_calibration,
 	.pwr_track		= rtw8822b_pwr_track,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 5e53e0db177e..baf519043d43 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2809,6 +2809,11 @@ static void rtw8822c_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 	rtw_write8(rtwdev, REG_ANAPARLDO_POW_MAC, ldo_pwr);
 }
 
+static void rtw8822c_set_ampdu_factor(struct rtw_dev *rtwdev, u8 factor)
+{
+	rtw_write32(rtwdev, REG_AMPDU_MAX_LENGTH, (8192 << factor) - 1);
+}
+
 static void rtw8822c_false_alarm_statistics(struct rtw_dev *rtwdev)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
@@ -4968,6 +4973,7 @@ static const struct rtw_chip_ops rtw8822c_ops = {
 	.set_tx_power_index	= rtw8822c_set_tx_power_index,
 	.set_antenna		= rtw8822c_set_antenna,
 	.cfg_ldo25		= rtw8822c_cfg_ldo25,
+	.set_ampdu_factor	= rtw8822c_set_ampdu_factor,
 	.false_alarm_statistics	= rtw8822c_false_alarm_statistics,
 	.dpk_track		= rtw8822c_dpk_track,
 	.phy_calibration	= rtw8822c_phy_calibration,
-- 
2.48.1


