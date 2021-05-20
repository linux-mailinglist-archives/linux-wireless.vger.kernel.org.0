Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BD4389C06
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 05:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhETDsY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 23:48:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41095 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230339AbhETDsY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 23:48:24 -0400
X-UUID: 6dafb413679a4ccc8ee2a8e4375bc2db-20210520
X-UUID: 6dafb413679a4ccc8ee2a8e4375bc2db-20210520
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1803936245; Thu, 20 May 2021 11:47:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 May 2021 11:46:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 May 2021 11:46:57 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>,
        YN Chen <yn.chen@mediatek.com>
Subject: [PATCH 6/7] mt76: mt7921: fix OMAC idx usage
Date:   Thu, 20 May 2021 11:46:40 +0800
Message-ID: <1621482401-29025-6-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1621482401-29025-1-git-send-email-sean.wang@mediatek.com>
References: <1621482401-29025-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

OMAC idx have to be same with BSS idx according to firmware usage.

Fixes: e0f9fdda81bd ("mt76: mt7921: add ieee80211_ops")
Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: YN Chen <yn.chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 55 +------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 5dbccbefe047..472afd4ea487 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -224,54 +224,6 @@ static void mt7921_stop(struct ieee80211_hw *hw)
 	mt7921_mutex_release(dev);
 }
 
-static inline int get_free_idx(u32 mask, u8 start, u8 end)
-{
-	return ffs(~mask & GENMASK(end, start));
-}
-
-static int get_omac_idx(enum nl80211_iftype type, u64 mask)
-{
-	int i;
-
-	switch (type) {
-	case NL80211_IFTYPE_STATION:
-		/* prefer hw bssid slot 1-3 */
-		i = get_free_idx(mask, HW_BSSID_1, HW_BSSID_3);
-		if (i)
-			return i - 1;
-
-		/* next, try to find a free repeater entry for the sta */
-		i = get_free_idx(mask >> REPEATER_BSSID_START, 0,
-				 REPEATER_BSSID_MAX - REPEATER_BSSID_START);
-		if (i)
-			return i + 32 - 1;
-
-		i = get_free_idx(mask, EXT_BSSID_1, EXT_BSSID_MAX);
-		if (i)
-			return i - 1;
-
-		if (~mask & BIT(HW_BSSID_0))
-			return HW_BSSID_0;
-
-		break;
-	case NL80211_IFTYPE_MONITOR:
-		/* ap uses hw bssid 0 and ext bssid */
-		if (~mask & BIT(HW_BSSID_0))
-			return HW_BSSID_0;
-
-		i = get_free_idx(mask, EXT_BSSID_1, EXT_BSSID_MAX);
-		if (i)
-			return i - 1;
-
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	return -1;
-}
-
 static int mt7921_add_interface(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
@@ -293,12 +245,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 		goto out;
 	}
 
-	idx = get_omac_idx(vif->type, phy->omac_mask);
-	if (idx < 0) {
-		ret = -ENOSPC;
-		goto out;
-	}
-	mvif->mt76.omac_idx = idx;
+	mvif->mt76.omac_idx = mvif->mt76.idx;
 	mvif->phy = phy;
 	mvif->mt76.band_idx = 0;
 	mvif->mt76.wmm_idx = mvif->mt76.idx % MT7921_MAX_WMM_SETS;
-- 
2.25.1

