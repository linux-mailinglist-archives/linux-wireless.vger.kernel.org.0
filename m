Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2B16AA8A3
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Mar 2023 09:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCDIKN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Mar 2023 03:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCDIKL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Mar 2023 03:10:11 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FBE11E8D
        for <linux-wireless@vger.kernel.org>; Sat,  4 Mar 2023 00:10:04 -0800 (PST)
X-UUID: f301c2b8ba6311ed945fc101203acc17-20230304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=M+nX4DmXaWAu5GaLRZX1v8/uR3NbT5kE2UzeDElONlw=;
        b=DiQEHvv1AXnYPoOU6TwDw6kpx2aPAnxYp6f6zAV6YepAjUTsy1IkUBvUzc0Jv7PmODdUi0VGLulcFqlr9qrqljSSeXE6Anz7F+MFZhOJS8Tr8IiQJVDi3zGjoWx+lPfLkcgUzcjSSmjnIK3aBfyp9+uWawSmaVLxXsXyJxYRs6o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:974f9970-bf3c-423d-ae77-ca81c2fb116c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:b6fc4d27-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: f301c2b8ba6311ed945fc101203acc17-20230304
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 799224403; Sat, 04 Mar 2023 16:09:55 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Sat, 4 Mar 2023 16:09:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Sat, 4 Mar 2023 16:09:54 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Neil Chen <yn.chen@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: use driver flags rather than mac80211 flags to mcu
Date:   Sat, 4 Mar 2023 16:09:51 +0800
Message-ID: <fce2160648ed8a83248e8998cf76bbe05de0e8a0.1677912476.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Neil Chen <yn.chen@mediatek.com>

FIF_* flags from mac80211 is not ABI. mt7921 should not pass it into mcu
directly. Remap FIF_* to driver defined flags as mcu command input.

Fixes: c222f77fd421 ("wifi: mt76: mt7921: fix rx filter incorrect by drv/fw inconsistent")
Signed-off-by: Neil Chen <yn.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c    | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 75eaf86c6a78..f67b37d38dbc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -703,10 +703,25 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 				    unsigned int *total_flags,
 				    u64 multicast)
 {
+#define MT7921_FILTER_FCSFAIL    BIT(2)
+#define MT7921_FILTER_CONTROL    BIT(5)
+#define MT7921_FILTER_OTHER_BSS  BIT(6)
+#define MT7921_FILTER_ENABLE     BIT(31)
+
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	u32 flags = MT7921_FILTER_ENABLE;
+
+#define MT7921_FILTER(_fif, _type) do {			\
+		if (*total_flags & (_fif))		\
+			flags |= MT7921_FILTER_##_type;	\
+	} while (0)
+
+	MT7921_FILTER(FIF_FCSFAIL, FCSFAIL);
+	MT7921_FILTER(FIF_CONTROL, CONTROL);
+	MT7921_FILTER(FIF_OTHER_BSS, OTHER_BSS);
 
 	mt7921_mutex_acquire(dev);
-	mt7921_mcu_set_rxfilter(dev, *total_flags, 0, 0);
+	mt7921_mcu_set_rxfilter(dev, flags, 0, 0);
 	mt7921_mutex_release(dev);
 
 	*total_flags &= (FIF_OTHER_BSS | FIF_FCSFAIL | FIF_CONTROL);
-- 
2.18.0

