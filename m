Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213FA5849A7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 04:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiG2CPb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 22:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2CPa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 22:15:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D358193FE
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 19:15:23 -0700 (PDT)
X-UUID: 7ecbbf46ba4f485896c412c2ff699a36-20220729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:096d1839-ff88-47db-9f42-921a58760a42,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:9c85a2d0-841b-4e95-ad42-8f86e18f54fc,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 7ecbbf46ba4f485896c412c2ff699a36-20220729
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1845451508; Fri, 29 Jul 2022 10:15:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 29 Jul 2022 10:15:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 29 Jul 2022 10:15:16 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Johannes Berg <johannes.berg@intel.com>
CC:     <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: read ethtool's sta_stats from sinfo
Date:   Fri, 29 Jul 2022 10:15:15 +0800
Message-ID: <ccfce8848c7bf7199ab90ccf3b4b14e1c7633385.1659060644.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Driver may update sinfo directly through .sta_statistics, so this
patch makes sure that ethool gets the correct statistics.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/mac80211/ethtool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 31cd3c1ac07f..26d7a967f10a 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -83,17 +83,17 @@ static void ieee80211_get_stats(struct net_device *dev,
 
 #define ADD_STA_STATS(sta)					\
 	do {							\
-		data[i++] += sta->rx_stats.packets;		\
-		data[i++] += sta->rx_stats.bytes;		\
+		data[i++] += sinfo.rx_packets;			\
+		data[i++] += sinfo.rx_bytes;			\
 		data[i++] += sta->rx_stats.num_duplicates;	\
 		data[i++] += sta->rx_stats.fragments;		\
-		data[i++] += sta->rx_stats.dropped;		\
+		data[i++] += sinfo.rx_dropped_misc;		\
 								\
 		data[i++] += sinfo.tx_packets;			\
 		data[i++] += sinfo.tx_bytes;			\
 		data[i++] += sta->status_stats.filtered;	\
-		data[i++] += sta->status_stats.retry_failed;	\
-		data[i++] += sta->status_stats.retry_count;	\
+		data[i++] += sinfo.tx_failed;			\
+		data[i++] += sinfo.tx_retries;			\
 	} while (0)
 
 	/* For Managed stations, find the single station based on BSSID
-- 
2.36.1

