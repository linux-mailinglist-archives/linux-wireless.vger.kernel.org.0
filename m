Return-Path: <linux-wireless+bounces-7648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6713E8C590B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 17:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062751F221D3
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8889217EBB0;
	Tue, 14 May 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U/rj+yU8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3517EB87;
	Tue, 14 May 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701891; cv=none; b=TSZf5eJ0XhR7EAerVQPrADoDBuY7RyLggn5oUWBkQ1OWl9lDeJmwf8l5/QSl/otDvvh1a0ZKZKpTCghhCiUpmbnf/W+7PAbCOHcoSpMuiyl3yNiI8lQPlzp2J3CI7SKjHsZLDSpbCVI6NEKhi+aJV8stYevnnxCMxU+st9QkHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701891; c=relaxed/simple;
	bh=0/ADeysUK6zcQEDcTdDJA5QqOa1mNX4iXTZev0jcyPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R/XjVn3n5XneGp/n3+pisVoCePYE0bF/yuuSCXnBpndAmnI6VJefstxd/+WGFmpSrgzy6JqGIBWWY2mCMW8JnzF7YZBnapV+sNK+LgU8SvskP0l3HH92LBlcObWAkQlMeIr/nWrT2UPPuYwR/HfzPowuOySzqwoSK9x6g6xPgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U/rj+yU8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1E911C000C;
	Tue, 14 May 2024 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715701887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UL/FZYt1ZDeYd7vr1TRXKJow8zuiDeZ1OlrlaoQyJrs=;
	b=U/rj+yU8YuImxDaISYiRJTPiohBEl3aXeSkyBRFP6cjbnxNTcp95/QomWIl79B1fbLLCDG
	sf6aWaEk0Mz+eU/5Fo263dbSAkFpcEZuzMuC73MVsHNFPWTqF9tGM/Bjc4WScsqJp+d25Z
	xeVofldBbcX86hmFSYCg5Eugy2T8RvmL9IzLHMQelJ0fwOU56Ca8lwRkzyl1qW83KX540Z
	yen7dDRXZ7UMgE4JULJG8Fm5nGhHmKydica1rjDGkwkmE5/AeSIC8Fn+gMzngXks/7Ynhu
	zsRxp3JWLY44Mlxv7gzWzJpXN+gw+M7R9KmCNKd7cGQKIW0+coLconwECxDIEQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Tue, 14 May 2024 17:51:19 +0200
Subject: [PATCH v2 1/6] wifi: wilc1000: set net device registration as last
 step during interface creation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240514-mac_addr_at_probe-v2-1-afef09f1cd10@bootlin.com>
References: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
In-Reply-To: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Heiko Thiery <Heiko.Thiery@kontron.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

net device registration is currently done in wilc_netdev_ifc_init but
other initialization operations are still done after this registration.
Since net device is assumed to be usable right after registration, it
should be the very last step of initialization.

Move netdev registration at the very end of wilc_netdev_ifc_init to let
this function completely initialize netdevice before registering it.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 31 ++++++++++++------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 73f56f7b002b..acc9b9a64552 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -965,16 +965,6 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 	vif->priv.wdev.iftype = type;
 	vif->priv.dev = ndev;
 
-	if (rtnl_locked)
-		ret = cfg80211_register_netdevice(ndev);
-	else
-		ret = register_netdev(ndev);
-
-	if (ret) {
-		ret = -EFAULT;
-		goto error;
-	}
-
 	ndev->needs_free_netdev = true;
 	vif->iftype = vif_type;
 	vif->idx = wilc_get_available_idx(wl);
@@ -985,13 +975,24 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 	mutex_unlock(&wl->vif_mutex);
 	synchronize_rcu();
 
-	return vif;
-
-error:
 	if (rtnl_locked)
-		cfg80211_unregister_netdevice(ndev);
+		ret = cfg80211_register_netdevice(ndev);
 	else
-		unregister_netdev(ndev);
+		ret = register_netdev(ndev);
+
+	if (ret) {
+		ret = -EFAULT;
+		goto error_remove_vif;
+	}
+
+	return vif;
+
+error_remove_vif:
+	mutex_lock(&wl->vif_mutex);
+	list_del_rcu(&vif->list);
+	wl->vif_num -= 1;
+	mutex_unlock(&wl->vif_mutex);
+	synchronize_rcu();
 	free_netdev(ndev);
 	return ERR_PTR(ret);
 }

-- 
2.44.0


