Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD325456BE4
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 09:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhKSI4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 03:56:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54308 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230027AbhKSI4l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 03:56:41 -0500
X-UUID: 636bbb29fa73437e9c8643c4c67c3012-20211119
X-UUID: 636bbb29fa73437e9c8643c4c67c3012-20211119
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 887281599; Fri, 19 Nov 2021 16:53:29 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 19 Nov 2021 16:53:27 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 19 Nov
 2021 16:53:27 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 19 Nov 2021 16:53:26 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH] mt76: fix the wiphy's available antennas to the correct value
Date:   Fri, 19 Nov 2021 16:53:23 +0800
Message-ID: <cbdfacdab1672161c5abf3eca2510dca3f3a7951.1637311782.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

the wiphy's available antennas may be incorrect
When ext phy's antenna_mask is different from main phy

Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 62807dc..a07a3bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -411,8 +411,8 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AQL);
 
-	wiphy->available_antennas_tx = dev->phy.antenna_mask;
-	wiphy->available_antennas_rx = dev->phy.antenna_mask;
+	wiphy->available_antennas_tx = phy->antenna_mask;
+	wiphy->available_antennas_rx = phy->antenna_mask;
 
 	hw->txq_data_size = sizeof(struct mt76_txq);
 	hw->uapsd_max_sp_len = IEEE80211_WMM_IE_STA_QOSINFO_SP_ALL;
-- 
2.18.0

