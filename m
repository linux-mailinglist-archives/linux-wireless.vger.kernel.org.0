Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FD939EF19
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 08:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFHG6P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 02:58:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34861 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230197AbhFHG6P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 02:58:15 -0400
X-UUID: 03260d55308f4dd0a8eaca91bc462469-20210608
X-UUID: 03260d55308f4dd0a8eaca91bc462469-20210608
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1187886286; Tue, 08 Jun 2021 14:56:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 14:56:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 14:56:18 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 1/2] mt76: testmode: move chip-specific stats dump before common stats
Date:   Tue, 8 Jun 2021 14:55:57 +0800
Message-ID: <20210608065558.8117-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move chip-specific stats dumping part before common stats dumping
to provide flexibility for per-chip driver to modify the value of
common stats.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/testmode.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index c6a85a0..f73ffbd 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -521,6 +521,14 @@ mt76_testmode_dump_stats(struct mt76_phy *phy, struct sk_buff *msg)
 	u64 rx_fcs_error = 0;
 	int i;
 
+	if (dev->test_ops->dump_stats) {
+		int ret;
+
+		ret = dev->test_ops->dump_stats(phy, msg);
+		if (ret)
+			return ret;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(td->rx_stats.packets); i++) {
 		rx_packets += td->rx_stats.packets[i];
 		rx_fcs_error += td->rx_stats.fcs_error[i];
@@ -535,9 +543,6 @@ mt76_testmode_dump_stats(struct mt76_phy *phy, struct sk_buff *msg)
 			      MT76_TM_STATS_ATTR_PAD))
 		return -EMSGSIZE;
 
-	if (dev->test_ops->dump_stats)
-		return dev->test_ops->dump_stats(phy, msg);
-
 	return 0;
 }
 
-- 
2.18.0

