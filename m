Return-Path: <linux-wireless+bounces-30994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D0ED3BF33
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA6FC35F4EF
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDC9376BFB;
	Tue, 20 Jan 2026 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjxv9Uac"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A399D36D516
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890542; cv=none; b=H0XNRT0YZsFoOU2CsCCIrIY9o3q3LqEhwKUUVkDZXie5qRwfNBfoUDIVn02946Cf49TtHu/ceVG38ftkD6PVFAblXk+M3xySoI3UALoB4YhyzK+5Zj/5P4EdHsCEUxYb10m+oWe3wIypgR/4O+Dvac2oDBalnSjokIhWn3nxqo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890542; c=relaxed/simple;
	bh=U3Nyq3NqiqDHDQqkseFznMKgRIxsJy24U5IKOEvZynU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr5/bEEvfgtn0aNs81xT6bsWsPBi/x624yhc7zXSmHZYubs8uFa0MeYvSFQS3mTV+Aq/Ziv4z88w+ihzEjmMgPl3kPj06iU4+UI2FCLE4QbKN0dYljMumv/uwuDyXdYkmq2WRbHaDYlo5RQcbKz17D3UndlRrkksCWHOvDkvnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjxv9Uac; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so9056370eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 22:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890540; x=1769495340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR+w7fOhhpyJjkq0X/V8TVo4iOOXXnMSK4qWX/dQNIE=;
        b=hjxv9UacipiMzOCPp4LF1+mn+BQyU+EDAC+RQaNB/xGuqe13Y78ZEkm9H8/cPUzK8D
         aYO5/FWmOqOjXLon0gpabv5CN4pAFPQZHAClgkOW7ZFXV7fscx/phS0rgtRzgdyu0IlI
         B95qyZYzy11v9zN0SdgdRaQYsMZj7XDjaTWshh/96B2CzZ6umNdDXoM6C30VUg9YldiE
         Zc+/10Q0mzCpzLzUX34XlMtbAIXMY9ktnzw0V5msh5GdagvQnSXy9+77U13PFt3iRj+g
         EV5i25L/HMNG5ex+k4xPvLHUiZ9lD+HUvnTO4g6/1dOg9djnJsYz8n8qk6dV1oj6DsSJ
         sEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890540; x=1769495340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QR+w7fOhhpyJjkq0X/V8TVo4iOOXXnMSK4qWX/dQNIE=;
        b=CUX3JlgyLeTsbHsSC7KeJfH+I1AlYuP9H5CeMhYcQoFf5FiVCwiRK/IMPSSIYvpJZM
         HoD/nU9KQoPln7eJlIUHWimh9Q1ieFN/FPYptYTp/Swq6l5dPDPET9rlpIyskxV2BQbp
         lC2uxD8EBHZtNCtzuuZtA/tDn6QQS4NKsPDym3ps7DDRQPkDSmEb5AulvGT9+AH3Zp4M
         kKOOsO5cSAt+RyXw8zgOfowaanN0JcgTnLrJRLzaGlM12zMb4CL99/7XkxFTuwFFLanX
         IUTP/8PPMHvATpz3YKoCYbUgaqWJ49Gj6bx0NRaqNunuctZFAWPdx6m1/xmAeK53Gp3M
         jkdw==
X-Forwarded-Encrypted: i=1; AJvYcCUyEvODrLLWTIB2OPaInbiiW2c3iE2vtaZ1wcBNpFGXo8iwC6N9O7f1keDcyCbh1Pio637gRsO1TCFjWLfGpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qtqIIkoe9jBdHuFzk5mqdx6jtLdQ2ffVqwMop4swWdq6ljne
	g5O6mwrJQod3PmL14t649W26kUufARCCIZ2fn37K+gfo8lLQ3VAnvl+PGCLx+a4y
X-Gm-Gg: AZuq6aIRW3BC1PZ3vmESHuAe+8eNGl2PIZfBfL134w2LiI0/jJd7BYiUBEzQZ4GXj91
	Xho4Rq6A19/+HzFiL2UTmCFn6KiKjT9Gql/qUy+lmW9Pm0t1zqHkaCzCq99WE7BgroULLsHrlJJ
	+SIvetUSiju94YgKW/ub3ggZ7Cdqoj0HS3lC5HtN5sEGEuDZC+ZayumW8L+fPOUpcNw5bNV3p9n
	qENejQxK1/u9nI3MsbdLfng+Bv8+7PG3SvywFN40+DBgkRZ5C1UjTvaU3UpaWqbZZ1wcbV8cbac
	wTMTBN9QamUZdtNRQkl5koaL0dntxL2ysSN4qGeNn/8zX4YP19QVviK9EPAlmZEDd/kpKazeJKJ
	BwQHz5/Yp9xGX2MfZEk7x3HDsgzXjY+JY7mkqgH3syUj5iL2aHOpUtuEtZMbYIm71B6UtEst35a
	mWAXcYH1L/0drD2XJUlUjoTaNLWMup9LTPnx3D8GnGaNd1ELBhGMS3yzKrQGVo
X-Received: by 2002:a05:7300:e825:b0:2ab:f56e:bea6 with SMTP id 5a478bee46e88-2b6b505d137mr10313793eec.39.1768890539343;
        Mon, 19 Jan 2026 22:28:59 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:28:58 -0800 (PST)
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
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	stable@vger.kernel.org,
	linux@frame.work,
	zbowling@gmail.com,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH 02/11] wifi: mt76: mt792x: fix NULL pointer and firmware reload issues
Date: Mon, 19 Jan 2026 22:28:45 -0800
Message-ID: <20260120062854.126501-3-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120062854.126501-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260120062854.126501-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

This patch combines two fixes for the shared mt792x code used by both
MT7921 and MT7925 drivers:

1. Fix NULL pointer dereference in TX path:

Add NULL pointer checks in mt792x_tx() to prevent kernel crashes when
transmitting packets during MLO link removal.

The function calls mt792x_sta_to_link() which can return NULL if the
link is being removed, but the return value was dereferenced without
checking. Similarly, the RCU-protected link_conf and link_sta pointers
were used without NULL validation.

This race can occur when:
- A packet is queued for transmission
- Concurrently, the link is being removed (mt7925_mac_link_sta_remove)
- mt792x_sta_to_link() returns NULL for the removed link
- Kernel crashes on wcid = &mlink->wcid dereference

Fix by checking mlink, conf, and link_sta before use, freeing the SKB
and returning early if any pointer is NULL.

2. Fix firmware reload failure after previous load crash:

If the firmware loading process crashes or is interrupted after
acquiring the patch semaphore but before releasing it, subsequent
firmware load attempts will fail with 'Failed to get patch semaphore'.

Apply the same fix from MT7915 (commit 79dd14f): release the patch
semaphore before starting firmware load and restart MCU firmware to
ensure clean state.

Fixes: c74df1c067f2 ("wifi: mt76: mt792x: introduce mt792x-lib module")
Fixes: 583204ae70f9 ("wifi: mt76: mt792x: move mt7921_load_firmware in mt792x-lib module")
Link: https://github.com/openwrt/mt76/commit/79dd14f2e8161b656341b6653261779199aedbe4
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index f2ed16feb6c1..05598202b488 100644
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
 
@@ -927,6 +936,20 @@ int mt792x_load_firmware(struct mt792x_dev *dev)
 {
 	int ret;
 
+	/* Release semaphore if taken by previous failed load attempt.
+	 * This prevents "Failed to get patch semaphore" errors when
+	 * recovering from firmware crashes or suspend/resume failures.
+	 */
+	ret = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
+	if (ret < 0)
+		dev_dbg(dev->mt76.dev, "Semaphore release returned %d (may be expected)\n", ret);
+
+	/* Always restart MCU to ensure clean state before loading firmware */
+	mt76_connac_mcu_restart(&dev->mt76);
+
+	/* Wait for MCU to be ready after restart */
+	msleep(100);
+
 	ret = mt76_connac2_load_patch(&dev->mt76, mt792x_patch_name(dev));
 	if (ret)
 		return ret;
-- 
2.52.0


