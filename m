Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818EB79EB64
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbjIMOoe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 10:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241436AbjIMOod (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 10:44:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD0191
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 07:44:28 -0700 (PDT)
X-UUID: 08075e84524411eea33bb35ae8d461a2-20230913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GtO7l74MiDOCASn4v8QtrTO68migCuNl/oaqN3ri9ic=;
        b=DZkCffg5/qPTibTv63VRmuY75p9N7xJ7hEqKSUj0HJ9G6hpu9L0AA4awjEShkV2Z7DvWO6nJxELn4SUk87eTOkSh5ZEOUdre83wc40d10miEgH4sOcW3zKVBgY6X+IImtEY+OpXurIOvviwGg7EhQkdL24PChYjPBhAn0xfg4As=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:498ac735-af62-4965-9ca6-1af203f8cbb8,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:0ad78a4,CLOUDID:1eaafcc2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 08075e84524411eea33bb35ae8d461a2-20230913
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1740494823; Wed, 13 Sep 2023 22:44:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Sep 2023 22:44:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Sep 2023 22:44:23 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2 08/17] wifi: mt76: mt7925: add mac.h
Date:   Wed, 13 Sep 2023 22:43:36 +0800
Message-ID: <40f14854b656ee26926a5ffa6260db6b95ef418b.1694595134.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1694595134.git.deren.wu@mediatek.com>
References: <cover.1694595134.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mac.h   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mac.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.h b/drivers/net/wireless/mediatek/mt76/mt7925/mac.h
new file mode 100644
index 000000000000..b10a993326b9
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#ifndef __MT7925_MAC_H
+#define __MT7925_MAC_H
+
+#include "../mt76_connac3_mac.h"
+
+#define MT_WTBL_TXRX_CAP_RATE_OFFSET	7
+#define MT_WTBL_TXRX_RATE_G2_HE		24
+#define MT_WTBL_TXRX_RATE_G2		12
+
+#define MT_WTBL_AC0_CTT_OFFSET		20
+
+static inline u32 mt7925_mac_wtbl_lmac_addr(struct mt792x_dev *dev, u16 wcid, u8 dw)
+{
+	mt76_wr(dev, MT_WTBLON_TOP_WDUCR,
+		FIELD_PREP(MT_WTBLON_TOP_WDUCR_GROUP, (wcid >> 7)));
+
+	return MT_WTBL_LMAC_OFFS(wcid, dw);
+}
+
+#endif
-- 
2.18.0

