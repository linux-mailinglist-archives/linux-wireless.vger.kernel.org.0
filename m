Return-Path: <linux-wireless+bounces-32610-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPsjIBCWqmmIUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32610-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C86621D756
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E64373037D74
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F037037F8B6;
	Fri,  6 Mar 2026 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlMFBmYt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978F337B413;
	Fri,  6 Mar 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787136; cv=none; b=EgrHDdBe5SwQjuEtvqd7CXQ6ptN/hT8x4L/Mn51BB0qLxJ1JzsC/0L9IHkYGM9pYQeS9MpA5CNmhskTJgEU7ewyQcpCgS7uCwv4qDebZMA59SARK12OSukqo2yP+v1TWloDxE1+J68haTznFLg1KuUghIfbDSBtxU5/yh7IhL98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787136; c=relaxed/simple;
	bh=FN0VJHU1PjM85EHuCcDhs9wmITRbjTHJ5B2iAepNjnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1+4Wgol2fNrlHD/5Y+xfoR2RUMwX56ObbtVC+atWaZ8JLQGtBHpDjN0b7umyYPszlnrP/FUNgPR08ch55TS6DakqKGNb+Dae0N4skqtAjSM05vTFFbWvC+J85BhS1x3IKVxXbqBs8ds+um906Puez7ESUUkYnmPrxOAHQ8FOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlMFBmYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEFDC2BC9E;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772787136;
	bh=FN0VJHU1PjM85EHuCcDhs9wmITRbjTHJ5B2iAepNjnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlMFBmYtZUCIHK48xkIvLAAS8mRvw1pXCfwsq8eWwybG2xRBft35+0wDz+0d9A1U4
	 bFTRzeHAtdmXivQvqaLXGSx1Wx2yonpD5KDb1ps+lnxi2pB41B68X1mkl1KNzQNOhC
	 bzgYqSQNTatS9KyP1lxwW8BtDHerWcHRZe0Vq++t/XqkR5nzvQ1YuBwHKCxV6Kj9im
	 WkIh0dW0mp6K4rRnYEHfXRrNGNS8Z1SmZBPsiEw/7gh2waUSd/id+8HN2JitWRRYt5
	 F57sPNCsjGdKyvydX2VNI/+9G3Gh8Z8tHUjW61xPSg7Jrdduu2Id9XvmGgAwZibYQV
	 ziJACLB/YGXyw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyQuq-000000003AR-3Y1A;
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
Subject: [PATCH v2 04/18] wifi: ath10k: drop redundant device reference
Date: Fri,  6 Mar 2026 09:51:30 +0100
Message-ID: <20260306085144.12064-5-johan@kernel.org>
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
X-Rspamd-Queue-Id: 6C86621D756
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,toke.dk,chromium.org,dolcini.it,nbd.name,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32610-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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
 drivers/net/wireless/ath/ath10k/usb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/ath/ath10k/usb.c
index 6661fff326e0..ad1cf0681b19 100644
--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -1016,7 +1016,6 @@ static int ath10k_usb_probe(struct usb_interface *interface,
 
 	netif_napi_add(ar->napi_dev, &ar->napi, ath10k_usb_napi_poll);
 
-	usb_get_dev(dev);
 	vendor_id = le16_to_cpu(dev->descriptor.idVendor);
 	product_id = le16_to_cpu(dev->descriptor.idProduct);
 
@@ -1055,8 +1054,6 @@ static int ath10k_usb_probe(struct usb_interface *interface,
 err:
 	ath10k_core_destroy(ar);
 
-	usb_put_dev(dev);
-
 	return ret;
 }
 
@@ -1071,7 +1068,6 @@ static void ath10k_usb_remove(struct usb_interface *interface)
 	ath10k_core_unregister(ar_usb->ar);
 	netif_napi_del(&ar_usb->ar->napi);
 	ath10k_usb_destroy(ar_usb->ar);
-	usb_put_dev(interface_to_usbdev(interface));
 	ath10k_core_destroy(ar_usb->ar);
 }
 
-- 
2.52.0


