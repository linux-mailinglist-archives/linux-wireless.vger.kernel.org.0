Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667F7553FDD
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 03:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiFVBIk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 21:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiFVBIj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 21:08:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC23151F
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 18:08:29 -0700 (PDT)
X-UUID: 4b39f25fe280440fa0576a74881d73e3-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:d72e158a-197d-48a1-973d-5ddde4381b28,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.6,REQID:d72e158a-197d-48a1-973d-5ddde4381b28,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:b14ad71,CLOUDID:1980af2d-1756-4fa3-be7f-474a6e4be921,C
        OID:a66b5be96c4e,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4b39f25fe280440fa0576a74881d73e3-20220622
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1294573829; Wed, 22 Jun 2022 09:08:23 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 09:08:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 22 Jun 2022 09:08:22 +0800
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Johannes Berg <johannes.berg@intel.com>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Peter Chiu" <chui-hao.chiu@mediatek.com>
Subject: [PATCH] mac80211: add s1g action frame in _ieee80211_is_robust_mgmt_frame
Date:   Wed, 22 Jun 2022 09:08:20 +0800
Message-ID: <20220622010820.17522-1-chui-hao.chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

S1g action frame with code 22 is not protected so update the robust
action frame list.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
 include/linux/ieee80211.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 5c65ae6b8..4c25207b3 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4094,6 +4094,7 @@ static inline bool _ieee80211_is_robust_mgmt_frame(struct ieee80211_hdr *hdr)
 			*category != WLAN_CATEGORY_SELF_PROTECTED &&
 			*category != WLAN_CATEGORY_UNPROT_DMG &&
 			*category != WLAN_CATEGORY_VHT &&
+			*category != WLAN_CATEGORY_S1G &&
 			*category != WLAN_CATEGORY_VENDOR_SPECIFIC;
 	}
 
-- 
2.18.0

