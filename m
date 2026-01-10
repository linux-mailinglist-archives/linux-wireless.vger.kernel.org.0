Return-Path: <linux-wireless+bounces-30615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE5D0CD49
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 03:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93F55300E3C3
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DFF2517AF;
	Sat, 10 Jan 2026 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dCXvBOSx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450923ABBF
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011631; cv=none; b=lJ0fKDJA7suwwr3Khnpt1Gyv6bh1W7RBDKvZOApewluqvbnt8WOScTlvtkvIVUkPMfBfYdvrlfPgC9K6hs4fqShlzwHJ/5cKLb3AwwmU6zj9S6CGWBoswOYJhXLITAOHiV+4YHuC9lW7rZ8z9OjTbQYct43eHQ5LQ6G6TrzgCp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011631; c=relaxed/simple;
	bh=5lAb28fZbIDun8wPIH9c/8xNUCUGVS3vBIuSoHNQTSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8zhtk/tfG2/+UP/FVA6sW6b6KNTfP3aDMpxYa+Psg9InKkkzR1/lIcW78WpLrSKZGFRY23CxnTHGjVkhK3DP7TBfQ5yLg61vSt+3DC+98t82qEas5D5TlrTE7xq14UcP+96u/KjSOjbBEu3hTCbol/4UX+20RsV8zr/V2Lp+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dCXvBOSx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60A2KPfF4241714, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768011625; bh=eX3wiNZ5qnIkiYM1/PZT+8vRWlTd3SxUN0nKstDYDjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dCXvBOSxIy9SqULdaySHzz+MSgZxqRsAG4qttA+bhC+khj7dEoEezr4Orf6SyDsbz
	 GEeTqK43igVoV7FE/DeTavAQo8g+oux3+dM7xUpdYfAhSbSOEGj+CxmEqNbYnlG+sV
	 mvJ2ckLj9JeI96H/ez6JCl687kd2CJnGtkUDciDHBIR1NwoMJYhbGavzx1Sjr85kJG
	 w7wNKLufPoLxhb2Oznk4wg/VAIDkMf50OjYcT/6Yz7iGHMDmcbosfY84HZZguFxswN
	 GpGI7X0ActQy8f+Co1KbC35JMAxM6h4fhZti9CHJlREH8dQ/xKp4RzxyV3J51Ha4eq
	 CjF9O6UWKbxFA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60A2KPfF4241714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 10:20:25 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:25 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:24 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 10 Jan 2026 10:20:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 1/8] wifi: rtw89: pci: validate sequence number of TX release report
Date: Sat, 10 Jan 2026 10:20:12 +0800
Message-ID: <20260110022019.2254969-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260110022019.2254969-1-pkshih@realtek.com>
References: <20260110022019.2254969-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hardware rarely reports abnormal sequence number in TX release report,
which will access out-of-bounds of wd_ring->pages array, causing NULL
pointer dereference.

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 1 PID: 1085 Comm: irq/129-rtw89_p Tainted: G S   U
             6.1.145-17510-g2f3369c91536 #1 (HASH:69e8 1)
  Call Trace:
   <IRQ>
   rtw89_pci_release_tx+0x18f/0x300 [rtw89_pci (HASH:4c83 2)]
   rtw89_pci_napi_poll+0xc2/0x190 [rtw89_pci (HASH:4c83 2)]
   net_rx_action+0xfc/0x460 net/core/dev.c:6578 net/core/dev.c:6645 net/core/dev.c:6759
   handle_softirqs+0xbe/0x290 kernel/softirq.c:601
   ? rtw89_pci_interrupt_threadfn+0xc5/0x350 [rtw89_pci (HASH:4c83 2)]
   __local_bh_enable_ip+0xeb/0x120 kernel/softirq.c:499 kernel/softirq.c:423
   </IRQ>
   <TASK>
   rtw89_pci_interrupt_threadfn+0xf8/0x350 [rtw89_pci (HASH:4c83 2)]
   ? irq_thread+0xa7/0x340 kernel/irq/manage.c:0
   irq_thread+0x177/0x340 kernel/irq/manage.c:1205 kernel/irq/manage.c:1314
   ? thaw_kernel_threads+0xb0/0xb0 kernel/irq/manage.c:1202
   ? irq_forced_thread_fn+0x80/0x80 kernel/irq/manage.c:1220
   kthread+0xea/0x110 kernel/kthread.c:376
   ? synchronize_irq+0x1a0/0x1a0 kernel/irq/manage.c:1287
   ? kthread_associate_blkcg+0x80/0x80 kernel/kthread.c:331
   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
   </TASK>

To prevent crash, validate rpp_info.seq before using.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index a66fcdb0293b..093960d7279f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -604,11 +604,16 @@ static void rtw89_pci_release_rpp(struct rtw89_dev *rtwdev, void *rpp)
 
 	info->parse_rpp(rtwdev, rpp, &rpp_info);
 
-	if (rpp_info.txch == RTW89_TXCH_CH12) {
+	if (unlikely(rpp_info.txch == RTW89_TXCH_CH12)) {
 		rtw89_warn(rtwdev, "should no fwcmd release report\n");
 		return;
 	}
 
+	if (unlikely(rpp_info.seq >= RTW89_PCI_TXWD_NUM_MAX)) {
+		rtw89_warn(rtwdev, "invalid seq %d\n", rpp_info.seq);
+		return;
+	}
+
 	tx_ring = &rtwpci->tx.rings[rpp_info.txch];
 	wd_ring = &tx_ring->wd_ring;
 	txwd = &wd_ring->pages[rpp_info.seq];
-- 
2.25.1


