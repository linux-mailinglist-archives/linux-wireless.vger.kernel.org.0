Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1E13CAD8B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jul 2021 22:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346700AbhGOUGk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 16:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241055AbhGOUGc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 16:06:32 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D4EC08EE76
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jul 2021 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OK+MoTyZsq17izadFHbsWJ086j0/zznA0Pv7m3goF2U=; b=n0LTqFGyldprZYDzp4AYeyG04B
        SgErPCYkoq5smhXDZz0vkJuVUUkZoKs/JO3gsHpEfGKFt4yyLYfnTt+Xxh1b1ct4aOay6Oaey/t6W
        3DlK4JaU2tiNW7KG4gl43k2Gst+HDgprPCHzgXYXGz0XnCzfGHDjyb2OmHI0GL2J8cPY=;
Received: from p54ae93f7.dip0.t-ipconnect.de ([84.174.147.247] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1m47Rh-00046W-4e; Thu, 15 Jul 2021 21:54:57 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v4 1/3] mt76: add mt76_default_basic_rate more devices can rely on
Date:   Thu, 15 Jul 2021 21:54:52 +0200
Message-Id: <20210715195454.12370-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

add mt76_default_basic_rate to mt76 core more devices can rely on
to send frames which require the rate in the basic rates.

Suggested-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 14 ++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index ee3a5b8d62d2..7403a012ceed 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1351,3 +1351,17 @@ mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
 	return hwq;
 }
 EXPORT_SYMBOL_GPL(mt76_init_queue);
+
+u16 mt76_default_basic_rate(struct mt76_phy *phy, struct ieee80211_vif *vif)
+{
+	int i = ffs(vif->bss_conf.basic_rates) - 1, offset = 0;
+	struct ieee80211_rate *rate;
+
+	if (phy->chandef.chan->band == NL80211_BAND_5GHZ)
+		offset = 4;
+
+	rate = &mt76_rates[offset + i];
+
+	return rate->hw_value;
+}
+EXPORT_SYMBOL_GPL(mt76_default_basic_rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0516d3afe262..bf36f9227713 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -891,6 +891,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *data, int offset, int len);
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
 		int ring_base);
+u16 mt76_default_basic_rate(struct mt76_phy *phy, struct ieee80211_vif *vif);
 static inline int mt76_init_tx_queue(struct mt76_phy *phy, int qid, int idx,
 				     int n_desc, int ring_base)
 {
-- 
2.30.1

