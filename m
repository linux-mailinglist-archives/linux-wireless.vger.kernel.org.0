Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4857A43E5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbjIRIE7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 04:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbjIRIEq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 04:04:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ED7CD0
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 01:04:04 -0700 (PDT)
X-UUID: eb6ff74055f911eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7GAv1C6fN6088LnDvegNQ7HSo3/GmY4uFgY5z5DRRAU=;
        b=nfR5X3hWD9gidu9aAzvrAnci0vemVF3FGGRfZ58kL+7AjCEqtNBZVqhFfOdUEGzjJf+TdLfAZ7VBKCTxDjBD/1t3XRl+rAEqXKe4Gk3IZlWgvw43OOeNxnMfWR9gcSRnn/brfTAuXVLmoWJ0IgMd1772LTRkilCFCRaLgFSzo9w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:e66b0c12-d704-4ee2-8d35-d4edb13b1b11,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:9876d2ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: eb6ff74055f911eea33bb35ae8d461a2-20230918
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2135754274; Mon, 18 Sep 2023 16:03:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 16:03:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 16:03:54 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <jsiuda@google.com>, <arowa@google.org>,
        <frankgor@google.com>, <kuabhs@google.com>, <druth@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Deren Wu" <deren.wu@mediatek.com>
Subject: [PATCH v2 3/3] wifi: mt76: mt7921: fix the wrong rate selected in fw for the chanctx driver
Date:   Mon, 18 Sep 2023 16:03:08 +0800
Message-ID: <99f303541083c8db4bea982a8d9d45bdf0bd788c.1695021398.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1695021398.git.deren.wu@mediatek.com>
References: <cover.1695021398.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.279000-8.000000
X-TMASE-MatchedRID: VznsoVq3PH8mcsJib2IjaW3NvezwBrVmncKJki+ooR0OUs4CTUgKy49X
        7Ioij9LvHTGmoBrw70XsiSCMfmP7WLhzq4QWtOF2EgwM8US/pTHzWEMQjooUzUk7tZaD19NMo8W
        MkQWv6iXBcIE78YqRWvcUt5lc1lLgjMejjvPkBr5c6gPJraaKgvfafcfnHBiP6ijCn7Oz/1qVcO
        awW8BibN2fVa0H6hco6zPm1u4Ijpig96/KzcCVuyiQxPVkhq7gv3i5ZQX+oq55lSmbrC6fdtr/T
        o2FgNrjDLMIOOVTHz2nbLeYgH6K31Zca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.279000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: C505C3B2D70669A22991E5380FAF201345DE0F62F075B4880C00BA5524BD7F402000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The variable band should be determined by the ieee80211_chanctx_conf when
the driver is a kind of chanctx one e.g mt7921 and mt7922 driver so we
added the extension to mt76_connac2_mac_tx_rate_val and
mt76_connac_get_he_phy_cap for the firmware can select the proper rate.

Fixes: 41ac53c899bd ("wifi: mt76: mt7921: introduce chanctx support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: David Ruth <druth@chromium.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
v2: rebase on the top of maintainer tree
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 32512066e3aa..bcd6c20f37ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -841,7 +841,9 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_vif *vif,
 			     u8 rcpi, u8 sta_state)
 {
-	struct cfg80211_chan_def *chandef = &mphy->chandef;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = mvif->ctx ?
+					    &mvif->ctx->def : &mphy->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_dev *dev = mphy->dev;
 	struct sta_rec_ra_info *ra_info;
@@ -1381,7 +1383,10 @@ EXPORT_SYMBOL_GPL(mt76_connac_get_phy_mode_ext);
 const struct ieee80211_sta_he_cap *
 mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif)
 {
-	enum nl80211_band band = phy->chandef.chan->band;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = mvif->ctx ?
+					    &mvif->ctx->def : &phy->chandef;
+	enum nl80211_band band = chandef->chan->band;
 	struct ieee80211_supported_band *sband;
 
 	sband = phy->hw->wiphy->bands[band];
-- 
2.18.0

