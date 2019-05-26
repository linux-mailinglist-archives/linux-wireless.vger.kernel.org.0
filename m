Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E975A2AA32
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2019 16:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfEZOFh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 May 2019 10:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfEZOFh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 May 2019 10:05:37 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD59A2085A;
        Sun, 26 May 2019 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558879537;
        bh=rz76KKxqQT2p3zqTZ4tjyGXqWBPjq2gmKwsFje72sFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcCo7vnhJn/7co9xzOnAxT5GFAa21OalF9q8PV8Gt3jwqB6ViZKOn9Fxa2odJrmT+
         3finIk0Bzu/jBvzsFFoXFyu3yvc/Yl/q9vnpnOtGUDIswciUdyCMIGNDy04R6Cu22C
         p1qX6g1Hg37BslKr9aY/JrmCI8YbbeHplQYgI1x0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 3/4] mt76: mt7615: init get_txpower mac80211 callback
Date:   Sun, 26 May 2019 16:05:12 +0200
Message-Id: <7d8dd9ac5fbcce5dfbfa663e4b67f47443ecec56.1558879234.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558879234.git.lorenzo@kernel.org>
References: <cover.1558879234.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Initialize get_txpower mac80211 callback to mt76_get_txpower
in order to report the configured tx power to mac80211

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 72bdb871ca13..cedc4c25f34d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -493,4 +493,5 @@ const struct ieee80211_ops mt7615_ops = {
 	.sw_scan_start = mt7615_sw_scan,
 	.sw_scan_complete = mt7615_sw_scan_complete,
 	.release_buffered_frames = mt76_release_buffered_frames,
+	.get_txpower = mt76_get_txpower,
 };
-- 
2.21.0

