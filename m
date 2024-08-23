Return-Path: <linux-wireless+bounces-11849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB1C95CF1D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 16:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03AA1C2114B
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D65D19924A;
	Fri, 23 Aug 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYWnl5Yw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142218BB90;
	Fri, 23 Aug 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421833; cv=none; b=PRq+2KShwFGmYrb+7qNmlXqXxBC89LFI8HfqpvLSDZ1EF7iKiaMpiEPJjYB/EavZu1eRa2qNgbJBG3ZQYSFASq+sPim4vZkxvEUy++emcC9aA4NZ4WgpyWHTf8JxW66+yNVz8O95NCRwN6ixV67Ts2k+r2oNyegCggRbRXfh48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421833; c=relaxed/simple;
	bh=Lw3xV5CQbRpHj7Suwhvn/ROZHULgNHJAEmyajtD6PGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVIYWiJm1B57fr1NB1waiPrpZlXELzQZSAWhevO2OE/OgAigIzNI1mrJ+8+Nf9bs5nJz+Xtplvr4gNLBAeKfAMjg1Viw7utU3h9VUcID+IvEfP/CB2Z4LGeWtEjpzVyt/ik+7U9tD+4ly98b202yWwM2I8XycIjW+8wbSmnRuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYWnl5Yw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F65C32786;
	Fri, 23 Aug 2024 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421832;
	bh=Lw3xV5CQbRpHj7Suwhvn/ROZHULgNHJAEmyajtD6PGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYWnl5YwwCBIArKeuw5YgI16un7qi9Ghfxz+P1bUe5Bfop9Jl5R9xnMAqGKFmf/Ys
	 f0FKm9hYcRE/b0nveJtd+S6FtYaqmo6KOUI5QGNratyPuyau4vmAMPlSCe8UMu4oOf
	 nOkCq48j5ebGp74SasoUiAVU3MQq7dVbbKH6lCB25wJUNeKXLZfwr6w992vSh4kwZ6
	 UbBc1cffpBCKW/Z6GOhd/CPykQkx9i+1Ho7P1IGF4EXVU2ZjVsms6qV8Sl4KeuQ2Zm
	 0QZB52ajVHpSuA8todpWFr5vHiz/quvFj9VDXWAUPK/hCHCTn2AgqwOfOerYw8Ol6u
	 bJHUu77c56izw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	Felix Fietkau <nbd@nbd.name>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	johannes.berg@intel.com,
	emmanuel.grumbach@intel.com,
	hao.zhang@mediatek.com,
	leon.yen@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/20] wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change
Date: Fri, 23 Aug 2024 10:02:29 -0400
Message-ID: <20240823140309.1974696-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140309.1974696-1-sashal@kernel.org>
References: <20240823140309.1974696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.47
Content-Transfer-Encoding: 8bit

From: Bert Karwatzki <spasswolf@web.de>

[ Upstream commit 479ffee68d59c599f8aed8fa2dcc8e13e7bd13c3 ]

When disabling wifi mt7921_ipv6_addr_change() is called as a notifier.
At this point mvif->phy is already NULL so we cannot use it here.

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20240812104542.80760-1-spasswolf@web.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index d8851cb5f400b..da17a29a4ce57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1095,7 +1095,7 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
 				    struct inet6_dev *idev)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mvif->phy->dev;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct inet6_ifaddr *ifa;
 	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
 	struct sk_buff *skb;
-- 
2.43.0


