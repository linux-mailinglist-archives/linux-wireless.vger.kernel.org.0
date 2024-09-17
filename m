Return-Path: <linux-wireless+bounces-12926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 496BD97B5F1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 00:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC001C20BEB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 22:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2E215C137;
	Tue, 17 Sep 2024 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7mvcjpA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C71208D0
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726613641; cv=none; b=dqQM3Tona3TSywCEgsgtAydbrZQHXYjDrbM30REtYBuEaXwOUWMNLDQ0kfGsJ9FBAcoItgfnWf3mzYRtvFgPB0Uxh08jfsImOiFX7+VMj/UcQ7mQYFuevrh211yY8ihKEpVwXjK3TQ4fJJf7jwthrXxZjH5ZPySD4EAwvgAvHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726613641; c=relaxed/simple;
	bh=fmrE9jn+KIjShsho953hiA9FftZAKTS+9aPEuFbm5DQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FOkrrdzr7ue8nwyHa5ogsx/cJizPrfGfcIx19tRpyRNbzjuAhr9/TCx9uuRkpRx3io3iWLKXREv59uTskv5zk4+J1lIwDsl8FwZT53gkyF56RFNp7vbiXqg9FJD7lLWE0oHm8zOUnJnM0FM0K1gnewSx5HntR3NQ72YbpjTj4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7mvcjpA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3780c8d689aso4524796f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 15:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726613638; x=1727218438; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzRdBirfE5c6WwMszhlbDPeysSYjmqju2o84x+sbhuI=;
        b=F7mvcjpAwi/RRGWVJylYYvhwVci916hDMYKwjajJAx0E8Gib7QDrNpD+ah1cR4ElwY
         LTXYrhfnQ4hrwkY+D2o7ocTBBZQaWpPtS8Sg7Pd9q/WM1uFuAjTGtW5AcobAkDKLrFHK
         fE6cUzUwAyDJtXZI6V279nk/T1sqLgvy31I/A+sdAG+uQ/PhdiAyWVmCH+efaYUK6IFa
         GQUUHM+13nQsMH3u7/FM0Fzla483ukoXRqen3N5H7I8pmTXA2GXQxTSfN5/LM77DA2+S
         wTgjgl3XYmAUj5lfMzgTW7dvoiHWQ2UD3J1BI6Bv32RxPl5MzpWZzo8WG1YpONlmXqcn
         nSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726613638; x=1727218438;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dzRdBirfE5c6WwMszhlbDPeysSYjmqju2o84x+sbhuI=;
        b=wv6VyQr3ErGOLik6vlzZEv6nAxfn7johyVASD5sXPFjQH+C8p+8mFWvacsC0+9r94K
         sbZYxoRjPTlufNq4HsIqo14Mtf7CgErHP9AjKfv5CZGUPw9mylx4q5xBwnQaD1aqEis9
         neTwglv+PYj3jQfIED/BXse5OkDUgmQhtLepj+wh8SJpWuIxJf8HlwxWZfXpivtMD2Q3
         wmzPjMhcpZ7gTQUplZa2NYntGDxREVUnFCRGU5S3DX1dsG3gC6D2bHZI8EIrMwHvzew4
         vG7QVnjbkGvEEoZHoFBaB5yeAREHHQaygBjwmI18zx6zZ/WwCf6pKMmcR3hivvjWCAh7
         8wWQ==
X-Gm-Message-State: AOJu0YzjI+Vzw+KLqMBMeYmuQEXhkGwl0gEyOx4Tg/g7ACmA3Us3hzVA
	gKC3wwD0nEnI1wLwcXCxFs+0gd2GqpKCaqUFc1UqD94vWgBj3v+pO+4E6g==
X-Google-Smtp-Source: AGHT+IFrm+5WhYUSluxK0cbaB/MEtmHmwtaUj9lGYHfi8MLg9q8l2qSclx5qVv+gGQtev8rw002StQ==
X-Received: by 2002:a05:6000:110c:b0:374:cbdd:480d with SMTP id ffacd0b85a97d-378c2d697c5mr11191011f8f.36.1726613637217;
        Tue, 17 Sep 2024 15:53:57 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df547sm501373766b.153.2024.09.17.15.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 15:53:56 -0700 (PDT)
Message-ID: <dae7994f-3491-40de-b537-ebf68df084bb@gmail.com>
Date: Wed, 18 Sep 2024 01:53:55 +0300
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
Subject: [PATCH 1/2] wifi: rtw88: Constify some arrays and structs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These are never modified, so make them const:

card_enable_flow_8703b
card_disable_flow_8703b
rtw8703b_ops

rtw8723d_ops
card_enable_flow_8723d
card_disable_flow_8723d

trans_carddis_to_cardemu_8821c
trans_cardemu_to_act_8821c
trans_act_to_cardemu_8821c
trans_cardemu_to_carddis_8821c
card_enable_flow_8821c
card_disable_flow_8821c
rtw8821c_dig
page_table_8821c
rqpn_table_8821c
prioq_addrs_8821c
rtw8821c_ops

card_enable_flow_8822b
card_disable_flow_8822b
prioq_addrs_8822b
rtw8822b_ops
rtw8822b_edcca_th

card_enable_flow_8822c
card_disable_flow_8822c
prioq_addrs_8822c
rtw8822c_ops
rtw8822c_edcca_th

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
These two patches will be required for the upcoming v2 of the
RTL8821AU/RTL8812AU patches. (Those are still in progress.)
---
 drivers/net/wireless/realtek/rtw88/fw.c       |  2 +-
 drivers/net/wireless/realtek/rtw88/mac.c      |  4 ++--
 drivers/net/wireless/realtek/rtw88/main.h     |  8 +++----
 drivers/net/wireless/realtek/rtw88/phy.c      |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  6 ++---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  6 ++---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 22 +++++++++----------
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 10 ++++-----
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 10 ++++-----
 9 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index b9b0114e253b..813c12148819 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -267,7 +267,7 @@ static void rtw_fw_scan_result(struct rtw_dev *rtwdev, u8 *payload,
 static void rtw_fw_adaptivity_result(struct rtw_dev *rtwdev, u8 *payload,
 				     u8 length)
 {
-	struct rtw_hw_reg_offset *edcca_th = rtwdev->chip->edcca_th;
+	const struct rtw_hw_reg_offset *edcca_th = rtwdev->chip->edcca_th;
 	struct rtw_c2h_adaptivity *result = (struct rtw_c2h_adaptivity *)payload;
 
 	rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY,
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 564f5988ee82..e5abcc20b63c 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -228,7 +228,7 @@ static int rtw_sub_pwr_seq_parser(struct rtw_dev *rtwdev, u8 intf_mask,
 }
 
 static int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
-			      const struct rtw_pwr_seq_cmd **cmd_seq)
+			      const struct rtw_pwr_seq_cmd * const *cmd_seq)
 {
 	u8 cut_mask;
 	u8 intf_mask;
@@ -271,7 +271,7 @@ static int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
 static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
-	const struct rtw_pwr_seq_cmd **pwr_seq;
+	const struct rtw_pwr_seq_cmd * const *pwr_seq;
 	u32 imr = 0;
 	u8 rpwm;
 	bool cur_pwr;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 945117afe143..83180c488c37 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1167,7 +1167,7 @@ enum rtw_fwcd_item {
 
 /* hardware configuration for each IC */
 struct rtw_chip_info {
-	struct rtw_chip_ops *ops;
+	const struct rtw_chip_ops *ops;
 	u8 id;
 
 	const char *fw_name;
@@ -1209,8 +1209,8 @@ struct rtw_chip_info {
 
 	/* init values */
 	u8 sys_func_en;
-	const struct rtw_pwr_seq_cmd **pwr_on_seq;
-	const struct rtw_pwr_seq_cmd **pwr_off_seq;
+	const struct rtw_pwr_seq_cmd * const *pwr_on_seq;
+	const struct rtw_pwr_seq_cmd * const *pwr_off_seq;
 	const struct rtw_rqpn *rqpn_table;
 	const struct rtw_prioq_addrs *prioq_addrs;
 	const struct rtw_page_table *page_table;
@@ -1242,7 +1242,7 @@ struct rtw_chip_info {
 	u8 bfer_su_max_num;
 	u8 bfer_mu_max_num;
 
-	struct rtw_hw_reg_offset *edcca_th;
+	const struct rtw_hw_reg_offset *edcca_th;
 	s8 l2h_th_ini_cs;
 	s8 l2h_th_ini_ad;
 
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 37ef80c9091d..d57a2aabd89b 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -123,7 +123,7 @@ static void rtw_phy_cck_pd_init(struct rtw_dev *rtwdev)
 
 void rtw_phy_set_edcca_th(struct rtw_dev *rtwdev, u8 l2h, u8 h2l)
 {
-	struct rtw_hw_reg_offset *edcca_th = rtwdev->chip->edcca_th;
+	const struct rtw_hw_reg_offset *edcca_th = rtwdev->chip->edcca_th;
 
 	rtw_write32_mask(rtwdev,
 			 edcca_th[EDCCA_TH_L2H_IDX].hw_reg.addr,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 222608de33cd..e3ac748ad646 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -481,14 +481,14 @@ static const struct rtw_pwr_seq_cmd trans_act_to_lps_8703b[] = {
 	{TRANS_SEQ_END},
 };
 
-static const struct rtw_pwr_seq_cmd *card_enable_flow_8703b[] = {
+static const struct rtw_pwr_seq_cmd * const card_enable_flow_8703b[] = {
 	trans_pre_enable_8703b,
 	trans_carddis_to_cardemu_8703b,
 	trans_cardemu_to_act_8703b,
 	NULL
 };
 
-static const struct rtw_pwr_seq_cmd *card_disable_flow_8703b[] = {
+static const struct rtw_pwr_seq_cmd * const card_disable_flow_8703b[] = {
 	trans_act_to_lps_8703b,
 	trans_act_to_reset_mcu_8703b,
 	trans_act_to_cardemu_8703b,
@@ -1941,7 +1941,7 @@ static const struct coex_tdma_para tdma_sant_8703b[] = {
 	{ {0x61, 0x08, 0x03, 0x11, 0x11} },
 };
 
-static struct rtw_chip_ops rtw8703b_ops = {
+static const struct rtw_chip_ops rtw8703b_ops = {
 	.mac_init		= rtw8723x_mac_init,
 	.dump_fw_crash		= NULL,
 	.shutdown		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 3fba4054d45f..7f33e141e646 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1430,7 +1430,7 @@ static void rtw8723d_pwr_track(struct rtw_dev *rtwdev)
 	dm_info->pwr_trk_triggered = false;
 }
 
-static struct rtw_chip_ops rtw8723d_ops = {
+static const struct rtw_chip_ops rtw8723d_ops = {
 	.phy_set_param		= rtw8723d_phy_set_param,
 	.read_efuse		= rtw8723x_read_efuse,
 	.query_rx_desc		= rtw8723d_query_rx_desc,
@@ -1788,7 +1788,7 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_act_8723d[] = {
 	 RTW_PWR_CMD_END, 0, 0},
 };
 
-static const struct rtw_pwr_seq_cmd *card_enable_flow_8723d[] = {
+static const struct rtw_pwr_seq_cmd * const card_enable_flow_8723d[] = {
 	trans_carddis_to_cardemu_8723d,
 	trans_cardemu_to_act_8723d,
 	NULL
@@ -2004,7 +2004,7 @@ static const struct rtw_pwr_seq_cmd trans_act_to_post_carddis_8723d[] = {
 	 RTW_PWR_CMD_END, 0, 0},
 };
 
-static const struct rtw_pwr_seq_cmd *card_disable_flow_8723d[] = {
+static const struct rtw_pwr_seq_cmd * const card_disable_flow_8723d[] = {
 	trans_act_to_lps_8723d,
 	trans_act_to_pre_carddis_8723d,
 	trans_act_to_cardemu_8723d,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 526e8de77b3e..9d21c4b1450e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1254,7 +1254,7 @@ static void rtw8821c_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 	fill_txdesc_checksum_common(txdesc, 16);
 }
 
-static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8821c[] = {
+static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8821c[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_SDIO_MSK,
@@ -1292,7 +1292,7 @@ static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8821c[] = {
 	 RTW_PWR_CMD_END, 0, 0},
 };
 
-static struct rtw_pwr_seq_cmd trans_cardemu_to_act_8821c[] = {
+static const struct rtw_pwr_seq_cmd trans_cardemu_to_act_8821c[] = {
 	{0x0020,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
@@ -1396,7 +1396,7 @@ static struct rtw_pwr_seq_cmd trans_cardemu_to_act_8821c[] = {
 	 RTW_PWR_CMD_END, 0, 0},
 };
 
-static struct rtw_pwr_seq_cmd trans_act_to_cardemu_8821c[] = {
+static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8821c[] = {
 	{0x0093,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
@@ -1454,7 +1454,7 @@ static struct rtw_pwr_seq_cmd trans_act_to_cardemu_8821c[] = {
 	 RTW_PWR_CMD_END, 0, 0},
 };
 
-static struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8821c[] = {
+static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8821c[] = {
 	{0x0007,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
@@ -1567,13 +1567,13 @@ static struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8821c[] = {
 	 RTW_PWR_CMD_END, 0, 0},
 };
 
-static const struct rtw_pwr_seq_cmd *card_enable_flow_8821c[] = {
+static const struct rtw_pwr_seq_cmd * const card_enable_flow_8821c[] = {
 	trans_carddis_to_cardemu_8821c,
 	trans_cardemu_to_act_8821c,
 	NULL
 };
 
-static const struct rtw_pwr_seq_cmd *card_disable_flow_8821c[] = {
+static const struct rtw_pwr_seq_cmd * const card_disable_flow_8821c[] = {
 	trans_act_to_cardemu_8821c,
 	trans_cardemu_to_carddis_8821c,
 	NULL
@@ -1629,7 +1629,7 @@ static const struct rtw_rfe_def rtw8821c_rfe_defs[] = {
 	[6] = RTW_DEF_RFE(8821c, 0, 0),
 };
 
-static struct rtw_hw_reg rtw8821c_dig[] = {
+static const struct rtw_hw_reg rtw8821c_dig[] = {
 	[0] = { .addr = 0xc50, .mask = 0x7f },
 };
 
@@ -1639,7 +1639,7 @@ static const struct rtw_ltecoex_addr rtw8821c_ltecoex_addr = {
 	.rdata = LTECOEX_READ_DATA,
 };
 
-static struct rtw_page_table page_table_8821c[] = {
+static const struct rtw_page_table page_table_8821c[] = {
 	/* not sure what [0] stands for */
 	{16, 16, 16, 14, 1},
 	{16, 16, 16, 14, 1},
@@ -1648,7 +1648,7 @@ static struct rtw_page_table page_table_8821c[] = {
 	{16, 16, 16, 14, 1},
 };
 
-static struct rtw_rqpn rqpn_table_8821c[] = {
+static const struct rtw_rqpn rqpn_table_8821c[] = {
 	/* not sure what [0] stands for */
 	{RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_NORMAL,
 	 RTW_DMA_MAPPING_LOW, RTW_DMA_MAPPING_LOW,
@@ -1667,7 +1667,7 @@ static struct rtw_rqpn rqpn_table_8821c[] = {
 	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
 };
 
-static struct rtw_prioq_addrs prioq_addrs_8821c = {
+static const struct rtw_prioq_addrs prioq_addrs_8821c = {
 	.prio[RTW_DMA_MAPPING_EXTRA] = {
 		.rsvd = REG_FIFOPAGE_INFO_4, .avail = REG_FIFOPAGE_INFO_4 + 2,
 	},
@@ -1683,7 +1683,7 @@ static struct rtw_prioq_addrs prioq_addrs_8821c = {
 	.wsize = true,
 };
 
-static struct rtw_chip_ops rtw8821c_ops = {
+static const struct rtw_chip_ops rtw8821c_ops = {
 	.phy_set_param		= rtw8821c_phy_set_param,
 	.read_efuse		= rtw8821c_read_efuse,
 	.query_rx_desc		= rtw8821c_query_rx_desc,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 6edb17aea90e..650585086e8f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1978,13 +1978,13 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822b[] = {
 	 RTW_PWR_CMD_END, 0, 0},
 };
 
-static const struct rtw_pwr_seq_cmd *card_enable_flow_8822b[] = {
+static const struct rtw_pwr_seq_cmd * const card_enable_flow_8822b[] = {
 	trans_carddis_to_cardemu_8822b,
 	trans_cardemu_to_act_8822b,
 	NULL
 };
 
-static const struct rtw_pwr_seq_cmd *card_disable_flow_8822b[] = {
+static const struct rtw_pwr_seq_cmd * const card_disable_flow_8822b[] = {
 	trans_act_to_cardemu_8822b,
 	trans_cardemu_to_carddis_8822b,
 	NULL
@@ -2156,7 +2156,7 @@ static const struct rtw_rqpn rqpn_table_8822b[] = {
 	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
 };
 
-static struct rtw_prioq_addrs prioq_addrs_8822b = {
+static const struct rtw_prioq_addrs prioq_addrs_8822b = {
 	.prio[RTW_DMA_MAPPING_EXTRA] = {
 		.rsvd = REG_FIFOPAGE_INFO_4, .avail = REG_FIFOPAGE_INFO_4 + 2,
 	},
@@ -2172,7 +2172,7 @@ static struct rtw_prioq_addrs prioq_addrs_8822b = {
 	.wsize = true,
 };
 
-static struct rtw_chip_ops rtw8822b_ops = {
+static const struct rtw_chip_ops rtw8822b_ops = {
 	.phy_set_param		= rtw8822b_phy_set_param,
 	.read_efuse		= rtw8822b_read_efuse,
 	.query_rx_desc		= rtw8822b_query_rx_desc,
@@ -2521,7 +2521,7 @@ static const struct rtw_reg_domain coex_info_hw_regs_8822b[] = {
 	{0xc50,  MASKBYTE0, RTW_REG_DOMAIN_MAC8},
 };
 
-static struct rtw_hw_reg_offset rtw8822b_edcca_th[] = {
+static const struct rtw_hw_reg_offset rtw8822b_edcca_th[] = {
 	[EDCCA_TH_L2H_IDX] = {{.addr = 0x8a4, .mask = MASKBYTE0}, .offset = 0},
 	[EDCCA_TH_H2L_IDX] = {{.addr = 0x8a4, .mask = MASKBYTE1}, .offset = 0},
 };
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 1dbe1cdbc3fd..a5531e663dde 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4874,13 +4874,13 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822c[] = {
 	 RTW_PWR_CMD_END, 0, 0},
 };
 
-static const struct rtw_pwr_seq_cmd *card_enable_flow_8822c[] = {
+static const struct rtw_pwr_seq_cmd * const card_enable_flow_8822c[] = {
 	trans_carddis_to_cardemu_8822c,
 	trans_cardemu_to_act_8822c,
 	NULL
 };
 
-static const struct rtw_pwr_seq_cmd *card_disable_flow_8822c[] = {
+static const struct rtw_pwr_seq_cmd * const card_disable_flow_8822c[] = {
 	trans_act_to_cardemu_8822c,
 	trans_cardemu_to_carddis_8822c,
 	NULL
@@ -4972,7 +4972,7 @@ static const struct rtw_rqpn rqpn_table_8822c[] = {
 	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
 };
 
-static struct rtw_prioq_addrs prioq_addrs_8822c = {
+static const struct rtw_prioq_addrs prioq_addrs_8822c = {
 	.prio[RTW_DMA_MAPPING_EXTRA] = {
 		.rsvd = REG_FIFOPAGE_INFO_4, .avail = REG_FIFOPAGE_INFO_4 + 2,
 	},
@@ -4988,7 +4988,7 @@ static struct rtw_prioq_addrs prioq_addrs_8822c = {
 	.wsize = true,
 };
 
-static struct rtw_chip_ops rtw8822c_ops = {
+static const struct rtw_chip_ops rtw8822c_ops = {
 	.phy_set_param		= rtw8822c_phy_set_param,
 	.read_efuse		= rtw8822c_read_efuse,
 	.query_rx_desc		= rtw8822c_query_rx_desc,
@@ -5301,7 +5301,7 @@ static const struct rtw_pwr_track_tbl rtw8822c_rtw_pwr_track_tbl = {
 	.pwrtrk_2g_ccka_p = rtw8822c_pwrtrk_2g_cck_a_p,
 };
 
-static struct rtw_hw_reg_offset rtw8822c_edcca_th[] = {
+static const struct rtw_hw_reg_offset rtw8822c_edcca_th[] = {
 	[EDCCA_TH_L2H_IDX] = {
 		{.addr = 0x84c, .mask = MASKBYTE2}, .offset = 0x80
 	},
-- 
2.46.0


