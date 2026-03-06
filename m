Return-Path: <linux-wireless+bounces-32608-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBJINg+WqmmIUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32608-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A6421D74F
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B511830330D8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED08237F752;
	Fri,  6 Mar 2026 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="przSOu5P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623B137997C;
	Fri,  6 Mar 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787136; cv=none; b=CYTp19KuD+iSBgAKO30qWT18D18K/O82IJAruSIo2Gq6zVn//3zdV09tBfBB/f2H9NR7Bxa9aZS73thGdt1zaL1m0prGkzbRyH8QPKRDgjsW/tluhasmTlg0czAD4FHqMEcA49YsrNGbo8HZ9+JRJvU9sooSQ6ym8e8ZyEFDONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787136; c=relaxed/simple;
	bh=WlcQfuVYUTxHWCyVOtszC/tk9vnPA9GDI5j4ICmNw7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTpqEZtPCsq0ozteO22sa2D9t9E2XDOcxJsqaVPu1JZ/7sDGMiong7PruISx/3CjXZKPilARZYbhppeysGL7CxZ2uu3NdK58PrAkk00zFsAsnnwfKpYuHZToQtMZHEwW3vN2Q71G5QnJvPfufPTFdAGnSYLMGPfipjb+u1ReAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=przSOu5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21BCC4AF4D;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772787135;
	bh=WlcQfuVYUTxHWCyVOtszC/tk9vnPA9GDI5j4ICmNw7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=przSOu5PuvIYdQz0nQdNK9TMVRhYHr+Dvb5ogOLy+sx1xd8eJaREzt3IX+4pyhWRs
	 kPSAu2IBi7T+W4TBFr5geNKnz5J6X3UmrM4jAnE3XuBzBv0BMyphJsgaWr5qnxtJSL
	 LcfeVNgfx/67KPtdCSS6VIN7n/YUnClAn6U4C7gxkP+mcb3aaqe0qjFwM/HfTovZql
	 tca8nIPE6V+qh7Y5mDX1RHtMs99E4jTYFymDM4/SYaYFxd6kX3R+uRMfYNNUZj2jIU
	 AO4SBXrqRIGRFH4t51RzpzcIs5bZZjEKYtVPgANgvEDgFEXQaw5uVq4zpp8w6zLjOH
	 ymw/XawocPHxg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyQuq-000000003Ap-48xZ;
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
Subject: [PATCH v2 16/18] wifi: rtl818x: drop redundant device reference
Date: Fri,  6 Mar 2026 09:51:42 +0100
Message-ID: <20260306085144.12064-17-johan@kernel.org>
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
X-Rspamd-Queue-Id: 90A6421D74F
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
	TAGGED_FROM(0.00)[bounces-32608-lists,linux-wireless=lfdr.de];
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


