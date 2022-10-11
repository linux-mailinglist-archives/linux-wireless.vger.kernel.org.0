Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6945FAA74
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 04:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJKCED (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 22:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJKCEB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 22:04:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA4682865
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 19:04:00 -0700 (PDT)
X-UUID: 35ca98a640d540d090ff832d572fcd56-20221011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CxXP6CzobnL6sVNisn2kNutVrGf5dAauzM+XPwU5cAc=;
        b=bEQRRGuJo47tAq44Qf+ExrlWkzc4cILvjdl5NzZU+RcHq6mVTf6Otu6/ouOEySRXQS6eTkO2mGOueFyFkYXKXCPpy2T95UZSSp0FEQYD4KEleNNJaogDXj882u01w4H/9rxuv17j3dnQbbPQqSsOrQWJfp6eQcxc0kDITIpOn9g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:7f52eaa1-959d-4f49-9fd4-3df1190fe381,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:-32768,SF:-32768,FILE:0,BULK:-32768,RULE:Rel
        ease_Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:49e50901-cdeb-479d-93af-53f947adce9d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 35ca98a640d540d090ff832d572fcd56-20221011
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 48326364; Tue, 11 Oct 2022 10:03:46 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 11 Oct 2022 10:03:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 11 Oct 2022 10:03:44 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: prevent unexpected nss setting from eeprom
Date:   Tue, 11 Oct 2022 10:03:43 +0800
Message-ID: <efa6ba9cd8ad5124f58e05155cc05008b14c5edf.1665453585.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a check to prevent unexpected nss configuration from eeprom.

Fixes: 4d8053df67c5 ("wifi: mt76: mt7915: rework eeprom tx paths and streams init")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index e2482c65d639..6c5155223087 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -191,7 +191,6 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 		path = 4;
 
 	/* read tx/rx stream */
-	nss = path;
 	if (dev->dbdc_support) {
 		if (is_mt7915(&dev->mt76)) {
 			nss = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
@@ -206,6 +205,11 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 
 		if (!is_mt7986(&dev->mt76))
 			nss_max = 2;
+
+		if (!nss)
+			nss = nss_max;
+	} else {
+		nss = path;
 	}
 
 	nss = min_t(u8, min_t(u8, nss_max, nss), path);
-- 
2.36.1

