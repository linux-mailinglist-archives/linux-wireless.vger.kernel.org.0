Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C8076B7A4
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjHAOfw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjHAOfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:35:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713181702
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:35:50 -0700 (PDT)
X-UUID: b1d7a6fa307811ee9cb5633481061a41-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OhQsN1QHxfD0mrFyOb1zYqkCf1B8R/ejG1MPBioqGHs=;
        b=Liu+hfzWhf0wCmLgm/XRiLH3a/E71g0cIN/EKUnheEMoXCyhIKDvH257bgpFqlfHOWAyjLLGsG7rojqk3G9y2O3axK8Oe+R474CMkAqX0woLXwidZ7AxjDvNNiNYrikczsmaROc/of37KgaVsyrKvEa3OVGyETwIdL9x0d8xR/0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:ddbae092-75bd-4428-99f3-db4b631ebe6d,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:1fcc6f8,CLOUDID:d38e91d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b1d7a6fa307811ee9cb5633481061a41-20230801
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 390494108; Tue, 01 Aug 2023 22:35:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 22:35:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 22:35:42 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 01/17] wifi: mt76: mt7925: add Kconfig
Date:   Tue, 1 Aug 2023 22:34:17 +0800
Message-ID: <562eb3e0a4ae65007d59d0101746f505ec18b7e6.1690864199.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1690864199.git.deren.wu@mediatek.com>
References: <cover.1690864199.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/Kconfig | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/Kconfig

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7925/Kconfig
new file mode 100644
index 000000000000..5854e95e68a5
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/Kconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: ISC
+config MT7925_COMMON
+	tristate
+	select MT792x_LIB
+	select WANT_DEV_COREDUMP
+
+config MT7925E
+	tristate "MediaTek MT7925E (PCIe) support"
+	select MT7925_COMMON
+	depends on MAC80211
+	depends on PCI
+	help
+	  This adds support for MT7925-based wireless PCIe devices,
+	  which support operation at 6GHz, 5GHz, and 2.4GHz IEEE 802.11be
+	  2x2:2SS 4096-QAM, 160MHz channels.
+
+	  To compile this driver as a module, choose M here.
+
+config MT7925U
+	tristate "MediaTek MT7925U (USB) support"
+	select MT792x_USB
+	select MT7925_COMMON
+	depends on MAC80211
+	depends on USB
+	help
+	  This adds support for MT7925-based wireless USB devices,
+	  which support operation at 6GHz, 5GHz, and 2.4GHz IEEE 802.11be
+	  2x2:2SS 4096-QAM, 160MHz channels.
+
+	  To compile this driver as a module, choose M here.
-- 
2.18.0

