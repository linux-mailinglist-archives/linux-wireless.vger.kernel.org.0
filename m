Return-Path: <linux-wireless+bounces-28031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2511BE7F41
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 12:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4B884F80DA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A603161B2;
	Fri, 17 Oct 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="a+CLToYq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B7313265;
	Fri, 17 Oct 2025 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695640; cv=none; b=jHTBLLc59BcFi7c1J+KtLCwgT0a9nbEDdf/NIhuTUK34wHDdFWpGWOVaFg7Z5qNLLeXp/IdFeLHJDsJLJz0gR88n/0gS4zYQysvng3Fi9fcNTt56DQm2gdQd3nkFp7ODFIDpLtaHRXsOG7UFMuViWVLTPLn8MNH4PmpMfQR/zi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695640; c=relaxed/simple;
	bh=PgVMy/UeDvJu2+D6YvQBT8S2hBR0ylPnYD28L9bG780=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gm3YxJFuIvzvbnMurWQSl8ceXxs+C0Nvg9No7zqbwhDjWozfvZUqla3oGdr6oEgS2HqRguutHnTkZgtpMm8RdQCjsghULPv8iRFbnZsJIWa6KkKUEjgMPjYsgLcfAt/8Ka5dFrEMw9VJXj4ljT/5b1Xu3I3k7EP+tT2zHPGIBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=a+CLToYq; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 0A1E5407674C;
	Fri, 17 Oct 2025 10:07:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0A1E5407674C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760695634;
	bh=O2JANdGUF7IMDMe895Esv4rO4AcOdt8jE8736czwTfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+CLToYqwI9MLxJaMHqW1B8Cwhk+w7OA/ab1XkX2oVQS0Wa8SITUI/geIwaUwFu/P
	 oNBqQqWXgJx7J+JuYssT95SdOiwzRHpUlY7/KVVR1guyCAtydLZO3LVbqmxNBuK1M+
	 WyVb28U1X1hggX2NvCDIIY90ayyYBDvGHegP3OJc=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v3 7/9] wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Date: Fri, 17 Oct 2025 13:03:09 +0300
Message-ID: <20251017100658.66581-8-pchelkin@ispras.ru>
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

Frames flagged with IEEE80211_TX_CTL_REQ_TX_STATUS mean the driver has to
report to mac80211 stack whether AP sent ACK for the null frame/probe
request or not.  It's not implemented in USB part of the driver yet.

PCIe HCI has its own way of getting TX status incorporated into RPP
feature, and it's always enabled there.  Other HCIs need a different
scheme based on processing C2H messages.

Thus define a .tx_rpt_enabled flag defining which HCIs need to enable a TX
report feature.  Currently it is USB only.

Toggle a bit in the TX descriptor and place flagged skbs in a queue to
wait for a message from the firmware.  The main part is quite similar to
what rtw88 does.  The difference is that rtw89 has a new feature providing
a TX report for each transmission attempt.  Ignore a failed TX status
reported by the firmware until retry limit is reached or successful status
appears.  When there is no success and the retry limit is reached, report
the frame up to the wireless stack as failed eventually.

Forcefully flush the queue on HCI reset.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v3: - don't mix TX RPT queue with TX wait list processing (Ping-Ke)
    - add struct rtw89_tx_rpt for convenience, that's also like in rtw88
    - update changelog to reflect TX RPT retry logic and add some
      comments inside rtw89_mac_c2h_tx_rpt()

v2: - update TX rpt description in rtw89_core_tx_update_desc_info()
    - add a flag in rtw89_hci_info to determine if we should enable TX report (Ping-Ke)
    - refine rtw89_tx_rpt_queue_purge() - it's called on USB HCI reset
      and at rtw89_tx_wait_work.  Queueing delayed rtw89_tx_wait_work may be
      suboptimal but basically it's what rtw88 does with timer stuff.

 drivers/net/wireless/realtek/rtw89/core.c |  4 ++
 drivers/net/wireless/realtek/rtw89/core.h | 10 ++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 24 ++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 56 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.c  | 15 +++++-
 5 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index abe8eec1d0f5..3aa9a9a28118 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1112,6 +1112,9 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	if (addr_cam->valid && desc_info->mlo)
 		upd_wlan_hdr = true;
 
+	if (rtw89_is_tx_rpt_skb(tx_req->skb))
+		rtw89_tx_rpt_init(rtwdev, tx_req);
+
 	is_bmc = (is_broadcast_ether_addr(hdr->addr1) ||
 		  is_multicast_ether_addr(hdr->addr1));
 
@@ -5849,6 +5852,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6ghz_probe_work);
 	INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
 
+	skb_queue_head_init(&rtwdev->tx_rpt.queue);
 	skb_queue_head_init(&rtwdev->c2h_queue);
 	rtw89_core_ppdu_sts_init(rtwdev);
 	rtw89_traffic_stats_init(rtwdev, &rtwdev->stats);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 66b7bfa5902e..8641e3a8d36d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3516,6 +3516,11 @@ struct rtw89_phy_rate_pattern {
 #define RTW89_TX_LIFE_TIME		0x2
 #define RTW89_TX_MACID_DROP		0x3
 
+struct rtw89_tx_rpt {
+	struct sk_buff_head queue;
+	atomic_t sn;
+};
+
 #define RTW89_TX_WAIT_WORK_TIMEOUT msecs_to_jiffies(500)
 struct rtw89_tx_wait_info {
 	struct rcu_head rcu_head;
@@ -3527,6 +3532,8 @@ struct rtw89_tx_wait_info {
 
 struct rtw89_tx_skb_data {
 	struct rtw89_tx_wait_info __rcu *wait;
+	u8 tx_rpt_sn;
+	u8 tx_pkt_cnt_lmt;
 	u8 hci_priv[];
 };
 
@@ -3696,6 +3703,7 @@ struct rtw89_hci_info {
 	u32 rpwm_addr;
 	u32 cpwm_addr;
 	bool paused;
+	bool tx_rpt_enabled;
 };
 
 struct rtw89_chip_ops {
@@ -6015,6 +6023,8 @@ struct rtw89_dev {
 	struct list_head tx_waits;
 	struct wiphy_delayed_work tx_wait_work;
 
+	struct rtw89_tx_rpt tx_rpt;
+
 	struct rtw89_cam_info cam_info;
 
 	struct sk_buff_head c2h_queue;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 2fe239f18534..26c7476afdec 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5460,7 +5460,11 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
 static void
 rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
+	struct rtw89_tx_rpt *tx_rpt = &rtwdev->tx_rpt;
 	u8 sw_define, tx_status, data_txcnt;
+	struct rtw89_tx_skb_data *skb_data;
+	struct sk_buff *skb, *tmp;
+	unsigned long flags;
 
 	if (rtwdev->chip->chip_id == RTL8922A) {
 		const struct rtw89_c2h_mac_tx_rpt_v2 *rpt_v2;
@@ -5484,6 +5488,26 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 	rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 		    "C2H TX RPT: sn %d, tx_status %d, data_txcnt %d\n",
 		    sw_define, tx_status, data_txcnt);
+
+	spin_lock_irqsave(&tx_rpt->queue.lock, flags);
+	skb_queue_walk_safe(&tx_rpt->queue, skb, tmp) {
+		skb_data = RTW89_TX_SKB_CB(skb);
+
+		/* skip if sequence number doesn't match */
+		if (sw_define != skb_data->tx_rpt_sn)
+			continue;
+		/* skip if TX attempt has failed and retry limit has not been
+		 * reached yet
+		 */
+		if (tx_status != RTW89_TX_DONE &&
+		    data_txcnt != skb_data->tx_pkt_cnt_lmt)
+			continue;
+
+		__skb_unlink(skb, &tx_rpt->queue);
+		rtw89_tx_rpt_tx_status(rtwdev, skb, tx_status);
+		break;
+	}
+	spin_unlock_irqrestore(&tx_rpt->queue.lock, flags);
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 15c5c7e4033c..e8bd92223497 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1616,4 +1616,60 @@ int rtw89_mac_scan_offload(struct rtw89_dev *rtwdev,
 
 	return ret;
 }
+
+static inline
+void rtw89_tx_rpt_init(struct rtw89_dev *rtwdev,
+		       struct rtw89_core_tx_request *tx_req)
+{
+	struct rtw89_tx_rpt *tx_rpt = &rtwdev->tx_rpt;
+
+	if (!rtwdev->hci.tx_rpt_enabled)
+		return;
+
+	tx_req->desc_info.report = true;
+	/* firmware maintains a 4-bit sequence number */
+	tx_req->desc_info.sn = atomic_inc_return(&tx_rpt->sn) & 0xF;
+	tx_req->desc_info.tx_cnt_lmt_en = true;
+	tx_req->desc_info.tx_cnt_lmt = 8;
+}
+
+static inline
+bool rtw89_is_tx_rpt_skb(struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+	return info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS;
+}
+
+static inline
+void rtw89_tx_rpt_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *skb, u8 tx_status)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+	ieee80211_tx_info_clear_status(info);
+	if (tx_status == RTW89_TX_DONE)
+		info->flags |= IEEE80211_TX_STAT_ACK;
+	else
+		info->flags &= ~IEEE80211_TX_STAT_ACK;
+
+	ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
+}
+
+static inline
+void rtw89_tx_rpt_queue_purge(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_tx_rpt *tx_rpt = &rtwdev->tx_rpt;
+	struct sk_buff_head q;
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	__skb_queue_head_init(&q);
+
+	spin_lock_irqsave(&tx_rpt->queue.lock, flags);
+	skb_queue_splice_init(&tx_rpt->queue, &q);
+	spin_unlock_irqrestore(&tx_rpt->queue.lock, flags);
+
+	while ((skb = __skb_dequeue(&q)))
+		rtw89_tx_rpt_tx_status(rtwdev, skb, RTW89_TX_MACID_DROP);
+}
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 655e8437d62e..22994c3501f8 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -216,6 +216,14 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 		skb_pull(skb, txdesc_size);
 
 		info = IEEE80211_SKB_CB(skb);
+		if (rtw89_is_tx_rpt_skb(skb)) {
+			/* sequence number is passed to rtw89_mac_c2h_tx_rpt() via
+			 * driver data
+			 */
+			skb_queue_tail(&rtwdev->tx_rpt.queue, skb);
+			continue;
+		}
+
 		ieee80211_tx_info_clear_status(info);
 
 		if (urb->status == 0) {
@@ -372,6 +380,7 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	struct rtw89_tx_skb_data *skb_data;
 	struct sk_buff *skb = tx_req->skb;
 	struct rtw89_txwd_body *txdesc;
 	u32 txdesc_size;
@@ -398,6 +407,9 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
 
 	le32p_replace_bits(&txdesc->dword0, 1, RTW89_TXWD_BODY0_STF_MODE);
 
+	skb_data = RTW89_TX_SKB_CB(skb);
+	skb_data->tx_rpt_sn = tx_req->desc_info.sn;
+
 	skb_queue_tail(&rtwusb->tx_queue[desc_info->ch_dma], skb);
 
 	return 0;
@@ -678,7 +690,7 @@ static void rtw89_usb_deinit_tx(struct rtw89_dev *rtwdev)
 
 static void rtw89_usb_ops_reset(struct rtw89_dev *rtwdev)
 {
-	/* TODO: anything to do here? */
+	rtw89_tx_rpt_queue_purge(rtwdev);
 }
 
 static int rtw89_usb_ops_start(struct rtw89_dev *rtwdev)
@@ -962,6 +974,7 @@ int rtw89_usb_probe(struct usb_interface *intf,
 
 	rtwdev->hci.ops = &rtw89_usb_ops;
 	rtwdev->hci.type = RTW89_HCI_TYPE_USB;
+	rtwdev->hci.tx_rpt_enabled = true;
 
 	ret = rtw89_usb_intf_init(rtwdev, intf);
 	if (ret) {
-- 
2.51.0


