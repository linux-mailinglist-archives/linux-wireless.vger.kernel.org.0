Return-Path: <linux-wireless+bounces-26922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B62B3F604
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 08:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5958B4E36CB
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34732E54A8;
	Tue,  2 Sep 2025 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyBUYRot"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED58279787
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796128; cv=none; b=hHlpkWoi9xLjx3Bl7PYsS6xRMk1urwNfVfl7sAdWwR+JOrlwbrGcrQaxUi2sA5+FFGnTXr8issrKR0agfwVyJgDFunuccsVCjJ5kxlOdbHZn5aTJjK2kguQvi4L/FOswe/8v6PNuuW8F8zK8LdhJzE/uapWdXLy9h/zEtknJLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796128; c=relaxed/simple;
	bh=Q0svYiUz24i1uAu8o1H7UT5McD0Sxs7M3FJhmIbgAjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NxIt7NWqdnLD1EYzDUssFVeKx+Yn2f7a8F7NP5OZETlXDmG0gB0k15Ro5OqPWJQ3xkJd0clSO1iDWl3InHDls+Cpf3vWacdgDMwDJN8KSlEzveji6/nlRtHR8205U3APzCPqqOy05ftnBqOCeNZtmeM9uFv180g3c5jDd88uRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyBUYRot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C115EC4CEED;
	Tue,  2 Sep 2025 06:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756796128;
	bh=Q0svYiUz24i1uAu8o1H7UT5McD0Sxs7M3FJhmIbgAjg=;
	h=From:Date:Subject:To:Cc:From;
	b=fyBUYRotO0ds+7TGd9jowdfMUE4JQgrKn8sBUg2RLotujQn+TC/95Xg1f1ncAzWsb
	 84NFn9EvEBzit/FNREiWZRmwuuVyuw7Y5CKPRJoYfTsy2k3qeSh8Gl28OqQZfxgsrv
	 MJtD+dkSvBsRZ3gcfqAw3mtXrxwh9ByiRoin2So6eV/sUbrT1rJ1+u3oWVShb4Kk+l
	 CvWSxLzEfUefAsTYKyZoO9Li3LepLzqgKitCrufiWcciDpmLMhA+zrIQ3TN+WwDp5v
	 q6eqD/CpokcspvpzS6VY3Dj32Vt7eqZgCu79HsPK0MNRXoDUd/isq+SWhdsr9pWVjQ
	 H9P7wz8rBDQVQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 02 Sep 2025 08:55:12 +0200
Subject: [PATCH mt76] wifi: mt76: mt7996: Use proper link info in
 mt7996_mcu_add_group
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-mt7996_mcu_add_group-fix-v1-1-312e14794dee@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM+UtmgC/x2MWwqAIBAArxL7naBBml0lQjQ3248eaEUg3T3pc
 wZmMiSMhAn6KkPEmxLtWwFRVzAtdgvIyBeGhjct11yw9VRaS7NOl7HemxD362AzPUyiU27uhNR
 cQcmPiEX/62F83w+50VTXagAAAA==
X-Change-ID: 20250901-mt7996_mcu_add_group-fix-6eb7bf816907
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Do not always use default link in mt7996_mcu_add_group routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 01bdd0ecfcfe88d461d07e5cfeccd78a7d3e6a1b..dbd95d096c06bdf0305b41a140c788243ae35cf7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2325,13 +2325,10 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct mt7996_sta *msta,
 }
 
 static int
-mt7996_mcu_add_group(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-		     struct ieee80211_sta *sta)
+mt7996_mcu_add_group(struct mt7996_dev *dev, struct mt7996_vif_link *link,
+		     struct mt76_wcid *wcid)
 {
 #define MT_STA_BSS_GROUP		1
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_sta_link *msta_link;
-	struct mt7996_sta *msta;
 	struct {
 		u8 __rsv1[4];
 
@@ -2346,13 +2343,10 @@ mt7996_mcu_add_group(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		.tag = cpu_to_le16(UNI_VOW_DRR_CTRL),
 		.len = cpu_to_le16(sizeof(req) - 4),
 		.action = cpu_to_le32(MT_STA_BSS_GROUP),
-		.val = cpu_to_le32(mvif->deflink.mt76.idx % 16),
+		.val = cpu_to_le32(link->mt76.idx % 16),
+		.wlan_idx = cpu_to_le16(wcid->idx),
 	};
 
-	msta = sta ? (struct mt7996_sta *)sta->drv_priv : NULL;
-	msta_link = msta ? &msta->deflink : &mvif->deflink.msta_link;
-	req.wlan_idx = cpu_to_le16(msta_link->wcid.idx);
-
 	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(VOW), &req,
 				 sizeof(req), true);
 }
@@ -2492,7 +2486,7 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev,
 		}
 	}
 
-	ret = mt7996_mcu_add_group(dev, link_conf->vif, sta);
+	ret = mt7996_mcu_add_group(dev, link, wcid);
 	if (ret) {
 		dev_kfree_skb(skb);
 		return ret;

---
base-commit: fdac540331e118584c5b0acf4991af37ebf0e5f4
change-id: 20250901-mt7996_mcu_add_group-fix-6eb7bf816907

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


