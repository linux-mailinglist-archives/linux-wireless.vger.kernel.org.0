Return-Path: <linux-wireless+bounces-26984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB61B43039
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 05:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A545816439E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 03:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D7E28134C;
	Thu,  4 Sep 2025 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pqG8k13t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BE27FB10
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756955239; cv=none; b=ox1otEiLrZNwyfGrz7U2Ka3fvf654h3IDbeMB3a4nCIyjbqqfOXTVasl+YCwQ08deAyedDi9IqPmv1HhaGan1uo6Lk6SMxhPG5nIVxbWPGanTFgoss+TZx3+4KCfMgA+NHtrxoqVXJnXdYVhmH5Zl2D/jEIzw07FgqEhMvAg04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756955239; c=relaxed/simple;
	bh=0HSDrBv9U39sWPh6BChKJloMaezJMmWnc032o0+qLxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OT3zad7OomulInw5SDTlv/zmVYpgE9OkGKbOAvfhHG0XJ+75sqyrofVC+iZqGfQlAQCGS/KxMepZz4r1IPlezUU9DoIf3hwbnEocy5s+hB8CX6lYwWpcvKWMBZt0L9YFcKO1pgX9RMrI4Z+hrKMCZGQYi0sUyrsC+YiQzug86WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pqG8k13t; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3d20ab1c893c11f0b33aeb1e7f16c2b6-20250904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jO8i8kXujf744Mn62wNF2Zi3h3rmmA7bL/Jy8/gBbNU=;
	b=pqG8k13tBrkoXyqL+ghdgEWc9vYxPSP9f7ChpgbPgourcFYryk00gx4WWCPkh3x9y04uPVDdg4yMMs0RhkY0MNNbz4/px9CIX2uCBwXLXS1DPtB7iN7r7wC56MsPrw77qySHPQJGydrfNEwxha7xQhuR27ZxGjjkeI+zyDURUmo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:b83c6367-e70c-4bc4-9af5-cdef7165be65,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:db276a84-5317-4626-9d82-238d715c253f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3d20ab1c893c11f0b33aeb1e7f16c2b6-20250904
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1836700465; Thu, 04 Sep 2025 11:07:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 4 Sep 2025 11:07:03 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 4 Sep 2025 11:07:03 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 1/4] wifi: mt76: mt792x: protect state->cc_* counters with cc_lock
Date: Thu, 4 Sep 2025 11:06:46 +0800
Message-ID: <20250904030649.655436-2-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250904030649.655436-1-mingyen.hsieh@mediatek.com>
References: <20250904030649.655436-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The updates to state->cc_* (cc_busy, cc_tx, etc.) lack synchronization,
risking race conditions and inconsistent statistics.

Add cc_lock protection to ensure atomic updates.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 3f1d9ba49076..f86e0ac91100 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -243,10 +243,14 @@ mt792x_phy_update_channel(struct mt76_phy *mphy, int idx)
 		phy->noise += nf - (phy->noise >> 4);
 
 	state = mphy->chan_state;
+
+	spin_lock_bh(&dev->mt76.cc_lock);
 	state->cc_busy += busy_time;
 	state->cc_tx += tx_time;
 	state->cc_rx += rx_time + obss_time;
 	state->cc_bss_rx += rx_time;
+	spin_unlock_bh(&dev->mt76.cc_lock);
+
 	state->noise = -(phy->noise >> 4);
 }
 
-- 
2.34.1


