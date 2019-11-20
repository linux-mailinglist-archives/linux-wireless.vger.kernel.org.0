Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD6103A99
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 14:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfKTNCA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 08:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbfKTNB7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 08:01:59 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BB492251E;
        Wed, 20 Nov 2019 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574254919;
        bh=fUcpQp83cxM2DtMmXkoDEzTWGdVUn3l4dH5tGoj/2+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPWp9kAkKESgIPhHXQWl/2lIEhdXdD/bWGeBfkFwd36Phew2h+fdxasCreN5ViaQI
         zeNxW2V6pThASs6gZZDHoYXUPwq4kbWfMQDAuOzu0EbAq2U0U9dbwBUhOWh2bd9NS9
         7pqDoMp65dwc2M6Vh4BscczxF13q0sOOhw3Din9k=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH v2 1/3] mt76: mt76x02: fix coverage_class type
Date:   Wed, 20 Nov 2019 15:01:43 +0200
Message-Id: <2418c6670f8e3880d62e679a62949a49b3ac65c7.1574253996.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1574253996.git.lorenzo@kernel.org>
References: <cover.1574253996.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix coverage_class type in mt76x02_dev data structure since
coverage_class can be negative to enable dynack (just supported by
ath9k). Set 0 as minimum value for coverage_class

Fixes: 7bc04215a66b ("mt76: add driver code for MT76x2e")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02.h      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 0ca0bbfe8769..cdc1cbd1d392 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -110,7 +110,7 @@ struct mt76x02_dev {
 
 	bool no_2ghz;
 
-	u8 coverage_class;
+	s16 coverage_class;
 	u8 slottime;
 
 	struct mt76x02_dfs_pattern_detector dfs_pd;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index c0500d8f9a67..dd0fc87ee9a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -544,7 +544,7 @@ void mt76x02_set_coverage_class(struct ieee80211_hw *hw,
 	struct mt76x02_dev *dev = hw->priv;
 
 	mutex_lock(&dev->mt76.mutex);
-	dev->coverage_class = coverage_class;
+	dev->coverage_class = max_t(s16, coverage_class, 0);
 	mt76x02_set_tx_ackto(dev);
 	mutex_unlock(&dev->mt76.mutex);
 }
-- 
2.21.0

