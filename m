Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298D144DBE1
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 19:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhKKS7G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 13:59:06 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:49020 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229785AbhKKS7F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 13:59:05 -0500
X-UUID: 58acf91f55f54612809640a381b75fe8-20211112
X-UUID: 58acf91f55f54612809640a381b75fe8-20211112
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1036677006; Fri, 12 Nov 2021 02:56:09 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 12 Nov 2021 02:56:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Nov
 2021 02:56:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Nov 2021 02:56:07 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Fang Zhao <fang.zhao@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix SMPS operation fail
Date:   Fri, 12 Nov 2021 02:56:06 +0800
Message-ID: <4a2b49ea3821561416a546810cd3151fdc5aa86c.1636656394.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TGn fails sending SM power save mode action frame to the AP to switch
from dynamic SMPS mode to static mode.

Reported-by: Fang Zhao <fang.zhao@mediatek.com>
Signed-off-by: Fang Zhao <fang.zhao@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 6 +++++-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 79081abf3329..5021c8fd2650 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2135,8 +2135,11 @@ void mt7915_mac_sta_rc_work(struct work_struct *work)
 			       IEEE80211_RC_BW_CHANGED))
 			mt7915_mcu_add_rate_ctrl(dev, vif, sta, true);
 
-		if (changed & IEEE80211_RC_SMPS_CHANGED)
+		if (changed & IEEE80211_RC_SMPS_CHANGED) {
 			mt7915_mcu_add_smps(dev, vif, sta);
+			mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, NULL,
+						       RATE_PARAM_MMPS_UPDATE);
+		}
 
 		spin_lock_bh(&dev->sta_poll_lock);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 3a496046fe21..92166679055f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2077,7 +2077,11 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 	case RATE_PARAM_FIXED_MCS:
 	case RATE_PARAM_FIXED_GI:
 	case RATE_PARAM_FIXED_HE_LTF:
-		ra->phy = *phy;
+		if (phy)
+			ra->phy = *phy;
+		break;
+	case RATE_PARAM_MMPS_UPDATE:
+		ra->mmps_mode = (sta->smps_mode == IEEE80211_SMPS_DYNAMIC);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index e8501234f686..11728454b92c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -960,6 +960,7 @@ struct sta_rec_ra_fixed {
 
 enum {
 	RATE_PARAM_FIXED = 3,
+	RATE_PARAM_MMPS_UPDATE = 5,
 	RATE_PARAM_FIXED_HE_LTF = 7,
 	RATE_PARAM_FIXED_MCS,
 	RATE_PARAM_FIXED_GI = 11,
-- 
2.29.2

