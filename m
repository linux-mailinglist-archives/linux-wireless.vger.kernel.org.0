Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BED13C78
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2019 03:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfEEAxq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 20:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbfEEAxq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 20:53:46 -0400
Received: from localhost.localdomain (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB3562063F;
        Sun,  5 May 2019 00:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557017625;
        bh=tkJZSl8lXeFKFZLnoXo98AEyhztr0azfzfzlRNxH63c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1mhPaqRXpbtM5XJXky7AkWUR1emey+lAZvQxR0Hqt7UpQVluOua9QsaYztIjeMIV
         7gLW8mkgEfjKwwP8Nl4C2xMy8uXpNXzmIou/8bxQQqN+lQZ8cSEGA/n1ivmL+lkb4u
         mi/rYQNsBmejFg75r+tZbCo1KB+q29afjpJ23XAw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7603: stop mac80211 queues before setting the channel
Date:   Sun,  5 May 2019 02:53:32 +0200
Message-Id: <31a4fa56c854a64a25f2e7aa37cba23e9d3fb3d6.1557016660.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557016660.git.lorenzo@kernel.org>
References: <cover.1557016660.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Suspend data transmission during channel switch

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 0a0334dc40d5..172687a1cb15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -207,8 +207,11 @@ mt7603_config(struct ieee80211_hw *hw, u32 changed)
 	int ret = 0;
 
 	if (changed & (IEEE80211_CONF_CHANGE_CHANNEL |
-		       IEEE80211_CONF_CHANGE_POWER))
+		       IEEE80211_CONF_CHANGE_POWER)) {
+		ieee80211_stop_queues(hw);
 		ret = mt7603_set_channel(dev, &hw->conf.chandef);
+		ieee80211_wake_queues(hw);
+	}
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		mutex_lock(&dev->mt76.mutex);
-- 
2.20.1

