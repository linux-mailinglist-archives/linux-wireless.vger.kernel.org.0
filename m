Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B95F3EBBDD
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 20:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhHMSKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 14:10:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42758 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229612AbhHMSJ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 14:09:58 -0400
X-UUID: dfdd940a67934b0f920b4f23945fa58b-20210814
X-UUID: dfdd940a67934b0f920b4f23945fa58b-20210814
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1152631553; Sat, 14 Aug 2021 02:09:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 14 Aug 2021 02:09:20 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 14 Aug 2021 02:09:21 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] mt76: mt7921: fix kernel warning from cfg80211_calculate_bitrate
Date:   Sat, 14 Aug 2021 02:09:18 +0800
Message-ID: <a781b573380564be395500898269f27e5e4d2ba9.1628877755.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fix the kernel warning from cfg80211_calculate_bitrate
due to the legacy rate is not parsed well in the current driver.

Also, zeros struct rate_info before we fill it out to avoid the old value
is kept such as rate->legacy.

[  790.921560] WARNING: CPU: 7 PID: 970 at net/wireless/util.c:1298 cfg80211_calculate_bitrate+0x354/0x35c [cfg80211]
[  790.987738] Hardware name: MediaTek Asurada rev1 board (DT)
[  790.993298] pstate: a0400009 (NzCv daif +PAN -UAO)
[  790.998104] pc : cfg80211_calculate_bitrate+0x354/0x35c [cfg80211]
[  791.004295] lr : cfg80211_calculate_bitrate+0x180/0x35c [cfg80211]
[  791.010462] sp : ffffffc0129c3880
[  791.013765] x29: ffffffc0129c3880 x28: ffffffd38305bea8
[  791.019065] x27: ffffffc0129c3970 x26: 0000000000000013
[  791.024364] x25: 00000000000003ca x24: 000000000000002f
[  791.029664] x23: 00000000000000d0 x22: ffffff8d108bc000
[  791.034964] x21: ffffff8d108bc0d0 x20: ffffffc0129c39a8
[  791.040264] x19: ffffffc0129c39a8 x18: 00000000ffff0a10
[  791.045563] x17: 0000000000000050 x16: 00000000000000ec
[  791.050910] x15: ffffffd3f9ebed9c x14: 0000000000000006
[  791.056211] x13: 00000000000b2eea x12: 0000000000000000
[  791.061511] x11: 00000000ffffffff x10: 0000000000000000
[  791.066811] x9 : 0000000000000000 x8 : 0000000000000000
[  791.072110] x7 : 0000000000000000 x6 : ffffffd3fafa5a7b
[  791.077409] x5 : 0000000000000000 x4 : 0000000000000000
[  791.082708] x3 : 0000000000000000 x2 : 0000000000000000
[  791.088008] x1 : ffffff8d3f79c918 x0 : 0000000000000000
[  791.093308] Call trace:
[  791.095770]  cfg80211_calculate_bitrate+0x354/0x35c [cfg80211]
[  791.101615]  nl80211_put_sta_rate+0x6c/0x2c0 [cfg80211]
[  791.106853]  nl80211_send_station+0x980/0xaa4 [cfg80211]
[  791.112178]  nl80211_get_station+0xb4/0x134 [cfg80211]
[  791.117308]  genl_rcv_msg+0x3a0/0x440
[  791.120960]  netlink_rcv_skb+0xcc/0x118
[  791.124785]  genl_rcv+0x34/0x48
[  791.127916]  netlink_unicast+0x144/0x1dc

Fixes: 1c099ab44727 ("mt76: mt7921: add MCU support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: don't do unnecessary line removal
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index cadb633639d3..9b35b5da3619 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -328,11 +328,13 @@ mt7921_mcu_tx_rate_parse(struct mt76_phy *mphy,
 			 struct rate_info *rate, u16 r)
 {
 	struct ieee80211_supported_band *sband;
-	u16 flags = 0;
+	u16 flags = 0, rate_idx;
 	u8 txmode = FIELD_GET(MT_WTBL_RATE_TX_MODE, r);
 	u8 gi = 0;
 	u8 bw = 0;
+	bool cck = false;
 
+	memset(rate, 0, sizeof(*rate));
 	rate->mcs = FIELD_GET(MT_WTBL_RATE_MCS, r);
 	rate->nss = FIELD_GET(MT_WTBL_RATE_NSS, r) + 1;
 
@@ -357,13 +359,18 @@ mt7921_mcu_tx_rate_parse(struct mt76_phy *mphy,
 
 	switch (txmode) {
 	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
 	case MT_PHY_TYPE_OFDM:
 		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
 			sband = &mphy->sband_5g.sband;
 		else
 			sband = &mphy->sband_2g.sband;
 
-		rate->legacy = sband->bitrates[rate->mcs].bitrate;
+		rate_idx = FIELD_GET(MT_TX_RATE_IDX, r);
+		rate_idx = mt76_get_rate(mphy->dev, sband, rate_idx,
+					 cck);
+		rate->legacy = sband->bitrates[rate_idx].bitrate;
 		break;
 	case MT_PHY_TYPE_HT:
 	case MT_PHY_TYPE_HT_GF:
-- 
2.25.1

