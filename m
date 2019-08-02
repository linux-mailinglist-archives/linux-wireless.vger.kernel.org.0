Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 711EA7FC53
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2019 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392317AbfHBOge (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Aug 2019 10:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729971AbfHBOge (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Aug 2019 10:36:34 -0400
Received: from localhost.localdomain.com (unknown [151.66.59.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4F5204EC;
        Fri,  2 Aug 2019 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564756593;
        bh=UKeMuLm5a8VetpuMKRmf8eCa5s3iwEpOb70hLTJ7BTU=;
        h=From:To:Cc:Subject:Date:From;
        b=IaX8hhOcY1KWc+MvmpgQRj+7BVcBBGsIRztKyw0CJOJy4ZHE+o3u81icWyVvgWiZ+
         08jwjIiX6VIzz3oRHu5ZEjTDLz0NiL5B7MgaCwb8oqAUY2F6Nwy1oRz4IFWovRzgrC
         +gJqCixrdc0VVygGORG9a5UboEpgwH0P7NjJ1ES0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH] mt76: mt76x02u: enable multi-vif support
Date:   Fri,  2 Aug 2019 16:36:20 +0200
Message-Id: <3edec94719a37a58576d530bba05dc629dfef2e0.1564750297.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable multi-interface support for mt76x02u driver. For the moment
allow max two concurrent interfaces in order to preserve enough room
for ps traffic since we are using beacon slots for it.
I have successfully tested the following configuration:
- AP + STA
- AP0 + AP1

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index fa45ed280ab1..476f0157a370 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -61,6 +61,20 @@ static const struct ieee80211_iface_limit mt76x02_if_limits[] = {
 	 },
 };
 
+static const struct ieee80211_iface_limit mt76x02u_if_limits[] = {
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_ADHOC)
+	}, {
+		.max = 2,
+		.types = BIT(NL80211_IFTYPE_STATION) |
+#ifdef CONFIG_MAC80211_MESH
+			 BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
+			 BIT(NL80211_IFTYPE_AP)
+	},
+};
+
 static const struct ieee80211_iface_combination mt76x02_if_comb[] = {
 	{
 		.limits = mt76x02_if_limits,
@@ -75,6 +89,16 @@ static const struct ieee80211_iface_combination mt76x02_if_comb[] = {
 	}
 };
 
+static const struct ieee80211_iface_combination mt76x02u_if_comb[] = {
+	{
+		.limits = mt76x02u_if_limits,
+		.n_limits = ARRAY_SIZE(mt76x02u_if_limits),
+		.max_interfaces = 2,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = true,
+	}
+};
+
 static void
 mt76x02_led_set_config(struct mt76_dev *mdev, u8 delay_on,
 		       u8 delay_off)
@@ -151,6 +175,8 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 	if (mt76_is_usb(dev)) {
 		hw->extra_tx_headroom += sizeof(struct mt76x02_txwi) +
 					 MT_DMA_HDR_LEN;
+		wiphy->iface_combinations = mt76x02u_if_comb;
+		wiphy->n_iface_combinations = ARRAY_SIZE(mt76x02u_if_comb);
 	} else {
 		INIT_DELAYED_WORK(&dev->wdt_work, mt76x02_wdt_work);
 
-- 
2.21.0

