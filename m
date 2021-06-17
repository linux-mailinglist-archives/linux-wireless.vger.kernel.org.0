Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE82B3AB622
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFQOkl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 10:40:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46596 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230028AbhFQOkk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 10:40:40 -0400
X-UUID: f520a29e872e4ad7b64fad2267de899d-20210617
X-UUID: f520a29e872e4ad7b64fad2267de899d-20210617
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1175114754; Thu, 17 Jun 2021 22:38:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 22:38:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 22:38:27 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921: enable HE BFee capability
Date:   Thu, 17 Jun 2021 22:38:25 +0800
Message-ID: <8cec066575cafcb4a09a3f83625d98b4d76f65dd.1623929134.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Enables HE MU/SU beamformee functionality

Signed-off-by: Eric-SY Chang <Eric-SY.Chang@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index f062088780c2..426e76a45f73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -80,8 +80,11 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 		he_cap_elem->phy_cap_info[1] =
 			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
 		he_cap_elem->phy_cap_info[2] =
+			IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
 			IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
-			IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ;
+			IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
+			IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
+			IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
 
 		switch (i) {
 		case NL80211_IFTYPE_STATION:
@@ -103,7 +106,15 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 			he_cap_elem->phy_cap_info[3] |=
 				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
 				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[4] |=
+				IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
+				IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4;
+			he_cap_elem->phy_cap_info[5] |=
+				IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK |
+				IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK;
 			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_42_SU |
+				IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU |
 				IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
 				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
 				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
-- 
2.18.0

