Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D1A48C5BD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 15:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354041AbiALOPB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 09:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354014AbiALOOk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 09:14:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61ABC061748
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 06:14:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74CF7614EB
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 14:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C8AC36AE5;
        Wed, 12 Jan 2022 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641996878;
        bh=rJFr/ccMGxzX5Thiy1NAGXlf9AsqHRI3KKm8LzpKS9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RVVCZXw5Em4fPyYwalRAPwAXS2q+0fGDJeeR+7jTVwTMX5rlDIL7ziN9CCuITPKOp
         GAFI91L+W9WvqYw74UMAm0DQXeBt3VExa4/ub5knPyNSvcaE1ExZULzzyZz5H+0lvO
         nNv47JJbKIvAhNTI6Ff5Dypj7hxcb5DF/J94rCx4mt+MU2osRB9YLfINMjr5PQjoos
         NeC+FDNv6wLsoKXCaq3F9ho7ybwWfGxafVWkhQ2bxpBZ6tGvDjDEu9w8iHSq56vjzT
         96suLMeuauFxPKf/xXap2OA7ZUi+KyQDJT+TG1FYjrNSnzbS+H8qnOH94Nmt9kzLGJ
         NQwO0UDkYUTbQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com
Subject: [PATCH 5/6] mt76: mt7915: enable radar background detection
Date:   Wed, 12 Jan 2022 15:13:52 +0100
Message-Id: <f97a4fe5bec70d8e5594c0f4d286b46b844939a5.1641996493.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641996493.git.lorenzo@kernel.org>
References: <cover.1641996493.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Notify userland the hw supports background radar/CAC detection.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 5c1643963506..91c7ce60f296 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -309,6 +309,7 @@ static void
 mt7915_init_wiphy(struct ieee80211_hw *hw)
 {
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt76_dev *mdev = &phy->dev->mt76;
 	struct wiphy *wiphy = hw->wiphy;
 	struct mt7915_dev *dev = phy->dev;
 
@@ -337,6 +338,12 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_VHT);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
 
+	if (!mdev->dev->of_node ||
+	    !of_property_read_bool(mdev->dev->of_node,
+				   "mediatek,disable-radar-background"))
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_RADAR_BACKGROUND);
+
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
 	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
-- 
2.34.1

