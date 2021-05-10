Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B050379259
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhEJPSO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 11:18:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56330 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241770AbhEJPQg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 11:16:36 -0400
X-UUID: 17bf50ce860e4fe5a83cbb1ad7f46f44-20210510
X-UUID: 17bf50ce860e4fe5a83cbb1ad7f46f44-20210510
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1801878924; Mon, 10 May 2021 23:15:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 May 2021 23:14:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 May 2021 23:14:59 +0800
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
Subject: [PATCH 7/9] mt76: mt7921: consider the invalid value for to_rssi
Date:   Mon, 10 May 2021 23:14:55 +0800
Message-ID: <1620659697-12048-7-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
References: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3C9240EF2573B67657F9ED857479D90467E4CC8D7E534F832002A2DEABEF7E0B2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

It is possible the RCPI from the certain antenna is an invalid value,
especially packets are receiving while the system is frequently entering
deep sleep mode, so consider calculating RSSI with the reasonable upper
bound to avoid report the wrong value to the mac80211 layer.

Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 44b8918db95b..89a09381cfe4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -461,16 +461,19 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
 		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v1);
 		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v1);
-		status->signal = status->chain_signal[0];
-
-		for (i = 1; i < hweight8(mphy->antenna_mask); i++) {
-			if (!(status->chains & BIT(i)))
+		status->signal = -128;
+		for (i = 0; i < hweight8(mphy->antenna_mask); i++) {
+			if (!(status->chains & BIT(i)) ||
+			    status->chain_signal[i] >= 0)
 				continue;
 
 			status->signal = max(status->signal,
 					     status->chain_signal[i]);
 		}
 
+		if (status->signal == -128)
+			status->flag |= RX_FLAG_NO_SIGNAL_VAL;
+
 		stbc = FIELD_GET(MT_PRXV_STBC, v0);
 		gi = FIELD_GET(MT_PRXV_SGI, v0);
 		cck = false;
-- 
2.25.1

