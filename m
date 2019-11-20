Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D9103A9B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 14:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfKTNCH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 08:02:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbfKTNCH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 08:02:07 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E4D2251D;
        Wed, 20 Nov 2019 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574254926;
        bh=TpDr8uTfo9TvOTPGss2vHtpXmP/wVL//pNpl3kJKA0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WR/oiCAq8jCMsOHZnxj5byIFu/KE4jFDIdea8NG9Sv8kK7gg0imxrTGzRGUq1fZc8
         ycFI2oQIf1VgetDVNKz3/8VcJhVvj844JG01XL5VHgkcASZO04VX/sc4vwxAI3r17L
         A3f1gjphqeKsLZvSgaP0Xr0FjWq/w6cMBtOYfDFI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH v2 2/3] mt76: mt7603: set 0 as min coverage_class value
Date:   Wed, 20 Nov 2019 15:01:44 +0200
Message-Id: <dd57ee4becf16a17110982c41cbbd13dcb979057.1574253996.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1574253996.git.lorenzo@kernel.org>
References: <cover.1574253996.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set 0 as minimum configurable value for coverage_class since mt76 does
not support dynack

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index d31c9d307c2d..3ff822863391 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -635,7 +635,7 @@ mt7603_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 {
 	struct mt7603_dev *dev = hw->priv;
 
-	dev->coverage_class = coverage_class;
+	dev->coverage_class = max_t(s16, coverage_class, 0);
 	mt7603_mac_set_timing(dev);
 }
 
-- 
2.21.0

