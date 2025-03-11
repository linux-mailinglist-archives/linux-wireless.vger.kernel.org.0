Return-Path: <linux-wireless+bounces-20192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD86DA5CC99
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 18:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF31E179CE9
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B1C263C9E;
	Tue, 11 Mar 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSU4XMYk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CE263888
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715148; cv=none; b=SA5ccEkc2sfovLuZh2or0RSSmK/nsqxkygVuv6bBGPMEI5Qx3afgtmNW21jpvhQVObvTMbk11qx24KqOIunsleyub9UiBT5OMSqytb22KQXUv7Kya7pe/phcDRPXLiAG8aeFQWPmaHnt7kn+ub/ZBaOXc6ack6omvFpAI7xyEiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715148; c=relaxed/simple;
	bh=+9H/cY7XevfmBl9ExA/WUMon0lUnrmWb3xP9M+8TCyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUC4z2A+Q1Jhsp17XovxBJBA+aIFe0tTX3xHCWa4rpE/BEador2UJX1AlM00/g+79o/nXhDL9tx6cxqWNspnVUuNVw7KfXoJltmRwFKnw+ozHWQUUkynnVse5MBsTfDIzZznrSdYa1PRdZiE7GHh8fmzcQU7LhD4UESPQhFLIaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSU4XMYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C33C4CEE9;
	Tue, 11 Mar 2025 17:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715148;
	bh=+9H/cY7XevfmBl9ExA/WUMon0lUnrmWb3xP9M+8TCyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CSU4XMYkyAMLesDJHX/NI6iGOV6eDoUKWQC1hccMOd+ARFpc4od8rVylCk2UWRn4T
	 76xmYC/iKDWULGlI6lQpJGJv3/1adR7tAbyN/9UUgwKphXiy38OVQdj9XxCk65iBKt
	 OZ0uvJDGPRmn9GYuODYjOIhqQkSfNBkhkUYFmSFa/PUCKzs4iW1HBCRyyuw6nKYSDU
	 NFzzO/o/zc8cNH5ITZPeNEHsVsaOSo4/WuwwhDPCkd0jHWIufwXHC75BLnsAN1Tr3f
	 vw5p90rWA87DRHFwdoY11+GF6G7XrhgKuFlNooY9IzTKWkLLEHAll4bkhO60TMnxxH
	 Fl0zj165K9UyA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 18:45:11 +0100
Subject: [PATCH v2 12/13] wifi: mt76: mt7996: Rely on mt7996_vif_link in
 mt7996_mcu_twt_agrt_update signature
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mt7996-mlo-v2-12-31df6972519b@kernel.org>
References: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
In-Reply-To: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>
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
index 456666eb7080c50493dcde61c5399adc6a987d2d..4a7f6fd9025297f0ffa8ea7e91efd34164a26196 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2672,7 +2672,8 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	}
 	flow->tsf = le64_to_cpu(twt_agrt->twt);
 
-	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow, MCU_TWT_AGRT_ADD))
+	if (mt7996_mcu_twt_agrt_update(dev, &msta->vif->deflink, flow,
+				       MCU_TWT_AGRT_ADD))
 		goto unlock;
 
 	setup_cmd = TWT_SETUP_CMD_ACCEPT;
@@ -2705,7 +2706,7 @@ void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
 		return;
 
 	flow = &msta_link->twt.flow[flowid];
-	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow,
+	if (mt7996_mcu_twt_agrt_update(dev, &msta->vif->deflink, flow,
 				       MCU_TWT_AGRT_DELETE))
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 43e85308132e5ed80d8199858014b31a29b2e3b5..e6ebb309a8257637c122702df2f2924649b7fabe 100644
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
index 0dd9d798541f95f82bf8606512052eca79115f5c..962022c7eec9fd82ebba8e0d5aa6b6eae769ee32 100644
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


