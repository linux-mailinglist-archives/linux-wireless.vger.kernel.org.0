Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F13369D8B1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Feb 2023 03:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjBUCng (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 21:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjBUCnb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 21:43:31 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD701BDB
        for <linux-wireless@vger.kernel.org>; Mon, 20 Feb 2023 18:43:29 -0800 (PST)
X-UUID: 81efce42b19111eda06fc9ecc4dadd91-20230221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3Z9XstlmW3LgKWVrU6Kb51CuDUUWk7EEvQ9L8T83Bak=;
        b=W2o94xpG5hb9LF4MHANx+wh9KpSKRz50lQtJIVPF5tRGD0PDc6xkqX+GuzL8ouJMEcajPuhxpYxIsGvo/sJBQaD8eTPdrXgsNlL630fXjVRmQU/ZiXyBB5+IJ+6XLWlJd+2YMMIEq+n7CVfRBBKyQl42hGDb1vh3Q8+fUvWqrQc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:e6ce037f-82b0-4b08-8f7e-df4cd84b0544,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.19,REQID:e6ce037f-82b0-4b08-8f7e-df4cd84b0544,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:885ddb2,CLOUDID:95882d26-564d-42d9-9875-7c868ee415ec,B
        ulkID:2302211043244NOET1K9,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 81efce42b19111eda06fc9ecc4dadd91-20230221
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1246451958; Tue, 21 Feb 2023 10:43:22 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 21 Feb 2023 10:43:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 21 Feb 2023 10:43:22 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: rework init flow in mt7915_thermal_init()
Date:   Tue, 21 Feb 2023 10:43:17 +0800
Message-ID: <20230221024317.3218-1-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If kernel do not enable CONFIG_HWMON, it may cause thermal
initialization to be done with temperature value 0 and then can not
transmit. This commit fixes it by setting trigger/restore temperature
before checking CONFIG_HWMON.

Fixes: 7d12b38 ("wifi: mt76: mt7915: call mt7915_mcu_set_thermal_throttling() only after init_work")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 1ab768feccaa..c48dcb928649 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -202,6 +202,10 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 			phy->cdev = cdev;
 	}
 
+	/* initialize critical/maximum high temperature */
+	phy->throttle_temp[MT7915_CRIT_TEMP_IDX] = MT7915_CRIT_TEMP;
+	phy->throttle_temp[MT7915_MAX_TEMP_IDX] = MT7915_MAX_TEMP;
+
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return 0;
 
@@ -210,10 +214,6 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
 
-	/* initialize critical/maximum high temperature */
-	phy->throttle_temp[MT7915_CRIT_TEMP_IDX] = MT7915_CRIT_TEMP;
-	phy->throttle_temp[MT7915_MAX_TEMP_IDX] = MT7915_MAX_TEMP;
-
 	return 0;
 }
 
-- 
2.18.0

