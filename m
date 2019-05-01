Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2342910860
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 15:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEANoj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 09:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfEANoi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 09:44:38 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 596C920866;
        Wed,  1 May 2019 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556718278;
        bh=cDeiH4ksNkXMgOtamrsLlTi///OSXjW/4O2oRc5lln8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUu9+/p8RyL+o3oVqZM6F9A/RvgpurQil04OHq2h9OEx37X3COz8BT1r1mPPsTNKQ
         EYAKBfCM+mRqpMTsdpOuAObCTiZnmCS/xYx08hB8qAUx67sHMa202ptqH/aDwxf53t
         XF6ucDuCk7en3Q9V/uv4lmXjGr0/xbCv+/N75D+4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH] mt76: mt76x02: remove useless return in mt76x02_resync_beacon_timer
Date:   Wed,  1 May 2019 15:44:25 +0200
Message-Id: <b6e845207d947ce62161d98ea79a011211709062.1556717431.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556717431.git.lorenzo@kernel.org>
References: <cover.1556717431.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove useless return statment in mt76x02_resync_beacon_timer routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index e196b9c0a686..d61c686e08de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -189,10 +189,8 @@ mt76x02_resync_beacon_timer(struct mt76x02_dev *dev)
 	mt76_rmw_field(dev, MT_BEACON_TIME_CFG,
 		       MT_BEACON_TIME_CFG_INTVAL, timer_val);
 
-	if (dev->tbtt_count >= 64) {
+	if (dev->tbtt_count >= 64)
 		dev->tbtt_count = 0;
-		return;
-	}
 }
 EXPORT_SYMBOL_GPL(mt76x02_resync_beacon_timer);
 
-- 
2.20.1

