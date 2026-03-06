Return-Path: <linux-wireless+bounces-32605-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJwcFxmWqmmIUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32605-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D41C921D779
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47BFB303B2E5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE6B37C119;
	Fri,  6 Mar 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAs5q0ZY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC53783D1;
	Fri,  6 Mar 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787136; cv=none; b=NNoF9Iw0Jf5eV7CN8DT4KvhTnMlcErU1OtMj6Hhe9te1uKqYnoLyeWuAqcRTkK3gWzOD/Q6Mh8HOXOaxsVxW25083UReHrKQKGsVMRanGGwmevROIxrfMvs2FFM7b9YeoxDhwa31f2s4QRYTHloLM4ObYzbOOKiiT+9ne4B2Q4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787136; c=relaxed/simple;
	bh=zJISFJhAJ3tf7TyuqSsMvehn32gIa5K1gPFzzFRKP8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6dUuoHzZ/wAq5bAR+F2VW/EIV52riVvJGUZpI28SmTLJCWy0tzx0xWzkHikHiRKBRFVQ2MmO37LX+xYPR3QzXZUIcY7bPWWhm4qPfrcb+cP5PjgcC0TkWFAO5Wl7Tpdrj6HRvFKUehYBEni96xEz4TPLVtUZS9gbMAxFUtom+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAs5q0ZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC18C2BCC7;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772787135;
	bh=zJISFJhAJ3tf7TyuqSsMvehn32gIa5K1gPFzzFRKP8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAs5q0ZYlFwz583GQPrQmrsQnUxArfq3F34w4U+2sCMDvC/nXug/+Nr4+DTI1QXYk
	 ivnmXzPWhY4Qu11fWvgRpVQbGpK/R6c7qh5ieqe7m8/PUTyxD2VJCaFX31/3B9nNVC
	 qo7adzvE+ujCgdwLHHuZ+4q59sMZIJ5UVKCzAhWwwi4DvOjrGABK12wzS8svlHzPrn
	 JaHjy8Wb7+UDQU57svziBpWYZtqmmeR3GXfN7VfESLpq5fwX8uf8VFoNU3RO34ZFfw
	 YBcjxakHEXZCweTNoHT76uOyL2/lSsrXD7xMvMaAZ5NXtQWFOXssxsIeLLMdKM2EXL
	 8mY23MYpEQrgw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyQuq-000000003An-45wU;
	Fri, 06 Mar 2026 09:52:12 +0100
From: Johan Hovold <johan@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Hin-Tak Leung <hintak.leung@gmail.com>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 15/18] wifi: rt2x00: drop redundant device reference
Date: Fri,  6 Mar 2026 09:51:41 +0100
Message-ID: <20260306085144.12064-16-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260306085144.12064-1-johan@kernel.org>
References: <20260306085144.12064-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D41C921D779
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,toke.dk,chromium.org,dolcini.it,nbd.name,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32605-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wp.pl:email]
X-Rspamd-Action: no action

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop the redundant device reference to reduce cargo culting, make it
easier to spot drivers where an extra reference is needed, and reduce
the risk of memory leaks when drivers fail to release it.

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
index 54599cad78f9..83d00b6baf64 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
@@ -802,14 +802,12 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
 	struct rt2x00_dev *rt2x00dev;
 	int retval;
 
-	usb_dev = usb_get_dev(usb_dev);
 	usb_reset_device(usb_dev);
 
 	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
 	if (!hw) {
 		rt2x00_probe_err("Failed to allocate hardware\n");
-		retval = -ENOMEM;
-		goto exit_put_device;
+		return -ENOMEM;
 	}
 
 	usb_set_intfdata(usb_intf, hw);
@@ -851,10 +849,6 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
 
 exit_free_device:
 	ieee80211_free_hw(hw);
-
-exit_put_device:
-	usb_put_dev(usb_dev);
-
 	usb_set_intfdata(usb_intf, NULL);
 
 	return retval;
@@ -873,11 +867,7 @@ void rt2x00usb_disconnect(struct usb_interface *usb_intf)
 	rt2x00usb_free_reg(rt2x00dev);
 	ieee80211_free_hw(hw);
 
-	/*
-	 * Free the USB device data.
-	 */
 	usb_set_intfdata(usb_intf, NULL);
-	usb_put_dev(interface_to_usbdev(usb_intf));
 }
 EXPORT_SYMBOL_GPL(rt2x00usb_disconnect);
 
-- 
2.52.0


