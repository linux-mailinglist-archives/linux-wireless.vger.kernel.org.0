Return-Path: <linux-wireless+bounces-3959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93E1860FD7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 11:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB131F211FD
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB014B835;
	Fri, 23 Feb 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vyv3+BjL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA111428B
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685542; cv=none; b=on9vz9TuiJH5eC0q+vKRkqxhuA7fbWVs335YGPyjGrvMEkwcHwrPMMZxqOsxHg6W4jjIdMr2m6kGF4m99iL0Aw7a7atZMJfkdp40mluwLuD689mtqGxlcQVy5fuilauQW9ZRZWNVm2syrRtstsbNBP8AAZcwdUS0wAz9lhgqnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685542; c=relaxed/simple;
	bh=Q/4guf1NnvMjA0TFY6dFXf102kTk0SC9qLwejI1b+mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqhLqQgR3wV9a2xyUfBvf7GY+bVEAVueSB/8/I9Uw9nPmvh3iYNXzJSgpx+xuZBygG7d3LPZN0MC+uKg0QACZ/kqLTkus3nlifNC97mPXNwQ4VHXWgqkuCv27FZ38PurIzIoVT5V/RnOTcQoLs2qolCtn2BR/jo6ymZi58jnQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vyv3+BjL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ow0fXAtxRUDlHJo+9At4OEaoozXDVvfZl9dEjTbZsP8=; t=1708685540; x=1709895140; 
	b=vyv3+BjLHKvCNqXYllcMJZkloqv+ec7goS62HXMm2XVbr0jid78b0vy/Pqsv2GLhNjk9z+tSRsb
	uc7Km0tSO8ls2Ne04khQ7JRyAtejzVFkP1S1uwwdvOxbje8wSbGQ9lvgLNBjHBw6tfgqw0NyVcnOM
	1WFMppy5CyZgFYOL8bcqHxVjX6wj/FHooPdML5Geye/xsbWRtCpLZiQ4xLBCdWvrpuZZaHka3xica
	J+UR2PgE5fvIKRsC28GF+8GN+Fg6LznW646dYlps9FnafkmtDexXsMagL8bpeMFU5q93HHXjwaBuc
	m27dU2ixveYPDdnCvplL3gCDmwz/3EEZeDqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rdTA8-000000052II-0Tnf;
	Fri, 23 Feb 2024 11:52:16 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Siva Rebbagondla <siva8118@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] wifi: rsi: fix endian conversions
Date: Fri, 23 Feb 2024 11:52:14 +0100
Message-ID: <20240223115214.682fb94159fa.I576bbf9fe7ca2948dbe3e00c0fa0f37594e85046@changeid>
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
twice in this code.

Note also that prior to the commit mentioned below, the code
was putting 16-bit values 0xBBAA as bytes "AA BB 00 00", and
the commit mentions making it work for 32-bit values and
makes no mention of fixing endian conversion; however, after
it, the bytes for 0xBBAA would now be "00 00 BB AA" on big
endian platforms.

Remove one conversion to make sparse no longer warn.

Not sure anyone can, has, or ever will use this on big endian
platforms though.

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


