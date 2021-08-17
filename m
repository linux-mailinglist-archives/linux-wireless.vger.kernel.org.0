Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5B23EEEF9
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 17:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbhHQPMB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 11:12:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37390 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238352AbhHQPL7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 11:11:59 -0400
X-UUID: 69980d906f934727937951f5759e81df-20210817
X-UUID: 69980d906f934727937951f5759e81df-20210817
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1465298048; Tue, 17 Aug 2021 23:11:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 17 Aug 2021 23:11:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Aug 2021 23:11:20 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: add a bound check in mt76_calculate_default_rate()
Date:   Tue, 17 Aug 2021 23:11:19 +0800
Message-ID: <a4f6f434d4ec1e5e381d9765a634b6dd08a08070.1629212578.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

basic_rate could be 0 ie. hidden AP. Always pick the lowest rate
for such cases.

Fixes: 75fb2e62d444 (mt76: add mt76_default_basic_rate more devices can rely on)
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index e282c627e25c..3658328f513b 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1360,6 +1360,10 @@ u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx)
 	if (phy->chandef.chan->band == NL80211_BAND_5GHZ)
 		offset = 4;
 
+	/* pick the lowest rate for hidden nodes */
+	if (rateidx < 0)
+		rateidx = 0;
+
 	rate = &mt76_rates[offset + rateidx];
 
 	return rate->hw_value;
-- 
2.29.2

