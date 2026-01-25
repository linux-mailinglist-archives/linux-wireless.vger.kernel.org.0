Return-Path: <linux-wireless+bounces-31151-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAXQAa2ZdmmESwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31151-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 23:31:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 384EF82B1B
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 23:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E71F3004204
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 22:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311BB2D1F4E;
	Sun, 25 Jan 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b="AcdmqGUt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.out.titan.email (mail11.out.titan.email [3.232.242.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4582264CC
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.232.242.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769380266; cv=none; b=HaZCtbvWQPKx3Ck9jQoE4gRiAmxhDBaGXZ1gz0HXT8v/YXu3T5ziMzqefpSsUlJ1LYB5QaIPPn8cTO9DjGIAKuiZjnv8jyGuTm/ZCZRhlA+NDV0jGa4na4msYmAtAFFQB0GfUY9jzXzYibG1heU58sHOCBHpcsHKZZKIF2+7TfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769380266; c=relaxed/simple;
	bh=HPnCaPVTAi6aLKfp+3oqmpSl2+8TmDZ9KO24w2P7cRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmWShGm3KOyJZAOnD6VVs8u0QhM77nKdTVhUnWYlseb5eW5iT7vt4EzQ3wuBlUy/A/xOPO38e4GLTmhDWwAFT6eVYEUJiyhuWc+lBVwAxxKJ6JrIlbG49yq3Yf6yzdJ/gTTQkzFsaZyHQ17GWNZ071zRiok0ubcLdyyoQ9NmhcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b=AcdmqGUt; arc=none smtp.client-ip=3.232.242.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dzmPd0zLdz9rvX;
	Sun, 25 Jan 2026 22:22:29 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=HDde+sERU+6wCDmo3G07iytJThT1QX5SLbUADM4E1gY=;
	c=relaxed/relaxed; d=t32smtp-sign002.email;
	h=from:cc:subject:date:mime-version:message-id:to:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1769379749; v=1;
	b=AcdmqGUtNCGyif4HBh9QfnORv8TWYp1xzWJNZ31dNXGOtv+bTl7H7IBHpc9Hv+f/oR43waO2
	H4pBP7FCOcooqF34yoDSl6SmO+wq9g2ReuTpt7VNvWpNyllYmdKuf6xx3Q+pMcK2yHrNxNxC6+M
	/vofsJ0matYbIpSlsM9IPImM=
Received: from fedora (unknown [176.100.43.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dzmPc3htnz9rvs;
	Sun, 25 Jan 2026 22:22:28 +0000 (UTC)
Feedback-ID: :lucid_duck@justthetip.ca:justthetip.ca:flockmailId
From: Lucid Duck <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Lucid Duck <lucid_duck@justthetip.ca>
Subject: [PATCH] wifi: rtw89: usb: fix TX flow control by tracking in-flight URBs
Date: Sun, 25 Jan 2026 14:19:43 -0800
Message-ID: <20260125221943.36001-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1769379748937774343.13754.960002775032896041@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=697697a4
	a=yrWfAsoAw4/hpWCXcRwPxQ==:117 a=yrWfAsoAw4/hpWCXcRwPxQ==:17
	a=CEWIc4RMnpUA:10 a=ThxqNdz_AAAA:8 a=ciokKiwchZdtPYetSlsA:9
	a=X5WbqfxFh8zCdCUNm0Nt:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[t32smtp-sign002.email:s=titan1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[justthetip.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31151-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[t32smtp-sign002.email:+];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,t32smtp-sign002.email:dkim]
X-Rspamd-Queue-Id: 384EF82B1B
X-Rspamd-Action: no action

rtw89_usb_ops_check_and_reclaim_tx_resource() currently returns a
hardcoded placeholder value of 42, violating mac80211's TX flow control
contract. This causes uncontrolled URB accumulation under sustained TX
load since mac80211 believes resources are always available.

Fix this by implementing proper TX backpressure:

- Add per-channel atomic counters (tx_inflight[]) to track URBs between
  submission and completion
- Increment counter before usb_submit_urb() with rollback on failure
- Decrement counter in completion callback
- Return available slots (max - inflight) to mac80211, or 0 at capacity
- Exclude firmware command channel (CH12) from flow control

Tested on D-Link DWA-X1850 (RTL8832AU) with:
- Sustained high-throughput traffic
- Module load/unload stress tests
- Hot-unplug during active transmission
- 30-minute soak test verifying counters balance at idle

Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 27 ++++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/usb.h |  6 ++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index e77561a4d..6fcf32603 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -161,16 +161,25 @@ static u32
 rtw89_usb_ops_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 					    u8 txch)
 {
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	int inflight;
+
+	/* Firmware command channel is not flow-controlled */
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
@@ -229,6 +238,10 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 		break;
 	}
 
+	/* Decrement in-flight counter (skip firmware command channel) */
+	if (txcb->txch != RTW89_TXCH_CH12)
+		atomic_dec(&rtwusb->tx_inflight[txcb->txch]);
+
 	kfree(txcb);
 }
 
@@ -306,9 +319,17 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 
 		skb_queue_tail(&txcb->tx_ack_queue, skb);
 
+		/* Increment BEFORE submit to avoid race with completion */
+		if (txch != RTW89_TXCH_CH12)
+			atomic_inc(&rtwusb->tx_inflight[txch]);
+
 		ret = rtw89_usb_write_port(rtwdev, txch, skb->data, skb->len,
 					   txcb);
 		if (ret) {
+			/* Rollback increment on failure */
+			if (txch != RTW89_TXCH_CH12)
+				atomic_dec(&rtwusb->tx_inflight[txch]);
+
 			if (ret != -ENODEV)
 				rtw89_err(rtwdev, "write port txch %d failed: %d\n",
 					  txch, ret);
@@ -666,8 +687,10 @@ static void rtw89_usb_init_tx(struct rtw89_dev *rtwdev)
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
index 203ec8e99..f72a8b1b2 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -20,6 +20,9 @@
 #define RTW89_MAX_ENDPOINT_NUM		9
 #define RTW89_MAX_BULKOUT_NUM		7
 
+/* TX flow control: max in-flight URBs per channel */
+#define RTW89_USB_MAX_TX_URBS_PER_CH	32
+
 struct rtw89_usb_info {
 	u32 usb_host_request_2;
 	u32 usb_wlan0_1;
@@ -63,6 +66,9 @@ struct rtw89_usb {
 	struct usb_anchor tx_submitted;
 
 	struct sk_buff_head tx_queue[RTW89_TXCH_NUM];
+
+	/* TX flow control: track in-flight URBs per channel */
+	atomic_t tx_inflight[RTW89_TXCH_NUM];
 };
 
 static inline struct rtw89_usb *rtw89_usb_priv(struct rtw89_dev *rtwdev)
-- 
2.52.0


