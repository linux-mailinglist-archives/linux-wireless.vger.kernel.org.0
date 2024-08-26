Return-Path: <linux-wireless+bounces-12009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A331D95FDA6
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 01:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DA7282ECA
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 23:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B403149E0B;
	Mon, 26 Aug 2024 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Qjlcbgv/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB7942AA0;
	Mon, 26 Aug 2024 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713479; cv=none; b=GtNLu/X97SnNyArhLYLhZW73fQmBG8gQVbaUdiYpCPM8+vODQnHBr8pzCiD0a6qmI+ZjH0S+1yj1IqCwTC8Sz2rSJxqarRA1pO9YmLg2kE8mE/ra99obO4s9lgLZrqAJwRNvt+3nSUt6Gi7uqa8vjeqithbuYuu8X0/ytVIDWB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713479; c=relaxed/simple;
	bh=LWoF7d+MwsK8D33tMYWg7z3vjj8wjFqHa2l3bCLL++U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bIZxnHnTldcQpBkzUtyIFgDkKb7bert/tE9acwX9fpktf+p45zgzGjmnbP0rZ3xdFDP8valRrOK8XZUguIIFNcHL3YflP+KTU6W+7a7BdsrnqMxsdWmnfwiHEdylBlMa5Ym96LLx7peXfWHX4VC8GzChr+5jsWMI3kJJSyvtZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Qjlcbgv/; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724713473; bh=BJQ7PYbry8STGQrWKtDLgyffi+mn2fW5YEfdrsCq4Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qjlcbgv/ZIKG3g0DIuYBHJt07bLiIjnK3VY3DrL+cjBeaqLcO13q/CyBD1DW6SJdQ
	 B9Yy7xJYhHrji8kxFy30yd2x6vP8o4sDPV1P7aKFHRxrB71AEvCW2qON2zFsOdIwij
	 eFH/EyMuuKyVfEAIW2Mpl8acMFX+f5hjkgdi6Zjk=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id CC78C68C; Tue, 27 Aug 2024 06:51:07 +0800
X-QQ-mid: xmsmtpt1724712670t7ofo6x5b
Message-ID: <tencent_59F76EFB4C8B67EA86DA92C5065949996E06@qq.com>
X-QQ-XMAILINFO: NEoGzTA04D+5asKIVdFTBV8Xr9PlBlV/LIYO8oMAR7q70ff1Qq8uEGirSL9T9p
	 wkaVUxAHgPW/Z88IJ1z39oEK6xS/GzXfieTAelECnbgjW7gxu6bRYQL1+HKYxhWdBCilepkTs0AL
	 B7yaU3Nxft3qpr7TafxVDbBsPF5rrLXSPnhwgZU3DuwUCKnL9FK4klbC9DW2pVR4rxYjm4mQv9xe
	 hfi35OGMgvnCm6zh/dL+GJSRNmLn73/EBAnnht4r77qUONy/sAyHhjtNl+RReVFViyazn749Mi4U
	 WlfqVL/dpWo/EhcDgPnhdu8q/H50MTTS4REEfzWQ9kxL5qHqLN3LIjAkF2IzB+uJeKWz3QjlyHWq
	 t1g43ei+E5p3L40PkY6LP4rEPT713wh8eoM/fw/x3H6zBCmrKEJ35i3XZADxLXLUxjZcFqVHjG8X
	 voWzDoyTr9O2BtNwWtMxOLZVOy2WzuXpHS6Frgls2iRh9kBJR6Wbhp3ohtDaum5AAfii7miUuNb8
	 D6yVLHAKaqDopmtSDAG+vXRQwCbPwLP/X1Xqoon8QKrEpwe1ROglqc8KZ/TMrjcDuM65EgoYXLKi
	 RHNz5vr1V6O5Fx16ImxP0RGkLS3MqDjEsFDsXiVvNM3myhd4tD6aSA6pq7r3LT2yuQ7RTZ89jJ8a
	 816b1XCJvBIppgI653CBA7W8FWYs+bMhu3vbA2kq4lNaxk/uqtMN8ttP889F3UICtrJWfPyhEdl8
	 B0GMsTAr71yTE/qyHQf2PM8mHZ6/mh2DxyDdpbya35lXYuorKS16qE7NSvvpmNmAaqAuUEs8I2dO
	 McpPVwzCUGY5fxFjmZXkK7AufBsHU0EQzD6dyjuVnLszpo+bXvt1mrORdjAEczVmwf6N1CtrZdaZ
	 Avcqs/Kx1O7OtFGN1JHYOmD+wXB398t7Sc+Bs5hFd85jRY1fv2vxMQcOCVwOSU1sUC7iFwp4nswV
	 p64oV5bZwKE2dM53wTXtkVPAOkTfaUs3E4sdg4rNVMa3BvZhBZGXZAXe1kNWCoEHAv6yuQda6e5/
	 /D83fWNmgzJ46Yl+D5tcota4rJIcSZB7iDDeNSynv+oGVDHna7
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: kvalo@kernel.org
Cc: eadavis@qq.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V6 2/2] wifi: ath6kl: remove ath6kl_usb_submit_ctrl_in
Date: Tue, 27 Aug 2024 06:51:09 +0800
X-OQ-MSGID: <20240826225107.2817092-4-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826225107.2817092-3-eadavis@qq.com>
References: <87jzg3uy40.fsf@kernel.org>
 <20240826225107.2817092-3-eadavis@qq.com>
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

Note: Compile tested only, not tested on hardware, only tested on QEMU.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/net/wireless/ath/ath6kl/usb.c | 39 +++------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 0458b5a078e1..1a5fb2561fef 100644
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
+				   USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				   0, 0, resp_buf, *resp_len, 2000, GFP_KERNEL);
 
 	return ret;
 }
-- 
2.43.0


