Return-Path: <linux-wireless+bounces-36511-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGxXI+ZnCGq4nAMAu9opvQ
	(envelope-from <linux-wireless+bounces-36511-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 14:49:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031455BD7F
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 14:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 741353007515
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8F3DEAC1;
	Sat, 16 May 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOwFmtW+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985F3DD85A
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778935780; cv=none; b=nd0QO3eMsTsDgxU9bDFmqF5sTTjB5e5KxF77i/JmZXIwudLB8RRfPe1nYFAb6cItXBOJCGOJkj/lFkclN17Hgcc7QhVWCHLihST8OiuMAvp0UIY847iIJRHrqGGs3f9dwETRrVvbbe35B+qiinDAnLD4krm9GiedUZSY1yThV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778935780; c=relaxed/simple;
	bh=ri2Qe9qYh8oPHk4AcKXTkFsCkOUxNgwmklFksEuGh4E=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YB6C3U0/8AiASt+KWdKozfVx5sQjDeQdsblgnWCgoMaI4fBgOo3DIjFo0jP/Zuq8h3hKVIy41hLvpDJA0e2IwFL0VJbo1CCHQMlw32/ZnOa0XWKr/bu1ydT0BnYlQu9tiTW4gFfob7lrhozdHyQ0B6GGQbrA+ZPqZA4eqVQvYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOwFmtW+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso3917825e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778935777; x=1779540577; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx7HvCX5lBk1iOT4iCAawqSdIFxdfmRxBEXxGSgzVZ4=;
        b=FOwFmtW+KVFriky/c+VVenq403b5woiLaMaCUEADhljDg2+kGsjy73EnsrQ+siN1zV
         h+S/opIvfcNDNgue9MmuPE1ph1fviVuCCBCOIUmlyYRor1QdW4XsTN7V5Ar5vg2H7iMt
         D8/dVZMby99MoLwCXDjIbWMgXH9ZlXes0/pidWsA+v4fKPXyqJJshF/YFCYHEitYjv6h
         jqSeG1AIytIhW77KLMZBAhN+oha9zBWIg2aq0opE+Y8WKtGMKFskAaoxtIFJEtW1R2X8
         okOswan75UnH13XKjnzM6suZZhm8EOdfQtLaLpb50UpoikKoeIxKDkceTdmcYJrAGT0g
         VMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778935777; x=1779540577;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wx7HvCX5lBk1iOT4iCAawqSdIFxdfmRxBEXxGSgzVZ4=;
        b=XCRAv9OqSiQrciyI5ImHxhtVkm8J+8pg0RTYthrRFxbvlTHBmYpdprlMCUkcXnOape
         H0ggU8yNyPn8bzBTNz+FMrAb1u3OvfnPebbAGXDQfq12HmBbjSoyRvq5xx3dIWZG29JT
         id0bq1BmrknFhFrMOo3gx6N0ReVH4HxP6YG6d3UaVnOGgqGfbuWy7xUY4fmU0qoTAO4D
         CpsYU3zzRF7m1LormwX44NFmBGWMJkrdw6cx0qoylOJ89hLexmVkry8l5s0ATTQvH8uz
         d/Ri7BOsnCsnSQIgW/YhyIRPdJxkmd70Tc6sMVLIHlRYNnnPFD5kVGY1JFnGA3vLqmny
         LSTw==
X-Gm-Message-State: AOJu0Yy8vLMNK7yzKSgtaSsXdnmmOwewuMbtwNdSec6/nGLneDX9m7Pn
	QgDH7o387meyeS4yRLE8ROMeT6imVgpsgUSzKjNeamtIgR/Jg8octVbhDfVVPg==
X-Gm-Gg: Acq92OE9eA1xvhQL4P57gjHyfZj2C+JoI71xq0QUnr1sE690rP6Onu/XgcHdhIR9r9o
	CSnN3b6r9SIGImfoZWixfr6L4rbketrE6Xb08UW4oFdkNhvQlR+b64pWaqmLzkbYhJLs7R5AIbW
	8gLgCjS5iNOevMsk9k/CRyTtuY1998Dy+OYmbQRCpvyFNY9AFn0crxuO/AFyvAjc2r6X+Ox+faI
	kgZkdo/WMc+t+SmWoMRtSw9tBLWxTwVAij9VLcRWfxB2eDCFXtg9WXtSGdAkWsw5K/xF1dJlKNr
	y3z+xYHnHESveOTOdR4vwncjtfZUsKJUezBr+Op+v/S2KHY4boDLxvHpQ1Gmgdl26dd4FQMC+1F
	hQHvFhkBkzYoJ3EnYo2jNtytItN/F+U/obHlCEErOuyvVUX0sHoacFMMJzhFKLpfaKOIWuO+wIf
	EIAWPlA0vXacwjQXcBSYBMNPzd9e/a0T/XeZKH0hgK
X-Received: by 2002:a05:600c:34ce:b0:48a:592c:e63d with SMTP id 5b1f17b1804b1-48fe60d7832mr118122865e9.14.1778935776803;
        Sat, 16 May 2026 05:49:36 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab26ed9sm55701185e9.2.2026.05.16.05.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 05:49:36 -0700 (PDT)
Message-ID: <fcdde81a-97ec-458f-8e70-ac024938f1d7@gmail.com>
Date: Sat, 16 May 2026 15:49:35 +0300
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
Subject: [PATCH rtw-next v3] wifi: rtw89: usb: Support switching to USB 3 mode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3031455BD7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36511-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
v3:
 - Avoid crash when trying to switch.
 - Remove the unwanted module parameter.
 - Support RTL8922AU as well.
 - Use more bit names.
 - Hide the warnings when writing R_AX_PAD_CTRL2.
---
 drivers/net/wireless/realtek/rtw89/reg.h |  27 ++++++
 drivers/net/wireless/realtek/rtw89/usb.c | 112 +++++++++++++++++++++--
 2 files changed, 130 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 716747c3a10e..c9816ead834d 100644
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
index c6d55e669776..bfe004a49ccc 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -12,7 +12,7 @@
 static void rtw89_usb_read_port_complete(struct urb *urb);
 
 static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
-				void *data, u16 len, u8 reqtype)
+				void *data, u16 len, u8 reqtype, bool warn)
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
@@ -80,7 +80,7 @@ static u32 rtw89_usb_read_cmac(struct rtw89_dev *rtwdev, u32 addr)
 
 	for (count = 0; ; count++) {
 		rtw89_usb_vendorreq(rtwdev, addr32, &data, 4,
-				    RTW89_USB_VENQT_READ);
+				    RTW89_USB_VENQT_READ, true);
 
 		val32 = le32_to_cpu(data);
 		if (val32 != RTW89_R32_DEAD)
@@ -106,7 +106,8 @@ static u8 rtw89_usb_ops_read8(struct rtw89_dev *rtwdev, u32 addr)
 	if (ACCESS_CMAC(addr))
 		return rtw89_usb_read_cmac(rtwdev, addr);
 
-	rtw89_usb_vendorreq(rtwdev, addr, &data, 1, RTW89_USB_VENQT_READ);
+	rtw89_usb_vendorreq(rtwdev, addr, &data, 1,
+			    RTW89_USB_VENQT_READ, true);
 
 	return data;
 }
@@ -118,7 +119,8 @@ static u16 rtw89_usb_ops_read16(struct rtw89_dev *rtwdev, u32 addr)
 	if (ACCESS_CMAC(addr))
 		return rtw89_usb_read_cmac(rtwdev, addr);
 
-	rtw89_usb_vendorreq(rtwdev, addr, &data, 2, RTW89_USB_VENQT_READ);
+	rtw89_usb_vendorreq(rtwdev, addr, &data, 2,
+			    RTW89_USB_VENQT_READ, true);
 
 	return le16_to_cpu(data);
 }
@@ -131,7 +133,7 @@ static u32 rtw89_usb_ops_read32(struct rtw89_dev *rtwdev, u32 addr)
 		return rtw89_usb_read_cmac(rtwdev, addr);
 
 	rtw89_usb_vendorreq(rtwdev, addr, &data, 4,
-			    RTW89_USB_VENQT_READ);
+			    RTW89_USB_VENQT_READ, true);
 
 	return le32_to_cpu(data);
 }
@@ -140,21 +142,32 @@ static void rtw89_usb_ops_write8(struct rtw89_dev *rtwdev, u32 addr, u8 val)
 {
 	u8 data = val;
 
-	rtw89_usb_vendorreq(rtwdev, addr, &data, 1, RTW89_USB_VENQT_WRITE);
+	rtw89_usb_vendorreq(rtwdev, addr, &data, 1,
+			    RTW89_USB_VENQT_WRITE, true);
 }
 
 static void rtw89_usb_ops_write16(struct rtw89_dev *rtwdev, u32 addr, u16 val)
 {
 	__le16 data = cpu_to_le16(val);
 
-	rtw89_usb_vendorreq(rtwdev, addr, &data, 2, RTW89_USB_VENQT_WRITE);
+	rtw89_usb_vendorreq(rtwdev, addr, &data, 2,
+			    RTW89_USB_VENQT_WRITE, true);
 }
 
 static void rtw89_usb_ops_write32(struct rtw89_dev *rtwdev, u32 addr, u32 val)
 {
 	__le32 data = cpu_to_le32(val);
 
-	rtw89_usb_vendorreq(rtwdev, addr, &data, 4, RTW89_USB_VENQT_WRITE);
+	rtw89_usb_vendorreq(rtwdev, addr, &data, 4,
+			    RTW89_USB_VENQT_WRITE, true);
+}
+
+static void rtw89_usb_write32_quiet(struct rtw89_dev *rtwdev, u32 addr, u32 val)
+{
+	__le32 data = cpu_to_le32(val);
+
+	rtw89_usb_vendorreq(rtwdev, addr, &data, 4,
+			    RTW89_USB_VENQT_WRITE, false);
 }
 
 static u32
@@ -1059,6 +1072,80 @@ static void rtw89_usb_intf_deinit(struct rtw89_dev *rtwdev,
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
+	if (rtwusb->udev->speed == USB_SPEED_SUPER)
+		return 0;
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
@@ -1091,6 +1178,13 @@ int rtw89_usb_probe(struct usb_interface *intf,
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
2.53.0


