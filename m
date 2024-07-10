Return-Path: <linux-wireless+bounces-10161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB59792DBAF
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 00:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2D21C20CB2
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 22:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E06A146D7D;
	Wed, 10 Jul 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHlaJ4zv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB251465B1
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649500; cv=none; b=WxKuV2L2gwicIlXIp2Zt57kNKuxcwOR+1MoCOUpM57uWXYc3UginuwaIcquqXiZnGmRwZeV1n0z1Q6UAuP+px88Gn6Mqq2QKks4oeTx99HAbsJ04WZll1rDQGYfCM59dMAAXURyPJtkwKyRaBTv5nZyd6rNd0m2nEJGv3/GOCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649500; c=relaxed/simple;
	bh=qZ9U8YN+f18JOkRbSH6+hag2OH1UF2tA5ZGm7uwRc1A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ft3zSjNMrROimNq2QdoI72GjKekuyTYea0qf9b7i1rn4lwu6zB8P6eNN39olClZUY4l75FWYmNMX2dkn+uSMtg38HGeHNdbdbiflkT2Uydppw8grhKNXuuRTeF1wbApJAF6SlSZS4oqFW65330zxlF82wo8ajJhzTJbbLP/mhJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHlaJ4zv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea7bdde68so281316e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 15:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720649496; x=1721254296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaHXMA+Rwsh5qEMFjQRgFo7omOu+wdsZBvUMkE+xSEI=;
        b=gHlaJ4zvpBh5HyLfV0gNyCaUdH1swZaFCZYxlow0m32DU8C0ooBclOMNIgdOxXha1U
         nCIVnhsuBd4qqgmrSwtuX1AAStX1zbvYcd6xVDX6F0c6BZiPS5NazRo6TH6xnDeOawUY
         WNw+plaz2JFoqHn4Cc9nBA9jgdB43hrNZD5q3UYjdrrzgchm+Pv+ptbcXIaWqRsC3CGn
         eGLuR5kTaekUWL6whvYUNJbreG7v/VDJzjeZn4YH7i9dsk0RN+Qy+In/b3/ets2Xqis1
         WxiCXjzx2xmR8AkcBvEFRLi7GfplCREfHOjq6Y0V+ta4UTWvJQGJCDdZhKc34oTZTIIj
         MKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720649496; x=1721254296;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RaHXMA+Rwsh5qEMFjQRgFo7omOu+wdsZBvUMkE+xSEI=;
        b=oxU1lbjnFD+wNm1sKHDP++rXfl4G/b8mhlcQjqjJScrBbx05NFibEAM5isOHr6Fd1v
         wBzKKeAcogHxav6hQQzu9io9i1roJifg7eh6JteLnXavwDQDDwfGAIi6d50QccUYQpZE
         Mt0xKAmqK/rYUqkT2/GRMAsQJpNoJWN7YdTOnl71LZ7FIDgQYeYBfkPbV8lGskocRgxB
         0GxO9IS2ouF3zDLtj+tn7AiP2gF9EXzLPZ2EmnocLpKs6yA9SWVXml2yEGWazuJasWQr
         PNSRigz/FEkB3JTd++WF0xR/EuRZVQo+w9+6iJQ7ur6dSz1INxNJhfmu55/mhcg7Gj4+
         jxpg==
X-Gm-Message-State: AOJu0YxcZl2HnZFI97bx2DRbXYGc6HAjkj2CMsDFcHkYg5RqNMNDwr8p
	6a/Gjw5zFCim1mSMM7lPsk+wI2b5dceeITKxOP+jqIRqYshAt19lVl+3KA==
X-Google-Smtp-Source: AGHT+IFaXvuRj7q3RV4AAKvEO0aGJteUYLAT58aG53BZAd0cIdr9/BD8+pr7isgmNXzlx67kgQkuwA==
X-Received: by 2002:a05:6512:1244:b0:52d:8f80:6444 with SMTP id 2adb3069b0e04-52eb99a194cmr4774516e87.32.1720649495716;
        Wed, 10 Jul 2024 15:11:35 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc721sm193645266b.53.2024.07.10.15.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 15:11:35 -0700 (PDT)
Message-ID: <77906c62-5674-426f-bde1-1b2a12a0339d@gmail.com>
Date: Thu, 11 Jul 2024 01:11:33 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
 Sascha Hauer <sha@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The Realtek wifi 5 devices which support USB 3 are weird: when first
plugged in, they pretend to be USB 2. The driver needs to send some
commands to the device, which make it disappear and come back as a
USB 3 device.

Implement the required commands in rtw88.

When a USB 3 device is plugged into a USB 2 port, rtw88 will try to
switch it to USB 3 mode only once. The device will disappear and come
back still in USB 2 mode, of course.

Some people experience heavy interference in the 2.4 GHz band in
USB 3 mode, so add a module parameter switch_usb_mode with the
default value 1 to let people disable the switching.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Make the module parameter description clearer.
 - Replace rtw_info with rtw_dbg. Add RTW_DBG_USB flag for this purpose.
 - Delete unnecessary parentheses pointed out by checkpatch.
---
 drivers/net/wireless/realtek/rtw88/debug.h    |  1 +
 drivers/net/wireless/realtek/rtw88/main.h     |  2 +
 drivers/net/wireless/realtek/rtw88/reg.h      | 11 +++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.h |  4 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.h | 24 +++---
 drivers/net/wireless/realtek/rtw88/usb.c      | 84 +++++++++++++++++++
 8 files changed, 116 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.h b/drivers/net/wireless/realtek/rtw88/debug.h
index eb69006c463e..9a1e0e85a13c 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.h
+++ b/drivers/net/wireless/realtek/rtw88/debug.h
@@ -25,6 +25,7 @@ enum rtw_debug_mask {
 	RTW_DBG_HW_SCAN		= 0x00010000,
 	RTW_DBG_STATE		= 0x00020000,
 	RTW_DBG_SDIO		= 0x00040000,
+	RTW_DBG_USB		= 0x00080000,
 
 	RTW_DBG_UNEXP		= 0x80000000,
 	RTW_DBG_ALL		= 0xffffffff
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 49a3fd4fb7dc..9d21637cf5d5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1785,6 +1785,8 @@ struct rtw_efuse {
 	bool share_ant;
 	u8 bt_setting;
 
+	u8 usb_mode_switch;
+
 	struct {
 		u8 hci;
 		u8 bw;
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 02ef9a77316b..e7b24465f549 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -15,6 +15,7 @@
 #define BIT_WLOCK_1C_B6		BIT(5)
 #define REG_SYS_PW_CTRL		0x0004
 #define BIT_PFM_WOWL		BIT(3)
+#define BIT_APFM_OFFMAC		BIT(9)
 #define REG_SYS_CLK_CTRL	0x0008
 #define BIT_CPU_CLK_EN		BIT(14)
 
@@ -133,6 +134,14 @@
 #define REG_PMC_DBG_CTRL1	0xa8
 #define BITS_PMC_BT_IQK_STS	GENMASK(22, 21)
 
+#define REG_PAD_CTRL2		0x00C4
+#define BIT_RSM_EN_V1		BIT(16)
+#define BIT_NO_PDN_CHIPOFF_V1	BIT(17)
+#define BIT_MASK_USB23_SW_MODE_V1	GENMASK(19, 18)
+#define BIT_USB3_USB2_TRANSITION	BIT(20)
+#define BIT_USB_MODE_U2		1
+#define BIT_USB_MODE_U3		2
+
 #define REG_EFUSE_ACCESS	0x00CF
 #define EFUSE_ACCESS_ON		0x69
 #define EFUSE_ACCESS_OFF	0x00
@@ -568,6 +577,8 @@
 #define BIT_WL_SECURITY_CLK	BIT(15)
 #define BIT_DDMA_EN		BIT(8)
 
+#define REG_SW_MDIO		0x10C0
+
 #define REG_H2C_PKT_READADDR	0x10D0
 #define REG_H2C_PKT_WRITEADDR	0x10D4
 #define REG_FW_DBG6		0x10F8
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 2456ff242818..6edb17aea90e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -46,6 +46,7 @@ static int rtw8822b_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 
 	map = (struct rtw8822b_efuse *)log_map;
 
+	efuse->usb_mode_switch = u8_get_bits(map->usb_mode, BIT(7));
 	efuse->rfe_option = map->rfe_option;
 	efuse->rf_board_option = map->rf_board_option;
 	efuse->crystal_cap = map->xtal_k;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.h b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
index 2dc3a6660f06..cf85e63966a1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
@@ -72,7 +72,9 @@ struct rtw8822bs_efuse {
 
 struct rtw8822b_efuse {
 	__le16 rtl_id;
-	u8 res0[0x0e];
+	u8 res0[4];
+	u8 usb_mode;
+	u8 res1[0x09];
 
 	/* power index for four RF paths */
 	struct rtw_txpwr_idx txpwr_idx_table[4];
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 62376d1cca22..bc807b13e9ce 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -49,6 +49,7 @@ static int rtw8822c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 
 	map = (struct rtw8822c_efuse *)log_map;
 
+	efuse->usb_mode_switch = u8_get_bits(map->usb_mode, BIT(7));
 	efuse->rfe_option = map->rfe_option;
 	efuse->rf_board_option = map->rf_board_option;
 	efuse->crystal_cap = map->xtal_k & XCAP_MASK;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index 1bc0e7f5d6bb..e2b383d633cd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -59,16 +59,18 @@ struct rtw8822ce_efuse {
 
 struct rtw8822c_efuse {
 	__le16 rtl_id;
-	u8 res0[0x0e];
+	u8 res0[4];
+	u8 usb_mode;
+	u8 res1[0x09];
 
 	/* power index for four RF paths */
 	struct rtw_txpwr_idx txpwr_idx_table[4];
 
 	u8 channel_plan;		/* 0xb8 */
 	u8 xtal_k;
-	u8 res1;
+	u8 res2;
 	u8 iqk_lck;
-	u8 res2[5];			/* 0xbc */
+	u8 res3[5];			/* 0xbc */
 	u8 rf_board_option;
 	u8 rf_feature_option;
 	u8 rf_bt_setting;
@@ -80,21 +82,21 @@ struct rtw8822c_efuse {
 	u8 rf_antenna_option;		/* 0xc9 */
 	u8 rfe_option;
 	u8 country_code[2];
-	u8 res3[3];
+	u8 res4[3];
 	u8 path_a_thermal;		/* 0xd0 */
 	u8 path_b_thermal;
-	u8 res4[2];
+	u8 res5[2];
 	u8 rx_gain_gap_2g_ofdm;
-	u8 res5;
-	u8 rx_gain_gap_2g_cck;
 	u8 res6;
-	u8 rx_gain_gap_5gl;
+	u8 rx_gain_gap_2g_cck;
 	u8 res7;
-	u8 rx_gain_gap_5gm;
+	u8 rx_gain_gap_5gl;
 	u8 res8;
-	u8 rx_gain_gap_5gh;
+	u8 rx_gain_gap_5gm;
 	u8 res9;
-	u8 res10[0x42];
+	u8 rx_gain_gap_5gh;
+	u8 res10;
+	u8 res11[0x42];
 	union {
 		struct rtw8822ce_efuse e;
 		struct rtw8822cu_efuse u;
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index a55ca5a24227..251a5726f3ee 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -14,6 +14,11 @@
 #include "ps.h"
 #include "usb.h"
 
+static bool rtw_switch_usb_mode = true;
+module_param_named(switch_usb_mode, rtw_switch_usb_mode, bool, 0644);
+MODULE_PARM_DESC(switch_usb_mode,
+		 "Set to N to disable switching to USB 3 mode to avoid potential interference in the 2.4 GHz band (default: Y)");
+
 #define RTW_USB_MAX_RXQ_LEN	512
 
 struct rtw_usb_txcb {
@@ -841,6 +846,77 @@ static void rtw_usb_intf_deinit(struct rtw_dev *rtwdev,
 	usb_set_intfdata(intf, NULL);
 }
 
+static int rtw_usb_switch_mode_new(struct rtw_dev *rtwdev)
+{
+	enum usb_device_speed cur_speed;
+	u8 id = rtwdev->chip->id;
+	bool can_switch;
+	u32 pad_ctrl2;
+
+	if (rtw_read8(rtwdev, REG_SYS_CFG2 + 3) == 0x20)
+		cur_speed = USB_SPEED_SUPER;
+	else
+		cur_speed = USB_SPEED_HIGH;
+
+	if (cur_speed == USB_SPEED_SUPER)
+		return 0;
+
+	pad_ctrl2 = rtw_read32(rtwdev, REG_PAD_CTRL2);
+
+	can_switch = !!(pad_ctrl2 & (BIT_MASK_USB23_SW_MODE_V1 |
+				     BIT_USB3_USB2_TRANSITION));
+
+	if (!can_switch) {
+		rtw_dbg(rtwdev, RTW_DBG_USB,
+			"Switching to USB 3 mode unsupported by the chip\n");
+		return 0;
+	}
+
+	/* At this point cur_speed is USB_SPEED_HIGH. If we already tried
+	 * to switch don't try again - it's a USB 2 port.
+	 */
+	if (u32_get_bits(pad_ctrl2, BIT_MASK_USB23_SW_MODE_V1) == BIT_USB_MODE_U3)
+		return 0;
+
+	/* Enable IO wrapper timeout */
+	if (id == RTW_CHIP_TYPE_8822B || id == RTW_CHIP_TYPE_8821C)
+		rtw_write8_clr(rtwdev, REG_SW_MDIO + 3, BIT(0));
+
+	u32p_replace_bits(&pad_ctrl2, BIT_USB_MODE_U3, BIT_MASK_USB23_SW_MODE_V1);
+	pad_ctrl2 |= BIT_RSM_EN_V1;
+
+	rtw_write32(rtwdev, REG_PAD_CTRL2, pad_ctrl2);
+	rtw_write8(rtwdev, REG_PAD_CTRL2 + 1, 4);
+
+	rtw_write16_set(rtwdev, REG_SYS_PW_CTRL, BIT_APFM_OFFMAC);
+	usleep_range(1000, 1001);
+	rtw_write32_set(rtwdev, REG_PAD_CTRL2, BIT_NO_PDN_CHIPOFF_V1);
+
+	return 1;
+}
+
+static int rtw_usb_switch_mode(struct rtw_dev *rtwdev)
+{
+	u8 id = rtwdev->chip->id;
+
+	if (id != RTW_CHIP_TYPE_8822C && id != RTW_CHIP_TYPE_8822B)
+		return 0;
+
+	if (!rtwdev->efuse.usb_mode_switch) {
+		rtw_dbg(rtwdev, RTW_DBG_USB,
+			"Switching to USB 3 mode disabled by chip's efuse\n");
+		return 0;
+	}
+
+	if (!rtw_switch_usb_mode) {
+		rtw_dbg(rtwdev, RTW_DBG_USB,
+			"Switching to USB 3 mode disabled by module parameter\n");
+		return 0;
+	}
+
+	return rtw_usb_switch_mode_new(rtwdev);
+}
+
 int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct rtw_dev *rtwdev;
@@ -896,6 +972,14 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		goto err_destroy_rxwq;
 	}
 
+	ret = rtw_usb_switch_mode(rtwdev);
+	if (ret) {
+		/* Not a fail, but we do need to skip rtw_register_hw. */
+		rtw_dbg(rtwdev, RTW_DBG_USB, "switching to USB 3 mode\n");
+		ret = 0;
+		goto err_destroy_rxwq;
+	}
+
 	ret = rtw_register_hw(rtwdev, rtwdev->hw);
 	if (ret) {
 		rtw_err(rtwdev, "failed to register hw\n");
-- 
2.45.2


