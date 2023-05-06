Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ED96F8EB7
	for <lists+linux-wireless@lfdr.de>; Sat,  6 May 2023 07:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEFFqg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 May 2023 01:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFFqd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 May 2023 01:46:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354907D9E
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 22:46:27 -0700 (PDT)
X-UUID: 5513f234ebd111ed9cb5633481061a41-20230506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pu8LKqsig3D4xWskONiRV4lN2sw9wjTq20UJ5LvIF0Q=;
        b=WNnDqcZq5DNGvIdgEuqXTtJaP2xGn+yTNHoqxL4gU9vG+/tbWDwwSSZwHuaRq1n7+1DKcs9abq+WwlN7EWo8ZKP78aMQQcE0daE4mbfqY6UwJesNTsry/oUO2mVsCA969gDiZs1N6XlZqf6aQhs/eaIG5BTHBA+VD3XEuUDjwYw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:eadd1fcd-7599-463f-8944-6da7195b4fe1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.23,REQID:eadd1fcd-7599-463f-8944-6da7195b4fe1,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:697ab71,CLOUDID:9f46f7bf-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:2305061346238ATA0B4S,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 5513f234ebd111ed9cb5633481061a41-20230506
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 370956766; Sat, 06 May 2023 13:46:22 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Sat, 6 May 2023 13:46:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Sat, 6 May 2023 13:46:21 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Himanshu Goyal <himanshu.goyal@mediatek.com>
Subject: [PATCH] wifi: mt76: enable UNII-4 channel 177 support
Date:   Sat, 6 May 2023 13:46:19 +0800
Message-ID: <93627d88b400b8b4bfd667583904912cc303909f.1683328995.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable support for the 5GHz channel 177 with center frequency 5885MHz and
operating class 125 based on IEEE Std 802.11ax-2021 Table E-4.

Signed-off-by: Himanshu Goyal <himanshu.goyal@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 467afef98ba2..cd3aac4cc06f 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -76,6 +76,7 @@ static const struct ieee80211_channel mt76_channels_5ghz[] = {
 	CHAN5G(165, 5825),
 	CHAN5G(169, 5845),
 	CHAN5G(173, 5865),
+	CHAN5G(177, 5885),
 };
 
 static const struct ieee80211_channel mt76_channels_6ghz[] = {
-- 
2.18.0

