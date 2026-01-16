Return-Path: <linux-wireless+bounces-30867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DFED29810
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77A0B3019C74
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC54831AF2D;
	Fri, 16 Jan 2026 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3yNlEh6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E9314A8A
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525546; cv=none; b=nc6fSyFAmPjiVEJZBuqqsCGtcqwMUaeM7Qn8AJfobdwUIv2md4rqEjqsOsHrZMGpp/EIwb2oVSJN7bNXQCk6rGLF56MktKcANATxUXx0ThZsMqiY7cJN9VngKX1zgo87ig5BXIG7aH8qx3hcHiw8RZBqIOGlmf3TKXK37n9HGDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525546; c=relaxed/simple;
	bh=JZnzZyYJvjFa0LSUbqrGxrB2MD2Wwfj5C3G4vxH/yhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8StKPyjpfDHlpj6O2Y/Ili48GrXMSQpTE48SfqPqLhbj8fGbo7GOLDEOWmZugIUFzY1obzFHgYcw0B4H3pOSXhiE6RAcuARILWLoFKPIh71eyh5UM3QN8fXLf3ukODXtj3g1qAFm+bhmQznIEJ1T4Pnwy1W9sJd7pOtMKwJFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3yNlEh6; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b6bb644e8eso31148eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525538; x=1769130338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS7hbe2idkDtMNr1sikCj+4G/Yawhd2uUbgexxTfUAA=;
        b=j3yNlEh6mLCJt/CsnZqF5a49YL3O5rIngRu1c/S2U3xoDaBiayJh/TkGkYxKS3ccoQ
         K8O5Ea2CHugF53BicCR0zWuLZ9SH+GX5x+LL+5t3h+yHCaZI1S8Z1xBYzwGeD7hHY7qF
         /fLg00W0k469+zTPfLSZfG5zvpIdT8LUFye6EZ8CLlIigrUh2+eVav090wi+KQalgU/9
         q8bEuA1x1o2hLNx1gPbfp3Y1x96+aPilqJ3FfP1QN9xEr/KdyQDTmSXuW95hXhfvgJpU
         tvlv8E5TVF9MX/k/Oy/AuM3nlru6n8heG4qVAz+3au+gokIA2dHpPsZaxLNzVa8rPJCK
         aSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525538; x=1769130338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nS7hbe2idkDtMNr1sikCj+4G/Yawhd2uUbgexxTfUAA=;
        b=bC0WjKd9kI5l73aJAcn9imV/zW5qoIlVrBj218TgzCCYxQInWYQDC9yK44gj0OT9G3
         PejtcoLotD5B2TzxpVhcBRJUYHmcBY3fPMLmZtFnD/VIbCGd5/eE3+oSYkgWyNjVlmoR
         5FqEbwAejqrO6rxzSSFLXEr0qCYEANFhRPTMVv5OLK+rWhv2Tt+VuqU28NWy/YXR809J
         FbeYEC0HB7MWdJlCaUS1+KhI7Df3ihlH4r1TgDVteBqd9qhWfLSP5Jeoe02keEXvMM2M
         kCa/pCloAMujrXgtUg1Z6Q969VBftnvC28+yzE54eW0hBkqe1/+aLj+O7rGb1QQ0eea5
         oz8w==
X-Forwarded-Encrypted: i=1; AJvYcCW0dDEBFoDjRXL3SZLcEH3p9GP0Kl3E3dsMnCiemMHqJQ8xIsjTrXPDjCkNdSdaQIgcNGV1GhiteJoqN2XPnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PgLnf+NGRfUxCyptWkUlmozVzQcVmEZ4PfKaKCdFJltqj8Mo
	lCRPQadv4mmeItcO80sQo8kMXSu14+4f1DSkNfw2/yDcis4XWWIJmz4z
X-Gm-Gg: AY/fxX5AtW35Hhd4BbwznCGZZPgCy+fRddEGUNqqDHKeKvVuq1J/KLtmRPiq3igdrkT
	aUZhC2RJmryEb2jDdjgfwmFAXVoLeq5xAk7hUXx4hpHMb+NufTHX3W9PpIXfCbQBVtpphtHvgsb
	SvIMWAz2ymWrVkGOTGyl4arSy7oTggDK0lG8RbIyTS73LXo0DNEyL3jvwWqUfvnVGa7LkZRTxNP
	+E7G6ZV8rqL12nJqXFtLdRu1JRgUtevgbq/7UtomGlKqNdi1y44waZ9yonpZ6aQ2ke14fm3SXID
	A6fFGUOFEApWUB3L+tSIeGrrXL9rWzNM3yi+Ng6NsJ0HsU2ALV1IvTbWziuXYTc0k/f6NXkTqwX
	kF6iNZQoIvKkYQ2OvIcgHeMsq+A8FC5PN6Q3H/tIk9H0SPIWQ68TC+qeMTmXtmli2/1Z+KmbEFr
	cn0+nk8j1mdcWyprNBvVtlbhzOFsgIhZSakNMBEz+14vERC16lT08i+jxbgKT4MA==
X-Received: by 2002:a05:7300:5724:b0:2ac:1b61:ae1 with SMTP id 5a478bee46e88-2b6b40ffb6cmr1144200eec.26.1768525537895;
        Thu, 15 Jan 2026 17:05:37 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:37 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	linux@frame.work,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	Zac Bowling <zbowling@gmail.com>,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH v4 10/21] wifi: mt76: mt792x: fix NULL pointer dereference in TX path
Date: Thu, 15 Jan 2026 17:05:08 -0800
Message-ID: <20260116010519.37001-11-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116010519.37001-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260116010519.37001-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zbowling@gmail.com>

Add NULL pointer checks in mt792x_tx() to prevent kernel crashes when
transmitting packets during MLO link removal.

The function calls mt792x_sta_to_link() which can return NULL if the
link is being removed, but the return value was dereferenced without
checking. Similarly, the RCU-protected link_conf and link_sta pointers
were used without NULL validation.

This race can occur when:
1. A packet is queued for transmission
2. Concurrently, the link is being removed (mt7925_mac_link_sta_remove)
3. mt792x_sta_to_link() returns NULL for the removed link
4. Kernel crashes on wcid = &mlink->wcid dereference

Example crash trace:
  BUG: kernel NULL pointer dereference
  RIP: mt792x_tx+0x...
  Call Trace:
   ieee80211_tx+0x...
   __ieee80211_subif_start_xmit+0x...

Fix by:
- Check mlink return value before dereferencing wcid
- Check RCU-dereferenced conf and link_sta before use
- Free the SKB and return early if any pointer is NULL

This affects both MT7921 and MT7925 drivers as mt792x_core.c is shared.

Fixes: c74df1c067f2 ("wifi: mt76: mt792x: introduce mt792x-lib module")
Reported-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index f2ed16feb6..9dc768aa8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -95,6 +95,8 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 				       IEEE80211_TX_CTRL_MLO_LINK);
 		sta = (struct mt792x_sta *)control->sta->drv_priv;
 		mlink = mt792x_sta_to_link(sta, link_id);
+		if (!mlink)
+			goto free_skb;
 		wcid = &mlink->wcid;
 	}
 
@@ -113,9 +115,12 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 		link_id = wcid->link_id;
 		rcu_read_lock();
 		conf = rcu_dereference(vif->link_conf[link_id]);
-		memcpy(hdr->addr2, conf->addr, ETH_ALEN);
-
 		link_sta = rcu_dereference(control->sta->link[link_id]);
+		if (!conf || !link_sta) {
+			rcu_read_unlock();
+			goto free_skb;
+		}
+		memcpy(hdr->addr2, conf->addr, ETH_ALEN);
 		memcpy(hdr->addr1, link_sta->addr, ETH_ALEN);
 
 		if (vif->type == NL80211_IFTYPE_STATION)
@@ -136,6 +141,10 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 	}
 
 	mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
+	return;
+
+free_skb:
+	ieee80211_free_txskb(hw, skb);
 }
 EXPORT_SYMBOL_GPL(mt792x_tx);
 
-- 
2.52.0


