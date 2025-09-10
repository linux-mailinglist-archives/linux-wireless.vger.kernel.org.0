Return-Path: <linux-wireless+bounces-27210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A98B5155D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 13:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DDD3B183F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 11:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7245627B33A;
	Wed, 10 Sep 2025 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P5L8AyPS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F4D2475C8;
	Wed, 10 Sep 2025 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503388; cv=none; b=rNblarXdHRJwoTFWgn7Gfz1iGDF6knZPn/kYe4/UhUsCVaeJM6LI0W1r984mynNoOK8fuLX23AX0X70vkTxX6vPC5z1fdotDBht4wRA66VKkEgTVEGZtIxq7ptAejWOyK3MuV+JQuxdNDMXP7Hg7U9yoBf6US3s29cb65lGnyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503388; c=relaxed/simple;
	bh=ydERXTNz01LiQZLpNd0/q4ldKRYS30TLCZiEIkMe6ls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mOUfr9bAp8in/uragsi+ktr3jWWVV7ZHGgMCqMaK+D6B5AspG1PM1G4KCSxl8D2MNmePFnzR4MdR+ofMToIcd0vUj8bgfddfqCRPMrjrCtjoq/aBgI+n2lxlZVab3oLmEe091aavECLbfiqjFbVExHscSXoW6VrcgVmv3n2Gi1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P5L8AyPS; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nj
	8yDEBA3RX1k7rUhldu5sk3bXqY2HQz+wiLtVEiuHg=; b=P5L8AyPSpdu8fJkOcP
	UM1gSq/K7K2ypSkCKtENomk1FS3voTbvyygUtLslJqracck7BR6v42YnGqLxWKXQ
	4XUyf75TOn2p49FcBANRnBP3uAlcm6t5QUTIRbvjIcTSw1SoIaI+3v3CB4nXnxta
	rG+vdECSBgpGu//0e3Jik8nPg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnn3SCX8FohY75AA--.45873S2;
	Wed, 10 Sep 2025 19:22:43 +0800 (CST)
From: James Guan <guan_yufei@163.com>
To: johannes@sipsolutions.net
Cc: kuba@kernel.org,
	shaw.leon@gmail.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Guan <guan_yufei@163.com>
Subject: [PATCH] virt_wifi: Fix page fault on connect
Date: Wed, 10 Sep 2025 19:19:29 +0800
Message-Id: <20250910111929.137049-1-guan_yufei@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnn3SCX8FohY75AA--.45873S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar13Ary8Cr13ZrW3KFyrtFb_yoW8Xr4fp3
	yIg3yI9w45Wr4qk3yDAF1xuFykZa93JF929r1UZ3s8CFy8WFyFkr4kZFyayw1UArWkXF1S
	vr40qr47JasYgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi0D7xUUUUU=
X-CM-SenderInfo: xjxd0s51xivxi6rwjhhfrp/1tbiUQbES2jBUVGvRQABsa

This patch prevents page fault in __cfg80211_connect_result()[1]
when connecting a virt_wifi device, while ensuring that virt_wifi
can connect properly.

Note: After applying this patch, NetworkManager should be configured
to use iwd as the Wi-Fi backend. Otherwise, NetworkManager may
quickly disconnect from the virtio_wifi device after connect for
unknown reasons.

[1] https://lore.kernel.org/linux-wireless/20250909063213.1055024-1-guan_yufei@163.com/

Closes: https://lore.kernel.org/linux-wireless/20250909063213.1055024-1-guan_yufei@163.com/
Signed-off-by: James Guan <guan_yufei@163.com>
---
 drivers/net/wireless/virtual/virt_wifi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 1fffeff2190c..4eae89376feb 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -277,7 +277,9 @@ static void virt_wifi_connect_complete(struct work_struct *work)
 		priv->is_connected = true;
 
 	/* Schedules an event that acquires the rtnl lock. */
-	cfg80211_connect_result(priv->upperdev, requested_bss, NULL, 0, NULL, 0,
+	cfg80211_connect_result(priv->upperdev,
+				priv->is_connected ? fake_router_bssid : NULL,
+				NULL, 0, NULL, 0,
 				status, GFP_KERNEL);
 	netif_carrier_on(priv->upperdev);
 }
-- 
2.25.1


