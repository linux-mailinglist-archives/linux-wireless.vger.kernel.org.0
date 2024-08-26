Return-Path: <linux-wireless+bounces-11994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D915695F454
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 16:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827471F2260F
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C6118D639;
	Mon, 26 Aug 2024 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="M9J34480"
X-Original-To: linux-wireless@vger.kernel.org
Received: from xmbg9.mail.qq.com (xmbg9.mail.qq.com [81.69.217.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175E1925A4;
	Mon, 26 Aug 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.69.217.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683749; cv=none; b=mhyIldG7hqo7N3qV/EwHM6qc2FxsZz2HgLeX7EaRw04LrxF9J3ZsBNuOwCfxlpZwTtziVm257u9GpicLdc7TpW9BK3LxlQOVTiNXyhIOdYE+HI/GDxh9xpEGGIlimBI21J855RuqE5lRs+LcI4RShmjgVaSe5Ljj/RDn8mImNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683749; c=relaxed/simple;
	bh=scIlDt3bJxc6xjtCfFWzsD60sMCU7dzjdhlTShv6odY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=sOP9zgmKhrWtHbKoqUo6Dpys19Gz+lg5ogLcYPurZ+7Magh24RuJDPASgqBdkc+Mn3fU/I9TKoZUZKp5FopNajmZ56R5FmhnI3By+BwfshkHR15r0JpKMZoHSFn6JCaf+Ktcvp0jaqhF4o8H7mI2IrKtvjBR+QoTg3IzKk+G/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=M9J34480; arc=none smtp.client-ip=81.69.217.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724683737; bh=4MNoqgFAOdi2a+l9olqRlqs76QuNfFgvKzCU8S9eMFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M9J344809lRip64V04r7u2HHtiow2rclBETBBHtc+tpcMLhghECfEHMoHxwmDQ7f+
	 zPqv3qcrZsVCLV+EZwcSV4/2tZppTv4xl5medn7H52JmE+aKy1VrdOqRv5ooHsGEo0
	 oT/gbQi8cmDaPQpi2ecaQQGuohezlGp8UHtttirg=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 778048C4; Mon, 26 Aug 2024 20:29:56 +0800
X-QQ-mid: xmsmtpt1724675398txss294ka
Message-ID: <tencent_6E58783A6D402D596E509598E92AED2ACE0A@qq.com>
X-QQ-XMAILINFO: ObFHHlrAm440+Li0ed4Ju/KdFISCzgiyIsZhE32LhdfS6NJT3itGqxVFPomip9
	 /qyEM7g0WqB2UycGjeHyIyXbCB4Pn7dMYfQJcvQltwxZG9EKGrtGvOoA+QfXK7Po31jCw77irgR8
	 93dOZrOnGPOc+IehOlSLEyhBT3IzyGKA/PC7iLkx1Ajg4v18GbZraiFawlo4TWEkl9NaePI71h/T
	 UGNBJ6oBVarMRxFq2YZa+ClPJfTPMGsdPcl/hUPt3q2WY9OeRdTBLOlev9ZiS3AdP5BH+EyWtSeL
	 9oQVqc84ukE9OGdE8/Eo/iOJ9QNR0XNHFLs6khZVtSdjusJkSIvYsvPXliGS32HzbxwvRgfhDPyI
	 FENgToFynVhykRlg8ws9nwAW4rxIIZTQlTELdxWl+NLMLNl0NYPX2EdvXq/QN4qOe4oNYtBKjwm9
	 9COBA9TlmeUaHsq75Mi5rDSPcTDJUs9EGRf0dZWjBgnedmRNxlmH5nr8zv2Mujuinu0Fgbv7qQXE
	 Ndb6XAypeqSZ1N2UvPP9XZtwDII7WNz9Lh6TgP9WFx7J7WQKHdR5k4kidP0BQMwxtzS/9y21miD3
	 s5cFluMyZ9ORTvRv2TdsLCBqCxtzxaEeIURk+HNTMbpxSk3k2bMitdjSmb0LpyIgVGcEl9RV0TQj
	 AyfK30UjFMFqu21YK8hnJdUgTAy1cqKJBfaa+VsRe12CeD00W5zzfWoVCZOO0i7McZaK/4dxDjWe
	 XPYkmtbXt/CbnD2eNoWQKSzBfaBvqfpQWqjN02WO0RMr2lRpJXZ6IYQbs+gS0kHn/PeojiMFr6z/
	 L5A8sxD1IGF2Fl8hwUh1QR8yrYm4tzd0HsKJ6kX9CvlffeLEtsto6Rcnw+4lxr77nJ+pqiZicZXo
	 NAMDdkfauLwuSrWbTw/gD/P5pi7fqXbItfAAAYyZPYvU3mpb5C4M9+2OBbcrrGb7bLZpoM3TOICg
	 4yRQ2LcOfozQX8lw6DhQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: gregkh@linuxfoundation.org
Cc: eadavis@qq.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	sergei.shtylyov@gmail.com,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V4 2/2] wifi: ath6kl: remove ath6kl_usb_submit_ctrl_in
Date: Mon, 26 Aug 2024 20:29:57 +0800
X-OQ-MSGID: <20240826122955.2674569-4-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826122955.2674569-3-eadavis@qq.com>
References: <2024082631-upward-zips-f7b8@gregkh>
 <20240826122955.2674569-3-eadavis@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath6kl_usb_submit_ctrl_in() did not take into account the situation where
the length of the data read from the device is not equal to the len, and
such missing judgments will result in subsequent code using incorrect data.

usb_control_msg_recv() handles the abnormal length of the returned data,
so using it directly.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/net/wireless/ath/ath6kl/usb.c | 39 +++------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 0458b5a078e1..b1fc66d823b8 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -901,40 +901,6 @@ static int ath6kl_usb_submit_ctrl_out(struct ath6kl_usb *ar_usb,
 	return 0;
 }
 
-static int ath6kl_usb_submit_ctrl_in(struct ath6kl_usb *ar_usb,
-				  u8 req, u16 value, u16 index, void *data,
-				  u32 size)
-{
-	u8 *buf = NULL;
-	int ret;
-
-	if (size > 0) {
-		buf = kmalloc(size, GFP_KERNEL);
-		if (buf == NULL)
-			return -ENOMEM;
-	}
-
-	/* note: if successful returns number of bytes transfered */
-	ret = usb_control_msg(ar_usb->udev,
-				 usb_rcvctrlpipe(ar_usb->udev, 0),
-				 req,
-				 USB_DIR_IN | USB_TYPE_VENDOR |
-				 USB_RECIP_DEVICE, value, index, buf,
-				 size, 2000);
-
-	if (ret < 0) {
-		ath6kl_warn("Failed to read usb control message: %d\n", ret);
-		kfree(buf);
-		return ret;
-	}
-
-	memcpy((u8 *) data, buf, size);
-
-	kfree(buf);
-
-	return 0;
-}
-
 static int ath6kl_usb_ctrl_msg_exchange(struct ath6kl_usb *ar_usb,
 				     u8 req_val, u8 *req_buf, u32 req_len,
 				     u8 resp_val, u8 *resp_buf, u32 *resp_len)
@@ -954,8 +920,9 @@ static int ath6kl_usb_ctrl_msg_exchange(struct ath6kl_usb *ar_usb,
 	}
 
 	/* get response */
-	ret = ath6kl_usb_submit_ctrl_in(ar_usb, resp_val, 0, 0,
-					resp_buf, *resp_len);
+	ret = usb_control_msg_recv(ar_usb->udev, 0, resp_val,
+				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				0, 0, resp_buf, *resp_len, 2000, GFP_KERNEL);
 
 	return ret;
 }
-- 
2.43.0


