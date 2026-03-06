Return-Path: <linux-wireless+bounces-32595-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMdyMsWVqmkkUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32595-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:52:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D80421D5CC
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F3773022059
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20BD33065C;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3HfQI9X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37B221540;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787135; cv=none; b=hyGqwSOFeAio0faeoiYKRho462OSsygrOtebPxi8uHcf620kbSWF5HLEewh3Umwfcj7+GFpvo6gxrJaWhC9MC2SNs+hQzb0uKBKDTbDrNYi/uTCmuwir13fG5wBGNseLslkfh6/cZJ1KwiyHrL62WZIhrxAlqXvtkkA1OtwUFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787135; c=relaxed/simple;
	bh=CldXdF4K1Mffbg5Hf+ZzFSSzMyz/wwpC433QQhvr9WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBSRaF/RKMmlRq641KAhUHHIOSK3H44hwcvqcD1hWATuZoi8DXJNQDwNU6+tY1A5PvpJGFiGO7bl713UeSsun5C2BgUWmJL6DWVjibE1qvPbRSM07til77fZDcs67f4Dkb1+GvxyNItKwiqeLDE7Pkig6jzX3cOjKAG3HZwR/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3HfQI9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BF9C19422;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772787135;
	bh=CldXdF4K1Mffbg5Hf+ZzFSSzMyz/wwpC433QQhvr9WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3HfQI9XxCSFGw0VakBBYXmokEmmYt1/tlAQo6BgUVIer8N+lRwolY3OaUyj1SWaJ
	 HwzjTy/vLa9Ed0giVwm2v90wLgjqEEDKLhTSm5bFh7Po3pU4FQ+e++GagItyxlV4k6
	 SgMXplOVAn4cdFI4Cf7dEIosB3jC1dB5h13hMRah+5/Qx39Yz5lQgKFKmx2YAvBima
	 ICpPzBE0NaM9K6fEuydKpNliNgikNE+1QvDLxAMvYp8yFXPXdQ+5DfEKY+41m0wivM
	 wgMVQjvdVOcIMBFYLMcKU7CMxuoWbl+0zbWRUEQPqpSm2xZc/MTibJF+VAzrvzl30Y
	 Rs77w1Zhsm0Yw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyQuq-000000003AP-3VK8;
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
Subject: [PATCH v2 03/18] wifi: ath9k: drop redundant device reference
Date: Fri,  6 Mar 2026 09:51:29 +0100
Message-ID: <20260306085144.12064-4-johan@kernel.org>
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
X-Rspamd-Queue-Id: 6D80421D5CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,toke.dk,chromium.org,dolcini.it,nbd.name,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32595-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
 drivers/net/wireless/ath/ath9k/hif_usb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 8533b88974b2..821909b81ea9 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1382,8 +1382,6 @@ static int ath9k_hif_usb_probe(struct usb_interface *interface,
 		goto err_alloc;
 	}
 
-	usb_get_dev(udev);
-
 	hif_dev->udev = udev;
 	hif_dev->interface = interface;
 	hif_dev->usb_device_id = id;
@@ -1403,7 +1401,6 @@ static int ath9k_hif_usb_probe(struct usb_interface *interface,
 err_fw_req:
 	usb_set_intfdata(interface, NULL);
 	kfree(hif_dev);
-	usb_put_dev(udev);
 err_alloc:
 	return ret;
 }
@@ -1451,7 +1448,6 @@ static void ath9k_hif_usb_disconnect(struct usb_interface *interface)
 
 	kfree(hif_dev);
 	dev_info(&udev->dev, "ath9k_htc: USB layer deinitialized\n");
-	usb_put_dev(udev);
 }
 
 #ifdef CONFIG_PM
-- 
2.52.0


