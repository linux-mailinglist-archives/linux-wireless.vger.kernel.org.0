Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE0C1A322A
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 12:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDIKAS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 06:00:18 -0400
Received: from nbd.name ([46.4.11.11]:60824 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgDIKAS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 06:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=v/nVcghAqdih6qyBYA3nOkrPXJM2pa0tN2PRfPhCjzI=; b=DM/o4duRLbGlifbrVjXI72t8eu
        oXrcGpdMG7X558+4UatdE2IK4nMpMjkG7gFJ+ag3F0xpnqD0n6lT8X2kdlgDRpR6HUJIyAHK35+PT
        wwfk8uX0qdIpcV+tcfd3IMEBIE7xU4ztJ63+k2JsCcq15Q/lhmZinnl+S6mdWjReFClw=;
Received: from p54ae91d1.dip0.t-ipconnect.de ([84.174.145.209] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jMTys-000550-1V
        for linux-wireless@vger.kernel.org; Thu, 09 Apr 2020 12:00:18 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 789A8828EBF5; Thu,  9 Apr 2020 12:00:17 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7615: set hw scan limits only for firmware with offload support
Date:   Thu,  9 Apr 2020 12:00:16 +0200
Message-Id: <20200409100017.92156-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

They do not apply to software scan

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 07d4b259fe8a..b5d5e28b61b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -349,18 +349,21 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->reg_notifier = mt7615_regd_notifier;
 
-	wiphy->max_sched_scan_plan_interval = MT7615_MAX_SCHED_SCAN_INTERVAL;
-	wiphy->max_sched_scan_ie_len = IEEE80211_MAX_DATA_LEN;
-	wiphy->max_scan_ie_len = MT7615_SCAN_IE_LEN;
-	wiphy->max_sched_scan_ssids = MT7615_MAX_SCHED_SCAN_SSID;
-	wiphy->max_match_sets = MT7615_MAX_SCAN_MATCH;
-	wiphy->max_sched_scan_reqs = 1;
-	wiphy->max_scan_ssids = 4;
-
-	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
+	if (mt7615_firmware_offload(phy->dev)) {
+		wiphy->max_sched_scan_plan_interval = MT7615_MAX_SCHED_SCAN_INTERVAL;
+		wiphy->max_sched_scan_ie_len = IEEE80211_MAX_DATA_LEN;
+		wiphy->max_scan_ie_len = MT7615_SCAN_IE_LEN;
+		wiphy->max_sched_scan_ssids = MT7615_MAX_SCHED_SCAN_SSID;
+		wiphy->max_match_sets = MT7615_MAX_SCAN_MATCH;
+		wiphy->max_sched_scan_reqs = 1;
+		wiphy->max_scan_ssids = 4;
+
+		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
+		ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
+	}
+
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 
-	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 
 	if (is_mt7615(&phy->dev->mt76))
-- 
2.24.0

