Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E58E242EA1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 20:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgHLSo6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 14:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgHLSo6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 14:44:58 -0400
Received: from localhost.localdomain (unknown [5.170.107.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6B422078B;
        Wed, 12 Aug 2020 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597257898;
        bh=Mblev28fOQ59KEV/E+lX8RQhFj+zkcUa9H3GEqgthIo=;
        h=From:To:Cc:Subject:Date:From;
        b=pJGwUDm3TUPJYCAERShIutC5iPrPGaiMYE8c3EgwgxawV2pUhbg+mnUQFlr3XF6rZ
         eju6FMT9/rGCrovrRgsPIJCOTk2S68rIOTUO9pd1RWye5l6tg3YlD1w5/+YpChiVpz
         YjyFHs+4jWmXnoVBEgXs/Ib/gPue+JKrMaND/bkM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7615: unlock dfs bands
Date:   Wed, 12 Aug 2020 20:44:43 +0200
Message-Id: <b810a0a977c23329704411c42a0ae497f9007cfa.1597257677.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unlock dfs channels since mt7615 driver supports radar detection.
Dfs pattern detector has been tested successfully by mt7615 users

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index a147891953a1..5dceb336c7ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -224,6 +224,12 @@ static const struct ieee80211_iface_combination if_comb[] = {
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
2.26.2

