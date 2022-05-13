Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D20525C50
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 09:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377793AbiEMHUL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 03:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377786AbiEMHUF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 03:20:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABF62AA2C4
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 00:19:59 -0700 (PDT)
X-UUID: 1b18e5f55e4e4342ad9396f2cffc441e-20220513
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:5c111e56-be8d-47ba-9138-6863e8ea2fe3,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.5,REQID:5c111e56-be8d-47ba-9138-6863e8ea2fe3,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:2a19b09,CLOUDID:af962ca7-eab7-4b74-a74d-5359964535a9,C
        OID:202dd7195bdb,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 1b18e5f55e4e4342ad9396f2cffc441e-20220513
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <evelyn.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1346203577; Fri, 13 May 2022 15:19:50 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 13 May 2022 15:19:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 May 2022 15:19:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 May 2022 15:19:49 +0800
From:   Evelyn Tsai <evelyn.tsai@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [PATCH] mac80211: Use ATF by NL80211_EXT_FEATURE_AIRTIME_FAIRNESS
Date:   Fri, 13 May 2022 15:19:48 +0800
Message-ID: <20220513071948.2419-1-evelyn.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Except for using debugfs to change airtime_flags (AIRTIME_USE_TX/RX),
turn ATF into a proper NL80211_EXT_FEATURE, so the driver can determine
whether using airtime scheduling.

Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 net/mac80211/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 5311c3cd3050..89542bed7d89 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -717,7 +717,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 			IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
 	}
 
-	local->airtime_flags = AIRTIME_USE_TX | AIRTIME_USE_RX;
+	if (wiphy_ext_feature_isset(local->hw.wiphy,
+				    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
+		local->airtime_flags = AIRTIME_USE_TX | AIRTIME_USE_RX;
 	local->aql_threshold = IEEE80211_AQL_THRESHOLD;
 	atomic_set(&local->aql_total_pending_airtime, 0);
 
-- 
2.29.2

