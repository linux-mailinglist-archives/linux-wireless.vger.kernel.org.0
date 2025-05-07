Return-Path: <linux-wireless+bounces-22714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C37FAAE006
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 15:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FD89A4804
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 13:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7313C1D5CD4;
	Wed,  7 May 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZDGzVGb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F2778F2B
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623123; cv=none; b=jLMJh1TEDX/dRyrYUsx5Ncw5xkcFAwJf4zQmDOIGS8dXbftTrt0zGEa7GScADCnDdoF5pFfFssC8+mO7lLTTavOGUWobi6agXd/WNit2StLhTQXMA1UWchY4/XF1RO57yKRh+RgIQRFznwEfNhHiDZFlpAtd0BWGwea8O7obbV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623123; c=relaxed/simple;
	bh=BvOseooKfuOmdOncO5h9aQCDiO/qpnhOStKy8ZTkRJM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z0Nka8wdhDDYHOEm+C/X/Qqa5wuUbWMdRt1fg1MZr9P2E4EYwz0fmlrwsizaWBDPOCL1AZ5LShonBsKaP47BdUOFMOO1YUhjkkZGduKiJ7QVVxQqZ82D+hiuy1haKxqmTpQS7QslNucjgKTfX6a9PxFo2Rxr804y7F0u0uF/cR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZDGzVGb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad1b94382b8so652820966b.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 May 2025 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623119; x=1747227919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Roh5tLgUtedpsrm9I3tMVcqDqHNbfE0f1JbPRQsBtkY=;
        b=kZDGzVGb8KEHQCA9jJCI/rOac0LkkQMDTphYqU+6+ED5LAuDigfhJwaleqroFTZm1T
         g1jioggDjFgbYTcwQ+W7moO8MCJknLt7OXsveNzeYNRWkAQfEp/ZrmGvpCFh1M4+ob2x
         hrWL1zY2ldfSyn8tVBKvspWBFrjOmiSgRkh/Nt5+cNzTYg/jRUC4mHEuhJdUbPPNf22U
         dEaFprObUonbXQ6gIx72lwrQAOGoDyAUgTwq+fSbLiGhTwOLaeD/O6aZMsH842RvIQ37
         Ys/i0zaioMmgl8+VFIY54aQ/dtV/FdvOodtgHF5culyV8Lgp4qf5wHkjS+sv8VS3Dvfq
         7T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623119; x=1747227919;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Roh5tLgUtedpsrm9I3tMVcqDqHNbfE0f1JbPRQsBtkY=;
        b=j1j0evUwO3J3QtLOjOw+IjtY91/RVksLYD2fnE4+belJU6jDSuC/UH15+dSABwcH7N
         r4wAdlgc1F/FrR9MDMqEYB2nHWoupKzJimlg+zqA6a9Lb3+iL16vdrpdInLIx4m94htC
         H4tDagmtbUglj8WXc2BmzYEGH+Bda73iwAC6XrNnqr3PgZFQoi4XevmJbp9DyFYH0omk
         3INTUs6pbR4HxwSZsaxoWZ4PKUduuAmXPvO7WRcTWoY2/I5B02Eu7cO8tUBS7d2GDfMT
         GXnOOek/xJrqLrpCZhs9I/U4cjr/ztoU+pB0j+hsrEqgYxa5SNQsMmucmBfGC4UGBCDz
         9AGA==
X-Gm-Message-State: AOJu0YzVY9m+RKNaVL96M+eqyamOUdQpKsYXDEBRePAunrR0h2wk95sZ
	GKS1S5hnbvB4CktI4CgXeNOhlVgRxMhG8R1eAYK3hjh60Z/lKMHquSJjcQ==
X-Gm-Gg: ASbGnctET0Gx7+RVC8Jkk3n7u21uqV/eOF6pGiMwT+Trh0W4IazgRZbe0Tt9BFNbmif
	0czqwxpImnkOVNwGYGBXLClmX7V5UygeYdfhW8pEMW8W0sBPEnP8CMUgAc0qYKme1B7Fc1hjowq
	XU3yc2KNwr9V+ddd3N5DXBWuTHOK4sW1c6Htmqh6LS0fpGxcmQRVXGUbML4fM+JFN2ctYhjCIXN
	9Sf4NO9PlCtkvjHEidz2kf+YI0d1+IhJw/yYCpP3CHd72QfPrMBqY7fJM2anlbW/KvIOeyuTYJF
	VHI/VE3YACFJM28jI9CiC+FwWJFALYEIdvfjrLCyisuSuYQ/Oa2RmY03Ppqc
X-Google-Smtp-Source: AGHT+IGmXUAhZUzBC629t8x7RE/8g0IPF8WFqMzLdznOUK2QwtDTmy+E2GUir9rZ16fjYpfmg87+VQ==
X-Received: by 2002:a17:907:948c:b0:ac7:eb12:dc69 with SMTP id a640c23a62f3a-ad1e8c4be94mr332638766b.28.1746623119078;
        Wed, 07 May 2025 06:05:19 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a3cb9sm913650266b.60.2025.05.07.06.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 06:05:17 -0700 (PDT)
Message-ID: <9faaa45f-9ba8-46dc-b507-f97b3b6f52d3@gmail.com>
Date: Wed, 7 May 2025 16:05:16 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 2/2] wifi: rtw88: usb: Upload the firmware in bigger
 chunks
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <af4d2d58-f567-4bdf-841b-8345d21f7035@gmail.com>
Content-Language: en-US
In-Reply-To: <af4d2d58-f567-4bdf-841b-8345d21f7035@gmail.com>
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
index b16db579fdce..ad15ce12ab7f 100644
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
+	u32 addr = FW_8192C_START_ADDRESS;
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


