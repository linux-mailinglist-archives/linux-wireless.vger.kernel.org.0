Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B250A5BA38A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 02:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIPAje (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 20:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIPAjd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 20:39:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521FC254
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 17:39:27 -0700 (PDT)
X-UUID: 6048d8781f6d41aaa390ae8f164ab4e0-20220916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=btxeb0TAlItcniZCTe2RZdkxn60+QlCFj1RCEVm9Vkw=;
        b=LCEVVJwRUO/GxiWlSWIk4sxmHG+mNM645XA2uM43QicPxcNOxPaFwvWsaEDN1cQlxfQJBpP9G2WeZO8zdLee+C9awsJZn/V46oEEpf7K41WIvke6aWwYBxICeqUNhRRE54p402jBrPn3pOKATbztinu/Ox91Jh9YEySNlQYKNoI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:a99b4465-118d-4498-8de4-2b06b56b18e3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:a99b4465-118d-4498-8de4-2b06b56b18e3,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:9a5ecc7b-ea28-4199-b57e-003c7d60873a,B
        ulkID:220916083924QMKDXH5G,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6048d8781f6d41aaa390ae8f164ab4e0-20220916
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 354650939; Fri, 16 Sep 2022 08:39:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 16 Sep 2022 08:39:21 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 16 Sep 2022 08:39:21 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v3] mt76: mt7921: fix antenna signal are way off in monitor mode
Date:   Fri, 16 Sep 2022 08:39:19 +0800
Message-ID: <e987d8149d6e00b2bec979a343681ddedea3c347.1663288354.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Group 3 in RxD is disabled in monitor mode. We should use the group 5 in
RxD instead to fix antenna signal way off issue, e.g we would see the
incorrect antenna signal value in wireshark. On the other hand, Group 5
wouldn't be used in STA or AP mode, so the patch shouldn't cause any
harm to those modes.

Fixes: cbaa0a404f8d ("mt76: mt7921: fix up the monitor mode")
Reported-by: Adrian Granados <agranados@gmail.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: drop an unnecessary blank line and fix typo
v3: I didn't find wrapped line, just rebase and resend to see
    if it can properly show in patchwork.
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 32 ++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index e4868c492bc0..8de5e36a3780 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -394,6 +394,27 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 		if (v0 & MT_PRXV_HT_AD_CODE)
 			status->enc_flags |= RX_ENC_FLAG_LDPC;
 
+		ret = mt76_connac2_mac_fill_rx_rate(&dev->mt76, status, sband,
+						    rxv, &mode);
+		if (ret < 0)
+			return ret;
+
+		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
+			rxd += 6;
+			if ((u8 *)rxd - skb->data >= skb->len)
+				return -EINVAL;
+
+			rxv = rxd;
+			/* Monitor mode would use RCPI described in GROUP 5
+			 * instead.
+			 */
+			v1 = le32_to_cpu(rxv[0]);
+
+			rxd += 12;
+			if ((u8 *)rxd - skb->data >= skb->len)
+				return -EINVAL;
+		}
+
 		status->chains = mphy->antenna_mask;
 		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
 		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
@@ -408,17 +429,6 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 			status->signal = max(status->signal,
 					     status->chain_signal[i]);
 		}
-
-		ret = mt76_connac2_mac_fill_rx_rate(&dev->mt76, status, sband,
-						    rxv, &mode);
-		if (ret < 0)
-			return ret;
-
-		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
-			rxd += 18;
-			if ((u8 *)rxd - skb->data >= skb->len)
-				return -EINVAL;
-		}
 	}
 
 	amsdu_info = FIELD_GET(MT_RXD4_NORMAL_PAYLOAD_FORMAT, rxd4);
-- 
2.25.1

