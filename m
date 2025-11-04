Return-Path: <linux-wireless+bounces-28541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDFEC315A4
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 15:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD73818C47F7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243A032E72B;
	Tue,  4 Nov 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="jKJJepbo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C832AACC;
	Tue,  4 Nov 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264678; cv=none; b=KgltPow+iJIoMvPhggu2Rk9Kd4TaGaoCY6Z7of5FbjWlpPodsak9IdYWCTKnxmj0MKsp11geIAnt7el2HLlBZ3xj/i6+KsO6Gy3g4ZFkX3g47iLx+qb7rU36AtwX97i31XVR5qR0vrChMdMqWgtKlERlyzPOumFKhhHkPbxYNCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264678; c=relaxed/simple;
	bh=R79NvCtSSDtHptxRlhmkJ+5dSsZap3dJZL5gCIE9YLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agMZc04yMgR7bt6hoVQSo3jt3zv7YV0bMrrZopk58Hvm1cZxUAYaSeuLvitJw82VIVeOKSv+YrxN9m9aQ+O5lxABNyl/rzCGqGp8jXNX7TR66R2pao/dfdsaKbWq2ZdJfYtGs8E6rT2+Uh5aHCZ3AQxIKDasxqhly24sBEsYaFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=jKJJepbo; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id C07344078507;
	Tue,  4 Nov 2025 13:57:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C07344078507
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1762264668;
	bh=0ls4rUggpNN6fuXMoeXlS7JCepCKeWgo2xdyNOdB+mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKJJepbo5dNFPkHs5mp1mC/P5MMeYwSu1eoLYxh/HCsnpbHdUIg5gmZSyJ+Lh9A9X
	 U5lG4yDEul3QCY3b6yRyhULLN7gBI2R1+hGe8bjofVQg5Om1Ek6aQ+AgAENCQweSCf
	 wCTdlaesx1Ys+i6LzTG/Qk5aIlIekxg2+NnE7YtA=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v5 10/10] wifi: rtw89: process TX wait skbs for USB via C2H handler
Date: Tue,  4 Nov 2025 16:57:17 +0300
Message-ID: <20251104135720.321110-11-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104135720.321110-1-pchelkin@ispras.ru>
References: <20251104135720.321110-1-pchelkin@ispras.ru>
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
identify completed items inside the C2H handler.  Try to do this as
similar to PCIe path as possible.  When the corresponding TX wait skb is
found inside TX report queue, unlink it from there and call
rtw89_core_tx_wait_complete() to mark the completion.

If the callee waiting for the completion has already timed out, the TX
wait skb is placed into TX wait list (like PCIe part does).

It's important that during HCI reset all pending TX wait frames should be
completed inside hci.ops->reset method before calling
rtw89_tx_wait_list_clear().

Found by Linux Verification Center (linuxtesting.org).

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v4: - minor `info = IEEE80211_SKB_CB` assignment reordering to make it look
      more like PCIe side; Acked-by kept (Ping-Ke)
    - add a comment on completing TX waits in ->reset (Ping-Ke) 

v3: - use rcu_access_pointer() inside rtw89_core_is_tx_wait()  (Zong-Zhe)
    - finally I've hopefully realized what you meant by doing TX wait
      skb handling here similar to PCIe.  IMO this looks just elegant now
      compared to my previous submissions. Thanks, Ping-Ke!

v2: store TX wait skbs in tx_rpt_queue (Ping-Ke)

 drivers/net/wireless/realtek/rtw89/core.c |  5 ++---
 drivers/net/wireless/realtek/rtw89/core.h |  7 +++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 13 ++++++++++---
 drivers/net/wireless/realtek/rtw89/usb.c  |  2 +-
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 6059e30a0590..1d30ff27bce1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1131,7 +1131,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	if (addr_cam->valid && desc_info->mlo)
 		upd_wlan_hdr = true;
 
-	if (rtw89_is_tx_rpt_skb(tx_req->skb))
+	if (rtw89_is_tx_rpt_skb(rtwdev, tx_req->skb))
 		rtw89_tx_rpt_init(rtwdev, tx_req);
 
 	is_bmc = (is_broadcast_ether_addr(hdr->addr1) ||
@@ -1263,14 +1263,13 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
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
index cb71bd87b193..71eb7078a0dc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6328,6 +6328,7 @@ static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
 static inline void rtw89_hci_reset(struct rtw89_dev *rtwdev)
 {
 	rtwdev->hci.ops->reset(rtwdev);
+	/* hci.ops->reset must complete all pending TX wait SKBs */
 	rtw89_tx_wait_list_clear(rtwdev);
 }
 
@@ -7409,6 +7410,12 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
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
index 56751dd6e99b..ce3474a7ba03 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1645,19 +1645,26 @@ void rtw89_tx_rpt_init(struct rtw89_dev *rtwdev,
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
 void rtw89_tx_rpt_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			    u8 tx_status)
 {
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
+	struct ieee80211_tx_info *info;
+
+	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status))
+		return;
 
+	info = IEEE80211_SKB_CB(skb);
 	ieee80211_tx_info_clear_status(info);
 
 	if (tx_status == RTW89_TX_DONE)
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index f54e00c3033e..d7d968207a39 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -194,7 +194,7 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 
 		skb_pull(skb, txdesc_size);
 
-		if (rtw89_is_tx_rpt_skb(skb)) {
+		if (rtw89_is_tx_rpt_skb(rtwdev, skb)) {
 			if (urb->status == 0)
 				rtw89_tx_rpt_skb_add(rtwdev, skb);
 			else
-- 
2.51.0


