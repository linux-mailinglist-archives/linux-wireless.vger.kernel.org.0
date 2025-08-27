Return-Path: <linux-wireless+bounces-26697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C329EB381EC
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 14:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9449E206FAB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 12:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D11F3019AA;
	Wed, 27 Aug 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="pX7uyyFi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977E1F5834;
	Wed, 27 Aug 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296406; cv=none; b=Ha5WBe/8cMwIfZ2aXj+T+5XMt8USlD4R0nJf4IqETBRs4isWYVqgP5Dk3ifyaSCkHEGEJPmzAg8r/S6R7DODF3vjiDZFPGqx0FdH8greCCQfJ0y2Knb+jrQrNFqMms1fszc0NsySjhLbcC2/aKszvtiQL07w0OxAsi0A1iRXfjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296406; c=relaxed/simple;
	bh=oTjrnS1aokalKGVqTNC1iPeymCdEbqzGxNqHVimfBRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/3mqqXMDhGcmwVkLOzbNbJgQb2HsmFA8ZHQQGqNXYO5zA7Ux/E0uD8qxSzgM0R8ap+3a2rJyL5WOCnWShJRzTD4/3v5iTVuJli3C78FXqlPoK1ne9u9Xy7khGv4ukkFcvIqdoJ8+GsSvk5D1mRS5hJ8+Gx3oyH23RMF6grjHcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=pX7uyyFi; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 55C2B406C3E0;
	Wed, 27 Aug 2025 12:06:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 55C2B406C3E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756296400;
	bh=Mr57vs1QnPyRziD5WmW4Bs5hMaftxIZmL4AMV+GIvZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pX7uyyFiXLmy8F4NFoUs4lyvlx/VywnrXkIvcLvNwZeI+z/VrJYLhw5VC4LArmBZ3
	 XT4NBMrhLsHHDvSyxKSmOKGRzOu4sjC2AdRel1EEgdF4tFpSvn9OpiAclAzi52CWQZ
	 R2x+lPU1ZAXqpYwLi6y/cOF6aFkWpVCrpu6qzR2w=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH rtw v2 2/4] wifi: rtw89: fix tx_wait initialization race
Date: Wed, 27 Aug 2025 15:05:15 +0300
Message-ID: <20250827120603.723548-3-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827120603.723548-1-pchelkin@ispras.ru>
References: <20250827120603.723548-1-pchelkin@ispras.ru>
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
 drivers/net/wireless/realtek/rtw89/core.c | 31 +++++++++++++----------
 drivers/net/wireless/realtek/rtw89/pci.c  |  2 --
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 48aa02d6abd4..28bbc898b95e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1106,21 +1106,12 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 				    int qsel, unsigned int timeout)
 {
 	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
-	struct rtw89_tx_wait_info *wait;
+	struct rtw89_tx_wait_info *wait = skb_data->wait;
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
-	skb_data->wait = wait;
-
 	rtw89_core_tx_kick_off(rtwdev, qsel);
 	time_left = wait_for_completion_timeout(&wait->completion,
 						msecs_to_jiffies(timeout));
@@ -1184,10 +1175,12 @@ int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
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
@@ -1204,6 +1197,8 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
 	rtw89_core_tx_wake(rtwdev, &tx_req);
 
+	skb_data->wait = wait;
+
 	ret = rtw89_hci_tx_write(rtwdev, &tx_req);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to transmit skb to HCI\n");
@@ -1240,7 +1235,8 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		}
 	}
 
-	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel, false);
+	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel, false,
+					NULL);
 }
 
 static __le32 rtw89_build_txwd_body0(struct rtw89_tx_desc_info *desc_info)
@@ -3438,6 +3434,7 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	int link_id = ieee80211_vif_is_mld(vif) ? rtwvif_link->link_id : -1;
 	struct rtw89_sta_link *rtwsta_link;
+	struct rtw89_tx_wait_info *wait;
 	struct ieee80211_sta *sta;
 	struct ieee80211_hdr *hdr;
 	struct rtw89_sta *rtwsta;
@@ -3447,6 +3444,12 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
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
@@ -3471,7 +3474,8 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 		goto out;
 	}
 
-	ret = rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, &qsel, true);
+	ret = rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, &qsel, true,
+				       wait);
 	if (ret) {
 		rtw89_warn(rtwdev, "nullfunc transmit failed: %d\n", ret);
 		dev_kfree_skb_any(skb);
@@ -3484,6 +3488,7 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 					       timeout);
 out:
 	rcu_read_unlock();
+	kfree(wait);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 6356c2c224c5..8ad505743a8e 100644
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
-	skb_data->wait = NULL;
 
 	txwp_len = sizeof(*txwp_info);
 	txwd_len = chip->txwd_body_size;
-- 
2.50.1


