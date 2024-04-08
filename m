Return-Path: <linux-wireless+bounces-5968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC889B780
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 08:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426C5B21242
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 06:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2699510976;
	Mon,  8 Apr 2024 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gpb/ph8f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649D10942
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556913; cv=none; b=a8QU1yctEchx7PghHZh2f/Y0AqYJJ3Q+Epz0j+9cCvj/f9srSkJvNsWEjP32KhN2DeBixwKbYRLIkWc9PanWHUGClQLBRzcrnn2pRVhqCurOwct9EqBX4J380pliglmNw+xCgImU0NTQZX/WaABDd/xmHv1beH9LeIfSo4IIIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556913; c=relaxed/simple;
	bh=QnPyomYcpTEHKqkuI4QsUTTIaecwOg2KT1/dwcYjWYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=etZ/ZIWSS7NmBA8+ElIUthX2nZ0UIm3Jil+rwLe+J8SD0eIjqnk/J4d8x5va2O6vnJ2uiTwEajXuang/SAyXZ3ZqNXTkHMWdZbEDoHIjkVHt/oGF/5d7bTWEgH3xkfMwcdkPdftBnMUHExS+d09mlHHHqt6xslkT5+Api0MitqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gpb/ph8f; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 579e5ecef56f11eeb8927bc1f75efef4-20240408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ee6ScaF8NDqFt1x4FzTWri7fuE/3zdB6eCOnjp0D+Cw=;
	b=gpb/ph8fma/Vr7S2u69Av3c5+KTOtoLQ6O3hRxbwu41RD1ojZEyguC/4iraYXQv4NdaXDJrvGLS2sz+JmWK89odMm7anW1GMs4dXgmccIypGsiJN/dLVxn+5L5m0aGdypLZtdzXHsrTFH1cgIWVykcOoJcajskgSBzNv1U8ppy4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:56f7ffbe-4fc9-4943-920a-81a1389fd685,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:88bce885-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 579e5ecef56f11eeb8927bc1f75efef4-20240408
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1075619960; Mon, 08 Apr 2024 14:15:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 8 Apr 2024 14:15:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 8 Apr 2024 14:15:03 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt7996: let upper layer handle MGMT frame protection
Date: Mon, 8 Apr 2024 14:14:21 +0800
Message-ID: <20240408061421.10287-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Michael-CY Lee <michael-cy.lee@mediatek.com>

The firmware support for management frame protection has limitations:
- do not support cipher BIP-GMAC-128 and BIP-GMAC-256
- support cipher BIP-CMAC-128 and BIP-CMAC-256, except action frame with
  action type 'not robust'.

Therefore, to simplify the logic, do not set the IGTK to firmware and
let the encryption of management frames be handled by upper layer.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
v2: add back missing line
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 338ff10b121d..c4a068d52c35 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -352,10 +352,6 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	/* fall back to sw encryption for unsupported ciphers */
 	switch (key->cipher) {
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-		wcid_keyidx = &wcid->hw_key_idx2;
-		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
-		break;
 	case WLAN_CIPHER_SUITE_TKIP:
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_CCMP_256:
@@ -363,6 +359,11 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	case WLAN_CIPHER_SUITE_GCMP_256:
 	case WLAN_CIPHER_SUITE_SMS4:
 		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		wcid_keyidx = &wcid->hw_key_idx2;
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+		fallthrough;
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 		if (key->keyidx == 6 || key->keyidx == 7)
-- 
2.39.2


