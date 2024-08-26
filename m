Return-Path: <linux-wireless+bounces-11985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEEC95F17B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 14:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD39C281642
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E663017BEB7;
	Mon, 26 Aug 2024 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AKa1LhDu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639F171E76;
	Mon, 26 Aug 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675913; cv=none; b=hVrx5+KYscRYhrncF1M9w70V4ndrRnKxXRSm1XkKfkJu9ofqqw/M85VGpIRVjhiHcPujWfw0Yx3thKKJfjHZArgz0tnOd4EvK7d5UYMZy8GvIWc8A2QESxmVCu/RtCk0aHwzhjvWpUd2j3dl2+SXN1tvoy5gqp89FeRgMqPBcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675913; c=relaxed/simple;
	bh=ccZU3a24KVP9awOdU/7n6f47/VRFRXbCEIAY3d6o7uM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ET1ItSPjN0kpV1b6U5Y0XjkfLouMjJ7s2lZGthgb7/ktbxj1D2CNJGICSLtP5IPy5Uik/zO071g4WPdl51FGLuKANNKF23I9kgyySL/G78lecNi3cVZ4+WZ2oDlYysXnPow20kSlxnZglWA0TAMJE2RQA/QOZd8BNU0H7vpjiEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AKa1LhDu; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724675901; bh=bYvkknN4lY/PzXuYKt7WBFdDB1eWxCqDPPaUzeINxOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AKa1LhDuu94LHVfbg0hR+EgLYjj+FSJ0yLKSd8dYrrLgp6BkPtsTdbqavgK1cujh+
	 Zu7fXp3/VW73oXsJ5NXr6R6HSHzgXA1Y+GGmHHXF9W4igJgqJpcPTE3Ol+k62WbD/H
	 PViyEtI1Z9J32JfnhlXqMdt76A2s5G8vFT9cbnNQ=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 778048C4; Mon, 26 Aug 2024 20:29:56 +0800
X-QQ-mid: xmsmtpt1724675396tfbb2x19n
Message-ID: <tencent_A037749680365C4BCC750776D566183C4509@qq.com>
X-QQ-XMAILINFO: Nt+cTZuZCMyifgW/cBI/x1hPaZW8fHRofdlp7vzxjxMSaBHKfGA2U52/pNBcXt
	 c0gNrQEiHAU2/aOjUWyOzz+eEEEH8OqV9aVTj5AmQJv0XC2g4tEZKs6D7bVI1tkjrq3mUDVL3OBf
	 vQ7MUcMclu0fhkMJ1caJXTv0aEQ1jtF4Gt+PFTfsg2BtVdXZXsCM7JDhfHi9u5aavNu2Chs4uzdZ
	 dlbqzycDFN0IPxHxtomRRSoUyBMEqTdlHDdqGtUzGLXM7gmuFzcwlfEcKtjNY7u50Va9lrwidTub
	 MenScq2pjM990xwkK/YTFOdKTnLSJry4FBR7OMa1g1CGPvBk/fye4gGs3GDN4jtWRpf9gn8wOumz
	 aBPL3QIB37l/BFiKWGAtjDcLD1I+bRqziz1Z5u52rxIY/ImrY1WDCNipVZ4WJXnPbHBtD12NMp4p
	 ASmUPxao7NYt7eVbpp7uiPO1oz9CultHFG1grFL/I2KTKmg5vfO2+6O3HQfmgG+2ZiUS297KSn4j
	 3wml4bBrxHX2Ue25tOJWL4hm6r6H90acny79hvG+lZuYNSr4B98PCImj64ROwZJbWHgvqvdqy71B
	 h4PDgwlJ7mqcaWc5BMAOIFHCOOUunBdt0qI6TrM8eKynN7+koYz4c5a7bXd0yEkXstF2uPs9YISg
	 fP2SHBAxqpb9FmQ3B22gu71moyM+ZCnrAt5tF+lamf4uV1nwt433RKhwdgG+daANnrNSh0Zy3XWK
	 WKXfBCvppnluQmrZhff5D8j4bOczt6PJKyQqs9LVRLM3+4wlNfap2ueB8kam+ZuN/qyMEohgGkUO
	 D6hisb7ZSMXNguNYfayUPFZ4EDu9Z210S3TgeW6YvhtgK8MKl8mQlO8SGZLPNEqprCIrRxAnkkGy
	 7ylgkh/v45Z7hCe6ag60srK972gnz48AK55tO8iZrbULNpjh2FNi3RDR4H7H7do2qESU79SXsjhn
	 2wYrSAZsmoMMLFSg0O4+m29/deROYVnplL2HFp9Cidp+CR3Y0xFw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
Date: Mon, 26 Aug 2024 20:29:56 +0800
X-OQ-MSGID: <20240826122955.2674569-3-eadavis@qq.com>
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


