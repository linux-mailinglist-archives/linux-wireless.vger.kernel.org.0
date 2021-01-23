Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86431301400
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 09:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbhAWIho (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 03:37:44 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50154 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726962AbhAWIhf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 03:37:35 -0500
X-UUID: 87d39f144a4c4eaf878f0321610781a5-20210123
X-UUID: 87d39f144a4c4eaf878f0321610781a5-20210123
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1572550422; Sat, 23 Jan 2021 16:35:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 23 Jan 2021 16:35:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Jan 2021 16:35:18 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH -next v7 22/22] mt76: mt7921: add sta statistics
Date:   Sat, 23 Jan 2021 16:35:13 +0800
Message-ID: <8885b6803848b5a4302b523d9cf7430c05478280.1611389300.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611389300.git.objelf@gmail.com>
References: <cover.1611389300.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EF34D0D19CA955ACC7A0044D39A2FFDDA87272A98BB2A7346AB4CD4CEA8C427A2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add sta statistics support to query current tx bitrate

Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index cc1fea7d3bb2..2ec1a1270ae8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1095,6 +1095,31 @@ static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
 }
 #endif /* CONFIG_PM */
 
+static void mt7921_sta_statistics(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta,
+				  struct station_info *sinfo)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt7921_sta_stats *stats = &msta->stats;
+
+	if (!stats->tx_rate.legacy && !stats->tx_rate.flags)
+		return;
+
+	if (stats->tx_rate.legacy) {
+		sinfo->txrate.legacy = stats->tx_rate.legacy;
+	} else {
+		sinfo->txrate.mcs = stats->tx_rate.mcs;
+		sinfo->txrate.nss = stats->tx_rate.nss;
+		sinfo->txrate.bw = stats->tx_rate.bw;
+		sinfo->txrate.he_gi = stats->tx_rate.he_gi;
+		sinfo->txrate.he_dcm = stats->tx_rate.he_dcm;
+		sinfo->txrate.he_ru_alloc = stats->tx_rate.he_ru_alloc;
+	}
+	sinfo->txrate.flags = stats->tx_rate.flags;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+}
+
 const struct ieee80211_ops mt7921_ops = {
 	.tx = mt7921_tx,
 	.start = mt7921_start,
@@ -1132,4 +1157,5 @@ const struct ieee80211_ops mt7921_ops = {
 	.set_wakeup = mt7921_set_wakeup,
 	.set_rekey_data = mt7921_set_rekey_data,
 #endif /* CONFIG_PM */
+	.sta_statistics = mt7921_sta_statistics,
 };
-- 
2.25.1

