Return-Path: <linux-wireless+bounces-22810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F66AB23BE
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 14:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA174A4906
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C32B21C19B;
	Sat, 10 May 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et9gSNpm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED501F2C58
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746879750; cv=none; b=KOL4emu+9nPANXuEyNGZDvN9NhqSx0y5X2MiDtMHnsrd1OEG9E7T7O037iOqzH/ZJCTV5+Iqw2F9MG7xbruXM7wopY4MVPSM5sY10bpDJrqI5c1lTyoX3JFqCIo/+gmrL46wYCfauSsVPJS74x+klwWXlqxPIKwGGs7zmVMjj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746879750; c=relaxed/simple;
	bh=2AADe59Ac5McBr92xFHHeL7lANfGUNmwou6fqRcH9A8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q1AjOg0wFGOYhlNwX1ohjs2EOUhZb0zJeM6G6iEL+Z09zUM24We4bdkXY6hE34S4+2tg9ubiPrW+YWQvoOttmMN4OVi/CP849K/3bplRWjoZF6NY32T5qZYkXd3/jD3XBKCi6ZV/IgCVFwjYZGHVc+bW1WVJEJwqhYrbD6qFM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et9gSNpm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5fbed53b421so4532410a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746879746; x=1747484546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A8A403TWNmyZ89Moy5X4kuaX2sbabeNxjopD6UQU6Xw=;
        b=et9gSNpm1VhrnoUcvTxbxSWQmE/3nx8knK2TyOenbrg5B/2Lq8D68QhC7pGHIFwT7o
         zLhJf3gUgf2JhIH77uFd/BGc+RzRtWeM21Sh2Rh7GQLFUpt3InZL8mHHbISfjmPJW1+g
         ao2OGt/BBKOXn2NSDHNv511tijKqO9kgEve34kmKu2m9llUZZUUsiyudBxEbDFaUOd88
         xptv2NKJvkCR+6O2DcL5L0lAtT1z15WtDzaQFi3aaZWFBblzSsxOeCB2uG+OhOa5xJgq
         yiCiU9Aln7PF0SCS8D8EvKjli0d971P+/EN162O2DIfq+S4qURu1yuZCwSfeuodPNJiu
         TKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746879746; x=1747484546;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8A403TWNmyZ89Moy5X4kuaX2sbabeNxjopD6UQU6Xw=;
        b=AcBOEP0raaGE1e9jo/M7xY/YhBp1SbwKrpfLHNEJyTyDwstFTvXZuI74Z2hx6pnmqJ
         6I2t241XddxGRF0nDxLsuDA0ilKgYOQwEqtlUcXJOS6M6LxD8tC7uJhKcmSWRM5SpAkw
         qKYmsfW/GuWsyhRIkC2z/QvPjFvLG8lvvn++Ilkv3FJkNyraRLMTQhEzLFhoRgMSUkl4
         BoVgtPmKs4ec6WKoGV6U9MJOhqRUgZB4npvYyCp8o4scWI8c5IMb1UJRqTnj1YZBj+I+
         jNKfm7TivfHJKt+pZuTPqKsaAN8L1JB/6L6sMUEYxiXa0O0Mdm6AQRAz8HZjHDrUq6/n
         Dr6g==
X-Gm-Message-State: AOJu0YwlBHm0TJN1Q4RRnoXyXGbrf2e+/7ETO4AkxiajiOr+3NOHgmnd
	La6YGmwY+kf5V2LjjuALO+wXNEDth8Q2Gsl5H0+6nuKE9fxWtgsGmPTb5g==
X-Gm-Gg: ASbGncsCtdsaeCT8rQVdu0jX1qhgb06wT1X7Q3qnGy67jjW/liJwgxHRwq0dBaQ8Vn8
	4JeWOhst/QiPxfRokagNugL2Th8P/c7Xmgjyhzj9VWokk02GULXVesxIySfJU2SfpQbcSEcLoa9
	4YuFuISLR/kUsNBBkqB91mGb7Zp6EfPZfX1yiQsqQ4TaXHbtTVf6Psy4oBvx8gVw1U5sUCpan5B
	oR8aJumL+TR4M+Lmt//vZyCdw6G4wlwwRjfZc/qdhfKjFwrB3d4fzQSXDNXGG32vAqIVBL07vqL
	2Tw/sINziTFSkGMsbOuEvivtJxtMHCLDClFlPflKX1e4DwtRg7AMopBXDl6k
X-Google-Smtp-Source: AGHT+IEdWahP5FBpRF5xfYa9QYOIOCaCU8WoB8xjjnpjOH7+1cPADZIPX4TD2zEfJh1ZC23zNrdBoQ==
X-Received: by 2002:a17:907:9c07:b0:ace:6bfb:4a11 with SMTP id a640c23a62f3a-ad219057fe0mr529879966b.24.1746879746065;
        Sat, 10 May 2025 05:22:26 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bd432sm304287866b.129.2025.05.10.05.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 05:22:25 -0700 (PDT)
Message-ID: <43f1daad-3ec0-4a3b-a50c-9cd9eb2c2f52@gmail.com>
Date: Sat, 10 May 2025 15:22:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 2/2] wifi: rtw88: usb: Upload the firmware in
 bigger chunks
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1e35dd26-3f10-40b1-b2b4-f72184a26611@gmail.com>
Content-Language: en-US
In-Reply-To: <1e35dd26-3f10-40b1-b2b4-f72184a26611@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8811AU stops responding during the firmware download on some systems:

[  809.256440] rtw_8821au 5-2.1:1.0: Firmware version 42.4.0, H2C version 0
[  812.759142] rtw_8821au 5-2.1:1.0 wlp48s0f4u2u1: renamed from wlan0
[  837.315388] rtw_8821au 1-4:1.0: write register 0x1ef4 failed with -110
[  867.524259] rtw_8821au 1-4:1.0: write register 0x1ef8 failed with -110
[  868.930976] rtw_8821au 5-2.1:1.0 wlp48s0f4u2u1: entered promiscuous mode
[  897.730952] rtw_8821au 1-4:1.0: write register 0x1efc failed with -110

Maybe it takes too long when writing the firmware 4 bytes at a time.

Write 196 bytes at a time for RTL8821AU, RTL8811AU, and RTL8812AU,
and 254 bytes at a time for RTL8723DU. These are the sizes used in
their official drivers. Tested with all these chips.

Cc: stable@vger.kernel.org
Link: https://github.com/lwfinger/rtw88/issues/344
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Use FW_START_ADDR_LEGACY instead of FW_8192C_START_ADDRESS.
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw88/hci.h  |  8 ++++
 drivers/net/wireless/realtek/rtw88/mac.c  | 11 +++--
 drivers/net/wireless/realtek/rtw88/mac.h  |  2 +
 drivers/net/wireless/realtek/rtw88/pci.c  |  2 +
 drivers/net/wireless/realtek/rtw88/sdio.c |  2 +
 drivers/net/wireless/realtek/rtw88/usb.c  | 55 +++++++++++++++++++++++
 6 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/hci.h b/drivers/net/wireless/realtek/rtw88/hci.h
index 96aeda26014e..d4bee9c3ecfe 100644
--- a/drivers/net/wireless/realtek/rtw88/hci.h
+++ b/drivers/net/wireless/realtek/rtw88/hci.h
@@ -19,6 +19,8 @@ struct rtw_hci_ops {
 	void (*link_ps)(struct rtw_dev *rtwdev, bool enter);
 	void (*interface_cfg)(struct rtw_dev *rtwdev);
 	void (*dynamic_rx_agg)(struct rtw_dev *rtwdev, bool enable);
+	void (*write_firmware_page)(struct rtw_dev *rtwdev, u32 page,
+				    const u8 *data, u32 size);
 
 	int (*write_data_rsvd_page)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
 	int (*write_data_h2c)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
@@ -79,6 +81,12 @@ static inline void rtw_hci_dynamic_rx_agg(struct rtw_dev *rtwdev, bool enable)
 		rtwdev->hci.ops->dynamic_rx_agg(rtwdev, enable);
 }
 
+static inline void rtw_hci_write_firmware_page(struct rtw_dev *rtwdev, u32 page,
+					       const u8 *data, u32 size)
+{
+	rtwdev->hci.ops->write_firmware_page(rtwdev, page, data, size);
+}
+
 static inline int
 rtw_hci_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf, u32 size)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 0491f501c138..f66d1b302dc5 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -856,8 +856,8 @@ static void en_download_firmware_legacy(struct rtw_dev *rtwdev, bool en)
 	}
 }
 
-static void
-write_firmware_page(struct rtw_dev *rtwdev, u32 page, const u8 *data, u32 size)
+void rtw_write_firmware_page(struct rtw_dev *rtwdev, u32 page,
+			     const u8 *data, u32 size)
 {
 	u32 val32;
 	u32 block_nr;
@@ -887,6 +887,7 @@ write_firmware_page(struct rtw_dev *rtwdev, u32 page, const u8 *data, u32 size)
 		rtw_write32(rtwdev, write_addr, le32_to_cpu(remain_data));
 	}
 }
+EXPORT_SYMBOL(rtw_write_firmware_page);
 
 static int
 download_firmware_legacy(struct rtw_dev *rtwdev, const u8 *data, u32 size)
@@ -904,11 +905,13 @@ download_firmware_legacy(struct rtw_dev *rtwdev, const u8 *data, u32 size)
 	rtw_write8_set(rtwdev, REG_MCUFW_CTRL, BIT_FWDL_CHK_RPT);
 
 	for (page = 0; page < total_page; page++) {
-		write_firmware_page(rtwdev, page, data, DLFW_PAGE_SIZE_LEGACY);
+		rtw_hci_write_firmware_page(rtwdev, page, data,
+					    DLFW_PAGE_SIZE_LEGACY);
 		data += DLFW_PAGE_SIZE_LEGACY;
 	}
 	if (last_page_size)
-		write_firmware_page(rtwdev, page, data, last_page_size);
+		rtw_hci_write_firmware_page(rtwdev, page, data,
+					    last_page_size);
 
 	if (!check_hw_ready(rtwdev, REG_MCUFW_CTRL, BIT_FWDL_CHK_RPT, 1)) {
 		rtw_err(rtwdev, "failed to check download firmware report\n");
diff --git a/drivers/net/wireless/realtek/rtw88/mac.h b/drivers/net/wireless/realtek/rtw88/mac.h
index 6905e2747372..e92b1483728d 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.h
+++ b/drivers/net/wireless/realtek/rtw88/mac.h
@@ -34,6 +34,8 @@ int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
 		       const struct rtw_pwr_seq_cmd * const *cmd_seq);
 int rtw_mac_power_on(struct rtw_dev *rtwdev);
 void rtw_mac_power_off(struct rtw_dev *rtwdev);
+void rtw_write_firmware_page(struct rtw_dev *rtwdev, u32 page,
+			     const u8 *data, u32 size);
 int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw);
 int rtw_mac_init(struct rtw_dev *rtwdev);
 void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop);
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index bb4c4ccb31d4..7f2b6dc21f56 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -12,6 +12,7 @@
 #include "fw.h"
 #include "ps.h"
 #include "debug.h"
+#include "mac.h"
 
 static bool rtw_disable_msi;
 static bool rtw_pci_disable_aspm;
@@ -1602,6 +1603,7 @@ static const struct rtw_hci_ops rtw_pci_ops = {
 	.link_ps = rtw_pci_link_ps,
 	.interface_cfg = rtw_pci_interface_cfg,
 	.dynamic_rx_agg = NULL,
+	.write_firmware_page = rtw_write_firmware_page,
 
 	.read8 = rtw_pci_read8,
 	.read16 = rtw_pci_read16,
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 71cbe49b6c59..e733ed846123 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -10,6 +10,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio_func.h>
 #include "main.h"
+#include "mac.h"
 #include "debug.h"
 #include "fw.h"
 #include "ps.h"
@@ -1164,6 +1165,7 @@ static const struct rtw_hci_ops rtw_sdio_ops = {
 	.link_ps = rtw_sdio_link_ps,
 	.interface_cfg = rtw_sdio_interface_cfg,
 	.dynamic_rx_agg = NULL,
+	.write_firmware_page = rtw_write_firmware_page,
 
 	.read8 = rtw_sdio_read8,
 	.read16 = rtw_sdio_read16,
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index b16db579fdce..3b5126ffc81a 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -165,6 +165,60 @@ static void rtw_usb_write32(struct rtw_dev *rtwdev, u32 addr, u32 val)
 	rtw_usb_write(rtwdev, addr, val, 4);
 }
 
+static void rtw_usb_write_firmware_page(struct rtw_dev *rtwdev, u32 page,
+					const u8 *data, u32 size)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	struct usb_device *udev = rtwusb->udev;
+	u32 addr = FW_START_ADDR_LEGACY;
+	u8 *data_dup, *buf;
+	u32 n, block_size;
+	int ret;
+
+	switch (rtwdev->chip->id) {
+	case RTW_CHIP_TYPE_8723D:
+		block_size = 254;
+		break;
+	default:
+		block_size = 196;
+		break;
+	}
+
+	data_dup = kmemdup(data, size, GFP_KERNEL);
+	if (!data_dup)
+		return;
+
+	buf = data_dup;
+
+	rtw_write32_mask(rtwdev, REG_MCUFW_CTRL, BIT_ROM_PGE, page);
+
+	while (size > 0) {
+		if (size >= block_size)
+			n = block_size;
+		else if (size >= 8)
+			n = 8;
+		else
+			n = 1;
+
+		ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+				      RTW_USB_CMD_REQ, RTW_USB_CMD_WRITE,
+				      addr, 0, buf, n, 500);
+		if (ret != n) {
+			if (ret != -ENODEV)
+				rtw_err(rtwdev,
+					"write 0x%x len %d failed: %d\n",
+					addr, n, ret);
+			break;
+		}
+
+		addr += n;
+		buf += n;
+		size -= n;
+	}
+
+	kfree(data_dup);
+}
+
 static int dma_mapping_to_ep(enum rtw_dma_mapping dma_mapping)
 {
 	switch (dma_mapping) {
@@ -892,6 +946,7 @@ static const struct rtw_hci_ops rtw_usb_ops = {
 	.link_ps = rtw_usb_link_ps,
 	.interface_cfg = rtw_usb_interface_cfg,
 	.dynamic_rx_agg = rtw_usb_dynamic_rx_agg,
+	.write_firmware_page = rtw_usb_write_firmware_page,
 
 	.write8  = rtw_usb_write8,
 	.write16 = rtw_usb_write16,
-- 
2.49.0


