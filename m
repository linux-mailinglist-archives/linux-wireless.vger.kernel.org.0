Return-Path: <linux-wireless+bounces-13923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B199B3C8
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2024 13:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950491C2136A
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2024 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0432E1BB6BB;
	Sat, 12 Oct 2024 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lljsPDCX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECD1B85D0;
	Sat, 12 Oct 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732473; cv=none; b=h9iabWikd+9iFCm/tJ8FI68k2ZxAvMCJyJzHJ7z7v2MsPGGwATNl/q5vkIgeQwrOdGUD3/FrLKAJQ1igaXARSYRMEAlliU9unRSpDQsLt/K/dUhJMuIeVucvVET63BDSafKGUg42FlmYiQpNU7BX1WeyrV6TFJAXlE6WQ8ZQjNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732473; c=relaxed/simple;
	bh=Lw3xV5CQbRpHj7Suwhvn/ROZHULgNHJAEmyajtD6PGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIpKmQzBDgf0CnJUBg1eOmQUTwb/wfMSuBJ9yOL6WqrrT13XcFv0jspGXXYwu+hY9ENl5YZz3jQ2Ly7DU2px7LxjmnU1VG/CpX5zkZvBRXzGwhqv/N844ycEglrEgWnT+hn4cUFUDMMph87PqO86P1gb/sQKak4mY9IY+F6pweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lljsPDCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90137C4CEC6;
	Sat, 12 Oct 2024 11:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732473;
	bh=Lw3xV5CQbRpHj7Suwhvn/ROZHULgNHJAEmyajtD6PGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lljsPDCXyj8TBE846ZEmWDWDi1iRtyL8hgSgKh+ueveO44nWZfs0SuukTaLnJpI3a
	 gd3AEALGGRc8bBE2K/HIo4urXpCfXF4Iuyloygw70rJquvQFYh78Fu4f79u23gj+JD
	 vz8ds4hSfzseNp/phZHb9LD8Ay+7qO1VNhcD71P4lCDaASFLAaUKeihFvxUVBnq3TS
	 kPOdPB9ibMxosl1Uv+duYyT5dwCb7vW4iiyVZsNSl7J+3bQox2M36rI5yFykFGgSob
	 pc7xIXGlUSNcYOeqg6RpnAmgeX+TGucjluWOtQCLJ7cWmMkqc8itQTVEGEOx1LuFl+
	 U6+BjNwpjZb8w==
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
	hao.zhang@mediatek.com,
	emmanuel.grumbach@intel.com,
	leon.yen@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/20] wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change
Date: Sat, 12 Oct 2024 07:26:47 -0400
Message-ID: <20241012112715.1763241-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112715.1763241-1-sashal@kernel.org>
References: <20241012112715.1763241-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
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


