Return-Path: <linux-wireless+bounces-26063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C00B16FB9
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 12:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A8D1890386
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 10:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B22264AC;
	Thu, 31 Jul 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdr8R5tE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3F18D643
	for <linux-wireless@vger.kernel.org>; Thu, 31 Jul 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958508; cv=none; b=rIjDSlaALEEuARQfFxbuCSqTB9SJxOk9GiLkgn53Cu1jhn+iZfriC4REyzHqM6+fazwZDiFo/DfIz7iPm/u0aVpseYfNrVGPy+OyT9vULpX7JMg/9FB5TuOfOefIWBowvaIkt3FtvgnNG2BDxiE28JHj394+5PTCC0+xjKFC6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958508; c=relaxed/simple;
	bh=HFn2Sm81XBekacLQ3GbYvA+Glq8BpVBTyLYcvCAYhrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJdi6blfQcaFFX9GGPZEIDNuk3Y/llIcfw9J6ZKogFB93NvZ72UrXQfnBu4K0nVSklSRnle7X/FQmUM60jB/pv1ftnpnG4S99U4zbe0ofYUsyRc9QzjYvJNhXtEEdKNC8OSDL0n6xjOSCwx6Y5b4lrTF2pPjsuqbfYA2CZhAsoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdr8R5tE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DF0C4CEEF;
	Thu, 31 Jul 2025 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753958507;
	bh=HFn2Sm81XBekacLQ3GbYvA+Glq8BpVBTyLYcvCAYhrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bdr8R5tEKDmuFNmF6HYOGgw4+yuzT2Uu2fBTlw1YsCnoUUCotoTsI01Y9ECpM4DSI
	 cGatC76GXqbhAWU6HKVl61iK8Z59W2pNV3vzkPBw4uyxTbcYU7fCei1Q78cYacYvDn
	 x+22CVd7ufVkpk0MFy2MjbPSw3DevJPB7n1F4CbWYIwjAzesH8RXSxXsB9HFpM8DUU
	 0zW1yWqdurzED9Mj4WjdL+ZOmdLNi5Ck1QAaG5LTYMR4U6WcVzgRRnO7UkUAEm55Un
	 kFvAOlvaVBND6kt/2q8iQMVsST1vnpAVBIXRFBqe86tTs4vOu1yJxTIEIkJIsfUqIn
	 BUBAtzsqBB4zA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 31 Jul 2025 12:41:23 +0200
Subject: [PATCH mt76 1/2] wifi: mt76: mt7996: Set def_wcid pointer in
 mt7996_mac_sta_init_link()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-mt7996-mlo-devel-v1-1-7ff4094285d0@kernel.org>
References: <20250731-mt7996-mlo-devel-v1-0-7ff4094285d0@kernel.org>
In-Reply-To: <20250731-mt7996-mlo-devel-v1-0-7ff4094285d0@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In order to get the ieee80211_sta pointer from wcid struct for a MLO
client, set def_wcid pointer in mt7996_mac_sta_init_link routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index ed82197d8ffb74ed272b295351708b249cc543cd..662ce4bb5178a4b8765b2b337ea6baea649d3ef2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -962,6 +962,7 @@ mt7996_mac_sta_init_link(struct mt7996_dev *dev,
 	msta_link->wcid.sta = 1;
 	msta_link->wcid.idx = idx;
 	msta_link->wcid.link_id = link_id;
+	msta_link->wcid.def_wcid = &msta->deflink.wcid;
 
 	ewma_avg_signal_init(&msta_link->avg_ack_signal);
 	ewma_signal_init(&msta_link->wcid.rssi);

-- 
2.50.1


