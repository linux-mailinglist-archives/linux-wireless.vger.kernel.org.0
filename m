Return-Path: <linux-wireless+bounces-28988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10204C5D4FF
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 14:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0EC335BB67
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 13:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB83054F5;
	Fri, 14 Nov 2025 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNencgI8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10C21C16E
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126205; cv=none; b=A4Ue8tP8F982dQdwVJCnDNSD0nH6HWCoC03dnPL8zaypuJ0bNEojZFTca8a7xorUx9JkHTW1wxwWiF+GKniBMO7wCbqlcolN0yIhU1sFGEjh1th0WtOTIUZbMuG4uTxk5hSWZAzpg4D4IVlTIfdHCSECbcarcE1oLPWluSwWcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126205; c=relaxed/simple;
	bh=KVj9k68RnOszWxHXFLkpcOlslWuXtZE1P1GLidHf8pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BnzGVdw3R9ZGC5dUTKBpUHZrG4bjkbLZ1lWDpCNIFUBeczHzcVESw2qJBL6hdymdFnh6O8PAFniA5XWwv4tlqrCNbNaOVfP8h5s75EozZbhUvQ2Rue8ViE3Wp3oKuNMI51//2MHGnLD3J6jwVncl4F8Yp0Dsb+siaq2bg786SNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNencgI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D66C4CEF5;
	Fri, 14 Nov 2025 13:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763126205;
	bh=KVj9k68RnOszWxHXFLkpcOlslWuXtZE1P1GLidHf8pk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tNencgI87mkyu5kZ95NRa6CKYE9aZPGibKUdJkWRA7eia+3BRPKjd3QpRvaO8TLYA
	 Q7sz0zXojoMsc6MjNrV+DMjqDSZdlFDPFFyJP4RoRfwgawI8QpWgs7+fx5YWji7GZn
	 29eqvO5CDsCHRwI7qYYeKAUYFKhmCyCEr55JBQVbgAaHXbikv33R0zFSibuN6dh+Wa
	 lhCANCPbPD5e9NsQx1nEQWqtqOKqKCzUcTS50h1Ef9EIIOV/5qxcHuMgcmJ6vEmziU
	 0aMfsA67D8GYS0/wA5sdEPGeQiODmXouLkO78iHA9tQQ6+JRq1QBW4oFWyb2QFNdQo
	 oRiMNCH2fdfmw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 14 Nov 2025 14:16:24 +0100
Subject: [PATCH mt76 4/4] wifi: mt76: mt7996: skip deflink accounting for
 offchannel links
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mt76-fix-missing-mtx-v1-4-259ebf11f654@kernel.org>
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

Do not take into account offchannel links for deflink accounting.

Fixes: a3316d2fc669f ("wifi: mt76: mt7996: set vif default link_id adding/removing vif links")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index ad8698cf16242489b92e23befab4d040abbdcac2..d3cd2fed31cd55f1a949ae3f2e3ed5f488514b1d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -376,7 +376,8 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
 
-	if (mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED)
+	if (!mlink->wcid->offchannel &&
+	    mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED)
 		mvif->mt76.deflink_id = link_conf->link_id;
 
 	return 0;
@@ -407,7 +408,8 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	if (mvif->mt76.deflink_id == link_conf->link_id) {
+	if (!mlink->wcid->offchannel &&
+	    mvif->mt76.deflink_id == link_conf->link_id) {
 		struct ieee80211_bss_conf *iter;
 		unsigned int link_id;
 

-- 
2.51.1


