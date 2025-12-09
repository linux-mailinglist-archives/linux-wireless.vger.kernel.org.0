Return-Path: <linux-wireless+bounces-29619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E83CAF04A
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 07:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49E5A300E919
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 06:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B2C79DA;
	Tue,  9 Dec 2025 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="FEl+zai8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351EE1A76BB
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 06:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765261529; cv=none; b=ggyQVni1GMdirbFMbFY8i8+tnMqrGrJ5rsg2x2Q7eKplm7vyL+XUwcf+heMDV5Up88yRVmJeuM5oqxrQbU5zuXf3mw9q58vSSZjsAbbp7yVIXMgSkWf5I3+9S/6KIjo2FLXb8b3QEOhXnZI+4KpOckaRKOd8kJmZ0oErY2gRpOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765261529; c=relaxed/simple;
	bh=oUJ186T0igtsHT7qRr//gHXyT36apFYknprer8UqzPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6Em3eMRmxwln9yztscPhcdwkKPT+xelKSYhqsPOGBTW/G3cf1mZiYdvSZhHdAAHUbXKD9iSmwd/W94mMTU/Oep0rame8ERz7xZXfqZ0dm9uxU3b1GzGr1lc6CullPty/8rIOyS10VlsLw6P0xE1Pr4Wbibf/wydBtOjneiawG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=FEl+zai8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso4654263b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 22:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1765261526; x=1765866326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLVOg6T+xy4MBPCx8+ebQLT5tXD/AqfWIwP1xAE6jNM=;
        b=FEl+zai8Ifj4ZRcRGqRw3fDT/qgvLSZRLKlpc8F9vewlCYU9e/mv+55Ejkb56eAeit
         DZarOsjep2BSZF+DtHxeEHiL12Evd6PBthZKFbJzyb2zEqUTC4vq8EsoySyzaZEi2PHZ
         DDIX6L1MCvacg2+5JaRQDR3yLSEMgPkBn3NgoXSn0UFC7/A4vxFLXJQJjIU96ybNNNfS
         NR8bLEL6bBqj5G54Td8CpNxS64Daw4mtiuYZcdDN+9+0Oz4wtm4tG2BE1eIV+Vd3FJnf
         kqcrZDA4PxPS8CdhxYEJjgL4BsuH61wpF1iAsRQuH+vAJ5VKw/rdPLSFi0NB9OgziP07
         b5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765261526; x=1765866326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLVOg6T+xy4MBPCx8+ebQLT5tXD/AqfWIwP1xAE6jNM=;
        b=w8NPs65qpaOMF8dJ6OM/xNcMQXqA2csF3ishup7G/POJ2KQBYgNysxYqcBXaiNPNtU
         Plz/ZCl5G/lz8v3PYK8sYPaG0s+L+njnX9PyC7dEEF89Pr8NBkArSGqh2q0H1t/n9L8p
         KaKyZpSTHPzwTxVe3N1b2i1nEFtweh8sXn1WfQ2sSzxBmWpmW/AnW+KU2VYfT9OCk/x1
         BB62JheBL/k2buAMhf5eXj3Tr7qlVsaxDZk0e29YfZEDKFjf3G8lW9Wy1Md01R4NTXIt
         jcsLqM232nJMyDkxjb7qoxg8qqjfz/QGfKvtHiS65xitQy3p7oITQeoGLUcA6EwTLuCZ
         knRw==
X-Gm-Message-State: AOJu0YyxagCN2IaLNw+Rh694ujOnt9xyM2W+lrBiHy490LvQrCRCYMgj
	V/rBjPGwtmGEhZJ/RKowK8vHQ80xlmXQD2FX9/h1dyZMQIvr+keU4hu/7io/zdesYw==
X-Gm-Gg: ASbGnctwrBH5P+yi5NrVAdS67d55BRxew8owvuOU10u9YpxQ/D4RZJkxMbdJ8PkymEE
	7HQ0qRsLAattIW9s4hICck6Q1/kNutw8HblwXP7Bg8IIH8FF9c6qoQrgoEVistJvG8jaD/gKnY6
	lL2xpZrrwzLCp8KsjR9cmkHLYkIkWyzzr8ti20FJZ4idFUmw0s6S9WWgDKtoD1dpsglYfUhsltB
	i4SIPJvBob1ne/iQRL7fqHi6wTB/D4oMID6nIIvsfObg3RcNQ6HEPRzNDhYLuCOwzhSL6STAZyt
	6x417RTCfR/VlFev1B+esx7Em2xK2VMvXXZNkSKJ5RD1NA5Csr9nRXn5qD8Zkwj4JbC7sSq8Jhx
	IS7233cZadO0js/EmyYfccmWcgQX36R+e81vm20FnPo8S73/QXzPmofyVAa9ikfdtGJGjiWcs8Q
	5hXMEvD8G38pdEzZ7blgI9VIJ7
X-Google-Smtp-Source: AGHT+IEtcjbV3oze1jEIc+bipqnVl4JO1rEUqt6jUGxn4KXskFSpFxnHX82NRAW+rN+u115Iau3fGQ==
X-Received: by 2002:a05:6a00:3ccd:b0:7a5:67cc:c837 with SMTP id d2e1a72fcca58-7e8c2f6e8c3mr9664531b3a.18.1765261526353;
        Mon, 08 Dec 2025 22:25:26 -0800 (PST)
Received: from 1207.mumbai.mm.lcl ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2adc5c400sm14916187b3a.37.2025.12.08.22.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 22:25:25 -0800 (PST)
From: Ria Thomas <ria.thomas@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	lachlan.hodges@morsemicro.com,
	arien.judge@morsemicro.com,
	pradeep.reddy@morsemicro.com,
	simon@morsemicro.com,
	Ria Thomas <ria.thomas@morsemicro.com>
Subject: [PATCH wireless-next v2 3/3] wifi: mac80211: add support for NDP ADDBA/DELBA for S1G
Date: Tue,  9 Dec 2025 11:54:24 +0530
Message-Id: <20251209062424.3926297-4-ria.thomas@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
References: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S1G defines use of NDP Block Ack (BA) for aggregation, requiring negotiation
of NDP ADDBA/DELBA action frames. When an S1G STA supports HT-immediate BA,
it may reject legacy ADDBA requests, indicating preference for NDP Block Ack.

Introduce support for NDP ADDBA and DELBA exchange in mac80211. The
implementation negotiates the BA mechanism during setup based on station
capabilities and driver support (IEEE80211_HW_SUPPORTS_NDP_BLOCKACK).
If negotiation fails due to mismatched expectations, a rejection with status code
WLAN_STATUS_REJECTED_NDP_BLOCK_ACK_SUGGESTED is returned as per IEEE 802.11-2024.

The selected response indication (RI) is updated upon successful negotiation
and NDP preference is maintained throughout session setup, management and
teardown on both TX and RX paths

Signed-off-by: Ria Thomas <ria.thomas@morsemicro.com>
---
 include/linux/ieee80211-ht.h |  3 +++
 include/linux/ieee80211.h    |  2 ++
 include/net/mac80211.h       |  4 ++++
 net/mac80211/agg-rx.c        | 37 +++++++++++++++++++++++++++++++++---
 net/mac80211/agg-tx.c        | 22 +++++++++++++++++----
 net/mac80211/debugfs.c       |  1 +
 net/mac80211/ht.c            |  8 +++++---
 net/mac80211/ieee80211_i.h   |  9 ++++++++-
 net/mac80211/iface.c         |  3 +++
 net/mac80211/rx.c            | 11 +++++++++--
 net/mac80211/s1g.c           | 23 ++++++++++++++++++++++
 net/mac80211/sta_info.h      |  2 ++
 12 files changed, 112 insertions(+), 13 deletions(-)

diff --git a/include/linux/ieee80211-ht.h b/include/linux/ieee80211-ht.h
index 21bbf470540f..7612b72f9c7c 100644
--- a/include/linux/ieee80211-ht.h
+++ b/include/linux/ieee80211-ht.h
@@ -281,6 +281,9 @@ enum ieee80211_back_actioncode {
 	WLAN_ACTION_ADDBA_REQ = 0,
 	WLAN_ACTION_ADDBA_RESP = 1,
 	WLAN_ACTION_DELBA = 2,
+	WLAN_ACTION_NDP_ADDBA_REQ = 128,
+	WLAN_ACTION_NDP_ADDBA_RESP = 129,
+	WLAN_ACTION_NDP_DELBA = 130,
 };
 
 /* BACK (block-ack) parties */
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 96439de55f07..b6a1492cdb4d 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1492,6 +1492,8 @@ enum ieee80211_statuscode {
 	WLAN_STATUS_REJECT_DSE_BAND = 96,
 	WLAN_STATUS_DENIED_WITH_SUGGESTED_BAND_AND_CHANNEL = 99,
 	WLAN_STATUS_DENIED_DUE_TO_SPECTRUM_MANAGEMENT = 103,
+	/* 802.11ah */
+	WLAN_STATUS_REJECTED_NDP_BLOCK_ACK_SUGGESTED = 109,
 	/* 802.11ai */
 	WLAN_STATUS_FILS_AUTHENTICATION_FAILURE = 112,
 	WLAN_STATUS_UNKNOWN_AUTHENTICATION_SERVER = 113,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 89084ae46d26..51119eec4ca8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2874,6 +2874,9 @@ struct ieee80211_txq {
  *	HW flag so drivers can opt in according to their own control, e.g. in
  *	testing.
  *
+ * @IEEE80211_HW_SUPPORTS_NDP_BLOCKACK: HW can transmit/receive S1G NDP
+ *	BlockAck frames.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2934,6 +2937,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_DISALLOW_PUNCTURING,
 	IEEE80211_HW_HANDLES_QUIET_CSA,
 	IEEE80211_HW_STRICT,
+	IEEE80211_HW_SUPPORTS_NDP_BLOCKACK,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 7da909d78c68..65ae8bc1d96a 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -94,7 +94,8 @@ void __ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
 	/* check if this is a self generated aggregation halt */
 	if (initiator == WLAN_BACK_RECIPIENT && tx)
 		ieee80211_send_delba(sta->sdata, sta->sta.addr,
-				     tid, WLAN_BACK_RECIPIENT, reason);
+				     tid, WLAN_BACK_RECIPIENT, reason,
+				     ieee80211_s1g_use_ndp_ba(sta->sdata, sta));
 
 	/*
 	 * return here in case tid_rx is not assigned - which will happen if
@@ -240,6 +241,7 @@ static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *mgmt;
 	bool amsdu = ieee80211_hw_check(&local->hw, SUPPORTS_AMSDU_IN_AMPDU);
+	bool use_ndp = ieee80211_s1g_use_ndp_ba(sdata, sta);
 	u16 capab;
 
 	skb = dev_alloc_skb(sizeof(*mgmt) +
@@ -253,7 +255,8 @@ static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 
 	skb_put(skb, 1 + sizeof(mgmt->u.action.u.addba_resp));
 	mgmt->u.action.category = WLAN_CATEGORY_BACK;
-	mgmt->u.action.u.addba_resp.action_code = WLAN_ACTION_ADDBA_RESP;
+	mgmt->u.action.u.addba_resp.action_code = use_ndp ?
+		WLAN_ACTION_NDP_ADDBA_RESP : WLAN_ACTION_ADDBA_RESP;
 	mgmt->u.action.u.addba_resp.dialog_token = dialog_token;
 
 	capab = u16_encode_bits(amsdu, IEEE80211_ADDBA_PARAM_AMSDU_MASK);
@@ -275,6 +278,7 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 				     u8 dialog_token, u16 timeout,
 				     u16 start_seq_num, u16 ba_policy, u16 tid,
 				     u16 buf_size, bool tx, bool auto_seq,
+				     bool req_ndp,
 				     const u8 addba_ext_data)
 {
 	struct ieee80211_local *local = sta->sdata->local;
@@ -300,6 +304,18 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 		goto end;
 	}
 
+	if (tx && ieee80211_s1g_use_ndp_ba(sta->sdata, sta) && !req_ndp) {
+		/*
+		 * According to IEEE 802.11-2024: Inform S1G originator
+		 * ADDBA rejected as NDP BlockAck is preferred
+		 */
+		status = WLAN_STATUS_REJECTED_NDP_BLOCK_ACK_SUGGESTED;
+		ht_dbg(sta->sdata,
+		       "Rejecting AddBA Req from %pM tid %u - require NDP BlockAck\n",
+		       sta->sta.addr, tid);
+		goto end;
+	}
+
 	if (!sta->sta.valid_links &&
 	    !sta->sta.deflink.ht_cap.ht_supported &&
 	    !sta->sta.deflink.he_cap.has_he &&
@@ -457,6 +473,18 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 
 end:
 	if (status == WLAN_STATUS_SUCCESS) {
+		/*
+		 * Keep user-forced NO_RESPONSE; otherwise
+		 * track negotiated BA type
+		 */
+		if (sta->sdata->vif.bss_conf.s1g_ri !=
+		    IEEE80211_S1G_RI_NO_RESPONSE) {
+			u8 ri = req_ndp ? IEEE80211_S1G_RI_NDP_RESPONSE :
+				IEEE80211_S1G_RI_NORMAL_RESPONSE;
+
+			ieee80211_s1g_update_ri(sta->sdata,
+						&sta->sdata->deflink, ri);
+		}
 		__set_bit(tid, sta->ampdu_mlme.agg_session_valid);
 		__clear_bit(tid, sta->ampdu_mlme.unexpected_agg);
 		sta->ampdu_mlme.tid_rx_token[tid] = dialog_token;
@@ -473,6 +501,8 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 				     struct ieee80211_mgmt *mgmt,
 				     size_t len)
 {
+	bool req_ndp = mgmt->u.action.u.addba_req.action_code ==
+				WLAN_ACTION_NDP_ADDBA_REQ;
 	u16 capab, tid, timeout, ba_policy, buf_size, start_seq_num;
 	u8 dialog_token, addba_ext_data;
 
@@ -497,7 +527,8 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 
 	__ieee80211_start_rx_ba_session(sta, dialog_token, timeout,
 					start_seq_num, ba_policy, tid,
-					buf_size, true, false, addba_ext_data);
+					buf_size, true, false,
+					req_ndp, addba_ext_data);
 }
 
 void ieee80211_manage_rx_ba_offl(struct ieee80211_vif *vif,
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index d981b0fc57bf..17d9c047134d 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -60,7 +60,7 @@
 
 static void ieee80211_send_addba_request(struct sta_info *sta, u16 tid,
 					 u8 dialog_token, u16 start_seq_num,
-					 u16 agg_size, u16 timeout)
+					 u16 agg_size, u16 timeout, bool ndp)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
@@ -80,7 +80,8 @@ static void ieee80211_send_addba_request(struct sta_info *sta, u16 tid,
 	skb_put(skb, 1 + sizeof(mgmt->u.action.u.addba_req));
 
 	mgmt->u.action.category = WLAN_CATEGORY_BACK;
-	mgmt->u.action.u.addba_req.action_code = WLAN_ACTION_ADDBA_REQ;
+	mgmt->u.action.u.addba_req.action_code = ndp ?
+		WLAN_ACTION_NDP_ADDBA_REQ : WLAN_ACTION_ADDBA_REQ;
 
 	mgmt->u.action.u.addba_req.dialog_token = dialog_token;
 	capab = IEEE80211_ADDBA_PARAM_AMSDU_MASK;
@@ -484,7 +485,8 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 
 	/* send AddBA request */
 	ieee80211_send_addba_request(sta, tid, tid_tx->dialog_token,
-				     tid_tx->ssn, buf_size, tid_tx->timeout);
+				     tid_tx->ssn, buf_size, tid_tx->timeout,
+				     tid_tx->ndp);
 
 	WARN_ON(test_and_set_bit(HT_AGG_STATE_SENT_ADDBA, &tid_tx->state));
 }
@@ -521,6 +523,7 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 	 */
 	synchronize_net();
 
+	tid_tx->ndp = ieee80211_s1g_use_ndp_ba(sdata, sta);
 	params.ssn = sta->tid_seq[tid] >> 4;
 	ret = drv_ampdu_action(local, sdata, &params);
 	tid_tx->ssn = params.ssn;
@@ -940,7 +943,9 @@ void ieee80211_stop_tx_ba_cb(struct sta_info *sta, int tid,
 
 	if (send_delba)
 		ieee80211_send_delba(sdata, sta->sta.addr, tid,
-			WLAN_BACK_INITIATOR, WLAN_REASON_QSTA_NOT_USE);
+				     WLAN_BACK_INITIATOR,
+				     WLAN_REASON_QSTA_NOT_USE,
+				     tid_tx->ndp);
 }
 
 void ieee80211_stop_tx_ba_cb_irqsafe(struct ieee80211_vif *vif,
@@ -973,6 +978,8 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 {
 	struct tid_ampdu_tx *tid_tx;
 	struct ieee80211_txq *txq;
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct ieee80211_link_data *link = &sdata->deflink;
 	u16 capab, tid, buf_size;
 	bool amsdu;
 
@@ -1054,6 +1061,13 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 			tid_tx->last_tx = jiffies;
 		}
 
+		if (sdata->vif.bss_conf.s1g_ri !=
+		    IEEE80211_S1G_RI_NO_RESPONSE) {
+			u8 ri = tid_tx->ndp ? IEEE80211_S1G_RI_NDP_RESPONSE :
+					      IEEE80211_S1G_RI_NORMAL_RESPONSE;
+
+			ieee80211_s1g_update_ri(sdata, link, ri);
+		}
 	} else {
 		__ieee80211_stop_tx_ba_session(sta, tid, AGG_STOP_DECLINED);
 	}
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index d02f07368c51..e8d0a8b71d59 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -490,6 +490,7 @@ static const char *hw_flag_names[] = {
 	FLAG(DISALLOW_PUNCTURING),
 	FLAG(HANDLES_QUIET_CSA),
 	FLAG(STRICT),
+	FLAG(SUPPORTS_NDP_BLOCKACK),
 #undef FLAG
 };
 
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 1c82a28b03de..ac67bf55f983 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -379,7 +379,7 @@ void ieee80211_ba_session_work(struct wiphy *wiphy, struct wiphy_work *work)
 				       sta->ampdu_mlme.tid_rx_manage_offl))
 			__ieee80211_start_rx_ba_session(sta, 0, 0, 0, 1, tid,
 							IEEE80211_MAX_AMPDU_BUF_HT,
-							false, true, 0);
+							false, true, false, 0);
 
 		if (test_and_clear_bit(tid + IEEE80211_NUM_TIDS,
 				       sta->ampdu_mlme.tid_rx_manage_offl))
@@ -455,7 +455,8 @@ void ieee80211_ba_session_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 			  const u8 *da, u16 tid,
-			  u16 initiator, u16 reason_code)
+			  u16 initiator, u16 reason_code,
+			  bool use_ndp)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
@@ -472,7 +473,8 @@ void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 	skb_put(skb, 1 + sizeof(mgmt->u.action.u.delba));
 
 	mgmt->u.action.category = WLAN_CATEGORY_BACK;
-	mgmt->u.action.u.delba.action_code = WLAN_ACTION_DELBA;
+	mgmt->u.action.u.delba.action_code = use_ndp ?
+		WLAN_ACTION_NDP_DELBA : WLAN_ACTION_DELBA;
 	params = (u16)(initiator << 11); 	/* bit 11 initiator */
 	params |= (u16)(tid << 12); 		/* bit 15:12 TID number */
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9d9313eee59f..265b41d07243 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2185,7 +2185,8 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 				       struct link_sta_info *link_sta);
 void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 			  const u8 *da, u16 tid,
-			  u16 initiator, u16 reason_code);
+			  u16 initiator, u16 reason_code,
+			  bool use_ndp);
 int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 			       enum ieee80211_smps_mode smps, const u8 *da,
 			       const u8 *bssid, int link_id);
@@ -2201,6 +2202,7 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 				     u8 dialog_token, u16 timeout,
 				     u16 start_seq_num, u16 ba_policy, u16 tid,
 				     u16 buf_size, bool tx, bool auto_seq,
+				     bool req_ndp,
 				     const u8 addba_ext_data);
 void ieee80211_sta_tear_down_BA_sessions(struct sta_info *sta,
 					 enum ieee80211_agg_stop_reason reason);
@@ -2326,6 +2328,11 @@ void ieee80211_s1g_status_twt_action(struct ieee80211_sub_if_data *sdata,
 void ieee80211_s1g_cap_to_sta_s1g_cap(struct ieee80211_sub_if_data *sdata,
 				      const struct ieee80211_s1g_cap *s1g_cap_ie,
 				      struct link_sta_info *link_sta);
+bool ieee80211_s1g_use_ndp_ba(const struct ieee80211_sub_if_data *sdata,
+			      const struct sta_info *sta);
+void ieee80211_s1g_update_ri(struct ieee80211_sub_if_data *sdata,
+			     struct ieee80211_link_data *link,
+			     enum ieee80211_s1g_ri ri);
 
 /* Spectrum management */
 void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 4f04d95c19d4..1ef11a8e742d 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1577,14 +1577,17 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 		if (sta) {
 			switch (mgmt->u.action.u.addba_req.action_code) {
 			case WLAN_ACTION_ADDBA_REQ:
+			case WLAN_ACTION_NDP_ADDBA_REQ:
 				ieee80211_process_addba_request(local, sta,
 								mgmt, len);
 				break;
 			case WLAN_ACTION_ADDBA_RESP:
+			case WLAN_ACTION_NDP_ADDBA_RESP:
 				ieee80211_process_addba_resp(local, sta,
 							     mgmt, len);
 				break;
 			case WLAN_ACTION_DELBA:
+			case WLAN_ACTION_NDP_DELBA:
 				ieee80211_process_delba(sdata, sta,
 							mgmt, len);
 				break;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6a1899512d07..d4607057b2e1 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1475,7 +1475,9 @@ static void ieee80211_rx_reorder_ampdu(struct ieee80211_rx_data *rx,
 		    !test_and_set_bit(tid, rx->sta->ampdu_mlme.unexpected_agg))
 			ieee80211_send_delba(rx->sdata, rx->sta->sta.addr, tid,
 					     WLAN_BACK_RECIPIENT,
-					     WLAN_REASON_QSTA_REQUIRE_SETUP);
+					     WLAN_REASON_QSTA_REQUIRE_SETUP,
+					     ieee80211_s1g_use_ndp_ba(rx->sdata,
+								      rx->sta));
 		goto dont_reorder;
 	}
 
@@ -3364,7 +3366,9 @@ ieee80211_rx_h_ctrl(struct ieee80211_rx_data *rx, struct sk_buff_head *frames)
 		    !test_and_set_bit(tid, rx->sta->ampdu_mlme.unexpected_agg))
 			ieee80211_send_delba(rx->sdata, rx->sta->sta.addr, tid,
 					     WLAN_BACK_RECIPIENT,
-					     WLAN_REASON_QSTA_REQUIRE_SETUP);
+					     WLAN_REASON_QSTA_REQUIRE_SETUP,
+					     ieee80211_s1g_use_ndp_ba(rx->sdata,
+								      rx->sta));
 
 		tid_agg_rx = rcu_dereference(rx->sta->ampdu_mlme.tid_rx[tid]);
 		if (!tid_agg_rx)
@@ -3743,16 +3747,19 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 
 		switch (mgmt->u.action.u.addba_req.action_code) {
 		case WLAN_ACTION_ADDBA_REQ:
+		case WLAN_ACTION_NDP_ADDBA_REQ:
 			if (len < (IEEE80211_MIN_ACTION_SIZE +
 				   sizeof(mgmt->u.action.u.addba_req)))
 				goto invalid;
 			break;
 		case WLAN_ACTION_ADDBA_RESP:
+		case WLAN_ACTION_NDP_ADDBA_RESP:
 			if (len < (IEEE80211_MIN_ACTION_SIZE +
 				   sizeof(mgmt->u.action.u.addba_resp)))
 				goto invalid;
 			break;
 		case WLAN_ACTION_DELBA:
+		case WLAN_ACTION_NDP_DELBA:
 			if (len < (IEEE80211_MIN_ACTION_SIZE +
 				   sizeof(mgmt->u.action.u.delba)))
 				goto invalid;
diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
index 1f68df6e8067..fa26322d979a 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -220,3 +220,26 @@ void ieee80211_s1g_cap_to_sta_s1g_cap(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_sta_recalc_aggregates(&link_sta->sta->sta);
 }
+
+bool ieee80211_s1g_use_ndp_ba(const struct ieee80211_sub_if_data *sdata,
+			      const struct sta_info *sta)
+{
+	if (!sdata->vif.cfg.s1g ||
+	    !ieee80211_hw_check(&sdata->local->hw, SUPPORTS_NDP_BLOCKACK))
+		return false;
+
+	return sdata->vif.bss_conf.s1g_ri == IEEE80211_S1G_RI_NDP_RESPONSE ||
+		(sta && sta->sta.deflink.s1g_cap.s1g);
+}
+
+void ieee80211_s1g_update_ri(struct ieee80211_sub_if_data *sdata,
+			     struct ieee80211_link_data *link,
+			     enum ieee80211_s1g_ri ri)
+{
+	if (!sdata->vif.cfg.s1g ||
+	    sdata->vif.bss_conf.s1g_ri == ri)
+		return;
+
+	sdata->vif.bss_conf.s1g_ri = ri;
+	ieee80211_link_info_change_notify(sdata, link, BSS_CHANGED_S1G_RI);
+}
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 5288d5286651..870fbf4baba6 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -171,6 +171,7 @@ struct sta_info;
  * @bar_pending: BAR needs to be re-sent
  * @amsdu: support A-MSDU within A-MDPU
  * @ssn: starting sequence number of the session
+ * @ndp: this session is using NDP Block ACKs
  *
  * This structure's lifetime is managed by RCU, assignments to
  * the array holding it must hold the aggregation mutex.
@@ -199,6 +200,7 @@ struct tid_ampdu_tx {
 	u16 failed_bar_ssn;
 	bool bar_pending;
 	bool amsdu;
+	bool ndp;
 	u8 tid;
 };
 
-- 
2.25.1


