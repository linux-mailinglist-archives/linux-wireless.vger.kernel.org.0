Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C324E6828F6
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 10:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjAaJgp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 04:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjAaJgn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 04:36:43 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91E12BF1C
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 01:36:37 -0800 (PST)
X-UUID: bdb559d0a14a11eda06fc9ecc4dadd91-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=M1fzgT/hvdf1Qv1HcXNuSMlZM/1hnG6hd0UtQoC6aEs=;
        b=nsEcVuPszhjsVpEKcWl/PHcDwRqB2t7hxzcI5AdlqDkUJ24e2jYZC/8mJOhzBnlmjqyQF5Hqjb8M2aeUpxFBML61JHpfGuMyo1dwgh0ELJwMSVx1IdmH42xBYWgZCx5xcKztOfibw8CtnLciSyj0DtxQ+lk7z3S37ZrWWcMLLBA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:4d696a27-4e0c-494a-a529-70fbfbd82ceb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:4d696a27-4e0c-494a-a529-70fbfbd82ceb,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:e764da55-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230131173631VH6NRD8C,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0
X-UUID: bdb559d0a14a11eda06fc9ecc4dadd91-20230131
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 413078528; Tue, 31 Jan 2023 17:36:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 31 Jan 2023 17:36:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 17:36:28 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 02/13] wifi: mt76: connac: add CMD_CBW_320MHZ
Date:   Tue, 31 Jan 2023 17:36:00 +0800
Message-ID: <20230131093611.30914-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230131093611.30914-1-shayne.chen@mediatek.com>
References: <20230131093611.30914-1-shayne.chen@mediatek.com>
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

Add CMD_CBW_320MHZ for setting bandwidth 320 MHz to firmware.
This is the preliminary patch to add EHT support for mt7996.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 8ba883b03e50..c3dabad5d40d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -42,6 +42,7 @@ enum {
 	CMD_CBW_10MHZ,
 	CMD_CBW_5MHZ,
 	CMD_CBW_8080MHZ,
+	CMD_CBW_320MHZ,
 
 	CMD_HE_MCS_BW80 = 0,
 	CMD_HE_MCS_BW160,
@@ -239,6 +240,7 @@ static inline u8 mt76_connac_chan_bw(struct cfg80211_chan_def *chandef)
 		[NL80211_CHAN_WIDTH_10] = CMD_CBW_10MHZ,
 		[NL80211_CHAN_WIDTH_20] = CMD_CBW_20MHZ,
 		[NL80211_CHAN_WIDTH_20_NOHT] = CMD_CBW_20MHZ,
+		[NL80211_CHAN_WIDTH_320] = CMD_CBW_320MHZ,
 	};
 
 	if (chandef->width >= ARRAY_SIZE(width_to_bw))
-- 
2.25.1

