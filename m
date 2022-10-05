Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C525F5508
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJENIb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJENIa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:08:30 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DC078595
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ViUzERznmY9U49Nq8HELK7/3YsqE5xhCFUTaS/36kxY=; b=Gqq9DZqMiwmqlIkZnxeKUBPl0m
        iK6pd5IhPc1yZIyiBt8RHMEd89CS2EBT1BtkNT2GSPt+pke2eaHZTgndEQ78U6evtyOuG/N/UbsAS
        QeHfaSbPgJ516Ix7YfC25EWuQ3hUkiloMaGlRgVvilI4Iv++/pAFC/uuk6GT1JSJHpYY=;
Received: from p200300daa7301d005d133ca52e775ee5.dip0.t-ipconnect.de ([2003:da:a730:1d00:5d13:3ca5:2e77:5ee5] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1og48Q-00ANpv-9e; Wed, 05 Oct 2022 15:08:26 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, Chad Monroe <chad.monroe@smartrg.com>
Subject: [PATCH 6.1 1/2] wifi: mt76: fix receiving LLC packets on mt7615/mt7915
Date:   Wed,  5 Oct 2022 15:08:23 +0200
Message-Id: <20221005130824.23371-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When 802.3 decap offload is enabled, the hardware indicates header translation
failure, whenever either the LLC-SNAP header was not found, or a VLAN header
with an unregcognized tag is present.
In that case, the hardware inserts a 2-byte length fields after the MAC
addresses. For VLAN packets, this tag needs to be removed. However,
for 802.3 LLC packets, the length bytes should be preserved, since there
is no separate ethertype field in the data.
This fixes an issue where the length field was omitted for LLC frames, causing
them to be malformed after hardware decap.

Fixes: 1eeff0b4c1a6 ("mt76: mt7915: fix decap offload corner case with 4-addr VLAN frames")
Reported-by: Chad Monroe <chad.monroe@smartrg.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index d6aae60c440d..cbc6859e38ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -610,14 +610,14 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 			 * When header translation failure is indicated,
 			 * the hardware will insert an extra 2-byte field
 			 * containing the data length after the protocol
-			 * type field.
+			 * type field. This happens either when the LLC-SNAP
+			 * pattern did not match, or if a VLAN header was
+			 * detected.
 			 */
 			pad_start = 12;
 			if (get_unaligned_be16(skb->data + pad_start) == ETH_P_8021Q)
 				pad_start += 4;
-
-			if (get_unaligned_be16(skb->data + pad_start) !=
-			    skb->len - pad_start - 2)
+			else
 				pad_start = 0;
 		}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1070838e7e16..ec996a587142 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -446,14 +446,14 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 			 * When header translation failure is indicated,
 			 * the hardware will insert an extra 2-byte field
 			 * containing the data length after the protocol
-			 * type field.
+			 * type field. This happens either when the LLC-SNAP
+			 * pattern did not match, or if a VLAN header was
+			 * detected.
 			 */
 			pad_start = 12;
 			if (get_unaligned_be16(skb->data + pad_start) == ETH_P_8021Q)
 				pad_start += 4;
-
-			if (get_unaligned_be16(skb->data + pad_start) !=
-			    skb->len - pad_start - 2)
+			else
 				pad_start = 0;
 		}
 
-- 
2.36.1

