Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A332315D466
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 10:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbgBNJMM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 04:12:12 -0500
Received: from nbd.name ([46.4.11.11]:41280 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387402AbgBNJML (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 04:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=baDV0Xglh5+EFZY7RK+FaytXPWqDLTzBBzrfR/NZABM=; b=JwHE37AYlgmBIqD7HxqF5MP76v
        XfncoDG9tFIfiSHeVPBOkI8tvZXCjEFpYbGhzgk8TVgh+ehDIvh/62038jF14MhkvIBOX5H7ebKMk
        3z9Vby4n/gUKkGsuA13/opVu4puU1E3hjgkho9lsrvOGsn6kxAsXlN+J8je4fIBYW7kU=;
Received: from [80.255.7.100] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1j2X17-0006Ms-S3
        for linux-wireless@vger.kernel.org; Fri, 14 Feb 2020 10:12:09 +0100
Received: by maeck.local (Postfix, from userid 501)
        id D2DA27C8211E; Fri, 14 Feb 2020 10:12:08 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] mt76: do not set HOST_BROADCAST_PS_BUFFERING for mt7615
Date:   Fri, 14 Feb 2020 10:12:08 +0100
Message-Id: <20200214091208.59619-3-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200214091208.59619-1-nbd@nbd.name>
References: <20200214091208.59619-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7615 handles powersave buffering in firmware

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c     | 1 -
 drivers/net/wireless/mediatek/mt76/mt7603/init.c  | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index f74fc7130ed2..bcba1fefd723 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -295,7 +295,6 @@ mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
 
 	ieee80211_hw_set(hw, SIGNAL_DBM);
 	ieee80211_hw_set(hw, PS_NULLFUNC_STACK);
-	ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 	ieee80211_hw_set(hw, SUPPORTS_RC_TABLE);
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 182ce5a86f65..9e40e81bcc29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -557,6 +557,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
+	ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 48da4f3a17db..b7a120b0856d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -181,6 +181,7 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 	hw->vif_data_size = sizeof(struct mt76x02_vif);
 
 	ieee80211_hw_set(hw, SUPPORTS_HT_CCK_RATES);
+	ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
 
 	dev->mt76.global_wcid.idx = 255;
 	dev->mt76.global_wcid.hw_key_idx = -1;
-- 
2.24.0

