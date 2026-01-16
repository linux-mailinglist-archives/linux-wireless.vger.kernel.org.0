Return-Path: <linux-wireless+bounces-30869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C24D29849
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7841430433F8
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3F322768;
	Fri, 16 Jan 2026 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2m/bVYB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8582F261C
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525549; cv=none; b=DKeZHF8PzO5DoI+AK/lWzT7XKbpPur5XnEz1OQRgs0CdHNCF+QNtDueLscGXBQEWdyayS82PjrclxZ6ofoeSzlyi31/kyF07u83BZrAQWCZuaHFMlhOO3ke1ceHQGksTjPfDwHrsCCYY/bqJzs+XiiB96PPgQp53Kd2A7EMngtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525549; c=relaxed/simple;
	bh=UtDRJAA+MPtf7ebptEaBueINPsW854AUm8zzzFfN3Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tghiRjqSgaSxD7J/JAQjbNYhNB6SnCqsa3j+nEzg6TMjGAQRnpmRf99oRZd917fwucOygbGpgdxsRUbb94YjtRf0+zaZbuIzmIvV9TW4yiCMJeqqceTtcLSgscex1wJZLGoogCJHczvVaFnc5Yyn+7eGHoq4sf2Ughl2pqXFw3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2m/bVYB; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6b0500e06so914169eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525536; x=1769130336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZlc8vYTcRnUgM5gL9ljbqiK/D1gsQfXcDj7/vtO1vs=;
        b=h2m/bVYBgaEH3ISUEhtu5hSWY4GAKVBJq6xWrhW+zMQr66/gz2iNIk2dO8uEiM6isC
         sSI484dCGNE5iONZfuZkkearpkaLEDIq1SrvRvBim4ahEwQUGpDRPaBPNiFuLRtQyra5
         Zn7wEyFWmUGrF8tR3DvkZ4ACBAJGgjq6HkUighedf1kS8IarBSRodkLoAS6nykeq6Btv
         RoRUa1hGZAe6eMvWue3d+0TBtlDo+NnLd8ZTPfPw+XEXNnN1AbfKv7rYZRmqmYFJjFy1
         v1y/1XZBQN9gICBNKwdEO1U7QhlYnLJhQap66X0XTlmgE84gsFi81Cat3j+H9hbzWsw3
         1oFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525536; x=1769130336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZlc8vYTcRnUgM5gL9ljbqiK/D1gsQfXcDj7/vtO1vs=;
        b=RBiISQAjVahVZ+AHg2Oij+XlnbkcoecyltobmkJ/HvBfW/17fIkJAfFpkqIpmVUJKN
         x1Oig3NGhZ7ezGS936+xkwMmkWDs8Oi7pQcOqajI1MKpiskPTy386J63Z8CSeUO5EVD2
         tm37tM5YbVf8j07bbZTTwilDgbHO993LWnMJlkb+1P074mUpQapX45NEPPpBQJBNm4Jt
         bYCUe/FduV3VTCQNEkkpYGuE22fPMJtfImpgNSbqN1rPaon6rwBupjicCokJ3e1xAHaF
         3IanT4+0ywWfXMmNdsPArf7dPTzLZCnQ8Gv1FtC0IF1iYq0U/GfuarGToJYoPlgsvwT9
         qWHg==
X-Forwarded-Encrypted: i=1; AJvYcCWTN75QHmulzjcRQ3sgtRF84LTBAYuNwwb68T52xYVxlV0Dva0QYgR838+K0/2ZE+7oSmiHWn59FdOSsUTuMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YypgdzSDV5JQ++vob556eZiXrD3/RvJJzgW+LGSdL2pXoSj1RUH
	G/kfZs+dIOpEEYeaYMpWntalo8WGXtRnPRSbrkQaFNOELnsqWuiG9PPo
X-Gm-Gg: AY/fxX7S/VKk2kpoUpw09mhHnW02+prvDj/1JJXnxuqZVajQ55DwosY9ywmiNl47gyF
	iMJXFTOiVnntqLg2BxI3gOQRx5sMYVz3Pxx1q+HcSqBBBwt0zIK8V7W1jYCjfgWskA1hWZAN+sc
	HXJ4tkqavnCz5Dcz7gm9PV7fPgazXGeWrawMD6DIrlP5r/1QfT0fFvkHIVFHSYUmy0C2bGcdeIF
	kBHlUJ0io5JzYOYR9ASAdNdF/CrO8RqbpRCZOk0j4MoQY9jejC0SnKTDCUsjaepEMJHcNEtLBjc
	w2j5NAJVrz907CAOjDAVS9c+1itxDvHdInMQUHuLIxflMX8ojNVm+LTO0DnPfPE40W3DWhuhcgF
	tan+6uUoeLl0q0Br1RxcgaosT4jjRICq3gRvSiWZiCQA09ZyFmN9aprNu7z4APPq4cqBu0uhmE6
	y33XeJuZjXvZ3SJEnGPocscsZJUi0xqL7ULj/SVjmpcEu8OC21l2QPzsnqfVt08w==
X-Received: by 2002:a05:7300:b505:b0:2b0:5412:3ef with SMTP id 5a478bee46e88-2b6b412b810mr1269769eec.42.1768525536379;
        Thu, 15 Jan 2026 17:05:36 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:35 -0800 (PST)
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
Subject: [PATCH v4 09/21] wifi: mt76: mt7925: add NULL checks in MLO link and chanctx functions
Date: Thu, 15 Jan 2026 17:05:07 -0800
Message-ID: <20260116010519.37001-10-zac@zacbowling.com>
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
index 058394b2e0..852cf8ff84 100644
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
 
-	u16 sel_links = mt76_select_links(vif, 2);
-	u8 secondary_link_id = __ffs(~BIT(mvif->deflink_id) & sel_links);
+	link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
+	if (!link_conf)
+		return;
+
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
2.52.0


