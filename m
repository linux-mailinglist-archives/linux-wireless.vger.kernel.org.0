Return-Path: <linux-wireless+bounces-17014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346A9FFBE0
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057F31883C9A
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04BF1B6CEA;
	Thu,  2 Jan 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="jOa4872p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D441616F8F5
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835726; cv=none; b=N1VZGgVsEqre2/d5jcPXbgqWPkCKYjFc7pMD/ryPCs/6i+60XzQl9rMKHsJ0/g/a/bd0Ogxqk/Mx1oI7QXq8DNWQBcJgWlK0AY90zTuJiI+xeXpoF4wHCMMW2U9+Jgyvlxa4ptKHL1EqnSILvJE1zMhFU0xMbZzBcXZuQaTotq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835726; c=relaxed/simple;
	bh=e4B6Sf6Nh6+A2oO3ovral4ECyor7MYdB8K80rwgaEcQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tf5TXEJVWwpghi4Me3aNorm3X4wNlvElmFCILFDwem9B9nXDvk+4Ti8qIjUnygWnEoEcbgvdutJMeX5OvVIfpjlTz0W+EPxJFvK4S9OJ/MLitcMAVIygT8v0aWjytgeeIVfsKbL732nWCPxCMwFGFiDw09sFxuTdpcr1H0lNsnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=jOa4872p; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9JfTwmyw/8JxfsQbpi9/GeIy3z6B2Sd6pc/YK/eWaLM=; b=jOa4872pCkIPDotG7QTO8eL8a+
	ytL1mChd6TIDDFuYLfUHV1sQMOohP7af5HlTorkI56AAaAQb2a+mazeu7dkWHX2wnglXDJdFoRWex
	ByhrhxG9svDDcmAMr0nn0SII62romilIZiv4mwzZ/4C7Mu4NmjkxWxbBufNXZt/LR1hs=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAF-0008GS-0u
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:15 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 24/24] wifi: mt76: mt7996: fix monitor mode
Date: Thu,  2 Jan 2025 17:35:08 +0100
Message-ID: <20250102163508.52945-24-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102163508.52945-1-nbd@nbd.name>
References: <20250102163508.52945-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable sniffer mode via MCU command in order to properly enable promiscuous
mode on the device.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 21 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 77b97324f7d7..27826577dffc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -368,6 +368,7 @@ static void mt7996_set_monitor(struct mt7996_phy *phy, bool enabled)
 	mt76_rmw_field(dev, MT_DMA_DCR0(phy->mt76->band_idx),
 		       MT_DMA_DCR0_RXD_G5_EN, enabled);
 	mt7996_phy_set_rxfilter(phy);
+	mt7996_mcu_set_sniffer_mode(phy, enabled);
 }
 
 static int mt7996_add_interface(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 6abd666ff19d..58fc06a69539 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4496,6 +4496,27 @@ int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id)
 				 sizeof(req), true);
 }
 
+int mt7996_mcu_set_sniffer_mode(struct mt7996_phy *phy, bool enabled)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct {
+		u8 band_idx;
+		u8 _rsv[3];
+		__le16 tag;
+		__le16 len;
+		u8 enable;
+		u8 _pad[3];
+	} __packed req = {
+		.band_idx = phy->mt76->band_idx,
+		.tag = 0,
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.enable = enabled,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(SNIFFER), &req,
+				 sizeof(req), true);
+}
+
 int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
 {
 #define TX_POWER_LIMIT_TABLE_RATE	0
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 18ae2e3ad71b..1cfcac51a338 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -621,6 +621,7 @@ void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb);
 void mt7996_mcu_exit(struct mt7996_dev *dev);
 int mt7996_mcu_get_all_sta_info(struct mt7996_phy *phy, u16 tag);
 int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id);
+int mt7996_mcu_set_sniffer_mode(struct mt7996_phy *phy, bool enabled);
 
 static inline u8 mt7996_max_interface_num(struct mt7996_dev *dev)
 {
-- 
2.47.1


