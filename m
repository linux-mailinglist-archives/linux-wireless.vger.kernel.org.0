Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECC2722AE1
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 17:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjFEPWU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjFEPWI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 11:22:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E0110
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 08:22:00 -0700 (PDT)
X-UUID: b26cace603b411ee9cb5633481061a41-20230605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Yyz8D1GFrobUxMqU/rUHYpvO5kf4swdWrGRPN8/I+Vc=;
        b=KT/6uDiBYN79yMkIPUa2iTdouhvi6Bs2UpfgiUULJ3KIHPJlJxczTkBO5IXoDp0fFTqoSX3RkqOYVwkMBZ7cseHkqLk3tbcyGjuDFGStPt1SCHbGGVyzheigpBLHxBuln7u6KiHXIC76+4fxWWj1XcludtUG1IChj6f5w/9G9ks=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.25,REQID:51689c6b-0691-4129-ad7f-394d2218da10,IP:0,U
        RL:0,TC:0,Content:20,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS6885AD,AC
        TION:quarantine,TS:120
X-CID-INFO: VERSION:1.1.25,REQID:51689c6b-0691-4129-ad7f-394d2218da10,IP:0,URL
        :0,TC:0,Content:20,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:120
X-CID-META: VersionHash:d5b0ae3,CLOUDID:ef17a23d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230605232154BUMZFXBM,BulkQuantity:0,Recheck:0,SF:19|48|29|28|17,TC:n
        il,Content:4,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b26cace603b411ee9cb5633481061a41-20230605
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1466592725; Mon, 05 Jun 2023 23:21:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 23:21:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 23:21:50 +0800
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
Subject: [PATCH v3 03/10] wifi: mt76: mt7996: fix bss wlan_idx when sending bss_info command
Date:   Mon, 5 Jun 2023 23:21:34 +0800
Message-ID: <20230605152141.17434-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230605152141.17434-1-shayne.chen@mediatek.com>
References: <20230605152141.17434-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

The bmc_tx_wlan_idx should be the wlan_idx of the current bss rather
than peer AP's wlan_idx, otherwise there will appear some frame
decryption problems on station mode.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 545cc98749ac..6706d38cf4cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -712,6 +712,7 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	struct cfg80211_chan_def *chandef = &phy->chandef;
 	struct mt76_connac_bss_basic_tlv *bss;
 	u32 type = CONNECTION_INFRA_AP;
+	u16 sta_wlan_idx = wlan_idx;
 	struct tlv *tlv;
 	int idx;
 
@@ -731,7 +732,7 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 				struct mt76_wcid *wcid;
 
 				wcid = (struct mt76_wcid *)sta->drv_priv;
-				wlan_idx = wcid->idx;
+				sta_wlan_idx = wcid->idx;
 			}
 			rcu_read_unlock();
 		}
@@ -751,7 +752,7 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
 	bss->dtim_period = vif->bss_conf.dtim_period;
 	bss->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
-	bss->sta_idx = cpu_to_le16(wlan_idx);
+	bss->sta_idx = cpu_to_le16(sta_wlan_idx);
 	bss->conn_type = cpu_to_le32(type);
 	bss->omac_idx = mvif->omac_idx;
 	bss->band_idx = mvif->band_idx;
-- 
2.39.2

