Return-Path: <linux-wireless+bounces-27792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B588BBB519D
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 22:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B3624E36BD
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888532C11C6;
	Thu,  2 Oct 2025 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="AgPgHb0U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE312BEFE0;
	Thu,  2 Oct 2025 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435771; cv=none; b=A0g8wVCjOEPQrUKulCoqxVdbrKO32ldyOrPd4/8hIpEFpKURg2XCa7XVYV1TqAzUQcljFf/TiOCTD5TZf6AiQwqcF0sAtXRDbU+Awgv6i+XhWjHx6cbUmEgGZ/e/17FSRWC27/UjsQAhwhJcIR/uosKxWaipoSaQ71vbC3Zn3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435771; c=relaxed/simple;
	bh=zzy3YGA6JSETk46ayqJijO6l1OBTt5J05a9v8SGYuUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KopW7MleOuLHWLzW5MMo3R7AhidM6VRCWdhl9L0dZmSsCNib5fud+xgfnP+hDOml8j9E/HQm6k3gPIuYnspD+oNc0YSxzZYMk8EmD4UFv/9/ZZaJyJWgbIbHJip0NHX6+1/MyaIZLqLx0ZZ0YPvHB8/duLJ3dAoYx2+Lx8yiPns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=AgPgHb0U; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2F16140762F3;
	Thu,  2 Oct 2025 20:09:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2F16140762F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1759435761;
	bh=AF+SxHLJuBbFvJ9oJ18FGvvRlh7+5OYP8692tG6RXCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AgPgHb0UnPFowAtZ86DJF99p0REeGTNhm7xwhKH0c1QFCT5wx8TJ7MAU+c1YV5G5x
	 J7C4auUeNs26At3utdDDU4vXKm8bR2piFORf6c8n5S01p47muTZYTHhwuPTpvVEGKl
	 ++GqUiKPfyaQeXdlQikQnPmjL8xBb+fiwGAf5cbc=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v2 7/7] wifi: rtw89: process TX wait skbs for USB via C2H handler
Date: Thu,  2 Oct 2025 23:08:52 +0300
Message-ID: <20251002200857.657747-8-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002200857.657747-1-pchelkin@ispras.ru>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
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
identify completed items inside C2H handler via private driver data of
skb.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v2: store TX wait skbs in tx_rpt_queue (Ping-Ke)

 drivers/net/wireless/realtek/rtw89/core.c |  6 ++++--
 drivers/net/wireless/realtek/rtw89/core.h | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c  |  3 ++-
 drivers/net/wireless/realtek/rtw89/mac.h  | 15 +++++++++++++--
 drivers/net/wireless/realtek/rtw89/usb.c  |  3 ++-
 5 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 214924f8bee0..1457a5fe7320 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1108,7 +1108,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 		if (addr_cam->valid && desc_info->mlo)
 			upd_wlan_hdr = true;
 
-		if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)
+		if (tx_req->wait || (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS))
 			rtw89_tx_rpt_enable(rtwdev, tx_req);
 	}
 	is_bmc = (is_broadcast_ether_addr(hdr->addr1) ||
@@ -1173,7 +1173,8 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 
 	if (time_left == 0) {
 		ret = -ETIMEDOUT;
-		list_add_tail(&wait->list, &rtwdev->tx_waits);
+		if (!rtwdev->hci.tx_rpt_enable)
+			list_add_tail(&wait->list, &rtwdev->tx_waits);
 		wiphy_delayed_work_queue(rtwdev->hw->wiphy, &rtwdev->tx_wait_work,
 					 RTW89_TX_WAIT_WORK_TIMEOUT);
 	} else {
@@ -1242,6 +1243,7 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 	tx_req.skb = skb;
 	tx_req.vif = vif;
 	tx_req.sta = sta;
+	tx_req.wait = wait;
 	tx_req.rtwvif_link = rtwvif_link;
 	tx_req.rtwsta_link = rtwsta_link;
 	tx_req.desc_info.sw_mld = sw_mld;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3940e54353d3..c13465e2730a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1201,6 +1201,7 @@ struct rtw89_core_tx_request {
 	struct sk_buff *skb;
 	struct ieee80211_vif *vif;
 	struct ieee80211_sta *sta;
+	struct rtw89_tx_wait_info *wait;
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_sta_link *rtwsta_link;
 	struct rtw89_tx_desc_info desc_info;
@@ -7387,6 +7388,20 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
 	return dev_alloc_skb(length);
 }
 
+static inline bool rtw89_core_is_tx_wait(struct rtw89_dev *rtwdev,
+					 struct rtw89_tx_skb_data *skb_data)
+{
+	struct rtw89_tx_wait_info *wait;
+
+	guard(rcu)();
+
+	wait = rcu_dereference(skb_data->wait);
+	if (!wait)
+		return false;
+
+	return true;
+}
+
 static inline bool rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
 					       struct rtw89_tx_skb_data *skb_data,
 					       u8 tx_status)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 75d9efac452b..3406c8b01eb8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5484,7 +5484,8 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 			continue;
 
 		__skb_unlink(cur, &rtwdev->tx_rpt_queue);
-		rtw89_tx_rpt_tx_status(rtwdev, cur, tx_status);
+		if (!rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status))
+			rtw89_tx_rpt_tx_status(rtwdev, cur, tx_status);
 		break;
 	}
 	spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 1f7d3734d15f..2d647d3b0852 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1647,16 +1647,27 @@ void rtw89_tx_rpt_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *skb, u8 tx
 static inline
 void rtw89_tx_rpt_queue_purge(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_tx_skb_data *skb_data;
+	struct rtw89_tx_wait_info *wait;
 	struct sk_buff_head q;
 	struct sk_buff *skb;
 	unsigned long flags;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	__skb_queue_head_init(&q);
 	spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
 	skb_queue_splice_init(&rtwdev->tx_rpt_queue, &q);
 	spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);
 
-	while ((skb = __skb_dequeue(&q)))
-		rtw89_tx_rpt_tx_status(rtwdev, skb, RTW89_TX_MACID_DROP);
+	while ((skb = __skb_dequeue(&q))) {
+		skb_data = RTW89_TX_SKB_CB(skb);
+		wait = wiphy_dereference(rtwdev->hw->wiphy, skb_data->wait);
+
+		if (wait)
+			rtw89_tx_wait_release(wait);
+		else
+			rtw89_tx_rpt_tx_status(rtwdev, skb, RTW89_TX_MACID_DROP);
+	}
 }
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index f53ab676e9a8..adbadb2783f0 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -216,7 +216,8 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 		skb_pull(skb, txdesc_size);
 
 		info = IEEE80211_SKB_CB(skb);
-		if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
+		if (rtw89_core_is_tx_wait(rtwdev, RTW89_TX_SKB_CB(skb)) ||
+		    (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)) {
 			/* sn is passed to rtw89_mac_c2h_tx_rpt() via driver data */
 			skb_queue_tail(&rtwdev->tx_rpt_queue, skb);
 			wiphy_delayed_work_queue(rtwdev->hw->wiphy,
-- 
2.51.0


