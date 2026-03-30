Return-Path: <linux-wireless+bounces-34182-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JS8IQhSymnq7gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34182-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:35:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983F3596F1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B7B530101E6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 10:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44FD3BBA0D;
	Mon, 30 Mar 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRWTtyk9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE73B4EB5;
	Mon, 30 Mar 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866754; cv=none; b=hn1GvGn5ibakmTMs2lc63suys0Iz+tW1dOpX1Ruf4WHPCX/L+kw9cZo4Y87oHc43WvNv3ElDBGb5SKukDssBxeRPsKk/4OARV+BD/BP/ELqN9aadRf9yYqbEkZJhBE5u81ZzNH860YFEmCtRaQy04R0AzNOIePsLAa2DltjOiQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866754; c=relaxed/simple;
	bh=PXNBDL1AbhlnXoC5WjArcc4E1Rh8rLvJpXZaOjjIcus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTvs4lr7WIdqnbxtCOh+FKuElA63926RB2VtyJQWnXtngZXJ99bdxrKWCAROizal5JAfKL9TtcQUCVA3Wvp+XggopcB5F80sdM+wECvzWn/YtHyA8xrwmSL6gN68P3uPQMejVqbCKbXgOGdBlHEo1ZuNXwdaLZFpvNunN5dhWtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRWTtyk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D178C4AF09;
	Mon, 30 Mar 2026 10:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774866754;
	bh=PXNBDL1AbhlnXoC5WjArcc4E1Rh8rLvJpXZaOjjIcus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRWTtyk9OZ+hjpdvp1PK7Pevtq1C+VyR21b5bg/MqyhcGZr7rUnlQBomy7AQuAwru
	 +hvmaIuP4bsuHLgpFqzPaG3JK8mr7WflTPvCCi5uDPSPFjOomyItByPCMeFFH4590n
	 usivRvUcm1ipyZcMBHDaFR9HBlIurmOBbfWf8N1SXEuPVFw/7dQ+3RGTzidIKZ7E4P
	 rmBj87GwtbS4YAuI9GEAA5qHnunQLvhJ6JIkUUBnIxUEE1dSx0Fp+5THcQbUwM9Zu5
	 lGCPaqtbLvTuuDgCrNUx5YxIR8+hPwyEGZYZsQyyyai4u0Cn176QrXvnFmnpisXfxm
	 LlYZuMUJmjtqA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79v6-000000070xC-0Xej;
	Mon, 30 Mar 2026 12:32:32 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] wifi: libertas_tf: refactor endpoint lookup
Date: Mon, 30 Mar 2026 12:32:07 +0200
Message-ID: <20260330103207.1671926-4-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34182-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2983F3596F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the common USB helpers for looking up bulk and interrupt endpoints
(and determining max packet size) instead of open coding.

Note that the driver has an implicit max packet size check which is
kept.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 .../net/wireless/marvell/libertas_tf/if_usb.c | 46 +++++++++----------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/if_usb.c b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
index 07b38f2b8f58..b85c6d783bf7 100644
--- a/drivers/net/wireless/marvell/libertas_tf/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
@@ -144,12 +144,12 @@ static const struct lbtf_ops if_usb_ops = {
 static int if_usb_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	struct usb_device *udev;
 	struct usb_host_interface *iface_desc;
-	struct usb_endpoint_descriptor *endpoint;
 	struct lbtf_private *priv;
 	struct if_usb_card *cardp;
-	int i;
+	int ret;
 
 	lbtf_deb_enter(LBTF_DEB_USB);
 	udev = interface_to_usbdev(intf);
@@ -171,31 +171,27 @@ static int if_usb_probe(struct usb_interface *intf,
 		     udev->descriptor.bDeviceSubClass,
 		     udev->descriptor.bDeviceProtocol);
 
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
-		endpoint = &iface_desc->endpoint[i].desc;
-		if (usb_endpoint_is_bulk_in(endpoint)) {
-			cardp->ep_in_size =
-				le16_to_cpu(endpoint->wMaxPacketSize);
-			cardp->ep_in = usb_endpoint_num(endpoint);
-
-			lbtf_deb_usbd(&udev->dev, "in_endpoint = %d\n",
-				cardp->ep_in);
-			lbtf_deb_usbd(&udev->dev, "Bulk in size is %d\n",
-				cardp->ep_in_size);
-		} else if (usb_endpoint_is_bulk_out(endpoint)) {
-			cardp->ep_out_size =
-				le16_to_cpu(endpoint->wMaxPacketSize);
-			cardp->ep_out = usb_endpoint_num(endpoint);
-
-			lbtf_deb_usbd(&udev->dev, "out_endpoint = %d\n",
-				cardp->ep_out);
-			lbtf_deb_usbd(&udev->dev, "Bulk out size is %d\n",
-				cardp->ep_out_size);
-		}
+	ret = usb_find_common_endpoints_reverse(iface_desc, &ep_in, &ep_out,
+						NULL, NULL);
+	if (ret) {
+		lbtf_deb_usbd(&udev->dev, "Endpoints not found\n");
+		goto dealloc;
 	}
+
+	cardp->ep_in_size = usb_endpoint_maxp(ep_in);
+	cardp->ep_in = usb_endpoint_num(ep_in);
+
+	lbtf_deb_usbd(&udev->dev, "in_endpoint = %d\n", cardp->ep_in);
+	lbtf_deb_usbd(&udev->dev, "Bulk in size is %d\n", cardp->ep_in_size);
+
+	cardp->ep_out_size = usb_endpoint_maxp(ep_out);
+	cardp->ep_out = usb_endpoint_num(ep_out);
+
+	lbtf_deb_usbd(&udev->dev, "out_endpoint = %d\n", cardp->ep_out);
+	lbtf_deb_usbd(&udev->dev, "Bulk out size is %d\n", cardp->ep_out_size);
+
 	if (!cardp->ep_out_size || !cardp->ep_in_size) {
-		lbtf_deb_usbd(&udev->dev, "Endpoints not found\n");
-		/* Endpoints not found */
+		lbtf_deb_usbd(&udev->dev, "Endpoints not valid\n");
 		goto dealloc;
 	}
 
-- 
2.52.0


