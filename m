Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF4D4AE21C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 20:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385911AbiBHTTG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 14:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353717AbiBHTTF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 14:19:05 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC28C0612C0
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 11:19:01 -0800 (PST)
X-UUID: 4cc068cecd114a8aa1ef598b28bb9f87-20220209
X-UUID: 4cc068cecd114a8aa1ef598b28bb9f87-20220209
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1214468679; Wed, 09 Feb 2022 03:18:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 9 Feb 2022 03:18:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 03:18:56 +0800
From:   <sean.wang@mediatek.com>
To:     <deren.wu@mediatek.com>
CC:     <lorenzo.bianconi@redhat.com>, <nbd@nbd.name>,
        <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <evelyn.tsai@mediatek.com>, <Ryder.Lee@mediatek.com>,
        <Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921s: fix missing fc type/sub-type for 802.11 pkts
Date:   Wed, 9 Feb 2022 03:18:55 +0800
Message-ID: <1644347935-20006-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <33dd8e4b7f7f72d191e8eca88b33b32dbf2595d2.1644313224.git.deren.wu@mediatek.comk--annotate>
References: <33dd8e4b7f7f72d191e8eca88b33b32dbf2595d2.1644313224.git.deren.wu@mediatek.comk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>from: Deren Wu <deren.wu@mediatek.com>
>
>For non-mmio devices, should set fc values to proper txwi config
>
>Fixes: 48fab5bbef40 ("mt76: mt7921: introduce mt7921s support")
>Co-developed-by: Leon Yen <Leon.Yen@mediatek.com>
>Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
>Signed-off-by: Deren Wu <deren.wu@mediatek.com>

Tested-by: Sean Wang <sean.wang@mediatek.com>

>---
> drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 13 ++++++++++---  drivers/net/wireless/mediatek/mt76/mt7921/mac.h |  3 +++
> 2 files changed, 13 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>index d17558349a17..e403f0225b77 100644
>--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>@@ -852,6 +852,7 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
>	__le16 fc = hdr->frame_control;
>	u8 fc_type, fc_stype;
>	u32 val;
>+	bool is_mmio = mt76_is_mmio(&dev->mt76);
>
>	if (ieee80211_is_action(fc) &&
>	    mgmt->u.action.category == WLAN_CATEGORY_BACK && @@ -912,9 +913,15 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
>		txwi[3] |= cpu_to_le32(val);
>	}
>
>-	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
>-	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
>-	txwi[7] |= cpu_to_le32(val);
>+	if (is_mmio) {
>+		val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
>+		      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
>+		txwi[7] |= cpu_to_le32(val);
>+	} else {
>+		val = FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
>+		      FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
>+		txwi[8] |= cpu_to_le32(val);
>+	}
> }
>
> void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi, diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
>index 544a1c33126a..12e1cf8abe6e 100644
>--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
>+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
>@@ -284,6 +284,9 @@ enum tx_mcu_port_q_idx {
> #define MT_TXD7_HW_AMSDU		BIT(10)
> #define MT_TXD7_TX_TIME			GENMASK(9, 0)
>
>+#define MT_TXD8_L_TYPE			GENMASK(5, 4)
>+#define MT_TXD8_L_SUB_TYPE		GENMASK(3, 0)
>+
> #define MT_TX_RATE_STBC			BIT(13)
> #define MT_TX_RATE_NSS			GENMASK(12, 10)
> #define MT_TX_RATE_MODE			GENMASK(9, 6)
>--
>2.18.0
>
>
