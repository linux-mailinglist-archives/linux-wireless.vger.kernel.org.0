Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E65FB11611C
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2019 08:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfLHH0G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Dec 2019 02:26:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfLHH0G (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Dec 2019 02:26:06 -0500
Received: from localhost.localdomain (unknown [5.171.120.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A39E206D6;
        Sun,  8 Dec 2019 07:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575789965;
        bh=NbyMFdydPyQZ8sKK8V513pthoqEO+HVIpvJWYGKnsrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQRP1+d/4w5IitPRdL9jQXkoAoJuhazOPuLSal7Dm39rh04RLLKbIp5A3mC3z7b7r
         CsHKmS6yLyafGlanyRliMdXX/1v78SSOhh5DuAu26VolUG3VxpTtplE0ikudk6WTpC
         qs2RudvwLqVfNew/ls6lKvTP+2QfN5uPUHqf0F58=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH v4 1/3] mt76: mt76x02: fix coverage_class type
Date:   Sun,  8 Dec 2019 08:25:38 +0100
Message-Id: <0bbcf0b83bc854899c9141dbfb332c878209b3f8.1575789681.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1575789681.git.lorenzo@kernel.org>
References: <cover.1575789681.git.lorenzo@kernel.org>
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
index ba4c14eea22d..57665516d00e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -116,7 +116,7 @@ struct mt76x02_dev {
 
 	bool no_2ghz;
 
-	u8 coverage_class;
+	s16 coverage_class;
 	u8 slottime;
 
 	struct mt76x02_dfs_pattern_detector dfs_pd;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index e5685d9534e4..ab717d82d771 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -545,7 +545,7 @@ void mt76x02_set_coverage_class(struct ieee80211_hw *hw,
 	struct mt76x02_dev *dev = hw->priv;
 
 	mutex_lock(&dev->mt76.mutex);
-	dev->coverage_class = coverage_class;
+	dev->coverage_class = max_t(s16, coverage_class, 0);
 	mt76x02_set_tx_ackto(dev);
 	mutex_unlock(&dev->mt76.mutex);
 }
-- 
2.21.0

