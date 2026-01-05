Return-Path: <linux-wireless+bounces-30331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA268CF17F7
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF5530652A3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC1B21D3F3;
	Mon,  5 Jan 2026 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6/A8X0Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8C1E7C23
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572823; cv=none; b=q/5WYfJw6JPy6+ODUNd9M6Cp/fZww2m1zDdEx/twiykzBR1Zm/BFP3hd2uL9eqB7pRt7XMU0e7lGopNWzx1rz/45m3EwzxXVXKVr+nDFrH2pfemjgD10GIaY2EU5Tz/UaM1Ac/JdYXF1SZR2ZwyevGzH7ngB4XCRvfPqfEa6LXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572823; c=relaxed/simple;
	bh=okEPcwgetydhi6CjB9gPnDTD93VrrmmPij1wmDYyiRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3xj9bcVWmWcTZldcoIRAgboMebDXtP/6s7QDbNs2XEKo8FUuccd5eEtvAU9ntsLcsyG0wzZOwipsgveArbSBeO/6eZFloB4UtWMsPMdfuaQ+8fba/WD9zXKLKUQK9nVODe/1dtZ9v/IMjAi8V2YRhU7P8goEH3pnZwDA83Q2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6/A8X0Q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c1e4a9033abso12002107a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572820; x=1768177620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAUwSXTcbTdlZ05tKagbWIWR8etmGqco3VAQevRh9HA=;
        b=f6/A8X0QcwIeVVDgYgmodgBtSbe6nYPECYXbwZg2ulS5mLXCL1K+XwjBGndJLhDjR2
         lzuQdZ0a+LT2hjcZ2WRaaDkCIZgu/vSLTS8tkf4N9x3hVqgrMX7/hoij6kEUvqN6YpG5
         +u0D1cAcpFQzmMPHNNTuCO71F+jbf/ttzKTOXLzYgf6UrKWdU8naU0gJewIJ8tngKz0H
         8q/iGIq50qxxVo1wYbybMpIOUXt1jnkdkwzEUYfRhMtNfoxwtDZ5xvaGd+Ima7iJ6yxR
         iVqOoLN/b7EaUa6/6fQGwJGZDbJwBgWL+xLsLKTHbhDWUTlOwglpzGwhHUWqzTdpgB0R
         mcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572820; x=1768177620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qAUwSXTcbTdlZ05tKagbWIWR8etmGqco3VAQevRh9HA=;
        b=wfDvCbea5dlpphZ+Y6Dtqchc5ViykGrc9WIFq97mjtFjkskepgDMCI50jz1kiuLEve
         ENw1Rvla/ifoWn8cU+VOL0fNaR7yapVCfn40EGzpG7gnwl/xAsO19DXbbmWeVjRZwAoA
         DkBoPsUnYKLs00pQIw/u4MJ5+29ivIKP64pxVQH4EqSwK6HiavrG5ld+r0EX98SaUGVV
         Q4buekbrR9awxXIliciMIm4n7zrMgeu9zM0If6aPjv/QmKN/3IOf/FMS1ZLUQUzterwA
         X23wIxSKvLKziVSJR/xOuqPeFIiLTF4OnMeGjTc33znc4kHzpW/oNdazH/YrZMZXcziG
         4uig==
X-Forwarded-Encrypted: i=1; AJvYcCUJTLtPXNIc8MIragjI24X1AwIpIQriXRERbNf+8LM95PaJov/xBUDVxqkuIMVrzxgAymJxqUTKK3PmIV4IdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzVjSwUdhSrCWW1gcga2s1L+ccKgR2ZtmtgtusTRDSt18/7TOC
	hSA/zltNypZGl96lLtL6MQ/WekBtEpY7uFpn+cGs+oldO0xgTkmwXoA6
X-Gm-Gg: AY/fxX7QgYrPSfhSjcUlKAknOkrwt39X6rF9Xgafbin5hVak6ne+UGqOeRPwREbv/rm
	OkaJM7lo+J11M75AH92xYOD1tzt08TxsIkBvHrwUTngCQU60pn5VLSE9uRrsV0CcjhHmE6nkccZ
	5bOqG/gNjLsTl3s1bVCc0Yh/T/XmT4kWIsoYvvzsGw3653FuzWiWwU6+84KLa6ck0QzNwBcrt91
	88BJBJyiLeM6XkUX8rALab12ksEuDTErkJAH8nQ+udTYksOCx7PqaidxVz/SpBQakLSPzad2k7J
	pBiEoIcao5oROvitRiirVqBHbPHSWdtmNqYV6RYWk/x1u5jJVDLk5nyhvpKhJwH4XeDFgzAqWuK
	0M2NzZm9nBKWNwdQb9uyjJWF6R6rDKBH9IdxGrSM43eBg05FDa2I3sIjhK8aNVyHk+ksjk5VRVi
	e5V3FbJ6ASkdsHo93y79w4LU1HI/d6XzX+U1ZMIr7EA0gy+pXzt0Dc8XiqxElbt5g=
X-Google-Smtp-Source: AGHT+IEg+0O/U6jFKiIyTWm00cf6Hb3sWob6ISMuhNcfPkGZ9TORICaTgtXbn0sRqNiFULYdjJHR4w==
X-Received: by 2002:a05:7022:6b92:b0:11a:4525:5361 with SMTP id a92af1059eb24-121722a5f18mr45266378c88.6.1767572820373;
        Sun, 04 Jan 2026 16:27:00 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:26:59 -0800 (PST)
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
Subject: [PATCH 09/17] wifi: mt76: mt7925: add NULL checks in MLO link and chanctx functions
Date: Sun,  4 Jan 2026 16:26:30 -0800
Message-ID: <20260105002638.668723-10-zbowling@gmail.com>
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

Add NULL pointer checks for mconf and link_conf in several functions
that were missing validation after calling mt792x_vif_to_link() and
mt792x_vif_to_bss_conf().

Functions fixed:
- mt7925_mac_set_links(): Check both primary and secondary link_conf
  before dereferencing chanreq.oper for band selection
- mt7925_link_info_changed(): Check mconf before using it to get
  link_conf, prevents NULL dereference chain
- mt7925_assign_vif_chanctx(): Check mconf before use, return -EINVAL
  if NULL; check pri_link_conf before passing to MCU function
- mt7925_unassign_vif_chanctx(): Check mconf before dereferencing,
  return early if NULL during MLO cleanup

These functions handle MLO (Multi-Link Operation) scenarios where link
configurations may not be fully set up when called, particularly during
rapid link state transitions or error recovery paths.

Prevents panics during WiFi 7 MLO link setup and teardown sequences.

Reported-by: Zac Bowling <zac@zacbowling.com>
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 39 +++++++++++++++----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 058394b2e067..852cf8ff842f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1006,18 +1006,29 @@ mt7925_mac_set_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct ieee80211_bss_conf *link_conf =
-		mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
-	struct cfg80211_chan_def *chandef = &link_conf->chanreq.oper;
-	enum nl80211_band band = chandef->chan->band, secondary_band;
+	struct ieee80211_bss_conf *link_conf;
+	struct cfg80211_chan_def *chandef;
+	enum nl80211_band band, secondary_band;
+	u16 sel_links;
+	u8 secondary_link_id;
+
+	link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
+	if (!link_conf)
+		return;
 
-	u16 sel_links = mt76_select_links(vif, 2);
-	u8 secondary_link_id = __ffs(~BIT(mvif->deflink_id) & sel_links);
+	chandef = &link_conf->chanreq.oper;
+	band = chandef->chan->band;
+
+	sel_links = mt76_select_links(vif, 2);
+	secondary_link_id = __ffs(~BIT(mvif->deflink_id) & sel_links);
 
 	if (!ieee80211_vif_is_mld(vif) || hweight16(sel_links) < 2)
 		return;
 
 	link_conf = mt792x_vif_to_bss_conf(vif, secondary_link_id);
+	if (!link_conf)
+		return;
+
 	secondary_band = link_conf->chanreq.oper.chan->band;
 
 	if (band == NL80211_BAND_2GHZ ||
@@ -1927,7 +1938,12 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 	struct ieee80211_bss_conf *link_conf;
 
 	mconf = mt792x_vif_to_link(mvif, info->link_id);
+	if (!mconf)
+		return;
+
 	link_conf = mt792x_vif_to_bss_conf(vif, mconf->link_id);
+	if (!link_conf)
+		return;
 
 	mt792x_mutex_acquire(dev);
 
@@ -2136,9 +2152,14 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	if (ieee80211_vif_is_mld(vif)) {
 		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
+		if (!mconf) {
+			mutex_unlock(&dev->mt76.mutex);
+			return -EINVAL;
+		}
+
 		pri_link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
 
-		if (vif->type == NL80211_IFTYPE_STATION &&
+		if (pri_link_conf && vif->type == NL80211_IFTYPE_STATION &&
 		    mconf == &mvif->bss_conf)
 			mt7925_mcu_add_bss_info(&dev->phy, NULL, pri_link_conf,
 						NULL, true);
@@ -2167,6 +2188,10 @@ static void mt7925_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	if (ieee80211_vif_is_mld(vif)) {
 		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
+		if (!mconf) {
+			mutex_unlock(&dev->mt76.mutex);
+			return;
+		}
 
 		if (vif->type == NL80211_IFTYPE_STATION &&
 		    mconf == &mvif->bss_conf)
-- 
2.51.0


