Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0281B4981
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 18:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgDVQEv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 12:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgDVQEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 12:04:43 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A00C08C5F2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PD2DnRFiUh11u2brxoiZ+EAM/06AKtDIb0VtWF+o4qs=; b=jlyz5oujN2q2lMXdCd3Apx+h/x
        hSQwdjkcqzgSzUNBvf6Ptj8i6dfCAkq3d2Niboqq9RkXBU0wlqbTaz9Y3OdsPCGQHW8gh7t+vVCNg
        6CUzjKv/jfA+DOXyAO/ihTtQGsUa0Lrv5pgDdLh7ydgTsYEcAOkyB7IEP6evnUQAyULQ=;
Received: from p54ae965b.dip0.t-ipconnect.de ([84.174.150.91] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jRHrb-00054p-5P
        for linux-wireless@vger.kernel.org; Wed, 22 Apr 2020 18:04:39 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 9F3F9841962D; Wed, 22 Apr 2020 18:04:38 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/9] mt76: mt7615: fix sta ampdu factor for VHT
Date:   Wed, 22 Apr 2020 18:04:29 +0200
Message-Id: <20200422160437.99466-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If VHT has a larger A-MPDU size limit, pass it to the MCU via the wtbl_ht
TLV element.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index dc297856b749..24b78d10d7f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -924,11 +924,10 @@ mt7615_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		       void *sta_wtbl, void *wtbl_tlv)
 {
 	struct tlv *tlv;
+	struct wtbl_ht *ht = NULL;
 	u32 flags = 0;
 
 	if (sta->ht_cap.ht_supported) {
-		struct wtbl_ht *ht;
-
 		tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
 						wtbl_tlv, sta_wtbl);
 		ht = (struct wtbl_ht *)tlv;
@@ -945,6 +944,7 @@ mt7615_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 
 	if (sta->vht_cap.vht_supported) {
 		struct wtbl_vht *vht;
+		u8 af;
 
 		tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_VHT, sizeof(*vht),
 						wtbl_tlv, sta_wtbl);
@@ -952,6 +952,13 @@ mt7615_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		vht->ldpc = sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC,
 		vht->vht = 1;
 
+		af = (sta->vht_cap.cap &
+		      IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK) >>
+		      IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
+
+		if (ht)
+		    ht->af = max(ht->af, af);
+
 		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
 			flags |= MT_WTBL_W5_SHORT_GI_80;
 		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160)
-- 
2.24.0

