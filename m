Return-Path: <linux-wireless+bounces-33621-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MIAIZYSvmnFFwMAu9opvQ
	(envelope-from <linux-wireless+bounces-33621-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 04:37:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B162E323D
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 04:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E96173011C98
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 03:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864D318B83;
	Sat, 21 Mar 2026 03:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="KFYWlsej"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F8331D367
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 03:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774064272; cv=none; b=laDvSG3nVyI23AHpXZ9CFO0ANnWtd12uPIwnBSA3EgdgZORVntsez7bK4vT8UdFXoelLt8/aWrc2U1bhVKkil2wsZXEjfT43+DlhfolbBRW3QuZjju7Iv8JnxR+baN3EymRb0+oNXTGNlqIf/BUsBLWR93aRHqF8nxM684fxIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774064272; c=relaxed/simple;
	bh=JmqrJDiFCvTIKqqwS5uG96MjLZV17S2UQk0aegECK9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWWrQhpbL20os+ppHXzTuUZUX8E1PD+WM0bRicPgZ151QAZ1TZQEL6CDxPX8fLdTUxEJvCRILo4phz8gAAGnhiPmG0Pjta1RVo4l4JqkhCfNmsfPiIZB1r3pKoRLdmk6QTySNcWT6KhIbcDqO70jock3Tl3eKLwf9TpvaIEPw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=KFYWlsej; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1774064266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEK2KGVNaSSHaOcIpmP2J4fenxmGwUNmQpzBoLtU5Z4=;
	b=KFYWlsejgg0+XpkvSR3c7mbYz6jfPqaYc/LmkO7vqRkEJ0IUScLHYrRzxXRahtS9rlUkiw
	oOTZzPa4TpYI9d8g2MLk7JbrcmqyYvK+8LpsMyDyM/clAoLLsXYzSk1XM1QBMZuJ7j2HZg
	+00sUCQ3uh1F4kXB9HvvPNZK23jgibYI12E1uhV5KNFgxC3r5PqS7TTF1GwgawW3HIv7kw
	xdCGdSK1HOR3uS2F3Ja2G5/jaucLGilVli0Lg/SpQk31cts/PN2H29OEgz/L94onL7kxWg
	bHxBrvU7EcXyzJe3L+qb+5WriTaRki7PRGYLoFofsr1hwtPrjq9NmgQgKooWuw==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtw89: usb: fix TX flow control by tracking in-flight URBs
Date: Fri, 20 Mar 2026 20:37:42 -0700
Message-ID: <20260321040000.31192-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260125221943.36001-1-lucid_duck@justthetip.ca>
References: <20260125221943.36001-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33621-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,justthetip.ca:dkim,justthetip.ca:email,justthetip.ca:mid]
X-Rspamd-Queue-Id: A3B162E323D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lucid Duck <lucid_duck@justthetip.ca>
Date: Thu, 20 Mar 2026 20:00:00 -0700
Subject: [PATCH v2] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs

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

Tested on D-Link DWA-X1850 (RTL8832AU), kernel 6.18.3:

                     Unpatched -> Patched
  USB3 5GHz DL:      494 -> 709 Mbps (+44%)
  USB3 5GHz retx:    8 -> 1 (-88%)
  USB3 2.4GHz DL:    54 -> 68 Mbps (+25%)
  USB2 5GHz DL:      196 -> 225 Mbps (+15%)
  USB2 2.4GHz DL:    123 -> 131 Mbps (+6%)

Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
---
Resending v2. This was prepared in late January after addressing v1
review feedback, but the send failed silently (SMTP misconfiguration)
and never appeared on lore.kernel.org. Apologies for the delay.

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

The 32-URB-per-channel limit is based on similar USB wireless drivers
(mt76, ath9k_htc). The fixed value works well for both USB2 and USB3.

 drivers/net/wireless/realtek/rtw89/usb.c | 26 ++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/usb.h |  6 ++++++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index eb489df..faafa3c 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -161,16 +161,25 @@ static u32
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
index 9f554b5..1459122 100644
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
2.53.0

