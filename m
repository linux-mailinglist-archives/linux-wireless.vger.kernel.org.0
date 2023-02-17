Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96AD69B20E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 18:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBQRuq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 12:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBQRup (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 12:50:45 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D3E54D0C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 09:50:44 -0800 (PST)
X-UUID: 980efed0aeeb11ed945fc101203acc17-20230218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tMcnGa3U3EjcvxM880Qvd1d5nOYqaSAgka7dmP9myKc=;
        b=WEi/DBXKJrHh0AzL8dx9hhwjl49XJ3Uughqb7CVjBLXE14ZOydMNy891uCbnetVJLe4rfk+L1KraNR6FY78fWRfCsGWrlw7MrBpPkfyN0OrUSu7GenmZuGc07wH5lkeaR27OrAqVduhveRzTmr04buWXxc5U+RWP4Po36p+XAo0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:16d08978-66a0-4675-8182-4b6af53741bc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.19,REQID:16d08978-66a0-4675-8182-4b6af53741bc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:885ddb2,CLOUDID:a43acbb0-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230218015041D4IF0GUE,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 980efed0aeeb11ed945fc101203acc17-20230218
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1126066376; Sat, 18 Feb 2023 01:50:41 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 18 Feb 2023 01:50:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 18 Feb 2023 01:50:39 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] wifi: mt76: connac: refresh tx session timer for WED device
Date:   Sat, 18 Feb 2023 01:50:38 +0800
Message-ID: <63513d0d570ddfda327714ff15bbf9de7b31c8ce.1676616450.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <7c3f72eac1c34921cd84a462e60d71e125862152.1676616450.git.ryder.lee@mediatek.com>
References: <7c3f72eac1c34921cd84a462e60d71e125862152.1676616450.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There's no keep-alive packet being received by mac80211 stack when WED
is enabled, which leads to tx BA session timeout. This patch calls
ieee80211_refresh_tx_agg_session_timer() to refresh timer according
to tx status reporting.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index aed4ee95fb2e..8d316d3aab8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -582,6 +582,17 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 			le32_get_bits(txs_data[6], MT_TXS6_MPDU_FAIL_CNT);
 		stats->tx_retries +=
 			le32_get_bits(txs_data[7], MT_TXS7_MPDU_RETRY_CNT);
+
+		if (wcid->sta) {
+			struct ieee80211_sta *sta;
+			u8 tid;
+
+			sta = container_of((void *)wcid, struct ieee80211_sta,
+					   drv_priv);
+			tid = FIELD_GET(MT_TXS0_TID, txs);
+
+			ieee80211_refresh_tx_agg_session_timer(sta, tid);
+		}
 	}
 
 	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
-- 
2.18.0

