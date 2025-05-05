Return-Path: <linux-wireless+bounces-22485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C250AAA06B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1A81A834C7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F06B29009F;
	Mon,  5 May 2025 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+8LdaL0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66445290097;
	Mon,  5 May 2025 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483427; cv=none; b=OO9ocpzuRU6s/SSC3e2yDboVs18z/w6ulN7/zSkhwPrtiV9Ny6ORMx3DbGUQZ9JEEsXQcb9+hgFjwYKkWB5s+JVmL/pMiTanc/tFu3ea7bpPFU6Di3pTBpuaVs+GlZ2Z6IsLcWILztP6+lypRfl3/Bfi3qIlX4Qh/Xhia6JREM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483427; c=relaxed/simple;
	bh=/b3J7JjYOwlDGnUX53TNs6feQxn0vwXryA22VULuaAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hd29N8MQX7oyeCs3IAGaaBHDIpNuA6yAaUfPOiFFKyd0vyydU0c5gld71Vd/IuWwM76Vlxzc67hCMoWg4TWTfrvfTBKNo6u6j8V37AVWfQTHTyo9SErJCmGBG47nXntEBpTWifgu06uuFmC1p7dDL18SgTUSLvkcBAoz19iosgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+8LdaL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0DDC4CEE4;
	Mon,  5 May 2025 22:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483427;
	bh=/b3J7JjYOwlDGnUX53TNs6feQxn0vwXryA22VULuaAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+8LdaL0zlSrtyPxyWKO9f+UWS5oOvoccOqbb7m82jkVMfNc6rrJwVP0rf5Qzl0Rn
	 QW6+mi0c43TdWGGQgoCUISeQXLlxl4nAKOW+q6V6/4pdAhbWo2OfSnCBvhF/sYyTge
	 GM3ZT5udxDgpKj+ZcYDsXU6/KR86EKmNxNKye9UrN8/Rv8PA0s+PfL5mfVVZFOdWoA
	 +d7ZEi7Wjz/f9KDIPbsDV6tGw41XVYISABjr5BtJE6+IRmMQbbGkPLTBbUT9uoKkgo
	 AyK6PeZy3i+51czHoioaoNRd5g8/vm6VfLxnLWrmxwUsyTErrJtre3qNTnFopXSGjn
	 grcIixCbve6JA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 077/642] wifi: mt76: scan: set vif offchannel link for scanning/roc
Date: Mon,  5 May 2025 18:04:53 -0400
Message-Id: <20250505221419.2672473-77-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 3ba20af886d1f604dceeb4d4c8ff872e2c4e885e ]

The driver needs to know what vif link to use

Link: https://patch.msgid.link/20250311103646.43346-4-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/channel.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt76.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index 6a35c6ebd823e..e7b839e742903 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -293,6 +293,7 @@ struct mt76_vif_link *mt76_get_vif_phy_link(struct mt76_phy *phy,
 		kfree(mlink);
 		return ERR_PTR(ret);
 	}
+	rcu_assign_pointer(mvif->offchannel_link, mlink);
 
 	return mlink;
 }
@@ -301,10 +302,12 @@ void mt76_put_vif_phy_link(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			   struct mt76_vif_link *mlink)
 {
 	struct mt76_dev *dev = phy->dev;
+	struct mt76_vif_data *mvif = mlink->mvif;
 
 	if (IS_ERR_OR_NULL(mlink) || !mlink->offchannel)
 		return;
 
+	rcu_assign_pointer(mvif->offchannel_link, NULL);
 	dev->drv->vif_link_remove(phy, vif, &vif->bss_conf, mlink);
 	kfree(mlink);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8714418f3906c..e4ecd9cde36dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -351,6 +351,7 @@ struct mt76_wcid {
 	u8 hw_key_idx;
 	u8 hw_key_idx2;
 
+	u8 offchannel:1;
 	u8 sta:1;
 	u8 sta_disabled:1;
 	u8 amsdu:1;
@@ -788,6 +789,7 @@ struct mt76_vif_link {
 
 struct mt76_vif_data {
 	struct mt76_vif_link __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct mt76_vif_link __rcu *offchannel_link;
 
 	struct mt76_phy *roc_phy;
 	u16 valid_links;
-- 
2.39.5


