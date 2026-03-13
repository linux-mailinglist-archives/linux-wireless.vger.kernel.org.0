Return-Path: <linux-wireless+bounces-33225-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KcCLo2BtGlTpAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33225-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 22:28:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7B228A239
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 22:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23D20301F6BE
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 21:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFAE386429;
	Fri, 13 Mar 2026 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BBJ1OgFR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332E3845A3;
	Fri, 13 Mar 2026 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773437319; cv=none; b=NCdnfHl/Y4X7OlaNP7CKabvyljCbC90GiYJwjDnelkyEIKrEOeInbTBaJ0ZSq9Bf6MR5RZi/8tb1CJwaHMbc+xU0h8csOXfyejFUR/1c/u2EG/b9bM0Aqk9wq3mvwBu90ToZhgw24BSD7EMQWLwcdIZA4uhkX6Pca7lA2b09DPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773437319; c=relaxed/simple;
	bh=W75rJzcQ9OqjLMj37j3eU7ccV8Fk+yD0YTYrhsXASVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UejRbwqD3G17bP6UnOWWsuoAJCuyHdtH7QFBzZ1GHN37MpvfqRW9DpOsZ9ZyIId24WH4ntmu0VPOacOV2oe6sRB4mHFgH6w2RTSDjBbAnutxK7u/RHfDw24j8oiZTXEgSBFVaFGgDsoK5iMoOidqFzBpBatqromgafArCLi0D+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BBJ1OgFR; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iPJMovgEDfKBBMN9a4vOtIg1aTmb+ZeSY/mDll1OlFY=; b=BBJ1OgFRDC/MivY5/YXJF5/JXe
	kzaURJ8HGWTn0Oh3qa/Jcwt9TJRGfqsMi8NVqFlR5TYVb5tGGMHIKerRzphjUsPQvjUrDQp2i99FU
	oGl/tv7X3s3XYg7sVCgnh67GFLh+hB0rQzAC5XBx8xyvLlwbfey3Kg74Di4NaAlqJfdAtYdaIEVrK
	DhG8K0cBuxbJl4bg+cTyKmYnrP1bdXn+Tq6JehgM6kj7Jet1heEvJPqafpKfMsjP4kFc9zDwWhAwu
	S05lhSYRBfLn5Ae4FrOO4KCezw72XnWGdiVJ/rfcY+3FcI/fE5iod2NkFCXaq4v/rfH55kIE6Mftz
	XzcIQfoA==;
Received: from 189-14-81-93.vmaxnet.com.br ([189.14.81.93] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w1A3f-00FRhq-E6; Fri, 13 Mar 2026 22:28:35 +0100
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Fri, 13 Mar 2026 18:27:58 -0300
Subject: [PATCH 2/2] wifi: libertas: don't kill URBs in interrupt context
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-libertas-usb-anchors-v1-2-915afbe988d7@igalia.com>
References: <20260313-libertas-usb-anchors-v1-0-915afbe988d7@igalia.com>
In-Reply-To: <20260313-libertas-usb-anchors-v1-0-915afbe988d7@igalia.com>
To: Johannes Berg <johannes.berg@intel.com>, 
 Szymon Wilczek <swilczek.lx@gmail.com>
Cc: linux-wireless@vger.kernel.org, libertas-dev@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 syzbot+74afbb6355826ffc2239@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33225-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_SPAM(0.00)[0.210];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[halves@igalia.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,74afbb6355826ffc2239];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,igalia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 5E7B228A239
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Serialization for the TX path was enforced by calling
usb_kill_urb()/usb_kill_anchored_urbs(), to prevent transmission before
a previous URB was completed. usb_tx_block() can be called from
interrupt context (e.g. in the HCD giveback path), so we can't always
use it to kill in-flight URBs.

Prevent sleeping during interrupt context by checking the tx_submitted
anchor for existing URBs. We now return -EBUSY, to indicate there's
a pending request.

Reported-by: syzbot+74afbb6355826ffc2239@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=74afbb6355826ffc2239
Fixes: d66676e6ca96 ("wifi: libertas: fix WARNING in usb_tx_block")
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 drivers/net/wireless/marvell/libertas/if_usb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 11cd1422f46a..d3b9f7619a1a 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -429,7 +429,12 @@ static int usb_tx_block(struct if_usb_card *cardp, uint8_t *payload, uint16_t nb
 		goto tx_ret;
 	}
 
-	usb_kill_anchored_urbs(&cardp->tx_submitted);
+	/* check if there are pending URBs */
+	if (!usb_anchor_empty(&cardp->tx_submitted)) {
+		lbs_deb_usbd(&cardp->udev->dev, "%s failed: pending URB\n", __func__);
+		ret = -EBUSY;
+		goto tx_ret;
+	}
 
 	usb_fill_bulk_urb(cardp->tx_urb, cardp->udev,
 			  usb_sndbulkpipe(cardp->udev,

-- 
2.53.0


