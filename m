Return-Path: <linux-wireless+bounces-2633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B7483FDC5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA289283CEB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 05:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AAD446CA;
	Mon, 29 Jan 2024 05:38:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.cock.li (mail.cock.li [37.120.193.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455C2421D
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706506683; cv=none; b=YwMQAmyHMlWT/eE7/zUWXj4A7BHMv/0/isFN/VPN1hht20trXmFMmo06iwV7U5gfMDe4M7Cx8FLg4v6MNiwMIs3ltOv7Dwpkf/9W1Thks0NpzffPw5Ox76VzkAPYkl0+OqAnF0kNkti6G9c8WjRWIpOLHmIeXK6eoLTKYxkfx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706506683; c=relaxed/simple;
	bh=QELAz2JHlv+qdvzqzALEefysogz4KAlqZ3Y/8kYPxcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bX33nziuf5kvj5N+/8iwJevkK6Jo5KzQICeQUt7gUorJr67/AQRjIsH5/xh0JulsfGhvFfJ/vOvwBgTMGg7ngEDaBYaAS3ohm8/YCbPecpt8jWRyIP9jM0o8SqsTZNnEYLr9suK38xs8vXhFVw1rs7Nd1rs4OeuQfY8QCtBSUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cock.lu; spf=pass smtp.mailfrom=cock.lu; dkim=pass (2048-bit key) header.d=cock.lu header.i=@cock.lu header.b=LN3LT6vf; arc=none smtp.client-ip=37.120.193.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cock.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cock.lu
From: Chun Qiu <cqca@cock.lu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.lu; s=mail;
	t=1706506211; bh=QELAz2JHlv+qdvzqzALEefysogz4KAlqZ3Y/8kYPxcw=;
	h=From:To:Cc:Subject:Date:From;
	b=LN3LT6vfgQbXqx3a8rEFnye19LX5mTala7MVR4GuTBkJ5C2Xdxk0FRcWwsYdJDrkc
	 lgzTvYm9bhIVJr2AtWJKdsAwWRnW8Wz3oYfB/XyE7v2ghEdXCpZPLtxVICJvf4gu9y
	 /CToxgI0xwpHo5q+lT1Sy+d03BkIe7I1vYkGwCc8NiWBGNApiTXav1yKqbJObJgBG7
	 Ch9zUg1iwxU4flFIMLd/rByTcq//qZW6KT+Z++M8q/64gXHYTrt6BbxCgROo7xE8fN
	 UchKIsA3drPw6t0GEk7Gr50GQZyAeU0ZAOVvzxjRdOJ4Z00ACmMV8CL6K5y8VbmjSN
	 aqkumSPUQLRxA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@redhat.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Add TP-Link TL-WN823N V2 to the USB ID list
Date: Mon, 29 Jan 2024 13:30:30 +0800
Message-ID: <20240129053030.16369-1-cqca@cock.lu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TP-Link TL-WN823N V2 (2357:0135) is based on rtl8192fu and has been
tested to work with the rtl8xxxu driver.

Signed-off-by: Chun Qiu <cqca@cock.lu>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 180907319e8c..ea099a90b1a4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7522,7 +7522,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 			untested = 0;
 		break;
 	case 0x2357:
-		if (id->idProduct == 0x0109)
+		if (id->idProduct == 0x0109 || id->idProduct == 0x0135)
 			untested = 0;
 		break;
 	case 0x0b05:
@@ -7806,6 +7806,9 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192fu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x318b, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192fu_fops},
+/* TP-Link TL-WN823N V2 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0135, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192fu_fops},
 #ifdef CONFIG_RTL8XXXU_UNTESTED
 /* Still supported by rtlwifi */
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8176, 0xff, 0xff, 0xff),
-- 
2.43.0


