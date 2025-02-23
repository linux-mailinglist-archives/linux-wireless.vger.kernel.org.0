Return-Path: <linux-wireless+bounces-19359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1B3A4123F
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 00:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B511891C47
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Feb 2025 23:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BB4155A2F;
	Sun, 23 Feb 2025 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NhM4NRdr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6582054EF
	for <linux-wireless@vger.kernel.org>; Sun, 23 Feb 2025 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740352996; cv=none; b=Vx1myGqov/C3C5ziUCJmYe5kKnv0Q/OJ4NPGHHpKs/VCuBllOLrbsCfx5bYj/fD80l3ZdHx8qtNtQM3gBhdj4auRyLgmdW4Oqa4jNB8ai9ilU2OzLYNWmbBB+jOwb8/fkBIC9jV+pymawElxiQJiq5iBdmDIn7pzoavuXxGPLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740352996; c=relaxed/simple;
	bh=/7wxowOkYbnMXkMeQiZtVc9d8lfYPNAXlRlkAXmrcBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EuWT98gyddzqH/gwH34t4D54h9PlF/QHWtB4PhTwnkCzbsBZ21Af5LsH0W4SkSd3cH4N+jLruCQO+BSR3qFIOnUXQfmAchkvKWZkSMn6BKbOliThEkImEsJZ+DntR7/0S85dKH9xTclE1AG+V4V2pFey6f4fFc6yqSij+QIWQxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NhM4NRdr; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740352981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZXsjCNy4V+kCyFuif8XWdLqtmoN0EswAxYS9Q53oLPQ=;
	b=NhM4NRdr+vfHRpfKDz22u8xvKhUui2K8mcLNioPcSxfF7v5JjqpR0/ERdZSgFG2uDTT5hD
	tlFGWAu1i1X8Kg/Nn60k4bs2QHbmmaVu1fd1IOdGJhAEHRmRBUM/aMHkqvwEjuh0E0DDKm
	DNuClbuZB9unk0HeYhqZroEoNVzxhdo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH wireless-next] wifi: mt76: mt7925: Remove unnecessary if-check
Date: Mon, 24 Feb 2025 00:21:24 +0100
Message-ID: <20250223232127.99357-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The if and else branches implement the same logic. Remove the
unnecessary if-check and simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 15815ad84713..7e4935965d35 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1983,11 +1983,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 	}
 	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
-
-	if (link_sta)
-		info.newly = state != MT76_STA_INFO_STATE_ASSOC;
-	else
-		info.newly = state == MT76_STA_INFO_STATE_ASSOC ? false : true;
+	info.newly = state != MT76_STA_INFO_STATE_ASSOC;
 
 	if (ieee80211_vif_is_mld(vif))
 		err = mt7925_mcu_mlo_sta_cmd(&dev->mphy, &info);
-- 
2.48.1


