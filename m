Return-Path: <linux-wireless+bounces-30095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C885CDAD3E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 00:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01633301DB86
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 23:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708B928980E;
	Tue, 23 Dec 2025 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRsNJs+S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A27289378
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766531946; cv=none; b=K/5eY79thVR9jwlWGI9qOX8rPvayZmtUf8aCYGdkX94L1qEWsCtPBaNetNkJ6UoE5O3G5htKHuTvF8hLKCWkaEBtdND8Resgq3CZdN/R3ybaDiIpO7ced5QE3vXkqBCYcUtEGDH/+izlA/HzNg2MSIvevvLMAhg5yIn1DrIdV4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766531946; c=relaxed/simple;
	bh=FVN/CrZKW1Cu68GhxnJcDNNcLkUH3g3Hk76YTd7Z31E=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KRddfp93AC4uBY+GryrtLtNHrzqZQ+uZneVid3yD/NfRkEg7oJf7rz2euBEismMt5LromB59tQW2jbMubYQnr0uwjDGEJ1Hy6xnhVbKBz4S4lnjfkWUqryCyg5BvzGTS0RNXM2g1dxdow8iUirvUNLGs5hTyr+sNMb6fSAZqEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRsNJs+S; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so43148285e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 15:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766531943; x=1767136743; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf4BvluzZz8w991h81Z6VQBqw99CJWb2FtvaSDc2Gds=;
        b=lRsNJs+SycpRBa3nmp8ZdbQUW05zxTNtKuFUAqwTTvTQbL0px/hfrUg4fla1eW+nPB
         ILJiIf4Lora/aUVOyLBCVue7XBzWVvBsH0YH1rqVWBFQLJcMLWpdFhLPpzGU8Gb8Mi6o
         GByeOs3D/aHprAcyebyuvFNJdFUKU/V0DVFLkfMcRYCKMgeaoJv3DfwXzMs0vq/5CdZl
         3Cr2oC5VxfHrmDm6S5c06c9fJiOn53rBEO3k2w5V1nf3LJ0Li4GUaU9h6z94Bm1Agldu
         MDEJmAOVxj41RVM2CMC52ROlJB48C6NtAQaIfiZGqd7kHJ+B9u6JPjmm2lPIVFZ5ofHN
         fZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766531943; x=1767136743;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jf4BvluzZz8w991h81Z6VQBqw99CJWb2FtvaSDc2Gds=;
        b=Zeak8Sz7GnUXlyk68Dd1pM2rKUA/PsFm6/XGK0omPUbdHtcxnssuog7DCtAt1N3hWG
         KJpd93gC6tAlqf1rK4BhP+1FJdatt8FS80h9CUWifUujqb1A1vNHmfdCqpRjNkcm8YxB
         +dUYuf/RQd7v43pUbNk2vhFXTa4sX2gkoJNjOVmVCZCYDqYnD1EmKbkerdlOP+G6VtkW
         7dfyBHYDLCsIof2+VTtkhO/rLrOxvikgxUJW6iUeqs6CLBvxRJfEwBc/wouSwQYsdMgo
         m4iRoAtc3h0oXnPL8W5uFMQggILVdHMIuqbpWOHIci/1wv4tfUb7Oaz9xlaOaf8YaTq5
         ukpQ==
X-Gm-Message-State: AOJu0YxcXEl5DBnUEgRlxSSh/ndEQbvsQgHeZ+5k5UCY6YDJUI9u4rSZ
	Vk31UoAP0GX3eqVCqTcTPrA+iHjt6pdc1/x2lhiUBaOvgZE5ukluhIocIHSXVg==
X-Gm-Gg: AY/fxX7JlvnxOPoCvw+yRyUov1vb+x/O6stFIsN9XbWSSE2aRgJG9tuZcIbeRyMwXRC
	L8KluYOqNJqO8njTP/IKMdhm/V+35BOkcb7kpNTa6KtMk1dn5ZT6z3Ycrgp694rLtMZ9fplq7Vi
	V2aXjnPTAU8CrYWO+BEHm4gUX2NRCKsCKnIqT63aBqsZPjLKdjcDeRkYFugffDSkPfnNdvA2cab
	mtoUOjtysjQaliQ5tdWLNkZYRoi39mwXl09tHpzKDhU686zhVlAVxKkvcu9qRXgY9M0lA8Pm0y2
	HzH3rnRQJYpWwrxzBzi+V+9scNAXPj0RcXqRTR4QmUHGZEw221WAx8dPMssU6xfI3dSpcv+namt
	dBd8ZW/KuqqbqDQEiA8fh0YyAlakH6Cdk87W4TwS+q15ndKSg/Ws0ZCL4VIOR7QuumTvVDrh8sN
	AjtSYYM4DS8JSdM/kHFeiU3dxSOhIeDoM=
X-Google-Smtp-Source: AGHT+IEBt5uqzCEVZ/VPKjtjuk2pdDLgyHPiaWxXoHshPHbPLbH3lu7GfkwC1rnZ01bvY8SEZoiE1Q==
X-Received: by 2002:a05:6000:26cb:b0:430:fcbb:2e6b with SMTP id ffacd0b85a97d-4324e4d2d51mr19029951f8f.27.1766531942944;
        Tue, 23 Dec 2025 15:19:02 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227casm30680879f8f.15.2025.12.23.15.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 15:19:02 -0800 (PST)
Message-ID: <c2e72aff-190d-4f59-9914-2588de756385@gmail.com>
Date: Wed, 24 Dec 2025 01:19:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: Increase the RX gain before scanning
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Hrůza <martin.hruza123@gmail.com>

The driver reduces the RX gain while connected to a network located
close by. In this condition scans return few results because the more
distant networks can't be heard.

Temporarily increase the RX gain before scanning in order to detect
all available networks. Reset the RX gain back to the last recorded
value once the scan finishes.

Link: https://github.com/lwfinger/rtw88/issues/337
Signed-off-by: Martin Hrůza <martin.hruza123@gmail.com>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c |  3 +++
 drivers/net/wireless/realtek/rtw88/phy.c  | 20 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/phy.h  |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 361ce0d40956..dbec7724d6af 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1483,6 +1483,8 @@ void rtw_core_scan_start(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 
 	set_bit(RTW_FLAG_DIG_DISABLE, rtwdev->flags);
 	set_bit(RTW_FLAG_SCANNING, rtwdev->flags);
+
+	rtw_phy_dig_set_max_coverage(rtwdev);
 }
 
 void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
@@ -1494,6 +1496,7 @@ void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 	if (!rtwvif)
 		return;
 
+	rtw_phy_dig_reset(rtwdev);
 	clear_bit(RTW_FLAG_SCANNING, rtwdev->flags);
 	clear_bit(RTW_FLAG_DIG_DISABLE, rtwdev->flags);
 
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 55be0d8e0c28..e2ac5c6fd500 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -370,6 +370,26 @@ static void rtw_phy_statistics(struct rtw_dev *rtwdev)
 #define DIG_CVRG_MIN				0x1c
 #define DIG_RSSI_GAIN_OFFSET			15
 
+void rtw_phy_dig_set_max_coverage(struct rtw_dev *rtwdev)
+{
+	/* Lower values result in greater coverage. */
+	rtw_dbg(rtwdev, RTW_DBG_PHY, "Setting IGI=%#x for max coverage\n",
+		DIG_CVRG_MIN);
+
+	rtw_phy_dig_write(rtwdev, DIG_CVRG_MIN);
+}
+
+void rtw_phy_dig_reset(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 last_igi;
+
+	last_igi = dm_info->igi_history[0];
+	rtw_dbg(rtwdev, RTW_DBG_PHY, "Resetting IGI=%#x\n", last_igi);
+
+	rtw_phy_dig_write(rtwdev, last_igi);
+}
+
 static bool
 rtw_phy_dig_check_damping(struct rtw_dm_info *dm_info)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index c9e6b869661d..8449936497bb 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -146,6 +146,8 @@ static inline int rtw_check_supported_rfe(struct rtw_dev *rtwdev)
 }
 
 void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi);
+void rtw_phy_dig_reset(struct rtw_dev *rtwdev);
+void rtw_phy_dig_set_max_coverage(struct rtw_dev *rtwdev);
 
 struct rtw_power_params {
 	u8 pwr_base;
-- 
2.51.1


