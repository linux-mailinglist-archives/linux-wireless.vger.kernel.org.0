Return-Path: <linux-wireless+bounces-11848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380EA95CECD
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 16:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B85F1C2427E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 14:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E45A19146E;
	Fri, 23 Aug 2024 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTxHo08Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ADE188A02;
	Fri, 23 Aug 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421734; cv=none; b=decuJEPmanlj5rsnfHlz/o8GLCzLYuVO8YkNknwLOETTXDrd6ZtpmbJznmoQOQ91ltCkTQd4dEsF5BKZtMeUhQXS7hx/XPpfmzHP1nv7yEfJFF0n+MgMQn8AZl9QgM66/0yG/Ad591Bw4Lf98sQlTEN686NlLnobh0IGREA3zq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421734; c=relaxed/simple;
	bh=IQ7TjlPFcM1NGskxwZ6YexhDbnNk5J92eHGQ2QXZWhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2kEimoX9FML5wiQNBbN0SdoOlpxLQIteXYK4Z1GYaFkNi3aB4JUso4bqzNa97frDZD2osisRPZHA5TiVS7vxsiOGon22UZEAMBknKQWyk2IPwcld0oA1sibVf25+ePyY64BlYzwuqz8yyTpgdGTqvCsXQekIAY/zwY/qAZj8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTxHo08Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E81FC4AF09;
	Fri, 23 Aug 2024 14:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421734;
	bh=IQ7TjlPFcM1NGskxwZ6YexhDbnNk5J92eHGQ2QXZWhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTxHo08Ziqk/ocF6quKVxxR7pKZsEVk/m7a/BC6lVMY0BbfaxgFUV2H8jChQPNuWP
	 TQi6sRbPpImikJipSjXheiSDhBZcJMH1hJgF31MsHDYwunKw5e+M59QGXzFyc5BFZs
	 XGUHAIGvsrZWiwsmA7UH4UkwhZwUSv8eAD5TJZ0X38Cgx34sQ+GxTWZEfZVIuupmKw
	 ApUsipSuBAGMgZBKoHP13DW5wY+gf62TZDDNAaLOdibQd9G0KPPIdX7861Sb0z1CsO
	 p1txNpHVzR09gQWEZRsIGGqBkG0tK6/cYYS0kl2PfpcyJm3aiJWM3OB7qAPb5aCY7w
	 V4GbfTcwex2mA==
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
	leon.yen@mediatek.com,
	hao.zhang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 16/24] wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change
Date: Fri, 23 Aug 2024 10:00:38 -0400
Message-ID: <20240823140121.1974012-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
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
index 3e3ad3518d85f..cca7132ed6ab1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1182,7 +1182,7 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
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


