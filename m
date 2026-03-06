Return-Path: <linux-wireless+bounces-32598-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM6rB/SVqmmIUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32598-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 446D721D695
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DFA330185D1
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E173237C105;
	Fri,  6 Mar 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvNzqT7N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C5330B28;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787136; cv=none; b=jNibq8/+eHSfcoFmxdGANqg90Bb83kMpT+42Dks7mqhD75Pps4thaTCVGN1iAri9FBv11obO5tyAt7hvqMjswXZS8IZVQNdIQYuE7B7qxD8RRKm2x7bFTo2SJW2rmZH19EwhKOzAxRxpNWspV26GFfI7r+xYPNaY+q9ss84cyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787136; c=relaxed/simple;
	bh=xCEaqUoallq2NdTzWqQElwbwYb5T0f2rYJwsXpRUAaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2Oz7iiFSYvyUUjSofQ/dEu8D/UlBYz4RLtG9j7qknAzyM+y7Qk6HsPcS/WvGChyLX2ZUoFuIU51Hw83NazI/oE8d2BhuOas+F/BGPAykg63cnKxROgBob6Y6nvG19VdpdgRwQ9vCe6QbSsjlM6uK1vwF/MmOPY2I2Nbo0sfBkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvNzqT7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B781C2BCB0;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772787135;
	bh=xCEaqUoallq2NdTzWqQElwbwYb5T0f2rYJwsXpRUAaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvNzqT7N5X+8TX19x8BWY6BvUmFfbUw+2yOT1rmMozBVqR/gYrGArQP7Z964wci73
	 VZPVvz7GrXGDDp4EbRr7XAccgN78dx5juaLxyu2poNjJkdiE7DkNsdPoPMeSIwpOh7
	 OeduSMouDflTVP4VbTPWbnKja/arjy0CJ5hVIo433js3ACXjYpAbJFqfnQqI49eskK
	 ffQhibux2LDYrVWhB3CmB7Q2C7JqXr81plwts8I1yGcOHEc7DbSL+UJGB2+t85dSKr
	 bGq7ioN6/vODGnLtx0Chw6Rm2MnoR6sL9GYC7xO8tUE45XIs/FwFk40a6A7txv0qH2
	 HW3TWLoNYGsyg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyQuq-000000003Ah-3uu1;
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
Subject: [PATCH v2 12/18] wifi: mt76x2u: drop redundant device reference
Date: Fri,  6 Mar 2026 09:51:38 +0100
Message-ID: <20260306085144.12064-13-johan@kernel.org>
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
X-Rspamd-Queue-Id: 446D721D695
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,toke.dk,chromium.org,dolcini.it,nbd.name,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32598-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
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
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 01cb3b2830f3..8af360bca643 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -57,7 +57,6 @@ static int mt76x2u_probe(struct usb_interface *intf,
 
 	dev = container_of(mdev, struct mt76x02_dev, mt76);
 
-	udev = usb_get_dev(udev);
 	usb_reset_device(udev);
 
 	usb_set_intfdata(intf, dev);
@@ -84,14 +83,12 @@ static int mt76x2u_probe(struct usb_interface *intf,
 	mt76u_queues_deinit(&dev->mt76);
 	mt76_free_device(&dev->mt76);
 	usb_set_intfdata(intf, NULL);
-	usb_put_dev(udev);
 
 	return err;
 }
 
 static void mt76x2u_disconnect(struct usb_interface *intf)
 {
-	struct usb_device *udev = interface_to_usbdev(intf);
 	struct mt76x02_dev *dev = usb_get_intfdata(intf);
 	struct ieee80211_hw *hw = mt76_hw(dev);
 
@@ -100,7 +97,6 @@ static void mt76x2u_disconnect(struct usb_interface *intf)
 	mt76x2u_cleanup(dev);
 	mt76_free_device(&dev->mt76);
 	usb_set_intfdata(intf, NULL);
-	usb_put_dev(udev);
 }
 
 static int __maybe_unused mt76x2u_suspend(struct usb_interface *intf,
-- 
2.52.0


