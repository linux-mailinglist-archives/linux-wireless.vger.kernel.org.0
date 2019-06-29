Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608685AA35
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfF2Kgf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 06:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfF2Kgf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 06:36:35 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F1852086D;
        Sat, 29 Jun 2019 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561804594;
        bh=d3an55i6V52zQtBU+A+w3f4/4cB5BAeylN2J0HNdyAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKaT8BxTuyRkFwXqXUzZ8YeHQn5XTnePzc5jIjmcxoV7CdIQ1p6K580QfRMqLHvQj
         R1Ewk3XfpYLCz9upY5ypsD3gEaFRCt7jjPfe5tPwfE25BsDuKcsfXO559/mUBQ/PLa
         yHXYJgU3CLPvFgjpjdCPCKQEymvqhrbstzdkkQG8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com, yf.luo@mediatek.com
Subject: [PATCH 4/6] mt76: mt7615: unlock dfs bands
Date:   Sat, 29 Jun 2019 12:36:09 +0200
Message-Id: <33184e0b78983fe7c79fa70c5fbb21042aafa4f5.1561804422.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561804422.git.lorenzo@kernel.org>
References: <cover.1561804422.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unlock dfs channels since now mt7615 driver supports radar detection

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 5dc4cced5789..6d336d82cafe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -152,6 +152,12 @@ static const struct ieee80211_iface_combination if_comb[] = {
 		.max_interfaces = 4,
 		.num_different_channels = 1,
 		.beacon_int_infra_match = true,
+		.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+				       BIT(NL80211_CHAN_WIDTH_20) |
+				       BIT(NL80211_CHAN_WIDTH_40) |
+				       BIT(NL80211_CHAN_WIDTH_80) |
+				       BIT(NL80211_CHAN_WIDTH_160) |
+				       BIT(NL80211_CHAN_WIDTH_80P80),
 	}
 };
 
-- 
2.21.0

