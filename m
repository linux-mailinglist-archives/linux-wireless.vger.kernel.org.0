Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09BA24FC16
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 12:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHXK5W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 06:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgHXK5U (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 06:57:20 -0400
Received: from lore-desk.redhat.com (unknown [151.48.139.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADA5020738;
        Mon, 24 Aug 2020 10:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598266639;
        bh=3imcF2vxIpoWNFKt4kmwoUwK2ZR2Jf9V1XMMJQrD0Zs=;
        h=From:To:Cc:Subject:Date:From;
        b=LtUCSsvTEEHLLsmrpVug7hAknPXvGNaYIn1G8etZc6R9ntWngnS053y5D45skcrEG
         k6iKQw7lD7boK5QnhG19c2etjIfoPnWCSyd+aJP02iGf1fck9ZmgrHtvyk/aUQPJa+
         jM/7eCh2oakvykoFSfEGQcd1S0lgWrDiWj5v1Fno=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH v2] mt76: mt7615: unlock dfs bands
Date:   Mon, 24 Aug 2020 12:57:13 +0200
Message-Id: <fc603aeb996a99836f02712ab637f7e9f4841e9e.1598263398.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unlock dfs channels for mt7615 devices since the driver supports
radar detection. Dfs pattern detector has been tested successfully by
mt7615 users.
Do not unlock DFS frequencies for mt7663 devices since it has not been
tested yet.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- do not unlock dfs bands for mt7663
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index a147891953a1..00dc9e18a8a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -217,6 +217,22 @@ static const struct ieee80211_iface_limit if_limits[] = {
 	}
 };
 
+static const struct ieee80211_iface_combination if_comb_radar[] = {
+	{
+		.limits = if_limits,
+		.n_limits = ARRAY_SIZE(if_limits),
+		.max_interfaces = 4,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = true,
+		.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+				       BIT(NL80211_CHAN_WIDTH_20) |
+				       BIT(NL80211_CHAN_WIDTH_40) |
+				       BIT(NL80211_CHAN_WIDTH_80) |
+				       BIT(NL80211_CHAN_WIDTH_160) |
+				       BIT(NL80211_CHAN_WIDTH_80P80),
+	}
+};
+
 static const struct ieee80211_iface_combination if_comb[] = {
 	{
 		.limits = if_limits,
@@ -315,8 +331,13 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	hw->sta_data_size = sizeof(struct mt7615_sta);
 	hw->vif_data_size = sizeof(struct mt7615_vif);
 
-	wiphy->iface_combinations = if_comb;
-	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	if (is_mt7663(&phy->dev->mt76)) {
+		wiphy->iface_combinations = if_comb;
+		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	} else {
+		wiphy->iface_combinations = if_comb_radar;
+		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb_radar);
+	}
 	wiphy->reg_notifier = mt7615_regd_notifier;
 
 	wiphy->max_sched_scan_plan_interval = MT7615_MAX_SCHED_SCAN_INTERVAL;
-- 
2.26.2

