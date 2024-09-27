Return-Path: <linux-wireless+bounces-13254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E89880DB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 10:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925321F211FF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 08:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B064318A6AD;
	Fri, 27 Sep 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="US3NFJvO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3418A6CA
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427035; cv=none; b=c9K4llu5cog6QEp5fjYuHA3lCL0iJjPx8Xb7U7SYmvBqyX06iLQ6NnVYSeOph2hApHUkm2k0ZBHMm3BeTNAAczoLSHp3W3kxROaGxQBMqikmaYyRe+4CYCI2xuNN4GkQTNPKG8gDCXyoe6y8soETuctezfNJQ2krDveByiCbvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427035; c=relaxed/simple;
	bh=e09RDBS7PUQb9mCOvUrdJXMGThABwS9YFsmkLZJPBng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fB4powQEryt3cqwrAEzTOwzLNtK+cOQl017C5OV0eFulmjTdzKxA5OIBnAYi4TNHr5q0rL3LTeajNtlLtYNoX6esuxax8ZfcuWgqquWXyYDyoU2sgtJ0Xw56DSN7gglTjshbHv7MYZCQ38cn8jBzF+5mgA4l0rYIc5Vp/T+jUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=US3NFJvO; arc=none smtp.client-ip=178.154.239.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward203a.mail.yandex.net (Yandex) with ESMTPS id A5CB861195
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 11:44:34 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:6a2:0:640:8042:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 052FA47234;
	Fri, 27 Sep 2024 11:44:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PiRcldGOpCg0-KVhjKKYe;
	Fri, 27 Sep 2024 11:44:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1727426666; bh=zSKi1AnzASVgBVxtpNr5G9fqLSavMuXwrCOQUc3Wg58=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=US3NFJvOF1fu89k4Jw6RH2onqKEXO8v5QdIpcqkZYLYgLX9X+cUwqDvJKa/zVJrP5
	 uDN6/kUC+BraoBasPO8j6OMfja8VrWL6DR9esMeqqRZg9uhJCnK+6BfwY6Jcc/wEfu
	 ryINHErAb6SDVPRuUGYRjr6TVZ1cpwmaWXOI58eM=
Authentication-Results: mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Brian Norris <briannorris@chromium.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: mwifiex: cleanup struct mwifiex_private
Date: Fri, 27 Sep 2024 11:43:17 +0300
Message-ID: <20240927084317.96687-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240927084317.96687-1-dmantipov@yandex.ru>
References: <20240927084317.96687-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

Remove set but otherwise unused 'adhoc_is_link_sensed' and
'assoc_resp_ht_param' members of 'struct mwifiex_private' and
simplify related code in 'mwifiex_ret_802_11_associate()'.
Compile tested only.

Fixes: 28bf8312a983 ("mwifiex: get_channel from firmware")
Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/join.c      | 11 ++---------
 drivers/net/wireless/marvell/mwifiex/main.h      |  2 --
 drivers/net/wireless/marvell/mwifiex/sta_event.c |  6 +-----
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c |  2 --
 4 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wireless/marvell/mwifiex/join.c
index 6d8f1d1d7ca4..5a1a0287c1d5 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -663,7 +663,6 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
 	bool enable_data = true;
 	u16 cap_info, status_code, aid;
 	const u8 *ie_ptr;
-	struct ieee80211_ht_operation *assoc_resp_ht_oper;
 
 	if (!priv->attempted_bss_desc) {
 		mwifiex_dbg(priv->adapter, ERROR,
@@ -779,14 +778,8 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
 	ie_ptr = cfg80211_find_ie(WLAN_EID_HT_OPERATION, assoc_rsp->ie_buffer,
 				  priv->assoc_rsp_size
 				  - sizeof(struct ieee_types_assoc_rsp));
-	if (ie_ptr) {
-		assoc_resp_ht_oper = (struct ieee80211_ht_operation *)(ie_ptr
-					+ sizeof(struct ieee_types_header));
-		priv->assoc_resp_ht_param = assoc_resp_ht_oper->ht_param;
-		priv->ht_param_present = true;
-	} else {
-		priv->ht_param_present = false;
-	}
+
+	priv->ht_param_present = ie_ptr ? true : false;
 
 	mwifiex_dbg(priv->adapter, INFO,
 		    "info: ASSOC_RESP: curr_pkt_filter is %#x\n",
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 92a1cab6e750..e959906872b8 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -574,7 +574,6 @@ struct mwifiex_private {
 	u16 listen_interval;
 	u16 atim_window;
 	u8 adhoc_channel;
-	u8 adhoc_is_link_sensed;
 	u8 adhoc_state;
 	struct mwifiex_802_11_security sec_info;
 	struct mwifiex_wep_key wep_key[NUM_WEP_KEYS];
@@ -683,7 +682,6 @@ struct mwifiex_private {
 	struct mwifiex_ds_mem_rw mem_rw;
 	struct sk_buff_head bypass_txq;
 	struct mwifiex_user_scan_chan hidden_chan[MWIFIEX_USER_SCAN_CHAN_MAX];
-	u8 assoc_resp_ht_param;
 	bool ht_param_present;
 };
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index b5f3821a6a8f..400348abeee5 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -177,17 +177,14 @@ void mwifiex_reset_connect_state(struct mwifiex_private *priv, u16 reason_code,
 	priv->is_data_rate_auto = true;
 	priv->data_rate = 0;
 
-	priv->assoc_resp_ht_param = 0;
 	priv->ht_param_present = false;
 
 	if ((GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_STA ||
 	     GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) && priv->hist_data)
 		mwifiex_hist_data_reset(priv);
 
-	if (priv->bss_mode == NL80211_IFTYPE_ADHOC) {
+	if (priv->bss_mode == NL80211_IFTYPE_ADHOC)
 		priv->adhoc_state = ADHOC_IDLE;
-		priv->adhoc_is_link_sensed = false;
-	}
 
 	/*
 	 * Memorize the previous SSID and BSSID so
@@ -843,7 +840,6 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 
 	case EVENT_ADHOC_BCN_LOST:
 		mwifiex_dbg(adapter, EVENT, "event: ADHOC_BCN_LOST\n");
-		priv->adhoc_is_link_sensed = false;
 		mwifiex_clean_txrx(priv);
 		mwifiex_stop_net_dev_queue(priv->netdev, adapter);
 		if (netif_carrier_ok(priv->netdev))
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index d3cba6895f8c..e06a0622973e 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -351,8 +351,6 @@ int mwifiex_bss_start(struct mwifiex_private *priv, struct cfg80211_bss *bss,
 			goto done;
 		}
 
-		priv->adhoc_is_link_sensed = false;
-
 		ret = mwifiex_check_network_compatibility(priv, bss_desc);
 
 		mwifiex_stop_net_dev_queue(priv->netdev, adapter);
-- 
2.46.1


