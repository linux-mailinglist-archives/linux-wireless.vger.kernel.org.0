Return-Path: <linux-wireless+bounces-32511-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Jm0IX9kqWmB6gAAu9opvQ
	(envelope-from <linux-wireless+bounces-32511-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:09:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0225C21058E
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06EB1305BBA6
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7DF389116;
	Thu,  5 Mar 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIfmehlr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF03845B3;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708857; cv=none; b=FH1vr+zmYCr34SoDoy+o+sC1nUMiqAZgugZ3JH/O1YqjuGMod44avEUi+zOeC0kfqfF3NeM4W0OQm+Dhd0rPgFOWIUsBWJFiv+2VuPIDk3MEw6MrIG5ZfDodlsP1+lgsTIl9B+trnx4T0YFSakpvLvjXpnMya/yl3lt7szXrb+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708857; c=relaxed/simple;
	bh=ey/SDZWYDfwEzvacZ4/iPoJH/it7xuEF479WqUIu2to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN5Qa2eRXFB7Ec5jbTWoHGWEAlTy+B67q4gyVpyycBKn8Yn83ygoqOwqO/v5AC+ZzW3HlVJXi7QYQUuhGe5b9/Jq5NMYMWCwznn+ziByhSKLB81KQl48xAEY7nbtKNorBBxVagmUdAkh1jypnQ6XYrGoniFj2cwVP8PD3s1KPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIfmehlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D210C2BCC4;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772708857;
	bh=ey/SDZWYDfwEzvacZ4/iPoJH/it7xuEF479WqUIu2to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIfmehlrVWKqFw9Xjo8WCMjE5eu68ea5oECuiklfGAkr3b00E68KEYj23uvil2ksx
	 HOdYYHgiazv8aYPoyByFklhnPqZsnbkNLQ2L3jCxU9aAzbDMD3AaRQPUU9m0jfleHa
	 YbFSW3LGE1DfEcy0AKvkReICymCTYMbHecafpUIlEBGT5pKlRvjxRxIHL54oe5u+W8
	 EiTogIUtjMlLKCom1ESpp4whYdMS70PKpJlQH5boLDeCjvU3wYuLAE0rSL5ia3IX/G
	 BX5jTmxG44DUpYvakj22qeJKGFhmH+zevUTplD7RBykgV0H8gL3qQ/uwP+Bu/awKkv
	 tmCeYyAFjIv5Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6YI-000000004d5-2q0d;
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
Subject: [PATCH 10/13] wifi: rt2x00: drop redundant device reference
Date: Thu,  5 Mar 2026 12:07:10 +0100
Message-ID: <20260305110713.17725-11-johan@kernel.org>
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
X-Rspamd-Queue-Id: 0225C21058E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32511-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
index 54599cad78f9..83d00b6baf64 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
@@ -802,14 +802,12 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
 	struct rt2x00_dev *rt2x00dev;
 	int retval;
 
-	usb_dev = usb_get_dev(usb_dev);
 	usb_reset_device(usb_dev);
 
 	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
 	if (!hw) {
 		rt2x00_probe_err("Failed to allocate hardware\n");
-		retval = -ENOMEM;
-		goto exit_put_device;
+		return -ENOMEM;
 	}
 
 	usb_set_intfdata(usb_intf, hw);
@@ -851,10 +849,6 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
 
 exit_free_device:
 	ieee80211_free_hw(hw);
-
-exit_put_device:
-	usb_put_dev(usb_dev);
-
 	usb_set_intfdata(usb_intf, NULL);
 
 	return retval;
@@ -873,11 +867,7 @@ void rt2x00usb_disconnect(struct usb_interface *usb_intf)
 	rt2x00usb_free_reg(rt2x00dev);
 	ieee80211_free_hw(hw);
 
-	/*
-	 * Free the USB device data.
-	 */
 	usb_set_intfdata(usb_intf, NULL);
-	usb_put_dev(interface_to_usbdev(usb_intf));
 }
 EXPORT_SYMBOL_GPL(rt2x00usb_disconnect);
 
-- 
2.52.0


