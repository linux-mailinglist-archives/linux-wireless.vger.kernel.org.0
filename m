Return-Path: <linux-wireless+bounces-34185-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFx4EwZSymnQ7gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34185-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:35:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 357413596EA
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A970300AB0C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BC53BBA1A;
	Mon, 30 Mar 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbZo8aCB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F9D3BADB5;
	Mon, 30 Mar 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866754; cv=none; b=V6Z6mqGQUst6NU1WZvjmbkCxS0QBQVpKuJR7EcgGNLA7lEYC50IbXoWdm2asl+pVjMi2byYcAMPJYlpHLdsSXawLWrdKqxbpggAztAHR+v8Jz1xHaTfKiDIM8wzRQN10WPqkjLP2p7JcqJmaPZ+1yczFb2FFEcLh2ye9hKPCLeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866754; c=relaxed/simple;
	bh=coDTQYP0Z/JaaWswXeJk0wjnvXuhHeY1Xb+yc2nekAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVGRLcZHzr7lNPnemxaRonP22vklyghPy+yeYcOq1gPK9VUDM3I8UO+UUzGPVwwx18K/jJgJ2y0J1bIoAYPDb8mZ7JvPCaZtZ9A8VbkIkw33XVWtIXqTHJDCtcLF+PYBhlaWQFgy8ZdZ1JM2uo6ktkVwwRhmqiGWmbnf/IdQ580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbZo8aCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AACAC2BC9E;
	Mon, 30 Mar 2026 10:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774866754;
	bh=coDTQYP0Z/JaaWswXeJk0wjnvXuhHeY1Xb+yc2nekAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbZo8aCBse+ZPLdPBgxoIkNzO4Yv7BF2RpoAqAf9bh5YkLbuNEdPvYpS7zo5L4mOm
	 Zp5poFLUQNda1UJ9MJ+99iHlIWmW0UWkNfujIR1riciZ9CQC0heC3VAw1tUqbUKwdH
	 mQhCQ2hXk5gaXbx5LxitUqu8o70FusJFMdYT9i5b3kFH0V1PbeVafXaXiTegRS1Fuq
	 MDHjMUBJ5PFZbH2oHFJNDxTzXLRmvMkVBBU+E9uqPThLUE7ffNZ4NxD4pteYntBDSf
	 hlYqhQnHzLmmlk/d5VLwFyZZapUiYIJeNu8SJUmbXJXWdYOQqwrSR3HA/C0vsO1goD
	 B3VYfaKIA3p4Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79v6-000000070xA-0UTh;
	Mon, 30 Mar 2026 12:32:32 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] wifi: libertas: refactor endpoint lookup
Date: Mon, 30 Mar 2026 12:32:06 +0200
Message-ID: <20260330103207.1671926-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330103207.1671926-1-johan@kernel.org>
References: <20260330103207.1671926-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34185-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 357413596EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the common USB helpers for looking up bulk and interrupt endpoints
(and determining max packet size) instead of open coding.

Note that the driver has an implicit max packet size check which is
kept.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 .../net/wireless/marvell/libertas/if_usb.c    | 33 +++++++++----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 05fcf9cc28fa..c880e54201c2 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -193,13 +193,12 @@ static void if_usb_reset_olpc_card(struct lbs_private *priv)
 static int if_usb_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	struct usb_device *udev;
 	struct usb_host_interface *iface_desc;
-	struct usb_endpoint_descriptor *endpoint;
 	struct lbs_private *priv;
 	struct if_usb_card *cardp;
 	int r = -ENOMEM;
-	int i;
 
 	udev = interface_to_usbdev(intf);
 
@@ -221,25 +220,25 @@ static int if_usb_probe(struct usb_interface *intf,
 		     udev->descriptor.bDeviceSubClass,
 		     udev->descriptor.bDeviceProtocol);
 
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
-		endpoint = &iface_desc->endpoint[i].desc;
-		if (usb_endpoint_is_bulk_in(endpoint)) {
-			cardp->ep_in_size = le16_to_cpu(endpoint->wMaxPacketSize);
-			cardp->ep_in = usb_endpoint_num(endpoint);
+	if (usb_find_common_endpoints_reverse(iface_desc, &ep_in, &ep_out, NULL, NULL)) {
+		lbs_deb_usbd(&udev->dev, "Endpoints not found\n");
+		goto dealloc;
+	}
 
-			lbs_deb_usbd(&udev->dev, "in_endpoint = %d\n", cardp->ep_in);
-			lbs_deb_usbd(&udev->dev, "Bulk in size is %d\n", cardp->ep_in_size);
+	cardp->ep_in_size = usb_endpoint_maxp(ep_in);
+	cardp->ep_in = usb_endpoint_num(ep_in);
 
-		} else if (usb_endpoint_is_bulk_out(endpoint)) {
-			cardp->ep_out_size = le16_to_cpu(endpoint->wMaxPacketSize);
-			cardp->ep_out = usb_endpoint_num(endpoint);
+	lbs_deb_usbd(&udev->dev, "in_endpoint = %d\n", cardp->ep_in);
+	lbs_deb_usbd(&udev->dev, "Bulk in size is %d\n", cardp->ep_in_size);
+
+	cardp->ep_out_size = usb_endpoint_maxp(ep_out);
+	cardp->ep_out = usb_endpoint_num(ep_out);
+
+	lbs_deb_usbd(&udev->dev, "out_endpoint = %d\n", cardp->ep_out);
+	lbs_deb_usbd(&udev->dev, "Bulk out size is %d\n", cardp->ep_out_size);
 
-			lbs_deb_usbd(&udev->dev, "out_endpoint = %d\n", cardp->ep_out);
-			lbs_deb_usbd(&udev->dev, "Bulk out size is %d\n", cardp->ep_out_size);
-		}
-	}
 	if (!cardp->ep_out_size || !cardp->ep_in_size) {
-		lbs_deb_usbd(&udev->dev, "Endpoints not found\n");
+		lbs_deb_usbd(&udev->dev, "Endpoints not valid\n");
 		goto dealloc;
 	}
 	if (!(cardp->rx_urb = usb_alloc_urb(0, GFP_KERNEL))) {
-- 
2.52.0


