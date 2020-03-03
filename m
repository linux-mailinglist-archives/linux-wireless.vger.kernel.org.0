Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D0717757D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 12:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgCCLug (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 06:50:36 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:59762 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgCCLug (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 06:50:36 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 88010580075;
        Tue,  3 Mar 2020 12:50:34 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 3/3] mt76: set monitor mode scan ext. feature
Date:   Tue,  3 Mar 2020 12:50:17 +0100
Message-Id: <20200303115017.9845-3-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303115017.9845-1-markus.theil@tu-ilmenau.de>
References: <20200303115017.9845-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch enables monitor mode scanning for the mt76 driver.

I tested this with the following interface combinations:
  * 1 monitor VIF
  * 1 STA VIF + 1 monitor VIF
  * 1 AP VIF + 1 monitor VIF

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 96018fd65779..781511cc736d 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -316,6 +316,7 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_MONITOR_MODE_SCAN);
 
 	wiphy->available_antennas_tx = dev->antenna_mask;
 	wiphy->available_antennas_rx = dev->antenna_mask;
-- 
2.25.1

