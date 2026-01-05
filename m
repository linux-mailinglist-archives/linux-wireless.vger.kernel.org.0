Return-Path: <linux-wireless+bounces-30329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0AFCF17E2
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D06E1304C2A1
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB0C1E9B35;
	Mon,  5 Jan 2026 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHLJ4wB+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A778F29
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572821; cv=none; b=W5m7uq5CvO9LC1sobM2Nz47nniSpKO2ftCf9K5tMeQz0tbGbaTcDjf1MfeHoktIrjRbSF3c/tjc1y8RzCJKS0rmx/9U4sfXHlSGEWk8Iu+mfL9aRL8+K7DCuJDjrH7taoaeHgGNhI3eWI5GL4Jo3m1I9UH4KaCv1LsRQgaV+VoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572821; c=relaxed/simple;
	bh=hY1b17MNfyuOvTeTzkddBgwbu8t+mTinNbwGGmZk7zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIru+ujlDS/gJgFSG1tCW/EJTEDo3biDm3Rxp3T7+h31jIrBNr+hxNe18MCGhKTI4rFsCwxe/Ln0FzNtnN5ztUVsnOJDTsfSqCzif8Mo/Wtmes0IexX8tNe0cFGDceVkTNejhSLaJ4n0elIlbCnFEOGkaT8cnz+t+EvAS0I6/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHLJ4wB+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0bb2f093aso136080285ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572818; x=1768177618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Q69CcxdhkUBHE6WLrwVRfN6aM9r49U1wpvLGX5O/w0=;
        b=XHLJ4wB+Cu2qjsX71IK+SS9y9yx5znuggfhhVfiIzC6GtsnWUMQ3+suoaUOh58ZHrS
         CAsc8/cWOsNVlzktt4Jz4sIVM1qnW8EucZIDF+1rQQKrdA9LMBSAMyVWYlcg9lSZyRl3
         cnAn8GHy5uNwPid2r51meUeqnSv1RLtKH3plKx5nt7Hib+ElQxHc1oJg5XIQS6PEJ+qI
         K/Wr34FecsVBtVsdT9+I7dyhjXHjSSLjwCmwn/+YwFV7H3F5OWocUJU79+L1FqR3It8Q
         ZnKA7thEZqK40oAwFdji07fFi+9qfWuSm/+VlfUBn3A91L7p78/3hKbFwSTc2skxxY65
         lQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572818; x=1768177618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Q69CcxdhkUBHE6WLrwVRfN6aM9r49U1wpvLGX5O/w0=;
        b=HST8lBwRumE/I7NfU7HFfFs/nCHHboxklg9BDoOwNLZ9xzYuFbucP2r7XrjohBU3pf
         gBWhBj61ekZGYMHIWTw+qBiTq5taAtc2pi3SDDQmdAUumQfR5WPsIlOY7ObJ1Dx2UBcw
         4vA6lxvEWvn0VFjsbjNzZXuxHqn7ZqyiTJRxWY56Ff7WAfS90RS6+RHIXoRJWe9mFSJe
         ySaJ5ftWVM1F6SnYLWcS8xqyOiBkulN5+bPr8aiivNhVGlO3pg9PhQnGModsVc7tBDYl
         iHQxfZdOy5+ej0oAFw3cMrlmQowTYwwhAKvhc+KcCRoU/vYNfStYklG2h6qGMRmoW7/k
         P5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcK43PgiKHlUeTmegC97dHZWvT6I+um5HdSxg+IAsoiqEU/AwN3S/XVWUSv632DiIGIDZlqgsKBfD9VwrWJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVfcOHKe03W3W5S9l6GCjicdLBD4mA3pt2//U1a2KuAeQYX9am
	IGNhbHk1h0+XX3t7+K4VYDEEEJ+7dmh2g8u36NkO7+Js57so1DX/0Ao8UdWALra0
X-Gm-Gg: AY/fxX55FMkb0k9cRMbkZjVPbm9FlEHn0aCafAvujuPmbGw465T6ReZvumezr5UJJLy
	uxbZVaFrBzYUQDIrfFR+fJM2yjKACQFY4CF8oC+IkQRSnfCQ9Na9rSb2220QPq2xNnsrCx6E8cX
	FgSe/i5AiQL3fpTT7zaYfdf604zrouUu2ZuiJyoqzOtO9/DMA27BjxiwHLdHC6Klx/aEeKVFyme
	4+sJOSl4qmGRS32Wb2fiFVtFZmsXJnMAoUAe44Nz8jIe4CLgPpqE1eiPyPk4CyQPKPk/7+6W9nC
	CBf0elW7P2UJl/4NJnj6Y1PrKGOo4egvoj6UF5kgm+k4GS9bKINfbJV6ejf5fdbDXolcGbo9PFg
	0DBjDCw3QGXtp6/k9Oo8p+8tsNO1RRnXVoQuavkJb0jFWsMi9K7UEkpstLMpcAzA0D1C42nO4G3
	c5HwxH2Yh4Uw6U017oe9t4wkca4f3nuCAH/TY9MrJWqZyeDfKI0EOAUmrcmJZvfKM=
X-Google-Smtp-Source: AGHT+IH/HpfDxf451qZ290MLqPE8eNuLqEV5xYgUPjCo4qWea89lQLz9YeD33hrqDQkNgFdV0y3U8A==
X-Received: by 2002:a05:7022:6ab:b0:11b:c0db:a5ea with SMTP id a92af1059eb24-121722d3a98mr46215436c88.26.1767572818082;
        Sun, 04 Jan 2026 16:26:58 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:26:57 -0800 (PST)
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
Subject: [PATCH 07/17] wifi: mt76: mt7925: add error handling for BSS info MCU command in sta_add
Date: Sun,  4 Jan 2026 16:26:28 -0800
Message-ID: <20260105002638.668723-8-zbowling@gmail.com>
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

Check return value of mt7925_mcu_add_bss_info() in mt7925_mac_link_sta_add()
and propagate errors to the caller.

BSS info must be set up before adding a station record. If this MCU
command fails, continuing with station add would leave the firmware in
an inconsistent state with a station but no BSS configuration.

This can cause undefined behavior in the firmware, particularly during
MLO link setup where multiple BSS configurations are being programmed.

Reported-by: Zac Bowling <zac@zacbowling.com>
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index d966e5ab50ff..a7e1e673c4bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -899,11 +899,14 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		if (ieee80211_vif_is_mld(vif))
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, link_sta != mlink->pri_link);
+			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						      link_conf, link_sta,
+						      link_sta != mlink->pri_link);
 		else
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, false);
+			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						      link_conf, link_sta, false);
+		if (ret)
+			return ret;
 	}
 
 	if (ieee80211_vif_is_mld(vif) &&
-- 
2.51.0


