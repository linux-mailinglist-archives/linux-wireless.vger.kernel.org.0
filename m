Return-Path: <linux-wireless+bounces-30333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04839CF1803
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04AF63080A87
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6797119C54E;
	Mon,  5 Jan 2026 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPvVzD4U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8851A199252
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572826; cv=none; b=FMvSQrE7rwF5UXGdIG/Y5dtUqoKno6ZDUNdr5fE3PFGz1+uASfk5o5i/Zvv3CRXJ0NdDrr435xbs9SFVsaDkS+ak9LkrgCoPCuKC6oPY2y8Ei9BAC3+FZo484GRHXjruqOS2NqoEwi+C7ebtaW2da6DV8qnY/nOQAmVmJ0weies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572826; c=relaxed/simple;
	bh=qQiL7A5UoXk1yN80eddElOmaXjRK+jDnvWEcU4/4Qzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaqymEEP5sPWawwrZWtlFTLGy3VCywA9C6bJ78Mv4GwwzuEsZ6+fmmwnmkHM+BzSNR6NA2ntKB/Q6InDJhQ7f1KMvIPZ0Sfs8F0hCUb7GvE1mB6Bx+bc9uw7l4pFHaAYK0GA+nc5vSwRK+dpmyBuuk+5AN0WCjtYjp/X8acLNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPvVzD4U; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0fe77d141so155214625ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572822; x=1768177622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otlGSXdgNZb8EYSsQOqh3OBybZYoKcQg4yihKraf1p0=;
        b=SPvVzD4U6t55YPGOgvElsKDwKobMnc8ZErMwUidWI4YmOLqhZ5Ua7NrHsow2800EbY
         T6X+ag7s2F/rz4Lm1FzcZpB0RUskBcoQvnd+xrLyN9oaAenlBVPfZ5YVOkZjdfmvJkWP
         dYeZxjiPUsYgxIOvYoAHZj28DsqbzTpU+B6gZfpIsU/3izpT9mfFDhTirC1KzeTarvmn
         op5Snc7BLKu6FB/pS38PM9A3E6389Xo2AJdiXrk9SteohsdWZo9vB6mFcckKWJTeydqw
         rW6Gs9jkQN8DoX65LCEl91tOgVoHsnayqvJL//26KJZm1PWvK1BO+964G3htKRfja0Ka
         /NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572822; x=1768177622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=otlGSXdgNZb8EYSsQOqh3OBybZYoKcQg4yihKraf1p0=;
        b=oZqb5Y6ClS2fZQ0gDYqOIN1tMhaFjNiYWrO0+QoaMmwDa7T8rWf7sTudyl6vpeolTX
         WkTQNe78BhE47nrph4WU8t8PkmCz51b6bjZqMiAgAMVJwhOzhGUEdflzG2nhAD4j6/O7
         EsIaMC6OHYWYfRA44y9Es31u21qE0eC+MlSO+DlhuPQe+xpuqVsz2fEcFswPt9g9bTXb
         QZZGatR4BaSWFrDPzJTJAtlYHvPi/hLyxNqDRfodH94kPKDZdnT8qQUGisbn2UtvU/+K
         cGu2Z6bpw/Wb0d7uHMFiSKRlw47HgQKQnFET9vt67NWsajAb7Z7Zt9gFVIRg3hSbzhZi
         sjWA==
X-Forwarded-Encrypted: i=1; AJvYcCWDJwPCqqGdLW7XMslBGgHQnWb7kCIWWSiAJy83LgDklA6kkCjk2RnjUDdBfX5JGibYKJpenIQ5y9Cx3knzUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8sVm6HhvjHjFskGDdR7D1kPfqB0iagmRMTfltEC3AsvDc7V0
	m4Y4WcieipMLk8oS2kab13gi6yvaJ39YNNRCwRkrheW1xmqHKLkKf/2O
X-Gm-Gg: AY/fxX5chR+4Zn6MV3JbroKMXBEj5bzi+8j2B7XqdivqabSztELGbSNd3Qu/X1IL4bG
	1u3Bx2/AmAEyxeuxTnrEr/HyA1IKAMD6w8Un/sQo7+rDYE5OXnPj2l//+MuuEBAC9AFgCKJ5lKe
	Gw97nYQqkrAbhpqLBSuMiDXaHjuAUX+YMciC3CfN3QJfE8Sx4KcNc8dhhT2FpBNp81uFonquVGW
	+5nHtLq4qqyhPkQoXYtX2DxszOMdJrzBt8Rj2S0wC7qINF6jCNVRPUljwdM/Pae/i1iNQxO+OIe
	m+UubYfK++clGmA1w+cRwcK5Mj74MkXBrG08DpV7RfOzkpUKUVts5+MRpez5diTHQo2seHGwo4I
	ZXXNwJ4MxwvuTzu4eEH/3Wb7PUu6GLhnx3k/LNzEPdzs7Erj+xV4+eHvnVFucTDwQwhI5eOnOFC
	rNYvUeocnzrn/CZta+p3CgFbvMdt/J2IEzjyk9BtAWXSwMiL8Ratq93laPbDkS6s8=
X-Google-Smtp-Source: AGHT+IGoBnLyCx81MR6DWCg6Vhwj+2ECjH4n4qm3rwpzsNEJebHAQdFrXPLCsGc5oHn3E1w7jHt4DQ==
X-Received: by 2002:a05:7022:428b:b0:119:e569:fb96 with SMTP id a92af1059eb24-121722ab2c3mr48491836c88.5.1767572822470;
        Sun, 04 Jan 2026 16:27:02 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:27:01 -0800 (PST)
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
Subject: [PATCH 11/17] wifi: mt76: mt7925: add lockdep assertions for mutex verification
Date: Sun,  4 Jan 2026 16:26:32 -0800
Message-ID: <20260105002638.668723-12-zbowling@gmail.com>
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

Add lockdep_assert_held() calls to critical MCU functions to help catch
mutex violations during development and debugging. This follows the
pattern used in other mt76 drivers (mt7996, mt7915, mt7615).

Functions with new assertions:
- mt7925_mcu_add_bss_info(): Core BSS configuration MCU command
- mt7925_mcu_sta_update(): Station record update MCU command
- mt7925_mcu_uni_bss_ps(): Power save state MCU command

These functions modify firmware state and must be called with the
device mutex held to prevent race conditions. The lockdep assertions
will trigger warnings at runtime if code paths exist that call these
functions without proper mutex protection.

This aids in detecting the class of bugs fixed by patches in this series.

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index d61a7fbda745..958ff9da9f01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1527,6 +1527,8 @@ int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
 		},
 	};
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_conf->vif->type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
@@ -2037,6 +2039,8 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
@@ -2843,6 +2847,8 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	struct mt792x_link_sta *mlink_bc;
 	struct sk_buff *skb;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
-- 
2.51.0


