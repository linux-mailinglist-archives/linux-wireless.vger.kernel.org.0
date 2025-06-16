Return-Path: <linux-wireless+bounces-24144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C42DDADAD54
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 12:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111F2188B4E5
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 10:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9429DB95;
	Mon, 16 Jun 2025 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b="VRj39n+D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5D29A9C9;
	Mon, 16 Jun 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069605; cv=none; b=AEXgVZ7lRgzqseLqhsqo8L4agn7+JRHC+ECtRYaoPzqZEMKyhYHQNIxutDbmUV5GdWvBvO8wZnym6xwQGYY98+O7ICViJ1Q1p+qiahJD4mvZOtZZqcbZ2OM6MvL+8jyIuP66fSjJU2ZTlpg43HS8wlPR1oE+MZTmxIbUSIZmxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069605; c=relaxed/simple;
	bh=jxcGvGnUAWuJygjBOBSnSKBYI+C7iaAIXa9qMzH/ElA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLQTDcxNOCupUaTVk0yd6S2552IjNb5Kmvgovs41uLyzzgK7uWrXp1Uou9nv+NYeW3qxEPaBsjpNAmVDuW1OGW2GldH6XM/k76bhBYJoR0pjuL3U4BMk41jLRO8BCO1yQsmWoqW/OdMhc/t5pyUGuOMaktGU0bYuticqJQBRdTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b=VRj39n+D; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
DKIM-Signature: v=1; a=rsa-sha256; d=aladdin.ru; s=mail; c=simple/simple;
	t=1750068668; h=from:subject:to:date:message-id;
	bh=jxcGvGnUAWuJygjBOBSnSKBYI+C7iaAIXa9qMzH/ElA=;
	b=VRj39n+Dtqc5BllU0pU9hOjkDl+fPj2osCTzVKPcFAj65+GuTPR9yqWFr9gaelWfas97Xw2EMGh
	CO14+qe2g6WIS3jctg5/H2mzmiKz6ABE8yIfhmwG+D+6GZuqw6rUfff4F3JivvkrNjvXbe4e99ygJ
	WnN7WSQH3AZF0LjHMjyUlPzmXrZOFA9bjaK3s6WO6sOChvAA415RPxVHovP6JjABRCR3hIVsNUwEq
	rbfdGCgzlC73NaeCvI5oS6sBzt+gHTkCQEINdB4w6E2XK5E8wZ8BYQupf4oXklacCKIMM7DsDrZeT
	w2gLf43wLMc7ZDhKmMhOXAIuIFf02h/J27Mw==
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Hin-Tak Leung <hintak.leung@gmail.com>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Larry Finger
	<Larry.Finger@lwfinger.net>, "John W. Linville" <linville@tuxdriver.com>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 2/2] rtl818x: Kill URBs before clearing tx status queue
Date: Mon, 16 Jun 2025 13:10:50 +0300
Message-ID: <20250616101050.6911-3-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616101050.6911-1-d.dulov@aladdin.ru>
References: <20250616101050.6911-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

In rtl8187_stop() move the call of usb_kill_anchored_urbs() before clearing
b_tx_status.queue. This change prevents callbacks from using already freed
skb due to anchor was not killed before freeing such skb.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c1db52b9d27e ("rtl8187: Use usb anchor facilities to manage urbs")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 8fe6fdc32e56..12e2042ee2d0 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1050,10 +1050,10 @@ static void rtl8187_stop(struct ieee80211_hw *dev, bool suspend)
 	rtl818x_iowrite8(priv, &priv->map->CONFIG4, reg | RTL818X_CONFIG4_VCOOFF);
 	rtl818x_iowrite8(priv, &priv->map->EEPROM_CMD, RTL818X_EEPROM_CMD_NORMAL);
 
+	usb_kill_anchored_urbs(&priv->anchored);
 	while ((skb = skb_dequeue(&priv->b_tx_status.queue)))
 		dev_kfree_skb_any(skb);
 
-	usb_kill_anchored_urbs(&priv->anchored);
 	mutex_unlock(&priv->conf_mutex);
 
 	if (!priv->is_rtl8187b)
-- 
2.34.1


