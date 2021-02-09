Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3163314DBA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 12:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhBIK7z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 05:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232239AbhBIK5o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 05:57:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A603264E50;
        Tue,  9 Feb 2021 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612868077;
        bh=jvJmsvkjXBnY5thcyMdcgLFhIjSb6D2GbwDkba82v7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSkUzIl8OcgXx/gnvxKvTdTYCFZm+v9N1N53hzgvXcRAMuiPxB5tjCHuiMT2DsWjS
         6kQRKvpDAW8s/BBLBOcVK/F48AGp8azROeIPd8f2MEphOfVbjnJBLlpCsCbfZH7ytH
         KNDGg1KSpQ6iUTzu34hZnJ3w9dIQfCE6koItse4WGDxABAn0eOJUhI3InybAfFNrKM
         4rP9vrSWrIuknj8omsKQnpkpk5b1YiorJ+fhny3x6eigTQIZeBq6CxOGyXW55xq31h
         fGQRItn6RdnZyYEDX10gbXgRbU9+jSiE1mNlatNhWohp+qUBV3W3xLfkdcNhIW+OKk
         OsQ5DC6SZY0UA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 6/6] mt76: connac: update sched_scan cmd usage
Date:   Tue,  9 Feb 2021 11:54:07 +0100
Message-Id: <df691353deda63d0315fc122694981c1f7f59995.1612867656.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612867656.git.lorenzo@kernel.org>
References: <cover.1612867656.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Update sched_scan command usage according to the current firmware
submitted into linux-firmware.git.

Fixes: 80fc1e37c0eb ("mt76: mt7921: rely on mt76_connac_mcu module for sched_scan and hw_scan")
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |  5 -----
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |  5 +++++
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |  7 +++++--
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   | 14 +++++++++++---
 4 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 491841bc6291..5ef19fbee6bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -408,11 +408,6 @@ static inline bool is_mt7615(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7615 || mt76_chip(dev) == 0x7611;
 }
 
-static inline bool is_mt7663(struct mt76_dev *dev)
-{
-	return mt76_chip(dev) == 0x7663;
-}
-
 static inline bool is_mt7611(struct mt76_dev *dev)
 {
 	return mt76_chip(dev) == 0x7611;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 0d58606391b0..b811f3c410a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -73,6 +73,11 @@ static inline bool is_mt7921(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7961;
 }
 
+static inline bool is_mt7663(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7663;
+}
+
 int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm);
 void mt76_connac_power_save_sched(struct mt76_phy *phy,
 				  struct mt76_connac_pm *pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 4356bf130dbd..1ee4e627ea00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1435,10 +1435,13 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
 	req->version = 1;
 	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
 
-	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
-		get_random_mask_addr(req->random_mac, sreq->mac_addr,
+	if (is_mt7663(phy->dev) &&
+	    (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR)) {
+		get_random_mask_addr(req->mt7663.random_mac, sreq->mac_addr,
 				     sreq->mac_addr_mask);
 		req->scan_func = 1;
+	} else if (is_mt7921(phy->dev)) {
+		req->mt7921.bss_idx = mvif->idx;
 	}
 
 	req->ssids_num = sreq->n_ssids;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index c1e1df5f7cd7..4dca07e4e8aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -759,11 +759,19 @@ struct mt76_connac_sched_scan_req {
 	u8 channel_type;
 	u8 channels_num;
 	u8 intervals_num;
-	u8 scan_func; /* BIT(0) eable random mac address */
+	u8 scan_func; /* MT7663: BIT(0) eable random mac address */
 	struct mt76_connac_mcu_scan_channel channels[64];
 	__le16 intervals[MT76_CONNAC_MAX_SCHED_SCAN_INTERVAL];
-	u8 random_mac[ETH_ALEN]; /* valid when BIT(0) in scan_func is set */
-	u8 pad2[58];
+	union {
+		struct {
+			u8 random_mac[ETH_ALEN];
+			u8 pad2[58];
+		} mt7663;
+		struct {
+			u8 bss_idx;
+			u8 pad2[63];
+		} mt7921;
+	};
 } __packed;
 
 struct mt76_connac_sched_scan_done {
-- 
2.29.2

