Return-Path: <linux-wireless+bounces-32103-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDbVGxU8nGlCBgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32103-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:37:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DA91759B1
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD8D301E6EA
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 11:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595BE3624D7;
	Mon, 23 Feb 2026 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V9ejggRs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51B361DB5;
	Mon, 23 Feb 2026 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846674; cv=none; b=RJboxbv2xdjQfxL7ZnBuV0UYJ5b43GOCqwhnLUeYQ0Jkgh3PiAOWRbHCu7Er3CE6yU/B2VvOATBbww76tTihkuPoOqT09MMW1HTjKomJM/R1SNKkXDobhxklYbNQjd+n4Jx9ZiJJfp7hRONlgrnPIoJoLXyXy4ubmZUAlQfoRiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846674; c=relaxed/simple;
	bh=hwEciQS2IYkIhZYn+0zPOpRikRJ+VByuTWR42VvOyHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMraHzl/mpRdzgu7TMvnFCLvAOheFmZlNK4jGNxcHq3KwZWZX9xZ5w2qPkgmqewBuGugboz0UxISfgZazHEme9y/U1m9YSd9VxPV9bdexncWuZPeDjS4bQ6K4vJGCvnlvdkftdBNzBt91G8vbarnPiTSSbu1NRHsfHgcBzk6KqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V9ejggRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5809DC116D0;
	Mon, 23 Feb 2026 11:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771846673;
	bh=hwEciQS2IYkIhZYn+0zPOpRikRJ+VByuTWR42VvOyHs=;
	h=From:To:Cc:Subject:Date:From;
	b=V9ejggRs59JY1s5q01jRgCDNMk0uYDpAG5dF2YIBwo9AIhRU03CWPRb8DKORWYjwZ
	 8fEOpSie3pEh1zMrMuiMINAXsc8FVtmHnlxrZru0PnT+uerlJHLZK0MUF3mJjCjsBF
	 2j63PWAAjF2ym9fwrusDL3HJIxB64j+CkdylEwho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	stable <stable@kernel.org>
Subject: [PATCH net] wifi: rtw88: properly drop usb interface reference on error
Date: Mon, 23 Feb 2026 12:37:34 +0100
Message-ID: <2026022333-periscope-unusual-f0a0@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 38
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=hwEciQS2IYkIhZYn+0zPOpRikRJ+VByuTWR42VvOyHs=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlzrP9Wx9ks2hbvkbCnJeD9xqnOoi1+K594/rDS3uPI+ /pe1Dn1jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIaTLDTMbvhywD519/63D/ lCKLm5vH7dvuGkBRpW+PHsic6ayazH25dr9p5/STli8B
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32103-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,realtek.com:email]
X-Rspamd-Queue-Id: C6DA91759B1
X-Rspamd-Action: no action

If an error happens in the usb probe path, in rtw_usb_intf_init(), the
usb interface reference needs to be properly dropped, otherwise is is
incorrectly increased when returning to the USB core.

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 433b06c8d8a6..36ac20039ce2 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -1046,13 +1046,17 @@ static int rtw_usb_intf_init(struct rtw_dev *rtwdev,
 
 	rtwusb->udev = udev;
 	ret = rtw_usb_parse(rtwdev, intf);
-	if (ret)
+	if (ret) {
+		usb_put_dev(udev);
 		return ret;
+	}
 
 	rtwusb->usb_data = kcalloc(RTW_USB_MAX_RXTX_COUNT, sizeof(u32),
 				   GFP_KERNEL);
-	if (!rtwusb->usb_data)
+	if (!rtwusb->usb_data) {
+		usb_put_dev(udev);
 		return -ENOMEM;
+	}
 
 	usb_set_intfdata(intf, rtwdev->hw);
 
-- 
2.53.0


