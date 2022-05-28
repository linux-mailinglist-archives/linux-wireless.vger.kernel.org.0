Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A279F5369BF
	for <lists+linux-wireless@lfdr.de>; Sat, 28 May 2022 03:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355462AbiE1BdM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 21:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355254AbiE1BdL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 21:33:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C66A132A1B
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 18:33:04 -0700 (PDT)
X-UUID: 804e857238c743af9c78c46410533dc7-20220528
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:1fad2f5f-eee5-492b-acb4-5d25bd4e78aa,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.5,REQID:1fad2f5f-eee5-492b-acb4-5d25bd4e78aa,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:2a19b09,CLOUDID:6ee58bb8-3c45-407b-8f66-25095432a27a,C
        OID:e9a357db742a,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 804e857238c743af9c78c46410533dc7-20220528
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1822326408; Sat, 28 May 2022 09:32:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sat, 28 May 2022 09:32:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sat, 28 May 2022 09:32:57 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
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
        YN Chen <yn.chen@mediatek.com>,
        "Deren Wu" <deren.wu@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7921: add PATCH_FINISH_REQ cmd response handling
Date:   Sat, 28 May 2022 09:28:53 +0800
Message-ID: <63e1acbc230d3db535dfbaa13027cacad0767a34.1653699683.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1653699683.git.deren.wu@mediatek.com>
References: <cover.1653699683.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: YN Chen <yn.chen@mediatek.com>

add new case to fetch the return value of PATCH_FINISH_REQ

Signed-off-by: YN Chen <yn.chen@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 12bab18c4171..617f0a452f71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -111,7 +111,8 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	if (seq != rxd->seq)
 		return -EAGAIN;
 
-	if (cmd == MCU_CMD(PATCH_SEM_CONTROL)) {
+	if (cmd == MCU_CMD(PATCH_SEM_CONTROL) ||
+	    cmd == MCU_CMD(PATCH_FINISH_REQ)) {
 		skb_pull(skb, sizeof(*rxd) - 4);
 		ret = *skb->data;
 	} else if (cmd == MCU_EXT_CMD(THERMAL_CTRL)) {
-- 
2.18.0

