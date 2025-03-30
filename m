Return-Path: <linux-wireless+bounces-20979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904AEA75A6A
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 16:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3663C16855D
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF21B87EE;
	Sun, 30 Mar 2025 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU87Stfo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F91EA65
	for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743346614; cv=none; b=Rw9bcsv3EL6e/WbTvQvjP0X5OZ0Kk6VywB1j+7tEMcwgI2DFZJHpRivryMaXFCGeqWL3GSjpAigM7FhyLWoqvcKrIrJ0r+gPVcYjwKXXO1qmjuSKzu51xEIsIAyvDkWfPMyC5i5gul3pwMiubnf5pZLM/Eww88djc41xCNLCNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743346614; c=relaxed/simple;
	bh=JFTCHYy2KhWEG7Dev5VD+kNtAFpVd06/3wxyB5INXO0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g3DJ9vCDwfl6mhfnhFXHbKjWRWUF+jmLV3j8oKJFVUs7ySd0HYLA5C/JLIs3Ae2cwkhc/EOtYefC1/kCQxNdks5559Li9VR4Hny+6DNzvniPgawUIbyGLaTL1BHX01JAnFiXRGq21K6932a8w+/g2cOwusFzKDyhIzJyMsrNhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU87Stfo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so485695866b.0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743346611; x=1743951411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bS7pC7MQklOrE6zfgQebPQC9TeNaehzHvwrJZNxU6iM=;
        b=YU87StfoCZc0a33hBDmgurgI0d3nxazEzQZkwWDrKXHb2c8X/6NhNqNlJx0WwmpFhf
         ckJLGl1fQxA8xXNDYo2ao9MTxzr9gejMpLxptrUOvVCJ0/7HwWZCrWzuBYP3ylU84LPt
         Qi/w3nX+wp9n0uYQq0uecavNuZ8ZjtBbl7XUwxQ/782XB57YN5B+TSeBhRsgrjOWCLOT
         k9P0YSWCeWhk1R/dTDekfOJwzuOiK8wMX7wo7kZ3oMWiuKtXza9sitP5YbN9mQl5M+Nb
         8PijROsnldya8dpZS1etWQ54gku5+e1D4vyXyj13NuUG/UiEN2cLGMbNOGgQmobWlyqo
         DK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743346611; x=1743951411;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bS7pC7MQklOrE6zfgQebPQC9TeNaehzHvwrJZNxU6iM=;
        b=gHI6DSFCjKBZXSEPz8zUkxU5bJ+arU04RBmj1PXrzJ68K2Jmt22fGSEPt1NXtaGnZy
         OVQAdKdhvcbcnKCa4WLKnmwlU2urQ2LCo3jUzVXOC0NCUEXq4gi5wwbz065IsuRQU9ZA
         XBiMRztsRnOvD3otQ9RHotXsC2Yf/60DhbisKT1wUEpDcwZQFoHmSXv0Oz4ic5rY5iu9
         /D6nfTI84d3NmPwRQO9m0Kp1mOC2g4lYds4+Z1sZWP9eknHHo2fY2GmBMZD0rT5NrBVO
         NKinerGIPMmkNQf0dzOq2QYmygsy/xDrtRzXYvJ1EAQ+23+lEhcfywPjf+TY6fYurK4C
         OcMw==
X-Gm-Message-State: AOJu0YwX+D8m427ZoEhkIXUw8NTKDD7tnj6HFFmBrvI3blvUpyx+pUY8
	yA/a+Krr6MIyPJHp7dk82JmPlO2NRv8O2sr8OkwYUEt/1OQ0z7jxAoY2OQ==
X-Gm-Gg: ASbGnctD1wQnOis5rIfmahgjPaC4QjBEtzn0LzlTVa4LJ29I73UWs7G5X06EtDVJG6n
	e2ISdxLrS6QWbcyWsvNSm8V50CqxTMI/aaIeVLL7z4qPdyVMiG19+8MNLEPigfZlwZYCBLfeD+6
	nUH/uf9kKS51qoh4tgOdm7I38kS3ijf+dCU2idadgcKzxGZy2RgPNU7sM1W2HhXuBwIJqRXkJgF
	kdQ0iZWzBKWuN6cDxK077jl0kJhfidsYvYtVXPFTdX9/5RppN7l2uK3SIRvTN22Q7ppqd3BE0FE
	u53M05MvQ8oVW4REJ1Y2s/p/XMOznESXeY0iLegVKqZ6OCfmhTjyEgJnnJISjGNC
X-Google-Smtp-Source: AGHT+IEacctomCWMtVcDNSRT4VbOB7zmQq1N/VUx1nCMjdJYpRwxqAxrMkR5fw0S9i0Wx6WnPHQFaw==
X-Received: by 2002:a17:907:6d27:b0:ac7:1aff:1183 with SMTP id a640c23a62f3a-ac738932eecmr469750366b.2.1743346610846;
        Sun, 30 Mar 2025 07:56:50 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71967fcf4sm480048866b.129.2025.03.30.07.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 07:56:50 -0700 (PDT)
Message-ID: <b22de162-f914-4c91-acfb-254de8776ca6@gmail.com>
Date: Sun, 30 Mar 2025 17:56:49 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 3/4] wifi: rtw88: Set AMPDU factor to hardware for
 RTL8814A
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <5ccba1b8-d7de-4158-bc9a-0aa465f1b2df@gmail.com>
Content-Language: en-US
In-Reply-To: <5ccba1b8-d7de-4158-bc9a-0aa465f1b2df@gmail.com>
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
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 ++
 drivers/net/wireless/realtek/rtw88/main.c     | 32 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  3 ++
 drivers/net/wireless/realtek/rtw88/rtw8814a.c | 11 +++++++
 4 files changed, 48 insertions(+)

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
-- 
2.49.0


