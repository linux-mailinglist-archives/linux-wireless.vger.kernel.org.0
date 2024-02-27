Return-Path: <linux-wireless+bounces-4038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2A486873D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 03:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9061C27DBD
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 02:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07305175BE;
	Tue, 27 Feb 2024 02:34:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ne31.mxout.mta3.net (ne31.mxout.mta3.net [51.222.89.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E1168C6
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.89.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001283; cv=none; b=ISBIB1Dl6DaaO3N+zvCX4L4Rc2UzvfaTt7HiQ0i8VcFsEVwq2vRnXIoB63u39UwF5ipUuM7O7ip7JLPR62uzDmU1IojmxhGicNfkoU4ewMjsJX29Plj2ldYFJ5pTNOE7cXL+gl4/ZvULPRyBG+4dPz6ubAciRSYAq7M9vu63KKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001283; c=relaxed/simple;
	bh=vLjQHOQvwn5ZHesSBXyD9kEVRt+k9o9uxD0LXx371yQ=;
	h=From:Date:Subject:Message-Id:To:Cc:MIME-Version:Content-Type; b=X633B25aSJW4ba71NEJXPD0yZ1m3VjI0IHMugreNFHaxDfmbtM/L7barukKy2ZLGta51SVwCZhKopwWxf1OL8Ctw5FJau+UJjqOD97RBASLy0NTRhTQPDRwPT+XL/+qn0FyJ53mF1cgLOYlZknR+saTvVeZ9wf+0/oPZieDE3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=bounces.elasticemail.net; arc=none smtp.client-ip=51.222.89.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounces.elasticemail.net
From: Larry Finger <Larry.Finger@gmail.com>
Date: Tue, 27 Feb 2024 02:34:40 +0000
Subject: [PATCHi V2] wifi: rtw88: Add missing VID/PIDs doe 8811CU and 8821CU
Message-Id: <4ume7mjw63u7.XlMUvUuacW2ErhOCdqlLkw2@1EHFQ.trk.elasticemail.com>
Reply-To: Larry Finger <Larry.Finger@gmail.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
 Nick Morrow <morrownr@gmail.com>, Larry Finger <Larry.Finger@lwfinger.net>,
 Ping-Ke Shih <pkshih@realtek.com>, stable@vger.kernel.org
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-Msg-EID: XlMUvUuacW2ErhOCdqlLkw2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: Nick Morrow <morrownr@gmail.com>

Purpose: Add VID/PIDs that are known to be missing for this driver.
- removed  /* 8811CU */ and /* 8821CU */ as they are redundant
since the file is specific to those chips.
- removed /* TOTOLINK A650UA v3 */ as the manufacturer. It has a REALTEK
VID so it may not be specific to this adapter.

Source is https://1EHFQ.trk.elasticemail.com/tracking/click?d=I82H0YR_W_h175Lb3Nkb0D8i6IqvuhESe0WLnY6P7IVwR1UKvB0SPxd1Olp3PNJEJTqsu4kyqBXayE0BVd_k7uLFvlTe65Syx2uqLUB-UQSfsKKLkuyE-frMZXSCL7q824UG3Oer614GGEeEz-DNEWHh43p_e8oz7OouS6gRBEng0
Verified and tested.

Signed-off-by: Nick Morrow <morrownr@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Cc: stable@vger.kernel.org
---
 .../net/wireless/realtek/rtw88/rtw8821cu.c    | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
index 7a5cbdc31ef7..e2c7d9f87683 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
@@ -9,24 +9,36 @@
 #include "usb.h"
 
 static const struct usb_device_id rtw_8821cu_id_table[] = {
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xb82b, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x2006, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8731, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xb820, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc821, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xb82b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc80c, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc820, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc821, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82a, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82b, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc811, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8811CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8811, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8811CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x2006, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* TOTOLINK A650UA v3 */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82c, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x331d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* D-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xc811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xd811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8821cu_id_table);
-- 
2.43.2


https://1EHFQ.trk.elasticemail.com/tracking/unsubscribe?d=jAGPtWFGE8Soc3kz_2nkgV0cg1priCNwuAVMrjYRIIiyeRrym-Tm6C3M27-APNufjA0z4dvvT_-3HEXC4V8xVw1rFgNCZcEZuumX4JNEE9UE0

