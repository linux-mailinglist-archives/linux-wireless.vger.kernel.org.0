Return-Path: <linux-wireless+bounces-3958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A6A860FBB
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 11:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7215284E5A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD498664B9;
	Fri, 23 Feb 2024 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="G9Y1gaOQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775665189
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684851; cv=none; b=nCeRz4G0qE4aYUIvr0SRr1xJd6crneVpx5z2InlqEAK/wCfO9MzvAWtUc8S4vh8jin2R2WS699GqaHGp+gs4aZLEXUU/IjofMuFThQwxDSTk7/EmEmE6CCnWbKekXCrc38ItDI7fBpkqyjbccYU527oLRJUsUjv9DhuOlBraE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684851; c=relaxed/simple;
	bh=2Ny4ZKkPvfcxx0hqI52hsY8mzq6R+cI5RkmIGS/LIEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETZ32Is63JkYPw5PmM8NCb+d8S//Tu+4DqN33Bb0vyEtWvNfYflP7ix8THo2W6N8z7lUi2/4Av36TvDcENsxTl9iAhtpuXekq6Ft5/9AZ7M7M3iFyP6CEHOYGAlJYQZ560iAwczYqXrVxJXcilQ0Lr3k66SEUie27BPETRj1fe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G9Y1gaOQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=JsyHyOE7XGMBIWQkskHzTGwQdcYe1pZjgIGs5D7Llgk=; t=1708684850; x=1709894450; 
	b=G9Y1gaOQg5/f4qQ1vr2XQIeq+srjS6UT9buQ5n5dpOjjpUOlcD+JnCIMCkfYB+tpmUffFDzjgYf
	Imr6agjHTszRay56+KmbQpn4jQDZ4/mUDYbe2g0wmp1h4GZEB8stFR3zU7GzMaYaZp7lje5Xd8zPx
	sb6nP7/y0Qc4EWnEkximmDosrMIw1RfVFZFtqiXnDJtUyQgvCMRdpnaKXCzZDCGQoVnRJQFU4NBO2
	WYg3zL7lQKX1iAME6CLSp56BI2Syfpsm0D4XSmHaSMTQg+E84aJwtmaqH6hAgSMnsUfLfqFNVPTZE
	BwHaI1up+8OYT98/e7ljRzxNLRVFSObSVuPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rdSz1-000000051q6-47fD;
	Fri, 23 Feb 2024 11:40:48 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Siva Rebbagondla <siva8118@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: rsi: fix endian conversions
Date: Fri, 23 Feb 2024 11:40:45 +0100
Message-ID: <20240223114045.7bfdc048832c.I576bbf9fe7ca2948dbe3e00c0fa0f37594e85046@changeid>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This really seems like a bug, endian conversions now happen
twice in this code. Remove one conversion to make sparse no
longer warn, not sure anyone can even test this on big endian
platforms.

Fixes: 0a60014b76f5 ("rsi: miscallaneous changes for 9116 and common")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/rsi/rsi_91x_usb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless/rsi/rsi_91x_usb.c
index 10a465686439..0ce8c9aad1f1 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -222,7 +222,7 @@ static int rsi_usb_reg_write(struct usb_device *usbdev,
 			     u32 value,
 			     u16 len)
 {
-	u8 *usb_reg_buf;
+	__le32 *usb_reg_buf;
 	int status = -ENOMEM;
 
 	if (len > RSI_USB_CTRL_BUF_SIZE)
@@ -232,17 +232,14 @@ static int rsi_usb_reg_write(struct usb_device *usbdev,
 	if (!usb_reg_buf)
 		return status;
 
-	usb_reg_buf[0] = (cpu_to_le32(value) & 0x00ff);
-	usb_reg_buf[1] = (cpu_to_le32(value) & 0xff00) >> 8;
-	usb_reg_buf[2] = (cpu_to_le32(value) & 0x00ff0000) >> 16;
-	usb_reg_buf[3] = (cpu_to_le32(value) & 0xff000000) >> 24;
+	usb_reg_buf[0] = cpu_to_le32(value);
 
 	status = usb_control_msg(usbdev,
 				 usb_sndctrlpipe(usbdev, 0),
 				 USB_VENDOR_REGISTER_WRITE,
 				 RSI_USB_REQ_OUT,
-				 ((cpu_to_le32(reg) & 0xffff0000) >> 16),
-				 (cpu_to_le32(reg) & 0xffff),
+				 upper_16_bits(reg),
+				 lower_16_bits(reg),
 				 (void *)usb_reg_buf,
 				 len,
 				 USB_CTRL_SET_TIMEOUT);
-- 
2.43.2


