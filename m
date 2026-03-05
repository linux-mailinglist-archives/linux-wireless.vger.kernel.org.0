Return-Path: <linux-wireless+bounces-32500-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAqXC4ZKqWn+3wAAu9opvQ
	(envelope-from <linux-wireless+bounces-32500-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 10:19:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7529220E32A
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 10:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E7730B2DD5
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A864E3783AD;
	Thu,  5 Mar 2026 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="qCIsREfq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920AF374E79
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702026; cv=none; b=d33lZ7AIs0VKDnWnui344ND7Vz/N3r+4KiPrLt2N6HmY+F1EEvbncygFxOIPXhjCxGlB7ajCFqBpfvia92vJq/nQzH4aSvIN+lPPDHI9XxXmEHdumGofV4WiuFS6Rem1YepkVKeoAtn4QKJSHnEw2p/Djcsl1oG5UbkHge9yC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702026; c=relaxed/simple;
	bh=0hrt+sLs28+fg8Ozvvv4d15sjIgef5F9lbZ7JYKR4ak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KHB2UUC523paIps8YNLA+GjnIXt9uMg375e754tKwrG0eAE7cCWOijznjX2tJhogfffjGZTlydh32kKco7ZedTj0Vj12nEz9QZgPUMaP/t56YnOEfonyZFLOlvIrMMhWFTgDFijQmFKTiCpqoCme7JC998VXdRjFgkMX970A0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=qCIsREfq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-827270d50d4so8211967b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 01:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772702024; x=1773306824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy643gsvRFtjtfMzRNVFNiw+rjdWexj6f5jFJXd9EyU=;
        b=qCIsREfqT/T5zao7uJzcXJatxLPHTz3RA+vLu+ViL4Ro+9FI1vdhc5dGuo4p2qDZQs
         WL8ZlFBPIzxO4GVHCcASsbbxdoT+uWozLn43ve/uacKfSsxSMKzOYIhEqyRV0Qf37PLO
         vlF5ufF6i+IQ+7GEq+aElJEh6geD8qrubgqPy/xNDCb5/a54AKL19cn5IabRfyiIgwwJ
         tLnot8fO5xMnPEWzwWOp0hvQ9l+biVuF9tVv1llfEtdPr55lTWmoVpJHJw9H1yBDaLXA
         YkWi3851p5lw+gkHW/JR2PcQWCKUj63MnoFPp4w9tPe6MiBA4YdQ7C3+clnq0A7O/MUb
         yTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702024; x=1773306824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy643gsvRFtjtfMzRNVFNiw+rjdWexj6f5jFJXd9EyU=;
        b=lMKM5zDHfekPQ7NKdO2hlPe//iyRt/zLjvW2yvjhoufxTVBiwYtPn/Sr0L9xvOLfbc
         tcJngTvk0HnUEqikvf8UhUXU9qPzvEi88o3i804b4H9ykyuvjFbWANXTVX98DRHUp0gL
         af7aLsv7fYuNupGt4wzbQK12KB/RQqfTaSf+9be3hm6Kkk0TnN9xKuF1sD9vIioJzTQQ
         Ufv0yxFYsAbS4U7HNN92HxXZAVP/LIer8IGc5VAcpKiGWa9qIfEaI2EYE8acVVnPzw6/
         PV/C2rnv/s2CAEwN3HEL8080oNqojUGHdZ3/5Stc7zBQL9Xj/s+LW+8h/xPivGtS8t5w
         DLMw==
X-Gm-Message-State: AOJu0YwCSGnpADjM4gTMVVivaZX7jD5g/A1b9+wvrZLnvKciKtHoCzED
	rRhkH8KBIen53BuGXNpQL3cYf4Mm5X9nbIhz9j3GoOUefpfWVZRzj07JCU9+oPjj6A==
X-Gm-Gg: ATEYQzyfcqKSJSgAKwSUf9qfSZ6QXHtbPLsurIRWnfGyie8CFetQMif5TeKXR+wl8hX
	6gDxIRmk8G8Nyo5yleL87X0b+phlafXYUfCviCjTAvQvPwpY1+k4Z5mVo50fHdrVfd0Eq9Vyuo5
	d1fFnQJ4gft53K7/vJBiEZdFuwCmTQNzE/Is8xUlt33iGL3suboFFf5MAh27vzOXc/8nRkqenVs
	g7fDudk/S1LHHlGcHicW+mQVHLx+mNhrYYTAhyV0qAUCa0SI4duqpQIbVkKo53vYlrMLs3iwbce
	hlcY0bZg1KwPrzL1ry5vplDbpE/pw/lVx1aQqcAOK600zI/lzth8f/JzRrk8cslm0c3T67Vgdc0
	SZGgMpPr8sS/BahgYRgjksaEGKzAnlXyACV07cD3snXMqQ45RetK/QUjmNNdWUHBdZ9H9D1R5Jf
	17G2Y4FDdYy6SPEb1NNelZe7JWBU2T6P5hq9Lw
X-Received: by 2002:a05:6a20:cc0b:b0:384:f573:42b9 with SMTP id adf61e73a8af0-3982e2b99dcmr4750594637.67.1772702023616;
        Thu, 05 Mar 2026 01:13:43 -0800 (PST)
Received: from 1207.mumbai.mm.lcl ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82c284sm18583937a12.23.2026.03.05.01.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:13:42 -0800 (PST)
From: Ria Thomas <ria.thomas@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	lachlan.hodges@morsemicro.com,
	arien.judge@morsemicro.com,
	pradeep.reddy@morsemicro.com,
	simon@morsemicro.com,
	Ria Thomas <ria.thomas@morsemicro.com>
Subject: [PATCH wireless-next] wifi: mac80211: add support for NDP ADDBA/DELBA for S1G
Date: Thu,  5 Mar 2026 14:43:04 +0530
Message-Id: <20260305091304.310990-1-ria.thomas@morsemicro.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7529220E32A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32500-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ria.thomas@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

S1G defines use of NDP Block Ack (BA) for aggregation, requiring negotiation
of NDP ADDBA/DELBA action frames. If the S1G recipient supports HT-immediate
block ack, the sender must send an NDP ADDBA Request indicating it expects
only NDP BlockAck frames for the agreement.

Introduce support for NDP ADDBA and DELBA exchange in mac80211. The
implementation negotiates the BA mechanism during setup based on station
capabilities and driver support (IEEE80211_HW_SUPPORTS_NDP_BLOCKACK).
If negotiation fails due to mismatched expectations, a rejection with status code
WLAN_STATUS_REJECTED_NDP_BLOCK_ACK_SUGGESTED is returned as per IEEE 802.11-2024.

Trace sample:

IEEE 802.11 Wireless Management
    Fixed parameters
        Category code: Block Ack (3)
        Action code: NDP ADDBA Request (0x80)
        Dialog token: 0x01
        Block Ack Parameters: 0x1003, A-MSDUs, Block Ack Policy
            .... .... .... ...1 = A-MSDUs: Permitted in QoS Data MPDUs
            .... .... .... ..1. = Block Ack Policy: Immediate Block Ack
            .... .... ..00 00.. = Traffic Identifier: 0x0
            0001 0000 00.. .... = Number of Buffers (1 Buffer = 2304 Bytes): 64
        Block Ack Timeout: 0x0000
        Block Ack Starting Sequence Control (SSC): 0x0010
            .... .... .... 0000 = Fragment: 0
            0000 0000 0001 .... = Starting Sequence Number: 1

IEEE 802.11 Wireless Management
    Fixed parameters
        Category code: Block Ack (3)
        Action code: NDP ADDBA Response (0x81)
        Dialog token: 0x02
        Status code: BlockAck negotiation refused because, due to buffer constraints and other unspecified reasons, the recipient prefers to generate only NDP BlockAck frames (0x006d)
        Block Ack Parameters: 0x1002, Block Ack Policy
            .... .... .... ...0 = A-MSDUs: Not Permitted
            .... .... .... ..1. = Block Ack Policy: Immediate Block Ack
            .... .... ..00 00.. = Traffic Identifier: 0x0
            0001 0000 00.. .... = Number of Buffers (1 Buffer = 2304 Bytes): 64
        Block Ack Timeout: 0x0000

Signed-off-by: Ria Thomas <ria.thomas@morsemicro.com>
---
 include/linux/ieee80211-ht.h |  3 +++
 include/linux/ieee80211.h    |  2 ++
 include/net/mac80211.h       |  4 ++++
 net/mac80211/agg-rx.c        | 25 ++++++++++++++++++++++---
 net/mac80211/agg-tx.c        | 13 +++++++++----
 net/mac80211/debugfs.c       |  1 +
 net/mac80211/ht.c            |  8 +++++---
 net/mac80211/ieee80211_i.h   |  6 +++++-
 net/mac80211/iface.c         |  3 +++
 net/mac80211/rx.c            | 11 +++++++++--
 net/mac80211/s1g.c           |  8 ++++++++
 net/mac80211/sta_info.h      |  2 ++
 12 files changed, 73 insertions(+), 13 deletions(-)

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
index 3651b2e6c518..9f6225fd0d61 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1501,6 +1501,8 @@ enum ieee80211_statuscode {
 	WLAN_STATUS_REJECT_DSE_BAND = 96,
 	WLAN_STATUS_DENIED_WITH_SUGGESTED_BAND_AND_CHANNEL = 99,
 	WLAN_STATUS_DENIED_DUE_TO_SPECTRUM_MANAGEMENT = 103,
+	/* 802.11ah */
+	WLAN_STATUS_REJECTED_NDP_BLOCK_ACK_SUGGESTED = 109,
 	/* 802.11ai */
 	WLAN_STATUS_FILS_AUTHENTICATION_FAILURE = 112,
 	WLAN_STATUS_UNKNOWN_AUTHENTICATION_SERVER = 113,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9f8251fb9832..9cc482191ab9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2913,6 +2913,9 @@ struct ieee80211_txq {
  *	HW flag so drivers can opt in according to their own control, e.g. in
  *	testing.
  *
+ * @IEEE80211_HW_SUPPORTS_NDP_BLOCKACK: HW can transmit/receive S1G NDP
+ *	BlockAck frames.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2973,6 +2976,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_DISALLOW_PUNCTURING,
 	IEEE80211_HW_HANDLES_QUIET_CSA,
 	IEEE80211_HW_STRICT,
+	IEEE80211_HW_SUPPORTS_NDP_BLOCKACK,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index f301a8622bee..4f35e0218622 100644
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
@@ -473,6 +489,8 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 				     struct ieee80211_mgmt *mgmt,
 				     size_t len)
 {
+	bool req_ndp = mgmt->u.action.u.addba_req.action_code ==
+				WLAN_ACTION_NDP_ADDBA_REQ;
 	u16 capab, tid, timeout, ba_policy, buf_size, start_seq_num;
 	u8 dialog_token, addba_ext_data;
 
@@ -497,7 +515,8 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 
 	__ieee80211_start_rx_ba_session(sta, dialog_token, timeout,
 					start_seq_num, ba_policy, tid,
-					buf_size, true, false, addba_ext_data);
+					buf_size, true, false,
+					req_ndp, addba_ext_data);
 }
 
 void ieee80211_manage_rx_ba_offl(struct ieee80211_vif *vif,
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 93b47a7ba9c4..cd00e8d0fe19 100644
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
index a4babf7624e5..d71e0c6d2165 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2190,7 +2190,8 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 				       struct link_sta_info *link_sta);
 void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 			  const u8 *da, u16 tid,
-			  u16 initiator, u16 reason_code);
+			  u16 initiator, u16 reason_code,
+			  bool use_ndp);
 int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 			       enum ieee80211_smps_mode smps, const u8 *da,
 			       const u8 *bssid, int link_id);
@@ -2206,6 +2207,7 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 				     u8 dialog_token, u16 timeout,
 				     u16 start_seq_num, u16 ba_policy, u16 tid,
 				     u16 buf_size, bool tx, bool auto_seq,
+				     bool req_ndp,
 				     const u8 addba_ext_data);
 void ieee80211_sta_tear_down_BA_sessions(struct sta_info *sta,
 					 enum ieee80211_agg_stop_reason reason);
@@ -2331,6 +2333,8 @@ void ieee80211_s1g_status_twt_action(struct ieee80211_sub_if_data *sdata,
 void ieee80211_s1g_cap_to_sta_s1g_cap(struct ieee80211_sub_if_data *sdata,
 				      const struct ieee80211_s1g_cap *s1g_cap_ie,
 				      struct link_sta_info *link_sta);
+bool ieee80211_s1g_use_ndp_ba(const struct ieee80211_sub_if_data *sdata,
+			      const struct sta_info *sta);
 
 /* Spectrum management */
 void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 676b2a43c9f2..c5f7f0e0d450 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1581,14 +1581,17 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
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
index 6c4b549444c6..5280b1c7fc8a 100644
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
 
@@ -3372,7 +3374,9 @@ ieee80211_rx_h_ctrl(struct ieee80211_rx_data *rx, struct sk_buff_head *frames)
 		    !test_and_set_bit(tid, rx->sta->ampdu_mlme.unexpected_agg))
 			ieee80211_send_delba(rx->sdata, rx->sta->sta.addr, tid,
 					     WLAN_BACK_RECIPIENT,
-					     WLAN_REASON_QSTA_REQUIRE_SETUP);
+					     WLAN_REASON_QSTA_REQUIRE_SETUP,
+					     ieee80211_s1g_use_ndp_ba(rx->sdata,
+								      rx->sta));
 
 		tid_agg_rx = rcu_dereference(rx->sta->ampdu_mlme.tid_rx[tid]);
 		if (!tid_agg_rx)
@@ -3756,16 +3760,19 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 
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
index 1f68df6e8067..2b3c735f395b 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -220,3 +220,11 @@ void ieee80211_s1g_cap_to_sta_s1g_cap(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_sta_recalc_aggregates(&link_sta->sta->sta);
 }
+
+bool ieee80211_s1g_use_ndp_ba(const struct ieee80211_sub_if_data *sdata,
+			      const struct sta_info *sta)
+{
+	return sdata->vif.cfg.s1g &&
+		ieee80211_hw_check(&sdata->local->hw, SUPPORTS_NDP_BLOCKACK) &&
+		(sta && sta->sta.deflink.s1g_cap.s1g);
+}
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 2875ef7d7946..f64764c3cf25 100644
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


