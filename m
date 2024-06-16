Return-Path: <linux-wireless+bounces-9029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E61909F84
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2024 21:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2192831C4
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2024 19:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B438F96;
	Sun, 16 Jun 2024 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUTyKUvk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF6107A9
	for <linux-wireless@vger.kernel.org>; Sun, 16 Jun 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718566059; cv=none; b=C+xX5kb/fIejhnS39LAbqQuveEICo4gGqusyPp5i0NCq14pDOYU7pTQSvkWp/xmitUPIyb74MZWgqtbYANmeTS1P26heJ6riGMqeo9UwQLhji0HsQZApb4qowjgLMshzQ9t5nd0vy3VhKamQCaymPDYddZWhhhIY25df3gZJWeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718566059; c=relaxed/simple;
	bh=koHD8ShaGbCQ+41fMl2DhioVwpgQzgP6dk7pGP+YwZc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=dWLXcFq/wtdvYhk7bHWc+E4OpcciptakCzqV1cRp7I9WI/h5kU9v3kzFJLEQ9qlqq6dNiOdRpGGOYALGAevPe0rbtALhfJbjqz2SwbbF8MvgzmEGdH2AL1s7u8Pu9NyrWUsPCK+gFiTMla6qLO54vGN6XwgjXabr1piREjGDqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUTyKUvk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35f1c567ae4so2915958f8f.1
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jun 2024 12:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718566056; x=1719170856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBLD02rv9znddKVtV4Bemli1MzS86ls20lCPOxkpE5M=;
        b=gUTyKUvk3QOBUiBOKxp8DxqfqefmCWaKhq3e/X9f71vlOPdVYYgHxhkqhmNrhIPZUD
         AVVuyCiCWgHRv3pSkFkgXCpN6FHmN8I7/xdy8hWZs0E8mIbpWhy0/e2m3LIbO6nGWMy1
         +V6PFw3bwPCkJlKiuCMsItBdMm0lon3J/FuwPQaMnzMYK0Zr8Z1NVZXXMvvzJ+jwUGvp
         nOaGSE8d3GnPPdnbxuIrgKnssSWR0vIFriaKpeWiNQNvA3ISsG1E0l4QjUI6LKFsQ43Y
         deQ3Gtav8gcJrliHceu+IpsKvm83y5cy5KkO4R7Qm2DZxswZPEqit8b6/gcYHxpyA1RM
         zqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718566056; x=1719170856;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NBLD02rv9znddKVtV4Bemli1MzS86ls20lCPOxkpE5M=;
        b=n/6gILyNFWN9PnjwSshmiNYLep8tHfswOM4TS3yr6AcF7Feku2H7krcdQdbos66n3b
         0H9srJjA5JA/IyDNaIN8dAlfIHMoNkFxVXYtFQgxKXr9k4r/XmQ0Lpj2DPbQHMBU/brj
         GLRto+7+zlI+S1LVIkottYjPf2ae8/53VGSggc5mPw+p9Lh/v/xEUHI18s30ia3YanpB
         dfaouowJ7fO3G69lkHhTTlPrFeKjLK+k9k8h7xPoUHgPTaRDmH1IHnJ9UEkUS74lfGU/
         soKRGVPA2DYjo/r4pLzcczPqYNdzKgfB010CxiEHdlMscKJ1vrEpf/GlMqHHc092FrTC
         PPvQ==
X-Gm-Message-State: AOJu0Yyil1ctpIo66GVv65ADnbSO+FVAuKIBYogLKxv247vj25fa1Lzn
	DLLmyJqSUCftWEyTHoZ7d7OckjRpJZ8vy0Uz4dpE03orn+IXTOsbStD5pw==
X-Google-Smtp-Source: AGHT+IFlThOzQx5uIxpQbp/Ip5NjkgVzuaObpF1BDtitIf+NxSO49elIBqm2nP0Pk6YjWeTO4WuS9Q==
X-Received: by 2002:a5d:6210:0:b0:360:8476:678a with SMTP id ffacd0b85a97d-3608476680fmr4223769f8f.45.1718566056083;
        Sun, 16 Jun 2024 12:27:36 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36076515a80sm10066440f8f.76.2024.06.16.12.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 12:27:35 -0700 (PDT)
Message-ID: <cb46ea35-7e59-4742-9c1f-01ceeaad36fb@gmail.com>
Date: Sun, 16 Jun 2024 22:27:34 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v3] wifi: rtw88: usb: Further limit the TX aggregation
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently the number of frames sent to the chip in a single USB Request
Block is limited only by the size of the TX buffer, which is 20 KiB.
Testing reveals that as many as 13 frames get aggregated. This is more
than what any of the chips would like to receive. RTL8822CU, RTL8822BU,
and RTL8821CU want at most 3 frames, and RTL8723DU wants only 1 frame
per URB.

RTL8723DU in particular reliably malfunctions during a speed test if it
receives more than 1 frame per URB. All traffic seems to stop. Pinging
the AP no longer works.

Fix this problem by limiting the number of frames sent to the chip in a
single URB according to what each chip likes.

Also configure RTL8822CU, RTL8822BU, and RTL8821CU to expect 3 frames
per URB.

RTL8703B may or may not be found in USB devices. Declare that it wants
only 1 frame per URB, just in case.

Tested with RTL8723DU and RTL8811CU.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - Don't sort the members of rtw{8703b,8723d,8821c,8822b,8822c}_hw_spec.
 - Put usb_tx_agg_desc_num in rtw{8723d,8821c,8822b,8822c}_hw_spec
   in a better position.
 - Explicitly say that RTL8723DU malfunctions if it receives more than
   1 frame per URB.

v2:
 - Use rtw_write8_mask and GENMASK.
 - Initialise the members of rtw{8703b,8723d,8821c,8822b,8822c}_hw_spec
   in the same order they are declared.
---
 drivers/net/wireless/realtek/rtw88/mac.c      | 9 +++++++++
 drivers/net/wireless/realtek/rtw88/main.h     | 2 ++
 drivers/net/wireless/realtek/rtw88/reg.h      | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
 drivers/net/wireless/realtek/rtw88/usb.c      | 4 +++-
 9 files changed, 20 insertions(+), 1 deletion(-)

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
index 8919f9e11f03..222608de33cd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -2013,6 +2013,7 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.tx_stbc = false,
 	.max_power_index = 0x3f,
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
+	.usb_tx_agg_desc_num = 1, /* Not sure if this chip has USB interface */
 
 	.path_div_supported = false,
 	.ht_supported = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index f8df4c84d39f..3fba4054d45f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2171,6 +2171,7 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.band = RTW_BAND_2G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x20,
+	.usb_tx_agg_desc_num = 1,
 	.ht_supported = true,
 	.vht_supported = false,
 	.lps_deep_mode_supported = 0,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index fe5d8e188350..526e8de77b3e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -2008,6 +2008,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
+	.usb_tx_agg_desc_num = 3,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 3017a9760da8..2456ff242818 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2548,6 +2548,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
+	.usb_tx_agg_desc_num = 3,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index cd965edc29ce..62376d1cca22 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5366,6 +5366,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x20,
+	.usb_tx_agg_desc_num = 3,
 	.default_1ss_tx_path = BB_PATH_A,
 	.path_div_supported = true,
 	.ht_supported = true,
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


