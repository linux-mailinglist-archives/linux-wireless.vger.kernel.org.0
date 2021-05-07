Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7967F376341
	for <lists+linux-wireless@lfdr.de>; Fri,  7 May 2021 12:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhEGKDT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 May 2021 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhEGKDS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 May 2021 06:03:18 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8D9C061574
        for <linux-wireless@vger.kernel.org>; Fri,  7 May 2021 03:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pEYSZCtp1pexN3zVGuYjlw45M7QM495sfzfFTV84aY8=; b=g1B60RdcKSiFExrms6oOPC1mbp
        EXaiUVYyk5wLhnUPl1BnyDbgSPjARuFR3NxYU15WYN/6ZcE/ItGAczM6gC2VaQ5j6dEybx6F27QlH
        3jJnj7JL6HC/Bmzs53sMhzP41KAjaoU79Dd2H56QHO97mpefJ5ex2PGKzEzUy7gpx414=;
Received: from p4ff13bc6.dip0.t-ipconnect.de ([79.241.59.198] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lexJH-0003bF-Sp; Fri, 07 May 2021 12:02:15 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, Jayden Kuo <Jayden.Kuo@mediatek.com>
Subject: [PATCH 5.13 1/2] mt76: connac: fix HT A-MPDU setting field in STA_REC_PHY
Date:   Fri,  7 May 2021 12:02:10 +0200
Message-Id: <20210507100211.15709-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The MT7921 firmware needs this to enable tx A-MPDU properly

Reported-by: Jayden Kuo (郭育辰) <Jayden.Kuo@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index fe0ab5e5ff81..619561606f96 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -721,6 +721,10 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 	phy->phy_type = mt76_connac_get_phy_mode_v2(mphy, vif, band, sta);
 	phy->basic_rate = cpu_to_le16((u16)vif->bss_conf.basic_rates);
 	phy->rcpi = rcpi;
+	phy->ampdu = FIELD_PREP(IEEE80211_HT_AMPDU_PARM_FACTOR,
+				sta->ht_cap.ampdu_factor) |
+		     FIELD_PREP(IEEE80211_HT_AMPDU_PARM_DENSITY,
+				sta->ht_cap.ampdu_density);
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra_info));
 	ra_info = (struct sta_rec_ra_info *)tlv;
-- 
2.30.1

