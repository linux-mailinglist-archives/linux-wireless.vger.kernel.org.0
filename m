Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B923401AB0
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Sep 2021 13:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhIFLqP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Sep 2021 07:46:15 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:39152 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241281AbhIFLqO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Sep 2021 07:46:14 -0400
X-UUID: 2f807ec355f74bbaabbcaac33c73d178-20210906
X-UUID: 2f807ec355f74bbaabbcaac33c73d178-20210906
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 236502573; Mon, 06 Sep 2021 19:45:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkexhb01.mediatek.inc (172.21.101.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 6 Sep 2021 19:45:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 6 Sep 2021 19:45:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Sep 2021 19:45:05 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 4/8] mt76: mt7915: fix sta_rec_wtbl tag len
Date:   Mon, 6 Sep 2021 19:44:19 +0800
Message-ID: <20210906114423.13646-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210906114423.13646-1-shayne.chen@mediatek.com>
References: <20210906114423.13646-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix tag len error for sta_rec_wtbl, which causes fw parsing error for
the tags placed behind it.

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based
chipsets")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index da40be8daa6e..fa4a98e59f77 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -607,7 +607,7 @@ mt7915_mcu_alloc_wtbl_req(struct mt7915_dev *dev, struct mt7915_sta *msta,
 	}
 
 	if (sta_hdr)
-		sta_hdr->len = cpu_to_le16(sizeof(hdr));
+		le16_add_cpu(&sta_hdr->len, sizeof(hdr));
 
 	return skb_put_data(nskb, &hdr, sizeof(hdr));
 }
-- 
2.25.1

