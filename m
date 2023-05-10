Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89726FD773
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 08:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjEJGxY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 02:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbjEJGxW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 02:53:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612762711;
        Tue,  9 May 2023 23:53:17 -0700 (PDT)
X-UUID: 53c081b4eeff11edb20a276fd37b9834-20230510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Tx9CfWRYSGHMpHne4BeMeiM05WCsy/k7BT7zMI9zAyc=;
        b=UgF+6FYJZevkbaFLaWeS/cL9frDY2tSXxlZtuvebQOJlFTRx/IHBxW37tHlPdZXfpj6S7WYM50m8x2X4nDzt4edqxc4azKDu8apwCVBj+209yoF4NIaervNzqwsDMBk1VmXZr/zj7azoepgUEzVQlKUGLF6rGaIvPwPLFtJln04=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:4824f41a-545c-413b-bcd8-4b90e66e8797,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.24,REQID:4824f41a-545c-413b-bcd8-4b90e66e8797,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:178d4d4,CLOUDID:af9f5dc0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230510145312T5M18QWD,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 53c081b4eeff11edb20a276fd37b9834-20230510
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 318407663; Wed, 10 May 2023 14:53:10 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 May 2023 14:53:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 May 2023 14:53:09 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH] wifi: mt76: mt7921: do not support one stream on secondary antenna only
Date:   Wed, 10 May 2023 14:51:13 +0800
Message-ID: <cc94dbd5a53537e82d0beaa2d986f0b18e06eee4.1683700651.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7921 support following antenna combiantions only.
* primary + secondary (2x2)
* primary only        (1x1)

Since we cannot work on secondary antenna only, return error if the
antenna bitmap is 0x2 in .set_antenna().

For example:
iw phy0 set antenna 3 3 /* valid */
iw phy0 set antenna 1 1 /* valid */
iw phy0 set antenna 2 2 /* invalid */

Cc: stable@vger.kernel.org
Fixes: e0f9fdda81bd ("mt76: mt7921: add ieee80211_ops")
Suggested-by: Knox Chiou <knoxchiou@google.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 0c9a472bc81a..6c971c30d6a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1364,7 +1364,7 @@ mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 		return -EINVAL;
 
 	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
-		tx_ant = BIT(ffs(tx_ant) - 1) - 1;
+		return -EINVAL;
 
 	mt7921_mutex_acquire(dev);
 
-- 
2.18.0

