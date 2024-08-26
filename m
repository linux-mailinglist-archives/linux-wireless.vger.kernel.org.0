Return-Path: <linux-wireless+bounces-11993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBFA95F360
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 15:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6AB1C2143B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77800188584;
	Mon, 26 Aug 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ejKdB4G1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1D17C989;
	Mon, 26 Aug 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680671; cv=none; b=lmOTAVBGcRJXmIqUm5UTYK7B/jMpRnX/EQ2gTnf/mI9LKS7iNlypHDsdVqXkT0zOShRL+Z08rQ1zB+hG0zZdezYmXFY12AfuNeNFcAXMGKrnN+SZ9+WvNHOAs+SW8KhMGuNrkzL3mUgAihmRL6H1fFMx7kFyuVenZLyq0yEqNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680671; c=relaxed/simple;
	bh=vr7oofwZgZfct6HqlKWNzT6ycYxBI0n+s7zmMjcpi4M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hU85ou+HtI5Ge9fIU/jIuBsIBuw3uZcnAC5oVqiWRIv8D9LQ1EbDJ3MxXkgEp5xL8cvX0Ta7UyjMR6iIpcfvPZajT3eCkDTjQtWfzHcny5bxRqsIRoVb19ma2313i5XR2ODwKNMi/Tq+NBlcP0RM2IJgqin+LNKowH8en+zvKmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ejKdB4G1; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724680663; bh=OHgRLzSenWLbC5JQpgLz4xtY6cHLHbUrK3U66N3AWaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ejKdB4G13RzIjs6bAOrBphKmkZ7gSfgleilYyM6Gb+gbeKk3YcrbUApIQ0MJb2EMm
	 DFWsL+Ra5pCravZJVExP85JwZRqForjuNl99DVmved16gW3H/bseB4+I2yvMf6+lOi
	 8Q5FYS19zd+iVr2Cy3fYABm+2I3mBCZ6NDVSZcwM=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id B12B340A; Mon, 26 Aug 2024 21:44:18 +0800
X-QQ-mid: xmsmtpt1724679858tld28qu36
Message-ID: <tencent_A2DE92DC864D89B92ECBAEF2CC8FE7F4C606@qq.com>
X-QQ-XMAILINFO: MW5hkHoBpWXyI09Aq4gwR2uQtgcCQR4idHhfNGBGz3Iiy0PEFTPLCT8Ve7kUlB
	 J3emttFsrfj7eSzFRWc8gbM+fXuFNF1fRgMwh+qRAysAxuLsLDgJl2XSsRxhA5UreLLdPTujQtXV
	 nQijk9n1Jv8PFDio6NTz7dS15so4EvTpfB9HOryeWKqx+n0hmx7HjOh7FP1vz+M1n7gDFZ8HC7B4
	 M4eyRY9Bu9PZggcntTYT4+Vo/3IfUYgxfsZ+n4h2ue+ZYhR5LyNH8/il0QMdGXbmd9cXc8F5DY0a
	 MR/dHTGlYL/qqlAful5Z9j4XNaPglB/nNJQrXbtaGxYA1j4mLY4UMpfVa5i90q8YtYUE3S5kta7D
	 VCWCaZFdgMkHYfJaCNXQ4pQnP4LlAs9zAUxvSaDflmbFpkPeuZPmCG3Akj1LXVKwtFWNiEmVfmBY
	 4GjVepYFiXcaAXrRFtGxmldhUzETVALTZIonuq20fDXEQxVqWF9L07uETBjWLjg21PF/6huGeovl
	 AgXxxl6h5NwQcCbRZUZJIFMNC01Ui/p+BX2AKBZzEnoGmoQezqE/fPsPJGecRmSNyzPDzWywwKwM
	 VmEzy8rPWvlSw3Hp4USDlJ7MOh03emUzN0uLVlbje52AqBNNLnzW5S/SDnz71OCf0ndC4C1YdRK/
	 0Ll8vtcCrMniWesPuNnikOAJtLmxn89PABDzGL6PimrsZCQSx0wwvS4nnxefIyzt0EH++pipNtwa
	 CL0CjK2Qploo6tLYinew63Es0FP8uYpIeVyuI2dn99KYr3H+SPzQneDQxQKe2txtSGga3XpSachX
	 GBC/5dMqWcj8ip+wnWh3oVB0j2JQl92HM8oDjWvFRFE75eTPJ7AzUoUXMFHTpm4pM30+tNvppjdS
	 VyPmT4TutSaXMNKynOz5lb3YdfNFL3MVUc4a6Tf6mar17Yy5GsCOdS0jqJQPeENF2s5+eFKfnMz8
	 DAXPWcalud/1iyQESt4Xk6DiDEoY3pIjHZBdywSmEbAJnlKDeHMecTubXR+ePo
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
Subject: [PATCH V5 1/2] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with usb_control_msg_recv
Date: Mon, 26 Aug 2024 21:44:19 +0800
X-OQ-MSGID: <20240826134418.2744882-3-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024082607-foothold-boss-c693@gregkh>
References: <2024082607-foothold-boss-c693@gregkh>
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

Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1: If the data length returned by the device is 0 return failure
V2: Directly using USB functions
V3: Adjust indentation style
V4: Adjust indentation style
V5: Update comments, add warning info

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



