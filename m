Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6F42E73C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Oct 2021 05:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhJODct (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Oct 2021 23:32:49 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:47228 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234152AbhJODct (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Oct 2021 23:32:49 -0400
X-UUID: 8264b49b6c1f4694b55261c87dc5c7af-20211015
X-UUID: 8264b49b6c1f4694b55261c87dc5c7af-20211015
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 971098581; Fri, 15 Oct 2021 11:30:40 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 15 Oct 2021 11:30:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 15 Oct
 2021 11:30:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Oct 2021 11:30:40 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v6 7/8] mt76: mt7915: set VTA bit in tx descriptor
Date:   Fri, 15 Oct 2021 11:29:37 +0800
Message-ID: <20211015032938.7493-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211015032938.7493-1-shayne.chen@mediatek.com>
References: <20211015032938.7493-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The VTA (Valid for Txd Arrival time) bit should be set in tx descriptor,
which is necessary for WM fw to schedule SPL (station priority list)
normally before generating txcmd.
If it's not set, some unexpected wcids may be involved in SPL.

Suggested-by: Nelson Chang <nelson.chang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b992fdd..d3d220f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1068,7 +1068,7 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
 	txwi[0] = cpu_to_le32(val);
 
-	val = MT_TXD1_LONG_FORMAT |
+	val = MT_TXD1_LONG_FORMAT | MT_TXD1_VTA |
 	      FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
 	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
 
-- 
2.25.1

