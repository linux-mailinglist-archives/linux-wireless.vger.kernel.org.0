Return-Path: <linux-wireless+bounces-11986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FEB95F248
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 15:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5241F23507
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4723916C84B;
	Mon, 26 Aug 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xy6hpfPj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFC17E1;
	Mon, 26 Aug 2024 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677324; cv=none; b=nKwzU032D2x2+FXT8pUkWcYdmzMSptfg/wGLKJr1uPXn2pXgFa78qKBgJ5vp8Cf3SJTVxHXdUVTIzTJMmn3stb431EbFM96kP24vhFcC84oHk4T77m5RTLdaNtdWtS3NYRoCH5U/zWR6VtN7OUC3YetxzBwFm9UuC3nXw5On4I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677324; c=relaxed/simple;
	bh=ccZU3a24KVP9awOdU/7n6f47/VRFRXbCEIAY3d6o7uM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aKmyz7LXaLfdJZX+i+yBahaeN5GG8n2jvLLVZvqLfeuRVNJg2SURjjyKYKcInBleRwqHqCSQLW8t3LBr6AbSpweijtzZzIiMz9Zq/bdzwlqGa6xjJ6PlRgG4SDZqy7rxTJ7+r4yA1O3sybyQTst8D/jOOKkCteQTGsMwgoy8v7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xy6hpfPj; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724677318; bh=bYvkknN4lY/PzXuYKt7WBFdDB1eWxCqDPPaUzeINxOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xy6hpfPjzkgMBvmaUBrPaycYp9nNEGhhRSKOG4/JqoRZ3CrVGRQMqozXEsu0VguLx
	 MqcdHp/oyz17Orx1w9Dl5kXaVjjviQqHEdruAXsrW9fK+UB4WNs+eGDVlIMtlkwlXk
	 1UE0/tkCgR4v/W30NlEuW/QLEnY9PYFoFW4degZo=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 771A2A8; Mon, 26 Aug 2024 21:01:55 +0800
X-QQ-mid: xmsmtpt1724677315tf7m5rx88
Message-ID: <tencent_0AD5762F67E03DAB364097D036C04B367409@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNzn/LR6TrDyrzWLVwUKg8NNpXgZaDAVYEFwLZZeMd3vzd46K6TEU0
	 As715XwSA+fYEH8z4PRxoThPD3Nh31bZFAvQrrPiqvl+/dxz6GtV0d9dTksZNhAnkhkSNZOrxBfZ
	 Kcc4AHDgNWrIUmPo9BysEwTZvR3ZuXlTmEeOnHxUHuvlC4MeTuNL8jNUSU3UPwSi4Qm+rrx/I1ES
	 ta7c01eQUbDsl93DrbeTCi6R7BbOJZKHaKBfOoTJragwAokkJYl1rui8yHWUw7qe74jHJCn/tVE2
	 lTs+XVtaovVF8Vuw2lnjaO1n1yNAX0ddk1buNnTzeLUPqe/2aQOUFln+c2NoQGabjwUKYkOAQHRm
	 M8CvOx0kincHPdexwMCaEg5V/Q9F0FFNY6WixYmWUm3mBHrFZtTbam2RQ78HvoTbt7CIAVNkTOn0
	 EOcFduoxGpEySImtLsVjJITec9hUSf/+aMyggh1dKuB6ZhH/DO4F9euxl0DRYdYGGavzeqRPbAhB
	 f3TFFx14+0P8txfU5kCGZVcpWFb3+DKF0TlHUiziuahm2jqzQ8pMeim7M7bSfwvS8QDrYFOqTYRQ
	 K0A2dCOC+8jX2eIgk5quJ1rh1i7PMMw0BvO3cR690l8NLOkZkjcs1ZghB1Qsm1yU4h3PWMkVYVHM
	 6IjKrHXh7pOYastXR6ZzxbPE0j+anASEDGcyhyhi8o4ogHmBT2/5tpsHg2Z6Flh21oTn3TBuDiPa
	 LcZywsT2HENQJdC0q/CZUhTYBAh38wPPtKc0RBro3xYQw949HUHO8EP2YLeRX2XJHX3XDKS/hewb
	 Vxc1Lx0fMOf8KFWdzPXN1vhSDpJvbjOV5rtMRyc5RQ14mw+eAQ8GJ3VxP3GA2hcs4mSrRTyc1MOZ
	 5zDfBTZ3Ygglx6b9IONyiAl7aKXaa3Gpa0MVzCQAExEuEKtSVYhYioqI2PeDL3B0xdLRfCok5oEK
	 v33Diw5YmdVYoxtfmI/1+SCUEduPx2ZqYPYQpO58ziMuIFdgF385rUCWd3DnReMMjf1/N1GHUg78
	 Azmt4pKXYjWFlydpH3xIAdCSnWvuxgZAU1lzwdDfZeoz5/4B8pOiDjWonjo7c=
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
Subject: [PATCH V4 1/2] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with usb_control_msg_recv
Date: Mon, 26 Aug 2024 21:01:55 +0800
X-OQ-MSGID: <20240826130154.2706792-3-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024082631-upward-zips-f7b8@gregkh>
References: <2024082631-upward-zips-f7b8@gregkh>
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
V4: Adjust indentation style

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
+				ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
+				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				0, 0, buf, len, 2000, GFP_KERNEL);
 	if (ret) {
 		ath6kl_err("Unable to read the bmi data from the device: %d\n",
 			   ret);
-- 
2.43.0


