Return-Path: <linux-wireless+bounces-13903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2971399ADAE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3671F227E8
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54C199231;
	Fri, 11 Oct 2024 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE2Bxk2K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525B1D150D
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679638; cv=none; b=FgH5LmWLNZa1i1+ILRxg38Ee2CYAkYDWguVphMM0TVqR9mb51DO+wtZhS1/RIQVQ/C7/WJafyk1c/et70VtwrzGj48IS+VJPr/o2WN9pMCUKMvGvEl3j+qwjktLyQHdgGaBrwetqG2rPLH2Yl8JppfNWgOhXMokYt6UrEEzG9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679638; c=relaxed/simple;
	bh=F92qKwvqZOuuBUoSUxYtgmTQdG2AEnSkkN47wv9wto0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=utVJn3geFogW7cPhrCyKC+ecKhW/aROiSOXM5QMElcKZEBwGdWIMiaHBkDDIT0T5TKu7kgXH8iolcVudvS3zYkKcWqmNrZuy4JThHSpMlfa61B4PRwZpRCgtRxBKUrgYdgi4VkMsVdEe2TR0TLZ0K065NB7MGB49CckZC91ADtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE2Bxk2K; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4305724c12eso17727935e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728679635; x=1729284435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ahf0ozfYo3EHA4be3vBc5t8WrWCZxRHi+3687Xn9lMQ=;
        b=JE2Bxk2KFGa/xJeogh3fNuzNW/PD8d55XjvVvruRkTALNufpcPiP+lDvkp2dgPOvGS
         zAI9V9uOyl3+uzcnBey3aiVZMzHn/allh86K0Gpn2OIHmw4kWlgQxwkIreFmrZcMEzGz
         CvFW2nYV+Uo1/0XnVuLFvz9247mlxuY5c05XzGnaYA91NaQi3z/Py38kQ5+t1MN0PsLO
         aIuBxJBqUJkR9paJa9Xo+0/qfjYHS5o5MNUChXDAn9OV9FJklN61GLhxaksReUE7qMGo
         UfJWgY4sibUqq6NeSRDFUHPFq6VKJ/EuqMozf+xSMSK/2t6YcmA38iPg6Bu3U4aMoDBD
         NYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679635; x=1729284435;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahf0ozfYo3EHA4be3vBc5t8WrWCZxRHi+3687Xn9lMQ=;
        b=xBFo7qo56Rv1DUKMK2zEZui07VRWK+R6x/o93Qf2Qz9U13w0U5wt7uk3dXb2PP+Gug
         vjIL/ps8nch7My6Xakj4vPhisafMu3Pqy4wgr/0IuZj+7sjKbhUesr3aywjRu70nYXlM
         GOUSPL2KsY3DoLC6glvm02IV0Zzp8JuG5OCWP/HSTEKeEf36nt3Q4fjYNps/eWFqZ8YA
         HBWK9/195fU+TzyTy4fxatq+rcuqIl/P8hwOkcKAKB6Dl0NndC0BZmKyc5CT4k8Avv1Z
         josSYPb8P7tXoDVc0/OIMFfoX9FrDcRMAnxuGLY2Gz9wwqdOZnFDPsZaHiRsUL7tAEra
         15Ug==
X-Gm-Message-State: AOJu0YyRCNh3lmdb64yoPlPrDooFNHib3KxZ9+/gLds+55KpTdd+v4Qs
	QUiEZHs9qJTXtk+HuFnzcEN+FIenxLXrJkin7S1VwsTowHT6RLPs72DspQ==
X-Google-Smtp-Source: AGHT+IHQdTtulLfe1iUFcZEHz75uvspLJfu33+PcXGwaCpkyuyAZFa3owG+A/xbL1lpBZhvTQyu1UQ==
X-Received: by 2002:a05:600c:1c9d:b0:430:57f1:d6d with SMTP id 5b1f17b1804b1-431255d5099mr5227945e9.1.1728679634423;
        Fri, 11 Oct 2024 13:47:14 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff785sm50581675e9.13.2024.10.11.13.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:47:14 -0700 (PDT)
Message-ID: <9bbe0502-dabb-4a95-b201-505dfc9ab688@gmail.com>
Date: Fri, 11 Oct 2024 23:47:13 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 03/22] wifi: rtw88: Allow different C2H RA report sizes
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The RTL8821AU and RTL8812AU have smaller RA report size, only 4 bytes.
Avoid the "invalid ra report c2h length" error.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Use a struct and u8_get_bits() to access the RA report C2H.
 - Use offsetofend, a solution already accepted in rtl8xxxu.
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 21 +++++++++++++------
 drivers/net/wireless/realtek/rtw88/fw.h       | 18 ++++++++++++----
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
 8 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 813c12148819..168e19187ba7 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -139,25 +139,30 @@ static u16 get_max_amsdu_len(u32 bit_rate)
 struct rtw_fw_iter_ra_data {
 	struct rtw_dev *rtwdev;
 	u8 *payload;
+	u8 length;
 };
 
 static void rtw_fw_ra_report_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw_fw_iter_ra_data *ra_data = data;
+	struct rtw_c2h_ra_rpt *ra_rpt = (struct rtw_c2h_ra_rpt *)ra_data->payload;
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
 	u8 mac_id, rate, sgi, bw;
 	u8 mcs, nss;
 	u32 bit_rate;
 
-	mac_id = GET_RA_REPORT_MACID(ra_data->payload);
+	mac_id = ra_rpt->mac_id;
 	if (si->mac_id != mac_id)
 		return;
 
 	si->ra_report.txrate.flags = 0;
 
-	rate = GET_RA_REPORT_RATE(ra_data->payload);
-	sgi = GET_RA_REPORT_SGI(ra_data->payload);
-	bw = GET_RA_REPORT_BW(ra_data->payload);
+	rate = u8_get_bits(ra_rpt->rate_sgi, RTW_C2H_RA_RPT_RATE);
+	sgi = u8_get_bits(ra_rpt->rate_sgi, RTW_C2H_RA_RPT_SGI);
+	if (ra_data->length >= offsetofend(typeof(*ra_rpt), bw))
+		bw = ra_rpt->bw;
+	else
+		bw = si->bw_mode;
 
 	if (rate < DESC_RATEMCS0) {
 		si->ra_report.txrate.legacy = rtw_desc_to_bitrate(rate);
@@ -197,14 +202,18 @@ static void rtw_fw_ra_report_iter(void *data, struct ieee80211_sta *sta)
 static void rtw_fw_ra_report_handle(struct rtw_dev *rtwdev, u8 *payload,
 				    u8 length)
 {
+	struct rtw_c2h_ra_rpt *ra_rpt = (struct rtw_c2h_ra_rpt *)payload;
 	struct rtw_fw_iter_ra_data ra_data;
 
-	if (WARN(length < 7, "invalid ra report c2h length\n"))
+	if (WARN(length < rtwdev->chip->c2h_ra_report_size,
+		 "invalid ra report c2h length %d\n", length))
 		return;
 
-	rtwdev->dm_info.tx_rate = GET_RA_REPORT_RATE(payload);
+	rtwdev->dm_info.tx_rate = u8_get_bits(ra_rpt->rate_sgi,
+					      RTW_C2H_RA_RPT_RATE);
 	ra_data.rtwdev = rtwdev;
 	ra_data.payload = payload;
+	ra_data.length = length;
 	rtw_iterate_stas_atomic(rtwdev, rtw_fw_ra_report_iter, &ra_data);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index e999c24e4634..d0971d774948 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -85,6 +85,20 @@ struct rtw_c2h_adaptivity {
 	u8 option;
 } __packed;
 
+struct rtw_c2h_ra_rpt {
+	u8 rate_sgi;
+	u8 mac_id;
+	u8 byte2;
+	u8 status;
+	u8 byte4;
+	u8 ra_ratio;
+	u8 bw;
+	u8 txcls_rate;
+} __packed;
+
+#define RTW_C2H_RA_RPT_RATE	GENMASK(6, 0)
+#define RTW_C2H_RA_RPT_SGI	BIT(7)
+
 struct rtw_h2c_register {
 	u32 w0;
 	u32 w1;
@@ -364,10 +378,6 @@ struct rtw_fw_hdr_legacy {
 #define GET_CHAN_SWITCH_CENTRAL_CH(c2h_payload)	(c2h_payload[2])
 #define GET_CHAN_SWITCH_ID(c2h_payload)		(c2h_payload[3])
 #define GET_CHAN_SWITCH_STATUS(c2h_payload)	(c2h_payload[4])
-#define GET_RA_REPORT_RATE(c2h_payload)		(c2h_payload[0] & 0x7f)
-#define GET_RA_REPORT_SGI(c2h_payload)		((c2h_payload[0] & 0x80) >> 7)
-#define GET_RA_REPORT_BW(c2h_payload)		(c2h_payload[6])
-#define GET_RA_REPORT_MACID(c2h_payload)	(c2h_payload[1])
 
 #define GET_BCN_FILTER_NOTIFY_TYPE(c2h_payload)	(c2h_payload[1] & 0xf)
 #define GET_BCN_FILTER_NOTIFY_EVENT(c2h_payload)	(c2h_payload[1] & 0x10)
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 58c7c6a178a8..6161db5fcba6 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1201,6 +1201,7 @@ struct rtw_chip_info {
 
 	u8 usb_tx_agg_desc_num;
 	bool hw_feature_report;
+	u8 c2h_ra_report_size;
 
 	u8 default_1ss_tx_path;
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 01ac07ac68c8..23125a62e74f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -1961,6 +1961,7 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
 	.usb_tx_agg_desc_num = 1, /* Not sure if this chip has USB interface */
 	.hw_feature_report = true,
+	.c2h_ra_report_size = 7,
 
 	.path_div_supported = false,
 	.ht_supported = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index bf87c92087da..6a9115775faf 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2132,6 +2132,7 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.dig_min = 0x20,
 	.usb_tx_agg_desc_num = 1,
 	.hw_feature_report = true,
+	.c2h_ra_report_size = 7,
 	.ht_supported = true,
 	.vht_supported = false,
 	.lps_deep_mode_supported = 0,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 44ef2e246724..6cb7e9aaa437 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1969,6 +1969,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.dig_min = 0x1c,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
+	.c2h_ra_report_size = 7,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 9b7c383f37fe..48aefe3722ec 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2510,6 +2510,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.dig_min = 0x1c,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
+	.c2h_ra_report_size = 7,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 063c65c269fe..25933a54e863 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5330,6 +5330,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.dig_min = 0x20,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
+	.c2h_ra_report_size = 7,
 	.default_1ss_tx_path = BB_PATH_A,
 	.path_div_supported = true,
 	.ht_supported = true,
-- 
2.46.0


