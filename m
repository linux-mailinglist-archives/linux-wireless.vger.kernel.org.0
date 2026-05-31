Return-Path: <linux-wireless+bounces-37216-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v0WPHYm5HGpGRwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37216-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 00:43:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9131B61826F
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 00:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97BFB300B3EF
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 22:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A041335675C;
	Sun, 31 May 2026 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b="aIef59G+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.cock.li (mail.cock.li [37.120.193.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707FF33F591;
	Sun, 31 May 2026 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780267397; cv=none; b=cS9XTqWm21JatX7s7uI+3Q0X0vzgDfVLM4a/NKmfF927OLd+tEC9QwWvNB4uMkKkR+YlLjd4bMPQwXQBwqDmBN8uboe1ptwhco6jmiM27HD+YcKPlFgacjnY4eOaYaOF8IvxTwJW+1ZjabUOwzKbUhIeR0FRHLkxYansIRqcS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780267397; c=relaxed/simple;
	bh=XgZKgdvdRJZ6QE3Us3zZJ8a1z/dSj82ioQpHMdTmgBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ms8iu0Rej1oUqx1MLwbf3GVuOmCKEIm1s3vnop9hsgeBBawtBAHG6LMAc4STo+Dn0p/3w0EoWLERaW/1zB1pFszVI88z1ek4PiO6e3zsHDdYPJEtydkfJKXNQNce/pLSFJ3c80jG/aBy5CnkpoKdxY0nkdtHZ8IIzepzK2owgmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc; spf=pass smtp.mailfrom=airmail.cc; dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b=aIef59G+; arc=none smtp.client-ip=37.120.193.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airmail.cc
From: VolcomIlluminated <Volcomilluminated@airmail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=airmail.cc; s=mail;
	t=1780266909; bh=XgZKgdvdRJZ6QE3Us3zZJ8a1z/dSj82ioQpHMdTmgBc=;
	h=From:To:Cc:Subject:Date:From;
	b=aIef59G+aUXQ5GdSZps8sPh4NxPMCea0DfA/QQhepWRW3QVDxrSQU9M4EBMRJGw4h
	 pRHK76Juo9dQkN/TplaAR+Gf3FLBrfGWFL5z/8m+tKeECKzFZbxgsWJ0hky3x66LTi
	 kxqc0Nu9V9culBITTrO/I1/gRkAvfJZcyMyMJwTqbguEefh86yjW5uRdIm1BVvcnln
	 T/RTq3Pe7VPuVHe/LttYizloRYrNSgEb/4/XTx6yFHy+nvuqN31dv54lb/0m3cFjtp
	 AiOyvMfqsUOpngMtyvmbLeQ88yZnIcS4iZLj0RceAL+Dr0NeChfx5XWvF1Tksvc4/3
	 a0yqqbU8uokwA==
To: pkshih@realtek.com
Cc: kvalo@kernel.org,
	luka.gejak@linux.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	VolcomIlluminated <Volcomilluminated@airmail.cc>
Subject: [PATCH] wifi: rtw88: extend USB TX report timeout to RTL8822BU
Date: Sun, 31 May 2026 18:33:49 -0400
Message-ID: <20260531223349.5952-1-Volcomilluminated@airmail.cc>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[airmail.cc,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[airmail.cc:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37216-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[airmail.cc:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Volcomilluminated@airmail.cc,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DM_SURBL(0.00)[airmail.cc:email,airmail.cc:mid,airmail.cc:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9131B61826F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Luka Gejak's patch increased the TX report timeout for RTL8723DU to
accommodate off-channel dwell time during background scans. The same
issue affects RTL8822BU (tested on Edimax EW-7822ULC) where background
scans cause the firmware to stay off-channel for periods exceeding the
default 500ms timeout, causing the purge timer to fire prematurely and
drop TX tracking skbs.

Extend the 2500ms timeout to also cover RTL8822BU USB devices.

Tested on RTL8822BU (Edimax EW-7822ULC) with 17,706 packets over 24+
hours with zero drops.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Cc: stable@vger.kernel.org
Signed-off-by: VolcomIlluminated <Volcomilluminated@airmail.cc>
---
--- /tmp/linux-6.18/drivers/net/wireless/realtek/rtw88/tx.c	2025-11-30 17:42:10.000000000 -0500
+++ /home/ptpx86mm1/kernelbuild/linux-6.18/drivers/net/wireless/realtek/rtw88/tx.c	2026-05-31 16:00:37.125645594 -0400
@@ -196,6 +196,7 @@
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
+	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -207,7 +208,12 @@
 	__skb_queue_tail(&tx_report->queue, skb);
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 
-	mod_timer(&tx_report->purge_timer, jiffies + RTW_TX_PROBE_TIMEOUT);
+	if ((rtwdev->chip->id == RTW_CHIP_TYPE_8723D ||
+	     rtwdev->chip->id == RTW_CHIP_TYPE_8822B) &&
+	    rtwdev->hci.type == RTW_HCI_TYPE_USB)
+		timeout = msecs_to_jiffies(2500);
+
+	mod_timer(&tx_report->purge_timer, jiffies + timeout);
 }
 EXPORT_SYMBOL(rtw_tx_report_enqueue);
 

