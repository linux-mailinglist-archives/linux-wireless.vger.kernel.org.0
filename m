Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7B221361A
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgGCIQn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgGCIQk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:40 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 450EC207FF;
        Fri,  3 Jul 2020 08:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764200;
        bh=PHxZI6kQT92TJsy5aJifbIG/s34Ng7bluHs6Q1I1JqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yAPXJ+FjYcLZpzmKBc38EhSbW1BSXIHWJdz3P2YFTFlko4IP+UzCCtNz6bhuYbjDU
         Xz6+t5Z2jHFQWmHOfp7nzwzo0WJn8hKMkCO7+Qa8n0hTX7aQGgCPxMQUjIzP/2zCM9
         E7A1VpHmlPcLfqNuQfxKr0e6acJyQaL9JwvgPTa8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 11/22] mt76: mt7615: add missing lock in mt7615_regd_notifier
Date:   Fri,  3 Jul 2020 10:15:50 +0200
Message-Id: <a8d8e4bc64d003972f04b9452ae723f6400842b7.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make sure to run mt7615_dfs_init_radar_detector in mt7615_regd_notifier
holding mt76 mutex in order to avoid races and set the device in full
power

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index c22878b82540..59c59e8630c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -294,7 +294,9 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
 		return;
 
+	mt7615_mutex_acquire(dev);
 	mt7615_dfs_init_radar_detector(phy);
+	mt7615_mutex_release(dev);
 }
 
 static void
-- 
2.26.2

