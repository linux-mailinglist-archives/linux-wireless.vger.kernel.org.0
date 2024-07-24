Return-Path: <linux-wireless+bounces-10466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960FC93AC28
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 07:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A111C22CC7
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 05:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEC92572;
	Wed, 24 Jul 2024 05:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="hYA7tOCK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF604B5C1
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721797512; cv=none; b=RdlurCYMuWN4IuvaLpJxf4JFKOHmaBgjJ6NehdVg+Rg0E4rHaQuiKsGe6JPNsyAcXC1AuT65TsLqTcO2Xmdz3OMFTXbC8e4AK4ICTaRgo/OBB/dNLALaFsHIcFLg6sxtHlv4mA6Rpgu7jz17xmxLcVIRVW5GgpWbDdBioJ64qug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721797512; c=relaxed/simple;
	bh=euiib8Qa4+uy6CrOCmqWulNoBBz+xZ14q9VfSPPGV+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c73JfCzNRIy0V2peCDvYi2M6cBifZ7MOhp6Tr7JHdfda8DGPkxBkXbnNJ5ZRvLlNdAAAaClUIfubsJNRDSHceQntC6QvagPK7fp8MTFob8Hs2p0Id0rnxuEDm4Grvq0uarw/pQZZLqqGKjHiv9zzgvF/iodnKWyipfw2Af3JS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=hYA7tOCK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46O557thC1883077, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721797507; bh=euiib8Qa4+uy6CrOCmqWulNoBBz+xZ14q9VfSPPGV+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=hYA7tOCK0FaF9PmaTbyICwP/ILD7LvClYj6qKhsfmlhLByn8FZ595xGhYafNlRrDH
	 dfz8MmLO9354fhsBSKDLKZZL7A8QLGZrGvTlsiAF/ierMVeSou9UcBgRlzVKXV6Ohy
	 rlAswdN5Y2Q6nNQD2zOGsQ8n94bZgGsWQmD1M5tJh2T50pDK9WPK6jl4cAfjWX/Q2E
	 udB57QCQ2KILX9DqZzIv/ONCtEHC78qfguUM7i73t0gkl0PqioThFOA7HKlY/jz/4R
	 dh70D8fJa1U32nzQj/c+OPsbjSQxdwPCPGA/vq0t36YtHwjb8jxy3L4WzP0A3idyhE
	 Opu4jOZbYgNew==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46O557thC1883077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 13:05:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 13:05:07 +0800
Received: from [127.0.1.1] (172.16.23.66) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Jul
 2024 13:05:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: [PATCH] wifi: rtw88: 8822c: Parse channel from IE to correct invalid hardware reports
Date: Wed, 24 Jul 2024 13:05:01 +0800
Message-ID: <20240724050501.7550-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Po-Hao Huang <phhuang@realtek.com>

For CCK packets we could get incorrect reports from hardware.
And this causes wrong frequencies being reported. Parse the channel
information from IE if provided by AP to fix this.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/pci.c      |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  7 ++--
 drivers/net/wireless/realtek/rtw88/rx.c       | 41 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rx.h       | 13 ++++++
 drivers/net/wireless/realtek/rtw88/sdio.c     |  1 +
 drivers/net/wireless/realtek/rtw88/usb.c      |  2 +
 7 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 9d21637cf5d5..37912dded128 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -622,6 +622,7 @@ struct rtw_rx_pkt_stat {
 	bool crc_err;
 	bool decrypted;
 	bool is_c2h;
+	bool channel_invalid;
 
 	s32 signal_power;
 	u16 pkt_len;
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index a5b9d6c7be37..5d0580da13fb 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1088,6 +1088,7 @@ static u32 rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 			/* remove rx_desc */
 			skb_pull(new, pkt_offset);
 
+			rtw_update_rx_freq_for_invalid(rtwdev, new, &rx_status, &pkt_stat);
 			rtw_rx_stats(rtwdev, pkt_stat.vif, new);
 			memcpy(new->cb, &rx_status, sizeof(rx_status));
 			ieee80211_rx_napi(rtwdev->hw, NULL, new, napi);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index bc807b13e9ce..96a233079e02 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2576,9 +2576,10 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 	rx_power[RF_PATH_B] -= 110;
 
 	channel = GET_PHY_STAT_P0_CHANNEL(phy_status);
-	if (channel == 0)
-		channel = rtwdev->hal.current_channel;
-	rtw_set_rx_freq_band(pkt_stat, channel);
+	if (channel != 0)
+		rtw_set_rx_freq_band(pkt_stat, channel);
+	else
+		pkt_stat->channel_invalid = true;
 
 	pkt_stat->rx_power[RF_PATH_A] = rx_power[RF_PATH_A];
 	pkt_stat->rx_power[RF_PATH_B] = rx_power[RF_PATH_B];
diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 84aedabdf285..66f9419588cf 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -146,6 +146,47 @@ static void rtw_set_rx_freq_by_pktstat(struct rtw_rx_pkt_stat *pkt_stat,
 	rx_status->band = pkt_stat->band;
 }
 
+void rtw_update_rx_freq_from_ie(struct rtw_dev *rtwdev, struct sk_buff *skb,
+				struct ieee80211_rx_status *rx_status,
+				struct rtw_rx_pkt_stat *pkt_stat)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	int channel = rtwdev->hal.current_channel;
+	size_t hdr_len, ielen;
+	int channel_number;
+	u8 *variable;
+
+	if (!test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
+		goto fill_rx_status;
+
+	if (ieee80211_is_beacon(mgmt->frame_control)) {
+		variable = mgmt->u.beacon.variable;
+		hdr_len = offsetof(struct ieee80211_mgmt,
+				   u.beacon.variable);
+	} else if (ieee80211_is_probe_resp(mgmt->frame_control)) {
+		variable = mgmt->u.probe_resp.variable;
+		hdr_len = offsetof(struct ieee80211_mgmt,
+				   u.probe_resp.variable);
+	} else {
+		goto fill_rx_status;
+	}
+
+	if (skb->len > hdr_len)
+		ielen = skb->len - hdr_len;
+	else
+		goto fill_rx_status;
+
+	channel_number = cfg80211_get_ies_channel_number(variable, ielen,
+							 NL80211_BAND_2GHZ);
+	if (channel_number != -1)
+		channel = channel_number;
+
+fill_rx_status:
+	rtw_set_rx_freq_band(pkt_stat, channel);
+	rtw_set_rx_freq_by_pktstat(pkt_stat, rx_status);
+}
+EXPORT_SYMBOL(rtw_update_rx_freq_from_ie);
+
 void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
 			   struct rtw_rx_pkt_stat *pkt_stat,
 			   struct ieee80211_hdr *hdr,
diff --git a/drivers/net/wireless/realtek/rtw88/rx.h b/drivers/net/wireless/realtek/rtw88/rx.h
index d3668c4efc24..2f1539068f1a 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.h
+++ b/drivers/net/wireless/realtek/rtw88/rx.h
@@ -50,5 +50,18 @@ void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
 			   struct ieee80211_hdr *hdr,
 			   struct ieee80211_rx_status *rx_status,
 			   u8 *phy_status);
+void rtw_update_rx_freq_from_ie(struct rtw_dev *rtwdev, struct sk_buff *skb,
+				struct ieee80211_rx_status *rx_status,
+				struct rtw_rx_pkt_stat *pkt_stat);
+
+static inline
+void rtw_update_rx_freq_for_invalid(struct rtw_dev *rtwdev, struct sk_buff *skb,
+				    struct ieee80211_rx_status *rx_status,
+				    struct rtw_rx_pkt_stat *pkt_stat)
+{
+	if (pkt_stat->channel_invalid)
+		rtw_update_rx_freq_from_ie(rtwdev, skb, rx_status, pkt_stat);
+}
+
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 0cae5746f540..763aa8212a4b 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -948,6 +948,7 @@ static void rtw_sdio_rx_skb(struct rtw_dev *rtwdev, struct sk_buff *skb,
 	skb_put(skb, pkt_stat->pkt_len);
 	skb_reserve(skb, pkt_offset);
 
+	rtw_update_rx_freq_for_invalid(rtwdev, skb, rx_status, pkt_stat);
 	rtw_rx_stats(rtwdev, pkt_stat->vif, skb);
 
 	ieee80211_rx_irqsafe(rtwdev->hw, skb);
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 251a5726f3ee..9145c11a063e 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -579,6 +579,8 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 
 		skb_put(skb, pkt_stat.pkt_len);
 		skb_reserve(skb, pkt_offset);
+
+		rtw_update_rx_freq_for_invalid(rtwdev, skb, &rx_status, &pkt_stat);
 		memcpy(skb->cb, &rx_status, sizeof(rx_status));
 		ieee80211_rx_irqsafe(rtwdev->hw, skb);
 	}
-- 
2.25.1


