Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9EB64C241
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 03:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiLNC20 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Dec 2022 21:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbiLNC2Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Dec 2022 21:28:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1EF1F9F3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 18:28:24 -0800 (PST)
X-UUID: 91d08b2ca5c14806928d8e52eb3de9de-20221214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=L926ZhafewJStmjMylo4c48rggKUDrBSQaRHkO641RU=;
        b=pM6q273zWrUYuPZO7YlMECalFnP5XU3/n06Lf69pNXd8jDwqyVagA9qNhjRkwsEEjcwCoAz2ciUHXymq2ddlu0TIOFN61thoO3OfB2rzlEzqAaZ2vcdav6fZPU0zYjxOuZemSwMykDZAqmZJcXfam2UVGI1ZIZEaHoGHhvHskfE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:ae4ec058-0736-4461-a892-5737a27398cd,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:dcaaed0,CLOUDID:eae18ad2-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 91d08b2ca5c14806928d8e52eb3de9de-20221214
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 525435307; Wed, 14 Dec 2022 10:28:22 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 14 Dec 2022 10:28:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 14 Dec 2022 10:28:21 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH v3 3/4] wifi: mt76: mt7915: rework mt7915_thermal_temp_store()
Date:   Wed, 14 Dec 2022 10:28:08 +0800
Message-ID: <20221214022809.32087-4-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221214022809.32087-1-howard-yh.hsu@mediatek.com>
References: <20221214022809.32087-1-howard-yh.hsu@mediatek.com>
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

Call mt7915_mcu_set_thermal_protect() through
mt7915_thermal_temp_store() to update firmware trigger/restore temp
directly.

Fixes: 02ee68b95d81 ("mt76: mt7915: add control knobs for thermal throttling")
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c   | 18 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mt7915.h |  3 +++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index be435ae56bbf..0ab9e1320fac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -83,9 +83,23 @@ static ssize_t mt7915_thermal_temp_store(struct device *dev,
 
 	mutex_lock(&phy->dev->mt76.mutex);
 	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 60, 130);
+
+	if ((i - 1 == MT7915_CRIT_TEMP_IDX &&
+	     val > phy->throttle_temp[MT7915_MAX_TEMP_IDX]) ||
+	    (i - 1 == MT7915_MAX_TEMP_IDX &&
+	     val < phy->throttle_temp[MT7915_CRIT_TEMP_IDX])) {
+		dev_err(phy->dev->mt76.dev,
+			"temp1_max shall be greater than temp1_crit.");
+		return -EINVAL;
+	}
+
 	phy->throttle_temp[i - 1] = val;
 	mutex_unlock(&phy->dev->mt76.mutex);
 
+	ret = mt7915_mcu_set_thermal_protect(phy);
+	if (ret)
+		return ret;
+
 	return count;
 }
 
@@ -195,8 +209,8 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 		return PTR_ERR(hwmon);
 
 	/* initialize critical/maximum high temperature */
-	phy->throttle_temp[0] = 110;
-	phy->throttle_temp[1] = 120;
+	phy->throttle_temp[MT7915_CRIT_TEMP_IDX] = 110;
+	phy->throttle_temp[MT7915_MAX_TEMP_IDX] = 120;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 855779f86bde..e58650bbbd14 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -70,6 +70,9 @@
 
 #define MT7915_WED_RX_TOKEN_SIZE	12288
 
+#define MT7915_CRIT_TEMP_IDX		0
+#define MT7915_MAX_TEMP_IDX		1
+
 struct mt7915_vif;
 struct mt7915_sta;
 struct mt7915_dfs_pulse;
-- 
2.18.0

