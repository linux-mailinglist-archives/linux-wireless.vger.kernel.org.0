Return-Path: <linux-wireless+bounces-32607-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM0BMh2WqmkkUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32607-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8404521D78F
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D8D5305FD84
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033D637C11F;
	Fri,  6 Mar 2026 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atldsAuE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C6374732;
	Fri,  6 Mar 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787136; cv=none; b=o7iRMsXXrrvZ69uEVsU4y2e19bB3FOwe12oKRCjfftgp6I4CKrrI9TWvlllFl2rQKWNfDsgYdn8sYnBfR7C9rd+SFpTf5UnGkvN2jn/2NUjwfTaicWaOvbaphIR9o4k+1eMU6ANHhX/eJk4biZLAUQ/3RjDWMvH4VEzrQNE2JbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787136; c=relaxed/simple;
	bh=NAiZqhx2oUYerFceltwHy39/hwOjKejdOi1pvDPT46M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUWDoCGE1A27WCo9Pw1AQm05EpCego8K74byUjnDADlQTt+1ARfjpubrIbd+r0BhaVUkGDLXcSq1QqKqltX2ihnvmkO9caxrZK5iJNelBZFx92hv00ePhnn4jsLXYuxCNyC2dzr05K5gL2zTZfokTtHJCz04wnNOg6O0/Xg4b+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atldsAuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB94C2BD00;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772787135;
	bh=NAiZqhx2oUYerFceltwHy39/hwOjKejdOi1pvDPT46M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atldsAuEvpPkmPoqtTEpB6yLhgXMGWekk9BzauzOG9Nrra7tdMUU2n0C6WZaVpIO1
	 YEME+i+5mj9ZQ3aYPWHZYGbbLUti2WgpR+GMuLG6pbUYuFuV2jgjbyW9yJKJvcdjbQ
	 W5skiFMy8SPu4aW1kNeASMlenif2NNv+0HnIL3H1wPGwxjDqDpb5MPK4XEHVbIQ66E
	 7y4dgjFPkhnWqUu0SAaaQ496nSu14Jdcx9IIFzfpZRN73FOdhNxWJed4vlesLSZJqI
	 lIm8bOUX8ifBa6HfdmAD/EpF+lH4OnT11pz+zPC9frmFnBIhYKeUQ36ZWdBhCdn/g9
	 1w22iK7Mp7kmw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyQur-000000003Ar-00Av;
	Fri, 06 Mar 2026 09:52:13 +0100
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
Subject: [PATCH v2 17/18] wifi: rtl8xxxu: drop redundant device reference
Date: Fri,  6 Mar 2026 09:51:43 +0100
Message-ID: <20260306085144.12064-18-johan@kernel.org>
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
X-Rspamd-Queue-Id: 8404521D78F
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
	FREEMAIL_CC(0.00)[kernel.org,toke.dk,chromium.org,dolcini.it,nbd.name,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32607-lists,linux-wireless=lfdr.de];
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
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 794187d28caa..f131ca09ae43 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -7698,7 +7698,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	int ret;
 	int untested = 1;
 
-	udev = usb_get_dev(interface_to_usbdev(interface));
+	udev = interface_to_usbdev(interface);
 
 	switch (id->idVendor) {
 	case USB_VENDOR_ID_REALTEK:
@@ -7756,10 +7756,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	}
 
 	hw = ieee80211_alloc_hw(sizeof(struct rtl8xxxu_priv), &rtl8xxxu_ops);
-	if (!hw) {
-		ret = -ENOMEM;
-		goto err_put_dev;
-	}
+	if (!hw)
+		return -ENOMEM;
 
 	priv = hw->priv;
 	priv->hw = hw;
@@ -7901,8 +7899,6 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	mutex_destroy(&priv->h2c_mutex);
 
 	ieee80211_free_hw(hw);
-err_put_dev:
-	usb_put_dev(udev);
 
 	return ret;
 }
@@ -7935,7 +7931,6 @@ static void rtl8xxxu_disconnect(struct usb_interface *interface)
 			 "Device still attached, trying to reset\n");
 		usb_reset_device(priv->udev);
 	}
-	usb_put_dev(priv->udev);
 	ieee80211_free_hw(hw);
 }
 
-- 
2.52.0


