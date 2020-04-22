Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DC81B497B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgDVQEo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 12:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgDVQEm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 12:04:42 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD6C03C1A9
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fVVBF58LBsdR8a+3tYtpeEThNzzcC0Iu35QnBfZRRD8=; b=rnoecyFjZHqWLZN9eJNWT526ST
        pKJEuCF88hpkIqj6cNne/oPxZ31uIBQXJ0dFbroB7Nw6BX3he+zW3jtOk4g1nRNYoWtb5aOrtyPaE
        rs/7jOltpdzgwOGV0MUM5wD1HyygG7cEXPLbmB4UMemHO9SoDmMFFJOMzfUtldFSWrsw=;
Received: from p54ae965b.dip0.t-ipconnect.de ([84.174.150.91] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jRHrb-00054o-5F
        for linux-wireless@vger.kernel.org; Wed, 22 Apr 2020 18:04:39 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 9ED7C841962C; Wed, 22 Apr 2020 18:04:38 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/9] mt76: mt7615: never use an 802.11b CF-End rate on 5GHz
Date:   Wed, 22 Apr 2020 18:04:32 +0200
Message-Id: <20200422160437.99466-4-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200422160437.99466-1-nbd@nbd.name>
References: <20200422160437.99466-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sometimes mt7615_mac_set_timing gets called while the slot time is still
configured to 20. Ensure that in this case it always uses the OFDM CFend
rate.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 396f11e1bbf6..63c7acfd4cc2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -117,8 +117,9 @@ void mt7615_mac_set_timing(struct mt7615_phy *phy)
 	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
 		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 24);
 	int sifs, offset;
+	bool is_5ghz = phy->mt76->chandef.chan->band == NL80211_BAND_5GHZ;
 
-	if (phy->mt76->chandef.chan->band == NL80211_BAND_5GHZ)
+	if (is_5ghz)
 		sifs = 16;
 	else
 		sifs = 10;
@@ -151,7 +152,7 @@ void mt7615_mac_set_timing(struct mt7615_phy *phy)
 		FIELD_PREP(MT_IFS_SIFS, sifs) |
 		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
 
-	if (phy->slottime < 20)
+	if (phy->slottime < 20 || is_5ghz)
 		val = MT7615_CFEND_RATE_DEFAULT;
 	else
 		val = MT7615_CFEND_RATE_11B;
-- 
2.24.0

