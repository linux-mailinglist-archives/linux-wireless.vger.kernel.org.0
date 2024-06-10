Return-Path: <linux-wireless+bounces-8766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B209027BF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 19:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45B01F228D3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F450145B09;
	Mon, 10 Jun 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAA9d0G0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35FC14532C
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040432; cv=none; b=Y/lWj5pMSM47RqL5YJNb43QHmCwS6F00JNeAwacHZ2kNpIkrT2ur2jQE/COwYFqkw4p4e/GLnkdfSR29VOhNkk5nilCvpVNg9NsuHvPPOcVTLrgpLIh9w0mIpUPHhHAd8IswncrFqK+IJrpCNuwGktbSzFYwGvqkpxMYxjJh9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040432; c=relaxed/simple;
	bh=naOIhzXYfseI2YmuyztyUZB6yLwi+m0SQwQlzgkNGZE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hF6/whQThbpQQxTGSFgN+XEFrCGssjNXhm8X2esOwq3tJfJPAKOn9qTogyG/JXNxT6RLIXxBPUtxAMtper+MKJsRxMkwKxz0ZVp2Hcd1svMi5gNqvkRuu7cJw1fdRe2Ww9Q7Afm1ybg2iMtQl3Yi/P7w+37nF7RmpcNmnQbwr6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAA9d0G0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso406573666b.2
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718040428; x=1718645228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1nN0lB2aYHOMtiaOL0YkRKzV5mO+iSQM3OLO0sszNeU=;
        b=BAA9d0G09HjQ/IbGdRgC05YBEqQmcE3ngeWuqY9cAjrKvSRCDNP9LpjOuslawP3mbM
         LYLgVp8DU9mNsiBEjaB7jgwGuhuFtOHOfVeymsUdncVhZbWAWxNwDO2SSi6AlavYaGBw
         JWcAkPqJnfouuIroU07occK8cmrZRXgqSQMXXZHyYwkAHGJ8t2UZ3dKW+o8940Si2SbR
         88dXI8+Kh0afU2q/ETHIYMWqSKU3JLYHX3ixeteVLljDiGjA73gU3uOtMi4lK9LVV97o
         PCNrv5i2O+oTqhTK17wcHQy7ugK4qWRHzkwYpEr1WWxAH1dQsodbVcA/Ks1Uk2r+SHSx
         NGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718040428; x=1718645228;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nN0lB2aYHOMtiaOL0YkRKzV5mO+iSQM3OLO0sszNeU=;
        b=MsQ2bUgSu7nbsVyyk3vPAEATcs6L4ag9fHAahEi1Z07tet59EdDijEdrN7Rn2IMQfM
         dwRAEug9OllPh1Yv0r8N/7qCLbUaaLkm+iqOB82QRv/Na+jb0atCDMJtkE+9WS1Tt8iw
         0kRmemEuwQig64GNhA6sasS2d1qsZJZxE9SgmHyQwzyrkVT/2TMJlVNQIDWhfA1yyD7a
         Pa5juPFkm0+yqPB7pNXLG+hgubmPCsDAQ9RRQ3xzVmbXt5VfcMNDwjgg7nTDqTzBxzhY
         +WpcmZ/SbYLzLJP9DfD4rHq7TpBSaV4FldjIHvP1J1h29UJ6DPGRUQBuGWFu8U1sPLzg
         JUmA==
X-Gm-Message-State: AOJu0YykBAWHCHfFLUT6BIFnHMRy/ED/EI6GmNbBI2mRCfJdEeFgrtM5
	oBcT0S5a54hTtNnGHLPyCHy6yIc/jaW/yiCb8nIUiAULGGn8Yl65QBgADw==
X-Google-Smtp-Source: AGHT+IGhbPSmkzigKnO/HqQYRVLSOyFlFDhw1GZsG2qvqPy1CHbdtv6QMkZYC/qv4q/OfUTeAM4cKw==
X-Received: by 2002:a17:906:5fcc:b0:a6e:f8d5:b49 with SMTP id a640c23a62f3a-a6ef8d50b92mr475798366b.46.1718040427533;
        Mon, 10 Jun 2024 10:27:07 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f2f8bd62esm49149266b.141.2024.06.10.10.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 10:27:07 -0700 (PDT)
Message-ID: <dfb019b6-4285-4381-86d2-d85409abee4b@gmail.com>
Date: Mon, 10 Jun 2024 20:27:04 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] wifi: rtw88: usb: Further limit the TX aggregation
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <0996d2d0-e7b8-4e43-ba12-63074ba9df1b@gmail.com>
Content-Language: en-US
In-Reply-To: <0996d2d0-e7b8-4e43-ba12-63074ba9df1b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently the number of frames sent to the chip in a single USB Request
Block is limited only by the size of the TX buffer, which is 20 KiB.
Testing reveals that as many as 13 frames get aggregated. This is more
than what any of the chips would like to receive. RTL8822CU, RTL8822BU,
and RTL8821CU want at most 3 frames, and RTL8723DU wants only 1 frame
per URB.

RTL8723DU in particular reliably malfunctions during a speed test. All
traffic seems to stop. Pinging the AP no longer works.

Fix this problem by limiting the number of frames sent to the chip in a
single URB according to what each chip likes.

Also configure RTL8822CU, RTL8822BU, and RTL8821CU to expect 3 frames
per URB.

RTL8703B may or may not be found in USB devices. Declare that it wants
only 1 frame per URB, just in case.

Also, since we're touching these, initialise the members of
rtw{8703b,8723d,8821c,8822b,8822c}_hw_spec in the same order they are
declared.

Tested with RTL8723DU and RTL8811CU.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Use rtw_write8_mask and GENMASK.
 - Initialise the members of rtw{8703b,8723d,8821c,8822b,8822c}_hw_spec
   in the same order they are declared.
---
 drivers/net/wireless/realtek/rtw88/mac.c      |  9 ++++
 drivers/net/wireless/realtek/rtw88/main.h     |  2 +
 drivers/net/wireless/realtek/rtw88/reg.h      |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 21 ++++-----
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 38 ++++++++--------
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 38 ++++++++--------
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 39 ++++++++--------
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 45 ++++++++++---------
 drivers/net/wireless/realtek/rtw88/usb.c      |  4 +-
 9 files changed, 107 insertions(+), 90 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 0dba8aae7716..564f5988ee82 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -1201,6 +1201,15 @@ static int __priority_queue_cfg(struct rtw_dev *rtwdev,
 	rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2 + 2, fifo->rsvd_boundary);
 	rtw_write16(rtwdev, REG_BCNQ1_BDNY_V1, fifo->rsvd_boundary);
 	rtw_write32(rtwdev, REG_RXFF_BNDY, chip->rxff_size - C2H_PKT_BUF - 1);
+
+	if (rtwdev->hci.type == RTW_HCI_TYPE_USB) {
+		rtw_write8_mask(rtwdev, REG_AUTO_LLT_V1, BIT_MASK_BLK_DESC_NUM,
+				chip->usb_tx_agg_desc_num);
+
+		rtw_write8(rtwdev, REG_AUTO_LLT_V1 + 3, chip->usb_tx_agg_desc_num);
+		rtw_write8_set(rtwdev, REG_TXDMA_OFFSET_CHK + 1, BIT(1));
+	}
+
 	rtw_write8_set(rtwdev, REG_AUTO_LLT_V1, BIT_AUTO_INIT_LLT_V1);
 
 	if (!check_hw_ready(rtwdev, REG_AUTO_LLT_V1, BIT_AUTO_INIT_LLT_V1, 0))
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 49894331f7b4..49a3fd4fb7dc 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1197,6 +1197,8 @@ struct rtw_chip_info {
 	u16 fw_fifo_addr[RTW_FW_FIFO_MAX];
 	const struct rtw_fwcd_segs *fwcd_segs;
 
+	u8 usb_tx_agg_desc_num;
+
 	u8 default_1ss_tx_path;
 
 	bool path_div_supported;
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index b122f226924b..02ef9a77316b 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -270,6 +270,7 @@
 #define BIT_MASK_BCN_HEAD_1_V1	0xfff
 #define REG_AUTO_LLT_V1		0x0208
 #define BIT_AUTO_INIT_LLT_V1	BIT(0)
+#define BIT_MASK_BLK_DESC_NUM	GENMASK(7, 4)
 #define REG_DWBCN0_CTRL		0x0208
 #define BIT_BCN_VALID		BIT(16)
 #define REG_TXDMA_OFFSET_CHK	0x020C
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 8919f9e11f03..6a1d274ae1ca 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -2013,6 +2013,7 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.tx_stbc = false,
 	.max_power_index = 0x3f,
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
+	.usb_tx_agg_desc_num = 1, /* Not sure if this chip has USB interface */
 
 	.path_div_supported = false,
 	.ht_supported = true,
@@ -2065,25 +2066,26 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.bt_rssi_type = COEX_BTRSSI_RATIO,
 	.ant_isolation = 15,
 	.rssi_tolerance = 2,
-	.bt_rssi_step = bt_rssi_step_8703b,
-	.wl_rssi_step = wl_rssi_step_8703b,
 	/* sant -> shared antenna, nsant -> non-shared antenna
 	 * Not sure if 8703b versions with non-shard antenna even exist.
 	 */
 	.table_sant_num = ARRAY_SIZE(table_sant_8703b),
-	.table_sant = table_sant_8703b,
 	.table_nsant_num = 0,
-	.table_nsant = NULL,
 	.tdma_sant_num = ARRAY_SIZE(tdma_sant_8703b),
-	.tdma_sant = tdma_sant_8703b,
 	.tdma_nsant_num = 0,
-	.tdma_nsant = NULL,
-	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8703b),
-	.wl_rf_para_tx = rf_para_tx_8703b,
-	.wl_rf_para_rx = rf_para_rx_8703b,
 	.bt_afh_span_bw20 = 0x20,
 	.bt_afh_span_bw40 = 0x30,
 	.afh_5g_num = ARRAY_SIZE(afh_5g_8703b),
+	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8703b),
+	.coex_info_hw_regs_num = 0,
+	.bt_rssi_step = bt_rssi_step_8703b,
+	.wl_rssi_step = wl_rssi_step_8703b,
+	.table_nsant = NULL,
+	.table_sant = table_sant_8703b,
+	.tdma_sant = tdma_sant_8703b,
+	.tdma_nsant = NULL,
+	.wl_rf_para_tx = rf_para_tx_8703b,
+	.wl_rf_para_rx = rf_para_rx_8703b,
 	.afh_5g = afh_5g_8703b,
 	/* REG_BTG_SEL doesn't seem to have a counterpart in the
 	 * vendor driver. Mathematically it's REG_PAD_CTRL1 + 3.
@@ -2096,7 +2098,6 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	/* These registers are used to read (and print) from if
 	 * CONFIG_RTW88_DEBUGFS is enabled.
 	 */
-	.coex_info_hw_regs_num = 0,
 	.coex_info_hw_regs = NULL,
 };
 EXPORT_SYMBOL(rtw8703b_hw_spec);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index f8df4c84d39f..9249c5dc14a0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2164,22 +2164,25 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.txff_size = 32768,
 	.rxff_size = 16384,
 	.rsvd_drv_pg_num = 8,
-	.txgi_factor = 1,
-	.is_pwr_by_rate_dec = true,
-	.max_power_index = 0x3f,
-	.csi_buf_pg_num = 0,
 	.band = RTW_BAND_2G,
 	.page_size = TX_PAGE_SIZE,
+	.csi_buf_pg_num = 0,
 	.dig_min = 0x20,
+	.txgi_factor = 1,
+	.is_pwr_by_rate_dec = true,
+	.rx_ldpc = false,
+	.max_power_index = 0x3f,
+	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
+	.usb_tx_agg_desc_num = 1,
 	.ht_supported = true,
 	.vht_supported = false,
 	.lps_deep_mode_supported = 0,
 	.sys_func_en = 0xFD,
 	.pwr_on_seq = card_enable_flow_8723d,
 	.pwr_off_seq = card_disable_flow_8723d,
-	.page_table = page_table_8723d,
 	.rqpn_table = rqpn_table_8723d,
 	.prioq_addrs = &rtw8723x_common.prioq_addrs,
+	.page_table = page_table_8723d,
 	.intf_table = &phy_para_table_8723d,
 	.dig = rtw8723x_common.dig,
 	.dig_cck = rtw8723x_common.dig_cck,
@@ -2193,10 +2196,8 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.rf_tbl = {&rtw8723d_rf_a_tbl},
 	.rfe_defs = rtw8723d_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8723d_rfe_defs),
-	.rx_ldpc = false,
-	.pwr_track_tbl = &rtw8723d_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
-	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
+	.pwr_track_tbl = &rtw8723d_rtw_pwr_track_tbl,
 	.max_scan_ie_len = IEEE80211_MAX_DATA_LEN,
 
 	.coex_para_ver = 0x2007022f,
@@ -2209,26 +2210,25 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.bt_rssi_type = COEX_BTRSSI_RATIO,
 	.ant_isolation = 15,
 	.rssi_tolerance = 2,
-	.wl_rssi_step = wl_rssi_step_8723d,
-	.bt_rssi_step = bt_rssi_step_8723d,
 	.table_sant_num = ARRAY_SIZE(table_sant_8723d),
-	.table_sant = table_sant_8723d,
 	.table_nsant_num = ARRAY_SIZE(table_nsant_8723d),
-	.table_nsant = table_nsant_8723d,
 	.tdma_sant_num = ARRAY_SIZE(tdma_sant_8723d),
-	.tdma_sant = tdma_sant_8723d,
 	.tdma_nsant_num = ARRAY_SIZE(tdma_nsant_8723d),
-	.tdma_nsant = tdma_nsant_8723d,
-	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8723d),
-	.wl_rf_para_tx = rf_para_tx_8723d,
-	.wl_rf_para_rx = rf_para_rx_8723d,
 	.bt_afh_span_bw20 = 0x20,
 	.bt_afh_span_bw40 = 0x30,
 	.afh_5g_num = ARRAY_SIZE(afh_5g_8723d),
+	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8723d),
+	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8723d),
+	.bt_rssi_step = bt_rssi_step_8723d,
+	.wl_rssi_step = wl_rssi_step_8723d,
+	.table_nsant = table_nsant_8723d,
+	.table_sant = table_sant_8723d,
+	.tdma_sant = tdma_sant_8723d,
+	.tdma_nsant = tdma_nsant_8723d,
+	.wl_rf_para_tx = rf_para_tx_8723d,
+	.wl_rf_para_rx = rf_para_rx_8723d,
 	.afh_5g = afh_5g_8723d,
 	.btg_reg = &btg_reg_8723d,
-
-	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8723d),
 	.coex_info_hw_regs = coex_info_hw_regs_8723d,
 };
 EXPORT_SYMBOL(rtw8723d_hw_spec);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index fe5d8e188350..553c36c4ba3b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -2001,22 +2001,25 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.txff_size = 65536,
 	.rxff_size = 16384,
 	.rsvd_drv_pg_num = 8,
-	.txgi_factor = 1,
-	.is_pwr_by_rate_dec = true,
-	.max_power_index = 0x3f,
-	.csi_buf_pg_num = 0,
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
+	.csi_buf_pg_num = 0,
 	.dig_min = 0x1c,
+	.txgi_factor = 1,
+	.is_pwr_by_rate_dec = true,
+	.rx_ldpc = false,
+	.max_power_index = 0x3f,
+	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
+	.usb_tx_agg_desc_num = 3,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
 	.sys_func_en = 0xD8,
 	.pwr_on_seq = card_enable_flow_8821c,
 	.pwr_off_seq = card_disable_flow_8821c,
-	.page_table = page_table_8821c,
 	.rqpn_table = rqpn_table_8821c,
 	.prioq_addrs = &prioq_addrs_8821c,
+	.page_table = page_table_8821c,
 	.intf_table = &phy_para_table_8821c,
 	.dig = rtw8821c_dig,
 	.rf_base_addr = {0x2800, 0x2c00},
@@ -2028,12 +2031,10 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.rf_tbl = {&rtw8821c_rf_a_tbl},
 	.rfe_defs = rtw8821c_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8821c_rfe_defs),
-	.rx_ldpc = false,
-	.pwr_track_tbl = &rtw8821c_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
+	.pwr_track_tbl = &rtw8821c_rtw_pwr_track_tbl,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
-	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
 	.max_scan_ie_len = IEEE80211_MAX_DATA_LEN,
 
 	.coex_para_ver = 0x19092746,
@@ -2046,25 +2047,24 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.bt_rssi_type = COEX_BTRSSI_RATIO,
 	.ant_isolation = 15,
 	.rssi_tolerance = 2,
-	.wl_rssi_step = wl_rssi_step_8821c,
-	.bt_rssi_step = bt_rssi_step_8821c,
 	.table_sant_num = ARRAY_SIZE(table_sant_8821c),
-	.table_sant = table_sant_8821c,
 	.table_nsant_num = ARRAY_SIZE(table_nsant_8821c),
-	.table_nsant = table_nsant_8821c,
 	.tdma_sant_num = ARRAY_SIZE(tdma_sant_8821c),
-	.tdma_sant = tdma_sant_8821c,
 	.tdma_nsant_num = ARRAY_SIZE(tdma_nsant_8821c),
-	.tdma_nsant = tdma_nsant_8821c,
-	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8821c),
-	.wl_rf_para_tx = rf_para_tx_8821c,
-	.wl_rf_para_rx = rf_para_rx_8821c,
 	.bt_afh_span_bw20 = 0x24,
 	.bt_afh_span_bw40 = 0x36,
 	.afh_5g_num = ARRAY_SIZE(afh_5g_8821c),
-	.afh_5g = afh_5g_8821c,
-
+	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8821c),
 	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8821c),
+	.bt_rssi_step = bt_rssi_step_8821c,
+	.wl_rssi_step = wl_rssi_step_8821c,
+	.table_nsant = table_nsant_8821c,
+	.table_sant = table_sant_8821c,
+	.tdma_sant = tdma_sant_8821c,
+	.tdma_nsant = tdma_nsant_8821c,
+	.wl_rf_para_tx = rf_para_tx_8821c,
+	.wl_rf_para_rx = rf_para_rx_8821c,
+	.afh_5g = afh_5g_8821c,
 	.coex_info_hw_regs = coex_info_hw_regs_8821c,
 };
 EXPORT_SYMBOL(rtw8821c_hw_spec);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 3017a9760da8..442883d998aa 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2541,22 +2541,26 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.rxff_size = 24576,
 	.fw_rxff_size = 12288,
 	.rsvd_drv_pg_num = 8,
-	.txgi_factor = 1,
-	.is_pwr_by_rate_dec = true,
-	.max_power_index = 0x3f,
-	.csi_buf_pg_num = 0,
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
+	.csi_buf_pg_num = 0,
 	.dig_min = 0x1c,
+	.txgi_factor = 1,
+	.is_pwr_by_rate_dec = true,
+	.rx_ldpc = true,
+	.max_power_index = 0x3f,
+	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
+	.fw_fifo_addr = {0x780, 0x700, 0x780, 0x660, 0x650, 0x680},
+	.usb_tx_agg_desc_num = 3,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
 	.sys_func_en = 0xDC,
 	.pwr_on_seq = card_enable_flow_8822b,
 	.pwr_off_seq = card_disable_flow_8822b,
-	.page_table = page_table_8822b,
 	.rqpn_table = rqpn_table_8822b,
 	.prioq_addrs = &prioq_addrs_8822b,
+	.page_table = page_table_8822b,
 	.intf_table = &phy_para_table_8822b,
 	.dig = rtw8822b_dig,
 	.dig_cck = NULL,
@@ -2569,15 +2573,13 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.rf_tbl = {&rtw8822b_rf_a_tbl, &rtw8822b_rf_b_tbl},
 	.rfe_defs = rtw8822b_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8822b_rfe_defs),
-	.pwr_track_tbl = &rtw8822b_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
+	.pwr_track_tbl = &rtw8822b_rtw_pwr_track_tbl,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
-	.rx_ldpc = true,
 	.edcca_th = rtw8822b_edcca_th,
 	.l2h_th_ini_cs = 10 + EDCCA_IGI_BASE,
 	.l2h_th_ini_ad = -14 + EDCCA_IGI_BASE,
-	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
 	.max_scan_ie_len = IEEE80211_MAX_DATA_LEN,
 
 	.coex_para_ver = 0x20070206,
@@ -2590,28 +2592,27 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.bt_rssi_type = COEX_BTRSSI_RATIO,
 	.ant_isolation = 15,
 	.rssi_tolerance = 2,
-	.wl_rssi_step = wl_rssi_step_8822b,
-	.bt_rssi_step = bt_rssi_step_8822b,
 	.table_sant_num = ARRAY_SIZE(table_sant_8822b),
-	.table_sant = table_sant_8822b,
 	.table_nsant_num = ARRAY_SIZE(table_nsant_8822b),
-	.table_nsant = table_nsant_8822b,
 	.tdma_sant_num = ARRAY_SIZE(tdma_sant_8822b),
-	.tdma_sant = tdma_sant_8822b,
 	.tdma_nsant_num = ARRAY_SIZE(tdma_nsant_8822b),
-	.tdma_nsant = tdma_nsant_8822b,
-	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8822b),
-	.wl_rf_para_tx = rf_para_tx_8822b,
-	.wl_rf_para_rx = rf_para_rx_8822b,
 	.bt_afh_span_bw20 = 0x24,
 	.bt_afh_span_bw40 = 0x36,
 	.afh_5g_num = ARRAY_SIZE(afh_5g_8822b),
+	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8822b),
+	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8822b),
+	.bt_rssi_step = bt_rssi_step_8822b,
+	.wl_rssi_step = wl_rssi_step_8822b,
+	.table_nsant = table_nsant_8822b,
+	.table_sant = table_sant_8822b,
+	.tdma_sant = tdma_sant_8822b,
+	.tdma_nsant = tdma_nsant_8822b,
+	.wl_rf_para_tx = rf_para_tx_8822b,
+	.wl_rf_para_rx = rf_para_rx_8822b,
 	.afh_5g = afh_5g_8822b,
 
-	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8822b),
 	.coex_info_hw_regs = coex_info_hw_regs_8822b,
 
-	.fw_fifo_addr = {0x780, 0x700, 0x780, 0x660, 0x650, 0x680},
 };
 EXPORT_SYMBOL(rtw8822b_hw_spec);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index cd965edc29ce..af90f7ba0c4b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5359,13 +5359,19 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.rxff_size = 24576,
 	.fw_rxff_size = 12288,
 	.rsvd_drv_pg_num = 16,
-	.txgi_factor = 2,
-	.is_pwr_by_rate_dec = false,
-	.max_power_index = 0x7f,
-	.csi_buf_pg_num = 50,
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
+	.csi_buf_pg_num = 50,
 	.dig_min = 0x20,
+	.txgi_factor = 2,
+	.is_pwr_by_rate_dec = false,
+	.rx_ldpc = true,
+	.tx_stbc = true,
+	.max_power_index = 0x7f,
+	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
+	.fw_fifo_addr = {0x780, 0x700, 0x780, 0x660, 0x650, 0x680},
+	.fwcd_segs = &rtw8822c_fwcd_segs,
+	.usb_tx_agg_desc_num = 3,
 	.default_1ss_tx_path = BB_PATH_A,
 	.path_div_supported = true,
 	.ht_supported = true,
@@ -5374,9 +5380,9 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.sys_func_en = 0xD8,
 	.pwr_on_seq = card_enable_flow_8822c,
 	.pwr_off_seq = card_disable_flow_8822c,
-	.page_table = page_table_8822c,
 	.rqpn_table = rqpn_table_8822c,
 	.prioq_addrs = &prioq_addrs_8822c,
+	.page_table = page_table_8822c,
 	.intf_table = &phy_para_table_8822c,
 	.dig = rtw8822c_dig,
 	.dig_cck = NULL,
@@ -5386,23 +5392,20 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.mac_tbl = &rtw8822c_mac_tbl,
 	.agc_tbl = &rtw8822c_agc_tbl,
 	.bb_tbl = &rtw8822c_bb_tbl,
-	.rfk_init_tbl = &rtw8822c_array_mp_cal_init_tbl,
 	.rf_tbl = {&rtw8822c_rf_b_tbl, &rtw8822c_rf_a_tbl},
+	.rfk_init_tbl = &rtw8822c_array_mp_cal_init_tbl,
 	.rfe_defs = rtw8822c_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8822c_rfe_defs),
 	.en_dis_dpd = true,
 	.dpd_ratemask = DIS_DPD_RATEALL,
-	.pwr_track_tbl = &rtw8822c_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
 	.lck_threshold = 8,
+	.pwr_track_tbl = &rtw8822c_rtw_pwr_track_tbl,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
-	.rx_ldpc = true,
-	.tx_stbc = true,
 	.edcca_th = rtw8822c_edcca_th,
 	.l2h_th_ini_cs = 60,
 	.l2h_th_ini_ad = 45,
-	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
 
 #ifdef CONFIG_PM
 	.wow_fw_name = "rtw88/rtw8822c_wow_fw.bin",
@@ -5420,29 +5423,27 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.bt_rssi_type = COEX_BTRSSI_DBM,
 	.ant_isolation = 15,
 	.rssi_tolerance = 2,
-	.wl_rssi_step = wl_rssi_step_8822c,
-	.bt_rssi_step = bt_rssi_step_8822c,
 	.table_sant_num = ARRAY_SIZE(table_sant_8822c),
-	.table_sant = table_sant_8822c,
 	.table_nsant_num = ARRAY_SIZE(table_nsant_8822c),
-	.table_nsant = table_nsant_8822c,
 	.tdma_sant_num = ARRAY_SIZE(tdma_sant_8822c),
-	.tdma_sant = tdma_sant_8822c,
 	.tdma_nsant_num = ARRAY_SIZE(tdma_nsant_8822c),
-	.tdma_nsant = tdma_nsant_8822c,
-	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8822c),
-	.wl_rf_para_tx = rf_para_tx_8822c,
-	.wl_rf_para_rx = rf_para_rx_8822c,
 	.bt_afh_span_bw20 = 0x24,
 	.bt_afh_span_bw40 = 0x36,
 	.afh_5g_num = ARRAY_SIZE(afh_5g_8822c),
+	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8822c),
+	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8822c),
+	.bt_rssi_step = bt_rssi_step_8822c,
+	.wl_rssi_step = wl_rssi_step_8822c,
+	.table_nsant = table_nsant_8822c,
+	.table_sant = table_sant_8822c,
+	.tdma_sant = tdma_sant_8822c,
+	.tdma_nsant = tdma_nsant_8822c,
+	.wl_rf_para_tx = rf_para_tx_8822c,
+	.wl_rf_para_rx = rf_para_rx_8822c,
 	.afh_5g = afh_5g_8822c,
 
-	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8822c),
 	.coex_info_hw_regs = coex_info_hw_regs_8822c,
 
-	.fw_fifo_addr = {0x780, 0x700, 0x780, 0x660, 0x650, 0x680},
-	.fwcd_segs = &rtw8822c_fwcd_segs,
 };
 EXPORT_SYMBOL(rtw8822c_hw_spec);
 
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index d204d138afe2..057c0ffbe944 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -379,7 +379,9 @@ static bool rtw_usb_tx_agg_skb(struct rtw_usb *rtwusb, struct sk_buff_head *list
 
 		skb_iter = skb_peek(list);
 
-		if (skb_iter && skb_iter->len + skb_head->len <= RTW_USB_MAX_XMITBUF_SZ)
+		if (skb_iter &&
+		    skb_iter->len + skb_head->len <= RTW_USB_MAX_XMITBUF_SZ &&
+		    agg_num < rtwdev->chip->usb_tx_agg_desc_num)
 			__skb_unlink(skb_iter, list);
 		else
 			skb_iter = NULL;
-- 
2.45.1


