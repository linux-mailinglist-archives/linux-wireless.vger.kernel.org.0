Return-Path: <linux-wireless+bounces-28382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B454FC1CE45
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 20:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 632F44E2C00
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 19:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EAD35A159;
	Wed, 29 Oct 2025 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="VKwZN5t4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B5359F81;
	Wed, 29 Oct 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764587; cv=none; b=AqbD9/sy1Xt7PkpH+yduAaintnyiZQwP6cfdSzfmy+L7K17lHLDSD14O5CaYdmLSkgVeQQ5LbWSZU5+3dzfYvFsXUztlSyjWaDmWO8nxdFI4CSca1qznnpYXNjtupGigSM71hSFjv2QXqG7qWIxIPV9/yqirprbscH1YJb/puYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764587; c=relaxed/simple;
	bh=MmZnm8c8K/KdjD4ZMfwtWe/jnPVSTOAeA3O2c5jY+uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suwr8VIQh85GrM+GTXWLlmYqHKM3aGr136GBxNLzJkV5e13SQZtfWDRytTUun/Z6oXWO2x/VYx27XwujLkfvFQCwmbLGL9E2JFV3/MmB6BpQn7mtPFn25XIPIfbEvgAukCd/65wjHB6TqBKLDUSjPXllG3+j9w1Vxk73YeFPtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=VKwZN5t4; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7F17540777B3;
	Wed, 29 Oct 2025 19:03:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7F17540777B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761764581;
	bh=S2i7jF9OmAeePWQbw7BoE8r46UITUtxwGtyawLeFRhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKwZN5t4XfD4KikvdU9Iy9n+FOi9fimQMgd/Zr1lACS4JsSv6LbXx119kItzE9Nmm
	 3+qhN1/YVC/+bvDKdE+pD0Bww7D1s3A8Ky6DCXZou1Lb3+iHonDSI6F4tk0zwUxgLr
	 bsrwb9+F1oKFKrhPghKeiML2npmelTHMv+KSNDpk=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v4 08/10] wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Date: Wed, 29 Oct 2025 22:02:36 +0300
Message-ID: <20251029190241.1023856-9-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029190241.1023856-1-pchelkin@ispras.ru>
References: <20251029190241.1023856-1-pchelkin@ispras.ru>
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

Thus define a .tx_rpt_enabled flag indicating which HCIs need to enable a
TX report feature.  Currently it is USB only.

Toggle a bit in the TX descriptor and place flagged skbs in a fix-sized
queue to wait for a message from the firmware.  Firmware maintains a 4-bit
sequence number for required frames hence the queue can contain just 16
elements simultaneously.  That's enough for normal driver / firmware
communication.  If the firmware crashes for any reason and doesn't provide
TX reports in time, driver will handle this and report the obsolete frames
as dropped.

rtw89 also has a new feature providing a TX report for each transmission
attempt.  Ignore a failed TX status reported by the firmware until retry
limit is reached or successful status appears.  When there is no success
and the retry limit is reached, report the frame up to the wireless stack
as failed eventually.

HCI reset should stop all pending TX activity so forcefully flush the
queue there.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v4: - use fix-sized queue for storing pending TX frames, replace skb queue
      list implementation
    - update the changelog accordingly
    - make comment right after hci->reset to explicitly point out we should
      complete all TX waits skbs (Ping-Ke)
    - check urb->status for TX rpt frames, too (Ping-Ke)

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
 drivers/net/wireless/realtek/rtw89/core.h | 13 ++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 26 ++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 81 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.c  | 18 +++++
 5 files changed, 142 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c069bde8b44e..d0b8cd999b49 100644
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
 
@@ -5846,6 +5849,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6ghz_probe_work);
 	INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
 
+	spin_lock_init(&rtwdev->tx_rpt.skb_lock);
 	skb_queue_head_init(&rtwdev->c2h_queue);
 	rtw89_core_ppdu_sts_init(rtwdev);
 	rtw89_traffic_stats_init(rtwdev, &rtwdev->stats);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 9372e30a0039..015d7833841f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3517,6 +3517,14 @@ struct rtw89_phy_rate_pattern {
 #define RTW89_TX_LIFE_TIME		0x2
 #define RTW89_TX_MACID_DROP		0x3
 
+#define RTW89_MAX_TX_RPTS		16
+#define RTW89_MAX_TX_RPTS_MASK		(RTW89_MAX_TX_RPTS - 1)
+struct rtw89_tx_rpt {
+	struct sk_buff *skbs[RTW89_MAX_TX_RPTS];
+	spinlock_t skb_lock;
+	atomic_t sn;
+};
+
 #define RTW89_TX_WAIT_WORK_TIMEOUT msecs_to_jiffies(500)
 struct rtw89_tx_wait_info {
 	struct rcu_head rcu_head;
@@ -3528,6 +3536,8 @@ struct rtw89_tx_wait_info {
 
 struct rtw89_tx_skb_data {
 	struct rtw89_tx_wait_info __rcu *wait;
+	u8 tx_rpt_sn;
+	u8 tx_pkt_cnt_lmt;
 	u8 hci_priv[];
 };
 
@@ -3697,6 +3707,7 @@ struct rtw89_hci_info {
 	u32 rpwm_addr;
 	u32 cpwm_addr;
 	bool paused;
+	bool tx_rpt_enabled;
 };
 
 struct rtw89_chip_ops {
@@ -6019,6 +6030,8 @@ struct rtw89_dev {
 	struct list_head tx_waits;
 	struct wiphy_delayed_work tx_wait_work;
 
+	struct rtw89_tx_rpt tx_rpt;
+
 	struct rtw89_cam_info cam_info;
 
 	struct sk_buff_head c2h_queue;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e4e126a4428b..a6642c5761cb 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5463,7 +5463,10 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
 static void
 rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
+	struct rtw89_tx_rpt *tx_rpt = &rtwdev->tx_rpt;
+	struct rtw89_tx_skb_data *skb_data;
 	u8 sw_define, tx_status, txcnt;
+	struct sk_buff *skb;
 
 	if (rtwdev->chip->chip_id == RTL8922A) {
 		const struct rtw89_c2h_mac_tx_rpt_v2 *rpt_v2;
@@ -5492,6 +5495,29 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 	rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 		    "C2H TX RPT: sn %d, tx_status %d, txcnt %d\n",
 		    sw_define, tx_status, txcnt);
+
+	scoped_guard(spinlock_irqsave, &tx_rpt->skb_lock) {
+		skb = tx_rpt->skbs[sw_define];
+
+		/* skip if no skb (normally shouldn't happen) */
+		if (!skb) {
+			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+				    "C2H TX RPT: no skb found in queue\n");
+			return;
+		}
+
+		skb_data = RTW89_TX_SKB_CB(skb);
+
+		/* skip if TX attempt has failed and retry limit has not been
+		 * reached yet
+		 */
+		if (tx_status != RTW89_TX_DONE &&
+		    txcnt != skb_data->tx_pkt_cnt_lmt)
+			return;
+
+		tx_rpt->skbs[sw_define] = NULL;
+		rtw89_tx_rpt_tx_status(rtwdev, skb, tx_status);
+	}
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 15c5c7e4033c..fde784b41bcf 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1616,4 +1616,85 @@ int rtw89_mac_scan_offload(struct rtw89_dev *rtwdev,
 
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
+	tx_req->desc_info.sn = atomic_inc_return(&tx_rpt->sn) &
+			       RTW89_MAX_TX_RPTS_MASK;
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
+void rtw89_tx_rpt_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *skb,
+			    u8 tx_status)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+	ieee80211_tx_info_clear_status(info);
+
+	if (tx_status == RTW89_TX_DONE)
+		info->flags |= IEEE80211_TX_STAT_ACK;
+	else
+		info->flags &= ~IEEE80211_TX_STAT_ACK;
+
+	ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
+}
+
+static inline
+void rtw89_tx_rpt_skb_add(struct rtw89_dev *rtwdev, struct sk_buff *skb)
+{
+	struct rtw89_tx_rpt *tx_rpt = &rtwdev->tx_rpt;
+	struct rtw89_tx_skb_data *skb_data;
+	u8 idx;
+
+	skb_data = RTW89_TX_SKB_CB(skb);
+	idx = skb_data->tx_rpt_sn;
+
+	scoped_guard(spinlock_irqsave, &tx_rpt->skb_lock) {
+		/* if skb having the similar seq number is still in the queue,
+		 * this means the queue is overflowed - it isn't normal and
+		 * should indicate firmware doesn't provide TX reports in time;
+		 * report the old skb as dropped, we can't do much more here
+		 */
+		if (tx_rpt->skbs[idx])
+			rtw89_tx_rpt_tx_status(rtwdev, tx_rpt->skbs[idx],
+					       RTW89_TX_MACID_DROP);
+		tx_rpt->skbs[idx] = skb;
+	}
+}
+
+static inline
+void rtw89_tx_rpt_skbs_purge(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_tx_rpt *tx_rpt = &rtwdev->tx_rpt;
+	struct sk_buff *skbs[RTW89_MAX_TX_RPTS];
+
+	scoped_guard(spinlock_irqsave, &tx_rpt->skb_lock) {
+		memcpy(skbs, tx_rpt->skbs, sizeof(tx_rpt->skbs));
+		memset(tx_rpt->skbs, 0, sizeof(tx_rpt->skbs));
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(skbs); i++)
+		if (skbs[i])
+			rtw89_tx_rpt_tx_status(rtwdev, skbs[i],
+					       RTW89_TX_MACID_DROP);
+}
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index c359b469aabe..5e587c93268e 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -216,6 +216,15 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 		skb_pull(skb, txdesc_size);
 
 		info = IEEE80211_SKB_CB(skb);
+		if (rtw89_is_tx_rpt_skb(skb)) {
+			if (urb->status == 0)
+				rtw89_tx_rpt_skb_add(rtwdev, skb);
+			else
+				rtw89_tx_rpt_tx_status(rtwdev, skb,
+						       RTW89_TX_MACID_DROP);
+			continue;
+		}
+
 		ieee80211_tx_info_clear_status(info);
 
 		if (urb->status == 0) {
@@ -378,6 +387,7 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	struct rtw89_tx_skb_data *skb_data;
 	struct sk_buff *skb = tx_req->skb;
 	struct rtw89_txwd_body *txdesc;
 	u32 txdesc_size;
@@ -404,6 +414,12 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
 
 	le32p_replace_bits(&txdesc->dword0, 1, RTW89_TXWD_BODY0_STF_MODE);
 
+	skb_data = RTW89_TX_SKB_CB(skb);
+	if (tx_req->desc_info.sn)
+		skb_data->tx_rpt_sn = tx_req->desc_info.sn;
+	if (tx_req->desc_info.tx_cnt_lmt)
+		skb_data->tx_pkt_cnt_lmt = tx_req->desc_info.tx_cnt_lmt;
+
 	skb_queue_tail(&rtwusb->tx_queue[desc_info->ch_dma], skb);
 
 	return 0;
@@ -692,6 +708,7 @@ static void rtw89_usb_ops_reset(struct rtw89_dev *rtwdev)
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
 
 	rtw89_usb_cancel_tx_bufs(rtwusb);
+	rtw89_tx_rpt_skbs_purge(rtwdev);
 }
 
 static int rtw89_usb_ops_start(struct rtw89_dev *rtwdev)
@@ -977,6 +994,7 @@ int rtw89_usb_probe(struct usb_interface *intf,
 
 	rtwdev->hci.ops = &rtw89_usb_ops;
 	rtwdev->hci.type = RTW89_HCI_TYPE_USB;
+	rtwdev->hci.tx_rpt_enabled = true;
 
 	ret = rtw89_usb_intf_init(rtwdev, intf);
 	if (ret) {
-- 
2.51.0


