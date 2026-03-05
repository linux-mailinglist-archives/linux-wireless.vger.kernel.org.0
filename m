Return-Path: <linux-wireless+bounces-32506-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE+7MF5kqWmB6gAAu9opvQ
	(envelope-from <linux-wireless+bounces-32506-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:09:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43140210568
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E74530268A4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866A1384239;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQTkkoFh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618E5374745;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708857; cv=none; b=e53H5dr1crP4yVmnAvBN5pxtEUy/3vNM69nqwbzM+F/dJC74jrvMTRX17L/cH/Jb4l/4Q0IaN64+eqBH681VzH9gr8nmEvZaHxyqWn6jEwpcNiYzP2nyGmfwd1e+zKLaki/HlOG4kb7o3Ew4rjU0tcq3td4kr6ChjD30VqUjaZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708857; c=relaxed/simple;
	bh=kaq0JBNHyQqQlidhi1/aPYh1/H5njyrGvo0l9Tfow5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8h6pgMc7rdbIRIneE9eHKdn5v1flPY9d+F4zWRerG2bY7fQV9XXCsCj08XReYX6PLG1cYAYrMJhbc3nmK2VRly0OTn12xe4OCg50DH7V6RIZawXRJ2cPvzYyKpqRtt1BK58rAGB1OH1zVctiBENfpPg0I8n4UhbWU5JfNse5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQTkkoFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1646BC2BC9E;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772708857;
	bh=kaq0JBNHyQqQlidhi1/aPYh1/H5njyrGvo0l9Tfow5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQTkkoFhssKdRx0pGljGKTXpqz/w+cu8eDMUVGqWd6jcRCVdhHMLf+ALdT44Fjx2G
	 QIZW5GYHa1moZg5+A3hvPlHFFcQV2RCUrtUGdWr4kDTzfJYgoAJn6DJkTn/Bf4ZPPj
	 r01LS5Qe7lrSjuMC7eCUvHCugmToz9zyCTa9M/3pbVvLzh+EF8S53dRRkCWRQeQ+YQ
	 yqGYGasYaGoyqNFmktO8xf1WSSdFoD7eErayW+EKo1Dfdx27xmqXq5tTsEh+OW2KfA
	 2qO3u3c75dV4nd7mO30ltdRNrpc9D0P5cv69tJgUBQxnbGTtjKKGwtoEpvmiF9nBdL
	 ioBbh2ofNJI5A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6YI-000000004cp-2TFX;
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
Subject: [PATCH 02/13] wifi: libertas: drop redundant device reference
Date: Thu,  5 Mar 2026 12:07:02 +0100
Message-ID: <20260305110713.17725-3-johan@kernel.org>
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
X-Rspamd-Queue-Id: 43140210568
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32506-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
 drivers/net/wireless/marvell/libertas/if_usb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 8a6bf1365cfa..05fcf9cc28fa 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -276,7 +276,6 @@ static int if_usb_probe(struct usb_interface *intf,
 
 	cardp->boot2_version = udev->descriptor.bcdDevice;
 
-	usb_get_dev(udev);
 	usb_set_intfdata(intf, cardp);
 
 	r = lbs_get_firmware_async(priv, &udev->dev, cardp->model,
@@ -287,7 +286,6 @@ static int if_usb_probe(struct usb_interface *intf,
 	return 0;
 
 err_get_fw:
-	usb_put_dev(udev);
 	lbs_remove_card(priv);
 err_add_card:
 	if_usb_reset_device(cardp);
@@ -321,7 +319,6 @@ static void if_usb_disconnect(struct usb_interface *intf)
 	kfree(cardp);
 
 	usb_set_intfdata(intf, NULL);
-	usb_put_dev(interface_to_usbdev(intf));
 }
 
 /**
-- 
2.52.0


