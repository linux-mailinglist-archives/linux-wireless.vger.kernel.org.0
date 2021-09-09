Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5199D4046DA
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 10:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhIIIQi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Sep 2021 04:16:38 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44870 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231426AbhIIIQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Sep 2021 04:16:37 -0400
X-UUID: e4fbee25def34d418faeac10a35e4490-20210909
X-UUID: e4fbee25def34d418faeac10a35e4490-20210909
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 116656672; Thu, 09 Sep 2021 16:15:26 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 9 Sep 2021 16:15:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 9 Sep
 2021 16:15:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Sep 2021 16:15:18 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v4 4/8] mt76: mt7915: fix sta_rec_wtbl tag len
Date:   Thu, 9 Sep 2021 16:15:08 +0800
Message-ID: <20210909081512.5037-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210909081512.5037-1-shayne.chen@mediatek.com>
References: <20210909081512.5037-1-shayne.chen@mediatek.com>
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

