Return-Path: <linux-wireless+bounces-19213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2068A3DB33
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACD53BA522
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CCB1F8BC9;
	Thu, 20 Feb 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvUG9+bv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90ED1E766E
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057587; cv=none; b=ScgF7+5ZIT3T+ApYClFBUQS192xQLcmlFinffZhAxXjykqArAQq31CoYygvOVJq87xXtEe8LxZlOkS83ggVRqsDPhF7b6rbV56V4zCjNfr/VfWV+W2jXCg7/aU0X/RKzbu7XYoXfJ9fOu31i5MW9ObeEfxjLN10ge+0IL0/YCGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057587; c=relaxed/simple;
	bh=QKSzQlhaap4NAoryXxlW3RwuzGmB6dNpgI2ZolbeH9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rrM7ucO2e/4brwnoMfd39WeF61AjrS7ho63gKZJePtg2lWL6Vkm1n6kr5Mwl1K3hyk8yPY2+sRmft/y3mLoJji8JFgHTg80L1HNw0YbBqF1NzKBHthQl2TAACVvhvQREcP9rV9FjeLD9Gl15D6NRfPTbEaBfzdJLNeaCEioWxkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvUG9+bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7139CC4CED1;
	Thu, 20 Feb 2025 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057586;
	bh=QKSzQlhaap4NAoryXxlW3RwuzGmB6dNpgI2ZolbeH9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cvUG9+bvGqraYZX0xzmmwrHTNtaWHbsLpNhOd0okoa4i/YDP1jn1+6VTIiWymSKEP
	 6BZ26lDvyxpf4oVOnYh8q5yAttNaCh2OCv1hkXtqd+GhI5lcl/R+9rJe/LHa4K8nG4
	 W25b77WSwYP+n6MKmRs5KyDy3eSMfPHupdNOEZ6CMAvE7xSg85XSmU/GODiXH3hIIe
	 cqo7mHfBPrLZsyHdNFiUk7lkrNDzrH59VSXasjaT1N6ThT1snKrddtBmC9IgPoxZmC
	 +GiqeA10crVxL50W4DLlsrmp5wfN6Iy3R1TqDBtLDjXbcNiWzUefKikR6qC92MQbj7
	 btVz9tWm9RulA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 20 Feb 2025 14:18:59 +0100
Subject: [PATCH 13/14] wifi: mt76: mt7996: Rely on mt7996_vif_link in
 mt7996_mcu_twt_agrt_update signature
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mt7996-mlo-v1-13-34c4abb37158@kernel.org>
References: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
In-Reply-To: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

This is a preliminary patch to enable MLO for MT7996 driver

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 32b011e7945a603e06b543e0b302211ce83af1ec..0c862cd749b233ae1a6870c536792087109cd46c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2659,7 +2659,8 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	}
 	flow->tsf = le64_to_cpu(twt_agrt->twt);
 
-	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow, MCU_TWT_AGRT_ADD))
+	if (mt7996_mcu_twt_agrt_update(dev, &msta->vif->deflink, flow,
+				       MCU_TWT_AGRT_ADD))
 		goto unlock;
 
 	setup_cmd = TWT_SETUP_CMD_ACCEPT;
@@ -2692,7 +2693,7 @@ void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
 		return;
 
 	flow = &msta_link->twt.flow[flowid];
-	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow,
+	if (mt7996_mcu_twt_agrt_update(dev, &msta->vif->deflink, flow,
 				       MCU_TWT_AGRT_DELETE))
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index fea6f228a62268583d6cd1a711f05ab91a5815ed..a35ef2b295d2e3e95de60e7c5c45c54087d381d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4236,7 +4236,7 @@ int mt7996_mcu_update_bss_color(struct mt7996_dev *dev,
 #define TWT_AGRT_PROTECT	BIT(2)
 
 int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
-			       struct mt7996_vif *mvif,
+			       struct mt7996_vif_link *link,
 			       struct mt7996_twt_flow *flow,
 			       int cmd)
 {
@@ -4267,12 +4267,12 @@ int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
 		.len = cpu_to_le16(sizeof(req) - 4),
 		.tbl_idx = flow->table_id,
 		.cmd = cmd,
-		.own_mac_idx = mvif->deflink.mt76.omac_idx,
+		.own_mac_idx = link->mt76.omac_idx,
 		.flowid = flow->id,
 		.peer_id = cpu_to_le16(flow->wcid),
 		.duration = flow->duration,
-		.bss = mvif->deflink.mt76.idx,
-		.bss_idx = mvif->deflink.mt76.idx,
+		.bss = link->mt76.idx,
+		.bss_idx = link->mt76.idx,
 		.start_tsf = cpu_to_le64(flow->tsf),
 		.mantissa = flow->mantissa,
 		.exponent = flow->exp,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 43534681301b8f239337092013e49eec2fee2ce8..3a8e99b6f474af285838f90b1068380c93a862a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -563,7 +563,7 @@ int mt7996_run(struct mt7996_phy *phy);
 int mt7996_mcu_init(struct mt7996_dev *dev);
 int mt7996_mcu_init_firmware(struct mt7996_dev *dev);
 int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
-			       struct mt7996_vif *mvif,
+			       struct mt7996_vif_link *link,
 			       struct mt7996_twt_flow *flow,
 			       int cmd);
 int mt7996_mcu_add_dev_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,

-- 
2.48.1


