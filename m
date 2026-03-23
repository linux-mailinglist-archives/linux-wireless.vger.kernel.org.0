Return-Path: <linux-wireless+bounces-33742-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG3KA+zNwWnhWwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33742-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 00:34:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A11A2FEFE4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 00:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5587D3012205
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 23:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF69C36C9EB;
	Mon, 23 Mar 2026 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="p+s/3qpH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB4358369
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308836; cv=none; b=DB+1L7KfBrUvhQ5GN0ANIOzAgfVGvy2L1S2j61YppS9fWSg9EkS3qOBD3eYF0WL3lYjRkV81egDxmeCfifpObqR5fPecESpi1Qyeqzt/DmmQVRdd5uVuZvHY7HfpDChFyH7PXtMofIdImVfMp8Vi2chlu0PoV6Bme2IvTtJzGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308836; c=relaxed/simple;
	bh=FjbAyrEmeQ2pJD5HlGbZEf8ALytHq3Yzj2mQiRDhEQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usP+x+zGeB2c6z150hnSGQVDcQdmtjle2q4wi+8w6mMBmfJI7rwtp2z9uK0bMOajLc3bwQCMXIPbZwhSieBvF3QUpqWHN3Bwk857gLSkX+gG6RpOjxK+ldzX1+9KazsCyh++hE+7gHzz9VkduFU13aNpEahJEyhGBedfzZ9LSmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=p+s/3qpH; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1774308832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o/rtVFg5poN4pSegOVy5Qig/kruBx34w6AKo7vNkyHU=;
	b=p+s/3qpHLeWIEO+MzphYpCXt38prg4kTTWZu3KijSHBqrUwfgoJZhbw7LY0bo/N3nZ5BuN
	KlU1Jr9cewkNmWiti4FmTKGrT4ji/AMj5df8/dB8XjbQ3lCBO1u5vYgcp1ys0G6Im1x0ur
	1yFTB2GNARGLLpazsnjzqwaxyvP6Z1j+o9VLajfV/syiubR9SkWf4BOqRt2U3M/2DllMf5
	/vznEqn+bFsyzLRekqoXVvuThCAp31UCl1qqRyKliUZ/+19oMlXRzYvA+/6m3dcskp3cxo
	GOje14nMOpp8p8O1MQWlDnPeu+YV/K+6j3HxmsfC1ZmiqDPczeF9r4koCvC1pQ==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v3] wifi: rtw89: usb: fix TX flow control by tracking in-flight URBs
Date: Mon, 23 Mar 2026 16:33:47 -0700
Message-ID: <20260323233347.158745-1-lucid_duck@justthetip.ca>
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
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33742-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[justthetip.ca:dkim,justthetip.ca:email,justthetip.ca:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A11A2FEFE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtw89_usb_ops_check_and_reclaim_tx_resource() returns a hardcoded
placeholder value (42) instead of actual TX resource availability.
This violates mac80211's flow control contract, preventing backpressure
and causing uncontrolled URB accumulation under sustained TX load.

Fix by adding per-channel atomic counters (tx_inflight[]) that track
in-flight URBs:

- Increment before usb_submit_urb() with rollback on failure
- Decrement in completion callback
- Return (MAX_URBS - inflight) to mac80211, or 0 when at capacity
- Exclude firmware command channel (CH12) from tracking

The pre-increment pattern prevents a race where the USB core completes
the URB (possibly on another CPU) before the submitting code increments
the counter.

The 64-URB-per-channel limit was determined empirically. Testing across
32, 64, and 128 URBs showed that 32 causes a 10% throughput regression
on single-stream USB3 5GHz upload (844 to 763 Mbps) and a 35% drop
under parallel streams (858 to 556 Mbps). 64 URBs recovers to stock
throughput while maintaining correct flow control. 128 URBs shows no
further gain. On USB2 the bus speed is the bottleneck, so URB count
has no effect.

Tested on D-Link DWA-X1850 (RTL8832AU), kernel 6.19.8:

                        Unpatched -> Patched (64 URBs)
  USB3 5GHz DL:         509 -> 475 Mbps
  USB3 5GHz UL:         844 -> 840 Mbps (retransmits: 3 -> 0)
  USB3 5GHz UL 4-stream: 858 -> 837 Mbps
  USB3 5GHz UL 8-stream: 872 -> 830 Mbps
  USB3 2.4GHz DL:       82 -> 104 Mbps (+27%)
  USB3 2.4GHz UL:       162 -> 163 Mbps
  USB2 5GHz UL:         250 -> 248 Mbps (bus-limited, no change)
  UDP flood (64 URBs):  930 Mbps, 0% loss, 4M+ datagrams
  60s sustained soak:   844 Mbps, 0 retransmits

Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
---
Changes since v2:
- Increased MAX_TX_URBS_PER_CH from 32 to 64 (Ping-Ke Shih):
  32 constrains USB3 5GHz throughput, especially under parallel
  streams. 64 recovers fully. 128 shows no further gain.
- Removed redundant comments on define and struct member (Ping-Ke Shih)
- Added uplink and multi-stream test data to commit message (Ping-Ke Shih)

Changes since v1:
- Removed duplicate "TX flow control" comment (Ping-Ke Shih)
- Added test results to commit message (Ping-Ke Shih)

Bitterblue's CH12 question from v1: the CH12 guards in tx_kick_off()
and write_port_complete() are a matched pair. tx_kick_off() skips
atomic_inc for CH12, so the completion handler must skip atomic_dec
to match. Removing only the completion side causes counter underflow.

Additional validation: 100-iteration stress test, 50-iteration
teardown (rmmod/modprobe under load), 10x hot-unplug during active
TX, and 30-minute soak -- all pass with counters balanced at idle.

 drivers/net/wireless/realtek/rtw89/usb.c | 27 +++++++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/usb.h |  4 ++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index eb489df..faafa3c 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -166,16 +166,25 @@ static u32
 rtw89_usb_ops_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 					    u8 txch)
 {
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	int inflight;
+
+	/* Firmware command channel is not tracked */
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
@@ -234,6 +243,10 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 		break;
 	}

+	/* Decrement in-flight counter (skip firmware command channel) */
+	if (txcb->txch != RTW89_TXCH_CH12)
+		atomic_dec(&rtwusb->tx_inflight[txcb->txch]);
+
 	kfree(txcb);
 }

@@ -311,9 +324,17 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)

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
@@ -694,8 +715,10 @@ static void rtw89_usb_init_tx(struct rtw89_dev *rtwdev)
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
index 9f554b5..1459122 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -21,6 +21,8 @@
 #define RTW89_MAX_BULKIN_NUM		2
 #define RTW89_MAX_BULKOUT_NUM		7

+#define RTW89_USB_MAX_TX_URBS_PER_CH	64
+
 struct rtw89_usb_info {
 	u32 usb_host_request_2;
 	u32 usb_wlan0_1;
@@ -67,6 +69,8 @@ struct rtw89_usb {
 	struct usb_anchor tx_submitted;

 	struct sk_buff_head tx_queue[RTW89_TXCH_NUM];
+
+	atomic_t tx_inflight[RTW89_TXCH_NUM];
 };

 static inline struct rtw89_usb *rtw89_usb_priv(struct rtw89_dev *rtwdev)
--
2.53.0

