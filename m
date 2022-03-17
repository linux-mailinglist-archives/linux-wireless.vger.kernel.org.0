Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A2A4DCC0F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 18:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiCQRKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 13:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbiCQRKK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 13:10:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7C9C6EEB
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 10:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ADB861504
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 17:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12BEC340ED;
        Thu, 17 Mar 2022 17:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647536931;
        bh=u3e4MiT1GBHxr9p97shtHhH4ijNLsh9dAnnU4OpyuUs=;
        h=From:To:Cc:Subject:Date:From;
        b=Y/i5lUKVs4gkvAaL/SlK55pvCmSOAjDUiAJgpmr8x4cqtOQJRwx/EkSqb7U5Anb6W
         I6XaTnKEJQJVJzwsH+B/Gl2n3uamfw/RHYU7VZNcoQDmwNh2Xn4N/dPAKjfqv1qJnu
         TSIIBArNzfDJls3pcZbg4m2g0DhzcOi8TvjvQaMJqH68Mn4HwWz9YyvYCSMaAEvNVO
         7QgxSAYigqCGl4z/Vlad31r6zGq4QN0GjyZquyuGdpi/iVENzff6jblZTUftwupxrh
         nnqFEL3NZx2+g1rWe/0fnrXviGmZtnAEFrIF2k2O1HKgBg72w89e4fHb+JhFRTbNZ8
         C2nIP2ySshvjQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: mt7921: honor pm user configuration in mt7921_sniffer_interface_iter
Date:   Thu, 17 Mar 2022 18:08:35 +0100
Message-Id: <c7da8e84d481a8105664f10d86a6f7a14e9f1d86.1647536886.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Honor runtime-pm user configuration in mt7921_sniffer_interface_iter
routine if we do not have a monitor interface.

Fixes: 1f12fa34e5dc5 ("mt76: mt7921: don't enable beacon filter when IEEE80211_CONF_CHANGE_MONITOR is set")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3c56b1108265..e1bd01aa77b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -489,8 +489,8 @@ mt7921_sniffer_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
 	mt7921_mcu_set_sniffer(dev, vif, monitor);
-	pm->enable = !monitor;
-	pm->ds_enable = !monitor;
+	pm->enable = pm->enable_user && !monitor;
+	pm->ds_enable = pm->ds_enable_user && !monitor;
 
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 
-- 
2.35.1

