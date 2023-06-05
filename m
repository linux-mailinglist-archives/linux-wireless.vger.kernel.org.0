Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C227220D6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFEIU6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 04:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjFEIUw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 04:20:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09162CD
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 01:20:49 -0700 (PDT)
X-UUID: dca96a84037911eeb20a276fd37b9834-20230605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w+L2Tpb+dUNC8ni2FPWrhFjsr9duAkRXBdpvppSWils=;
        b=iiJ1L9rYYVK+MegzMEn6ALOUm2UWYInHgt0LVHF6YhDTZKcNVzyL40U9VmX4y8GIYxUc/cDZMSu5NwdlD6O5qWWqUCkWFiPY0YwoYRS4ALRdCprcinT2EXK6KLJkONXOlxK1UvNKyb+ige13ehTCrZqtw12cl7EMHgiEVJ2HLCw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:91700ba0-5236-4b32-8ec7-ab3945d5be1d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:700f0c6e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: dca96a84037911eeb20a276fd37b9834-20230605
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1865652646; Mon, 05 Jun 2023 16:20:42 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 16:20:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 16:20:41 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 04/10] wifi: mt76: mt7996: init he and eht cap for AP_VLAN
Date:   Mon, 5 Jun 2023 16:19:41 +0800
Message-ID: <20230605081947.12804-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230605081947.12804-1-shayne.chen@mediatek.com>
References: <20230605081947.12804-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Init he and eht capabilities for AP_VLAN type. Without this patch, the
BA response from AP_VLAN will not include the ADDBA extension tag.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index f1b48cdda58f..004575a0479b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -808,6 +808,7 @@ __mt7996_set_stream_he_eht_caps(struct mt7996_phy *phy,
 		switch (i) {
 		case NL80211_IFTYPE_STATION:
 		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_AP_VLAN:
 #ifdef CONFIG_MAC80211_MESH
 		case NL80211_IFTYPE_MESH_POINT:
 #endif
-- 
2.39.2

