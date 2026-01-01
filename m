Return-Path: <linux-wireless+bounces-30256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D00ECECD73
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 07:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAB9C30081A8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 06:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3421638D;
	Thu,  1 Jan 2026 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjLbc3YC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB4015B998
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767248430; cv=none; b=AMnof8NskxzeHeC0OUd/q/L3dIDSjpGO+anvX4RH68v1zM3bWH6qmxUXRaS1TlfIWdMM+SjVIUZF7GhiIKcEHPnFDZCppzPDVz2A6goYNfJ1eng9CYDetsSyN36bDOetCgSfZgWhy4xqlshCESfwk0Sqf6vs7vk2Un7gC8chF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767248430; c=relaxed/simple;
	bh=ZMjkQ2oEVaMus7T4ec0PlJQ/SINBc3xpFQWSs4HAiGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/5zQZV+JCellZQNsCGbSgQ8TJjtB+Ie6URrIxertASVyUj/6QWuGAok9zAnnYe9i3qkFM4FpPdIIleLII9V4dSRtau7URLdH2kCtSFirGzuTs9gSOCU2sEGDY3VLZbKOPgty9Q/BGjWkknOCDbgrYux11bfb86Y/7vJbckMd+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjLbc3YC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso6845893a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 22:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767248427; x=1767853227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F7OVxpcjzhJ36YO0FCMfAYe7gUj9JaKUB98nBjP7Gi8=;
        b=HjLbc3YCHgHK/2gEAWgkRhR+LaBZLLmsMHEUKEoxB4YDtXzPLgHERvpPn3Krm5PzPP
         vPWCGPnm0PeDyyU7TwNWCI0EoP6TNg8xW/OnTl7sHzF7XmYWEm+PrTCNx4O13lQdHd0u
         n2s03AJyig72SksPhSdsU26kiJxf9IPEgAQGfI05/cTXF6VmcTlF9YPR5JNs5AWSS8mE
         MN0VQY7sewcfU54UQgDb/IK7KyqxQKagXfzHPeqLAMCsaC6dxYCSO6R2ZNTMY6ZyvUpM
         r5K68HSJ1iubC9C3xpiGsWZK278kww1ed0HDY1fpay0kSR/GlVxi6pAamrz4aAAMyk3i
         kX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767248427; x=1767853227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7OVxpcjzhJ36YO0FCMfAYe7gUj9JaKUB98nBjP7Gi8=;
        b=cDmvsqXBfqKhp/KFMhMcxrLC2ry9qj7PJXN7/oajvVdpQv50zNvTlPy51/O/v0aixj
         O88JGbEuYnBRzgKtoShGk2svX/ik/ctDf1bR67RoeJ21ZGuvO3+cjB+qFZ2tyoySr8Fp
         Jlc9xzuqjU5ZOmR2LMCQ/YBE2QKMPKLppahDPDKHo2VQCfWIiidisfMr/3l8uEcaze1V
         HGPaD9DpzUYNITNI9tGdaIzUYWl/rcS8kfwxG4VhIvyV32BH0+lBd81OOSKzMr4Xtij+
         FIn0EdV02Km2nMgSojpjI6ZyKRKqiiUU4SQrxf/jGSiuXXQ0lNl68IzBo4W7CueUIUa6
         U63g==
X-Gm-Message-State: AOJu0YyiPraW0MiMsWLYXqV2JgP0NGyfcMP378xcecbucm80t0MtSapC
	7gxhH3x8XZYeMrJK36pBkYsQrg+PDsAq6nHsjQfB5JlGhsEOVstaYu6iJ0ILrTDR
X-Gm-Gg: AY/fxX5QzR5c9lT7PUyWA7hL5UqW/lyj3RoJ/F8jCDPzQJ43A2L46cv83IqFCOmQ+qO
	rxKgWuGmH9Bm/B8J2WpDXu0Xu85yKKj9ThO6Jhck7hnnymGmucAkeFlxkUV8LVeFAtbKZySABrf
	mDqK3zgsE2t8vIMMTrR6jYYkQPtc8VCgH2hFwZ+RIcTjuM+5nO18n/Kq+kEWsi/LCzIST7nAkAY
	Hxt1hB8UdktuqViFXmjQt0LDTaBgJm7O6e2UCzCX0rmnK4zT+pMZRSq1eN2vUoV7yhbu4hcnGWK
	QMMnAEUn/u4AMe2LhFECGDu6dFvNDLBaF56rMFJZVyJk/thMojwDB7peK9j6PW2yRE2X14o7Muz
	bnej9WQcfdY5shrWZYTbR9efG5vl3EUC72bisFWeMiKqZkMe7EmFEPtA20nXWnCsHaOckB4dCnQ
	oiI4SAVX2ZfOgn8UKCklta/OHsAUpbLTBtgCSnBSi9HwR7KHbYqU+kT/GD5oEXWHQUiuivfCuS
X-Google-Smtp-Source: AGHT+IFcNyD5xwVxRzRa1qB3GJNdE3L/hyCnyksDrjw+mHu292ZOJvkzX/ysi8HBo7Uasfom1wxTCQ==
X-Received: by 2002:a05:7022:6983:b0:11b:9386:8273 with SMTP id a92af1059eb24-12172312cc6mr32852067c88.48.1767248427458;
        Wed, 31 Dec 2025 22:20:27 -0800 (PST)
Received: from zubuntu.home.zacbowling.com ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de25dsm108662883c88.7.2025.12.31.22.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 22:20:26 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	ryder.lee@mediatek.com
Subject: [PATCH] wifi: mt76: mt792x: fix NULL pointer dereference in TX path
Date: Wed, 31 Dec 2025 22:20:23 -0800
Message-ID: <20260101062024.181697-1-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

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

Fix by:
- Check mlink return value before dereferencing wcid
- Check RCU-dereferenced conf and link_sta before use
- Free the SKB and return early if any pointer is NULL

This affects both MT7921 and MT7925 drivers as mt792x_core.c is shared.

Reported-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index f2ed16feb6c1..9dc768aa8b9c 100644
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
2.51.0


