Return-Path: <linux-wireless+bounces-28029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D421BE7F35
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 12:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134FE620EF7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7DF314B7C;
	Fri, 17 Oct 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="nJWOYSoq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44A3128D6;
	Fri, 17 Oct 2025 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695640; cv=none; b=JK2HUx38lBCvRKlVKQqZ62jROuwRIVoQnfR+S5hYVKZq9pAHGWS/VNZ5gCimr/lKamJAxDK4620Dqan7dj/kjU3mcVfG0QjJDsADNwId65/VOCcnHrEZjRAS7pHCLm667XhaNMIWNPIs6pgIfGQrzBgBMILw/D5HJfRQVMg3Yv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695640; c=relaxed/simple;
	bh=BDdDMNAz3HiIhxTWIV834HC/Ap2rBDeTXrOTNt3F5qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFENLyf5Sjav2iXj1twetzFn5DNnEdnxvzd8k59lmh1kgICtcyI32Ch8nNl0mhB4IPuP8wnsTHPbArQ69P+nuhGw1sfjWNXX2rBoH9D23Pn7OTAzp7odD1+EkmZbDSNXEuPUKmHbQqXw1aGXQonOZzQPcrOi9Hc6WEZy/W0ccOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=nJWOYSoq; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5878B40769D6;
	Fri, 17 Oct 2025 10:07:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5878B40769D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760695635;
	bh=MY9pM3gsKgI+UwDVoEgQuGT9WYi88rJ5/wNdFB+PDe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJWOYSoqpO1l/aJoXoYJG8D9xyMo2FtFcGJ7tAyXcnrn2O+0QhE946fGdbPB5KTx3
	 4uRy1mMdALM6nUu70Oni6QtL1jEt//cYM6NPeYYFRbOGT+y1WFUcrLM0oyBAn7hfc9
	 wrkzxQ5MgIaF2tlml+qAp+2eXLZS3ESr7fScKkQQ=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v3 9/9] wifi: rtw89: process TX wait skbs for USB via C2H handler
Date: Fri, 17 Oct 2025 13:03:11 +0300
Message-ID: <20251017100658.66581-10-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017100658.66581-1-pchelkin@ispras.ru>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TX wait skbs need to be completed when they are done.  PCIe part does this
inside rtw89_pci_tx_status() during RPP processing.  Other HCIs use a
mechanism based on C2H firmware messages.

Store TX wait skbs inside TX report queue so that it'll be possible to
identify completed items inside the C2H handler via private driver data of
skb.  Try to do this as similar to PCIe path as possible.  When the
corresponding TX wait skb is found inside TX report queue, unlink it from
there and call rtw89_core_tx_wait_complete() to mark the completion.

If the callee waiting for the completion has already timed out, the TX
wait skb is placed into TX wait list (like PCIe part does).

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v3: - use rcu_access_pointer() inside rtw89_core_is_tx_wait()  (Zong-Zhe)
    - finally I've hopefully realized what you meant by doing TX wait
      skb handling here similar to PCIe.  IMO this looks just elegant now
      compared to my previous submissions. Thanks, Ping-Ke!

v2: store TX wait skbs in tx_rpt_queue (Ping-Ke)

 drivers/net/wireless/realtek/rtw89/core.c |  5 ++---
 drivers/net/wireless/realtek/rtw89/core.h |  6 ++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 10 ++++++++--
 drivers/net/wireless/realtek/rtw89/usb.c  |  2 +-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 3aa9a9a28118..e28020429692 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1112,7 +1112,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	if (addr_cam->valid && desc_info->mlo)
 		upd_wlan_hdr = true;
 
-	if (rtw89_is_tx_rpt_skb(tx_req->skb))
+	if (rtw89_is_tx_rpt_skb(rtwdev, tx_req->skb))
 		rtw89_tx_rpt_init(rtwdev, tx_req);
 
 	is_bmc = (is_broadcast_ether_addr(hdr->addr1) ||
@@ -1244,14 +1244,13 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 	tx_req.rtwvif_link = rtwvif_link;
 	tx_req.rtwsta_link = rtwsta_link;
 	tx_req.desc_info.sw_mld = sw_mld;
+	rcu_assign_pointer(skb_data->wait, wait);
 
 	rtw89_traffic_stats_accu(rtwdev, rtwvif, skb, true, true);
 	rtw89_wow_parse_akm(rtwdev, skb);
 	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
 	rtw89_core_tx_wake(rtwdev, &tx_req);
 
-	rcu_assign_pointer(skb_data->wait, wait);
-
 	ret = rtw89_hci_tx_write(rtwdev, &tx_req);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to transmit skb to HCI\n");
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8641e3a8d36d..85d25eb316a3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7391,6 +7391,12 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
 	return dev_alloc_skb(length);
 }
 
+static inline bool rtw89_core_is_tx_wait(struct rtw89_dev *rtwdev,
+					 struct rtw89_tx_skb_data *skb_data)
+{
+	return rcu_access_pointer(skb_data->wait);
+}
+
 static inline bool rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
 					       struct rtw89_tx_skb_data *skb_data,
 					       u8 tx_status)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index e8bd92223497..fe3573455247 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1634,18 +1634,24 @@ void rtw89_tx_rpt_init(struct rtw89_dev *rtwdev,
 }
 
 static inline
-bool rtw89_is_tx_rpt_skb(struct sk_buff *skb)
+bool rtw89_is_tx_rpt_skb(struct rtw89_dev *rtwdev, struct sk_buff *skb)
 {
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 
-	return info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS;
+	return rtw89_core_is_tx_wait(rtwdev, skb_data) ||
+	       (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS);
 }
 
 static inline
 void rtw89_tx_rpt_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *skb, u8 tx_status)
 {
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 
+	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status))
+		return;
+
 	ieee80211_tx_info_clear_status(info);
 	if (tx_status == RTW89_TX_DONE)
 		info->flags |= IEEE80211_TX_STAT_ACK;
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 22994c3501f8..e4077dec28c9 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -216,7 +216,7 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 		skb_pull(skb, txdesc_size);
 
 		info = IEEE80211_SKB_CB(skb);
-		if (rtw89_is_tx_rpt_skb(skb)) {
+		if (rtw89_is_tx_rpt_skb(rtwdev, skb)) {
 			/* sequence number is passed to rtw89_mac_c2h_tx_rpt() via
 			 * driver data
 			 */
-- 
2.51.0


