Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3AA6D6E0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 00:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbfGRWo2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jul 2019 18:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfGRWo2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jul 2019 18:44:28 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D948C208C0;
        Thu, 18 Jul 2019 22:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563489868;
        bh=2UzlhbC3jlkpYE56/7IFK2brm2TUyqF+TuYc+RQGjl4=;
        h=From:To:Cc:Subject:Date:From;
        b=CHqdHZJmFH8A9WSJBrmPj5Pqe64F6xjuJcP0wAoQYg7vKSwHaqQq+0JE86gKudEIZ
         KPQuvDSmAGWW3FvAZevAkSJ37R5vt+ypfd2rJ7HLF8kKaOzyOLXfEK4E98B9uzPbKw
         JSJlhOXD3V/JlFAeUsvVZFPmsijk9/fOZwcovxPs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        royluo@google.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: fix MT7615_WATCHDOG_TIME definition
Date:   Fri, 19 Jul 2019 00:44:16 +0200
Message-Id: <43d02dc2fc35b281fb576369bd9355f77785ccd9.1563489704.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Express watchdog timeout in jiffies since it is used directly in
ieee80211_queue_delayed_work

Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 9d2286be0700..a014f7b17825 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -15,7 +15,7 @@
 #define MT7615_WTBL_STA			(MT7615_WTBL_RESERVED - \
 					 MT7615_MAX_INTERFACES)
 
-#define MT7615_WATCHDOG_TIME		100 /* ms */
+#define MT7615_WATCHDOG_TIME		(HZ / 10)
 #define MT7615_RATE_RETRY		2
 
 #define MT7615_TX_RING_SIZE		1024
-- 
2.21.0

