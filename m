Return-Path: <linux-wireless+bounces-35698-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ/hOg4U82llxAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35698-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 10:34:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9104049F482
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 10:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99FB93024A58
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF1D3FE375;
	Thu, 30 Apr 2026 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J36Uxyl5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D13FD15E;
	Thu, 30 Apr 2026 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538034; cv=none; b=t2dCx0i/wHdbAbN0IYlswzawryAIharV7x36jmP9snyO52BrLV9qYo33NzYVHgEluepmfRzAVwwHNC8TkSHDsKMGy/2/KkQ7AkfyhjcGNwCr7iRJGcTOEzPCLMQKNoPUQ2HGR7Hb+wLIplPrDWwP/u/GNuTd8hF2evXohzebRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538034; c=relaxed/simple;
	bh=w4MvbuUnVFxrRLrqGcz+OIFkZ2X2qfkCXwh910utgqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDbLHvXqo0P2Z+t50H0+9U4CCV0OwO1dOZlFKppFFC+XNApBOQEMQMKAhlKtz1EAmnVB7IRxG54cU36gMT/5qTipoRM/hdBtvri1KYo+JC/oQ1VRS/0cWzVpXhewYYLuMPc7qg7Y2747FTMr6jbwJVMy7JUTiA9paU/l+SL5rTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J36Uxyl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D18C4AF09;
	Thu, 30 Apr 2026 08:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777538033;
	bh=w4MvbuUnVFxrRLrqGcz+OIFkZ2X2qfkCXwh910utgqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J36Uxyl51qV1TMtO70TlIuevJnP9WfqcH1nq4Id7hz8F22pgNl7X2vSNo0EF/nH0W
	 owqKo+aGWcWhnEEE4GcT0A4IAN6/tgwt2qeyzmtPXuhdWcQ77x5HUGqf/h9AoYXYQF
	 NBwUoTtIFo91TZvnzS7CFqlUBVXCMwWlXDniVAbV80/6nBer0wJLnsAc4aLauha2TF
	 U7iWmD5uKLAjBlQTxCTLAmFtLYVBTxgr2BdxoB8KhBxItd1WgVdyq/MMUWMnPI5PHN
	 ewF2+V+Zg5QFxoKI4vzusP7+05MPFfbtWWV/pLYxw0/HQ9x63MgYV5rwnBvcneeRIh
	 PwVH+uPPf597Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wIMqF-00000000u0A-1lNw;
	Thu, 30 Apr 2026 10:33:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 RESEND 1/5] wifi: mt76: drop redundant device reference
Date: Thu, 30 Apr 2026 10:33:31 +0200
Message-ID: <20260430083335.215239-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430083335.215239-1-johan@kernel.org>
References: <20260430083335.215239-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9104049F482
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35698-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop the redundant device reference to reduce cargo culting, make it
easier to spot drivers where an extra reference is needed, and reduce
the risk of memory leaks when drivers fail to release it.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index d91feffadda9..bab7b91f14be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -151,7 +151,6 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 		return -ENOMEM;
 
 	dev = container_of(mdev, struct mt7615_dev, mt76);
-	udev = usb_get_dev(udev);
 	usb_reset_device(udev);
 
 	usb_set_intfdata(usb_intf, dev);
@@ -193,7 +192,6 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 error:
 	mt76u_queues_deinit(&dev->mt76);
 	usb_set_intfdata(usb_intf, NULL);
-	usb_put_dev(interface_to_usbdev(usb_intf));
 
 	mt76_free_device(&dev->mt76);
 
@@ -211,7 +209,6 @@ static void mt7663u_disconnect(struct usb_interface *usb_intf)
 	mt7663u_cleanup(dev);
 
 	usb_set_intfdata(usb_intf, NULL);
-	usb_put_dev(interface_to_usbdev(usb_intf));
 
 	mt76_free_device(&dev->mt76);
 }
-- 
2.53.0


