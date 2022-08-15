Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D52F592818
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Aug 2022 05:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiHOD35 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Aug 2022 23:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiHOD34 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Aug 2022 23:29:56 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D010FFF
        for <linux-wireless@vger.kernel.org>; Sun, 14 Aug 2022 20:29:54 -0700 (PDT)
X-UUID: 129ecf837ec54adbbf255ef9d78447cd-20220815
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=f/DNrOHjuuOkqJPFhLJHldmqWG8aZc2jc5hg+27lVc0=;
        b=PYLGVofGuu4UgKo5bDFPULPpY/3pgEho9cpvegbgVpy8Sq2D8N+5nbF9vk4Mu4SaVMCVFbkvKRfXCBQkCTZ3Ze+hBnh2pxCynT06jQgV0vtjDcepxHZlIa+/kaAWRVuRqPLV7q/HzoSSSFCW/WeDhjoYUvBJOYS3E8pqEzFHHh8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:8eb1baf2-680e-4170-a1fe-9c4c0393d024,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:38,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:38
X-CID-META: VersionHash:3d8acc9,CLOUDID:b1a5cdae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:4,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 129ecf837ec54adbbf255ef9d78447cd-20220815
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 181753360; Mon, 15 Aug 2022 11:29:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 15 Aug 2022 11:29:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Aug 2022 11:29:47 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix mcs value in ht mode
Date:   Mon, 15 Aug 2022 11:29:31 +0800
Message-ID: <20220815032931.28367-1-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the error that mcs will be reduced to a range of 0 to 7 in ht mode.

Fixes: 70fd1333cd32 ("mt76: mt7915: rework .set_bitrate_mask() to support more options")

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index f83067961945..e99fdacc11ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1360,7 +1360,7 @@ mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
 	struct sta_phy phy = {};
 	int ret, nrates = 0;
 
-#define __sta_phy_bitrate_mask_check(_mcs, _gi, _he)				\
+#define __sta_phy_bitrate_mask_check(_mcs, _gi, _ht, _he)			\
 	do {									\
 		u8 i, gi = mask->control[band]._gi;				\
 		gi = (_he) ? gi : gi == NL80211_TXRATE_FORCE_SGI;		\
@@ -1373,15 +1373,17 @@ mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
 				continue;					\
 			nrates += hweight16(mask->control[band]._mcs[i]);	\
 			phy.mcs = ffs(mask->control[band]._mcs[i]) - 1;		\
+			if (_ht)						\
+				phy.mcs += 8 * i;				\
 		}								\
 	} while (0)
 
 	if (sta->deflink.he_cap.has_he) {
-		__sta_phy_bitrate_mask_check(he_mcs, he_gi, 1);
+		__sta_phy_bitrate_mask_check(he_mcs, he_gi, 0, 1);
 	} else if (sta->deflink.vht_cap.vht_supported) {
-		__sta_phy_bitrate_mask_check(vht_mcs, gi, 0);
+		__sta_phy_bitrate_mask_check(vht_mcs, gi, 0, 0);
 	} else if (sta->deflink.ht_cap.ht_supported) {
-		__sta_phy_bitrate_mask_check(ht_mcs, gi, 0);
+		__sta_phy_bitrate_mask_check(ht_mcs, gi, 1, 0);
 	} else {
 		nrates = hweight32(mask->control[band].legacy);
 		phy.mcs = ffs(mask->control[band].legacy) - 1;
-- 
2.18.0

