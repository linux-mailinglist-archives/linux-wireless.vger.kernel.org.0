Return-Path: <linux-wireless+bounces-30332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB816CF17FA
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E682E308B09B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893AB225402;
	Mon,  5 Jan 2026 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB1Rx9pG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D53A189BB6
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572824; cv=none; b=VPtbhkdXS31wx/2nS2qsBEhxQrIqWeuZkKffF6TXhoi66vFfhz/Dfm6D2X6fyfupY6tBh7CKf2PjvY+aGw+0e39LggXjqwrA5FQ1TZXGpyfL7CsWAJDS8XLeLLqkPX3pVVa/ydijpy0owRx5nK7JWx/4eKuGDBAqt72/gRefN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572824; c=relaxed/simple;
	bh=UI9JtUEuEslTaP4rLaUkTohz7iGmINe7yYsfOHt6CR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8d9iQX/3Pk636Ckc3fm7HbJR/HPwsBw4uPzjElpL72jUFrfvTSoqo2cZJ7tpvmuY/nWXw9uOaND//BS7yYcSgN6i2sEfnRSEvTPTZS1zNCXr2nSsbVHi+IXvU3NRVa7Q+HYoB9k5uaEdwMt5O7dJFhLNuFhwaoON+RCAzU7L74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB1Rx9pG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a12ebe4b74so242084935ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572821; x=1768177621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xc3vtf8nV55Q+3v5tcb1BiSqe6gDU9FJGry7raEU0u4=;
        b=kB1Rx9pGQfv3N4pZPlIkVc5APrtLza9R6tdij4xdynm5SNMv8eTJJ+0Ar+OqRfHAAA
         ialJdXhVzRVpzqQg+4jqpBJKSR0IdvCYvrJk0Yq9huiCzRxMj2JAlHqljrxkcru8fqZL
         pt+YqHymn4Qk/3/Ivrex/lsqlQI6g21mbMMveEJFEq5gbJ34tXGCkZmM2OV6UaFo3lr7
         a8H5K61/hyK2VQK1zBwBrIm7UVnZRQGenwWuXpNWufVewb2a4zujyi5DEV5lRtgFmInV
         Vza4ejAfc65Ob0xHYzCx75uvDtNM0hERvS/z0XcbHjy7AP1tMjOCP7Mca1EH/mTkMm5x
         7HtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572821; x=1768177621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xc3vtf8nV55Q+3v5tcb1BiSqe6gDU9FJGry7raEU0u4=;
        b=ebRQurcqU7bCyED4WbVlWX33Z0JkVvPlYr/VP3e8r9HdVSovtmhLRZXK7+ShZyjotX
         j8KhJyvmH4egotJeauwoxezuEj16qDk2HmmPaSU1rhetC1uwfVxGng2HuwuRYl6NCa6d
         UihMjJxYcwNGrGtuQ6fvn5ZXIl8in2v6KgmChcBm+xpqg2HXLs8lM1Ks2FG4lGZSGTmq
         GBQUprWpe2rKyV1H4gtj5jRjJln27pi/vNpcMsQXA/y2f4T62LX+sVMT8p51gO0o48tL
         sIi8KR4W1OGV5ssifuk98OT3THbKRb3THheHV9Lf1346kP7Qu9RDb4nYrnKqD4yeIz09
         rdug==
X-Forwarded-Encrypted: i=1; AJvYcCV3iLip67d4gCD9kRDwNQOG7Jor5vb1vxMZ3bzh8CylsWHEDNgcyHdwQMT9j2iCMhiVGvQ/AOL3vJSnZy/yOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUZdWHMjQqSGS1mHEoOtZWkmwtbJHEbWNH4ulrmN+U2xZcxNDD
	YNZ+v/jIlQ2ptipuBYCYUQ0EIpO8tFQmSBqaLDWWSCNhmvrgmX7+uYC9
X-Gm-Gg: AY/fxX5FS9C/idhCHgEFbVVI2pxO27dBjESuheUGpIIm08+fn4G7Eusw0UTDoXUc0CC
	Ar2w4nQd4Uk+3qOdU9r4QC1TmXQoI54WG3p7SEQ3oprhVqn0CyvE91LrdYHX3fzVuZB7AX7GBxv
	NwcIzSPdVEO9tzhSremzGoKOeZbBpFT4PAgsB//bOMHpZAEg/6OhcRtMiQ+ZeUXJZn7cx+b7J8/
	zQWu7++/5GASF47YOsOyxH7gd9TDdAPlwsfXIt8dupDhah6SOnUTsr2Sz/q5XXPHv9I9Xn1ztuX
	xrCFuhTGf2S4QER9JII1adCgk50L1mx1n7Djot7cFgK3tIGQThLBaB9sctLUDj3RSWRA+g66Vfl
	o2ITb1c6YJqBIQi5T8lB/L/keHcHOcIANKPLmj3PvqOHA2jage3U2pywrjZDSQQg+jDAOsWprgk
	kjklSfJ/p7OG2Vp7+CnwcvZlnZ5VcsVVvT2y/2Et9lmS/XSlHJcqL0zitpTPIGHUc=
X-Google-Smtp-Source: AGHT+IEU2h/tWNXbABrCcQmKu0PD8p87Gpp0+pw1A9lE8jv1PWOQX4Lsqm7CqNoXiBV7IUAHXXZutw==
X-Received: by 2002:a05:7022:82:b0:11a:126f:ee7d with SMTP id a92af1059eb24-121722f57bamr30029316c88.35.1767572821365;
        Sun, 04 Jan 2026 16:27:01 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:27:00 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com
Subject: [PATCH 10/17] wifi: mt76: mt792x: fix NULL pointer dereference in TX path
Date: Sun,  4 Jan 2026 16:26:31 -0800
Message-ID: <20260105002638.668723-11-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105002638.668723-1-zbowling@gmail.com>
References: <20260102200524.290779-1-zbowling@gmail.com>
 <20260105002638.668723-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


