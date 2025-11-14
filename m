Return-Path: <linux-wireless+bounces-28986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22946C5D4F6
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 14:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7647D3583E3
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13613126A5;
	Fri, 14 Nov 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIyuHu2a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7451CDFD5
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126199; cv=none; b=ebUpsfCu5czgKSpywvSl0FPACQy32KRkdfnAMinMdjcG8IXsFClN/oK/QIPIhNgNEasBXGnxo1fCUR3qXbNR5o9e2RPqSL7GaoJ++wtq7hO5VDDGQ923981xt96nmZMASRwUxvq9lStpF3C/H9YQnmRVOrx3EwiQbqJZAXPfqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126199; c=relaxed/simple;
	bh=bmUiXuKzR7Y7ZVMjQ0u1D5PLzI5X7SgiDua+J81vZZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FyYySViCJxEDimHiJEW1ZQVp/+Rg7L0VGArRdCDYHDJ51vpfMOVZSTmB+VlfQonkXsnZCpFecOVBIk6B+ANBsuk1x/CnJE53c8popPjA8GQNzlmSXOPJ7/0+UoaSOeRKHr2xJnbG9DIzaLxMbmq6YSX52bpsRfhcmhGg9WrTyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIyuHu2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A88DC4CEF5;
	Fri, 14 Nov 2025 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763126199;
	bh=bmUiXuKzR7Y7ZVMjQ0u1D5PLzI5X7SgiDua+J81vZZI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gIyuHu2aYJ/CG6mvi5iolCCXB2MSeOV7a6AsmJ/gA3MPoyiYt0oiC9nvD+BxvpsDA
	 cOZUSTW47PJ79O//i4esT43PWeaIUdW0HCm9ta1YngSx+UGGv+3tEKxFaLrgv/5Qqp
	 YjZ9n9bDKKlBwIEl54tLVnUSU4w2JKQ/aeqmlZW05g9QctPl0WksOzQmoKL2n39zY1
	 tAkotNTU4i0uy+gGA+n7sfN7iUk+6alWdr70wbUTM1voIwoCp2GFG3jZ2os+3r7SRF
	 g9sl8W9HATM93TS4U6+lBIjwJlYPhBGT3UF8qjd8fawz8X6HD9q5AKp6onc8YDUOMb
	 b/Kwn7h6lIsqQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 14 Nov 2025 14:16:22 +0100
Subject: [PATCH mt76 2/4] wifi: mt76: mt7996: Move mt7996_update_beacons
 inside mt76 mutex critical section
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mt76-fix-missing-mtx-v1-2-259ebf11f654@kernel.org>
References: <20251114-mt76-fix-missing-mtx-v1-0-259ebf11f654@kernel.org>
In-Reply-To: <20251114-mt76-fix-missing-mtx-v1-0-259ebf11f654@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Move mt7996_update_beacons routine inside mt76 mutex critical section
in mt7996_mac_reset_work() in order to run mt7996_vif_conf_link() in
mt7996_mcu_add_beacon routine.

Fixes: f30906c55a400 ("wifi: mt76: mt7996: disable beacons when going offchannel")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 9501def3e0e3e20132fdbcfe0b1f489694afdc5f..1fac3815c523c05643705b9b6b7263a7fdf2e3a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2599,11 +2599,10 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	local_bh_enable();
 
 	ieee80211_wake_queues(hw);
+	mt7996_update_beacons(dev);
 
 	mutex_unlock(&dev->mt76.mutex);
 
-	mt7996_update_beacons(dev);
-
 	mt7996_for_each_phy(dev, phy)
 		ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 					     MT7996_WATCHDOG_TIME);

-- 
2.51.1


