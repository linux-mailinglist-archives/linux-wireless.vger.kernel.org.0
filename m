Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D724679EB71
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbjIMOog (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 10:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241415AbjIMOoe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 10:44:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57931A8
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 07:44:30 -0700 (PDT)
X-UUID: 0886052c524411eea33bb35ae8d461a2-20230913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PQDxa2zx1X81lzl1+vipiYWxKX40ZvcKKak1KSbRfVo=;
        b=padZm7wBsWB0cVN+3vTC4jjtj77aMsLAj92hYNistLVbR8yLrxQD3tSRNttPUazrEFJdvUOngN95I+WocwvzLnxAQTUytkqwb1F9M337sxoTrytadqakU48oq4PgE/OYOSB2RXOsgo8CUFubdo5cMWpQkSuweFCMCoBAJlhioLQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:935e9120-6ce7-43d8-a4a4-e250e47d45c8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:4b44a8ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0886052c524411eea33bb35ae8d461a2-20230913
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1399587023; Wed, 13 Sep 2023 22:44:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Sep 2023 22:44:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Sep 2023 22:44:24 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2 16/17] wifi: mt76: add mt7925 to Makefile
Date:   Wed, 13 Sep 2023 22:43:44 +0800
Message-ID: <c76dc537c6575cfa22b2a2e560b03bf7957c44e1.1694595134.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1694595134.git.deren.wu@mediatek.com>
References: <cover.1694595134.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.945700-8.000000
X-TMASE-MatchedRID: E6K/LcOYTbPKRSR886eK0gPZZctd3P4BfS0Ip2eEHnwj/1Rbkzl1E95/
        HgWYxplM5MIx11wv+CPKayT/BQTiGmRC/Be9tHFfUw3dg58guK1eSoDdWjhLENTT9twbPLPvSRg
        IuXfPVjl7g8nCEeZ0VqNqiEMp+bIAN3lVf0HC2I6zVGiGpNbTb0EsBv8VOmZSdATQdtPksR+3/J
        iWOe6GXXSWgQ2GpXdZbxffl9hhCBw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.945700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E3FA70FA19B525EB3D50983E1411946F36628336F5192B405E4FB90FB80D628B2000:8
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
 drivers/net/wireless/mediatek/mt76/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index 85c4799be954..d6575fe18c6b 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_MT7615_COMMON) += mt7615/
 obj-$(CONFIG_MT7915E) += mt7915/
 obj-$(CONFIG_MT7921_COMMON) += mt7921/
 obj-$(CONFIG_MT7996E) += mt7996/
+obj-$(CONFIG_MT7925_COMMON) += mt7925/
-- 
2.18.0

