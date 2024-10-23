Return-Path: <linux-wireless+bounces-14397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C3F9ACBF0
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC011F221DA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA01A2C27;
	Wed, 23 Oct 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqV5z/4L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511581AE014
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692593; cv=none; b=Pwf+R7kCtPONhcYUZQZOrsLUUAnBwVdQIEjYLLi/6DR9P0iH2KDCvSyEcgBxzS9dvzj+BHf3hNwGyLKQh0wj+UaL7Gu1P8dCBTM8FyB/VfDvdrZVasHo0rbZD8qtJXZPCtl8aJGUhcP6dJYil3nc7DpyER3wE13obslFLXabyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692593; c=relaxed/simple;
	bh=+SdH363b9frrFFxwjQm/FfQYuynzj4xOqy8X/aqV8kU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YMZh+vTV0iagCS2qmDjiCKstmoUucAnaOHVTdXInRT5yGqyxx6wS4Cb2r0iJIOLgFmqYsNteaF6uwJRvmTyx97wXbEQbp2/VFI3Bn4pL36Aq7ErQPsq9lMipbSDtzjG0Rd/ZQwtIzFDj9IdxNOxIuezTijJRaxAW/ASXIT43qiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqV5z/4L; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9aa8895facso363508966b.2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692590; x=1730297390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e9C1xTG+o6xQ/agVQV/IaSbmROnpAuNCjYGVasj+7FU=;
        b=LqV5z/4Lrdc39YfN+hSHejOlzmtDTV7Z66f+boeDRCpQmelKayyKEHHFbamdVuOGxM
         fdKatSRZMW+pqhapftqMrdckxxA+g/gUcCwHhWC1ROr0ThFLKfSGff/b+rfyXdFYx3kH
         1D//es66I/gMRwZU/GkOW2W0b0sonNeFSnObD+thLDeSpEU00uvjLa6YWtEJdE7c7nub
         ltiM6m7YDQghZl34XPEAuf7/LpY+po0JgBXbY0tdVSq2eydxPKUvyP55DEnUBdumE9Ez
         AYi0qBugZZfftvfmVDPuzf31eqlQepk3khm3KS5pCuY5cqR3ig6Esjgtrwob3nVfnCht
         J7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692590; x=1730297390;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9C1xTG+o6xQ/agVQV/IaSbmROnpAuNCjYGVasj+7FU=;
        b=D+Keyirj2B3IdANfbTVtETo6SKEDU7bz+nWpOSYHtOUdpkSJckZHC/W/efcIdkVvL2
         ZzSvwiS8NioVUbSJTyjfQjnnN5ENcbTI2sqL5xO2jU74EAW7UQsXf/FAEGALh/cogxvZ
         WFDlcWMWia43n6qMZYumf7PaF74YqTmubJcQMYnUyWpA8f4D3Xm30cPe+eT2+PwLMfAz
         S6epDdWqvnaYu8ltBUPja+gBDAPiOWwJHI7D38nR09ujLPKK1+8ZpC81wHF17E8kM2cO
         mSRZTJPct8pguxNI77Pd1lnnNrjsXkEmpligxb3oUkZVwmUuhPQ0q8Efqf1RiNb66R0i
         dqfw==
X-Gm-Message-State: AOJu0Yw8IMoyUY6yxH98y0ZDmAqlWDXp8SIae3NODFZNoHLkk5C7BPW5
	+lJL/zsgUAEEHpRIUcsf1DSsttnWee4rsVmqCBSlr9IHOQYrJhYsaUnqqw==
X-Google-Smtp-Source: AGHT+IG7vyx1iz49SaovD43WG+EtvFJpMqS3shHTBnLT2YzPyWa07yPahVzgqrkwPlOBacE2vcre7A==
X-Received: by 2002:a17:907:60cd:b0:a9a:55dd:4d52 with SMTP id a640c23a62f3a-a9abf95fa03mr195073166b.63.1729692589288;
        Wed, 23 Oct 2024 07:09:49 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91571ef4sm480096266b.153.2024.10.23.07.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:09:48 -0700 (PDT)
Message-ID: <98ab839f-9100-44ae-9551-9af743a4aa3a@gmail.com>
Date: Wed, 23 Oct 2024 17:09:47 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 06/22] wifi: rtw88: Let each driver control the power
 on/off process
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8821AU and RTL8812AU have to do some things differently, so let
them have full control.

The other chips use the same functions as before.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/coex.c     |  3 +++
 drivers/net/wireless/realtek/rtw88/mac.c      | 11 +++++++----
 drivers/net/wireless/realtek/rtw88/mac.h      |  3 +++
 drivers/net/wireless/realtek/rtw88/main.c     | 13 ++++++++-----
 drivers/net/wireless/realtek/rtw88/main.h     |  5 +++++
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  2 ++
 10 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 13096fa7025c..8c5aec744f3c 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2753,16 +2753,19 @@ void rtw_coex_power_on_setting(struct rtw_dev *rtwdev)
 	rtw_write8(rtwdev, 0xff1a, 0x0);
 	rtw_coex_set_gnt_debug(rtwdev);
 }
+EXPORT_SYMBOL(rtw_coex_power_on_setting);
 
 void rtw_coex_power_off_setting(struct rtw_dev *rtwdev)
 {
 	rtw_write16(rtwdev, REG_WIFI_BT_INFO, BIT_BT_INT_EN);
 }
+EXPORT_SYMBOL(rtw_coex_power_off_setting);
 
 void rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
 {
 	__rtw_coex_init_hw_config(rtwdev, wifi_only);
 }
+EXPORT_SYMBOL(rtw_coex_init_hw_config);
 
 void rtw_coex_ips_notify(struct rtw_dev *rtwdev, u8 type)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index e5abcc20b63c..daf23ccf6378 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -227,8 +227,8 @@ static int rtw_sub_pwr_seq_parser(struct rtw_dev *rtwdev, u8 intf_mask,
 	return 0;
 }
 
-static int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
-			      const struct rtw_pwr_seq_cmd * const *cmd_seq)
+int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
+		       const struct rtw_pwr_seq_cmd * const *cmd_seq)
 {
 	u8 cut_mask;
 	u8 intf_mask;
@@ -267,6 +267,7 @@ static int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
 
 	return 0;
 }
+EXPORT_SYMBOL(rtw_pwr_seq_parser);
 
 static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 {
@@ -994,6 +995,7 @@ int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 
 	return 0;
 }
+EXPORT_SYMBOL(rtw_download_firmware);
 
 static u32 get_priority_queues(struct rtw_dev *rtwdev, u32 queues)
 {
@@ -1127,7 +1129,7 @@ static int txdma_queue_mapping(struct rtw_dev *rtwdev)
 	return 0;
 }
 
-static int set_trx_fifo_info(struct rtw_dev *rtwdev)
+int rtw_set_trx_fifo_info(struct rtw_dev *rtwdev)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
@@ -1179,6 +1181,7 @@ static int set_trx_fifo_info(struct rtw_dev *rtwdev)
 
 	return 0;
 }
+EXPORT_SYMBOL(rtw_set_trx_fifo_info);
 
 static int __priority_queue_cfg(struct rtw_dev *rtwdev,
 				const struct rtw_page_table *pg_tbl,
@@ -1256,7 +1259,7 @@ static int priority_queue_cfg(struct rtw_dev *rtwdev)
 	u16 pubq_num;
 	int ret;
 
-	ret = set_trx_fifo_info(rtwdev);
+	ret = rtw_set_trx_fifo_info(rtwdev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw88/mac.h b/drivers/net/wireless/realtek/rtw88/mac.h
index 58c3dccc14bb..6905e2747372 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.h
+++ b/drivers/net/wireless/realtek/rtw88/mac.h
@@ -30,11 +30,14 @@
 
 void rtw_set_channel_mac(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 			 u8 primary_ch_idx);
+int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
+		       const struct rtw_pwr_seq_cmd * const *cmd_seq);
 int rtw_mac_power_on(struct rtw_dev *rtwdev);
 void rtw_mac_power_off(struct rtw_dev *rtwdev);
 int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw);
 int rtw_mac_init(struct rtw_dev *rtwdev);
 void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop);
+int rtw_set_trx_fifo_info(struct rtw_dev *rtwdev);
 int rtw_ddma_to_fw_fifo(struct rtw_dev *rtwdev, u32 ocp_src, u32 size);
 
 static inline void rtw_mac_flush_all_queues(struct rtw_dev *rtwdev, bool drop)
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 942266324ca4..e6f985a92019 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1309,7 +1309,7 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 	rtw_fw_send_ra_info(rtwdev, si, reset_ra_mask);
 }
 
-static int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
+int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fw_state *fw;
@@ -1329,6 +1329,7 @@ static int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
 
 	return ret;
 }
+EXPORT_SYMBOL(rtw_wait_firmware_completion);
 
 static enum rtw_lps_deep_mode rtw_update_lps_deep_mode(struct rtw_dev *rtwdev,
 						       struct rtw_fw_state *fw)
@@ -1350,7 +1351,7 @@ static enum rtw_lps_deep_mode rtw_update_lps_deep_mode(struct rtw_dev *rtwdev,
 	return LPS_DEEP_MODE_NONE;
 }
 
-static int rtw_power_on(struct rtw_dev *rtwdev)
+int rtw_power_on(struct rtw_dev *rtwdev)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fw_state *fw = &rtwdev->fw;
@@ -1413,6 +1414,7 @@ static int rtw_power_on(struct rtw_dev *rtwdev)
 err:
 	return ret;
 }
+EXPORT_SYMBOL(rtw_power_on);
 
 void rtw_core_fw_scan_notify(struct rtw_dev *rtwdev, bool start)
 {
@@ -1485,7 +1487,7 @@ int rtw_core_start(struct rtw_dev *rtwdev)
 {
 	int ret;
 
-	ret = rtw_power_on(rtwdev);
+	ret = rtwdev->chip->ops->power_on(rtwdev);
 	if (ret)
 		return ret;
 
@@ -1505,12 +1507,13 @@ int rtw_core_start(struct rtw_dev *rtwdev)
 	return 0;
 }
 
-static void rtw_power_off(struct rtw_dev *rtwdev)
+void rtw_power_off(struct rtw_dev *rtwdev)
 {
 	rtw_hci_stop(rtwdev);
 	rtw_coex_power_off_setting(rtwdev);
 	rtw_mac_power_off(rtwdev);
 }
+EXPORT_SYMBOL(rtw_power_off);
 
 void rtw_core_stop(struct rtw_dev *rtwdev)
 {
@@ -1535,7 +1538,7 @@ void rtw_core_stop(struct rtw_dev *rtwdev)
 
 	mutex_lock(&rtwdev->mutex);
 
-	rtw_power_off(rtwdev);
+	rtwdev->chip->ops->power_off(rtwdev);
 }
 
 static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 297da821704b..af4876327837 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -843,6 +843,8 @@ struct rtw_regd {
 };
 
 struct rtw_chip_ops {
+	int (*power_on)(struct rtw_dev *rtwdev);
+	void (*power_off)(struct rtw_dev *rtwdev);
 	int (*mac_init)(struct rtw_dev *rtwdev);
 	int (*dump_fw_crash)(struct rtw_dev *rtwdev);
 	void (*shutdown)(struct rtw_dev *rtwdev);
@@ -2209,6 +2211,7 @@ void rtw_core_scan_start(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 			    bool hw_scan);
 int rtw_core_start(struct rtw_dev *rtwdev);
+void rtw_power_off(struct rtw_dev *rtwdev);
 void rtw_core_stop(struct rtw_dev *rtwdev);
 int rtw_chip_info_setup(struct rtw_dev *rtwdev);
 int rtw_core_init(struct rtw_dev *rtwdev);
@@ -2223,6 +2226,8 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 		    bool fw_exist);
 void rtw_fw_recovery(struct rtw_dev *rtwdev);
+int rtw_wait_firmware_completion(struct rtw_dev *rtwdev);
+int rtw_power_on(struct rtw_dev *rtwdev);
 void rtw_core_fw_scan_notify(struct rtw_dev *rtwdev, bool start);
 int rtw_dump_fw(struct rtw_dev *rtwdev, const u32 ocp_src, u32 size,
 		u32 fwcd_item);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 23125a62e74f..97dbc77f037a 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -1888,6 +1888,8 @@ static const struct coex_tdma_para tdma_sant_8703b[] = {
 };
 
 static const struct rtw_chip_ops rtw8703b_ops = {
+	.power_on		= rtw_power_on,
+	.power_off		= rtw_power_off,
 	.mac_init		= rtw8723x_mac_init,
 	.dump_fw_crash		= NULL,
 	.shutdown		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 6a9115775faf..f6a08b06f853 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1390,6 +1390,8 @@ static void rtw8723d_pwr_track(struct rtw_dev *rtwdev)
 }
 
 static const struct rtw_chip_ops rtw8723d_ops = {
+	.power_on		= rtw_power_on,
+	.power_off		= rtw_power_off,
 	.phy_set_param		= rtw8723d_phy_set_param,
 	.read_efuse		= rtw8723x_read_efuse,
 	.query_phy_status	= query_phy_status,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 6cb7e9aaa437..e17d0193ca6f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1643,6 +1643,8 @@ static const struct rtw_prioq_addrs prioq_addrs_8821c = {
 };
 
 static const struct rtw_chip_ops rtw8821c_ops = {
+	.power_on		= rtw_power_on,
+	.power_off		= rtw_power_off,
 	.phy_set_param		= rtw8821c_phy_set_param,
 	.read_efuse		= rtw8821c_read_efuse,
 	.query_phy_status	= query_phy_status,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 48aefe3722ec..7360ce0a193e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2132,6 +2132,8 @@ static const struct rtw_prioq_addrs prioq_addrs_8822b = {
 };
 
 static const struct rtw_chip_ops rtw8822b_ops = {
+	.power_on		= rtw_power_on,
+	.power_off		= rtw_power_off,
 	.phy_set_param		= rtw8822b_phy_set_param,
 	.read_efuse		= rtw8822b_read_efuse,
 	.query_phy_status	= query_phy_status,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 25933a54e863..17d4d9bddd83 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4947,6 +4947,8 @@ static const struct rtw_prioq_addrs prioq_addrs_8822c = {
 };
 
 static const struct rtw_chip_ops rtw8822c_ops = {
+	.power_on		= rtw_power_on,
+	.power_off		= rtw_power_off,
 	.phy_set_param		= rtw8822c_phy_set_param,
 	.read_efuse		= rtw8822c_read_efuse,
 	.query_phy_status	= query_phy_status,
-- 
2.46.0


