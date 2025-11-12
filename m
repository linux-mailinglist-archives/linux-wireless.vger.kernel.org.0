Return-Path: <linux-wireless+bounces-28859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ECFC50DED
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 08:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4873A6254
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 07:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAB127F010;
	Wed, 12 Nov 2025 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hamik.net header.i=@hamik.net header.b="X4tW7siP";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="QRPCvN1M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e226-12.smtp-out.us-east-2.amazonses.com (e226-12.smtp-out.us-east-2.amazonses.com [23.251.226.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D958D2FB;
	Wed, 12 Nov 2025 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.226.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931094; cv=none; b=aqzXojkOvjHFps48ltb1A0kCzSoKmosB8RYcJhBit06pwitof60+TnIE/3IJAKl3V5HvOvF/ICoizwNDugqVna2PUWLV+/MUMgXVEJt6lJN0nC/Mrt1EVpP4RYCbMwbWmz/O9RU/e6agt9D85mbCEUkRSybBNUQs0BFwTvIzhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931094; c=relaxed/simple;
	bh=zq26d4SX6r7SkrLhlhr0kCPdE63/LNV2974dTh/FhC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YT4cVC1PhpxhX5kidEjEgc4gUVMQB8uhByda1TqGwKDmFnPuis2mqGc5YfSZwxXBYbV0uLvXqVCihxgUIfmDhOeoQwKM0VsEUaWLQHvrl372wyh8jV5hnALPNg+2KFVxxkIU4yiSjKjBuqziiwZ5GSrhbqejgjC6vWi8pwHL33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hamik.net; spf=pass smtp.mailfrom=us-east-2.amazonses.com; dkim=pass (2048-bit key) header.d=hamik.net header.i=@hamik.net header.b=X4tW7siP; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=QRPCvN1M; arc=none smtp.client-ip=23.251.226.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hamik.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us-east-2.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=dmdftaxaeg5wm4n7u6njourd62jd53oe; d=hamik.net; t=1762931091;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=zq26d4SX6r7SkrLhlhr0kCPdE63/LNV2974dTh/FhC4=;
	b=X4tW7siPxwZp4724CtEia07Bpkzn2cAr71bZ4CJF77Z5ZBuKUCy4Ov7yQQySYK0O
	EG/61Hzae41f4pppJ2NSrDCznBsO53RFuDNELkBUi9tgeWfDk10ZItc6DcVkVI84Ved
	8iEkVWWajT8W/+f6rnSwPDh8/2BKj+kuPQZWS8YVJmgLUNHrHfVEeljcJ4+yVJ9W5Fw
	1o9I/czie+Vhf6VKrJru97Oit8RSI7cfLJeW3RSM+vtEFjjNQxhlmKDcesbmd3mNCgF
	/CA+9JfZhTea9UFHxKcevYKnFKYZkw0V2uROlVnQoR0xLz5aZtDR646n6l6k6PFCDxS
	qrLX97ACcQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ndjes4mrtuzus6qxu3frw3ubo3gpjndv; d=amazonses.com; t=1762931091;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=zq26d4SX6r7SkrLhlhr0kCPdE63/LNV2974dTh/FhC4=;
	b=QRPCvN1MTpb/ZE1qzmcBYlp/AiXDMDYchZfKBjOZ/b65iBXF1a56EJaUmzUs6Dvu
	XZZdrbwrArwXoOX6EPNvA2mSWaztAik00b4RYV+6dDR6g1HFWFcmn69KMAqL6PpcTFC
	MJlSGnbJ/iVaPLy928sK3uNYv/gUj//38hBPcrlA=
From: Dan Hamik <dan@hamik.net>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dan Hamik <dan@hamik.net>
Subject: [PATCH v2] wifi: rtw89: rtw8852bu: Added dev id for ASUS AX57 NANO USB Wifi dongle
Date: Wed, 12 Nov 2025 07:04:51 +0000
Message-ID: <010f019a76e1a84b-0a6f5e9f-2a43-4a9d-9c30-de4ae6363011-000000@us-east-2.amazonses.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-2.zaPTHEWiOjctLYOPn6UYZ0ckxmMPCJEH8rpm8BETxak=:AmazonSES
X-SES-Outgoing: 2025.11.12-23.251.226.12

Add the USB device ID 0x0b05:0x1cb6 to the rtw8852bu driver to support the
ASUS AX57 Nano WiFi 6 USB adapter.This device uses the same Realtek
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


