Return-Path: <linux-wireless+bounces-34473-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BvlODAf1Wnr0wcAu9opvQ
	(envelope-from <linux-wireless+bounces-34473-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:13:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC2C3B0BC5
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5572306022B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47903603EC;
	Tue,  7 Apr 2026 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHjgLSeZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F633D503;
	Tue,  7 Apr 2026 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574695; cv=none; b=qDfoutANxyvhHEfd/EpFiY1ic4ZrZJDwemtRIDF5uLqaHJ+lxwDYY/Z/cBvcmOhlR6tLSFyGylWEdOSKDoMLCmyYBEBggTH+WCbebrNILiLO2Gsa9tPGERKMwqReiLvvLcdDyCsaFpCWMcW9kMR/FveLOvTjJLiRH2xrd97x8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574695; c=relaxed/simple;
	bh=9odPQBSmgdpPjUeBiSqpa4Qt2b1+mW4C5Kv8ZsaYDps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5MlEDxewKIYDoUYrK1YOZyYP2y0zBJU+TY0n7UiJKy5nwnMoNSyhqDMIuVwBPat9J+NRpiN6JBQsVfWDmd0KnGPEjGVrgTdXZQ7F0uug+uSobGWjsQ6X+DVNOcChMwkVJD9GHfJ9OaGGkgIZ2yl5KVIbIMVGdkmH9VG0KUcLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHjgLSeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4389CC2BCAF;
	Tue,  7 Apr 2026 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775574695;
	bh=9odPQBSmgdpPjUeBiSqpa4Qt2b1+mW4C5Kv8ZsaYDps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHjgLSeZ/HHP0SYGPxVfnS/CygggZOO4TJk7PV/5DtXyK+8ZrrgCYIlYru8QbDNge
	 Tm50LUXKvBzZ8Up1M5G0yOAzm9jSya9EtOd63lezSlXuuShlsVuFf3ysBYbs2w2r5y
	 B9UoI1fd+57Jy0xJ4ITKSa47Il4C3ulkCRDZcw72PQa+H5ANmz5LhutaY8ZEX9c2qz
	 ConWxYxQquXKt02m7yhmHs9YpB8NFIO4ThqpvlTQuoOdUEUq5TX5De1i1Om055Sirt
	 zOdwcVpx5yhExL3hU9suNBxVuZNfMECZ0ila9sovaKibFtX4CoOvr77fjtTYAST0KC
	 TnRuoLWrvJfyg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA85V-0000000DNJ5-0WFY;
	Tue, 07 Apr 2026 17:11:33 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/3] wifi: libertas: refactor endpoint lookup
Date: Tue,  7 Apr 2026 17:11:10 +0200
Message-ID: <20260407151111.3187826-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407151111.3187826-1-johan@kernel.org>
References: <20260407151111.3187826-1-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34473-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EC2C3B0BC5
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
index 176f2106bab6..4fae0e335136 100644
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
 
@@ -224,25 +223,25 @@ static int if_usb_probe(struct usb_interface *intf,
 	init_usb_anchor(&cardp->rx_submitted);
 	init_usb_anchor(&cardp->tx_submitted);
 
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


