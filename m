Return-Path: <linux-wireless+bounces-28459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226B3C28638
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9D7188A336
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096E62586C9;
	Sat,  1 Nov 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0+46sdn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D92FFDC9
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024945; cv=none; b=BdnqU1xA6YTqY0n380GrcvP4hlolYR+cIYFg0SCfgGB2peC7prbUCPGfP8bjNWBV+DOJhcwXsAdqE6n0wGFSvFF8/ZdXn4dRCcIeEs2GcWSCEXsKQYgkWeiAF1KIWlmFoD8++RvwGX2qRmj91A508QlEUpiwyQCLixl2WHq15Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024945; c=relaxed/simple;
	bh=Lnv21W6e/XmORVFYoIfa8fNRwmc10ejGOLkgXBwSGNw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fJMK4zMv3Gr+DFabLvUEd6gisA43OKxDfsXtcB2FJGKtAG4Yi8IOFSKNjmYXGDaImRDqWdrN1wpsIwM0DIlxfNtR93olDW8oM7U088hlNKcuJ9nEBoTHJu2G1543xx5h4F+m06qgB0XmbwES6sL0991IHEE9ObdQXrQHGHzjy8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0+46sdn; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2637452f8f.1
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762024942; x=1762629742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7wlltAVjCtiz0v7Sqetl/1hgDbdjCquopHFWicyJKjg=;
        b=N0+46sdnL82fRa3XxBGK0Frne9QnMWG2hk/xQrde73DhtckB1Lqd/eFpFpQCjqbVsB
         f0FcNkHlDgkKiUT17QDjPY9Be3A8nSagvK5wnlmiYmM07aAJHdq54yP3PD3iZ4ObVOnr
         aE2/JzY/Kiy0DZtlCdsJILgoQdemCduxGpLucEvobfbdvAa5WeYG1lM6rmUyNawkZKpf
         0z91z4XsZ6Gc8fCcJei2jDLpzNAuhKUI4yHLmV1cxKEt7pKpezWo09tdony6VL0n9eWG
         /IosZMygiG/QSFkz7xqI5twukVAYBjd1z+lqb9cmSS7qVFGqQggPlibNDxt68TcoHuGY
         oJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762024942; x=1762629742;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wlltAVjCtiz0v7Sqetl/1hgDbdjCquopHFWicyJKjg=;
        b=GzT28P0z5jonwRfsavaARAUYyBEIalnp7j9IGRCJEvcoD4r2g++Ds4LAEjdfipvh5j
         /c893lX7ejuUaNGARfTi5L1/IPzNhHw3d+o4bgZEOHw0pWUEZ885JRAITf7mTySTRekw
         Pm9ZNYNu9SMtV3n4scqjKviI8M8qjNB0HTSiRsiqYMDEtrzwHLxI8Uhuz7nhsD9qfvKd
         CJupbp4VuE6TH3bte7fQkwGSk4Ao003t50IRTIDq6tnIupi43JvSl6NVbGnmWKqtUvdx
         mRekbqM/OiQ5Png7q/9+7lh6PSWMBmYw/RJ8gkhB+0kCHd3G+89er9MDZ/mGu2VMdGNu
         fS/Q==
X-Gm-Message-State: AOJu0YztErTmz0DL8xMRMe3HQnD+Wr1Nr9A1mY7D3vBGdYRqu6OQH5TG
	/DXDIMSNZrMzi5h2Q/4U1AInZszhiI42575ll+14El4rDI6JzVeohclfSAy7EQ==
X-Gm-Gg: ASbGnctuPs7r//fCBfuugqIgk0u4AoL4iiassHxQrVCQjskoXMfbITVya3GK/qjnqMY
	f0HhYMbPvLEYAhDD1rqht7+wWMU38OH/eUoPUWFbJePQxgJRTKReGT5yq4ty3ZdQFYupfyMcJJ3
	K4SVD/iJBwu8ZpJZ0Cx4/BZU3yi6HhvM45RdebWuu9UiJlF/br+WJZm68W6NrNJoUHypcVX2nq9
	Cfjnwvck/pZVqoHyxkPyuCQsNe8J7OHsk8GRkaRPtqKpjwxDyxlG/r9raJhh1zOuS4R/JXLuHja
	h5gguy+dFal4MUTOjKe+tTmiE9h0h3nLh9gmg/K5/kYyP4RJIVWg76hoFBPX9ZAlce4zEAYXlu5
	DHjSc2+v3bCFtnuiJzWOrt3L8KQzl0ZABuH56tukDXT/QUe1V0mlIXuQF9y9sJkN5ZmdjjsYBLN
	gzMOoK8H79E6WtzlJhptU=
X-Google-Smtp-Source: AGHT+IG5/nLQ8addKAjPpRcQuK9UdVhlTdhf8HmQnHpsxh+FEW/CPHOO8nkylJOVwGvu8tNnNbExHg==
X-Received: by 2002:a05:600c:420c:b0:477:115b:878d with SMTP id 5b1f17b1804b1-477262baebfmr65425375e9.15.1762024942001;
        Sat, 01 Nov 2025 12:22:22 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c48daa0sm63670845e9.3.2025.11.01.12.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:22:20 -0700 (PDT)
Message-ID: <de11cfae-1dc0-4514-95b2-02b1bbfa92be@gmail.com>
Date: Sat, 1 Nov 2025 21:22:19 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 03/12] wifi: rtw89: usb: Move bulk out map to new
 struct rtw89_usb_info
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8852AU, RTL8852CU, and RTL8922AU will need a different TX channel
to bulk out endpoint mapping, so create a new struct rtw89_usb_info
and move the mapping there. Initialise it in each chip's driver.

Struct rtw89_usb_info will also hold some registers which are located
at different offsets in RTL8852CU compared to the other wifi 6 chips.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Move the bulk out map to the new struct rtw89_usb_info instead of
   adding the new mapping to rtw89_usb_get_bulkout_id().

v4:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/core.h     |  2 ++
 .../net/wireless/realtek/rtw89/rtw8851bu.c    | 15 +++++++++++
 .../net/wireless/realtek/rtw89/rtw8852bu.c    | 15 +++++++++++
 drivers/net/wireless/realtek/rtw89/usb.c      | 25 +++----------------
 drivers/net/wireless/realtek/rtw89/usb.h      |  5 ++++
 5 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c7b48bd000c7..97cb0e5f0898 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -15,6 +15,7 @@
 
 struct rtw89_dev;
 struct rtw89_pci_info;
+struct rtw89_usb_info;
 struct rtw89_mac_gen_def;
 struct rtw89_phy_gen_def;
 struct rtw89_fw_blacklist;
@@ -4514,6 +4515,7 @@ struct rtw89_chip_variant {
 
 union rtw89_bus_info {
 	const struct rtw89_pci_info *pci;
+	const struct rtw89_usb_info *usb;
 };
 
 struct rtw89_driver_info {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index 04e1ab13b753..c39acbec12a9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -7,10 +7,25 @@
 #include "rtw8851b.h"
 #include "usb.h"
 
+static const struct rtw89_usb_info rtw8851b_usb_info = {
+	.bulkout_id = {
+		[RTW89_DMA_ACH0] = 3,
+		[RTW89_DMA_ACH1] = 4,
+		[RTW89_DMA_ACH2] = 5,
+		[RTW89_DMA_ACH3] = 6,
+		[RTW89_DMA_B0MG] = 0,
+		[RTW89_DMA_B0HI] = 1,
+		[RTW89_DMA_H2C] = 2,
+	},
+};
+
 static const struct rtw89_driver_info rtw89_8851bu_info = {
 	.chip = &rtw8851b_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.bus = {
+		.usb = &rtw8851b_usb_info,
+	}
 };
 
 static const struct usb_device_id rtw_8851bu_id_table[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index 0694272f7ffa..28e69473918e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -7,10 +7,25 @@
 #include "rtw8852b.h"
 #include "usb.h"
 
+static const struct rtw89_usb_info rtw8852b_usb_info = {
+	.bulkout_id = {
+		[RTW89_DMA_ACH0] = 3,
+		[RTW89_DMA_ACH1] = 4,
+		[RTW89_DMA_ACH2] = 5,
+		[RTW89_DMA_ACH3] = 6,
+		[RTW89_DMA_B0MG] = 0,
+		[RTW89_DMA_B0HI] = 1,
+		[RTW89_DMA_H2C] = 2,
+	},
+};
+
 static const struct rtw89_driver_info rtw89_8852bu_info = {
 	.chip = &rtw8852b_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.bus = {
+		.usb = &rtw8852b_usb_info,
+	}
 };
 
 static const struct usb_device_id rtw_8852bu_id_table[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index afbd1fb79021..8c0129d54b6c 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -167,27 +167,6 @@ rtw89_usb_ops_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 	return 42; /* TODO some kind of calculation? */
 }
 
-static u8 rtw89_usb_get_bulkout_id(u8 ch_dma)
-{
-	switch (ch_dma) {
-	case RTW89_DMA_ACH0:
-		return 3;
-	case RTW89_DMA_ACH1:
-		return 4;
-	case RTW89_DMA_ACH2:
-		return 5;
-	case RTW89_DMA_ACH3:
-		return 6;
-	default:
-	case RTW89_DMA_B0MG:
-		return 0;
-	case RTW89_DMA_B0HI:
-		return 1;
-	case RTW89_DMA_H2C:
-		return 2;
-	}
-}
-
 static void rtw89_usb_write_port_complete(struct urb *urb)
 {
 	struct rtw89_usb_tx_ctrl_block *txcb = urb->context;
@@ -249,9 +228,10 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
 				void *data, int len, void *context)
 {
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	const struct rtw89_usb_info *info = rtwusb->info;
 	struct usb_device *usbd = rtwusb->udev;
 	struct urb *urb;
-	u8 bulkout_id = rtw89_usb_get_bulkout_id(ch_dma);
+	u8 bulkout_id = info->bulkout_id[ch_dma];
 	unsigned int pipe;
 	int ret;
 
@@ -949,6 +929,7 @@ int rtw89_usb_probe(struct usb_interface *intf,
 
 	rtwusb = rtw89_usb_priv(rtwdev);
 	rtwusb->rtwdev = rtwdev;
+	rtwusb->info = info->bus.usb;
 
 	rtwdev->hci.ops = &rtw89_usb_ops;
 	rtwdev->hci.type = RTW89_HCI_TYPE_USB;
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index c1b4bfa20979..a27c698a424c 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -20,6 +20,10 @@
 #define RTW89_MAX_ENDPOINT_NUM		9
 #define RTW89_MAX_BULKOUT_NUM		7
 
+struct rtw89_usb_info {
+	u8 bulkout_id[RTW89_DMA_CH_NUM];
+};
+
 struct rtw89_usb_rx_ctrl_block {
 	struct rtw89_dev *rtwdev;
 	struct urb *rx_urb;
@@ -35,6 +39,7 @@ struct rtw89_usb_tx_ctrl_block {
 struct rtw89_usb {
 	struct rtw89_dev *rtwdev;
 	struct usb_device *udev;
+	const struct rtw89_usb_info *info;
 
 	__le32 *vendor_req_buf;
 
-- 
2.51.1


