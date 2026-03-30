Return-Path: <linux-wireless+bounces-34184-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NlLAAZSymnq7gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34184-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:35:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 983D13596E3
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AA483002B25
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 10:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F873BBA19;
	Mon, 30 Mar 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSbcEeXH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E462FFFB5;
	Mon, 30 Mar 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866754; cv=none; b=EaCXSUeqKDcAlwog2BmvBzdA5DIu/dxLRKsZBzkJKeflGRjm+hCJHh07sRY49Ci8XT1S9fIDfPWHyAb0frqZLFf+dgruFKD+2AaeuVeDjNz2sxBM6kwpdze96Ms8GD1ZwSPAPIHT3QIll0qtL8Xvt9shTHAycb3s8Fd9hT5QiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866754; c=relaxed/simple;
	bh=du9Hh4E2pPm0a3BhcAvyXy9zMrIAlKjJzHQCMlxwU1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFKT/It5FUHdJRtbydqyt3cnLtWTqtUrpS9uhwIULhj/ePxs8qmEhELNxhnTUquvCA9+6Ae70QVVpCj9JIXbJF9IOvczpWzc1ung+McqSMD8zIJaaUEWCHrxzQklW7k6jYG+2cMccHNgOvdGJ64jHz18wwPd1lR2yyY6tVVaDjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSbcEeXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B05C2BCB2;
	Mon, 30 Mar 2026 10:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774866754;
	bh=du9Hh4E2pPm0a3BhcAvyXy9zMrIAlKjJzHQCMlxwU1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSbcEeXHSuIil/TkuY0gyBEMgwr5NOu72CIEfGAy8aMxZn6VtnasAsSJHvS4HxL57
	 8ewbNX5dye+rXikkWNAqO1ysIW5oERxJaZ8ZoQ9EIWraIuOy/dbX8fbf2Bp944bYfx
	 7FLs0Ucy2K1UqzN9SKzB+YCUGp1Hut22GNr1PIn93LOYfCBpqCR/fc5xPs0XUe80JM
	 VCllWbD3SY7wpPKPaezN7s2Ai4rHsvbdCcy/l37AHJ3rwh7emIjzM+4DrNM07yw368
	 VV2WkmR6BscyKhU+Qu4WK+MZMf5LUc7VmZYBN9wXzjsewJBKzum1iP3wi8/a1Gkuvp
	 1AwW9Q2k/cz+A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79v6-000000070x8-0RHW;
	Mon, 30 Mar 2026 12:32:32 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/3] wifi: at76c50x: refactor endpoint lookup
Date: Mon, 30 Mar 2026 12:32:05 +0200
Message-ID: <20260330103207.1671926-2-johan@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-34184-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 983D13596E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the common USB helper for looking up bulk and interrupt endpoints
instead of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/wireless/atmel/at76c50x-usb.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 44b04ea3cc8b..32e3e09e7680 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -2226,34 +2226,20 @@ static struct at76_priv *at76_alloc_new_device(struct usb_device *udev)
 static int at76_alloc_urbs(struct at76_priv *priv,
 			   struct usb_interface *interface)
 {
-	struct usb_endpoint_descriptor *endpoint, *ep_in, *ep_out;
-	int i;
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	int buffer_size;
 	struct usb_host_interface *iface_desc;
+	int ret;
 
 	at76_dbg(DBG_PROC_ENTRY, "%s: ENTER", __func__);
 
 	at76_dbg(DBG_URB, "%s: NumEndpoints %d ", __func__,
 		 interface->cur_altsetting->desc.bNumEndpoints);
 
-	ep_in = NULL;
-	ep_out = NULL;
 	iface_desc = interface->cur_altsetting;
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
-		endpoint = &iface_desc->endpoint[i].desc;
-
-		at76_dbg(DBG_URB, "%s: %d. endpoint: addr 0x%x attr 0x%x",
-			 __func__, i, endpoint->bEndpointAddress,
-			 endpoint->bmAttributes);
-
-		if (!ep_in && usb_endpoint_is_bulk_in(endpoint))
-			ep_in = endpoint;
 
-		if (!ep_out && usb_endpoint_is_bulk_out(endpoint))
-			ep_out = endpoint;
-	}
-
-	if (!ep_in || !ep_out) {
+	ret = usb_find_common_endpoints(iface_desc, &ep_in, &ep_out, NULL, NULL);
+	if (ret) {
 		dev_err(&interface->dev, "bulk endpoints missing\n");
 		return -ENXIO;
 	}
-- 
2.52.0


