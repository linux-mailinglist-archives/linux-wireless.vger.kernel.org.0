Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC78E7205E1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 17:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbjFBPWH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 11:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbjFBPWB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 11:22:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7055718C
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 08:22:00 -0700 (PDT)
X-UUID: 33677b0e015911eeb20a276fd37b9834-20230602
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tOHm0zte+jHqtEQi/W+GwuzFP4Uy0vZzuphIS7rEjv8=;
        b=XPL2wWwBRH/c74Wl6Tua6o7NFW5YjFiEgz5cHNsadYwwdxTLdLRuSbhYbixDfcEmBvoICpU58LrBrBydHZOk3j9g2JoG3KCcIjfvo2EjMpC6dgIigvGQS0pXuOf6zRbvqjBpFkc7rYONrcvFAAyxJUXSjO87wnhyC32T3lUXPwo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:648cf49b-dc54-41cc-87a6-176165a0168f,IP:0,U
        RL:0,TC:0,Content:20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:20
X-CID-META: VersionHash:d5b0ae3,CLOUDID:0a1c363d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 33677b0e015911eeb20a276fd37b9834-20230602
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1470600517; Fri, 02 Jun 2023 23:21:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 2 Jun 2023 23:21:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 2 Jun 2023 23:21:51 +0800
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
Subject: [PATCH 04/12] wifi: mt76: mt7996: fix bss wlan_idx when sending bss_info command
Date:   Fri, 2 Jun 2023 23:21:00 +0800
Message-ID: <20230602152108.26860-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230602152108.26860-1-shayne.chen@mediatek.com>
References: <20230602152108.26860-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
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
index 243647dbd8c7..db51b3023654 100644
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

