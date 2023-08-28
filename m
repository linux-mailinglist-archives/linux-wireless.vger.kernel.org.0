Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D510478B43C
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 17:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjH1PSn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 11:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjH1PSj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 11:18:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F32E8
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=9IPrJVU2rUS55tRMmqR/w+e/4oSZ7HJRGOkowaLH0wE=; t=1693235916; x=1694445516; 
        b=OS3gvq34G0nO9p7OZ45jzaP5dwMHSieV0KbASijtygFtRFUrZ1GqS9s8QsVZfceWCiCGEtEFXki
        1hBuPaB7K8aCXSFyFfyMNDj3p286KE2rJh4FVtpHSzxtcJ69dgSImQWvsPOPDntQggwIV+/ANzBAH
        aZYrInPVd0kNhnZ+n3y9btEVd7Qes4AvqjtPY7lN5AJRSZx33GwKc4rJvZvzSXm0BN6Gb2WRJTSgJ
        llklpdqHcDA4QeRtB0XanXtUTGA+ErafU6YhdahMgVkp7+qxN6MsNjzmTzrWTLUR++PbYCkZdZQbv
        j4CSjIhdsu/ipK/d9zjjqU8Q4amygvlWLtJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qae0f-00GwEC-1X;
        Mon, 28 Aug 2023 17:18:33 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH] wifi: mt76: use atomic iface iteration for pre-TBTT work
Date:   Mon, 28 Aug 2023 17:18:31 +0200
Message-ID: <20230828171830.580585e35fa7.I77619fb2d0ccdc1b25bf9c3a26014a3a21583909@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In addition to the previous series I posted, over time I'd
also like to get rid of the iflist_mtx in mac80211. That
isn't easy now since lots of places use iteration and would
have to be audited, but even a cursory look suggests that
mt76 might be more problematic than most since holding the
wiphy lock for the latency-sensitive pre-TBTT work could be
an issue.

Convert the pre-TBTT work to use atomic iteration and then
sending the device commands outside of it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c |  8 +++-----
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c   | 11 +++++++++--
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c   | 13 ++++++++++---
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index ad4dc8e17b58..d570b99bccb9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -136,7 +136,8 @@ EXPORT_SYMBOL_GPL(mt76x02_resync_beacon_timer);
 void
 mt76x02_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	struct mt76x02_dev *dev = (struct mt76x02_dev *)priv;
+	struct beacon_bc_data *data = priv;
+	struct mt76x02_dev *dev = data->dev;
 	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 	struct sk_buff *skb = NULL;
 
@@ -147,7 +148,7 @@ mt76x02_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (!skb)
 		return;
 
-	mt76x02_mac_set_beacon(dev, skb);
+	__skb_queue_tail(&data->q, skb);
 }
 EXPORT_SYMBOL_GPL(mt76x02_update_beacon_iter);
 
@@ -182,9 +183,6 @@ mt76x02_enqueue_buffered_bc(struct mt76x02_dev *dev,
 {
 	int i, nframes;
 
-	data->dev = dev;
-	__skb_queue_head_init(&data->q);
-
 	do {
 		nframes = skb_queue_len(&data->q);
 		ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index e9c5e85ec07c..9b5e3fb7b0df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -16,13 +16,17 @@ static void mt76x02_pre_tbtt_tasklet(struct tasklet_struct *t)
 	struct mt76x02_dev *dev = from_tasklet(dev, t, mt76.pre_tbtt_tasklet);
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_queue *q = dev->mphy.q_tx[MT_TXQ_PSD];
-	struct beacon_bc_data data = {};
+	struct beacon_bc_data data = {
+		.dev = dev,
+	};
 	struct sk_buff *skb;
 	int i;
 
 	if (mt76_hw(dev)->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		return;
 
+	__skb_queue_head_init(&data.q);
+
 	mt76x02_resync_beacon_timer(dev);
 
 	/* Prevent corrupt transmissions during update */
@@ -31,7 +35,10 @@ static void mt76x02_pre_tbtt_tasklet(struct tasklet_struct *t)
 
 	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
 		IEEE80211_IFACE_ITER_RESUME_ALL,
-		mt76x02_update_beacon_iter, dev);
+		mt76x02_update_beacon_iter, &data);
+
+	while ((skb = __skb_dequeue(&data.q)) != NULL)
+		mt76x02_mac_set_beacon(dev, skb);
 
 	mt76_wr(dev, MT_BCN_BYPASS_MASK,
 		0xff00 | ~(0xff00 >> dev->beacon_data_count));
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 2c6c03809b20..85a78dea4085 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -182,7 +182,9 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 {
 	struct mt76x02_dev *dev =
 		container_of(work, struct mt76x02_dev, pre_tbtt_work);
-	struct beacon_bc_data data = {};
+	struct beacon_bc_data data = {
+		.dev = dev,
+	};
 	struct sk_buff *skb;
 	int nbeacons;
 
@@ -192,15 +194,20 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 	if (mt76_hw(dev)->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		return;
 
+	__skb_queue_head_init(&data.q);
+
 	mt76x02_resync_beacon_timer(dev);
 
 	/* Prevent corrupt transmissions during update */
 	mt76_set(dev, MT_BCN_BYPASS_MASK, 0xffff);
 	dev->beacon_data_count = 0;
 
-	ieee80211_iterate_active_interfaces(mt76_hw(dev),
+	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
 		IEEE80211_IFACE_ITER_RESUME_ALL,
-		mt76x02_update_beacon_iter, dev);
+		mt76x02_update_beacon_iter, &data);
+
+	while ((skb = __skb_dequeue(&data.q)) != NULL)
+		mt76x02_mac_set_beacon(dev, skb);
 
 	mt76_csa_check(&dev->mt76);
 
-- 
2.41.0

