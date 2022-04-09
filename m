Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4452F4FA8B1
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Apr 2022 15:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242228AbiDINrA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Apr 2022 09:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242234AbiDINq7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Apr 2022 09:46:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22279BAC4
        for <linux-wireless@vger.kernel.org>; Sat,  9 Apr 2022 06:44:48 -0700 (PDT)
X-UUID: 601a400f306a40849f43d1ef05bc5ac4-20220409
X-UUID: 601a400f306a40849f43d1ef05bc5ac4-20220409
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1519573908; Sat, 09 Apr 2022 21:44:43 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 9 Apr 2022 21:44:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 9 Apr
 2022 21:44:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Apr 2022 21:44:41 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Shayne Chen" <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: fix antenna config missing in 6G cap
Date:   Sat, 9 Apr 2022 21:44:07 +0800
Message-ID: <357763fe0b112838d500422a27b114b4281adb9a.1649511465.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

To make sure we have the proper antenna config in 6g cap,
move IEEE80211_VHT_CAP_[T/R]X_ANTENNA_PATTERN to stream init.

Fixes: f1103fa6b3492 ("mt76: add TX/RX antenna pattern capabilities")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 026ab1e16d45..2dd3ebd1863f 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -248,6 +248,8 @@ static void mt76_init_stream_cap(struct mt76_phy *phy,
 		vht_cap->cap |= IEEE80211_VHT_CAP_TXSTBC;
 	else
 		vht_cap->cap &= ~IEEE80211_VHT_CAP_TXSTBC;
+	vht_cap->cap |= IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN |
+			IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN;
 
 	for (i = 0; i < 8; i++) {
 		if (i < nstream)
@@ -323,8 +325,6 @@ mt76_init_sband(struct mt76_phy *phy, struct mt76_sband *msband,
 	vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC |
 			IEEE80211_VHT_CAP_RXSTBC_1 |
 			IEEE80211_VHT_CAP_SHORT_GI_80 |
-			IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN |
-			IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN |
 			(3 << IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT);
 
 	return 0;
-- 
2.18.0

