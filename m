Return-Path: <linux-wireless+bounces-27436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0463B7D311
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC02189BBE4
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625BB34AB0D;
	Wed, 17 Sep 2025 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="RZZdK4iL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929434A308;
	Wed, 17 Sep 2025 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102808; cv=none; b=BR7wMQlApg0NdUBSyHfGMLt2UPQ4fO4B8IzZ5/Go72o1dNcwZFmDD8T2BPTP2Xskrkj2mxCBJmnsg8ehXYhHhmQJDKPFMFMe43BnF+9j08+/iddbunfTiJDUxOl4bb8itvnsvw9NO/yc8OJTb/gn8qm19P5yRT0LKX2BCluQmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102808; c=relaxed/simple;
	bh=gdUfuLis/ZVnwZNUuUsmKuOJX4cDINBma2T0GWrtk4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xo9AWNe+tezd4sqzZ79IKJkfCvHQLQkguEYDFANzafMYz9xA0PAsLbjxruc2+VbYbnurBNKSvWAQMsq2h/xB5KNsrlK4EvkKoESYdr0xmls4depfH3jxUoHR4VdBHW/9EMvWdP94jbNdcKchPfu09y12iGrvEu10uYeAhbFTjws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=RZZdK4iL; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 05E8540762F6;
	Wed, 17 Sep 2025 09:53:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 05E8540762F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758102804;
	bh=qYuRJpUf47DnQDklhDIhNPsYu32t1FjJ+rUuDvOnnm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZZdK4iLNpUqzRGBiDuQYQ50OEODhNmcofSQzE7hayprk4lUln6EU8SXAed3IcYRN
	 u1dq7abX61j2Uc2m8hcC/I8i73FOHKwz9QHuH/3zKewjxN3+uVavJ/1Z0AxCEKYGAX
	 ukpaPHGtXgW644MSQTZgbng6jRiHqp5ZxcTqkNSs=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH rtw v4 2/4] wifi: rtw89: fix tx_wait initialization race
Date: Wed, 17 Sep 2025 12:52:53 +0300
Message-ID: <20250917095302.2908617-3-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917095302.2908617-1-pchelkin@ispras.ru>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that nullfunc skbs are recycled in a separate work item in the driver,
the following race during initialization and processing of those skbs
might lead to noticeable bugs:

      Waiting thread                          Completing thread

rtw89_core_send_nullfunc()
  rtw89_core_tx_write_link()
    ...
    rtw89_pci_txwd_submit()
      skb_data->wait = NULL
      /* add skb to the queue */
      skb_queue_tail(&txwd->queue, skb)
                                            rtw89_pci_napi_poll()
                                            ...
                                              rtw89_pci_release_txwd_skb()
                                                /* get skb from the queue */
                                                skb_unlink(skb, &txwd->queue)
                                                rtw89_pci_tx_status()
                                                  rtw89_core_tx_wait_complete()
                                                  /* use incorrect skb_data->wait */
  rtw89_core_tx_kick_off_and_wait()
  /* assign skb_data->wait but too late */

The value of skb_data->wait indicates whether skb is passed on to the
core ieee80211 stack or released by the driver itself.  So assure that by
the time skb is added to txwd queue and becomes visible to the completing
side, it has already allocated tx_wait-related data (in case it's needed).

Found by Linux Verification Center (linuxtesting.org).

Fixes: 1ae5ca615285 ("wifi: rtw89: add function to wait for completion of TX skbs")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v4: - use wiphy_dereference (Zong-Zhe)
    - move wait->skb assignment place 

 drivers/net/wireless/realtek/rtw89/core.c | 35 ++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/pci.c  |  2 --
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 438930b65631..1efe4bb09262 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1094,22 +1094,13 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 				    int qsel, unsigned int timeout)
 {
 	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
-	struct rtw89_tx_wait_info *wait;
+	struct rtw89_tx_wait_info *wait = wiphy_dereference(rtwdev->hw->wiphy,
+							    skb_data->wait);
 	unsigned long time_left;
 	int ret = 0;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
-	wait = kzalloc(sizeof(*wait), GFP_KERNEL);
-	if (!wait) {
-		rtw89_core_tx_kick_off(rtwdev, qsel);
-		return 0;
-	}
-
-	init_completion(&wait->completion);
-	wait->skb = skb;
-	rcu_assign_pointer(skb_data->wait, wait);
-
 	rtw89_core_tx_kick_off(rtwdev, qsel);
 	time_left = wait_for_completion_timeout(&wait->completion,
 						msecs_to_jiffies(timeout));
@@ -1171,10 +1162,12 @@ int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
 static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link,
 				    struct rtw89_sta_link *rtwsta_link,
-				    struct sk_buff *skb, int *qsel, bool sw_mld)
+				    struct sk_buff *skb, int *qsel, bool sw_mld,
+				    struct rtw89_tx_wait_info *wait)
 {
 	struct ieee80211_sta *sta = rtwsta_link_to_sta_safe(rtwsta_link);
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct rtw89_core_tx_request tx_req = {};
 	int ret;
@@ -1191,6 +1184,8 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
 	rtw89_core_tx_wake(rtwdev, &tx_req);
 
+	rcu_assign_pointer(skb_data->wait, wait);
+
 	ret = rtw89_hci_tx_write(rtwdev, &tx_req);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to transmit skb to HCI\n");
@@ -1227,7 +1222,8 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		}
 	}
 
-	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel, false);
+	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel, false,
+					NULL);
 }
 
 static __le32 rtw89_build_txwd_body0(struct rtw89_tx_desc_info *desc_info)
@@ -3425,6 +3421,7 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	int link_id = ieee80211_vif_is_mld(vif) ? rtwvif_link->link_id : -1;
 	struct rtw89_sta_link *rtwsta_link;
+	struct rtw89_tx_wait_info *wait;
 	struct ieee80211_sta *sta;
 	struct ieee80211_hdr *hdr;
 	struct rtw89_sta *rtwsta;
@@ -3434,6 +3431,12 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
 		return 0;
 
+	wait = kzalloc(sizeof(*wait), GFP_KERNEL);
+	if (!wait)
+		return -ENOMEM;
+
+	init_completion(&wait->completion);
+
 	rcu_read_lock();
 	sta = ieee80211_find_sta(vif, vif->cfg.ap_addr);
 	if (!sta) {
@@ -3448,6 +3451,8 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 		goto out;
 	}
 
+	wait->skb = skb;
+
 	hdr = (struct ieee80211_hdr *)skb->data;
 	if (ps)
 		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
@@ -3458,7 +3463,8 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 		goto out;
 	}
 
-	ret = rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, &qsel, true);
+	ret = rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, &qsel, true,
+				       wait);
 	if (ret) {
 		rtw89_warn(rtwdev, "nullfunc transmit failed: %d\n", ret);
 		dev_kfree_skb_any(skb);
@@ -3471,6 +3477,7 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 					       timeout);
 out:
 	rcu_read_unlock();
+	kfree(wait);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 4e3034b44f56..cb9682f306a6 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1372,7 +1372,6 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	struct pci_dev *pdev = rtwpci->pdev;
 	struct sk_buff *skb = tx_req->skb;
 	struct rtw89_pci_tx_data *tx_data = RTW89_PCI_TX_SKB_CB(skb);
-	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	bool en_wd_info = desc_info->en_wd_info;
 	u32 txwd_len;
 	u32 txwp_len;
@@ -1388,7 +1387,6 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	}
 
 	tx_data->dma = dma;
-	rcu_assign_pointer(skb_data->wait, NULL);
 
 	txwp_len = sizeof(*txwp_info);
 	txwd_len = chip->txwd_body_size;
-- 
2.51.0


