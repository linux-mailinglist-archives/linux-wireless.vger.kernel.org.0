Return-Path: <linux-wireless+bounces-34094-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB6qGFbfxmkoPQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34094-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 20:49:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A37334A706
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 20:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EE6D303A130
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 19:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65237E302;
	Fri, 27 Mar 2026 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="InALLPmi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43138BF8E
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640435; cv=none; b=pzac0qmFO489ysgUCL8EotDw9YQZz7x1r8D+51K4fQGyXib0sPMNzvGh9iJFaCT1fzAsRvvJIH7pQDlPj5KH9RZUNeJEUdATUGXsHKgxlZZ+aSponLOOzSyJLzIDBuWEOjvt5Aw16ccrmUSZUrKxgwws1O5sSEL7WBY0x3tgTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640435; c=relaxed/simple;
	bh=dmGV+dwOZe0z0P/MfvO9d6jrVB1lS++DYp0VGNGKeCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLTtmi/j8fKIsE2Fz5kPPFpF92BK2fP/glljoAapR/WLa6OBBkP4t7Y58wdyZ4MmHK2WTrOMwGJVhtcvKAXGxVWmkOrnRxN717gczLHNhvLcIoNhhGX/eIyqCeMs+qsvcc/YjX0eNJLZvLCB6pjrZf85z2buu/vmQlRjdoeyzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=InALLPmi; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1774640424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FUcjJSTCwKjx17qZB6HcOBr+uMak1u7sFzWNqgDyLQ8=;
	b=InALLPmiApYSi+Hrk21m+u/r6YNV79yIZlZtN8/AEGM6M/GnU5EtXinxAgwJaaZf7wuCPj
	JyeONFWQ0E0yE3lJTB0kFVfaudxQt90Zgv8KGnLUJhJjES0jyh4L8E8AvuoahT5oh55pyt
	HaVBera/94Pfhla2/hQKF5362iGSuUeRYuEu+psqStBA6cptd/o5QbyCoUU6lHXHKVvyJk
	j3Ois26aUW+AL5EPqBg73W796+V2bf/iEcGY25gDkDQfDhBYFppCC4dGIzhitN36VM3Yce
	NyUeWDP3t21OUo//wXv1GuV4V87irpO3qsuwa93l96AGIEML88br0qBE6vsM8w==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	morrownr@gmail.com,
	Lucid Duck <lucid_duck@justthetip.ca>
Subject: [PATCH v4] wifi: rtw89: usb: fix TX flow control by tracking in-flight URBs
Date: Fri, 27 Mar 2026 12:40:02 -0700
Message-ID: <20260327194002.48648-1-lucid_duck@justthetip.ca>
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
	TAGGED_FROM(0.00)[bounces-34094-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 7A37334A706
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
Changes since v3:
  - Increased MAX_TX_URBS_PER_CH from 64 to 128 per Ping-Ke's
    suggestion, providing headroom for RTL8832CU at 160 MHz. I don't
    have an RTL8832CU to test 160 MHz directly, but 64 and 128 are
    equivalent on RTL8852AU at 80 MHz -- no regression risk.
  - Simplified CH12 handling per Ping-Ke's suggestion: CH12 is now
    tracked in the counter like all other channels. The only special
    case is in check_and_reclaim where CH12 returns 1 (firmware
    command channel has its own flow control).
  - Removed all inline comments flagged in review.
  - Sent via git send-email (was asked about mailer in v2 review).

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

 usb.c | 20 ++++++++++++++++++--
 usb.h |  3 +++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/usb.c b/usb.c
index eb489df..6f57788 100644
--- a/usb.c
+++ b/usb.c
@@ -166,16 +166,24 @@ static u32
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
@@ -234,6 +242,8 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 		break;
 	}
 
+	atomic_dec(&rtwusb->tx_inflight[txcb->txch]);
+
 	kfree(txcb);
 }
 
@@ -311,9 +321,13 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 
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
@@ -694,8 +708,10 @@ static void rtw89_usb_init_tx(struct rtw89_dev *rtwdev)
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(rtwusb->tx_queue); i++)
+	for (i = 0; i < ARRAY_SIZE(rtwusb->tx_queue); i++) {
 		skb_queue_head_init(&rtwusb->tx_queue[i]);
+		atomic_set(&rtwusb->tx_inflight[i], 0);
+	}
 }
 
 static void rtw89_usb_deinit_tx(struct rtw89_dev *rtwdev)
diff --git a/usb.h b/usb.h
index 9f554b5..1a77e0e 100644
--- a/usb.h
+++ b/usb.h
@@ -21,6 +21,8 @@
 #define RTW89_MAX_BULKIN_NUM		2
 #define RTW89_MAX_BULKOUT_NUM		7
 
+#define RTW89_USB_MAX_TX_URBS_PER_CH	128
+
 struct rtw89_usb_info {
 	u32 usb_host_request_2;
 	u32 usb_wlan0_1;
@@ -67,6 +69,7 @@ struct rtw89_usb {
 	struct usb_anchor tx_submitted;
 
 	struct sk_buff_head tx_queue[RTW89_TXCH_NUM];
+	atomic_t tx_inflight[RTW89_TXCH_NUM];
 };
 
 static inline struct rtw89_usb *rtw89_usb_priv(struct rtw89_dev *rtwdev)
-- 
2.53.0


