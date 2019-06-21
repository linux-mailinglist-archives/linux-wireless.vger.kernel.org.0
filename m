Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCFCF4EDB3
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2019 19:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfFURPf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jun 2019 13:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFURPf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jun 2019 13:15:35 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 068C12070B;
        Fri, 21 Jun 2019 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561137336;
        bh=F/h6EdILMe9buW4gjxDlt14bzn5ae/2cNlIJsPPpHIY=;
        h=From:To:Cc:Subject:Date:From;
        b=B+M1oQC6VovNxhW7T/QNDiT2AFxH2tT9Pqq5AdhOEE+thzEVbBs7NWZuZcoFGj0ne
         BnpfTa94HA5zS9ck4gj4VIAcYBs8HzEPEeb3kBVgotQr1ahjCT4wO09gJtZDInu3Qj
         wIbrUcbJPfD9xG7BnUyD0snmuH8Qwza0xtz0OHlk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: remove cfg80211_chan_def from mt7615_set_channel signature
Date:   Fri, 21 Jun 2019 19:15:26 +0200
Message-Id: <1adcbcac40f227cbfa0563c9d8116f37f9818625.1561136954.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Simplify mt7615_set_channel signature removing cfg80211_chan_def
parameter since it is not actually used

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index d21407ddda31..ea6b2315c6e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -130,8 +130,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
-static int mt7615_set_channel(struct mt7615_dev *dev,
-			      struct cfg80211_chan_def *def)
+static int mt7615_set_channel(struct mt7615_dev *dev)
 {
 	int ret;
 
@@ -196,7 +195,7 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 		ieee80211_stop_queues(hw);
-		ret = mt7615_set_channel(dev, &hw->conf.chandef);
+		ret = mt7615_set_channel(dev);
 		ieee80211_wake_queues(hw);
 	}
 
-- 
2.21.0

