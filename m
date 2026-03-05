Return-Path: <linux-wireless+bounces-32515-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IUzMFZkqWmB6gAAu9opvQ
	(envelope-from <linux-wireless+bounces-32515-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:09:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23269210553
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6938C30E9D89
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF838B7C3;
	Thu,  5 Mar 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe/q2087"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AA7385527;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708857; cv=none; b=TnX0KL02rchtz42yv0IZHAX+Qe665lLFkzRHtK5QTRWXg9RtJGl8+TNxWQ+ijr4YwjbUQtFNYhue7/DD6JVkKTmm1nrxX/eJjB82d0ct2gOiKTU7ygOBeLuPKrciLMGscSP/Nc/Ad6lmeNVrL1jjprrRVp0yByK9/rRSuryuVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708857; c=relaxed/simple;
	bh=NAiZqhx2oUYerFceltwHy39/hwOjKejdOi1pvDPT46M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4JcaQUXaOgENhj0EWwok/G4Xm3tOyPwdDlRDiWd1pHYP8zB3IdylzJVZJPwcJFU1Octt7V3+8obCaoDuc1Rg3GP2GFk8OWPqaKq0OTGh7wG06ek7OI6zqPmFTwVd43SwQEVOpdst98Ls0ghs9sKg6KajT74GBTPRqbwSNp1gX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe/q2087; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467A9C2BCB6;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772708857;
	bh=NAiZqhx2oUYerFceltwHy39/hwOjKejdOi1pvDPT46M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pe/q2087e5B7rU0QRAwbxDK+3zIqnfJantwLZ2QUfgwXj4nkTZpBxGrtiqiG4W91L
	 /a4BcxyWZPFnjAiAOHTj9Z+VEfaik1Kiq1n+gIl8XxlOQSUivLSyt0khqgZ7mOhV+D
	 d97OLNh2NjXiGa8egXb348wx7O5TIy9s7iDFP0XrT6TFHc0V47CQ09s9m5dE2Tlq36
	 Uq+bx8tA2QGckQTiv8V5Y1WWUbKHjt6l7+dHBE/eRPXZDIXZ8j0y/8q2Mwoun251ww
	 VVYgCbIjc4ud6XYlAq47Djz46prAL04Ghq2WyH+zqhxZhlMh6N+CGT+In9SgGp+0gy
	 oll9eYxhDAnNg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6YI-000000004d9-2vkv;
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
Subject: [PATCH 12/13] wifi: rtl8xxxu: drop redundant device reference
Date: Thu,  5 Mar 2026 12:07:12 +0100
Message-ID: <20260305110713.17725-13-johan@kernel.org>
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
X-Rspamd-Queue-Id: 23269210553
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32515-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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


