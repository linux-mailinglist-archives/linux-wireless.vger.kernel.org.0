Return-Path: <linux-wireless+bounces-28858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F80C50B52
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 07:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 525A84E18EB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 06:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C9620FAAB;
	Wed, 12 Nov 2025 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hamik.net header.i=@hamik.net header.b="Am/tIkv9";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="dd0ifvxJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e226-9.smtp-out.us-east-2.amazonses.com (e226-9.smtp-out.us-east-2.amazonses.com [23.251.226.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402B24C076;
	Wed, 12 Nov 2025 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.226.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762928978; cv=none; b=UEq0Owx1Vk42SQNWzXy4Fh2tJrl6doNzq8ITBMA530Vq/8ySULxWzpy7/OThfhZVhL6HcuXXeRYbYzKIRa3dGGIUpY1UrVR2qNQ36qZ51rxjxjpQkvhnVLYs50Z3qsUOICf0qgv6haXcHQAHE4ycYTliWYhVMxH3bLp0XJ29UQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762928978; c=relaxed/simple;
	bh=gaiL6bZBrkX6HIsIRrnmsHaREvPKYmFeupL3ZACspMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tb/wOzXr4+Ba1f9TtVFPPSrAHDDTG5leWHe0urSenl248crm6HFsHq0PQ86HGHJ9k5xkfrs/86hNU/45LXyzYvYrGCOtIK0274qQMEpdtTk+aqgzsLH/48i3RQszvvMIwgFeSx1pjcQ0jn0tYt0lvRycwaX68oYdhaRYIbcZ/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hamik.net; spf=pass smtp.mailfrom=us-east-2.amazonses.com; dkim=pass (2048-bit key) header.d=hamik.net header.i=@hamik.net header.b=Am/tIkv9; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=dd0ifvxJ; arc=none smtp.client-ip=23.251.226.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hamik.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us-east-2.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=dmdftaxaeg5wm4n7u6njourd62jd53oe; d=hamik.net; t=1762928975;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=gaiL6bZBrkX6HIsIRrnmsHaREvPKYmFeupL3ZACspMk=;
	b=Am/tIkv9HZI8FiQo2/4w6RtPml3WUYh/NlR8kdDXi40DyLC/giB9FDf8z+YngbrP
	P8TkB9QfQKaqewAOtwtf4hvsKVWKMDPaBDDQRe82jgho4idCqbfunT23F2Ysue7eDEO
	ACu5q1TCQVHYlimh2K1SzRIBYbtNOI/odagKcasPWTdyWIqG7lNe5KhIX0E45ShqU45
	EPtNrhicay2AsS8J7WXBbPrQtdH249fgd3ZxsN1BgZw4AYDk8uDFeM+HXVeHMf/gY9u
	dSJAxF1HQe2huopchN4HGB/GB8cqNtyAkM1fnAxN7LIJ8xlAL2sVTOPmqN/+KzJY0Iv
	xIBNBfBoYw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ndjes4mrtuzus6qxu3frw3ubo3gpjndv; d=amazonses.com; t=1762928975;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=gaiL6bZBrkX6HIsIRrnmsHaREvPKYmFeupL3ZACspMk=;
	b=dd0ifvxJVflm3JjCmlGoLca/eXV7LHyAdCutgvu6VzbbOeh3oxF92ZGUBeHSHS1f
	Csfa8IHkRdpsns1mTqEdatvZ+jVtNBIKTtbVujxFW0FnJJdiI10tawMsFCDqHCEMw3w
	bu2NmBlSUKiXdNKmgLdG1/vayCSymvR/9OfJZV6M=
From: Dan Hamik <dan@hamik.net>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dan Hamik <dan@hamik.net>
Subject: [PATCH] wifi: rtw89: rtw8852bu: Added dev id for ASUS AX67 NANO USB Wifi dongle
Date: Wed, 12 Nov 2025 06:29:35 +0000
Message-ID: <010f019a76c15f3a-7a1290d7-0cbd-41b3-93ef-d8de15b65cad-000000@us-east-2.amazonses.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-2.zaPTHEWiOjctLYOPn6UYZ0ckxmMPCJEH8rpm8BETxak=:AmazonSES
X-SES-Outgoing: 2025.11.12-23.251.226.9

Add the USB device ID 0x0b05:0x1cb6 to the rtw8852bu driver to support the
ASUS AX67 Nano WiFi 6 USB adapter.This device uses the same Realtek
RTL8852BU chipset as other supported models.

Tested on: Linux Mint 22 with kernel 6.8.0-87-generic.
The adapter initializes successfully and connects to networks.

Signed-off-by: Dan Hamik <dan@hamik.net>
---
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index 0694272f7ffa..83bdea040f40 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -28,6 +28,8 @@ static const struct usb_device_id rtw_8852bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x1a62, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x1cb6, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x6931, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3327, 0xff, 0xff, 0xff),
-- 
2.43.0


