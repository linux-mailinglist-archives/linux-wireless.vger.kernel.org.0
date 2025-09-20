Return-Path: <linux-wireless+bounces-27540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799CAB8C90C
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 15:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0447E6CAD
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D112FD1B2;
	Sat, 20 Sep 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="lITVJi9Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7D222590;
	Sat, 20 Sep 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758374848; cv=none; b=Czvz3AMtlw36QRxPbahvRriVgq7e9vRNroN++pdiX3JBGDCse4vxhb6x/Gn13fOOSzDauXo3yl1LYeC2zifpM0WHKu0FSZOA3CGUM6rzWFEDFUTba3ZGmJka+S9Q2Vs7S6g7/j/TBQnpR4Rk870XPZyZN8q+jDXVY02Cx+ujOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758374848; c=relaxed/simple;
	bh=PZLPORJSeDV3hWznwRkGHYPxAN97qOg4iaFMjaL+isQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD1bX3l+miX5YUR9YmQc/7XxQDIFeKsBESoMgJPbIRPEjhi8M7e1+lqj1VJ6RxUASJj3ByOak94cv3YNdOVR469eVXOi20s4j82xrMktn5aUJYh1G1prJm01YeLhSyjub+8OH5xPvbdUsArjc44NE7HrKrnuxBbABCKXU8gtlWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=lITVJi9Q; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1C9B940762F1;
	Sat, 20 Sep 2025 13:27:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1C9B940762F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758374843;
	bh=Lvht88xD9r+c3vbj0FkJFRWbvdzubUEjxVmkQ+ulT0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lITVJi9QtJjbYIKx+YMLPe+mHPvl3BOEicRHmcdfL25nWOgABwrvFjzTjyCButl4C
	 n/ptpqQP6gazieLndviBoEOVg0cpUNYOpDHfipqOjPwAyBfigpU8xzcim0L5wuTCRq
	 3Rx8qLQcvJ4tAPQQXKDhQQfzU7XY94f6jq/FT9U8=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next 4/6] wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Date: Sat, 20 Sep 2025 16:26:09 +0300
Message-ID: <20250920132614.277719-5-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920132614.277719-1-pchelkin@ispras.ru>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
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

Thus define a .tx_rpt_enable handler which will initialize the
corresponding values used later when writing to TX descriptor.  The
handler is a no-op for PCIe, TX status reporting behaviour doesn't change
there.

Do skb handling / queueing part quite similar to what rtw88 has.  Store
the flagged skbs in a queue for further processing in a C2H handler.
Flush the queue on HCI reset (done at core deinitialization phase, too).

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/core.c |  5 ++++
 drivers/net/wireless/realtek/rtw89/core.h | 18 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 29 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c  |  1 +
 drivers/net/wireless/realtek/rtw89/pci.h  |  4 ----
 drivers/net/wireless/realtek/rtw89/usb.c  | 18 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.h  | 15 ++++++++++++
 7 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d2a559ddfa2e..3e7bd0cedbdf 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1229,6 +1229,7 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 	struct ieee80211_sta *sta = rtwsta_link_to_sta_safe(rtwsta_link);
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct rtw89_core_tx_request tx_req = {};
 	int ret;
@@ -1240,6 +1241,9 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 	tx_req.rtwsta_link = rtwsta_link;
 	tx_req.desc_info.sw_mld = sw_mld;
 
+	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)
+		rtw89_hci_tx_rpt_enable(rtwdev, &tx_req);
+
 	rtw89_traffic_stats_accu(rtwdev, rtwvif, skb, true, true);
 	rtw89_wow_parse_akm(rtwdev, skb);
 	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
@@ -5839,6 +5843,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6ghz_probe_work);
 	INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
 
+	skb_queue_head_init(&rtwdev->tx_rpt_queue);
 	skb_queue_head_init(&rtwdev->c2h_queue);
 	rtw89_core_ppdu_sts_init(rtwdev);
 	rtw89_traffic_stats_init(rtwdev, &rtwdev->stats);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2362724323a9..4e597a5df005 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3509,6 +3509,11 @@ struct rtw89_phy_rate_pattern {
 	bool enable;
 };
 
+#define RTW89_TX_DONE			0x0
+#define RTW89_TX_RETRY_LIMIT		0x1
+#define RTW89_TX_LIFE_TIME		0x2
+#define RTW89_TX_MACID_DROP		0x3
+
 #define RTW89_TX_WAIT_WORK_TIMEOUT msecs_to_jiffies(500)
 struct rtw89_tx_wait_info {
 	struct rcu_head rcu_head;
@@ -3646,6 +3651,8 @@ struct rtw89_hci_ops {
 	void (*pause)(struct rtw89_dev *rtwdev, bool pause);
 	void (*switch_mode)(struct rtw89_dev *rtwdev, bool low_power);
 	void (*recalc_int_mit)(struct rtw89_dev *rtwdev);
+	void (*tx_rpt_enable)(struct rtw89_dev *rtwdev,
+			      struct rtw89_core_tx_request *tx_req);
 
 	u8 (*read8)(struct rtw89_dev *rtwdev, u32 addr);
 	u16 (*read16)(struct rtw89_dev *rtwdev, u32 addr);
@@ -6008,6 +6015,9 @@ struct rtw89_dev {
 	struct list_head tx_waits;
 	struct wiphy_delayed_work tx_wait_work;
 
+	atomic_t sn;
+	struct sk_buff_head tx_rpt_queue;
+
 	struct rtw89_cam_info cam_info;
 
 	struct sk_buff_head c2h_queue;
@@ -6294,6 +6304,7 @@ static inline void rtw89_hci_reset(struct rtw89_dev *rtwdev)
 {
 	rtwdev->hci.ops->reset(rtwdev);
 	rtw89_tx_wait_list_clear(rtwdev);
+	skb_queue_purge(&rtwdev->tx_rpt_queue);
 }
 
 static inline int rtw89_hci_start(struct rtw89_dev *rtwdev)
@@ -6336,6 +6347,13 @@ static inline void rtw89_hci_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 	return rtwdev->hci.ops->tx_kick_off(rtwdev, txch);
 }
 
+static inline void rtw89_hci_tx_rpt_enable(struct rtw89_dev *rtwdev,
+					   struct rtw89_core_tx_request *tx_req)
+{
+	if (rtwdev->hci.ops->tx_rpt_enable)
+		rtwdev->hci.ops->tx_rpt_enable(rtwdev, tx_req);
+}
+
 static inline int rtw89_hci_mac_pre_deinit(struct rtw89_dev *rtwdev)
 {
 	return rtwdev->hci.ops->mac_pre_deinit(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 01afdcd5f36c..831e53aedccc 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5457,15 +5457,44 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
 	rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
 }
 
+static void
+rtw89_tx_rpt_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *skb, bool acked)
+{
+	struct ieee80211_tx_info *info;
+
+	info = IEEE80211_SKB_CB(skb);
+	ieee80211_tx_info_clear_status(info);
+	if (acked)
+		info->flags |= IEEE80211_TX_STAT_ACK;
+	else
+		info->flags &= ~IEEE80211_TX_STAT_ACK;
+
+	ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
+}
+
 static void
 rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
 	u8 sw_define = RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h->data);
 	u8 tx_status = RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h->data);
+	struct sk_buff *cur, *tmp;
+	unsigned long flags;
+	u8 *n;
 
 	rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 		    "C2H TX RPT: sn %d, tx_status %d\n",
 		    sw_define, tx_status);
+
+	spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
+	skb_queue_walk_safe(&rtwdev->tx_rpt_queue, cur, tmp) {
+		n = (u8 *)RTW89_TX_SKB_CB(cur)->hci_priv;
+		if (*n == sw_define) {
+			__skb_unlink(cur, &rtwdev->tx_rpt_queue);
+			rtw89_tx_rpt_tx_status(rtwdev, cur, tx_status == RTW89_TX_DONE);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 0ee5f8579447..fdf142d77ecc 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4675,6 +4675,7 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 	.pause		= rtw89_pci_ops_pause,
 	.switch_mode	= rtw89_pci_ops_switch_mode,
 	.recalc_int_mit = rtw89_pci_recalc_int_mit,
+	.tx_rpt_enable  = NULL, /* always enabled */
 
 	.read8		= rtw89_pci_ops_read8,
 	.read16		= rtw89_pci_ops_read16,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index cb05c83dfd56..16dfb0e79d77 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1487,10 +1487,6 @@ struct rtw89_pci_tx_addr_info_32_v1 {
 #define RTW89_PCI_RPP_POLLUTED		BIT(31)
 #define RTW89_PCI_RPP_SEQ		GENMASK(30, 16)
 #define RTW89_PCI_RPP_TX_STATUS		GENMASK(15, 13)
-#define RTW89_TX_DONE			0x0
-#define RTW89_TX_RETRY_LIMIT		0x1
-#define RTW89_TX_LIFE_TIME		0x2
-#define RTW89_TX_MACID_DROP		0x3
 #define RTW89_PCI_RPP_QSEL		GENMASK(12, 8)
 #define RTW89_PCI_RPP_MACID		GENMASK(7, 0)
 
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index bc0d5e48d39b..98eff955fc96 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -188,6 +188,13 @@ static u8 rtw89_usb_get_bulkout_id(u8 ch_dma)
 	}
 }
 
+static void rtw89_usb_ops_tx_rpt_enable(struct rtw89_dev *rtwdev,
+					struct rtw89_core_tx_request *tx_req)
+{
+	tx_req->desc_info.report = true;
+	tx_req->desc_info.sn = atomic_inc_return(&rtwdev->sn) & 0xF;
+}
+
 static void rtw89_usb_write_port_complete(struct urb *urb)
 {
 	struct rtw89_usb_tx_ctrl_block *txcb = urb->context;
@@ -216,6 +223,12 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 		skb_pull(skb, txdesc_size);
 
 		info = IEEE80211_SKB_CB(skb);
+		if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
+			/* sn is passed to rtw89_mac_c2h_tx_rpt() via driver data */
+			skb_queue_tail(&rtwdev->tx_rpt_queue, skb);
+			continue;
+		}
+
 		ieee80211_tx_info_clear_status(info);
 
 		if (urb->status == 0) {
@@ -364,6 +377,7 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
 	struct sk_buff *skb = tx_req->skb;
+	struct rtw89_usb_tx_data *tx_data;
 	struct rtw89_txwd_body *txdesc;
 	u32 txdesc_size;
 
@@ -387,6 +401,9 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
 	memset(txdesc, 0, txdesc_size);
 	rtw89_chip_fill_txdesc(rtwdev, desc_info, txdesc);
 
+	tx_data = RTW89_USB_TX_SKB_CB(skb);
+	tx_data->sn = tx_req->desc_info.sn;
+
 	le32p_replace_bits(&txdesc->dword0, 1, RTW89_TXWD_BODY0_STF_MODE);
 
 	skb_queue_tail(&rtwusb->tx_queue[desc_info->ch_dma], skb);
@@ -811,6 +828,7 @@ static const struct rtw89_hci_ops rtw89_usb_ops = {
 	.pause		= rtw89_usb_ops_pause,
 	.switch_mode	= rtw89_usb_ops_switch_mode,
 	.recalc_int_mit = rtw89_usb_ops_recalc_int_mit,
+	.tx_rpt_enable  = rtw89_usb_ops_tx_rpt_enable,
 
 	.read8		= rtw89_usb_ops_read8,
 	.read16		= rtw89_usb_ops_read16,
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index c1b4bfa20979..c8b2ad2eaa22 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -53,11 +53,26 @@ struct rtw89_usb {
 	struct sk_buff_head tx_queue[RTW89_TXCH_NUM];
 };
 
+struct rtw89_usb_tx_data {
+	u8 sn;
+};
+
 static inline struct rtw89_usb *rtw89_usb_priv(struct rtw89_dev *rtwdev)
 {
 	return (struct rtw89_usb *)rtwdev->priv;
 }
 
+static inline struct rtw89_usb_tx_data *RTW89_USB_TX_SKB_CB(struct sk_buff *skb)
+{
+	struct rtw89_tx_skb_data *data = RTW89_TX_SKB_CB(skb);
+
+	BUILD_BUG_ON(sizeof(struct rtw89_tx_skb_data) +
+		     sizeof(struct rtw89_usb_tx_data) >
+		     sizeof_field(struct ieee80211_tx_info, driver_data));
+
+	return (struct rtw89_usb_tx_data *)data->hci_priv;
+}
+
 int rtw89_usb_probe(struct usb_interface *intf,
 		    const struct usb_device_id *id);
 void rtw89_usb_disconnect(struct usb_interface *intf);
-- 
2.51.0


