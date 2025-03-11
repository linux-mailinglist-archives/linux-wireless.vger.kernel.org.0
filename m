Return-Path: <linux-wireless+bounces-20181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09988A5CC84
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 18:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2233B7D62
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8A262817;
	Tue, 11 Mar 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFtkSaTp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC526159F
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715118; cv=none; b=U4udMMGwa8GwUNXrK6SFpu6Z+joKMaRux25vOmLWUBqjJ4hhrkw9SxNw/2zDAQZoixAge4/W3S6qyN0artxyO5oetg2YpGAihzSu83hlsM+xaXl7m1lAASSLa55VA6DuGbTsjdv6KG/FcbGGxwUjXICPGsxy2Wc5qSJMaqSDXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715118; c=relaxed/simple;
	bh=iTxm09vzIwOGZsrbO6SwdKjRP6DnRsKoA/tAzDLV3+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FnsF4ec4gHF4yU93UYBpKnzkIWpu7VMiiom9G6RNIiiHx0my/dVppI82yGVimjZzo06eXujlsZoYvU3IDMSAPjbhEPorGcXSzlkfc7WUQrueTOu1Zl+eFhBpBZc52NTMTLhh/8LQFkrpMA31QU6rCN+1XgggYjfkmyt6PoqcJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFtkSaTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0F1C4CEEC;
	Tue, 11 Mar 2025 17:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715118;
	bh=iTxm09vzIwOGZsrbO6SwdKjRP6DnRsKoA/tAzDLV3+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EFtkSaTpBXdx2hNabFoaSSPMyDP1I4bHIRE5td75prZ7aWgciiuT4ds//BbtMGCuH
	 0EBrXqY/QER9KqQMYoaVRg9RZaZdmVTPvbUU36uTez+P8zwuXYiyOJEj7ra/gMwrgk
	 zcmFKyQRfckF2SPGNGFylAANHJ1wPqidaOEa/9lp/hzVxvgxuDYyf14HPECH4c3QoF
	 8hs9Q1ZsfLDxse7DnhWIN4XNTkePpXcgzZfpk+kaU7ADQ75I+TIjLmv6TQ+uGsa8i1
	 zqvcTi+6XYXPNRBf/zaWiERjfGMGN2D8EnyTBGh38NicLoI19EXnvAE5iXEWYyNOPM
	 egOu5AQqnSChw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 18:45:00 +0100
Subject: [PATCH v2 01/13] wifi: mt76: mt7996: Add chage_vif_links stub
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mt7996-mlo-v2-1-31df6972519b@kernel.org>
References: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
In-Reply-To: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

chage_vif_links callback is required by mac80211.
This is a preliminary patch to introduce MLO support for MT7996 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index b01cc7ef47999793f4815e4f3c6650c573f8cb28..c0e7ab9bcae5fcd503c10e1a02508977b6921d17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1650,6 +1650,14 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 
 #endif
 
+static int
+mt7996_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			u16 old_links, u16 new_links,
+			struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
+{
+	return 0;
+}
+
 const struct ieee80211_ops mt7996_ops = {
 	.add_chanctx = mt76_add_chanctx,
 	.remove_chanctx = mt76_remove_chanctx,
@@ -1705,4 +1713,5 @@ const struct ieee80211_ops mt7996_ops = {
 	.net_fill_forward_path = mt7996_net_fill_forward_path,
 	.net_setup_tc = mt76_wed_net_setup_tc,
 #endif
+	.change_vif_links = mt7996_change_vif_links,
 };

-- 
2.48.1


