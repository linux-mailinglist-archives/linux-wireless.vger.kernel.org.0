Return-Path: <linux-wireless+bounces-21090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DECA79230
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9854B16C55A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F6010F9;
	Wed,  2 Apr 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpMVucOD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579C2E3372
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607879; cv=none; b=Jk8QDm/ZVd6HXecTdXKvJrPXFi7JMuUNs2CQXzNopsDCRwfmNiajvGfLs/Dj5AgB7lZq67+uO5qEN7/evEmitbrgzFcKyt3vJNG2b9bku0kaTqG3B+JhfFr4y8UYfut0PnRh0pOOXEFQGPDbjFs/z3RpcWmj3CM+E8nHoq1MMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607879; c=relaxed/simple;
	bh=thUvma92iDqONjVFNgeAzdcm/zphCm0/xbk59jTcsl8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c5m1M0uZXSnasc/KSsbbDlsV6RlCSCeM3iGF2l78CCI3a78wGpaZZhChYMViA6QBQ+O0RQsQTtsxQQ2RS9moz6JyzDLUm1Ot53ggA5cj426/80GqSSYL+krC+p7VAG5cXidoa4JTqsfIiovyyhdzyLw5BiW9oO74YhsJ8xlehug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpMVucOD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac25520a289so1158825366b.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743607875; x=1744212675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RF1edLnEaKS8/8iDOXJ2CiX0xjvg9e1g/TmU+I09aK4=;
        b=hpMVucODboujWMEfNTXAYVWk2NDB4cebl6nZIa6pg6FqagUCWKplD+H4pPdAosghuD
         qIDihbp/ILRa7K5JBCI2r0zmZ1ewHuKrtww9AK7xU4B7DpZ37YRjni84/MerSwSOTZQa
         HzqDFG1xJsqgIi7gLfgYzF8GHKiqf4EJRyuZ7sE0PgR+QWg/vP/ng0PaEuHcMPg+afr6
         W7S7IQfw+w294D2KSza055xE1sWYQMOeBeboWZJqrts6I0JZ7Y4xFFYGV/q2O/zu66t/
         wwqq2jpSt2jedFLc7Xps7wljRqJ8LHeV5Uia+1j7YSU04x1DZ0H7bd64x90VdAM6a4n+
         2kLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743607875; x=1744212675;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RF1edLnEaKS8/8iDOXJ2CiX0xjvg9e1g/TmU+I09aK4=;
        b=RhU691SnlWM44zFsJIhcWAMlFqELJ/7Z2tbn8+Ia964wFz1NoLKWxIczw8V6/xo/vp
         UHkYgmQsghopZA/sdlHwro3+trS7DNHNPXQE1wN3iy4UGOcsv9FsfSixwIv0JFZ824pb
         tqDOzSKG13V8VOviaRDcLRTSAQeio3PXwUnXFgX81FbnxiYB2kKTbYkNGJvXlLmSS5I6
         dxAPi6Wtrt4k9jU+tXliIplUgW+LcfA8TPWIBxt43Fo/AadinDDVvckGhXlvMzQ3abF4
         PgUmzBk7kaMIH6u7ClAMWEiySq4zkfAqQZmjLuXdwOseftn6qYXnfe6Zgf8g5nKIkNgb
         U/UQ==
X-Gm-Message-State: AOJu0YyEBnVThLhUdv5t2LzHstaZ6xgNBrEmsCiy0t0uYiNK/bOQ/cby
	fsMl/3QFZblrn7hDn5F2dMCXsjaKhAgm418MijIdrs5nYmo82UF0TX8Tig==
X-Gm-Gg: ASbGncuyEw5Q0HbtON6Il7xI6ZEEjCGSm7ZQ4rw0gswIVr5NIEA0F/E0YW86c25e476
	a9SFQeYlZg8/TO6GYGdsTpZ/Rw8jJvi4h+d8dlfHnYBxqmEtyxnHpguODTxFOR724i6pD/+qOmA
	kdP506agCyO8XK3PATInT/YGZ7F/o/3K7tZ86xrqRix477gFGECWmasdk5haPc71uP2iSRRn8/L
	L6Z9rppSgt0AeamvFsQ7sJaIL/LhSZ/bptVXAcq3GijC7H9EL7gXreoiv0JLfDjuq+2t5c7zx+z
	5jJtg4wSnRDEgfYp0JMk9/x9ap8l1RQDxqPn9liDMZJrgNuf0Vei/A==
X-Google-Smtp-Source: AGHT+IFI3c7cXezmuHtUCy3rVzKBzD1RIZx9MmIA7lWWyT4FB2EaaGyBwcVGUW6GHtKQw1/W8+JrtQ==
X-Received: by 2002:a17:907:9625:b0:ac2:a5c7:7fc9 with SMTP id a640c23a62f3a-ac738c13711mr1523180966b.51.1743607874985;
        Wed, 02 Apr 2025 08:31:14 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196dc49csm919122666b.168.2025.04.02.08.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 08:31:14 -0700 (PDT)
Message-ID: <4edc2a63-81b3-431c-9a37-5a7d899a6cc2@gmail.com>
Date: Wed, 2 Apr 2025 18:31:12 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 3/4] wifi: rtw88: Set AMPDU factor to hardware for
 RTL8814A
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <257632d8-4347-45bc-ab39-4e88d87cdb3b@gmail.com>
Content-Language: en-US
In-Reply-To: <257632d8-4347-45bc-ab39-4e88d87cdb3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tell the chip the maximum AMPDU size supported by the AP. This greatly
improves the TX speed of RTL8814AU in the 2.4 GHz band. Before: ~90
Mbps. After: ~300 Mbps.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Do this only for RTL8814A.
 - Add a comment explaining why this is needed.

v3:
 - Explicitly initialise the set_ampdu_factor member with NULL for the
   other chips.
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 ++
 drivers/net/wireless/realtek/rtw88/main.c     | 32 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  3 ++
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8812a.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8814a.c | 11 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
 11 files changed, 55 insertions(+)

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
index 1d232adbdd7e..5e59cfe4dfdf 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -1904,6 +1904,7 @@ static const struct rtw_chip_ops rtw8703b_ops = {
 	.set_antenna		= NULL,
 	.cfg_ldo25		= rtw8723x_cfg_ldo25,
 	.efuse_grant		= rtw8723x_efuse_grant,
+	.set_ampdu_factor	= NULL,
 	.false_alarm_statistics	= rtw8723x_false_alarm_statistics,
 	.phy_calibration	= rtw8703b_phy_calibration,
 	.dpk_track		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 87715bd54860..31876e708f9e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1404,6 +1404,7 @@ static const struct rtw_chip_ops rtw8723d_ops = {
 	.set_antenna		= NULL,
 	.cfg_ldo25		= rtw8723x_cfg_ldo25,
 	.efuse_grant		= rtw8723x_efuse_grant,
+	.set_ampdu_factor	= NULL,
 	.false_alarm_statistics	= rtw8723x_false_alarm_statistics,
 	.phy_calibration	= rtw8723d_phy_calibration,
 	.cck_pd_set		= rtw8723d_phy_cck_pd_set,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812a.c b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
index f9ba2aa2928a..adbfb37105d0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
@@ -925,6 +925,7 @@ static const struct rtw_chip_ops rtw8812a_ops = {
 	.set_tx_power_index	= rtw88xxa_set_tx_power_index,
 	.cfg_ldo25		= rtw8812a_cfg_ldo25,
 	.efuse_grant		= rtw88xxa_efuse_grant,
+	.set_ampdu_factor	= NULL,
 	.false_alarm_statistics	= rtw88xxa_false_alarm_statistics,
 	.phy_calibration	= rtw8812a_phy_calibration,
 	.cck_pd_set		= rtw88xxa_phy_cck_pd_set,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814a.c b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
index cfd35d40d46e..ce8d4e4c6c57 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8814a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
@@ -1332,6 +1332,16 @@ static void rtw8814a_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 {
 }
 
+/* Without this RTL8814A sends too many frames and (some?) 11n AP
+ * can't handle it, resulting in low TX speed. Other chips seem fine.
+ */
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
@@ -2051,6 +2061,7 @@ static const struct rtw_chip_ops rtw8814a_ops = {
 	.set_antenna		= NULL,
 	.cfg_ldo25		= rtw8814a_cfg_ldo25,
 	.efuse_grant		= rtw8814a_efuse_grant,
+	.set_ampdu_factor	= rtw8814a_set_ampdu_factor,
 	.false_alarm_statistics	= rtw8814a_false_alarm_statistics,
 	.phy_calibration	= rtw8814a_phy_calibration,
 	.cck_pd_set		= rtw8814a_phy_cck_pd_set,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
index f68239b07319..4d81fb29c9fc 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
@@ -871,6 +871,7 @@ static const struct rtw_chip_ops rtw8821a_ops = {
 	.set_tx_power_index	= rtw88xxa_set_tx_power_index,
 	.cfg_ldo25		= rtw8821a_cfg_ldo25,
 	.efuse_grant		= rtw88xxa_efuse_grant,
+	.set_ampdu_factor	= NULL,
 	.false_alarm_statistics	= rtw88xxa_false_alarm_statistics,
 	.phy_calibration	= rtw8821a_phy_calibration,
 	.cck_pd_set		= rtw88xxa_phy_cck_pd_set,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 0ade7f11cbd2..f68b0041dcc0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1668,6 +1668,7 @@ static const struct rtw_chip_ops rtw8821c_ops = {
 	.set_antenna		= NULL,
 	.set_tx_power_index	= rtw8821c_set_tx_power_index,
 	.cfg_ldo25		= rtw8821c_cfg_ldo25,
+	.set_ampdu_factor	= NULL,
 	.false_alarm_statistics	= rtw8821c_false_alarm_statistics,
 	.phy_calibration	= rtw8821c_phy_calibration,
 	.cck_pd_set		= rtw8821c_phy_cck_pd_set,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index b4934da88e33..0da212e27d55 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2158,6 +2158,7 @@ static const struct rtw_chip_ops rtw8822b_ops = {
 	.set_tx_power_index	= rtw8822b_set_tx_power_index,
 	.set_antenna		= rtw8822b_set_antenna,
 	.cfg_ldo25		= rtw8822b_cfg_ldo25,
+	.set_ampdu_factor	= NULL,
 	.false_alarm_statistics	= rtw8822b_false_alarm_statistics,
 	.phy_calibration	= rtw8822b_phy_calibration,
 	.pwr_track		= rtw8822b_pwr_track,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 5e53e0db177e..ca0cf26b9055 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4968,6 +4968,7 @@ static const struct rtw_chip_ops rtw8822c_ops = {
 	.set_tx_power_index	= rtw8822c_set_tx_power_index,
 	.set_antenna		= rtw8822c_set_antenna,
 	.cfg_ldo25		= rtw8822c_cfg_ldo25,
+	.set_ampdu_factor	= NULL,
 	.false_alarm_statistics	= rtw8822c_false_alarm_statistics,
 	.dpk_track		= rtw8822c_dpk_track,
 	.phy_calibration	= rtw8822c_phy_calibration,
-- 
2.49.0


