Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A15E6399BD
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Nov 2022 09:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiK0IpQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Nov 2022 03:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiK0IpO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Nov 2022 03:45:14 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021E612AB3
        for <linux-wireless@vger.kernel.org>; Sun, 27 Nov 2022 00:45:09 -0800 (PST)
X-UUID: 534304b763be4b7a8fb82ed53f9f4a24-20221127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=degEPpez7R0PK8gPSumCmltIgpOy/w9YTRhbX2/Q2qU=;
        b=kdSOkbyNAhtELS80VWWThKcV8xhLJg9xyLUKMIv7amiMVkmLhwblRFWDrOF1jg5n1xzAEjWdH8Hff8q4voAGDl0InE4PjCDSEnQAyjj6Ob81C30/p+AbDZsNWFAjnbkwg89ST8WqrcIo2pcvVVfIvMKwMaUn0E4aciLPvD540Y4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:9791ed34-ceb7-4039-b70d-a13e9e6bd5d6,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:9791ed34-ceb7-4039-b70d-a13e9e6bd5d6,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:e30dec2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221127164504AF8W1MLR,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 534304b763be4b7a8fb82ed53f9f4a24-20221127
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 999147435; Sun, 27 Nov 2022 16:45:03 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sun, 27 Nov 2022 16:45:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sun, 27 Nov 2022 16:45:02 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: fix endianness of mt7915_mcu_set_obss_spr_pd()
Date:   Sun, 27 Nov 2022 16:45:00 +0800
Message-ID: <ff2080860ee5b28f7dcde70bada720ba55b0bac5.1669538240.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix sparse: sparse: incorrect type in assignment (different base types).

Fixes: a6335031eb96 ("wifi: mt76: mt7915: add support to configure spatial reuse parameter set")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 7a6cb25fdaed..9e479d41eab5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3438,8 +3438,8 @@ mt7915_mcu_set_obss_spr_pd(struct mt7915_phy *phy,
 	if (he_obss_pd->sr_ctrl & IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT)
 		req.param.pd_th_srg = max_th - he_obss_pd->max_offset;
 
-	req.param.obss_pd_min = 82;
-	req.param.obss_pd_min_srg = 82;
+	req.param.obss_pd_min = cpu_to_le16(82);
+	req.param.obss_pd_min_srg = cpu_to_le16(82);
 	req.param.txpwr_restrict_mode = 2;
 	req.param.txpwr_ref = 21;
 
-- 
2.36.1

