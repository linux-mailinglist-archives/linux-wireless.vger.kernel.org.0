Return-Path: <linux-wireless+bounces-11277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD34994E327
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 22:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599191F210A2
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 20:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD188F47;
	Sun, 11 Aug 2024 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqtqNmbw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1879F4
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723409862; cv=none; b=K1ErTdpuHf6sQRhaZ5UMfJ1PpMTAHfIac01bueDRB9OgzvCJjb5j8RwfubVNYX72EHsT+M+B42gKNMqkf3Ck1nVNN4TFX2wDyLinC1RTUnn3xFyzOQDkpAeL/zsCqJjXswbC/XSJOIbJPG/RTxbzk8Ne3+9F4AsL5PznmufU9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723409862; c=relaxed/simple;
	bh=03Swlyg6kbLAobF00MH6aWy0sJvbqIAg7kPx4/CT7G4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZThazmxxFsscD/awp9uWDKZ/gEO6fmnEQ16XuH51sIdeavdtgjAHiii2puTH4wXzCqs5p6KDCgzOA7UwGg3j/4uQrni817y6StETviN0Xukweoy+VD6R5QeY18ckuH/bUqvN1rSMfWYeAFtCvxHIUWxWoXZX241NAkItjRpDkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqtqNmbw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so449769266b.0
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723409859; x=1724014659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7DVC3b5q4uccPI5+bfiihP5ws8BRNHQXBVY3w2gPmas=;
        b=nqtqNmbwnAiMYZAs+hjDyKw2C7LpuaXTTdDVA/LZqRLg4bvTzsQI7CZU3CSVETr40h
         d+HEhHO606GgHfjO7AgQWbMa0bePNL32x+C/zs1MT5udqR65Nv0i52ybuTGpMLfhFl25
         W7pWsHj+YQXitjHdO0ekl6OKqFN/jojzecWFRP0CkETljYsf7UTH0+DpbxeO+JWAGsCJ
         sygqSEdcTUBG5PbhCMlPf+IWF/Xd38VqqFKTjj+7Sa4jSnjXqxLOf5NyyorwZzOsQMGq
         e/reP2d/9rO2Ex3avMfgsOcZzNsftITc1Yl7JJvitF7ABlvmuohXnowNKMQa/dYZWNzz
         uK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723409859; x=1724014659;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DVC3b5q4uccPI5+bfiihP5ws8BRNHQXBVY3w2gPmas=;
        b=lzVVsk22Vo6hVTVS3FtV77ipktLTbpQ540r/cHANdtrpJuhkjJeQQDM/9fmUdJYjHA
         zJEFp8CBQjQ2YkG490yKKQnqyuXomv2uz08tCDml4DPn4vSM2BkrcW4WJiCl11VYr/a0
         /wjAZ4ITmUYf8jkuITH1igt2lLHMRB0McYrigT0VmPsRLkiuBOAxMi7uCNkkIJTud6yQ
         8MEDHH7clAHvqkZMPmAOu4Wuu4cP44vBIHKJilxtoiysjpTsXDr4GFYmODOEQ9HSQLDV
         BJR2PEfaArTUohYxWT8pdylKcBdaWOFyXeoe1WhhbFlcwcqlLB0L92bvVyfs6nRD0uqj
         CjXA==
X-Gm-Message-State: AOJu0YxGHQ9M2i5xrFKTM7vsUuw+wIpvOd0PcYoWkjYOKKSfk8e2T6s1
	1BxIsnZt5LqZpuC8BuxiWDwDTWGW+WvxI0BmQEoZFPQcIa8Ip14I1r5p6Q==
X-Google-Smtp-Source: AGHT+IGVUg2fb/6ku/DuSz5ukP7zxNRfcFsU0pLa9I7JC/I2TdAYjCyG8/DcgTsUCCP0DJE5yOrQvg==
X-Received: by 2002:a17:907:e68b:b0:a77:b4e3:4fca with SMTP id a640c23a62f3a-a80aa55164dmr562345966b.9.1723409858798;
        Sun, 11 Aug 2024 13:57:38 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb2130basm170378166b.154.2024.08.11.13.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 13:57:38 -0700 (PDT)
Message-ID: <4671cead-20a7-42c0-9a37-f65cd86b4c1d@gmail.com>
Date: Sun, 11 Aug 2024 23:57:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 06/20] wifi: rtw88: Let each driver control the power on/off
 process
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8821AU and RTL8812AU have to do some things differently, so let
them have full control.

The other chips use the same functions as before.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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
index 47d32a6f3345..7f12dcc03d70 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2771,16 +2771,19 @@ void rtw_coex_power_on_setting(struct rtw_dev *rtwdev)
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
index 564f5988ee82..ed7e95d5d11c 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -227,8 +227,8 @@ static int rtw_sub_pwr_seq_parser(struct rtw_dev *rtwdev, u8 intf_mask,
 	return 0;
 }
 
-static int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
-			      const struct rtw_pwr_seq_cmd **cmd_seq)
+int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
+		       const struct rtw_pwr_seq_cmd **cmd_seq)
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
index 58c3dccc14bb..cd86e0b779cc 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.h
+++ b/drivers/net/wireless/realtek/rtw88/mac.h
@@ -30,11 +30,14 @@
 
 void rtw_set_channel_mac(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 			 u8 primary_ch_idx);
+int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
+		       const struct rtw_pwr_seq_cmd **cmd_seq);
 int rtw_mac_power_on(struct rtw_dev *rtwdev);
 void rtw_mac_power_off(struct rtw_dev *rtwdev);
 int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw);
 int rtw_mac_init(struct rtw_dev *rtwdev);
 void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop);
+int rtw_set_trx_fifo_info(struct rtw_dev *rtwdev);
 int rtw_ddma_to_fw_fifo(struct rtw_dev *rtwdev, u32 ocp_src, u32 size);
 
 static inline void rtw_mac_flush_all_queues(struct rtw_dev *rtwdev, bool drop)
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index aeb21ac25e2e..3806e57400fb 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1315,7 +1315,7 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 	rtw_fw_send_ra_info(rtwdev, si, reset_ra_mask);
 }
 
-static int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
+int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fw_state *fw;
@@ -1335,6 +1335,7 @@ static int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
 
 	return ret;
 }
+EXPORT_SYMBOL(rtw_wait_firmware_completion);
 
 static enum rtw_lps_deep_mode rtw_update_lps_deep_mode(struct rtw_dev *rtwdev,
 						       struct rtw_fw_state *fw)
@@ -1356,7 +1357,7 @@ static enum rtw_lps_deep_mode rtw_update_lps_deep_mode(struct rtw_dev *rtwdev,
 	return LPS_DEEP_MODE_NONE;
 }
 
-static int rtw_power_on(struct rtw_dev *rtwdev)
+int rtw_power_on(struct rtw_dev *rtwdev)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fw_state *fw = &rtwdev->fw;
@@ -1419,6 +1420,7 @@ static int rtw_power_on(struct rtw_dev *rtwdev)
 err:
 	return ret;
 }
+EXPORT_SYMBOL(rtw_power_on);
 
 void rtw_core_fw_scan_notify(struct rtw_dev *rtwdev, bool start)
 {
@@ -1491,7 +1493,7 @@ int rtw_core_start(struct rtw_dev *rtwdev)
 {
 	int ret;
 
-	ret = rtw_power_on(rtwdev);
+	ret = rtwdev->chip->ops->power_on(rtwdev);
 	if (ret)
 		return ret;
 
@@ -1511,12 +1513,13 @@ int rtw_core_start(struct rtw_dev *rtwdev)
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
@@ -1541,7 +1544,7 @@ void rtw_core_stop(struct rtw_dev *rtwdev)
 
 	mutex_lock(&rtwdev->mutex);
 
-	rtw_power_off(rtwdev);
+	rtwdev->chip->ops->power_off(rtwdev);
 }
 
 static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index c827320c1b9b..49af0daa5e67 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -844,6 +844,8 @@ struct rtw_regd {
 };
 
 struct rtw_chip_ops {
+	int (*power_on)(struct rtw_dev *rtwdev);
+	void (*power_off)(struct rtw_dev *rtwdev);
 	int (*mac_init)(struct rtw_dev *rtwdev);
 	int (*dump_fw_crash)(struct rtw_dev *rtwdev);
 	void (*shutdown)(struct rtw_dev *rtwdev);
@@ -2200,6 +2202,7 @@ void rtw_core_scan_start(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 			    bool hw_scan);
 int rtw_core_start(struct rtw_dev *rtwdev);
+void rtw_power_off(struct rtw_dev *rtwdev);
 void rtw_core_stop(struct rtw_dev *rtwdev);
 int rtw_chip_info_setup(struct rtw_dev *rtwdev);
 int rtw_core_init(struct rtw_dev *rtwdev);
@@ -2214,6 +2217,8 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 		    bool fw_exist);
 void rtw_fw_recovery(struct rtw_dev *rtwdev);
+int rtw_wait_firmware_completion(struct rtw_dev *rtwdev);
+int rtw_power_on(struct rtw_dev *rtwdev);
 void rtw_core_fw_scan_notify(struct rtw_dev *rtwdev, bool start);
 int rtw_dump_fw(struct rtw_dev *rtwdev, const u32 ocp_src, u32 size,
 		u32 fwcd_item);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 8f90320e1c51..c2af095af5a9 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -1942,6 +1942,8 @@ static const struct coex_tdma_para tdma_sant_8703b[] = {
 };
 
 static struct rtw_chip_ops rtw8703b_ops = {
+	.power_on		= rtw_power_on,
+	.power_off		= rtw_power_off,
 	.mac_init		= rtw8723x_mac_init,
 	.dump_fw_crash		= NULL,
 	.shutdown		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 85f3abee32fc..44fbf53c0c2b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1431,6 +1431,8 @@ static void rtw8723d_pwr_track(struct rtw_dev *rtwdev)
 }
 
 static struct rtw_chip_ops rtw8723d_ops = {
+	.power_on		= rtw_power_on,
+	.power_off		= rtw_power_off,
 	.phy_set_param		= rtw8723d_phy_set_param,
 	.read_efuse		= rtw8723x_read_efuse,
 	.query_rx_desc		= rtw8723d_query_rx_desc,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 76726632c048..851bf018c911 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1684,6 +1684,8 @@ static struct rtw_prioq_addrs prioq_addrs_8821c = {
 };
 
 static struct rtw_chip_ops rtw8821c_ops = {
+	.power_on		= rtw_power_on,
+	.power_off		= rtw_power_off,
 	.phy_set_param		= rtw8821c_phy_set_param,
 	.read_efuse		= rtw8821c_read_efuse,
 	.query_rx_desc		= rtw8821c_query_rx_desc,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 9dde02dbbb62..fea7de9d6603 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2173,6 +2173,8 @@ static struct rtw_prioq_addrs prioq_addrs_8822b = {
 };
 
 static struct rtw_chip_ops rtw8822b_ops = {
+	.power_on		= rtw_power_on,
+	.power_off		= rtw_power_off,
 	.phy_set_param		= rtw8822b_phy_set_param,
 	.read_efuse		= rtw8822b_read_efuse,
 	.query_rx_desc		= rtw8822b_query_rx_desc,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 5dabcd0efb1d..d9bf992493fb 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4989,6 +4989,8 @@ static struct rtw_prioq_addrs prioq_addrs_8822c = {
 };
 
 static struct rtw_chip_ops rtw8822c_ops = {
+	.power_on		= rtw_power_on,
+	.power_off		= rtw_power_off,
 	.phy_set_param		= rtw8822c_phy_set_param,
 	.read_efuse		= rtw8822c_read_efuse,
 	.query_rx_desc		= rtw8822c_query_rx_desc,
-- 
2.46.0


