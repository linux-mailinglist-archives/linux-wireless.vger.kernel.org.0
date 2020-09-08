Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B32621D6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 23:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgIHVSa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 17:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbgIHVSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 17:18:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D20C061797
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Is5CAD/ZIm6t03EgYX/3+vaKqFv/sZsDgYtmsy53erk=; b=BstwodcIMTAmfYxk8B24SL7Is5
        bpmYMOF1qvgqqUjSvwKq7A2XJUU034QYNAe4ceK6q44Cs67GQEoYl0YdrlLItfGuZFrV5FxgIjmLB
        Hvzgt152c6gkNjWfcgDIf5ap4jbaRVjcIJny4Vgua+RJOUSJAGuLg8l/zhMmKExzxyhs=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFl03-0002Cx-EU
        for linux-wireless@vger.kernel.org; Tue, 08 Sep 2020 23:17:59 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 08/11] mt76: mt7915: simplify mt7915_lmac_mapping
Date:   Tue,  8 Sep 2020 23:17:53 +0200
Message-Id: <20200908211756.15998-8-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908211756.15998-1-nbd@nbd.name>
References: <20200908211756.15998-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Compared to mac80211 ACs, MT7915 queue numbers are in reverse order
There is no need for the defensive WARN_ON_ONCE, so we can simplify
the function to avoid the array lookup

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index ab3f209ff6cd..4b8908fa7eda 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -258,17 +258,8 @@ mt7915_ext_phy(struct mt7915_dev *dev)
 
 static inline u8 mt7915_lmac_mapping(struct mt7915_dev *dev, u8 ac)
 {
-	static const u8 lmac_queue_map[] = {
-		[IEEE80211_AC_BK] = MT_LMAC_AC00,
-		[IEEE80211_AC_BE] = MT_LMAC_AC01,
-		[IEEE80211_AC_VI] = MT_LMAC_AC02,
-		[IEEE80211_AC_VO] = MT_LMAC_AC03,
-	};
-
-	if (WARN_ON_ONCE(ac >= ARRAY_SIZE(lmac_queue_map)))
-		return MT_LMAC_AC01; /* BE */
-
-	return lmac_queue_map[ac];
+	/* LMAC uses the reverse order of mac80211 AC indexes */
+	return 3 - ac;
 }
 
 extern const struct ieee80211_ops mt7915_ops;
-- 
2.28.0

