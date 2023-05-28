Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDAC713B6F
	for <lists+linux-wireless@lfdr.de>; Sun, 28 May 2023 20:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjE1SEf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 May 2023 14:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE1SEe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 May 2023 14:04:34 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8636DA3
        for <linux-wireless@vger.kernel.org>; Sun, 28 May 2023 11:04:33 -0700 (PDT)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4QTml50GzSz9t4L;
        Sun, 28 May 2023 18:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1685297073; bh=kd0gr9zU3M9sCyyuW1FElZLLgJs0S0mlTv0FCVwrOT0=;
        h=Date:From:Subject:To:Cc:From;
        b=SMuFZKWvNiVQTV/+ZQosF3/lH59tEr6hEX3adEvqCRNU9nMCUOpVB6YMklGiuLR3S
         f5J+SC0ReU7EGFAhFhMVM5l6u4oZXzp6ZgO48PgFw96ayv6biXlcMJ6KIu/A1f/pRH
         7jB0LxX/D8k2ggzchAlmhV8wOYiRNJ9D0H0HmUKo=
X-Riseup-User-ID: F3B25438CE897A8CBA30A1FCD53C2EE40712085F7E84966CED8E7CD1EA643C96
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4QTml234zPzFs02;
        Sun, 28 May 2023 18:04:30 +0000 (UTC)
Message-ID: <61b9ff43-1064-f928-2ebe-4c40b564540b@riseup.net>
Date:   Sun, 28 May 2023 21:04:28 +0300
MIME-Version: 1.0
From:   Rany Hany <rany_hany@riseup.net>
Subject: [PATCH 1/1] wifi: mt76: mt7915: fix command timeout in AP stop period
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Due to AP stop improperly, mt7915 driver would face random command timeout
by chip fw problem. Migrate AP start/stop process to .start_ap/.stop_ap and
congiure BSS network settings in both hooks.

The new flow is shown below.
* AP start
    .start_ap()
      configure BSS network resource
      set BSS to connected state
    .bss_info_changed()
      enable fw beacon offload

* AP stop
    .bss_info_changed()
      disable fw beacon offload (skip this command)
    .stop_ap()
      set BSS to disconnected state (beacon offload disabled automatically)
      destroy BSS network resource

Based on "mt76: mt7921: fix command timeout in AP stop period"

Signed-off-by: Rany Hany <rany_hany@riseup.net>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 38 ++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 1b361199c061..cc37cb8e89f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -629,11 +629,6 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
-	if (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon) {
-		mt7915_mcu_add_bss_info(phy, vif, true);
-		mt7915_mcu_add_sta(dev, vif, NULL, true);
-	}
-
 	/* ensure that enable txcmd_mode after bss_info */
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
 		mt7915_mcu_set_tx(dev, vif);
@@ -653,6 +648,37 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static int
+mt7915_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		struct ieee80211_bss_conf *link_conf)
+{
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	int err;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	err = mt7915_mcu_add_bss_info(phy, vif, true);
+	if (err)
+		goto out;
+	err = mt7915_mcu_add_sta(dev, vif, NULL, true);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+
+static void
+mt7915_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_bss_conf *link_conf)
+{
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7915_mcu_add_sta(dev, vif, NULL, false);
+	mutex_unlock(&dev->mt76.mutex);
+}
+
 static void
 mt7915_channel_switch_beacon(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
@@ -1526,6 +1552,8 @@ const struct ieee80211_ops mt7915_ops = {
 	.conf_tx = mt7915_conf_tx,
 	.configure_filter = mt7915_configure_filter,
 	.bss_info_changed = mt7915_bss_info_changed,
+	.start_ap = mt7915_start_ap,
+	.stop_ap = mt7915_stop_ap,
 	.sta_add = mt7915_sta_add,
 	.sta_remove = mt7915_sta_remove,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
-- 
2.34.1



