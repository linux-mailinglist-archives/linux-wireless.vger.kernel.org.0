Return-Path: <linux-wireless+bounces-29582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C8ECABF9C
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 04:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5A153016366
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 03:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1FC23D7FB;
	Mon,  8 Dec 2025 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="gLjKHR1I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2072F7478
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765165230; cv=none; b=B4cSbWQFi+x7/eri6r8maeJseyZviO5gxJsRAUo4nvjxnnT/EAVbGimTTFBiY1snC5D2P4pZbzF5MLF3Tc7zpayhPGBkn6SLh6ldVbxYgWqtWGMSqKMRkQUeu1Vmlt7UqK5YG4J/KjIR91SL9Z2bgEbRCcv+VGg9O6nkO9lYrWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765165230; c=relaxed/simple;
	bh=lvR5e8hNOFbPA0oYVaXsHBRSnckNiMsN9aJZl1jKRHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jtKrLn99+kIWggCCM2fafOT768xf86i/ZU73fNNXRIRd/WMi2ChFOU9Tb1OM1MglJHg6S/fqNINuTIV946aAiG8y8TU+F9tOnjYDpMzQ5vPK5jvFc02Gn2SCxv98V4YQtyhlCcno8WWOt3wjNvb+EolLYgjzxq2SeuvH2V2MEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=gLjKHR1I; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-295548467c7so52663315ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 07 Dec 2025 19:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1765165228; x=1765770028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN8SZn+ebwGxVjiaVLUiFPeydXCGzxXLnFhoKiygDyY=;
        b=gLjKHR1InFs3PzW66Can2066fj5jwZimdg7G/H5DiOEG3K6QHPX0VK7RTvQnLSXx5T
         tdgxY/OhmNo260IAqyhrNovo0Tc+5iv8KnJ3Tlm8MeODbadTdRwEUQKhuDbpogE7XeOQ
         NfSYFL9V9PbO8w2IzeFVlqYR9VkmyaaRMDNvOSnxRyJaBGGuT+pm/g7vulrv50reYt5J
         g0BuQCVqbqOGIytEyL7d3uhDJM4Xh1Q/Ws9SWYlnLYNFNIUwr4vGQ6geltGkP2RtiOAa
         H5ShNR5j7yCDi4IzuYN9tRCorI6OlC3wsYarldCB5oVIqyFU4aoLBHxhR1DdNKv/b9+l
         4k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765165228; x=1765770028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pN8SZn+ebwGxVjiaVLUiFPeydXCGzxXLnFhoKiygDyY=;
        b=qGfmKCQ8CXfsUhxXjqFDPabF5AhQltZ/y1tXwA6d+zzo8ZiAgPPUzOjORhFjD0NLHA
         oOe/msJTjuizv6MqQlYuTMj2PFseenWP7aphzeY/vS7UNMcsPE/z6U02XWXRYwoJbVOk
         1Mh5HbIuK8meioAoUW1w4xAqwMQqaHJhZAdnLN+w+o2jTIXE2wslPBJWy9p8m8a7rIaM
         BYrmbjlBx/lk4uzvG2BKdMlIQQ58o39BTtnIg8jkAbxF5TRGl23SKzbL6t40/j2xdFg6
         3sJgL0Er3RVCPWNu38jACwcuRWNbki2xUXIVMPJjOS/BVpvNTORvjwcD3nCHxZ9VkiPi
         KOEw==
X-Gm-Message-State: AOJu0Yxgy4Iv1z/4IY2IVfDoZDoRUb6PZuwhYwLFeiXVFVK7RlAL9W2x
	ccwPg3KXYK+kVHq08JqEk1A1IbY8rIKCpj5o4ceq3SqvqQfrGueFwryJtVEk7O8uvw==
X-Gm-Gg: ASbGncu/Ow6HRzw7wfLvTnmQPfm4fho0Yk9s1T6Yd8Lj3QnAOq/qUDzqz+3C0SNttH3
	GBmsfurPWFCeiGnDuiDlRq5ZpSZDilkHeNLerwVTjNPCRYwcO9b08iQD6zct4P9L9HIkJUiUKm4
	K397Ys9xrajDL59nU7UXC106aEAm9OUOTobocdWRYMdCwHvA2S0jsF0Z8xqHox1ivauvd3vm2/A
	d2bElYWfAOIxvk91i3ppYDX7yD4lM8GK4tiCywf56I/JNgPzZwfHIxAiXmvB9gsIhc6jKvxwDu/
	FLBHRm0RH666hAU23qSzn2bxib+b+ABlqtx+NE4WTLrwzkk12Eq+kSDyAuRliLtNLnDYa2Qk6CM
	8USnM6NoPSv2Tpug8LbXxAOUIvyCH1veT176VTJSCcf2sjaGI+T3adueQllahjYOab9Swlr0or2
	SjJnHZybsN8ai6n5rJII8BSTk/
X-Google-Smtp-Source: AGHT+IF/mz04XdRhlLtOohmrmCjGjOKs0Eydrvv2veuvD/Hdx5uJsZvud+9EwU9DjjH5bREM0L81WQ==
X-Received: by 2002:a17:90b:520f:b0:340:bde5:c9e3 with SMTP id 98e67ed59e1d1-349a259a06cmr5734500a91.23.1765165228243;
        Sun, 07 Dec 2025 19:40:28 -0800 (PST)
Received: from 1207.mumbai.mm.lcl ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494ea899desm10383209a91.17.2025.12.07.19.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 19:40:27 -0800 (PST)
From: Ria Thomas <ria.thomas@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	lachlan.hodges@morsemicro.com,
	pradeep.reddy@morsemicro.com,
	simon@morsemicro.com,
	arien.judge@morsemicro.com,
	Ria Thomas <ria.thomas@morsemicro.com>
Subject: [PATCH wireless-next 3/3] wifi: mac80211: add support for NDP ADDBA/DELBA for S1G
Date: Mon,  8 Dec 2025 09:09:39 +0530
Message-Id: <20251208033939.3005700-4-ria.thomas@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251208033939.3005700-1-ria.thomas@morsemicro.com>
References: <20251208033939.3005700-1-ria.thomas@morsemicro.com>
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
index 8aa7640bb49f..efe9af471ea5 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2871,6 +2871,9 @@ struct ieee80211_txq {
  *	HW flag so drivers can opt in according to their own control, e.g. in
  *	testing.
  *
+ * @IEEE80211_HW_SUPPORTS_NDP_BLOCKACK: HW can transmit/receive S1G NDP
+ *	BlockAck frames.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2931,6 +2934,7 @@ enum ieee80211_hw_flags {
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


