Return-Path: <linux-wireless+bounces-32514-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPzRCxNkqWmB6gAAu9opvQ
	(envelope-from <linux-wireless+bounces-32514-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:08:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4AB21050C
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E273301CC4C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9266C38B7AC;
	Thu,  5 Mar 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8JYtG/3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B64385536;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708857; cv=none; b=IcnFcTuB6kzEtarbQgs+cd9OWui0yuXpytCmUlIkemFO1LkcfuqZEfHkPkPjJ8vxQVgNkdTX3LX4uyLrvzc6wVF98cdGk/OwnUR2TxFMzqDamAsEvwsPRnqLjRGEe6HZEsx6jOPE+54LeDEPL/xJyZPgKz2h9pYf6E6C97n9d3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708857; c=relaxed/simple;
	bh=xCEaqUoallq2NdTzWqQElwbwYb5T0f2rYJwsXpRUAaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pzie1489vKaXU24VwkLS8rXLfjzx+10sCZOEYfNRZaSOU9Xjtd2ifEZLpVAKawAhhCXPoK3u1s1ykCRIQayd8PE8jELn9LihEyhZHC34XWhohVxZRiGBKVvzBnQQOMyj+8HdTlTmAUnQOVSgfPLwi4EEhvTpMmrZPASnPUU7CrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8JYtG/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579F5C2BCFC;
	Thu,  5 Mar 2026 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772708857;
	bh=xCEaqUoallq2NdTzWqQElwbwYb5T0f2rYJwsXpRUAaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8JYtG/3YpWHw0jDUl4/6GqoMiuvpz3yVJSaw4Lald1bL1wQ0s2KWUIcSN39tiw2D
	 /RReIH224fkVgrwRmHc0e81/z6+hHcuRV36ieOfdavAcivtN2id2ZjjgXRH+yuVqvy
	 FK/n1kmswq0XBIXAbnRY/WNWNSuUj4f2DRvSf9Gkmq4Li6xOvmyvTqHeoW+moySs+F
	 kxVW31VkKgLoEiJFciRciYFpYXX4YhtSLO/DAII8zS84LIG5u3cqlybu9z5Gplyacx
	 /Ddt44FBGToBahGfvuaRSonFNCmRPiFlJpUjEDLf52plGCzN9ppBoJyBj3yiqlDW5/
	 9LSAB6MIdq1oQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6YI-000000004cz-2hFL;
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
Subject: [PATCH 07/13] wifi: mt76x2u: drop redundant device reference
Date: Thu,  5 Mar 2026 12:07:07 +0100
Message-ID: <20260305110713.17725-8-johan@kernel.org>
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
X-Rspamd-Queue-Id: 3C4AB21050C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32514-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
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
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 01cb3b2830f3..8af360bca643 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -57,7 +57,6 @@ static int mt76x2u_probe(struct usb_interface *intf,
 
 	dev = container_of(mdev, struct mt76x02_dev, mt76);
 
-	udev = usb_get_dev(udev);
 	usb_reset_device(udev);
 
 	usb_set_intfdata(intf, dev);
@@ -84,14 +83,12 @@ static int mt76x2u_probe(struct usb_interface *intf,
 	mt76u_queues_deinit(&dev->mt76);
 	mt76_free_device(&dev->mt76);
 	usb_set_intfdata(intf, NULL);
-	usb_put_dev(udev);
 
 	return err;
 }
 
 static void mt76x2u_disconnect(struct usb_interface *intf)
 {
-	struct usb_device *udev = interface_to_usbdev(intf);
 	struct mt76x02_dev *dev = usb_get_intfdata(intf);
 	struct ieee80211_hw *hw = mt76_hw(dev);
 
@@ -100,7 +97,6 @@ static void mt76x2u_disconnect(struct usb_interface *intf)
 	mt76x2u_cleanup(dev);
 	mt76_free_device(&dev->mt76);
 	usb_set_intfdata(intf, NULL);
-	usb_put_dev(udev);
 }
 
 static int __maybe_unused mt76x2u_suspend(struct usb_interface *intf,
-- 
2.52.0


