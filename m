Return-Path: <linux-wireless+bounces-27790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F264CBB5197
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 22:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB0924E3B93
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 20:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F3B2C0F93;
	Thu,  2 Oct 2025 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="dQohuQcG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BDD2BE02D;
	Thu,  2 Oct 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435771; cv=none; b=YgPgVyZFwAE4u7BbH0bk2F7HWGBCpY+3dm26HLUz4GibfhwNyzXEKB7v5DObQOKNyGsOD6zZ6Y70g4Jil8hnUV7xw/QjGZz+1H5OfLeKDpTIFeHdq07lIfzSiONqDWWusTd+OPFsRKdXqyNPEB7uQT5NkldewR1UB4OlmFMc0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435771; c=relaxed/simple;
	bh=/6EvuVBC32gYqPg9Feq4/HEWPdxL+O8EPZTxjNiycF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSpqTCQVMT9Go5pJM2VCZNIiL1jbKcp/hTo/ONwqMbe1LknRcKbP6q+AolUQM0CM+fZ1DBaLkUGVQAJt4l7qqWqx5rd32zjHs5RUAYNx2ah9iiyUmjRVfUSqpLOd2bjwSXC3LW+VhUxYAwbfNkVXp/RDO+ITQxgHGduSZrULzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=dQohuQcG; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 69D8940762F2;
	Thu,  2 Oct 2025 20:09:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 69D8940762F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1759435760;
	bh=DUzOs/1Nwx04a1DZYBff2c7o9JavR8B6mWeAO5NM2b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQohuQcGHA+dhpxrT52Z+TwUrDCmklFTrOX86RiZ1ryX+bLJK03dzsgqsY1jF+970
	 0txUzRGxNZ/yezTQdnJzQWH39pj5pJYnX9OG1evnfJkYU/8cHJcU+ROgvKZo4tLaRs
	 LSJ5Jq+7Zbr4QyFQov4+Qi2j4haPvbI+ZtD1E5Ls=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v2 6/7] wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Date: Thu,  2 Oct 2025 23:08:51 +0300
Message-ID: <20251002200857.657747-7-pchelkin@ispras.ru>
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

Frames flagged with IEEE80211_TX_CTL_REQ_TX_STATUS mean the driver has to
report to mac80211 stack whether AP sent ACK for the null frame/probe
request or not.  It's not implemented in USB part of the driver yet.

PCIe HCI has its own way of getting TX status incorporated into RPP
feature, and it's always enabled there.  Other HCIs need a different
scheme based on processing C2H messages.

Thus define a .tx_rpt_enable flag defining which HCIs would need a TX
report feature.  Currently it is USB only.

Do skb handling / queueing part quite similar to what rtw88 has.  Store
the flagged skbs in a queue for further processing in a C2H handler.
Flush the queue on HCI reset and on timeout via delayed work handler used
for TX waits - it's convenient since the further changes will pass TX wait
skbs management to the same TX report queue.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v2: - update TX rpt description in rtw89_core_tx_update_desc_info()
    - add a flag in rtw89_hci_info to determine if we should enable TX report (Ping-Ke)
    - refine rtw89_tx_rpt_queue_purge() - it's called on USB HCI reset
      and at rtw89_tx_wait_work.  Queueing delayed rtw89_tx_wait_work may be
      suboptimal but basically it's what rtw88 does with timer stuff.
      We can drop it and rely only on HCI reset to free remaining buffers
      in case firmware didn't send any TX status report.  I'd like to know
      your thoughts on this.

 drivers/net/wireless/realtek/rtw89/core.c |  9 ++++-
 drivers/net/wireless/realtek/rtw89/core.h |  6 ++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 19 ++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 43 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.c  | 14 +++++++-
 5 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 49ecc248464b..214924f8bee0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1107,6 +1107,9 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 						 tx_req->rtwsta_link);
 		if (addr_cam->valid && desc_info->mlo)
 			upd_wlan_hdr = true;
+
+		if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)
+			rtw89_tx_rpt_enable(rtwdev, tx_req);
 	}
 	is_bmc = (is_broadcast_ether_addr(hdr->addr1) ||
 		  is_multicast_ether_addr(hdr->addr1));
@@ -1140,7 +1143,10 @@ static void rtw89_tx_wait_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						tx_wait_work.work);
 
-	rtw89_tx_wait_list_clear(rtwdev);
+	if (!rtwdev->hci.tx_rpt_enable)
+		rtw89_tx_wait_list_clear(rtwdev);
+	else
+		rtw89_tx_rpt_queue_purge(rtwdev);
 }
 
 void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
@@ -5847,6 +5853,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6ghz_probe_work);
 	INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
 
+	skb_queue_head_init(&rtwdev->tx_rpt_queue);
 	skb_queue_head_init(&rtwdev->c2h_queue);
 	rtw89_core_ppdu_sts_init(rtwdev);
 	rtw89_traffic_stats_init(rtwdev, &rtwdev->stats);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 66b7bfa5902e..3940e54353d3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3527,6 +3527,8 @@ struct rtw89_tx_wait_info {
 
 struct rtw89_tx_skb_data {
 	struct rtw89_tx_wait_info __rcu *wait;
+	u8 tx_rpt_sn;
+	u8 tx_pkt_cnt_lmt;
 	u8 hci_priv[];
 };
 
@@ -3696,6 +3698,7 @@ struct rtw89_hci_info {
 	u32 rpwm_addr;
 	u32 cpwm_addr;
 	bool paused;
+	bool tx_rpt_enable;
 };
 
 struct rtw89_chip_ops {
@@ -6015,6 +6018,9 @@ struct rtw89_dev {
 	struct list_head tx_waits;
 	struct wiphy_delayed_work tx_wait_work;
 
+	atomic_t sn;
+	struct sk_buff_head tx_rpt_queue;
+
 	struct rtw89_cam_info cam_info;
 
 	struct sk_buff_head c2h_queue;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 10c2a39e544b..75d9efac452b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5465,10 +5465,29 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 	u8 sw_define = le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_SW_DEFINE);
 	u8 tx_status = le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_TX_STATE);
 	u8 data_txcnt = le32_get_bits(rpt->w5, RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT);
+	struct rtw89_tx_skb_data *skb_data;
+	struct sk_buff *cur, *tmp;
+	unsigned long flags;
 
 	rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 		    "C2H TX RPT: sn %d, tx_status %d, data_txcnt %d\n",
 		    sw_define, tx_status, data_txcnt);
+
+	spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
+	skb_queue_walk_safe(&rtwdev->tx_rpt_queue, cur, tmp) {
+		skb_data = RTW89_TX_SKB_CB(cur);
+
+		if (sw_define != skb_data->tx_rpt_sn)
+			continue;
+		if (tx_status != RTW89_TX_DONE &&
+		    data_txcnt != skb_data->tx_pkt_cnt_lmt)
+			continue;
+
+		__skb_unlink(cur, &rtwdev->tx_rpt_queue);
+		rtw89_tx_rpt_tx_status(rtwdev, cur, tx_status);
+		break;
+	}
+	spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 15c5c7e4033c..1f7d3734d15f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1616,4 +1616,47 @@ int rtw89_mac_scan_offload(struct rtw89_dev *rtwdev,
 
 	return ret;
 }
+
+static inline
+void rtw89_tx_rpt_enable(struct rtw89_dev *rtwdev,
+			 struct rtw89_core_tx_request *tx_req)
+{
+	if (!rtwdev->hci.tx_rpt_enable)
+		return;
+
+	tx_req->desc_info.report = true;
+	tx_req->desc_info.sn = atomic_inc_return(&rtwdev->sn) & 0xF;
+	tx_req->desc_info.tx_cnt_lmt_en = true;
+	tx_req->desc_info.tx_cnt_lmt = 8;
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
+	struct sk_buff_head q;
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	__skb_queue_head_init(&q);
+	spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
+	skb_queue_splice_init(&rtwdev->tx_rpt_queue, &q);
+	spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);
+
+	while ((skb = __skb_dequeue(&q)))
+		rtw89_tx_rpt_tx_status(rtwdev, skb, RTW89_TX_MACID_DROP);
+}
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 655e8437d62e..f53ab676e9a8 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -216,6 +216,15 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 		skb_pull(skb, txdesc_size);
 
 		info = IEEE80211_SKB_CB(skb);
+		if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
+			/* sn is passed to rtw89_mac_c2h_tx_rpt() via driver data */
+			skb_queue_tail(&rtwdev->tx_rpt_queue, skb);
+			wiphy_delayed_work_queue(rtwdev->hw->wiphy,
+						 &rtwdev->tx_wait_work,
+						 RTW89_TX_WAIT_WORK_TIMEOUT);
+			continue;
+		}
+
 		ieee80211_tx_info_clear_status(info);
 
 		if (urb->status == 0) {
@@ -396,6 +405,8 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
 	memset(txdesc, 0, txdesc_size);
 	rtw89_chip_fill_txdesc(rtwdev, desc_info, txdesc);
 
+	RTW89_TX_SKB_CB(skb)->tx_rpt_sn = tx_req->desc_info.sn;
+
 	le32p_replace_bits(&txdesc->dword0, 1, RTW89_TXWD_BODY0_STF_MODE);
 
 	skb_queue_tail(&rtwusb->tx_queue[desc_info->ch_dma], skb);
@@ -678,7 +689,7 @@ static void rtw89_usb_deinit_tx(struct rtw89_dev *rtwdev)
 
 static void rtw89_usb_ops_reset(struct rtw89_dev *rtwdev)
 {
-	/* TODO: anything to do here? */
+	rtw89_tx_rpt_queue_purge(rtwdev);
 }
 
 static int rtw89_usb_ops_start(struct rtw89_dev *rtwdev)
@@ -962,6 +973,7 @@ int rtw89_usb_probe(struct usb_interface *intf,
 
 	rtwdev->hci.ops = &rtw89_usb_ops;
 	rtwdev->hci.type = RTW89_HCI_TYPE_USB;
+	rtwdev->hci.tx_rpt_enable = true;
 
 	ret = rtw89_usb_intf_init(rtwdev, intf);
 	if (ret) {
-- 
2.51.0


