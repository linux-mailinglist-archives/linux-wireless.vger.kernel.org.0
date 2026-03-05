Return-Path: <linux-wireless+bounces-32512-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHXOEIBkqWmB6gAAu9opvQ
	(envelope-from <linux-wireless+bounces-32512-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:09:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0506B210595
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 295F0305BF4C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90318389473;
	Thu,  5 Mar 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHnc/Fam"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9613845BF;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708857; cv=none; b=cZZ+dHciZL8iwXpLp7x6WgXk2UumqrlnQRoRD9qe3hIgNok/rnd3IXUM7W9PI53hGdT/S6Govw8tRsnaxbys5D/nC5RJPtUfA8kidOt7H9SWaaiwgfQobX3a0xJTGLmMMthBmGUU9eibd3E+nRm590+e89+EjtWtw2ZeGr/3sW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708857; c=relaxed/simple;
	bh=nQgAI+YcSF8G0lQDc1zi/FNWJaXGqRruXZeJTmy1ph0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1gZHK3yyiWwIlhP05cpfKUmceevf9HgWmDYAtWltYRjodNFg5t9pKpzo0bx7LYI8hW4+DMQ+h4gSIfEfIGUE+7h4p6Vo6H+rUNx4Xy7cSO5KEuBK2g0cLzwOXvkhHpmwJsHHze8TIkWC/YtkMdgFhxLTBBdbGbINrFaOepWnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHnc/Fam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C10C2BCB8;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772708857;
	bh=nQgAI+YcSF8G0lQDc1zi/FNWJaXGqRruXZeJTmy1ph0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHnc/FamkijRkDGZPVujIRbiwELwJS++pH3OLi4vA6Xlioaqh8tH5H57qH/mBzKTs
	 vONiDJqlpOquNKhLjgkXxnxyBiBo2LbPSpOCmcoMak4XVTTdyju8c40wCm8/I48k03
	 gncKKlPYDMjDtoED0aHKJg8WNjF86YF/jgEacA1RkqNoImeLvx5b/sLeacuBhcw/bJ
	 +E7205ElOVVHhbBMTedyNuwbAVbRUAyt2SfbtbQ/aL97ows1mM+0hD1RThRYBZS0mU
	 7XyLnKFbp16uKbXcJ1vGVf6TWndud9ZovunDY3dvdpTCTC+1FDagVj28273ZaxTvXg
	 R9jAarPiqNUGw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6YI-000000004dB-2yiG;
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
Subject: [PATCH 13/13] wifi: rtlwifi: usb: drop redundant device reference
Date: Thu,  5 Mar 2026 12:07:13 +0100
Message-ID: <20260305110713.17725-14-johan@kernel.org>
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
X-Rspamd-Queue-Id: 0506B210595
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
	TAGGED_FROM(0.00)[bounces-32512-lists,linux-wireless=lfdr.de];
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
 drivers/net/wireless/realtek/rtlwifi/usb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index d35ed56d6db9..9a64df9eed39 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -986,7 +986,6 @@ int rtl_usb_probe(struct usb_interface *intf,
 	init_completion(&rtlpriv->firmware_loading_complete);
 	SET_IEEE80211_DEV(hw, &intf->dev);
 	udev = interface_to_usbdev(intf);
-	usb_get_dev(udev);
 	usb_priv = rtl_usbpriv(hw);
 	memset(usb_priv, 0, sizeof(*usb_priv));
 	usb_priv->dev.intf = intf;
@@ -1038,7 +1037,6 @@ int rtl_usb_probe(struct usb_interface *intf,
 	rtl_deinit_core(hw);
 error_out2:
 	_rtl_usb_io_handler_release(hw);
-	usb_put_dev(udev);
 	kfree(rtlpriv->usb_data);
 	ieee80211_free_hw(hw);
 	return -ENODEV;
@@ -1050,7 +1048,6 @@ void rtl_usb_disconnect(struct usb_interface *intf)
 	struct ieee80211_hw *hw = usb_get_intfdata(intf);
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_mac *rtlmac = rtl_mac(rtl_priv(hw));
-	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
 
 	if (unlikely(!rtlpriv))
 		return;
@@ -1072,7 +1069,6 @@ void rtl_usb_disconnect(struct usb_interface *intf)
 	kfree(rtlpriv->usb_data);
 	rtlpriv->cfg->ops->deinit_sw_vars(hw);
 	_rtl_usb_io_handler_release(hw);
-	usb_put_dev(rtlusb->udev);
 	usb_set_intfdata(intf, NULL);
 	ieee80211_free_hw(hw);
 }
-- 
2.52.0


