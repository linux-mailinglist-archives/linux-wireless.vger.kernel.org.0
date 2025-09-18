Return-Path: <linux-wireless+bounces-26947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C8B40DC3
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 21:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5507B547D73
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E402F83D0;
	Tue,  2 Sep 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFLGLbvO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3A20C038
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840709; cv=none; b=Cp0vs9TFkAOkqCRS4D5UCLN37sHlhv783TktG3t1AarND5bqN/6r3mAg8mb6F60ak9jhRVwm6oaHfJ6efgMNFNbMVyx6ZAELc/IknqnSzDwytJ+9BN3Z7mBRICr00OapN/heq9fDxrVXi5rpQyezVWhx6Mfto1yNHy5KNtre/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840709; c=relaxed/simple;
	bh=0l7ANV3oc32SME44FBPiXCTBRDuZfxoqru6H1toeifk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtWFN/tkmHSJEcrzYOTKLc6uwaUlhiB1OL71/zNnxx/ct9YOJ7aJ0sZ/BZ7mRAtzS2nsCTPA3UE+je3a+1AqAWmLgtuXVt1h8YfoloOIBZYdAYEBv/hAfaXffpSWOnDKWu365W8yKYSp2BzNcikRVBwTK8Lq1ryTiUoSt6viC+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFLGLbvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF26C4CEED;
	Tue,  2 Sep 2025 19:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756840708;
	bh=0l7ANV3oc32SME44FBPiXCTBRDuZfxoqru6H1toeifk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JFLGLbvOAdURPWVsYXjxhlk/Ph/NXJ4T5CUubWYipP6O40+RauTGuJLU0q7BeXrUI
	 2vJIOJ4mGLvJgvGgs0dcwZBxcR8WYXoRw8P6EQf/7859/b63hakaCgB8DvK5G+Qcp8
	 etyOpIbVgfS+w1b356z752UKKTiwJNceQSNqdviwwucaiFsR8nKAPzpkYXU3VbnIUE
	 T0H/g2M4lVmdCfwgK5cWb3d33SeCetTUDE7YoL6vEOcf6O75SXqoyYXmoa8RZ5UYvJ
	 LadHOOq/t0iBKvGoCS1rECrOPTthlX2EH4vqZPLN09T5LEsU4d8075Ssm7qUytsQ1c
	 7SD2MnDpdQ/Og==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 02 Sep 2025 21:17:58 +0200
Subject: [PATCH mt76 v3 08/15] wifi: mt76: mt7996: Fix tx-queues
 initialization for second phy on mt7996
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-mt7996-rro-rework-v3-8-8f813890959e@kernel.org>
References: <20250902-mt7996-rro-rework-v3-0-8f813890959e@kernel.org>
In-Reply-To: <20250902-mt7996-rro-rework-v3-0-8f813890959e@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Benjamin Lin <benjamin-jw.lin@mediatek.com>, Rex Lu <rex.lu@mediatek.com>
X-Mailer: b4 0.14.2

Fix the second phy tx queue initialization if hif device is not
available for MT7990 chipset.

Fixes: 83eafc9251d6d ("wifi: mt76: mt7996: add wed tx support")
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Co-developed-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index b66ba38df570503839e1a9ba1819b4e29303532f..023f788ac5f8ce6f01e5556a6000765ed42cc646 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -703,13 +703,20 @@ static int mt7996_register_phy(struct mt7996_dev *dev, enum mt76_band_id band)
 
 	/* init wiphy according to mphy and phy */
 	mt7996_init_wiphy_band(mphy->hw, phy);
-	ret = mt7996_init_tx_queues(mphy->priv,
-				    MT_TXQ_ID(band),
-				    MT7996_TX_RING_SIZE,
-				    MT_TXQ_RING_BASE(band) + hif1_ofs,
-				    wed);
-	if (ret)
-		goto error;
+
+	if (is_mt7996(&dev->mt76) && !dev->hif2 && band == MT_BAND1) {
+		int i;
+
+		for (i = 0; i <= MT_TXQ_PSD; i++)
+			mphy->q_tx[i] = dev->mt76.phys[MT_BAND0]->q_tx[0];
+	} else {
+		ret = mt7996_init_tx_queues(mphy->priv, MT_TXQ_ID(band),
+					    MT7996_TX_RING_SIZE,
+					    MT_TXQ_RING_BASE(band) + hif1_ofs,
+					    wed);
+		if (ret)
+			goto error;
+	}
 
 	ret = mt76_register_phy(mphy, true, mt76_rates,
 				ARRAY_SIZE(mt76_rates));

-- 
2.50.1


