Return-Path: <linux-wireless+bounces-11902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1A395E3DE
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A741F215A1
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DCC15AADA;
	Sun, 25 Aug 2024 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hKXxFRPI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62BB155744;
	Sun, 25 Aug 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724595780; cv=none; b=ttujU8CgLofBbrDzhRSgYLRWnuAzPatHdmSelb+l6qJsyCTEEYcSAH7hu0ReksGD7Mg2XmBakHBJDV3ub6anv3743dJALzuBluPGHFrjCv3Er1wYGPEaSABYvC9WUEHhpPnecfjE/kjA2UkUPnAiEkACQWpgoc1/1XCnZTUo6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724595780; c=relaxed/simple;
	bh=M/wR+xnKDg2cGMZvrWk++cBTPybtZO63fRpvD1r3SDs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=S0AEEHVH71yCxDrVV17FsG9U9nlDO4+Xm6kFHTDouCIZTGbYFsMTDOet4TOVmXgpTmdUqk0dDKyq3xp2lrqddJxHnGCkSCOxPo0Gi1cgivrehMIZdw2PQyKWzxwdvI8lw/DIBUlXTv5K1SBo3fNVTIdw5TRegvdI7mDleB8aOl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hKXxFRPI; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724595713; bh=dhW6e9d16EHBmfa/5pieSMONGCAMoKv3NeI4bvVFex0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKXxFRPIHOXPioUZj9gTeHvcoZmf5/IJSK6d9KqBYwB4gtnGL6I1bQt6ZJnPjFh2z
	 /6lBQHpb3JtvJ0qrrPWNIfdzJejK2ksYB1i+2wUQNSIigkBSAFgk7KM2v4X/GJdx2L
	 ZXO1qoz9AQE3AuZCqVFxSR6JolYAC7NKQbMAfxLA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 57124072; Sun, 25 Aug 2024 22:21:49 +0800
X-QQ-mid: xmsmtpt1724595709tg524zhxp
Message-ID: <tencent_F0CB92D8867509922ED02ED5CCA4E7D2C606@qq.com>
X-QQ-XMAILINFO: OOPJ7pYMv25tOv4j2BBAXkUdpg9yjOmM2tr8OVzMrfOn0klAhg1aX7T1ut/9Ei
	 3ajFPmCKrlCkde87aP1ryXWTQTnpH7Xr2h+zKu7zdGxyC/f9J0mcDDhQRp/nNU4ApS+dFWc6vetX
	 U/fFZS2f/7adxXY9GjfkNlf8X+9+ge9zyw9ljcVR7f3QSgzmppgcywx/S1ia41MxUUu0WOjQGujh
	 /SHphuG8NTJY2RLGCjIkPZY/dsRQtC484ZapvLwX8oMJq95m1AtMOAo/CzeC4TJjQ5NwzmtGflP9
	 YWeD4mFESWTZKVFBLRCHRrbtKMAksIxd8qqAj4GLTfYBTPKF2h8gOAv4AIydCrbmJZL6E+eBiABl
	 9XdCoZpBErOGiKBMs53Keh5xnqpBAItmKBOAq4brSbjBXaXpRSWN/zrRl17cOAVlmsSxzbbz7YUP
	 D8P+mhVyVvKcOpIpO2cN86BGnSai0af4xR3p1qNefiHjr5vSj/QSp4DxLQeVEvB9AdNxnvZ0YQk/
	 8io1+meC9gk7iBtMYnx9ROBtM06CGRxQVHLurQGTGCPj/4dTgqHqjvbnl4MNWM+DGle/Wr5SiRaf
	 neRFHgnM9VZMDVaDGcRRlnjzO0WPu9F7xyyhS3v+CaaA6KJSMB/xJ5O83d9n/vpIuRagvBDJthKJ
	 84PrMk+xrqK1+mRX8Jt+OlCUIFK4FLP0nfqiX+gBvZt11PdyBm+zr3O+uyWdwIFMgjluDDt7VIbM
	 QO+2+L9qoRDzgMeRwMeSvd3UwZgiV6aX1Kg+JaoJ27gCBwXh7zKSWH9gr1MDRsutffzsBzNQfYvw
	 np1aUPqz94tSrwhkJfocKX0127iepGsB/JRWb8VpEkxoHfbirWMcqAwgsEOkz4DNyNWxJ7Ejt58j
	 Yeid5wbpkZhwmp0vaxorYk8jGYCj6aV4GnTbT5S9sVViQatNjxSd3VdrKuFJICQ3MTMkl4f4T2Z8
	 mTekYI8wVq708BKuXgpEsvS6ghou3W7ALFm5SIQ9yuQls91aBo8GxUtodGuj955X22h3H3+8AbOE
	 XjZhdxi6L36KF1TwNy
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: gregkh@linuxfoundation.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with usb_control_msg_recv
Date: Sun, 25 Aug 2024 22:21:49 +0800
X-OQ-MSGID: <20240825142148.2563255-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <tencent_1D9967CEC6D952EC86530991EED86ED70C06@qq.com>
References: <tencent_1D9967CEC6D952EC86530991EED86ED70C06@qq.com>
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
so using it directly can fix this warning.

Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V2: Directly using USB functions

 drivers/net/wireless/ath/ath6kl/usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 5220809841a6..dc1f89ebb740 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -1027,9 +1027,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
 	int ret;
 
 	/* get response */
-	ret = ath6kl_usb_submit_ctrl_in(ar_usb,
-					ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
-					0, 0, buf, len);
+	ret = usb_control_msg_recv(ar_usb->udev, 0, ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
+				 USB_DIR_IN | USB_TYPE_VENDOR |
+				 USB_RECIP_DEVICE, 0, 0, buf, len, 2000, GFP_KERNEL);
 	if (ret) {
 		ath6kl_err("Unable to read the bmi data from the device: %d\n",
 			   ret);
-- 
2.43.0


