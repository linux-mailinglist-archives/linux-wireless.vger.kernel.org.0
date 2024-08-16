Return-Path: <linux-wireless+bounces-11515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36BD954229
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 08:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA581F21C61
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 06:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF90D82490;
	Fri, 16 Aug 2024 06:56:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCEB7FBA1
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791407; cv=none; b=VHpmsTGcAGxmw1SpPldPUCC4lABPiLjoH0F496mc0yDf1Z54g1BDPFnAA7OoRcinV5nWukKfgBdYwpv6JdnmzAaWmx5WnBsPSjreKkQM7CYJBBCGQpFcbb/z2Ieu7gAUj9tBHlmndI4nmyckJuFcxbESa/PiDDIq3pP8Upc86Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791407; c=relaxed/simple;
	bh=+jnz5WErXWJkDmhX/Q0FbYDi2dBARIowfXLRq9Y61R0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PL8HLmnNXHtSd9/WUiHb9WufVlhT4xeoN4qYBZmRUZ5IJ21b5P2lVvK8M/WZWckJdJkafeCQ+L4IseBRBvb2X45H2U9HalgNjKqxaTqnMi2TwrK3nff/1/j2qbfZjsm2W8/pLc6ujiQAG89hF7b9dq2G0svMzQXaQxicTZ/WV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1seqsg-0004pS-3S; Fri, 16 Aug 2024 08:56:14 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1seqsf-000mIF-9j; Fri, 16 Aug 2024 08:56:13 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1seqsf-00FSYn-0h;
	Fri, 16 Aug 2024 08:56:13 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 16 Aug 2024 08:56:10 +0200
Subject: [PATCH] wifi: mwifiex: remove unnecessary checks for valid priv
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mwifiex-remove-priv-checks-v1-1-6dd6553e8ed9@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAn4vmYC/x3MTQqDMBAG0KvIrDsQbQjaq5Qu0vhFB/GHCURBv
 LvB5du8kxJUkOhTnaTIkmRdCupXRWH0ywCWvpga01jT1o7nXaLgYMW8ZvCmkjmMCFNi7w1i5/5
 4245KsCmiHE/+/V3XDZxktHpsAAAA
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723791373; l=17485;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=+jnz5WErXWJkDmhX/Q0FbYDi2dBARIowfXLRq9Y61R0=;
 b=F2Djc1HizIWevSlHBRI++tAsCvNk3W9Y3iL2KtCu8hwaLc7LzpdAfHcZaYRWSTSeKM9ImbcKH
 C0WnUYok4f/Cd9mMMvyR2j2CcL4FeT5H5w6MmS/FxF/FUHyeH0/vmTF
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The pointers in adapter->priv[] are allocated in mwifiex_register().
With an allocation failed the function will return an error and
driver initialization is aborted. This makes all checks for valid
priv pointers unnecessary throughout the driver. In many places
the pointers are assumed to be valid without checks, this patch
removes the remaining checks.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/11n.c         |  2 -
 drivers/net/wireless/marvell/mwifiex/11n.h         |  4 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   | 23 +++-----
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |  4 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      |  2 +-
 drivers/net/wireless/marvell/mwifiex/init.c        | 67 +++++++++-------------
 drivers/net/wireless/marvell/mwifiex/join.c        |  3 +-
 drivers/net/wireless/marvell/mwifiex/main.c        | 14 ++---
 drivers/net/wireless/marvell/mwifiex/main.h        | 30 ++++------
 drivers/net/wireless/marvell/mwifiex/scan.c        |  2 -
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |  3 +-
 drivers/net/wireless/marvell/mwifiex/usb.c         |  7 +--
 drivers/net/wireless/marvell/mwifiex/wmm.c         |  7 ---
 13 files changed, 59 insertions(+), 109 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index c0c635e74bc50..66f0f5377ac18 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -881,8 +881,6 @@ void mwifiex_update_ampdu_txwinsize(struct mwifiex_adapter *adapter)
 	struct mwifiex_private *priv;
 
 	for (i = 0; i < adapter->priv_num; i++) {
-		if (!adapter->priv[i])
-			continue;
 		priv = adapter->priv[i];
 		tx_win_size = priv->add_ba_param.tx_win_size;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/11n.h b/drivers/net/wireless/marvell/mwifiex/11n.h
index 7738ebe1fec17..773bd5c0f007d 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.h
+++ b/drivers/net/wireless/marvell/mwifiex/11n.h
@@ -108,9 +108,7 @@ static inline u8 mwifiex_space_avail_for_new_ba_stream(
 
 	for (i = 0; i < adapter->priv_num; i++) {
 		priv = adapter->priv[i];
-		if (priv)
-			ba_stream_num += list_count_nodes(
-				&priv->tx_ba_stream_tbl_ptr);
+		ba_stream_num += list_count_nodes(&priv->tx_ba_stream_tbl_ptr);
 	}
 
 	if (adapter->fw_api_ver == MWIFIEX_FW_V15) {
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 10690e82358b8..cb948ca343736 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -810,8 +810,6 @@ void mwifiex_update_rxreor_flags(struct mwifiex_adapter *adapter, u8 flags)
 
 	for (i = 0; i < adapter->priv_num; i++) {
 		priv = adapter->priv[i];
-		if (!priv)
-			continue;
 
 		spin_lock_bh(&priv->rx_reorder_tbl_lock);
 		list_for_each_entry(tbl, &priv->rx_reorder_tbl_ptr, list)
@@ -834,8 +832,6 @@ static void mwifiex_update_ampdu_rxwinsize(struct mwifiex_adapter *adapter,
 	dev_dbg(adapter->dev, "Update rxwinsize %d\n", coex_flag);
 
 	for (i = 0; i < adapter->priv_num; i++) {
-		if (!adapter->priv[i])
-			continue;
 		priv = adapter->priv[i];
 		rx_win_size = priv->add_ba_param.rx_win_size;
 		if (coex_flag) {
@@ -882,17 +878,16 @@ void mwifiex_coex_ampdu_rxwinsize(struct mwifiex_adapter *adapter)
 	u8 count = 0;
 
 	for (i = 0; i < adapter->priv_num; i++) {
-		if (adapter->priv[i]) {
-			priv = adapter->priv[i];
-			if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_STA) {
-				if (priv->media_connected)
-					count++;
-			}
-			if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) {
-				if (priv->bss_started)
-					count++;
-			}
+		priv = adapter->priv[i];
+		if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_STA) {
+			if (priv->media_connected)
+				count++;
 		}
+		if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) {
+			if (priv->bss_started)
+				count++;
+		}
+
 		if (count >= MWIFIEX_BSS_COEX_COUNT)
 			break;
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 722ead51e9123..77016c0268c4e 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3508,7 +3508,7 @@ static int mwifiex_cfg80211_suspend(struct wiphy *wiphy,
 
 	for (i = 0; i < adapter->priv_num; i++) {
 		priv = adapter->priv[i];
-		if (priv && priv->netdev)
+		if (priv->netdev)
 			netif_device_detach(priv->netdev);
 	}
 
@@ -3580,7 +3580,7 @@ static int mwifiex_cfg80211_resume(struct wiphy *wiphy)
 
 	for (i = 0; i < adapter->priv_num; i++) {
 		priv = adapter->priv[i];
-		if (priv && priv->netdev)
+		if (priv->netdev)
 			netif_device_attach(priv->netdev);
 	}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index ea6ebc9c23ef0..7894102f03eb0 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -482,7 +482,7 @@ int mwifiex_process_event(struct mwifiex_adapter *adapter)
 	if ((adapter->event_cause & EVENT_ID_MASK) == EVENT_RADAR_DETECTED) {
 		for (i = 0; i < adapter->priv_num; i++) {
 			priv = adapter->priv[i];
-			if (priv && mwifiex_is_11h_active(priv)) {
+			if (mwifiex_is_11h_active(priv)) {
 				adapter->event_cause |=
 					((priv->bss_num & 0xff) << 16) |
 					((priv->bss_type & 0xff) << 24);
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index a336d45b9677e..8b61e45cd6678 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -368,15 +368,13 @@ static void mwifiex_invalidate_lists(struct mwifiex_adapter *adapter)
 		list_del(&adapter->bss_prio_tbl[i].bss_prio_head);
 
 	for (i = 0; i < adapter->priv_num; i++) {
-		if (adapter->priv[i]) {
-			priv = adapter->priv[i];
-			for (j = 0; j < MAX_NUM_TID; ++j)
-				list_del(&priv->wmm.tid_tbl_ptr[j].ra_list);
-			list_del(&priv->tx_ba_stream_tbl_ptr);
-			list_del(&priv->rx_reorder_tbl_ptr);
-			list_del(&priv->sta_list);
-			list_del(&priv->auto_tdls_list);
-		}
+		priv = adapter->priv[i];
+		for (j = 0; j < MAX_NUM_TID; ++j)
+			list_del(&priv->wmm.tid_tbl_ptr[j].ra_list);
+		list_del(&priv->tx_ba_stream_tbl_ptr);
+		list_del(&priv->rx_reorder_tbl_ptr);
+		list_del(&priv->sta_list);
+		list_del(&priv->auto_tdls_list);
 	}
 }
 
@@ -425,13 +423,11 @@ int mwifiex_init_lock_list(struct mwifiex_adapter *adapter)
 	spin_lock_init(&adapter->mwifiex_cmd_lock);
 	spin_lock_init(&adapter->queue_lock);
 	for (i = 0; i < adapter->priv_num; i++) {
-		if (adapter->priv[i]) {
-			priv = adapter->priv[i];
-			spin_lock_init(&priv->wmm.ra_list_spinlock);
-			spin_lock_init(&priv->curr_bcn_buf_lock);
-			spin_lock_init(&priv->sta_list_spinlock);
-			spin_lock_init(&priv->auto_tdls_lock);
-		}
+		priv = adapter->priv[i];
+		spin_lock_init(&priv->wmm.ra_list_spinlock);
+		spin_lock_init(&priv->curr_bcn_buf_lock);
+		spin_lock_init(&priv->sta_list_spinlock);
+		spin_lock_init(&priv->auto_tdls_lock);
 	}
 
 	/* Initialize cmd_free_q */
@@ -455,8 +451,6 @@ int mwifiex_init_lock_list(struct mwifiex_adapter *adapter)
 	}
 
 	for (i = 0; i < adapter->priv_num; i++) {
-		if (!adapter->priv[i])
-			continue;
 		priv = adapter->priv[i];
 		for (j = 0; j < MAX_NUM_TID; ++j)
 			INIT_LIST_HEAD(&priv->wmm.tid_tbl_ptr[j].ra_list);
@@ -506,31 +500,24 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
 	mwifiex_init_adapter(adapter);
 
 	for (i = 0; i < adapter->priv_num; i++) {
-		if (adapter->priv[i]) {
-			priv = adapter->priv[i];
+		priv = adapter->priv[i];
 
-			/* Initialize private structure */
-			ret = mwifiex_init_priv(priv);
-			if (ret)
-				return -1;
-		}
+		/* Initialize private structure */
+		ret = mwifiex_init_priv(priv);
+		if (ret)
+			return -1;
 	}
 	if (adapter->mfg_mode) {
 		adapter->hw_status = MWIFIEX_HW_STATUS_READY;
 		ret = -EINPROGRESS;
 	} else {
 		for (i = 0; i < adapter->priv_num; i++) {
-			if (adapter->priv[i]) {
-				ret = mwifiex_sta_init_cmd(adapter->priv[i],
-							   first_sta, true);
-				if (ret == -1)
-					return -1;
-
-				first_sta = false;
-			}
-
-
+			ret = mwifiex_sta_init_cmd(adapter->priv[i],
+						   first_sta, true);
+			if (ret == -1)
+				return -1;
 
+			first_sta = false;
 		}
 	}
 
@@ -637,13 +624,11 @@ mwifiex_shutdown_drv(struct mwifiex_adapter *adapter)
 
 	/* Clean up Tx/Rx queues and delete BSS priority table */
 	for (i = 0; i < adapter->priv_num; i++) {
-		if (adapter->priv[i]) {
-			priv = adapter->priv[i];
+		priv = adapter->priv[i];
 
-			mwifiex_clean_auto_tdls(priv);
-			mwifiex_abort_cac(priv);
-			mwifiex_free_priv(priv);
-		}
+		mwifiex_clean_auto_tdls(priv);
+		mwifiex_abort_cac(priv);
+		mwifiex_free_priv(priv);
 	}
 
 	atomic_set(&adapter->tx_queued, 0);
diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wireless/marvell/mwifiex/join.c
index 249210fb2e753..6d8f1d1d7ca4e 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -1582,8 +1582,7 @@ void mwifiex_deauthenticate_all(struct mwifiex_adapter *adapter)
 
 	for (i = 0; i < adapter->priv_num; i++) {
 		priv = adapter->priv[i];
-		if (priv)
-			mwifiex_deauthenticate(priv, NULL);
+		mwifiex_deauthenticate(priv, NULL);
 	}
 }
 EXPORT_SYMBOL_GPL(mwifiex_deauthenticate_all);
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 88cd2d6a1dcb7..96d1f6039fbca 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -127,10 +127,8 @@ static int mwifiex_unregister(struct mwifiex_adapter *adapter)
 
 	/* Free private structures */
 	for (i = 0; i < adapter->priv_num; i++) {
-		if (adapter->priv[i]) {
-			mwifiex_free_curr_bcn(adapter->priv[i]);
-			kfree(adapter->priv[i]);
-		}
+		mwifiex_free_curr_bcn(adapter->priv[i]);
+		kfree(adapter->priv[i]);
 	}
 
 	if (adapter->nd_info) {
@@ -1171,7 +1169,7 @@ void mwifiex_drv_info_dump(struct mwifiex_adapter *adapter)
 	}
 
 	for (i = 0; i < adapter->priv_num; i++) {
-		if (!adapter->priv[i] || !adapter->priv[i]->netdev)
+		if (!adapter->priv[i]->netdev)
 			continue;
 		priv = adapter->priv[i];
 		p += sprintf(p, "\n[interface  : \"%s\"]\n",
@@ -1210,7 +1208,7 @@ void mwifiex_drv_info_dump(struct mwifiex_adapter *adapter)
 	debug_info = kzalloc(sizeof(*debug_info), GFP_KERNEL);
 	if (debug_info) {
 		for (i = 0; i < adapter->priv_num; i++) {
-			if (!adapter->priv[i] || !adapter->priv[i]->netdev)
+			if (!adapter->priv[i]->netdev)
 				continue;
 			priv = adapter->priv[i];
 			mwifiex_get_debug_info(priv, debug_info);
@@ -1472,7 +1470,7 @@ static void mwifiex_uninit_sw(struct mwifiex_adapter *adapter)
 	/* Stop data */
 	for (i = 0; i < adapter->priv_num; i++) {
 		priv = adapter->priv[i];
-		if (priv && priv->netdev) {
+		if (priv->netdev) {
 			mwifiex_stop_net_dev_queue(priv->netdev, adapter);
 			if (netif_carrier_ok(priv->netdev))
 				netif_carrier_off(priv->netdev);
@@ -1497,8 +1495,6 @@ static void mwifiex_uninit_sw(struct mwifiex_adapter *adapter)
 
 	for (i = 0; i < adapter->priv_num; i++) {
 		priv = adapter->priv[i];
-		if (!priv)
-			continue;
 		rtnl_lock();
 		if (priv->netdev &&
 		    priv->wdev.iftype != NL80211_IFTYPE_UNSPECIFIED) {
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 9024bb944e6aa..529863edd7a25 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1303,14 +1303,12 @@ mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter,
 	int i;
 
 	for (i = 0; i < adapter->priv_num; i++) {
-		if (adapter->priv[i]) {
-			if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
-				continue;
+		if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
+			continue;
 
-			if ((adapter->priv[i]->bss_num == bss_num) &&
-			    (adapter->priv[i]->bss_type == bss_type))
-				break;
-		}
+		if ((adapter->priv[i]->bss_num == bss_num) &&
+		    (adapter->priv[i]->bss_type == bss_type))
+			break;
 	}
 	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
 }
@@ -1326,11 +1324,9 @@ mwifiex_get_priv(struct mwifiex_adapter *adapter,
 	int i;
 
 	for (i = 0; i < adapter->priv_num; i++) {
-		if (adapter->priv[i]) {
-			if (bss_role == MWIFIEX_BSS_ROLE_ANY ||
-			    GET_BSS_ROLE(adapter->priv[i]) == bss_role)
-				break;
-		}
+		if (bss_role == MWIFIEX_BSS_ROLE_ANY ||
+		    GET_BSS_ROLE(adapter->priv[i]) == bss_role)
+			break;
 	}
 
 	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
@@ -1348,12 +1344,10 @@ mwifiex_get_unused_bss_num(struct mwifiex_adapter *adapter, u8 bss_type)
 
 	memset(index, 0, sizeof(index));
 	for (i = 0; i < adapter->priv_num; i++)
-		if (adapter->priv[i]) {
-			if (adapter->priv[i]->bss_type == bss_type &&
-			    !(adapter->priv[i]->bss_mode ==
-			      NL80211_IFTYPE_UNSPECIFIED)) {
-				index[adapter->priv[i]->bss_num] = 1;
-			}
+		if (adapter->priv[i]->bss_type == bss_type &&
+		    !(adapter->priv[i]->bss_mode ==
+		      NL80211_IFTYPE_UNSPECIFIED)) {
+			index[adapter->priv[i]->bss_num] = 1;
 		}
 	for (j = 0; j < MWIFIEX_MAX_BSS_NUM; j++)
 		if (!index[j])
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index e782d652cb933..010e6ff91457f 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2051,8 +2051,6 @@ void mwifiex_cancel_scan(struct mwifiex_adapter *adapter)
 		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 		for (i = 0; i < adapter->priv_num; i++) {
 			priv = adapter->priv[i];
-			if (!priv)
-				continue;
 			if (priv->scan_request) {
 				struct cfg80211_scan_info info = {
 					.aborted = true,
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index a94659988a4ce..d3cba6895f8ce 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -503,8 +503,7 @@ int mwifiex_enable_hs(struct mwifiex_adapter *adapter)
 	if (disconnect_on_suspend) {
 		for (i = 0; i < adapter->priv_num; i++) {
 			priv = adapter->priv[i];
-			if (priv)
-				mwifiex_deauthenticate(priv, NULL);
+			mwifiex_deauthenticate(priv, NULL);
 		}
 	}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index 515e6db410f28..6085cd50970d4 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -745,8 +745,6 @@ static void mwifiex_usb_port_resync(struct mwifiex_adapter *adapter)
 	if (adapter->usb_mc_status) {
 		for (i = 0; i < adapter->priv_num; i++) {
 			priv = adapter->priv[i];
-			if (!priv)
-				continue;
 			if ((priv->bss_role == MWIFIEX_BSS_ROLE_UAP &&
 			     !priv->bss_started) ||
 			    (priv->bss_role == MWIFIEX_BSS_ROLE_STA &&
@@ -758,8 +756,6 @@ static void mwifiex_usb_port_resync(struct mwifiex_adapter *adapter)
 	} else {
 		for (i = 0; i < adapter->priv_num; i++) {
 			priv = adapter->priv[i];
-			if (!priv)
-				continue;
 			if ((priv->bss_role == MWIFIEX_BSS_ROLE_UAP &&
 			     priv->bss_started) ||
 			    (priv->bss_role == MWIFIEX_BSS_ROLE_STA &&
@@ -770,8 +766,7 @@ static void mwifiex_usb_port_resync(struct mwifiex_adapter *adapter)
 		}
 		for (i = 0; i < adapter->priv_num; i++) {
 			priv = adapter->priv[i];
-			if (priv)
-				priv->usb_port = active_port;
+			priv->usb_port = active_port;
 		}
 		for (i = 0; i < MWIFIEX_TX_DATA_PORT; i++) {
 			if (active_port == card->port[i].tx_data_ep)
diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index 8558995e8fc73..bcb61dab7dc86 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -454,8 +454,6 @@ int mwifiex_bypass_txlist_empty(struct mwifiex_adapter *adapter)
 
 	for (i = 0; i < adapter->priv_num; i++) {
 		priv = adapter->priv[i];
-		if (!priv)
-			continue;
 		if (adapter->if_ops.is_port_ready &&
 		    !adapter->if_ops.is_port_ready(priv))
 			continue;
@@ -477,8 +475,6 @@ mwifiex_wmm_lists_empty(struct mwifiex_adapter *adapter)
 
 	for (i = 0; i < adapter->priv_num; ++i) {
 		priv = adapter->priv[i];
-		if (!priv)
-			continue;
 		if (!priv->port_open &&
 		    (priv->bss_mode != NL80211_IFTYPE_ADHOC))
 			continue;
@@ -1491,9 +1487,6 @@ void mwifiex_process_bypass_tx(struct mwifiex_adapter *adapter)
 	for (i = 0; i < adapter->priv_num; ++i) {
 		priv = adapter->priv[i];
 
-		if (!priv)
-			continue;
-
 		if (adapter->if_ops.is_port_ready &&
 		    !adapter->if_ops.is_port_ready(priv))
 			continue;

---
base-commit: ae98f5c9fd8ba84cd408b41faa77e65bf1b4cdfa
change-id: 20240816-mwifiex-remove-priv-checks-aa0ef96be349

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


