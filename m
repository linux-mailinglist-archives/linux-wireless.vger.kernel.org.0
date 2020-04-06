Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE551A0081
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 23:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgDFV4j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 17:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDFV4j (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 17:56:39 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B4D20842;
        Mon,  6 Apr 2020 21:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586210199;
        bh=cz7J06GHj8wA5T68rrWj6/Sv+02ISrlJSLYDGJBsVrI=;
        h=From:To:Cc:Subject:Date:From;
        b=m4h61MWXks/acJnCDmjD4FFKjV4oyXHjSKMkQPv5J6EZ7YlOlS4EMqxflpjljhtBp
         uHsmbGYCGf8d67gPOADfTAb5WhzjxwNeE38HnY6wfsFdJoUPHhpPxaMV+8Sw/chbdc
         4SkEpYZBomJAPcofrD0Go61/N478kavmWKqM8lWo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: fix possible division by 0 in mt7615_mac_update_mib_stats
Date:   Mon,  6 Apr 2020 23:56:30 +0200
Message-Id: <3cdc3a64324d0b0e860875b3960ad3e3929a7210.1586210037.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check that val is not zero before aggr_per estimation in order to avoid a
possible division by 0

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 596fa17a58ff..23f905dfecc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1702,9 +1702,11 @@ mt7615_mac_update_mib_stats(struct mt7615_phy *phy)
 
 	val = mt76_get_field(dev, MT_MIB_SDR14(ext_phy),
 			     MT_MIB_AMPDU_MPDU_COUNT);
-	val2 = mt76_get_field(dev, MT_MIB_SDR15(ext_phy),
-			      MT_MIB_AMPDU_ACK_COUNT);
-	mib->aggr_per = 1000 * (val - val2) / val;
+	if (val) {
+		val2 = mt76_get_field(dev, MT_MIB_SDR15(ext_phy),
+				      MT_MIB_AMPDU_ACK_COUNT);
+		mib->aggr_per = 1000 * (val - val2) / val;
+	}
 
 	aggr = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0; i < 4; i++) {
-- 
2.25.1

