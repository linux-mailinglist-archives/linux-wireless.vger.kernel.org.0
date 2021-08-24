Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD343F5BF9
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 12:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhHXKXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 06:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236217AbhHXKXv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 06:23:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 986C66127B;
        Tue, 24 Aug 2021 10:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629800587;
        bh=Z3bFgKOu5bCjpmMXELSViUtooBu6UZhIj+M6GCJ/a1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OmZbGXXAwLplsr3XYxI5iQ9IC/w5tZecC9rnOif9aO+ClDE1/R6n0tkdCCmEE2W2x
         d+aGHez1baAeIDoqceuTpCO3ClVECYX+nB7mZzAwU/+mmCQEdVfvZ0+yhz5Jme2onF
         Hq1mk6mHho5kJkIZFggWt/V/K1Q486ruYV+YakLbK04NNcVkt+AuHBECQwLOa0yz03
         rUaHDxNHGIgHxY3eSSAx+mXae56rh27NpkSqhkm3+hzrNvngjwlLgr5jihbjVJgpnh
         HAcwUwblbrXqk7fYW53d32Cn17PIJrN+tLn7/dfjTgAqSBRIcaWA6EDhI8jFQGGFCP
         +4DjRWuw/BznQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH 6/9] mt76: connac: add 6GHz support to mt76_connac_mcu_uni_add_bss
Date:   Tue, 24 Aug 2021 12:22:24 +0200
Message-Id: <b8bc96eb80510f9ad0dd35703c3c43bdb2496dff.1629799385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629799385.git.lorenzo@kernel.org>
References: <cover.1629799385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to enable 6GHz band for mt7921 devices.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 11 +++++++++--
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  8 ++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ab44e61e3aaf..3b9c4180f954 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1292,7 +1292,8 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 			u8 short_st;
 			u8 ht_op_info;
 			u8 sco;
-			u8 pad[3];
+			u8 band;
+			u8 pad[2];
 		} __packed rlm;
 	} __packed rlm_req = {
 		.hdr = {
@@ -1308,13 +1309,19 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 			.ht_op_info = 4, /* set HT 40M allowed */
 			.rx_streams = phy->chainmask,
 			.short_st = true,
+			.band = band,
 		},
 	};
 	int err, conn_type;
-	u8 idx;
+	u8 idx, basic_phy;
 
 	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
 	basic_req.basic.hw_bss_idx = idx;
+	if (band == NL80211_BAND_6GHZ)
+		basic_req.basic.phymode_ext = BIT(0);
+
+	basic_phy = mt76_connac_get_phy_mode_v2(phy, vif, band, NULL);
+	basic_req.basic.nonht_basic_phy = cpu_to_le16(basic_phy);
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 5ab5e185a8bb..ea46dde364e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -668,10 +668,14 @@ struct mt76_connac_bss_basic_tlv {
 		     * bit(3): GN
 		     * bit(4): AN
 		     * bit(5): AC
+		     * bit(6): AX2
+		     * bit(7): AX5
+		     * bit(8): AX6
 		     */
 	__le16 sta_idx;
-	u8 nonht_basic_phy;
-	u8 pad[3];
+	__le16 nonht_basic_phy;
+	u8 phymode_ext; /* bit(0) AX_6G */
+	u8 pad[1];
 } __packed;
 
 struct mt76_connac_bss_qos_tlv {
-- 
2.31.1

