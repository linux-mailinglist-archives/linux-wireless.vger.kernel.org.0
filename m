Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF661486091
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jan 2022 07:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiAFGV3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 01:21:29 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:36112 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229890AbiAFGV3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 01:21:29 -0500
X-UUID: 3a897a5a89024a19952a4fd16c3b0af9-20220106
X-UUID: 3a897a5a89024a19952a4fd16c3b0af9-20220106
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1075290722; Thu, 06 Jan 2022 14:21:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 6 Jan 2022 14:21:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 14:21:25 +0800
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Peter Chiu" <chui-hao.chiu@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7915: fix ht mcs in mt7915_mac_add_txs_skb()
Date:   Thu, 6 Jan 2022 14:20:56 +0800
Message-ID: <20220106062057.14981-1-chui-hao.chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The mcs value of HT mode reported by mt7915_mac_add_txs_skb()
has already been converted to the expected format.

Fixes: 9908d98ae72cd ("mt76: mt7915: report tx rate directly from tx status")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index a6770fd40b34..5368a3e276c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1568,7 +1568,6 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		break;
 	case MT_PHY_TYPE_HT:
 	case MT_PHY_TYPE_HT_GF:
-		rate.mcs += (rate.nss - 1) * 8;
 		if (rate.mcs > 31)
 			goto out;
 
-- 
2.29.2

