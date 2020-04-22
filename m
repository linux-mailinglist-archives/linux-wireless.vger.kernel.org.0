Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4EC1B4985
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgDVQE4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 12:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgDVQEm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 12:04:42 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D7FC03C1AB
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MLVyKSueW3g8Ghtf0CERdlKOYJQk5qx2Ro/KWEtTQxs=; b=uEZ+K5RNsKlb7kt1Uj6+05NC/W
        6biVDcmfXCAluQkTsvPQi/Z9zaza6WYWx4ZNJOFJXsfeYfgUjA8uHunzxiZHnyvwLE9ZuIjC2+6OR
        DbtAvuqZ+nHyITp0G/RG1pKQnCmp27/gGTj+zc8jRC1WbZIbxYeizbsU2wRE5MLFE4hQ=;
Received: from p54ae965b.dip0.t-ipconnect.de ([84.174.150.91] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jRHrb-00054m-7v
        for linux-wireless@vger.kernel.org; Wed, 22 Apr 2020 18:04:39 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 9E6EB841962B; Wed, 22 Apr 2020 18:04:38 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 8/9] mt76: mt7615: fix tx status rate index calculation
Date:   Wed, 22 Apr 2020 18:04:36 +0200
Message-Id: <20200422160437.99466-8-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200422160437.99466-1-nbd@nbd.name>
References: <20200422160437.99466-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A switch from one rate index to the next only happens when tx count from
the current slot is greater than MT7615_RATE_RETRY, which is 1 has to be
subtracted from count, instead of added to it.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 89aed6d67de0..e7a76032caff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1148,7 +1148,7 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 	if (ampdu || (info->flags & IEEE80211_TX_CTL_AMPDU))
 		info->flags |= IEEE80211_TX_STAT_AMPDU | IEEE80211_TX_CTL_AMPDU;
 
-	first_idx = max_t(int, 0, last_idx - (count + 1) / MT7615_RATE_RETRY);
+	first_idx = max_t(int, 0, last_idx - (count - 1) / MT7615_RATE_RETRY);
 
 	if (fixed_rate && !probe) {
 		info->status.rates[0].count = count;
-- 
2.24.0

