Return-Path: <linux-wireless+bounces-27285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9675EB570A9
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4BC189CA9E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 06:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D41214236;
	Mon, 15 Sep 2025 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EK0XRgYm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525442C028B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919225; cv=none; b=VC9ZV5Fnw0CSBq+fSQJ2C+Z54LepR6Xrzp84XcwyKCT6/hNyZ/9mOjPWNjm03vZmsVqk+tycRVMKhXEnHJGwnWcrhR7+QNtnrJavsRnDun41r1gsZVWD25LALZV+ijTPckOHqPSqURDh4twjm899TuUlPCoQ0C+hFsAhN1bAbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919225; c=relaxed/simple;
	bh=U1x3cCBFD7rrbqbl1YExTkNXqUKyJwAkbL7EB6yOKAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGfXstJ7Hb2hJTPD474zO46SpyX/f0yQ1zeTb2vK128KJ80VBYsyH6FKwpuV7B4++cSGt8VEpCkafCsfCgvUp7RRwwR8NSsqHJAy1Lub421qwh+bBOdrWnXL869+32AGKWbr3rQtc4IMniOzT8q/DlSNeil+iQZlIVCLuDFBnIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EK0XRgYm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58F6re0nB591142, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757919220; bh=6p6+qYwVv6gDdODJb0S5pV4m4k4UKebsFn6xAikw/qQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EK0XRgYml3WYjkuFe2wLuVp3WiSo5gYrV3HEUGBlygK8/MGS7L5IKbnX+D6Tva/Xr
	 012o59BzUxs6He8OEKR7R2nR18NHaJEW7jCqjht4m/uwieQvxX0x7wly1oQC3SuFhE
	 iRDnYT7qG2X9gYRR19nBdedwQCjh2iUG0O6adzhxrA9fq1kaUtxfVcLIXRDwLlThdQ
	 p9IC/9bXcysbSkeQj/ttFIZoxhx9o52tXVDAzlazB+xKWccRthbnE4BVu1dALWLpx1
	 FLzJid6wZGa3qQTICWNw/iBgGked0b7bXiDcWb5UhVXfBR20xyDeIpG/KazGQSUjW5
	 xeBIaExH/tiPQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58F6re0nB591142
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 14:53:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 15 Sep 2025 14:53:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 15 Sep
 2025 14:53:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/11] wifi: rtw89: use ieee80211_tx_info::driver_data to store driver TX info
Date: Mon, 15 Sep 2025 14:52:04 +0800
Message-ID: <20250915065213.38659-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915065213.38659-1-pkshih@realtek.com>
References: <20250915065213.38659-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

It makes more sense to use ieee80211_tx_info::driver_data instead of
ieee80211_tx_info::status.status_driver_data which is used to share
TX status reporting to mac80211, because actually driver calls
ieee80211_tx_info_clear_status() to clear the content including
status_driver_data in rtw89_pci_tx_status() before filling the status.

Review and point out the scope (by comments) driver can safely use
ieee80211_tx_info::driver_data between rtw89_hci_tx_write() and
calling ieee80211_tx_info_clear_status().

Add BUILD_BUG_ON() to assert that driver struct size is smaller than
the size defined by mac80211.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 6 +++++-
 drivers/net/wireless/realtek/rtw89/pci.h  | 9 +++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ecfbcff85047..2841ea84bbc0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6390,9 +6390,13 @@ static inline void rtw89_hci_clear(struct rtw89_dev *rtwdev, struct pci_dev *pde
 static inline
 struct rtw89_tx_skb_data *RTW89_TX_SKB_CB(struct sk_buff *skb)
 {
+	/*
+	 * This should be used by/after rtw89_hci_tx_write() and before doing
+	 * ieee80211_tx_info_clear_status().
+	 */
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 
-	return (struct rtw89_tx_skb_data *)info->status.status_driver_data;
+	return (struct rtw89_tx_skb_data *)info->driver_data;
 }
 
 static inline u8 rtw89_read8(struct rtw89_dev *rtwdev, u32 addr)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index fc8268eb44db..cb05c83dfd56 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1634,10 +1634,7 @@ struct rtw89_pci {
 
 static inline struct rtw89_pci_rx_info *RTW89_PCI_RX_SKB_CB(struct sk_buff *skb)
 {
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-
-	BUILD_BUG_ON(sizeof(struct rtw89_pci_tx_data) >
-		     sizeof(info->status.status_driver_data));
+	BUILD_BUG_ON(sizeof(struct rtw89_pci_rx_info) > sizeof(skb->cb));
 
 	return (struct rtw89_pci_rx_info *)skb->cb;
 }
@@ -1668,6 +1665,10 @@ static inline struct rtw89_pci_tx_data *RTW89_PCI_TX_SKB_CB(struct sk_buff *skb)
 {
 	struct rtw89_tx_skb_data *data = RTW89_TX_SKB_CB(skb);
 
+	BUILD_BUG_ON(sizeof(struct rtw89_tx_skb_data) +
+		     sizeof(struct rtw89_pci_tx_data) >
+		     sizeof_field(struct ieee80211_tx_info, driver_data));
+
 	return (struct rtw89_pci_tx_data *)data->hci_priv;
 }
 
-- 
2.25.1


