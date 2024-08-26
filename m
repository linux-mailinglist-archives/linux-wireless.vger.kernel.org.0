Return-Path: <linux-wireless+bounces-12008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C712695FD86
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 00:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2BF1C2206B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E1A19DF64;
	Mon, 26 Aug 2024 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XkW6CcXY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57519ADBE;
	Mon, 26 Aug 2024 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712677; cv=none; b=gTQV9HeB4Qz79Ok1YCc9CvyAqKc6t4qHg9QEQoEKiblTMv59Lna2Ed00Dg+oMDG63bGhWLHG4ZMcf+Xnk5uwBac6xDiONC5tK4xQ+0DqFKiMzn+286fDMZDmfEH5T6ZJg0Ss6PXIoaJ5PHfERMznu5fQMx7iiF/Un2R8rK6n6Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712677; c=relaxed/simple;
	bh=vwxylYhqYzDcwD8VntoswCnq6jYCY0GwTMnoqPsNrFk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=T8mR9AmjuqLjAmaXjPQL/nRH9V4jVopbi5dGLHYVEif3PEY2tZ/LKj/8pgZyJfXMQo3awVFXei6ZRza0/hv5oKP/xGlLC1o9XZm32hUSBlQvW4wFdm5Tm128jWxLOz6ugtRYkZquYOt/t4K7ARs23B0nOBRlmBWjowbwJdLTchg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XkW6CcXY; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724712671; bh=efQry0do+stVDVzIBy/a+KnkSgRUN/Tp1juVU/tLaiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XkW6CcXYfSCg4KyWSNPv5U6vNBWQJybzi5cNds+DUDVi7XoTohY2hEhSRPSpiobL1
	 jEeEewiUrCVWBdr2+6KOWwg6O1TJOVZDzpdTMaI9oaXrWfYp4onQApQb50cCXmTUgl
	 Bqh39USOJbljbM3Lv7PEMu1SJZy32nJum0T+LMwA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id CC78C68C; Tue, 27 Aug 2024 06:51:07 +0800
X-QQ-mid: xmsmtpt1724712667t60kv7uhh
Message-ID: <tencent_A51B8725EABA04BB2A33BC9E1E1B2E4B0508@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5pYkZwEBzGaWEwpFRl4rltLTzryB4XVDEIlx8mFQGAr4Aup1tKy
	 A6BDPh0eEbwgH5l4SXq0KOWNHpR1JNhWSMgSi07KKCgc3kdBoLT344oLLrgEsLJ9UQIMPBKXYBlj
	 ETGrE9z4GqX3m7p/XFU/+Pmn3WNwHFvngnOQhIPQg0VwCdnhZWY1db7pHr7efQPRGgXk5h9Kf0ab
	 LKHH3ajOg6GZnI7PF5zegQkbjOsA01p1uoUA92vbqGpWjRuW/2+UyHOqp9DKbBDEeQ2u2itV8PO0
	 YQ0XMMaCo5sovj1WLb08X5YBHe1xv34gAUb+E7YAXM0LDF5PgELUUOYRYcG5Vl6PioGvGxQscE5a
	 8Ilc3bRbZaEsV+xvLlGY10gh9bnGOIlD5Dvxfmd08CdT6yDi/O5bZRXoesGVU9vcVIp8TH3+sJDP
	 ul4eWYuVHfmR0rVFTPT8iCpm7h4rpomPBIQjyekeoZDcZ6049TAq+oX6VsLfBMKXqkB3VIfxL8Eh
	 nPJ0Sy5/HCdyeVIMAdOCEuNQWd4ZDWZ+GQuC5+W+FS+KewjXScO6IYLW4LrQ9x0neZ/RpNkwWqZ8
	 s/e0z3F02cEc4x3jQpI9Oh0b2snaJvB0KxEeOwibzAhFxW7wRrEZ+U6N2bEIX5VAfnPx1/0MN+CG
	 1Jo+2qvn3AKBxJsQtubJDKc+z8foW/PXaeQS14lBMUHqYdqRmA7TJC4xmCHFgKcpBH6zQR+hCTEa
	 Sb96u0pnLy6TAUWfhVHuNuY0Pcsn5QMWM6EJeoN5AyzH+w3p32j/gCmiksn8Gltw9sX1K0kYvQ8+
	 ijzwiBE+ukPFDErQsJda4eqacmDXYI7m8maUsZtmDP3lxdvxiEutYbBSFzUnWFZ1S+cJqPTyKV+X
	 trm6FjAj7OsEk9Wq+uv/BX3gwbJbBTs2l6pHqhjQSqbq3QPV4k4XuFtZRzCpQbBbvNXwD7lhuxwq
	 TO5G3oZ7EkQUmdJDIb8s7sG85pAev7z9iIsiOMhs5pfy2q2R+4+3TQ2NzUU6kXGBndLBpXR9lR9V
	 6tdoyTgcHalZVt16E+h7l2kk4loQA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
Subject: [PATCH V6 1/2] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with usb_control_msg_recv
Date: Tue, 27 Aug 2024 06:51:08 +0800
X-OQ-MSGID: <20240826225107.2817092-3-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <87jzg3uy40.fsf@kernel.org>
References: <87jzg3uy40.fsf@kernel.org>
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
so using it directly can fix "target's targ_info doesn't match the host's
targ_info" warning in ath6kl_bmi_get_target_info.

Note: Compile tested only, not tested on hardware, only tested on QEMU.

Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: Directly using USB functions
V2 -> V3: Adjust indentation style
V3 -> V4: Adjust indentation style
V4 -> V5: Update comments, add warning info
V5 -> V6: Update comments

 drivers/net/wireless/ath/ath6kl/usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 5220809841a6..0458b5a078e1 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -1027,9 +1027,10 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
 	int ret;
 
 	/* get response */
-	ret = ath6kl_usb_submit_ctrl_in(ar_usb,
-					ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
-					0, 0, buf, len);
+	ret = usb_control_msg_recv(ar_usb->udev, 0,
+				   ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
+				   USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				   0, 0, buf, len, 2000, GFP_KERNEL);
 	if (ret) {
 		ath6kl_err("Unable to read the bmi data from the device: %d\n",
 			   ret);
-- 
2.43.0


