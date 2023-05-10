Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE6D6FD574
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 06:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjEJExe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 00:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjEJExc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 00:53:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAF8E2
        for <linux-wireless@vger.kernel.org>; Tue,  9 May 2023 21:53:29 -0700 (PDT)
X-UUID: 99f781caeeee11ed9cb5633481061a41-20230510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Va3ysEUmIoVWyFo600g7sh1Dh7QpOmSk6nUcgf1dMmM=;
        b=D6hvzmXudBpLjSk45AmhMFuETgtW62B6rm7KdE8aCkoHQmxuipYQsSu8w8W85OmyZ2rImuHwqMyMrzUPXRsGOSvMt0tUIbGjQvBpRWFo+I0s8Y/cCorMnQKNnJDv4hjWZ2pRoApMPxxwmLbkxFMJd0U6YTVVUlIrZci4T+qogRY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:2c5a6ada-fd45-49e9-a953-29d923376c2f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:c0ed59c0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 99f781caeeee11ed9cb5633481061a41-20230510
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 88540586; Wed, 10 May 2023 12:53:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 May 2023 12:53:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 May 2023 12:53:25 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 6/6] wifi: mt76: mt7996: drop return in mt7996_sta_statistics
Date:   Wed, 10 May 2023 12:53:21 +0800
Message-ID: <7fe20aedadf5ce581f6e4a8d2ef9f48e2cc87702.1683670255.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <e3cddf1cff5f060478c2de9e4e4021541549e750.1683670255.git.ryder.lee@mediatek.com>
References: <e3cddf1cff5f060478c2de9e4e4021541549e750.1683670255.git.ryder.lee@mediatek.com>
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

Avoid blocking other statistics sinfo->filled when txrate is
unavailable.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 0975774fe244..8e1b7cc48146 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -953,18 +953,19 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct rate_info *txrate = &msta->wcid.rate;
 
-	if (!txrate->legacy && !txrate->flags)
-		return;
-
-	if (txrate->legacy) {
-		sinfo->txrate.legacy = txrate->legacy;
-	} else {
-		sinfo->txrate.mcs = txrate->mcs;
-		sinfo->txrate.nss = txrate->nss;
-		sinfo->txrate.bw = txrate->bw;
-		sinfo->txrate.he_gi = txrate->he_gi;
-		sinfo->txrate.he_dcm = txrate->he_dcm;
-		sinfo->txrate.he_ru_alloc = txrate->he_ru_alloc;
+	if (txrate->legacy || txrate->flags) {
+		if (txrate->legacy) {
+			sinfo->txrate.legacy = txrate->legacy;
+		} else {
+			sinfo->txrate.mcs = txrate->mcs;
+			sinfo->txrate.nss = txrate->nss;
+			sinfo->txrate.bw = txrate->bw;
+			sinfo->txrate.he_gi = txrate->he_gi;
+			sinfo->txrate.he_dcm = txrate->he_dcm;
+			sinfo->txrate.he_ru_alloc = txrate->he_ru_alloc;
+		}
+		sinfo->txrate.flags = txrate->flags;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
 	sinfo->txrate.flags = txrate->flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
-- 
2.18.0

