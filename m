Return-Path: <linux-wireless+bounces-11982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A0F95EFEC
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDEBA1F21FB8
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B5C155314;
	Mon, 26 Aug 2024 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KZuydqM3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D41487EB;
	Mon, 26 Aug 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672348; cv=none; b=nPudaCdp90XzYbXaF0Tx9fXrCu6+w/sSvRx7VrQuoYOuAFaXV8oWVwedERE8xxaxKXSjy0Cok70vUZMYlKQVaiA2RqwNS+Ee99UF81oHZaenXotci9NpYqdgHoRYmbjRu0NGo/ItYbOvAbBurxKSOY8+2ITg0xavMWPBgotZipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672348; c=relaxed/simple;
	bh=E9rYvDBmtX2kTyV8AGiczH2r9nepy7yRTbxdWTOmWFw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=PgihnfELtq9jkPG5vCp5lzLE/j8H8eQTOtFRMP+4yuycbQm4bubOcsTGWN+Zzimq6z0JTb6g9yHcVH/ts226wRD4hMaxVDP1bmNe24s3RCSwHhl9Lo9KU081DvWRYQGsVw4VRfBmriQlCD4bCRxHX6V4XSWcD8/lrTPEpYipZ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KZuydqM3; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724672338; bh=wsl3YrLaOjovnNCIjsBbtpVNQi+hrP2bmg/zUf5XtxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KZuydqM3iPKp+uI8XRLpcrDfOCK7V6aBDrckVDn5g9VPA6BslRjRDF5V2eTgW4mQN
	 g9Np924SJ1sk7TnPdQD8n/lsAG2UIOmyewvSFr2BwP0ISkn93qdXglLbTe80HsPMi5
	 c6JoTBa1dXY5997oDKeoa3jwXEmgyjI9ccwkVSfY=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 4CA9427D; Mon, 26 Aug 2024 19:19:10 +0800
X-QQ-mid: xmsmtpt1724671150tfknzi5pi
Message-ID: <tencent_AAA2EDEACE4478EA6C9C2CA96E8095DCE80A@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jfQte9tgmmBStTXdNzkkWprxDThbE76o3E1Mdlm5xztf1z9OgKs
	 PM/RdTwqfYO6f+zp1+uoskPubotRqljuP7V7cDJMgXk0ZMlfQUgGsahssWs8uGypzY10TIr7Grai
	 46Uzm651nuf8+Swbj42DjWLJ05UuFAOIHi9T5KSfwpLJSAE+ZvchymyBfhOuUxM3TbQbAvI4o6HC
	 4Tm9iQuTqUcLoH5w78Op9nGU1jXmPBo/jP8kDzg38zI76VrJb7bMQWSEzX3WUG4hLbaShe1R1IFN
	 B14TM4WwQ9i3n6ODI4gow75BMXqE8zV8FDDEXMHbcy+1bBgvT5VIoXjw37BNr7uJSTSbgZpS1k/a
	 AKniX9U/9sXWA8GPgJJlJ7leMoa0pYrHm9a2fyjX33kSO7EVvDcd3Qy4uZtLb6eysycZcRjN9g2w
	 xy5JcGOyUtPY0aCpY7WJY/62fhJJfWsMOTJjO0SLFlK9WYfCuTYAl4dTcUtYkxR30m7CzPFieBQj
	 ag954X7REWdWnNSxXzreIJ7kGpaJeXZSXbgb8Ntk9cLxn164zmHl1axlc1EqsSCq+6MuVfFfuMHP
	 qe8grOJ9A5wRi9wwvESEF/T4803dFCgM/ZP8i7Zd4rKN8CRrPSMfPt6TylQsH8odh7/YTFSOTTrx
	 MR+it877zpn6VRUcPnVxyPLhqgmmw6qRGlp36vNIZPejYyUj5id+hPO0SJE7eV6uZsfKIkZ+6O+G
	 tE9ZiRp9iHDUVgsVHaanQ/4w8/T+/XxJk+iNTieDNLJh8JESb16ynY4kyvgqTjSZJ8lLrAnvTWs4
	 oFWhmSsFFcSTjPxudeQ+JMs65cQAzDCoZ/pbklO2BbygCivQ70XNDKT4iHJHDjaGmZn5OyuVyp3P
	 8lb4c7NSnad/iPIazoq/3/MU2mhaxjq0WCodOPZbz3dQWmSfouIoaYC/A8qTXe766SFxgHAkHJNV
	 SpT3kO/kC28ZNO/AZBlT3/IZMWktz575eYJZVj7nUBuPvyjql/AXRznF5gz+ge
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: gregkh@linuxfoundation.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	sergei.shtylyov@gmail.com,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V3] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with usb_control_msg_recv
Date: Mon, 26 Aug 2024 19:19:09 +0800
X-OQ-MSGID: <20240826111909.2608973-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <tencent_2C2C336C9E441B294BB21B6A2558BA34BB08@qq.com>
References: <tencent_2C2C336C9E441B294BB21B6A2558BA34BB08@qq.com>
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
V2 -> V3: Adjust indentation style

 drivers/net/wireless/ath/ath6kl/usb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 5220809841a6..5b1ce4f9ed54 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -1027,9 +1027,11 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
 	int ret;
 
 	/* get response */
-	ret = ath6kl_usb_submit_ctrl_in(ar_usb,
-					ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
-					0, 0, buf, len);
+	ret = usb_control_msg_recv(ar_usb->udev, 0,
+				ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
+				USB_DIR_IN | USB_TYPE_VENDOR |
+				USB_RECIP_DEVICE, 0, 0, buf, len, 2000,
+				GFP_KERNEL);
 	if (ret) {
 		ath6kl_err("Unable to read the bmi data from the device: %d\n",
 			   ret);
-- 
2.43.0


