Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91207366961
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 12:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhDUKoe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 06:44:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234175AbhDUKoe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 06:44:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AD616144D;
        Wed, 21 Apr 2021 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619001840;
        bh=2QYi1iu7sq/QBDrVawnEK6+7Hw1UaxORFE3L6tcR5cI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMEvvI7pdeFyqX8kZzSSYFN+tZccN1bxOcJnhD03sPvDLy6mEeQr6PLtO+R7K95tX
         NBPXjru4hXq4C/pUfk2stwCqlqwG+7iCvcTiEmwHuWRE9QHRn9jeBLPD7JzKFvvfw8
         prGFhuCw1ciqk6lySwaySRcq/rBURn9V+mfEo2hKf8id+rS9JjOUFntoaItcWSVpCC
         wMCTe+GYzdKFXwa0fCxvYyu0DhcE74WlAuHB0RxXd4tOuW0RVYgiAWuIVBZ4DHpZs9
         VB3bFjY/zfrA+goPdJpjbkE+6+nAohwYqfUZBfVqyVdCfV6W0iekZkfgqC2T/C7f7P
         F7Htd2XHD/Sew==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 1/4] mt76: mt7921: improve doze opportunity
Date:   Wed, 21 Apr 2021 12:43:48 +0200
Message-Id: <799cbf719cd5418237afa413e097388a3b00d3ad.1619001617.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619001617.git.lorenzo@kernel.org>
References: <cover.1619001617.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase mt7921 mac work timeout in oder to have move sleep
opportunities

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 1233e5410ee7..72d04b229e6b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1461,12 +1461,12 @@ void mt7921_mac_work(struct work_struct *work)
 	mt7921_mutex_acquire(phy->dev);
 
 	mt76_update_survey(mphy->dev);
-	if (++mphy->mac_work_count == 5) {
+	if (++mphy->mac_work_count == 2) {
 		mphy->mac_work_count = 0;
 
 		mt7921_mac_update_mib_stats(phy);
 	}
-	if (++phy->sta_work_count == 10) {
+	if (++phy->sta_work_count == 4) {
 		phy->sta_work_count = 0;
 		mt7921_mac_sta_stats_work(phy);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index c6e112e47cfd..e72397c6e2ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -18,7 +18,7 @@
 
 #define MT7921_PM_TIMEOUT		(HZ / 12)
 #define MT7921_HW_SCAN_TIMEOUT		(HZ / 10)
-#define MT7921_WATCHDOG_TIME		(HZ / 10)
+#define MT7921_WATCHDOG_TIME		(HZ / 4)
 #define MT7921_RESET_TIMEOUT		(30 * HZ)
 
 #define MT7921_TX_RING_SIZE		2048
-- 
2.30.2

