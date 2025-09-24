Return-Path: <linux-wireless+bounces-27634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87127B9A1BF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 15:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91131B22E05
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981CC18E377;
	Wed, 24 Sep 2025 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgPWaB6B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6B2AE89
	for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721914; cv=none; b=QqiYAgvuoBgkk/s52OmPQXVK2dGv/fnO3nDiC99NH5cP/je1mMf9ih/4FXzHyqOG70WtFBgKR6bwJAPWg+VqZRXPUXu8rJU4LzUtg+Dq/OpSqEnsim5KiONXgZbabU1nr+lSVhUcwd51aBbex6cCnZaiJDXlfdzrBaoebBIYZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721914; c=relaxed/simple;
	bh=2PnF1NHzsZDLHuBnT3GhZhqpwSuMX60FWYPhgeGiYFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OYfonii6IBL1waHA9x4ZXs5s81DnmK+3GkkjQqJvun0M2DbMuuSEIcR/XAWiu6YfvKFJKHvHewgQdTSK2CX3feS7Slf6JwuAZJ8/recgtzN68ORKEJo3N7hwtjrdOCGGIt1GmO1e3ih/953ZnXmpQueNyWeWg8+O3E69CPcorTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgPWaB6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9225EC4CEF0;
	Wed, 24 Sep 2025 13:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758721913;
	bh=2PnF1NHzsZDLHuBnT3GhZhqpwSuMX60FWYPhgeGiYFQ=;
	h=From:Date:Subject:To:Cc:From;
	b=YgPWaB6BDJHLlfanRAGbzN3J6C6T9B3uugL/OopTDyaIjfrDi/0Uzt2ZVM7g70uDv
	 utEdyEfV2sk64BBabYiEFcj5zIFFRD/jYbsZ6b5VbckBtWtUDI86418DfyINGk7acG
	 fr7zsOK4w/lHbPcbAECs7AFArAj91iaY+9vmkf3DkYNxMca6cV1H3hIlJRwQufQbsn
	 ieb6KgQ8bkLc5GlloXs/NdOuEJOXJU8k/cOLWgldGGUkrDot0kSNnEv3oJ6mLEplED
	 3r14dmxjCUxO7n8xG02Unav5tyiOfSrXM87po017zdD3hReY9VovJq7gVfrxbWem8w
	 Qt2aofMIjzFyw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 24 Sep 2025 15:51:39 +0200
Subject: [PATCH mt76] wifi: mt76: mt7996: Remove unnecessary link_id checks
 in mt7996_tx
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-mt76_tx_unnecessary-check-v1-1-e595930a5662@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGr302gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMT3dwSc7P4kor40ry81OTU4uLEokrd5IzU5GxdyyQjIDSxMEu1SFE
 C6i8oSk3LrACbHR1bWwsA4lXlFGsAAAA=
X-Change-ID: 20250924-mt76_tx_unnecessary-check-9b2b2b486e8d
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Remove unnecessary link_id checks in mt7996_tx routine since if the link
identifier provided by mac80211 is unspecified the value will be
overwritten at the beginning on the function.

Fixes: f940c9b7aef6 ("wifi: mt76: mt7996: Set proper link destination address in mt7996_tx()")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 581314368c5ba566f6050bee86696c4654619176..de044c16e630c888b181778b4b450c2c75a76939 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1339,12 +1339,10 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 	}
 
 	if (mvif) {
-		struct mt76_vif_link *mlink = &mvif->deflink.mt76;
+		struct mt76_vif_link *mlink;
 
-		if (link_id < IEEE80211_LINK_UNSPECIFIED)
-			mlink = rcu_dereference(mvif->mt76.link[link_id]);
-
-		if (mlink->wcid)
+		mlink = rcu_dereference(mvif->mt76.link[link_id]);
+		if (mlink && mlink->wcid)
 			wcid = mlink->wcid;
 
 		if (mvif->mt76.roc_phy &&
@@ -1352,7 +1350,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 			mphy = mvif->mt76.roc_phy;
 			if (mphy->roc_link)
 				wcid = mphy->roc_link->wcid;
-		} else {
+		} else if (mlink) {
 			mphy = mt76_vif_link_phy(mlink);
 		}
 	}
@@ -1362,7 +1360,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 		goto unlock;
 	}
 
-	if (msta && link_id < IEEE80211_LINK_UNSPECIFIED) {
+	if (msta) {
 		struct mt7996_sta_link *msta_link;
 
 		msta_link = rcu_dereference(msta->link[link_id]);

---
base-commit: 1e06a137513dff9835e57f76cff177cb1e2e5475
change-id: 20250924-mt76_tx_unnecessary-check-9b2b2b486e8d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


