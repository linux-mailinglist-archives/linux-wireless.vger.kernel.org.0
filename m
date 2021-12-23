Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA7847DF3A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 07:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346673AbhLWG6x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 01:58:53 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:49526 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346671AbhLWG6w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 01:58:52 -0500
X-UUID: 120a0b310f4a439db49ad509c65b9eea-20211223
X-UUID: 120a0b310f4a439db49ad509c65b9eea-20211223
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1869490313; Thu, 23 Dec 2021 14:58:48 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 23 Dec 2021 14:58:46 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Dec
 2021 14:58:46 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 14:58:45 +0800
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
Subject: [PATCH] mt76: mt7915: fix warning: variable 'flags' set but not used
Date:   Thu, 23 Dec 2021 14:58:43 +0800
Message-ID: <20211223065843.94919-1-bo.jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

fix warning: variable 'flags' set but not used

Fixes: 0aa6b534b5e1 ("mt76: mt7915: update rx rate reporting for mt7916")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index ee4535a..f6d6321 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -469,7 +469,7 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 			__le32 *rxv)
 {
 	u32 v0, v2;
-	u8 flags, stbc, gi, bw, dcm, mode, nss;
+	u8 stbc, gi, bw, dcm, mode, nss;
 	int i, idx;
 	bool cck = false;
 
@@ -505,20 +505,12 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 		status->encoding = RX_ENC_HT;
 		if (i > 31)
 			return -EINVAL;
-
-		flags = RATE_INFO_FLAGS_MCS;
-		if (gi)
-			flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case MT_PHY_TYPE_VHT:
 		status->nss = nss;
 		status->encoding = RX_ENC_VHT;
 		if (i > 9)
 			return -EINVAL;
-
-		flags = RATE_INFO_FLAGS_VHT_MCS;
-		if (gi)
-			flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case MT_PHY_TYPE_HE_MU:
 	case MT_PHY_TYPE_HE_SU:
@@ -532,7 +524,6 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 			status->he_gi = gi;
 
 		status->he_dcm = dcm;
-		flags |= RATE_INFO_FLAGS_HE_MCS;
 		break;
 	default:
 		return -EINVAL;
-- 
2.18.0

