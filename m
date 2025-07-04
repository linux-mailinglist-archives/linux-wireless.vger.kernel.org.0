Return-Path: <linux-wireless+bounces-24826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F780AF93AC
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 15:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F574A1211
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB52F50B0;
	Fri,  4 Jul 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaE70Tj1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D052D9488
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634524; cv=none; b=FA5JJHAHfnSxmqZncutWUIAl8q85/RNpn26V8ma4ybJhRYM5mqtDWE5lJjJk5FDAsOwnp6iT+k2zFnrU+3ZuSezbL9H8d74nn1wO16/HyzU+VmDt+HQm6Dk6Mpausa8sRKTOQYtd2KAnsTKprYDDaGqC33ajnm84Shjbnu2WGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634524; c=relaxed/simple;
	bh=fQPKqzqJoG96BUl5U70JlrV6PqD4K4Oa2dVm9yr0HrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6S8parWbNGrsvgYUaY42h65iKbmehlzNXhZ6JzMrfl9GumoKgorH8uNWoQ89dKw0JTL3xIFtRwBVEpqcm6s+8WIvzJKUtKruWh96MKgAE23PuexdOH4axVxVfvywiD9np87xP9ao4dtRHFmIcWUmAHR5nDNSQmd34dwScOeQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaE70Tj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C08C4CEEE;
	Fri,  4 Jul 2025 13:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634522;
	bh=fQPKqzqJoG96BUl5U70JlrV6PqD4K4Oa2dVm9yr0HrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SaE70Tj1OwyMqvxqvf4eScob+UgLUdi3MVNFhhU4ujlwlXvcJ5OYtvVcpzf9xcv7c
	 h7ht+/EmmhKE5sKm8bvC2vOJGYwdoJ82Y9J+8HoHxWNKPbO7svZyn2+K7N3ppmjdSM
	 AhdHp1iJbQklTm0P358/jsWybTSeLkr0WTu9tv62qcXUeIHedRGUU08lbBP7sjSvqt
	 bbKTIgqXsj2vXidw0x1yuPDnDT0SCP1lf/v2YxUao1cRJKoEfAWgJkn9Lu30t27DYS
	 AYEosCe7na9RtFOguLn/sw6aRBdryTeW+mgn+QQNcXs0ngRV8WSiEjKcOf4Dh9a7PH
	 KCTVyzRehoYbw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 04 Jul 2025 15:08:11 +0200
Subject: [PATCH mt76 7/9] wifi: mt76: mt7996: Fix valid_links bitmask in
 mt7996_mac_sta_{add,remove}
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-mt7996-mlo-fixes-v1-7-356456c73f43@kernel.org>
References: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
In-Reply-To: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

sta->valid_links bitmask can be set even for non-MLO client.

Fixes: dd82a9e02c054 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 6404514556419f75b69a783d96b0920157263e04..ea0cdd092a3f396c2a8cb655ff941b833fb9983e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1061,7 +1061,7 @@ mt7996_mac_sta_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	unsigned long links = sta->mlo ? sta->valid_links : BIT(0);
+	unsigned long links = sta->valid_links ? sta->valid_links : BIT(0);
 	int err;
 
 	mutex_lock(&mdev->mutex);
@@ -1155,7 +1155,7 @@ mt7996_mac_sta_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 {
 	struct mt76_dev *mdev = mphy->dev;
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
-	unsigned long links = sta->mlo ? sta->valid_links : BIT(0);
+	unsigned long links = sta->valid_links ? sta->valid_links : BIT(0);
 
 	mutex_lock(&mdev->mutex);
 

-- 
2.50.0


