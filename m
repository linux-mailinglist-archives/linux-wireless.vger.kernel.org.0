Return-Path: <linux-wireless+bounces-32508-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBlBKFJkqWmB6gAAu9opvQ
	(envelope-from <linux-wireless+bounces-32508-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:09:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2807F21054C
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0586830E5651
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAA4389112;
	Thu,  5 Mar 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOaIFzGQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FF7384231;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708857; cv=none; b=uGlRHEhTqy0GJKbPGVy5rhiIKZ2dfYf7aM7cseFyCMdbEwm+t8ehStPg5lcTc9lX4Lum1kFPFQdMH97cQrGlzyvjvvpGavBo/RDTi68nwxfyfWTPcgpzNJ9MlmH6FjmST3BBrboXCK1MMGwfscFrHkWFwFK7XPyD2rGyw7SLvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708857; c=relaxed/simple;
	bh=42Ws8GlzTjjM4nukmpyywyMHmPwKfyyiFsTL7Pg3heo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cb+DEKsgq15sZyVH4K+48F0th6V2beHogjDjWk6ZnETSDoAQ0HW26KrE4mHy7R3Mt2Tk9tJegao7Ca5vS/2Yu/gkLq8kk+0Bpi3RrsDbLVpX5RJSmQihV2moSGy35sBJVqvxCUEefXmjp+TX2NskOUPanftMM9UsiSqkd0kbUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOaIFzGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF90C2BCB3;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772708857;
	bh=42Ws8GlzTjjM4nukmpyywyMHmPwKfyyiFsTL7Pg3heo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOaIFzGQ7/rMeZLOz2PwYSqi5x+nYQfOEwxzNrhGsSWKoyOUYY9C1E29M8BpDXxWO
	 9Z6hHVM6hdiBEyoTA1L4iHZkwIhajTVp88cdSQxu2onefS/CwERF2VvWP0JUKaVE4N
	 WURp0cJCbrcvMKkcPz9TAqoLHOI02IDJYhFXuti4F90nM7hI5mexWsQC0ZuVX8SIBY
	 iG0mRUTQxbbEW7xZn5ZNLafBe6VcemAO1oC4elXrhyFzmLNtgf8I+X1VRFNANUGZGi
	 gzYciOQ6OV93o3JbIhXWPSrNKg9hNMM3WjA5jig596rPcsFW8rL37r4ohDGbYVtIO6
	 1c/FFnx74hSOw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6YI-000000004cv-2bgS;
	Thu, 05 Mar 2026 12:07:34 +0100
From: Johan Hovold <johan@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>,
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
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 05/13] wifi: mt76: drop redundant device reference
Date: Thu,  5 Mar 2026 12:07:05 +0100
Message-ID: <20260305110713.17725-6-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305110713.17725-1-johan@kernel.org>
References: <20260305110713.17725-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2807F21054C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32508-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop the redundant device reference to reduce cargo culting, make it
easier to spot drivers where an extra reference is needed, and reduce
the risk of memory leaks when drivers fail to release it.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index d91feffadda9..bab7b91f14be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -151,7 +151,6 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 		return -ENOMEM;
 
 	dev = container_of(mdev, struct mt7615_dev, mt76);
-	udev = usb_get_dev(udev);
 	usb_reset_device(udev);
 
 	usb_set_intfdata(usb_intf, dev);
@@ -193,7 +192,6 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 error:
 	mt76u_queues_deinit(&dev->mt76);
 	usb_set_intfdata(usb_intf, NULL);
-	usb_put_dev(interface_to_usbdev(usb_intf));
 
 	mt76_free_device(&dev->mt76);
 
@@ -211,7 +209,6 @@ static void mt7663u_disconnect(struct usb_interface *usb_intf)
 	mt7663u_cleanup(dev);
 
 	usb_set_intfdata(usb_intf, NULL);
-	usb_put_dev(interface_to_usbdev(usb_intf));
 
 	mt76_free_device(&dev->mt76);
 }
-- 
2.52.0


