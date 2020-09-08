Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78F02621CE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 23:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgIHVSK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 17:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbgIHVSE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 17:18:04 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6294C0613ED
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DROicD7xQI1KGUrU5PIXUBoYP+VU6OmNWzVs5m7D0vU=; b=S7fkX01HTFX/5TBFmJZjXfuQTd
        f/+26OTGDDkFfv31+rX74LeyPIcA/IVDRnRpyJymrEGhJBY1wZSSEgUNa77TBrayIapnbkhbpOBKc
        H17GRDC3sleVNfhABYEL1oCZo4FCniImgv3LYQobaz0doEuRKcpP9YtImk+vAYPjvvso=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFl03-0002Cx-K9
        for linux-wireless@vger.kernel.org; Tue, 08 Sep 2020 23:17:59 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 09/11] mt76: mt7915: fix queue/tid mapping for airtime reporting
Date:   Tue,  8 Sep 2020 23:17:54 +0200
Message-Id: <20200908211756.15998-9-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908211756.15998-1-nbd@nbd.name>
References: <20200908211756.15998-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unlike 7615, 7915 uses the same AC index for rx and tx, which matches the
LMAC queue mapping

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 54088d8e151f..defd0a98f7e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -105,12 +105,6 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		[IEEE80211_AC_VI] = 4,
 		[IEEE80211_AC_VO] = 6
 	};
-	static const u8 hw_queue_map[] = {
-		[IEEE80211_AC_BK] = 0,
-		[IEEE80211_AC_BE] = 1,
-		[IEEE80211_AC_VI] = 2,
-		[IEEE80211_AC_VO] = 3,
-	};
 	struct ieee80211_sta *sta;
 	struct mt7915_sta *msta;
 	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
@@ -169,8 +163,9 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		sta = container_of((void *)msta, struct ieee80211_sta,
 				   drv_priv);
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			u32 tx_cur = tx_time[i];
-			u32 rx_cur = rx_time[hw_queue_map[i]];
+			u8 q = mt7915_lmac_mapping(dev, i);
+			u32 tx_cur = tx_time[q];
+			u32 rx_cur = rx_time[q];
 			u8 tid = ac_to_tid[i];
 
 			if (!tx_cur && !rx_cur)
-- 
2.28.0

