Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A8442E73F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Oct 2021 05:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbhJODcz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Oct 2021 23:32:55 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:47252 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234193AbhJODcu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Oct 2021 23:32:50 -0400
X-UUID: dc7bbb54b2f84329b20e61b1d9242d6d-20211015
X-UUID: dc7bbb54b2f84329b20e61b1d9242d6d-20211015
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 30336469; Fri, 15 Oct 2021 11:30:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 15 Oct 2021 11:30:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Oct 2021 11:30:39 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v6 6/8] mt76: mt7915: fix muar_idx in mt7915_mcu_alloc_sta_req()
Date:   Fri, 15 Oct 2021 11:29:36 +0800
Message-ID: <20211015032938.7493-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211015032938.7493-1-shayne.chen@mediatek.com>
References: <20211015032938.7493-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For broadcast/multicast wcid, the muar_idx should be 0xe.

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
v6: remove line break of fix tag
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index cd31cb1..9ad7e8e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -586,7 +586,7 @@ mt7915_mcu_alloc_sta_req(struct mt7915_dev *dev, struct mt7915_vif *mvif,
 		.bss_idx = mvif->idx,
 		.wlan_idx_lo = msta ? to_wcid_lo(msta->wcid.idx) : 0,
 		.wlan_idx_hi = msta ? to_wcid_hi(msta->wcid.idx) : 0,
-		.muar_idx = msta ? mvif->omac_idx : 0,
+		.muar_idx = msta && msta->wcid.sta ? mvif->omac_idx : 0xe,
 		.is_tlv_append = 1,
 	};
 	struct sk_buff *skb;
-- 
2.25.1

