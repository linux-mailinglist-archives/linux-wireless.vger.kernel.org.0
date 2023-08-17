Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A0E77F1B9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 10:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348703AbjHQICg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 04:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348732AbjHQIC3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 04:02:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBE72D79
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 01:02:21 -0700 (PDT)
X-UUID: 5f7f2ef63cd411eeb20a276fd37b9834-20230817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=neOuzk7lJIYJ5Jd8PLRU/t9ndfy4bPRHP2Ab9ClSeLw=;
        b=mvzaUTkwrgMTYxif7XIt9ot/BOOvFcrVeNN2Ol460wvBJHm/yYc4SkvBnL2JXOsH1owrbZ4g1hj3yFATNfrCDXOYCJCitlP7G9oFZsC+9on1+/+fvUQFOjRrWFwYCTGTYl09rH/axDgofaGMJbKW29X8bMVMDukaqE/uBTz+bBc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:40f344c9-8215-4540-bf55-28b872e80ee5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:40f344c9-8215-4540-bf55-28b872e80ee5,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:41356f1f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:230817160214GDIN3JWN,BulkQuantity:0,Recheck:0,SF:19|48|29|28|17,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 5f7f2ef63cd411eeb20a276fd37b9834-20230817
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 764679602; Thu, 17 Aug 2023 16:02:12 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Aug 2023 16:02:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Aug 2023 16:02:11 +0800
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
Subject: [PATCH 6/9] wifi: mt76: mt7996: fix TWT command format
Date:   Thu, 17 Aug 2023 16:01:51 +0800
Message-ID: <20230817080154.16475-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230817080154.16475-1-shayne.chen@mediatek.com>
References: <20230817080154.16475-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Align the command format of UNI_CMD_TWT_ARGT_UPDATE to firmware.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index cf443748ef7c..b0e6f51041fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3548,7 +3548,9 @@ int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
 			       int cmd)
 {
 	struct {
-		u8 _rsv[4];
+		/* fixed field */
+		u8 bss;
+		u8 _rsv[3];
 
 		__le16 tag;
 		__le16 len;
@@ -3566,7 +3568,7 @@ int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
 		u8 exponent;
 		u8 is_ap;
 		u8 agrt_params;
-		u8 __rsv2[135];
+		u8 __rsv2[23];
 	} __packed req = {
 		.tag = cpu_to_le16(UNI_CMD_TWT_ARGT_UPDATE),
 		.len = cpu_to_le16(sizeof(req) - 4),
@@ -3576,6 +3578,7 @@ int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
 		.flowid = flow->id,
 		.peer_id = cpu_to_le16(flow->wcid),
 		.duration = flow->duration,
+		.bss = mvif->mt76.idx,
 		.bss_idx = mvif->mt76.idx,
 		.start_tsf = cpu_to_le64(flow->tsf),
 		.mantissa = flow->mantissa,
-- 
2.39.2

