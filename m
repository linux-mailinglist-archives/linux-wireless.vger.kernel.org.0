Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A28666E8
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 08:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfGLGUs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 02:20:48 -0400
Received: from nbd.name ([46.4.11.11]:33144 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfGLGUr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 02:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RZg4Y/n6fMQcyzT3pUOphV3aEhZTEHpnRQe5q0QKWCs=; b=gB/sGO/KQudpG1Gflp4e6oBTRV
        xgGHe5OSjNUVuYTwghakriT+opwUbKLhVZtHXU7R4mYi+ouztZbcThCTQ6BZJxEsLmFO3kHwIKZhU
        ir5wspzpAMfiSEkthZYsf7phJ/rJ94Vi1Xxd84zjguLJI0J/xLzQc59bcXqdk82NIxBo=;
Received: from p54ae9abd.dip0.t-ipconnect.de ([84.174.154.189] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hlovG-0003rb-Av
        for linux-wireless@vger.kernel.org; Fri, 12 Jul 2019 08:20:46 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id A161E61C52AB; Fri, 12 Jul 2019 08:20:45 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] mt76: mt7615: fix using VHT STBC rates
Date:   Fri, 12 Jul 2019 08:20:42 +0200
Message-Id: <20190712062045.85109-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The hardware expects MT_TX_RATE_NSS to be filled with the number of
space/time streams. For non-STBC rates, this is equal to nss.
For 1-stream STBC, this needs to be set to 2.
This is relevant for VHT rates only, on HT, the value is derived from MCS
internally.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c    | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 5bfb4594b8ee..6c21b2df69c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -254,7 +254,7 @@ mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
 		       bool stbc, u8 *bw)
 {
 	u8 phy, nss, rate_idx;
-	u16 rateval;
+	u16 rateval = 0;
 
 	*bw = 0;
 
@@ -292,12 +292,14 @@ mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
 		rate_idx = val & 0xff;
 	}
 
-	rateval = (FIELD_PREP(MT_TX_RATE_IDX, rate_idx) |
-		   FIELD_PREP(MT_TX_RATE_MODE, phy) |
-		   FIELD_PREP(MT_TX_RATE_NSS, nss - 1));
-
-	if (stbc && nss == 1)
+	if (stbc && nss == 1) {
+		nss++;
 		rateval |= MT_TX_RATE_STBC;
+	}
+
+	rateval |= (FIELD_PREP(MT_TX_RATE_IDX, rate_idx) |
+		    FIELD_PREP(MT_TX_RATE_MODE, phy) |
+		    FIELD_PREP(MT_TX_RATE_NSS, nss - 1));
 
 	return rateval;
 }
@@ -771,6 +773,10 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		break;
 	case MT_PHY_TYPE_VHT:
 		final_nss = FIELD_GET(MT_TX_RATE_NSS, final_rate);
+
+		if ((final_rate & MT_TX_RATE_STBC) && final_nss)
+			final_nss--;
+
 		final_rate_flags |= IEEE80211_TX_RC_VHT_MCS;
 		final_rate = (final_rate & MT_TX_RATE_IDX) | (final_nss << 4);
 		break;
-- 
2.17.0

