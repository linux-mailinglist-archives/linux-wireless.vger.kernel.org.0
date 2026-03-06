Return-Path: <linux-wireless+bounces-32606-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMQkMByWqmmIUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32606-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8071B21D787
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1185304B80A
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB937C11C;
	Fri,  6 Mar 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHP7JZ4W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447DB37269E;
	Fri,  6 Mar 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787136; cv=none; b=T/VTNF+6a29s42FOOEPKIFw1SWz1ShQ2hm2/aWsPmjqFu8abH9oLTGSaIfrPJz2dwkxRKN8vED8o0i9P5rREnGOhtlgJsZA40Wxx/h5A0wM4N8lk8R7RY6b0+UzwtaFezVhWHN1pxJ4ef9HGLeQPB28esu6OOFAlj8r09DC4Ik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787136; c=relaxed/simple;
	bh=Wg9PdiYnvFewTYn81qDhfXqKVkfZq7jAfwyGUQeiiBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfLdnZ4h/qCqdu3ZAtjC+zXhjw8ZMOaasrseWAUm/ddMlUKU1lilTU3cWg7dxfF4IKrhIWsjBJ70MI+V9uEbAuoBBYawJipa/5Ey5if7et0xRhF8ssV3EOaPr3Afax969CB7rUaenyH2kB+RnA6bI3W/yhEABeK2BhGBDECYaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHP7JZ4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58BEC2BCF4;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772787135;
	bh=Wg9PdiYnvFewTYn81qDhfXqKVkfZq7jAfwyGUQeiiBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHP7JZ4WHODayaL/lRc5G+Ol3AvbHNSE6IBp15uYa9mkQcm+puMjYGNqJijHif5v8
	 fRR5k/P9qGnooaPzCszQq9yOsiGB2t8u9wdpC5DAoDvvv5Ihshz1xeILsqe7JB9otu
	 2lCtIY/1OQFAnjFDezG7//xwOyVsStMwvwi+mRvwPEXSYmuwHz4G43kHyZaMGxOLSy
	 e0cfNcexUBi5uLH5w2x3Ek3/hnrkxz6zXjFb/tDV5z5J8a9aSMxdXWfuPw8SQH32nk
	 MVYOzQ50axncaW4ByKPwPUtRMFmJ3ZrD9vfBMvHjaZ4UD/B0WnWV32+amuioAzLR2n
	 v4/6NvdJcE5hQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyQuq-000000003AZ-3j22;
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
Subject: [PATCH v2 08/18] wifi: libertas_tf: drop redundant device reference
Date: Fri,  6 Mar 2026 09:51:34 +0100
Message-ID: <20260306085144.12064-9-johan@kernel.org>
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
X-Rspamd-Queue-Id: 8071B21D787
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
	FREEMAIL_CC(0.00)[kernel.org,toke.dk,chromium.org,dolcini.it,nbd.name,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32606-lists,linux-wireless=lfdr.de];
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
 drivers/net/wireless/marvell/libertas_tf/if_usb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/if_usb.c b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
index f49151c18b79..07b38f2b8f58 100644
--- a/drivers/net/wireless/marvell/libertas_tf/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
@@ -223,7 +223,6 @@ static int if_usb_probe(struct usb_interface *intf,
 	if (!priv)
 		goto dealloc;
 
-	usb_get_dev(udev);
 	usb_set_intfdata(intf, cardp);
 
 	return 0;
@@ -258,7 +257,6 @@ static void if_usb_disconnect(struct usb_interface *intf)
 	kfree(cardp);
 
 	usb_set_intfdata(intf, NULL);
-	usb_put_dev(interface_to_usbdev(intf));
 
 	lbtf_deb_leave(LBTF_DEB_MAIN);
 }
-- 
2.52.0


