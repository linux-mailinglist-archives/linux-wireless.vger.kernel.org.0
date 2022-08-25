Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E705A1C72
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 00:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243476AbiHYWdc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 18:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiHYWda (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 18:33:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B94B99DA
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 15:33:24 -0700 (PDT)
X-UUID: 69d3c12e47344a7fbacafb5cf2ae1462-20220826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=t2alrwEYy46XNmgg17O9/mwJMo7NuDF98DRafstob3Y=;
        b=NBUSoEXAFYg7ZNSZtf5wuku9xZCsoCpaiPv9p7I0y3topSiQ15tbUw1C0k5hOuj74ZJ37aP2RMTo7i3fwoX+iqDmB7jRie3Yb5XGIzGQA56g2EMPr0j10gvqt8jewMETzD3KIHYU8P3xwihfqQ/w5dysKjSvxrcMvoTKcQQ63i8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:aeb959d0-58fe-40df-aa6f-fe48fd465ec7,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.10,REQID:aeb959d0-58fe-40df-aa6f-fe48fd465ec7,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:100
X-CID-META: VersionHash:84eae18,CLOUDID:98e1a1cf-20bd-4e5e-ace8-00692b7ab380,C
        OID:eff2868b7b6d,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 69d3c12e47344a7fbacafb5cf2ae1462-20220826
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 135485452; Fri, 26 Aug 2022 06:33:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 26 Aug 2022 06:33:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 26 Aug 2022 06:33:17 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Johannes Berg <johannes.berg@intel.com>
CC:     <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] wifi: mac80211: read ethtool's sta_stats from sinfo
Date:   Fri, 26 Aug 2022 06:33:16 +0800
Message-ID: <f9edff14dd7f5205acf1c21bae8e9d8f9802dd88.1661466499.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        URIBL_CSS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Driver may update sinfo directly through .sta_statistics, so this
patch makes sure that ethool gets the correct statistics.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2 - rebase on wireless-next
---
 net/mac80211/ethtool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index c2b38370bfb1..a3830d925cc2 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -83,17 +83,17 @@ static void ieee80211_get_stats(struct net_device *dev,
 
 #define ADD_STA_STATS(sta)					\
 	do {							\
-		data[i++] += (sta)->rx_stats.packets;		\
-		data[i++] += (sta)->rx_stats.bytes;		\
+		data[i++] += sinfo.rx_packets;			\
+		data[i++] += sinfo.rx_bytes;			\
 		data[i++] += (sta)->rx_stats.num_duplicates;	\
 		data[i++] += (sta)->rx_stats.fragments;		\
-		data[i++] += (sta)->rx_stats.dropped;		\
+		data[i++] += sinfo.rx_dropped_misc;		\
 								\
 		data[i++] += sinfo.tx_packets;			\
 		data[i++] += sinfo.tx_bytes;			\
 		data[i++] += (sta)->status_stats.filtered;	\
-		data[i++] += (sta)->status_stats.retry_failed;	\
-		data[i++] += (sta)->status_stats.retry_count;	\
+		data[i++] += sinfo.tx_failed;			\
+		data[i++] += sinfo.tx_retries;			\
 	} while (0)
 
 	/* For Managed stations, find the single station based on BSSID
-- 
2.36.1

