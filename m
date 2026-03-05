Return-Path: <linux-wireless+bounces-32516-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMuROVhkqWmB6gAAu9opvQ
	(envelope-from <linux-wireless+bounces-32516-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:09:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BEE21055A
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BACF630F36DD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161738B7DE;
	Thu,  5 Mar 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZLrVprl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D0386444;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708857; cv=none; b=MoIigFWOFQcGi/8+n/2TZ6xTuqzqgRhePRC21Y1FFMoHRrjVGM4tI3vLg4mmrWTw7SNfk8Q3k+FBXbZYe82x5CPVpwg1iM2Q/egbay7miO5dVWMaghmhHso7q5WNgK2+eGKjMAwTfihGYFVfuERDHDmBjnSTDyMi2Vbv0+6Mrmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708857; c=relaxed/simple;
	bh=WlcQfuVYUTxHWCyVOtszC/tk9vnPA9GDI5j4ICmNw7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZWtQtGes1YWTUUItyyJcKaIL+et4tD1n1H3eg8d2+F2PTbo4A08+x6levqbZ57odTGYc1kPPvY3Km3/LBF1tjlbeb3roG9eHUWCklm2Y1f63GvsS7aVdLD/s8/LU2dohUJORtzFoOYRZtioA6QnDWY53tx8c6jcsNJp6weqUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZLrVprl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6226EC2BD00;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772708857;
	bh=WlcQfuVYUTxHWCyVOtszC/tk9vnPA9GDI5j4ICmNw7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZLrVprl0ZN0JnsloLZPlxLlJByyPEynB4ZJHwB3519k2ekK6HmIDvEb10lXslPhP
	 0Rt2sza2Wm0/a0PI6spla5sM5WyykDzFhTcDM2GXpybPVmFHgQFKBq78VSvETlMpaf
	 dQeX8DTgkZFLpWU9nrp4+qzPBFbRXQWQoH4rHHd7qY7StQN7FTaYEJlx+pTbY6jPu6
	 mNmdtJuux72xgcaR5+78aJnjbY0zGgBi2txeauv3EWxWEENgl7V/bXBtv5zP4Rezjf
	 Z/784iQym3iWJhCvP/31038X+A0nz6/A6r6oUkIF66kLI7UINcgEe4JP5gm9Szfh8G
	 KwLxzQZcQAkCw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6YI-000000004d7-2skY;
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
Subject: [PATCH 11/13] wifi: rtl818x: drop redundant device reference
Date: Thu,  5 Mar 2026 12:07:11 +0100
Message-ID: <20260305110713.17725-12-johan@kernel.org>
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
X-Rspamd-Queue-Id: 88BEE21055A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32516-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index f7e0f6573180..1d21c468a236 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1475,8 +1475,6 @@ static int rtl8187_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, dev);
 	priv->udev = udev;
 
-	usb_get_dev(udev);
-
 	skb_queue_head_init(&priv->rx_queue);
 
 	BUILD_BUG_ON(sizeof(priv->channels) != sizeof(rtl818x_channels));
@@ -1663,7 +1661,6 @@ static int rtl8187_probe(struct usb_interface *intf,
  err_free_dmabuf:
 	kfree(priv->io_dmabuf);
 	usb_set_intfdata(intf, NULL);
-	usb_put_dev(udev);
  err_free_dev:
 	ieee80211_free_hw(dev);
 	return err;
@@ -1685,7 +1682,6 @@ static void rtl8187_disconnect(struct usb_interface *intf)
 
 	priv = dev->priv;
 	usb_reset_device(priv->udev);
-	usb_put_dev(interface_to_usbdev(intf));
 	kfree(priv->io_dmabuf);
 	ieee80211_free_hw(dev);
 }
-- 
2.52.0


