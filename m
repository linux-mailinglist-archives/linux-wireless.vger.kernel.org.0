Return-Path: <linux-wireless+bounces-36609-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPM0G1cjC2oxDwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36609-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 16:33:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7705E56EE35
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 16:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5D83305361F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CCB466B75;
	Mon, 18 May 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P4bLvHVV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501F3F58D2
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114235; cv=none; b=N54vP4z0KhuCr9SShSU8feDIz31/bT0E4FPlna3R/ApziXjcyVt49Et1ulTc8ohbpKAMibxoFYt3H6wGAJc3Wj12T0QvwJ1y8PoD26XvmkIMhbTVzGg2QMdkm2GwfJJM6Etk9TfmT4D0s3zUdyKzTjyQG3lUIQOEzvY+rdXzdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114235; c=relaxed/simple;
	bh=jf0TmQKmVeYC0gpsI55lB1pWbgi0el4/1nCal3luHvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XblGWbdrhWsrsE1yOYmdaub/cVZjm1E91HMJE5kzodp4nbABaOU/+flRYZ5e/tY9Tr0Q4sIfOegyTJKAhQoHkfpO7YxwUCadMUZ+0+TJbNyLqu3O941SPHc6sqiiBAUZs9IHMvXdeqtToM6sHHJNn1IC1tbqEp/eUHC7WhR3F9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P4bLvHVV; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779114218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FwD5v3ONOdOsGGNvw1Tq8CqMFhIulXeR+lh+f9/MFGk=;
	b=P4bLvHVVUqXHQigori2cShp4vvaLbI8qVETXb+uQfAsewoiOdl7dAQBp7HeaWXJuSMzqSe
	YOgiqz+N++MNVVurtTM68VuybUIvi7AmorQq9DEHVvgFWG4JE5gC4IeVO5j7JBS6ad4iXh
	WM/Ht6BketLxcVbdEYKL/cxKlVtheJ8=
From: luka.gejak@linux.dev
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Luka Gejak <luka.gejak@linux.dev>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] wifi: rtw88: increase TX report timeout to fix race condition
Date: Mon, 18 May 2026 16:23:10 +0200
Message-ID: <20260518142311.10328-1-luka.gejak@linux.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36609-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7705E56EE35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

The driver expects the firmware to report TX status within 500ms.
However, a timeout can be triggered when the hardware performs
background scans while under TX load. During these scans, the firmware
stays off-channel for periods exceeding 500ms, delaying the delivery of
TX reports back to the driver.

When this occurs, the purge timer fires prematurely and drops the
tracking skbs from the queue. This results in the host stack
interpreting the missing status as packet loss, leading to TCP window
collapse. In testing with iperf3, this causes throughput to drop from
~90 Mbps to near-zero for approximately 2 seconds until the connection
recovers.

Increase RTW_TX_PROBE_TIMEOUT to 2500ms for RTL8723DU. This duration is
sufficient to accommodate off-channel dwell time during full background
scans, ensuring the purge timer only trips during genuine firmware
lockups and preventing unnecessary TCP retransmission cycles.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Cc: stable@vger.kernel.org
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
Changes in v4:
 - Picked up Acked-by tag.
Changes in v3:
 -Declared timeout with RTW_TX_PROBE_TIMEOUT as the default value and 
 removed the else branch.
 -Updated the Fixes tag to the commit that introduced USB support.
Changes in v2:
 -Isolated the change to RTL8723DU as requested by Ping-Ke

 drivers/net/wireless/realtek/rtw88/tx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 3106edb84fb4..a6e43314a4e9 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -196,6 +196,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
+	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -207,7 +208,11 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 	__skb_queue_tail(&tx_report->queue, skb);
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 
-	mod_timer(&tx_report->purge_timer, jiffies + RTW_TX_PROBE_TIMEOUT);
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8723D &&
+	    rtwdev->hci.type == RTW_HCI_TYPE_USB)
+		timeout = msecs_to_jiffies(2500);
+
+	mod_timer(&tx_report->purge_timer, jiffies + timeout);
 }
 EXPORT_SYMBOL(rtw_tx_report_enqueue);
 
-- 
2.54.0


