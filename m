Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AFD1C17DF
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgEAOgb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgEAOga (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 10:36:30 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9143DC061A0E
        for <linux-wireless@vger.kernel.org>; Fri,  1 May 2020 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=urb5Ncwd4FM7lxj1LvyXXOv2rvHnHpkxFH3TSMPJOPE=; b=JAYbUfIQH2FdvNwaMW2GqUz7OU
        opBbsT7ZHnQncFiZVlilJ1YUhsEGhhm5CzpzC7uzs1osQEngNOayaazqvCen7AQRuvZ32x4HjdQXF
        8NdeQB0/s77GsNd4ZUKPghUSqH4ybID98dQMETa8ClFr+mnQWHpAu8SHT61AXOrg/xLw=;
Received: from p54ae9310.dip0.t-ipconnect.de ([84.174.147.16] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jUWmC-000810-SI
        for linux-wireless@vger.kernel.org; Fri, 01 May 2020 16:36:28 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 2C68F851522F; Fri,  1 May 2020 16:36:27 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7615: set spatial extension index
Date:   Fri,  1 May 2020 16:36:26 +0200
Message-Id: <20200501143627.24523-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The vendor driver sets this in firmware rate control (which we don't use)

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index e7a76032caff..5c09787b0d76 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -639,7 +639,8 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 		txwi[3] |= cpu_to_le32(MT_TXD3_NO_ACK);
 
 	txwi[7] = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
-		  FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+		  FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype) |
+		  FIELD_PREP(MT_TXD7_SPE_IDX, 0x18);
 	if (is_usb)
 		txwi[8] = FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
 			  FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 5fd4a4ab5120..cbad854d7497 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -887,6 +887,7 @@ mt7615_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct wtbl_generic *generic;
 	struct wtbl_rx *rx;
+	struct wtbl_spe *spe;
 	struct tlv *tlv;
 
 	tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_GENERIC, sizeof(*generic),
@@ -914,6 +915,11 @@ mt7615_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	rx->rca1 = sta ? vif->type != NL80211_IFTYPE_AP : 1;
 	rx->rca2 = 1;
 	rx->rv = 1;
+
+	tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_SPE, sizeof(*spe),
+					wtbl_tlv, sta_wtbl);
+	spe = (struct wtbl_spe *)tlv;
+	spe->spe_idx = 24;
 }
 
 static void
-- 
2.24.0

