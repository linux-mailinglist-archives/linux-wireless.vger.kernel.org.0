Return-Path: <linux-wireless+bounces-11992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A1B95F356
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 15:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AF8BB20B3E
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EBD187FEA;
	Mon, 26 Aug 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yxLKXy8T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB118755F;
	Mon, 26 Aug 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680552; cv=none; b=kvImmmRaDxTo2QWYG/HESJB/2gmOf9KnWozTawmm/6w9VNqM13Nn79YkDyzhj7b5xQ2E/2a66nWB/3SG008Tp1ZSv/wVW8rMD8TBhwE5KNXPbmiFLB5ykP7Egk9FJoc1gyDtj+7LvE/hCioxRqNAWg8+aXdQmnk8Qmh9yWu8/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680552; c=relaxed/simple;
	bh=NATgpsff2H3ZQ8S3GdgP7lJSfrRhEUnOzap5J7BLiek=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=s63211xGNV46Uwo0ZlY0bmqtyS3etitShWpxf5WnVDh1FRsSu2pPAf/U3ZbLSCXsvCitee5HPTzE7Fk+nmBYmbYzdsbfV22WBIf2lS+SxEIwN+byn1nZZKvm+zFN5fW6TsGeQZRLhuJ2UNJQwkxrQVDM8dFVw640xHofTpE1SSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yxLKXy8T; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724680244; bh=FSL0sS5dQKb2f7iPwim4nCmugDqsEvcGTMYmGhj9qDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yxLKXy8TPHsmvWjAXcQfbJ+hf5sg1x9g+VSEUWFrpdSEIr7rw/Lf7FkeLeV5he2Ze
	 rJrvctC9VPR+OUHNVJLU5ZMk0koNwXObE15TKFdTMLgnguw1WXo0snrwiTXIv7sWd1
	 d6IP6ttQT0LbUZKZGecPEiqTzRyMdfp6YnvtjZuU=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id B12B340A; Mon, 26 Aug 2024 21:44:18 +0800
X-QQ-mid: xmsmtpt1724679862tuqv3rd6h
Message-ID: <tencent_E63C2506BA5BBB0B33669E0E1B3F4B4B1B08@qq.com>
X-QQ-XMAILINFO: N2bAIxLK0elndbABOvoA5K6JOD11oPBkICuZ0Z6fRM/bTt584GnqK1BE5Zh53F
	 2gF8ZGteJRE1Ycd5n2U0UKoXI0Sq4RWUZ4iYz6oCKe+Uf8LxnTBJKx+7AZmWTcvSbfMhrvQ055ND
	 qgqifAIdvJ7mvIPLvVGgPx8Z13dUIsV28k0mQ0GeM7jVubyYdXvphDJ7BhSomy6HxcMVLfB14nKE
	 FxlKl8+kJEcqQPn0jk193Vs7ESWv5LGANUhK9Y7g8vG5y36scQZLIfSj2fUD/SNKF4RR0+rsN+5F
	 A2xXhdwTOPfGTqqK1drLhBvsg6akuiHiukgzyAUflFERn2s+E254lz6oRcbKU3L9yZXm8YvnFOY2
	 DsjYOQrG8SHa9Ix3UanYrP4IlRntRJ6dGXzSsnLaumMHM52DlnKYvd538xDq+yme9UH8dTGkOKpw
	 YKiZntSgcy9s325u18JlBjlFLlVzQp8nirPjgvZSag0L2S2YO9P9Cgd7vn0UGAHA7+ZpGA1z8AR6
	 /SrnGTfG8oxXhqOj3hmNo4chu7m4gJg6sTQW6FhbKMuPIxAjWcIJ9k7pCbbMbQgVP8RFdA88HqTb
	 0Clq6MJcYeyZqjuvK+a34f0DWefoDiWhQ/uC3yg2jDqB+3M0doigAd8OW1S5PQUvGXBMpB7N+Ra2
	 7HHy1opZRozkcSQdnY2u1wjQVQUSubq3GCSDS/pn0ohA7fCTVCNoQGioxMyL1fTJ5ySEp8kXn0BI
	 sNrNFEefISfJJ0IQ5wPDRe/lOosVphVBopethX2UKO4YAjxje31aQ9zV4KCOM8crt0hlWzIwFsws
	 Ndl4BcsvaR/dyq9RhYPT0ijUr/OqQlXAK1tfHgb7pfxF0wzD51s3x5G6BL5lpuXtrsTGVv8oIUMJ
	 zxL1jhyCKdiy7R49Kphy3BNTZPh5+Ub/Vw+K7zXWXJLWijwDMIpsfTZHGEQbIc8mDgOGqAP7ur84
	 XHOdy36pVvkqX7JfV4LCYj3O8+azvNdCzPiAYj30etG8vbNFKo8l19m/MSad+vrZ13J1WqHReYGS
	 ukoyLQpqAorCWQeILy
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
Subject: [PATCH V5 2/2] wifi: ath6kl: remove ath6kl_usb_submit_ctrl_in
Date: Mon, 26 Aug 2024 21:44:20 +0800
X-OQ-MSGID: <20240826134418.2744882-4-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826134418.2744882-3-eadavis@qq.com>
References: <2024082607-foothold-boss-c693@gregkh>
 <20240826134418.2744882-3-eadavis@qq.com>
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


