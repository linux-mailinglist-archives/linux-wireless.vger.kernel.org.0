Return-Path: <linux-wireless+bounces-32611-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMAlLoaWqmmIUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32611-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:55:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF821D7FA
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EEB03054BB6
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078237F8BA;
	Fri,  6 Mar 2026 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+l1wrw7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A437B406;
	Fri,  6 Mar 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787136; cv=none; b=LI5nsmuMSGMFEQljEqz5ZpF2hwAmLRnhmvI0izCy2ElpKP9i4xNqOHGltkvb0hyI5TikOWP0vc2rfZKWkt8h65fEy3r20c4uqQLFnomN/YqzRpB6ExzhhOT6MNZiLhm6l9+IGoI0xGQl6qaS61hIcnllSKz7xxz5ssj41XxpexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787136; c=relaxed/simple;
	bh=YBI08jfhYlQX9Gx4zol78geSQz/rAVKtS3Ypl1NPKR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBlg7/ylPPFbatuR/a35UK8PPqdhwFnaqYN3TrJOGj6MAsEgB+/v1SQUantlvFyiMbWpxDKUImK3TWtN+hhQKIW2P6K8et+5g04cA0PxHNE6G8kRekRBGbtiHoOg0GyysF6A+I4iahFKlsG5TVhCU+Bi1SsxlWhuKt3zSzP0KgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+l1wrw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F973C19425;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772787136;
	bh=YBI08jfhYlQX9Gx4zol78geSQz/rAVKtS3Ypl1NPKR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+l1wrw7DmuyZLjDSr1+P62LoEwbSVyDRBPrspuXhrMQ0kOXtNIdWRdkbPb7Ffkvw
	 47p8Mj8Sox1nh9goSbEhBTIQpmhbbHMO+epPtTAq8mYJk+FN5Uf8r+QCerm70ZTsqy
	 SyNue6d9w2d00z6sEA68valC+IKJmyGngtS9mBbpgcPcIwhleCVASD7HTvr3zpRHie
	 C2ih5k3DotP4vNfV/ia7bEjA55asOe+LGMMn6hZg5mjHU/psW8MCtAHykR1krPBJJ6
	 XZkciuRz5kbsmmGiOljHraapz53yWLbw7DslcPIzx17kKn84tD6CgI3ohbfpqLeWKz
	 38YB7yz5saJ9Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyQuq-000000003AL-3Pwh;
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
Subject: [PATCH v2 01/18] wifi: ath6kl: drop redundant device reference
Date: Fri,  6 Mar 2026 09:51:27 +0100
Message-ID: <20260306085144.12064-2-johan@kernel.org>
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
X-Rspamd-Queue-Id: 35DF821D7FA
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
	TAGGED_FROM(0.00)[bounces-32611-lists,linux-wireless=lfdr.de];
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
 drivers/net/wireless/ath/ath6kl/usb.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 852e77e41bde..814faf96f1ff 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -1124,8 +1124,6 @@ static int ath6kl_usb_probe(struct usb_interface *interface,
 	int vendor_id, product_id;
 	int ret = 0;
 
-	usb_get_dev(dev);
-
 	vendor_id = le16_to_cpu(dev->descriptor.idVendor);
 	product_id = le16_to_cpu(dev->descriptor.idProduct);
 
@@ -1143,11 +1141,8 @@ static int ath6kl_usb_probe(struct usb_interface *interface,
 		ath6kl_dbg(ATH6KL_DBG_USB, "USB 1.1 Host\n");
 
 	ar_usb = ath6kl_usb_create(interface);
-
-	if (ar_usb == NULL) {
-		ret = -ENOMEM;
-		goto err_usb_put;
-	}
+	if (ar_usb == NULL)
+		return -ENOMEM;
 
 	ar = ath6kl_core_create(&ar_usb->udev->dev);
 	if (ar == NULL) {
@@ -1176,15 +1171,12 @@ static int ath6kl_usb_probe(struct usb_interface *interface,
 	ath6kl_core_destroy(ar);
 err_usb_destroy:
 	ath6kl_usb_destroy(ar_usb);
-err_usb_put:
-	usb_put_dev(dev);
 
 	return ret;
 }
 
 static void ath6kl_usb_remove(struct usb_interface *interface)
 {
-	usb_put_dev(interface_to_usbdev(interface));
 	ath6kl_usb_device_detached(interface);
 }
 
-- 
2.52.0


