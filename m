Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2386A9312
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Mar 2023 09:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCCIvt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Mar 2023 03:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCCIvr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Mar 2023 03:51:47 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F264E5CC
        for <linux-wireless@vger.kernel.org>; Fri,  3 Mar 2023 00:51:46 -0800 (PST)
X-UUID: 7fad4f50b99e11eda06fc9ecc4dadd91-20230303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wfl+wlLFHwlaMXpIMIdFKWw2vPASYSm+VKmoYkZ4zsk=;
        b=GwTHxVVkImwGT3otIPETFdgtF6/uZFIMdnPjr75PT5g33cVfq6TpUJe5lP9G1V6m9p6aqp0X7whZLqDw6EGXC0qem21K8GbhDz1xnfSZ9ing6FlSoaJv7+7gwYBnenTYYDdhqan1+VDSKsDvoAYgEQdsRzlgF4OdqVupdsdzKF8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:8731695e-630e-46d9-83d2-625df346546a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:ee4c3b27-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 7fad4f50b99e11eda06fc9ecc4dadd91-20230303
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 342044720; Fri, 03 Mar 2023 16:36:31 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 3 Mar 2023 16:36:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 3 Mar 2023 16:36:30 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 3/7] wifi: mt76: mt7996: remove unused eeprom band selection
Date:   Fri, 3 Mar 2023 16:35:54 +0800
Message-ID: <20230303083558.3586-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230303083558.3586-1-shayne.chen@mediatek.com>
References: <20230303083558.3586-1-shayne.chen@mediatek.com>
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

Tri-band chipsets support one band on each a-die, so remove the unused
definition of eeprom band selection.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c | 4 ----
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 2e48c5a40f81..544b6c6f1ea3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -138,10 +138,6 @@ static int mt7996_eeprom_parse_band_config(struct mt7996_phy *phy)
 	case MT_EE_BAND_SEL_6GHZ:
 		phy->mt76->cap.has_6ghz = true;
 		break;
-	case MT_EE_BAND_SEL_5GHZ_6GHZ:
-		phy->mt76->cap.has_5ghz = true;
-		phy->mt76->cap.has_6ghz = true;
-		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
index 8da599e0abea..5571881f639b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
@@ -46,7 +46,6 @@ enum mt7996_eeprom_band {
 	MT_EE_BAND_SEL_2GHZ,
 	MT_EE_BAND_SEL_5GHZ,
 	MT_EE_BAND_SEL_6GHZ,
-	MT_EE_BAND_SEL_5GHZ_6GHZ,
 };
 
 static inline int
-- 
2.39.2

