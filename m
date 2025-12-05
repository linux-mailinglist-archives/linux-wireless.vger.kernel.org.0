Return-Path: <linux-wireless+bounces-29540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D98CA725B
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 11:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9FA30B6233
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 10:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB042312813;
	Fri,  5 Dec 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITxiKiLY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688B2FFDC1
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764930302; cv=none; b=FvhO9COvMwZHGeipIO87DMuIKoyDfnN14ekg8Vwz6WVbn4MKPjJq/N8ofJZ4OZbeax4pVIBs4Vxbi/2ZauG20u5UnyhemFRaJ2ymf9IJOaU2gNHB2QIaSX5cTklSKqnUSTj5kWFs7yRpa7g0hvYym0moX1+oVOu5AhMm3c3Hbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764930302; c=relaxed/simple;
	bh=j2sszEHvbo+AG1hndOWuS1qSVFTizaaquasEEngVdcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEXuclHrgCOCsLX3NUv1U+6fUTwYglHe+1HYcXYUrWCM02no4TvGjuW3OBy9ktfkX6GT7dctP/KtZv1mGQ3a28AmZScyovNPxO12qGsPsw+xIEIY18PY0s5H7SOKk51hPb7OONNvLUWvS/yrHPaM1wfmwFgfaka+udxQfIUFXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITxiKiLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA726C116C6;
	Fri,  5 Dec 2025 10:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764930301;
	bh=j2sszEHvbo+AG1hndOWuS1qSVFTizaaquasEEngVdcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ITxiKiLYOPaF2czX9ZLml8Vf4qQz9RaNDooaySGr1VYW4790XsvtmbXg+QbMMEdZX
	 4I3BBQJzalOlbWt3WU5DEZn7OC2DC117A83CzY0i++9mDiSl8j72gOtm0aQpl0rW9I
	 NevtwxuxQSH3hYF+J1V6BIWaEaHiv9vstB8hmSuo/RygINeU+TVYXwDbhl+7Q+J+0M
	 shdh3coqrTZucjdC9GuoXC63b7oB18EfNTSsuJInND7JGsTdYIsMnzDU9Qm3qQcYA5
	 H00HhpS2mU/VlJLyre0VKoCk8hW+Brdxfe0+HyMT15xg60JpCfnGz/2XH7wmE/OkmP
	 zO0s4zWJQqWUw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 05 Dec 2025 11:24:37 +0100
Subject: [PATCH mt76 v2 2/4] wifi: mt76: mt7996: Reset mtxq->idx if primary
 link is removed in mt7996_vif_link_remove()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-mt76-txq-wicd-fix-v2-2-f19ba48af7c1@kernel.org>
References: <20251205-mt76-txq-wicd-fix-v2-0-f19ba48af7c1@kernel.org>
In-Reply-To: <20251205-mt76-txq-wicd-fix-v2-0-f19ba48af7c1@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Reset WCID index in mt76_txq struct if primary link is removed in
mt7996_vif_link_remove routine.

Fixes: a3316d2fc669f ("wifi: mt76: mt7996: set vif default link_id adding/removing vif links")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 0ad0152478a7e1b11bfe5d68d750cb8332d54290..8bf85a9beee7dc8c6741568af5b36cf89f0c1a88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -409,12 +409,23 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		struct ieee80211_bss_conf *iter;
 		unsigned int link_id;
 
+		/* Primary link will be removed, look for a new one */
 		mvif->mt76.deflink_id = IEEE80211_LINK_UNSPECIFIED;
 		for_each_vif_active_link(vif, iter, link_id) {
-			if (link_id != IEEE80211_LINK_UNSPECIFIED) {
-				mvif->mt76.deflink_id = link_id;
-				break;
+			struct mt7996_vif_link *link;
+
+			link = mt7996_vif_link(dev, vif, link_id);
+			if (!link)
+				continue;
+
+			if (vif->txq) {
+				struct mt76_txq *mtxq;
+
+				mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+				mtxq->wcid = link->msta_link.wcid.idx;
 			}
+			mvif->mt76.deflink_id = link_id;
+			break;
 		}
 	}
 

-- 
2.52.0


