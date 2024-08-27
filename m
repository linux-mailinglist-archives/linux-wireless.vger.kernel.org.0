Return-Path: <linux-wireless+bounces-12059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5C4960676
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987241F22ACD
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1982219DF66;
	Tue, 27 Aug 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="mV0HuQE7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD619DF61
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752583; cv=none; b=d/QcW1ABEBe00zLNxlJhTAKBSPxxZMYNLKlDB7kNaicDQ1L80ONp0iiC8RM7x4fWBeyFr8hID5MI1cptpY/AIwRwfMuxHfTPkK7dhUU1Y+L4WXnYSo7OT1KBBLQBbCn15CxWh7Ao/i59ry4XtTmsdqQbzKFGifgbCShLRGK6J6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752583; c=relaxed/simple;
	bh=Fh4ZquSL7SD6z+IyjjcN7i0I8OXuUIMHHCoR5Dfku1A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwHy+KE2fQ+JEEA6H9fxkTHAun7kfb+FWnX8v0Mtvg6v00QZ6DGZTZePdPeMVDhDegeBF3OAlZdayOoXG41mOecUVbvcNYuP+nGYSmK3gYkzgrdxAwd8eS4iQcSRMPA3Fp7G/MMnVzUhcM5TMQpHBsmMlYGty5yscVM4S7aimTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=mV0HuQE7; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fxN5Pf4ENkygrUnNkK4NOjC/PWNWTlMr5SQTo/CVJoc=; b=mV0HuQE74o0PNgWVk7NFAy1TTI
	Zd/19xk3DK+heBt6lPu5tRB32KcEWwHrL3/GDRcKpzJ30/7+tWNfLYkD1ylpuwWsZfMglbEcsj3si
	tAA4YPvy++YYK8iXMtYj/ccCV0j+8pkoM/4aEWKoM13YrFUlohWhHmGTdAuk7nw8e+l8=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWn-004Ww8-17
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:17 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 18/24] wifi: mt76: connac: move mt7615_mcu_del_wtbl_all to connac
Date: Tue, 27 Aug 2024 11:30:05 +0200
Message-ID: <20240827093011.18621-18-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-1-nbd@nbd.name>
References: <20240827093011.18621-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparation for reusing it in mt7915

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      | 10 ----------
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h   |  1 -
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  1 +
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index f7722f67db57..f9274c130c57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -319,7 +319,7 @@ void mt7615_init_work(struct mt7615_dev *dev)
 	mt7615_mcu_set_eeprom(dev);
 	mt7615_mac_init(dev);
 	mt7615_phy_init(dev);
-	mt7615_mcu_del_wtbl_all(dev);
+	mt76_connac_mcu_del_wtbl_all(&dev->mt76);
 	mt7615_check_offload_capability(dev);
 }
 EXPORT_SYMBOL_GPL(mt7615_init_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index f6eb9939c3e2..159218874802 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1880,16 +1880,6 @@ int mt7615_mcu_set_dbdc(struct mt7615_dev *dev)
 				 sizeof(req), true);
 }
 
-int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
-{
-	struct wtbl_req_hdr req = {
-		.operation = WTBL_RESET_ALL,
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(WTBL_UPDATE),
-				 &req, sizeof(req), true);
-}
-
 int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 68f4a7727a26..530da48ce3ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -399,7 +399,6 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *rates);
 void mt7615_pm_wake_work(struct work_struct *work);
 void mt7615_pm_power_save_work(struct work_struct *work);
-int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev);
 int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd);
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 		       const struct ieee80211_tx_queue_params *params);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 3a575cebe4a9..864246f94088 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2849,6 +2849,17 @@ int mt76_connac_mcu_restart(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_restart);
 
+int mt76_connac_mcu_del_wtbl_all(struct mt76_dev *dev)
+{
+	struct wtbl_req_hdr req = {
+		.operation = WTBL_RESET_ALL,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(WTBL_UPDATE),
+				 &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_del_wtbl_all);
+
 int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
 			    u8 rx_sel, u8 val)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index e04ae7eddb01..66d70d6e7957 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -2032,6 +2032,7 @@ void mt76_connac_mcu_wtbl_smps_tlv(struct sk_buff *skb,
 				   void *sta_wtbl, void *wtbl_tlv);
 int mt76_connac_mcu_set_pm(struct mt76_dev *dev, int band, int enter);
 int mt76_connac_mcu_restart(struct mt76_dev *dev);
+int mt76_connac_mcu_del_wtbl_all(struct mt76_dev *dev);
 int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
 			    u8 rx_sel, u8 val);
 int mt76_connac_mcu_sta_wed_update(struct mt76_dev *dev, struct sk_buff *skb);
-- 
2.46.0


