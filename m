Return-Path: <linux-wireless+bounces-36713-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JzuHdfJDWo33QUAu9opvQ
	(envelope-from <linux-wireless+bounces-36713-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 16:48:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEAB59009B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 16:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92CF930741F2
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBBC3EDAB7;
	Wed, 20 May 2026 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T639/esG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9283EE1CC
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288281; cv=none; b=D0PUf0y1gnAICZT/Xychj0RBx9TrjBjwrUNksOHhPvGX/6ibMHCz1ocUbWAwMCV/KK6T2WshagHx8kXcflBuioT+lMaplvFCCNkS/PEoHXdpJofE8R73MzSU6YwlbPE5ZvIvgSzaBOc5W/WYFc4GrYJATZaSL6qUynKMtJm/ptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288281; c=relaxed/simple;
	bh=MYxXA7PU/NQrHtwQ/gonOUrxNolNUctnP1r/NdM0+4A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=HOMRgMaWrBy79XXO3DNP+5MThdalaT0vQz4YUCoqg2Rv5365+eo4b9rieZbSPG8OrMpozcyrofUdqhGIkhzPsdkNa3u5uFHrDIUTlX+tnijQqwKoXAgIYqEmeNkGzGkTE3QFthNDyCTbAilTJn/8ZHLF6+LXfLkoH4ysuVgQUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T639/esG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso37425445e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779288277; x=1779893077; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU1FeExlCvWFVZvNK0FP5+DrXdEo+HfelhTkWLaYKPI=;
        b=T639/esG3GCHx4HX/SuWRa7OnfELRp1y3FX+1S/S9+Bj1bgt/HXFDlX3Tt6/fRk8f/
         GkC1tlfVqg5+d66K1kkMafl5HgQuWTKF2qqTs+9MZaQbWuzBvy2sJGldfma9O+EG4KvP
         +lDqCtYCOcsHLTZMc+Ixz5+cNAt6abB3TZ6RQJbWzmzTWXi42Pp8lUDi9tsTDGvepXhH
         jcAfAtZU7ZcJ0BHXp2bzt64vDBvaji3OYjLa40ZQnY1f3FUm2J3N7kS2M7CN4rFYewvI
         lrPOF2yhdz1NujjQ+eS03oS8lnl9q/L8TZk3wnLt85kgDwRCMbXerBNYwjgyLndF1gzH
         c+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288277; x=1779893077;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jU1FeExlCvWFVZvNK0FP5+DrXdEo+HfelhTkWLaYKPI=;
        b=FLb9y9s2GioXkrcDa4ObPoX2tzrhjou5oYEn06F1TJ0Jwz/74zb2f2lEWmJpZG8JW9
         IA2Fxjy0hUnj0D6ZO+ProYhghxVQg2uUYvNb9+8azDD+U+mBxuD6CiT1JlZ0k9hqKzCW
         JO+gXaD4p7PnbcCiC+hB6KO8e1yTjDJPeuk1IC2Nyr/BjmyR+WUh7s1SVXlnSvw3ltyE
         G58M7S0jbhAW8/putnkfOhe5kdA8569hkZbGsKLFY0o801WybW1oDcLnQ6lGvwrniiF8
         Xs6uu+9ASnFo5Ul6htlrkUXKvDCoenDSewWWvYtddHhRF6Ntbc2Kv8gUJfNC6cIF+GDM
         WSHA==
X-Gm-Message-State: AOJu0YwZngB8M0oC+e0mji9o/eG+6nucDj4c/o48njNdCTHXQB9hzL0L
	p9fQM7AZTTLeaceNqsZwouVelrFkKUn/4mKtF1+oFxSw7xSC+wUOOOPclHBzgQ==
X-Gm-Gg: Acq92OFnqvXsXTAvTJzSjKPgXBB12i6MwjqQAupf4+LSCuq6cSuI4IfAF9wPyIatd0J
	6gc5sKuzJ7HnjMOQ4uPU1/iQ3oHoBFXiTzMw79hRYpgDPWEIZG0AvJNAg/JxB29W74BCV8SkKVc
	kHH+isWQpAN1z33xzL7K7l1hEJslDlsU0p5bzCe9hiORSjb+V4Wsssbi0iKjNxtJcVjyM8F/Jl+
	QG8yiCFW6SSAbsPq4WICLRKqx7RSnf8oElg4YvpKTBUT/ymJquUdgvi9LwP/XvHS4sNVmgBk/K7
	tTea/kk+iSumnl1R7S6r1DfW/CWAGBIXjJeX6lLiS/jJdQPkmAE+MXqZJCSpkH5wcybUWH6VilU
	L0Oc1Wjl0kIt8oZ+If+Zdn5Jm5/Le3DZbIVm2PPFhD09RBIbU1CsxRa5+S/9e44IWIGTWV4fREc
	PLYdID1C8rH5jWHCDcT8Z2qJbS8GQxM96PS7b1ZGV7BQ==
X-Received: by 2002:a05:600c:4e47:b0:48e:8345:6f8f with SMTP id 5b1f17b1804b1-48fe632361fmr395405105e9.18.1779288277379;
        Wed, 20 May 2026 07:44:37 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe5821fsm132575095e9.14.2026.05.20.07.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 07:44:36 -0700 (PDT)
Message-ID: <e955451c-93a1-4d04-8024-d224a04f1d4a@gmail.com>
Date: Wed, 20 May 2026 17:44:35 +0300
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
Subject: [PATCH rtw-next v4] wifi: rtw89: usb: Support switching to USB 3 mode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36713-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1EEAB59009B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Realtek wifi 6/7 devices which support USB 3 are weird: when first
plugged in, they pretend to be USB 2. The driver needs to send some
commands to the device, which make it disappear and come back as a
USB 3 device.

Implement the required commands in rtw89.

Add a new function rtw89_usb_write32_quiet() to avoid the warnings
when writing to R_{AX,BE}_PAD_CTRL2. Even though the write succeeds,
usb_control_msg() returns -EPROTO, probably because the USB device
disappears immediately. This results in some confusing warnings in
the kernel log.

When a USB 3 device is plugged into a USB 2 port, rtw89 will try to
switch it to USB 3 mode only once. The device will disappear and come
back still in USB 2 mode, of course.

Tested with RTL8832AU, RTL8832BU, RTL8832CU, and RTL8912AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v4:
 - Use a wrapper around rtw89_usb_vendorreq().
 - Add a warning message about 2.4 GHz interference.

v3:
 - Avoid crash when trying to switch.
 - Remove the unwanted module parameter.
 - Support RTL8922AU as well.
 - Use more bit names.
 - Hide the warnings when writing R_AX_PAD_CTRL2.
---
 drivers/net/wireless/realtek/rtw89/reg.h |  27 ++++++
 drivers/net/wireless/realtek/rtw89/usb.c | 104 ++++++++++++++++++++++-
 2 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c9bfb163c32e..76e107091d3b 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -164,6 +164,19 @@
 #define R_AX_DBG_PORT_SEL 0x00C0
 #define B_AX_DEBUG_ST_MASK GENMASK(31, 0)
 
+#define R_AX_PAD_CTRL2 0x00C4
+#define B_AX_FORCE_U3_CK BIT(23)
+#define B_AX_USB2_FORCE BIT(22)
+#define B_AX_USB3_FORCE BIT(21)
+#define B_AX_USB3_USB2_TRANSITION BIT(20)
+#define B_AX_USB23_SW_MODE_V1 GENMASK(19, 18)
+#define USB_MODE_U2 0x1
+#define USB_MODE_U3 0x2
+#define B_AX_NO_PDN_CHIPOFF_V1 BIT(17)
+#define B_AX_RSM_EN_V1 BIT(16)
+#define B_AX_MATCH_CNT GENMASK(15, 8)
+#define USB_SWITCH_DELAY 0xF
+
 #define R_AX_PMC_DBG_CTRL2 0x00CC
 #define B_AX_SYSON_DIS_PMCR_AX_WRMSK BIT(2)
 
@@ -4235,6 +4248,20 @@
 #define B_BE_TOGGLE BIT(31)
 #define B_BE_DATA_LINE_MASK GENMASK(30, 0)
 
+#define R_BE_PAD_CTRL2 0x00C4
+#define B_BE_USB23_SW_MODE BIT(31)
+#define B_BE_USB3_GEN_MODE BIT(30)
+#define B_BE_USB3_LANE_MODE BIT(29)
+#define B_BE_USB_AUTO_INSTALL_MASK BIT(28)
+#define B_BE_FORCE_CLK_U2 BIT(25)
+#define B_BE_FORCE_U2_CK BIT(24)
+#define B_BE_FORCE_U3_CK BIT(23)
+#define B_BE_USB2_FORCE BIT(22)
+#define B_BE_USB3_FORCE BIT(21)
+#define B_BE_NO_PDN_CHIPOFF_V1 BIT(17)
+#define B_BE_RSM_EN_V1 BIT(16)
+#define B_BE_MATCH_CNT GENMASK(15, 8)
+
 #define R_BE_PMC_DBG_CTRL2 0x00CC
 #define B_BE_EFUSE_BURN_GNT_MASK GENMASK(31, 24)
 #define B_BE_DIS_IOWRAP_TIMEOUT BIT(16)
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index c6d55e669776..198378018062 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -11,8 +11,8 @@
 
 static void rtw89_usb_read_port_complete(struct urb *urb);
 
-static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
-				void *data, u16 len, u8 reqtype)
+static void __rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
+				  void *data, u16 len, u8 reqtype, bool warn)
 {
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
 	struct usb_device *udev = rtwusb->udev;
@@ -52,7 +52,7 @@ static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
 
 		if (ret == -ESHUTDOWN || ret == -ENODEV)
 			set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
-		else if (ret < 0)
+		else if (ret < 0 && warn)
 			rtw89_warn(rtwdev,
 				   "usb %s%u 0x%x fail ret=%d value=0x%x attempt=%d\n",
 				   str_read_write(reqtype == RTW89_USB_VENQT_READ),
@@ -69,6 +69,12 @@ static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
 	}
 }
 
+static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
+				void *data, u16 len, u8 reqtype)
+{
+	__rtw89_usb_vendorreq(rtwdev, addr, data, len, reqtype, true);
+}
+
 static u32 rtw89_usb_read_cmac(struct rtw89_dev *rtwdev, u32 addr)
 {
 	u32 addr32, val32, shift;
@@ -157,6 +163,14 @@ static void rtw89_usb_ops_write32(struct rtw89_dev *rtwdev, u32 addr, u32 val)
 	rtw89_usb_vendorreq(rtwdev, addr, &data, 4, RTW89_USB_VENQT_WRITE);
 }
 
+static void rtw89_usb_write32_quiet(struct rtw89_dev *rtwdev, u32 addr, u32 val)
+{
+	__le32 data = cpu_to_le32(val);
+
+	__rtw89_usb_vendorreq(rtwdev, addr, &data, 4,
+			      RTW89_USB_VENQT_WRITE, false);
+}
+
 static u32
 rtw89_usb_ops_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 					    u8 txch)
@@ -1059,6 +1073,83 @@ static void rtw89_usb_intf_deinit(struct rtw89_dev *rtwdev,
 	usb_set_intfdata(intf, NULL);
 }
 
+static int rtw89_usb_switch_mode_ax(struct rtw89_dev *rtwdev)
+{
+	u32 pad_ctrl2;
+
+	/* No known USB 3 devices with this chip. */
+	if (rtwdev->chip->chip_id == RTL8851B)
+		return 0;
+
+	pad_ctrl2 = rtw89_usb_ops_read32(rtwdev, R_AX_PAD_CTRL2);
+
+	rtw89_debug(rtwdev, RTW89_DBG_HCI, "%s: pad_ctrl2: %#x\n",
+		    __func__, pad_ctrl2);
+
+	/* Already tried to switch but it's a USB 2 port. */
+	if (u32_get_bits(pad_ctrl2, B_AX_MATCH_CNT) == USB_SWITCH_DELAY)
+		return 0;
+
+	/* Add delay to prevent some platforms would not detect USB switch */
+	u32p_replace_bits(&pad_ctrl2, USB_SWITCH_DELAY, B_AX_MATCH_CNT);
+
+	pad_ctrl2 &= ~(B_AX_FORCE_U3_CK | B_AX_USB2_FORCE |
+		       B_AX_USB3_FORCE | B_AX_USB3_USB2_TRANSITION);
+
+	u32p_replace_bits(&pad_ctrl2, USB_MODE_U3, B_AX_USB23_SW_MODE_V1);
+
+	pad_ctrl2 |= B_AX_NO_PDN_CHIPOFF_V1 | B_AX_RSM_EN_V1;
+
+	rtw89_usb_write32_quiet(rtwdev, R_AX_PAD_CTRL2, pad_ctrl2);
+
+	return 1;
+}
+
+static int rtw89_usb_switch_mode_be(struct rtw89_dev *rtwdev)
+{
+	u32 pad_ctrl2;
+
+	pad_ctrl2 = rtw89_usb_ops_read32(rtwdev, R_BE_PAD_CTRL2);
+
+	rtw89_debug(rtwdev, RTW89_DBG_HCI, "%s: pad_ctrl2: %#x\n",
+		    __func__, pad_ctrl2);
+
+	/* Already tried to switch but it's a USB 2 port. */
+	if (u32_get_bits(pad_ctrl2, B_BE_MATCH_CNT) == USB_SWITCH_DELAY)
+		return 0;
+
+	/* Add delay to prevent some platforms would not detect USB switch */
+	u32p_replace_bits(&pad_ctrl2, USB_SWITCH_DELAY, B_BE_MATCH_CNT);
+
+	pad_ctrl2 |= B_BE_RSM_EN_V1 | B_BE_NO_PDN_CHIPOFF_V1 |
+		     B_BE_USB_AUTO_INSTALL_MASK | B_BE_USB23_SW_MODE;
+
+	pad_ctrl2 &= ~(B_BE_USB3_FORCE | B_BE_USB2_FORCE |
+		       B_BE_FORCE_U3_CK | B_BE_FORCE_U2_CK |
+		       B_BE_FORCE_CLK_U2 | B_BE_USB3_GEN_MODE |
+		       B_BE_USB3_LANE_MODE);
+
+	rtw89_usb_write32_quiet(rtwdev, R_BE_PAD_CTRL2, pad_ctrl2);
+
+	return 1;
+}
+
+static int rtw89_usb_switch_mode(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+
+	if (rtwusb->udev->speed == USB_SPEED_SUPER) {
+		rtw89_info(rtwdev,
+			   "2.4 GHz performance may be better in a USB 2 port\n");
+		return 0;
+	}
+
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_AX)
+		return rtw89_usb_switch_mode_ax(rtwdev);
+
+	return rtw89_usb_switch_mode_be(rtwdev);
+}
+
 int rtw89_usb_probe(struct usb_interface *intf,
 		    const struct usb_device_id *id)
 {
@@ -1091,6 +1182,13 @@ int rtw89_usb_probe(struct usb_interface *intf,
 		goto err_free_hw;
 	}
 
+	ret = rtw89_usb_switch_mode(rtwdev);
+	if (ret) {
+		/* Not a fail, but we do need to skip rtw89_core_register. */
+		ret = 0;
+		goto err_intf_deinit;
+	}
+
 	if (rtwusb->udev->speed == USB_SPEED_SUPER)
 		rtwdev->hci.dle_type = RTW89_HCI_DLE_TYPE_USB3;
 	else
-- 
2.54.0


