Return-Path: <linux-wireless+bounces-20239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79802A5DB32
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C5A1891277
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504F623E35D;
	Wed, 12 Mar 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJ7a7Ju8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40522E011
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778075; cv=none; b=fR3luzIT91UnlFPdGc40Kwtg2wIrqm4IJ1MmoEWYf8I0pncpsh7ElABcXfK0irhURYPPBrJKXp51j+jjftO2MrVCc8GW4wkPD44PK1O3EO1QS4GInqTTU1Mzu6wuAQwiUsc3MRQ5z1b2jUR3baiQRLxTBSrQbbSVVWt/zqiLERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778075; c=relaxed/simple;
	bh=WWKbKXXhJy/OKwXLv2qGhKk5Lfwrc9oYu3E9rs+ztZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/BsK9IDliIW24HV+Oq9fDMoNVn4gjPySUmlv7eS6eEbH7qTq1lZWDGymGKgJ4AcZpz1D53Szgu/vROk7JmbzhwQ/6wz1PHsCcc15mFs3mVrQ3QdTXkDgLk+EBzLmMsIaapsSB/lnIGnno9TBXz3eQoODhJ1UV4JP/GwADvxX54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJ7a7Ju8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5B5C4CEE3;
	Wed, 12 Mar 2025 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778074;
	bh=WWKbKXXhJy/OKwXLv2qGhKk5Lfwrc9oYu3E9rs+ztZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qJ7a7Ju84qjP7w8QPDH0rMbRtx3oxjSBvDnts4zwcLD4cCGpVSZsf1iiJzh3137u0
	 96OlQ3+Io1gm3tjou8mheY5D9JqkdKvxhL5ibV+z+YzeSf6SOARvzYnQAO32q2PZY0
	 CsU+p6Vd6D2SfLjq3VQxiCwKLoTRYp7sUDmj1yqRlpjkxFLhmAw+x0eHMsR6aaucq/
	 PnfcYI26hW2oR5k2E1MO9xibDYvpp38uTm7hzDYrtbAkQQ4B7GhyjNjPE2NEKD6fzi
	 7E0TLnoHVY/fc0AyE7Vin4gZmmWaAFR5UTFwGyMTHhqTBRcaiK8K4IiUJkkcUcqbuh
	 LrdbKefZ72PAw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:13:57 +0100
Subject: [PATCH 13/21] wifi: mt76: mt7996: rework mt7996_mac_sta_poll to
 support MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-13-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Rework mt7996_mac_sta_poll routine in order to support multi-link
setup.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index c56b1126abd59da5895d94fb368004adf6ffbbc8..6870ee189dca61a989d4b7cfde741588c8f18482 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -123,10 +123,12 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		[IEEE80211_AC_VO] = 6
 	};
 	struct mt7996_sta_link *msta_link;
+	struct mt76_vif_link *mlink;
 	struct ieee80211_sta *sta;
 	struct mt7996_sta *msta;
 	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
 	LIST_HEAD(sta_poll_list);
+	struct mt76_wcid *wcid;
 	int i;
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
@@ -150,10 +152,11 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 					     struct mt7996_sta_link,
 					     wcid.poll_list);
 		msta = msta_link->sta;
-		list_del_init(&msta_link->wcid.poll_list);
+		wcid = &msta_link->wcid;
+		list_del_init(&wcid->poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-		idx = msta_link->wcid.idx;
+		idx = wcid->idx;
 
 		/* refresh peer's airtime reporting */
 		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 20);
@@ -181,7 +184,7 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 			       sizeof(msta_link->airtime_ac));
 		}
 
-		if (!msta_link->wcid.sta)
+		if (!wcid->sta)
 			continue;
 
 		sta = container_of((void *)msta, struct ieee80211_sta,
@@ -207,8 +210,15 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
 		rssi[3] = to_rssi(GENMASK(31, 14), val);
 
-		msta_link->ack_signal =
-			mt76_rx_signal(msta->vif->deflink.phy->mt76->antenna_mask, rssi);
+		mlink = rcu_dereference(msta->vif->mt76.link[wcid->link_id]);
+		if (mlink) {
+			struct mt76_phy *mphy = mt76_vif_link_phy(mlink);
+
+			if (mphy)
+				msta_link->ack_signal =
+					mt76_rx_signal(mphy->antenna_mask,
+						       rssi);
+		}
 
 		ewma_avg_signal_add(&msta_link->avg_ack_signal,
 				    -msta_link->ack_signal);

-- 
2.48.1


