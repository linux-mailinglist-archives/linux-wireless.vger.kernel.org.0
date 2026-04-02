Return-Path: <linux-wireless+bounces-34309-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOABFwL+zWnJkAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34309-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 07:26:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD1C383FB6
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 07:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6593021B12
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 05:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328D713A3F7;
	Thu,  2 Apr 2026 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="qFNlemrP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5B36B076
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775107583; cv=none; b=StCydY2Shlx5JrDIacLtTnXWJMxpaT87mdIZtiKO+uUBEkpnPqmbLySm7O2Q+KnIIrwOArvZrSy6ePRx7f7DKZypE65gQSgP5fLdHU4q5IxAsc2xQLzLmcujQis8dN/MSMDZjkkfShEqqecJv5x2Yc4xQdPMAhEzBGbZh4dexJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775107583; c=relaxed/simple;
	bh=FG9vSpO6LHdMrqOe0j8rAgmE5VB6fm7tRcu79Q2kbWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ty0tnAJcaZMMIBE3ATAZwcDePyy3SxyMbuRk6fXi2XbmcMonhrqYyji+kvM5c9qGeazaX67XvUbFw08Sa+gofCM5XOJrhYJiYQTrnl5iVjU1FGRaTPvScaxk48TSeDZDz3ZzPeXwB215sMoLVp+JIQiWAdYVK+oN516GGDtyOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=qFNlemrP; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1775107577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3pqwci5fxGjGAHcvD0SfuhWwhgYApQ4beNhAMbKLsw=;
	b=qFNlemrPmXGP+Ew/sBnPkEguJ68IJQGOcDc2NQQ18/icrgNpLjB4RAmNgUyWABidQijLiY
	AH489ilFsOctRzkxNT/B81ZkTy2fkMzto7BG842F3dAtycCuEDdjXXI+0/c+X8l1pbLk9W
	TY41GJQSnSXV+zhL82LXHktIq6N9M2SYjj+QvTuxTdVMjJLWMrMFivNXKt587rPeVVt1bj
	4oayEQ5l+Tkl5V6vdCjkSV+UMfNbAWLoz/EuANtJXPNq+SWrAXy9BllwNOPYwZP2Gqf8ZZ
	ESz5hYGrodKq0shtjRq5ZFk4vtokctX9OAC1K8EOC3Y9nZoTJZYowKJmrsJcLg==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	morrownr@gmail.com,
	Lucid Duck <lucid_duck@justthetip.ca>
Subject: [PATCH v6] wifi: rtw89: usb: fix TX flow control by tracking in-flight URBs
Date: Wed,  1 Apr 2026 22:22:16 -0700
Message-ID: <20260402052216.207858-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260330025959.399018-1-lucid_duck@justthetip.ca>
References: <20260330025959.399018-1-lucid_duck@justthetip.ca>
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
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34309-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,justthetip.ca];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7DD1C383FB6
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
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v6:
- Rebased onto rtw.git rtw-next to resolve merge conflict in usb.h
  (new RXAGG register defines added upstream)
- No code changes from v5

v5:
- Sent from kernel tree (v4 was from standalone rtw89 tree)

v4:
- Increased URB limit from 64 to 128 per Ping-Ke's review (headroom
  for RTL8832CU 160 MHz)
- Simplified CH12 handling per Ping-Ke's review
- Removed all comments per Ping-Ke's review

v3:
- Removed comments flagged as "AI-like" by reviewer
- Added 8-stream parallel load test data

v2:
- Pre-increment before usb_submit_urb() to prevent completion race
- Added per-channel tracking (was global)
- Added test data to commit message

 drivers/net/wireless/realtek/rtw89/usb.c | 20 ++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/usb.h |  3 +++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 581b8c05f..767a95f75 100644
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
@@ -684,8 +698,10 @@ static void rtw89_usb_init_tx(struct rtw89_dev *rtwdev)
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
index 3d17e514e..507f61f58 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -31,6 +31,8 @@
 #define R_AX_RXAGG_0			0x8900
 #define B_AX_RXAGG_0_BUF_SZ_4K		GENMASK(7, 0)
 
+#define RTW89_USB_MAX_TX_URBS_PER_CH	128
+
 struct rtw89_usb_info {
 	u32 usb_host_request_2;
 	u32 usb_wlan0_1;
@@ -75,6 +77,7 @@ struct rtw89_usb {
 	struct usb_anchor tx_submitted;
 
 	struct sk_buff_head tx_queue[RTW89_TXCH_NUM];
+	atomic_t tx_inflight[RTW89_TXCH_NUM];
 };
 
 static inline struct rtw89_usb *rtw89_usb_priv(struct rtw89_dev *rtwdev)
-- 
2.53.0


