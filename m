Return-Path: <linux-wireless+bounces-10017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C436B928F5C
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 00:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E773E1C217BC
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641DB144D16;
	Fri,  5 Jul 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGPcW3Rk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D90A955
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720219177; cv=none; b=Bca74Z+vAyy4PSBNnASQtiI7uO5+SAHyESOa64yFCA8UcJsfiyXlPBc9kpRB8TcVDWPiSpOUOAx9bL8/pjosQm2dOkuGfbFru1dgJnIUWCXKgv5HhJMPncZRpw/sEmWULleusRUrhHKf5fUHqrYjZmP2ZCrujuqhG2MsFHOamMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720219177; c=relaxed/simple;
	bh=QxVPWqmHECJ1BSg8hifYfLKGML+JxzxDi7GzT16wIDk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=C0Im92JxPfSwbci5zrmYiKpi2UoGsOgEeA5ZLQ+o7WIvhU0/UHSZXEx6UuW9sLjX21/DgW//MxT796LSexo9wzURJgLB6kJd5kx8jjRYrN3oj6wiy77/Bfvl782iL0SFB9jn2iWU4Vfobygtt3iVEJqxUxFlUk8giFbaoN72F5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGPcW3Rk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77c9d3e593so136984066b.0
        for <linux-wireless@vger.kernel.org>; Fri, 05 Jul 2024 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720219174; x=1720823974; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9Lsou1vo+5xFLYztrMYxUrj0tHMokk0CjkxGAm89Ag=;
        b=fGPcW3RkKZZp/IoQHOuGWLcDLDOF1SCSPtUZCN0nzwxCmfiJ0pwKjeosPaJSoZWsGz
         F19xF0ZkLBLg9SWRkV+zu6l2ePnx5/8lmb8JBIl9JiEojrDSbgykgmpRWiqiFuN2AxO6
         tAaPb2m4aKy3rfmK+yCgZBMAy2AKNcLVCKz85vGqxjz3ReIrzytcH8gF/5k7nILSeP0+
         gptpPnnMDGls/A0XAF78WFZvJkgzpVRPZ6S0sbclkaKNY1tSJJ1kj0n2FOOGU5GXqPxY
         zyVC5YC//wMtSsRRLI5MEwhrz0VDe6zo5U31whC8V/uV7uXkMW3kbFYddHIsvcPo4xzC
         2pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720219174; x=1720823974;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v9Lsou1vo+5xFLYztrMYxUrj0tHMokk0CjkxGAm89Ag=;
        b=FxBrtoRm3c5/vD3Nw9Cy+SvUN83HV1JaEJhvNikpk8Swb301CSXtaut0FbdAVZh0up
         Y+CjtUgmlRLf1sRWLDPZRPVJXaXtTMl7LgvAzFfLf0h38ms1bkUWfRbDDk9Ltdh+KPvD
         u0878tA2BWLGudMHPspP5fxCNMtIrJlcaMUcv90tZYnuOrVlRYaUErunLmRURNO8r/7D
         09T6Kbq8soPguhEu8q1ixZ/FMSqa6u8e6waOGW+miI+jtCNa3DVbrFitpll9iR2mQFfN
         0AbhW/+gHUYLPrctxiTwsAeyjyoEH+SMkcbzGaKC/GACB9271d2cKIAkqWn2Fq75VNfx
         R5jg==
X-Gm-Message-State: AOJu0YwfjIVC9NrmIbFXcYyA3NeuNR1qw4eixBrPXzx11nn9GaB9UEuJ
	ZqdX3qCyBLxyhNAnDRwcw0rE2oJHD05tOLVFfcapJ102tq7o8yEqIVWajA==
X-Google-Smtp-Source: AGHT+IHE6dV9M/GnVUEoBWspHQh2cXi65e8fepAfCEQ5uiKqdxgqidHoVci3sa21Fta6K2CD2U6e6Q==
X-Received: by 2002:a17:906:7198:b0:a72:60e2:bdf with SMTP id a640c23a62f3a-a77ba711971mr357393566b.50.1720219173419;
        Fri, 05 Jul 2024 15:39:33 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c3772ad5sm135233366b.173.2024.07.05.15.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 15:39:33 -0700 (PDT)
Message-ID: <2378105e-041a-4973-937f-e3efdc9ce0e8@gmail.com>
Date: Sat, 6 Jul 2024 01:39:31 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
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
A later patch will add the function rtw_usb_switch_mode_old() for the
older chips RTL8812AU and RTL8814AU.
---
 drivers/net/wireless/realtek/rtw88/main.h     |  2 +
 drivers/net/wireless/realtek/rtw88/reg.h      | 11 +++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.h |  4 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.h | 24 +++---
 drivers/net/wireless/realtek/rtw88/usb.c      | 84 +++++++++++++++++++
 7 files changed, 115 insertions(+), 12 deletions(-)

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
index a55ca5a24227..a59e52a0da10 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -14,6 +14,11 @@
 #include "ps.h"
 #include "usb.h"
 
+static bool rtw_switch_usb_mode = true;
+module_param_named(switch_usb_mode, rtw_switch_usb_mode, bool, 0644);
+MODULE_PARM_DESC(switch_usb_mode,
+		 "Set to Y to switch to USB 3 mode (default: Y)");
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
+		rtw_info(rtwdev,
+			 "Switching to USB 3 mode unsupported by the chip\n");
+		return 0;
+	}
+
+	/* At this point cur_speed is USB_SPEED_HIGH. If we already tried
+	 * to switch don't try again - it's a USB 2 port.
+	 */
+	if ((u32_get_bits(pad_ctrl2, BIT_MASK_USB23_SW_MODE_V1) == BIT_USB_MODE_U3))
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
+		rtw_info(rtwdev,
+			 "Switching to USB 3 mode disabled by chip's efuse\n");
+		return 0;
+	}
+
+	if (!rtw_switch_usb_mode) {
+		rtw_info(rtwdev,
+			 "Switching to USB 3 mode disabled by module parameter\n");
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
+		rtw_info(rtwdev, "switching to USB 3 mode\n");
+		ret = 0;
+		goto err_destroy_rxwq;
+	}
+
 	ret = rtw_register_hw(rtwdev, rtwdev->hw);
 	if (ret) {
 		rtw_err(rtwdev, "failed to register hw\n");
-- 
2.45.1


