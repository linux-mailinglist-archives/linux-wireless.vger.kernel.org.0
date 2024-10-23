Return-Path: <linux-wireless+bounces-14394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7D39ACBE7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6039E2825DC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A061B85C0;
	Wed, 23 Oct 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYe/IQXJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68971AE014
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692379; cv=none; b=teTVzusZ139THFc0q4Qz8tJ9EwERFfRVZAABtA+JiZkVvQvVwow+zrNuU7Nugch4nkg68iHjDFljKTYgBccxW2Tyy9JagUK8Gd3uJHOSFtwI3AnYGCLKS2Po8z//ynf3eiA3hrH0RjKPJmfeP9lpNPFaRhqV3wuJ8xT7Qr9Xc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692379; c=relaxed/simple;
	bh=KUwbjimqLxWwWkaxCY6X582SvRc+W6zgQYmUevSA78c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IngxixLms/cYSRjx4PpQCscxBTlmXvET7+56eB0GVEpWhUhjilOYpSIc68SJqZlMDMkRMLda3wvgNSj4dxXDbT1UbSDUpRBPH+W9nJQ8QPqh0WlmlvkUv9wGkrJqKr36PUav1Ym2dNan/0bQRGg19SkLOMahUqDG89UMy0aQpdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYe/IQXJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso907327966b.2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692376; x=1730297176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s54apOdddulrbIqxyivlJ/NACZ3QZjV62u5Yhghc7tw=;
        b=dYe/IQXJaX2RDVuI9a5wB7RlEsqcIAdm2W/0mFFCCegoxDkH9LIr1kWjACqKbsdvms
         XcJbdq/7PfwyQPzEeoUZqrqVqp9D5pDnI20ebAUc3sgI8o0k3PNL8eizNZChgAj8keIS
         fgqAK0UWwRbzr08tIEP/SxKfTtSgv6ovtiLyU0UtNOvGWLtZmSZrMnMAm5/WCnO8lDED
         SH5L+C0zUBQ8QHrMfWjIfVpNMjVI7Ww+NTzcU8gbOIXaY6yT0ThHo1P7/oPJho876+oV
         UymH3sTN2pZAOs+NHE/8jwGWNSYhcp0FhLN9JO1lyoo7HvvxiLNghV5/P5tLSSPvxJFc
         TRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692376; x=1730297176;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s54apOdddulrbIqxyivlJ/NACZ3QZjV62u5Yhghc7tw=;
        b=D7kA987+fyVyR54k3HQs2vGNNRped2IJVq2imx2GoyLBSpZ5mMDMDNTydt/ovwiJLx
         Uvise67+eit539ORUAd56CJ2qRq8amIWeHV/rkuYzFObhEiUr5m7aqVYnJlslc6O/mhK
         x3+hnQRY107r02kNXJSIoj1Z/2xucC15opHkKg4TRBJ4hUtFOctGN33RDx/TOeVJ6uaG
         L3dyoaldWbfKzROphpQYj2EC/uNnhELlg7D0n5PNvEcs6h7dkJAamQJ+QE8i3sxVVopE
         /UcDUE3W8nm+tgWC2+ITh7XzyctZEcXpGH16A8RcAyGDo4d1skhFIBSSo2Q51qoU4qdv
         Jh3g==
X-Gm-Message-State: AOJu0Yz48hLOjQjF7I8V0i43x7jKUIEKVsQLlwK3ztfkqPxm+vfEFrzk
	sAwruPDG9wFIz/E+8KYFOnsUruZK0y6X2YsOgsKqz+kjdIMAUBhL35lHbw==
X-Google-Smtp-Source: AGHT+IGjO8nz2/DjYZ3o8NwhC5QrhgFdXl6hfmpqiGcR5pF36Balc7tG45aROx3TLeTP4PriZBl0zA==
X-Received: by 2002:a17:907:7f1a:b0:a9a:161:8da4 with SMTP id a640c23a62f3a-a9abf963ce8mr279905066b.55.1729692375678;
        Wed, 23 Oct 2024 07:06:15 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9136fa68sm483124466b.122.2024.10.23.07.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:06:15 -0700 (PDT)
Message-ID: <c3e73c3a-fb2f-4013-9f06-d5274211e282@gmail.com>
Date: Wed, 23 Oct 2024 17:06:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 03/22] wifi: rtw88: Allow different C2H RA report sizes
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The RTL8821AU and RTL8812AU have smaller RA report size, only 4 bytes.
Avoid the "invalid ra report c2h length" error.

Also, use a struct and u8_get_bits() to access the RA report C2H.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Use a struct and u8_get_bits() to access the RA report C2H.
 - Use offsetofend, a solution already accepted in rtl8xxxu.

v3:
 - Remove txcls_rate member from struct rtw_c2h_ra_rpt. Added in v2,
   but it looks useless.
 - Update commit message.
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 21 +++++++++++++------
 drivers/net/wireless/realtek/rtw88/fw.h       | 17 +++++++++++----
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
 8 files changed, 34 insertions(+), 10 deletions(-)

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
index e999c24e4634..404de1b0c407 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -85,6 +85,19 @@ struct rtw_c2h_adaptivity {
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
+} __packed;
+
+#define RTW_C2H_RA_RPT_RATE	GENMASK(6, 0)
+#define RTW_C2H_RA_RPT_SGI	BIT(7)
+
 struct rtw_h2c_register {
 	u32 w0;
 	u32 w1;
@@ -364,10 +377,6 @@ struct rtw_fw_hdr_legacy {
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


