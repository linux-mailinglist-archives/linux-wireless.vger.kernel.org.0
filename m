Return-Path: <linux-wireless+bounces-34142-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFxsHk3nyWl43QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34142-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:00:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE22354F02
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AA4F3011101
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9956C365A06;
	Mon, 30 Mar 2026 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="ivd/EmfK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A0375ABC
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774839611; cv=none; b=gtfwJWhTN/yjo2mtLHnP2wIP01DfTAIUI3sowT5ZlyvVpX3q64lYeVQWmTJgvVEDDxFWIYyuJaiup76yPF/zTF8fkE266/z6B3i8eetfwQc+6BRrnI49cB9kkbZIDdB2IO1ZbR8fCHflmjUfhJsv6sngcNPxYwUXibQ3ydoQFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774839611; c=relaxed/simple;
	bh=WJ8HjFrFkmXT2dp9ZUarFikJml/ZKXBcr6PlYsWNf0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yyo0FKvclxlThTvlc3ddtYgSVe58Qx7FuTO1NfYbGAcJ+fspGVJG2opSDqN1f/aY6tfMtKupZYXKPe+6JRrK+rxNu0F+csXwIAGJalxfvqzTYzWuwM5+HwOejBUmzfCr796DxaFOnB6LLeDJJiSuPrs2A958qjqSOwBV97yNXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=ivd/EmfK; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1774839606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aawMuDp68GtT28D6xTsjJkFIofgzzyWmeGHlR3mYq/8=;
	b=ivd/EmfKDICQ91g11gMLlhUXGzZFRkzkCaZKvRBgSsE67FNZrZcMvr7Q56/6wNfdkKOHZv
	6MMxM8iHGrzGSHVS8NAMZaReV/htonmD/pPPZnr3/w/eP3xqoeEKVlGM9UpTqcUMhSY5d6
	mX2v41WNaW3bv2qS6jD3ShoEMLoMWESj6TDr+6l/0/bDz/Qobnu5Vc6gk9YLQ7mt0U8mgP
	IM1akmerE+kApaRTcwKFcXEi0623m4+PH9ZZeIkOL9hvTUsL0RiOIXwbcoRF+yAbfAZTE/
	Lsa/XQvc9mL/LXrZtRo8p9iQzI9QVF+BnXO2HxH02IeZ7DbCnmvMpFrpOvEMzg==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	morrownr@gmail.com,
	Lucid Duck <lucid_duck@justthetip.ca>
Subject: [PATCH v5] wifi: rtw89: usb: fix TX flow control by tracking in-flight URBs
Date: Sun, 29 Mar 2026 19:59:59 -0700
Message-ID: <20260330025959.399018-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260323233347.158745-1-lucid_duck@justthetip.ca>
References: <20260323233347.158745-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34142-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:dkim,justthetip.ca:email,justthetip.ca:mid]
X-Rspamd-Queue-Id: 5BE22354F02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtw89_usb_ops_check_and_reclaim_tx_resource() returns a hardcoded
placeholder value (42) instead of actual TX resource availability.
This violates mac80211's flow control contract, preventing backpressure
and causing uncontrolled URB accumulation under sustained TX load.

Fix by adding per-channel atomic counters (tx_inflight[]) that track
in-flight URBs. Increment before usb_submit_urb() with rollback on
failure, decrement in the completion callback, and return the
remaining capacity to mac80211. The firmware command channel (CH12)
always returns 1 since it has its own flow control.

The pre-increment pattern prevents a race where USB core completes the
URB on another CPU before the submitting code increments the counter.

128 URBs per channel provides headroom for RTL8832CU at 160 MHz
bandwidth. Tested on RTL8852AU (USB3 80 MHz) where 64 and 128 showed
equivalent throughput, and on RTL8832AU where 128 sustained full
throughput under 8-stream parallel load.

Tested on D-Link DWA-X1850 (RTL8832AU), kernel 6.19.8, Fedora 43:

                     Unpatched -> Patched (128 URBs)
  USB3 5GHz UL:      844 -> 837 Mbps (no regression)
  USB3 5GHz retx:    3 -> 0
  USB3 2.4GHz UL:    162 -> 164 Mbps (no regression)
  4-stream UL:       858 -> 826 Mbps (within variance)
  8-stream UL:       872 -> 826 Mbps (within variance)
  UDP flood:         0% loss (690K datagrams)
  60-second soak:    855 Mbps, 0 retransmits

Reported-by: morrownr <morrownr@gmail.com>
Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
---
Changes since v4:
  - Regenerated from kernel tree (not standalone repo). v4 had bare
    usb.c/usb.h paths instead of drivers/net/wireless/realtek/rtw89/
    which broke patchwork delegation. Sorry about that.
  - No code changes from v4.

Changes since v3:
  - Increased MAX_TX_URBS_PER_CH from 64 to 128 per Ping-Ke's
    suggestion, providing headroom for RTL8832CU at 160 MHz.
  - Simplified CH12 handling per Ping-Ke's suggestion: CH12 is now
    tracked in the counter like all other channels. The only special
    case is in check_and_reclaim where CH12 returns 1 (firmware
    command channel has its own flow control).
  - Removed all inline comments flagged in review.

Changes since v2:
  - Increased MAX_TX_URBS_PER_CH from 32 to 64 based on URB scaling
    tests showing 32 drops 35% under multi-stream load.
  - Removed duplicate "TX flow control" comments.

Changes since v1:
  - Removed duplicate comments per Ping-Ke.
  - Added throughput data to commit message per Ping-Ke.
  - Addressed Bitterblue's question about using skb_queue_len vs
    atomic counters (atomic is needed because the counter must update
    before usb_submit_urb returns, not after URB completion).

 drivers/net/wireless/realtek/rtw89/usb.c | 20 ++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/usb.h |  3 +++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index da1b7ce..9a2d68a 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -161,16 +161,24 @@ static u32
 rtw89_usb_ops_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 					    u8 txch)
 {
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	int inflight;
+
 	if (txch == RTW89_TXCH_CH12)
 		return 1;
 
-	return 42; /* TODO some kind of calculation? */
+	inflight = atomic_read(&rtwusb->tx_inflight[txch]);
+	if (inflight >= RTW89_USB_MAX_TX_URBS_PER_CH)
+		return 0;
+
+	return RTW89_USB_MAX_TX_URBS_PER_CH - inflight;
 }
 
 static void rtw89_usb_write_port_complete(struct urb *urb)
 {
 	struct rtw89_usb_tx_ctrl_block *txcb = urb->context;
 	struct rtw89_dev *rtwdev = txcb->rtwdev;
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
 	struct ieee80211_tx_info *info;
 	struct rtw89_txwd_body *txdesc;
 	struct sk_buff *skb;
@@ -229,6 +237,8 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 		break;
 	}
 
+	atomic_dec(&rtwusb->tx_inflight[txcb->txch]);
+
 	kfree(txcb);
 }
 
@@ -306,9 +316,13 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 
 		skb_queue_tail(&txcb->tx_ack_queue, skb);
 
+		atomic_inc(&rtwusb->tx_inflight[txch]);
+
 		ret = rtw89_usb_write_port(rtwdev, txch, skb->data, skb->len,
 					   txcb);
 		if (ret) {
+			atomic_dec(&rtwusb->tx_inflight[txch]);
+
 			if (ret != -ENODEV)
 				rtw89_err(rtwdev, "write port txch %d failed: %d\n",
 					  txch, ret);
@@ -666,8 +680,10 @@ static void rtw89_usb_init_tx(struct rtw89_dev *rtwdev)
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(rtwusb->tx_queue); i++)
+	for (i = 0; i < ARRAY_SIZE(rtwusb->tx_queue); i++) {
 		skb_queue_head_init(&rtwusb->tx_queue[i]);
+		atomic_set(&rtwusb->tx_inflight[i], 0);
+	}
 }
 
 static void rtw89_usb_deinit_tx(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index 203ec8e..e62bde6 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -20,6 +20,8 @@
 #define RTW89_MAX_ENDPOINT_NUM		9
 #define RTW89_MAX_BULKOUT_NUM		7
 
+#define RTW89_USB_MAX_TX_URBS_PER_CH	128
+
 struct rtw89_usb_info {
 	u32 usb_host_request_2;
 	u32 usb_wlan0_1;
@@ -63,6 +65,7 @@ struct rtw89_usb {
 	struct usb_anchor tx_submitted;
 
 	struct sk_buff_head tx_queue[RTW89_TXCH_NUM];
+	atomic_t tx_inflight[RTW89_TXCH_NUM];
 };
 
 static inline struct rtw89_usb *rtw89_usb_priv(struct rtw89_dev *rtwdev)
-- 
2.53.0


