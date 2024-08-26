Return-Path: <linux-wireless+bounces-11987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE7095F24D
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 15:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58385282A2D
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D1216F858;
	Mon, 26 Aug 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GJHAVdBQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD98165F0E;
	Mon, 26 Aug 2024 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677340; cv=none; b=I2B4ElMmWXr2fBa/fKJ/ntIX+4aDG9GRmlVT6sZubO5+3gGu2mhyRoapLsF/rA+AIAlHRuJQ0MhlQPamGko8u5QELgOBQsSqGhyIia6VGPgj/Uh3CaMG2/1afXxEr2fyqhiNcqtOpmcQTicbjr/klmekHHUsC32LMLaboeQbf8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677340; c=relaxed/simple;
	bh=scIlDt3bJxc6xjtCfFWzsD60sMCU7dzjdhlTShv6odY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=t24OH41UZZpapI/URs+GkhkMbI6dQhZgF+zAGUx7mYs+AmYYruiZcVmhct9TBBpaDKNpZPbDG0ikn/4skcizU+TCW0T1CibHjBXLToUWo3IwY3p3pM72xnBzPk54DqVNZ7VRDlJ1iElB3OYGNJ3KOCGu1Q8fiYD5+QGbQiZcLg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GJHAVdBQ; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724677321; bh=4MNoqgFAOdi2a+l9olqRlqs76QuNfFgvKzCU8S9eMFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GJHAVdBQezJ0uAmC4uDhKKePM7ocwsgnTHzB7nWLQ2bG0LdTggwD0D0T7LJ42wXQ4
	 X3nWMPRh0J3Zvmv2MMmlnLN4NZWB1frIXCcrEw5xSG7s8DeC84DAh3wo/4oMfm22Dv
	 /EaXQ6LykA6uTTeHTOKonGBaOmFRt6iLm0Ina1PE=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 771A2A8; Mon, 26 Aug 2024 21:01:55 +0800
X-QQ-mid: xmsmtpt1724677318txpb2ic50
Message-ID: <tencent_6D26CCB3712366696D23AAC446377C576505@qq.com>
X-QQ-XMAILINFO: OeF1Bg2NKDhoY4We6TlRiMdQPRfowlu1cuonH5uz2sqZ3Ieo5wzXEtAi02xl7E
	 ID3XGJ6Do7AhjaYuBFmJ0z4EK3O0gXTGtyqkPDQLfjp6fIGnm8lvcaN3VAMTICv4sGmBEPuE01WH
	 N3xd9q25ObL+n0TSt3OX7dJ2uhCgBX4XowZR8cWYKgCsB8ljOX0XQd6xmB79gfL6qc7ahcAfQdZn
	 jw+xR7q8xEQdGRK+r89nIlxtGgHPcPzt4uMW2dBwd7Gbj1yy+PLCf54tmPzHfpdR7RqJja6Nkzad
	 vlLA2RGR0NjK1E/WP2ssGxmdc9iww761mYD/9OkV5DrIlH/CnPcMzzJmrjj94IyHIgy4fOzA5DyL
	 dAyE7kKIvr8vXUR3BLhQLuHREAdgofzjYh1cA4RtuXRUKUwMZ1xvbGbwgB/RAFfWRxc2blRu4B0U
	 0shQCR3A94AL/J9ajd25kUhx052DRLYQ+S1AwF6Q3gv4z9+VRJm/k9p2OWAe73N7APz88UcXTLIl
	 qXmVbuPx7LH0FwJZw+Y+nkdS1TO3gBHybfxyhss3mc0yOYqRRl2H8aKyP7L3OGWabZ+uoWVirt5Z
	 NSLvGTjvS3qiuwrqjIEhSDivK3Wbs9KtTdsHOvXBkxgGQ/7NdeI4OFhLLxq4r/zXTSs3TIFLKbID
	 1+dTRkWOKwOkwqgSLhErhO3XTZot8IogGVFr5afuPE3FxYnKiBum1Ccl5hoSro/vRVD5CWF6FQgE
	 ccCHRNtvSL8uBQR3//pJ9SjumlLnAxlqjAnKDMlGnFlKerK5hgr/CwhkKxXkzumQOAjc19EzPw30
	 78QI8c/t8/9ckdvbhj14IuwxG2g+zZHYEtGcb0P+zQfU42h0TVYUck55/Cvld318+YFVOZOHHgCE
	 VbwelnQNiZNa8dvdia9kkRDyyfc7t2SewVlqtsi8/mI+JvJfVallkjNXmUewyBKTlraJY9g7GDVo
	 UYTFh6Qfost+SsybQikc9CnQPEyvQ7aLUp+gw5SM2NrmPCXLy1eCIYTCHF+hdjXT4yk199Rtuu4h
	 ecmT0T18h6ujSQLq67SGyifbUTR7gxxDpilrpnGg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
Date: Mon, 26 Aug 2024 21:01:56 +0800
X-OQ-MSGID: <20240826130154.2706792-4-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826130154.2706792-3-eadavis@qq.com>
References: <2024082631-upward-zips-f7b8@gregkh>
 <20240826130154.2706792-3-eadavis@qq.com>
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


