Return-Path: <linux-wireless+bounces-13167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95F59859BE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E982E1C23568
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3810E1AD9E3;
	Wed, 25 Sep 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+GjdMRd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF0118A6A3;
	Wed, 25 Sep 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264406; cv=none; b=aGM5EHRVN6iMR/BbJr0sdX+m/ZA5tMH4/DIFbYSkeEwvi5KdJdRWiw8doKmAmYnMeLg5nHFNXs2Zb6ziX6jLWFtwuZS9PSZIVsCt2LLfaci9w//UUgVejXa6sX+B/CT8LJO331aBnyZc0ZMeLDJCIS70KNAx5NqtCCzW7JckGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264406; c=relaxed/simple;
	bh=VEIQZWdTQ9dg2khM6hUR5xSlsXQRX0LggRkXcpNBBSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXKJeHd/7D9NI0XBaoTNOv49HK/5n69HxSGW9H7GG8Ml2brsfLlimwrS+Kigxm6pOJW+r4d8rm8ITYEVWJJlLfDwS+QlA3ETIee6VNbktEZBxoD80EvIrSz6v1FAbFMPZlEmGP91/NzI8xNWZfBDnJAUHRnvPDFJn7JZsT797u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+GjdMRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C91C4CEC3;
	Wed, 25 Sep 2024 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264405;
	bh=VEIQZWdTQ9dg2khM6hUR5xSlsXQRX0LggRkXcpNBBSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+GjdMRdfoLjpW0DyKpkag3fWOh8wCZm61Qqqr7uAzM9Lj/ON6rmoHPxexeIChgM3
	 3kwGZMLrmA4+MdUu8RYZetLcvwrtpTyEEjk6h1uH4GJk4yGdnjwxFiYpd4svRSkAf5
	 sXGN/pcbfbKcqcJUEDISF4MEcTp7mHB7TK0vFz/+QM8EH70F1se4V4O6kEB3hx42Bl
	 9ILjF7kBVPtD2BlA8OSzqBngaqSmDKee27Ju6vWRVur9FGIfWrZNFXL+a4Mi3tYv6T
	 idTJWjAUzRZN3yu4zM0KecID6JCq1TBQito0wlFvdr0CJ2q8z+0zOe8XE5MNiqikll
	 zvInGSyS7t2pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	shayne.chen@mediatek.com,
	henry.yen@mediatek.com,
	allen.ye@mediatek.com,
	yunchuan@nfschina.com,
	Bo.Jiao@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 083/244] wifi: mt76: mt7915: hold dev->mt76.mutex while disabling tx worker
Date: Wed, 25 Sep 2024 07:25:04 -0400
Message-ID: <20240925113641.1297102-83-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 8f7152f10cb434f954aeff85ca1be9cd4d01912b ]

Prevent racing against other functions disabling the same worker

Link: https://patch.msgid.link/20240827093011.18621-17-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 8008ce3fa6c7e..387d47e9fcd38 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1537,12 +1537,14 @@ void mt7915_mac_reset_work(struct work_struct *work)
 		set_bit(MT76_RESET, &phy2->mt76->state);
 		cancel_delayed_work_sync(&phy2->mt76->mac_work);
 	}
+
+	mutex_lock(&dev->mt76.mutex);
+
 	mt76_worker_disable(&dev->mt76.tx_worker);
 	mt76_for_each_q_rx(&dev->mt76, i)
 		napi_disable(&dev->mt76.napi[i]);
 	napi_disable(&dev->mt76.tx_napi);
 
-	mutex_lock(&dev->mt76.mutex);
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
 		mtk_wed_device_stop(&dev->mt76.mmio.wed);
-- 
2.43.0


