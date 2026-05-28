Return-Path: <linux-wireless+bounces-37075-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG07NXyfGGpvlggAu9opvQ
	(envelope-from <linux-wireless+bounces-37075-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 22:03:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A65F7B5B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 22:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA1FF3019821
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113AF24677F;
	Thu, 28 May 2026 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.com header.i=@tuta.com header.b="n0/IBX/r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C4526B973
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998468; cv=none; b=rFmzkpsXGuplVA/ImEEqZzvktow1vzeMTMOj54EleWdxEw9ujMhfK8fc9WaXsmMIjlrjLk0UX9Ws6kIQ4Ao057uKutXBbG4fD9vtnXtCHpc+uJQHZZ6p4TNHJV3E0eFsyNyyrah/JKb6dPnq0g79a+pnqP/qC7VkIGvDjco5R78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998468; c=relaxed/simple;
	bh=V0emmDcSnvCmyViSmeSEhSubfvKcVVdRdtlz+Y1jJcY=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=J3BHaIcFE0Kv0FhyzgJSh2xET6sMQO0ioEegwLX90ify4PFnRUOZzPhQ9tuiQ2LlwGe8AHsf97YD5VCu1OFYgEaKMu0W1JaHREj9N4hNZ08Ug/FF0/38GNWrVLwOSb7lPI37BorM6ChrUvwApQmyodEFg3+toSF/uIRaLHUqAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.com; spf=pass smtp.mailfrom=tuta.com; dkim=pass (2048-bit key) header.d=tuta.com header.i=@tuta.com header.b=n0/IBX/r; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.com
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 36785146CA49A
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 21:51:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779997899;
	s=s1; d=tuta.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=/6acsCH1Ydw2E7KRWYVpPcj4kAhsMBc1RGF19GaxHqk=;
	b=n0/IBX/rji+XkJqK7MAAxeIh3WCizc6Wn6nnJ6MU1cOr1JLI5J47K6wXkR6KEPwo
	K+48rKd8q7k6s0L+sMgTpzzfdHTHVuEOcIpbEu8EFE8+GWImUZ5yzKSEewLIQJsO/tZ
	rxy5xP+81n3yQQTDHIvsbdFYYdKiPLbYtbeMnsncsjQJL4ncx9jYY/gdMp0V6C0RArm
	MUYQ70AEb1s7NRuUd1qS8R+jKguxpjT4zdj+BPcPZ/ZXFz9dDbZEl43s6mKZilf/OHS
	HMcMGNrDMoIdOsmsPUFrW0fOCsGNBfTGiioOfcAoSuAwhmveteAaEQqfoHF/+l52Qhj
	HO53qvp+fA==
Date: Thu, 28 May 2026 21:51:39 +0200 (CEST)
From: VolcomIlluminated <volcomilluminated@tuta.com>
To: Pkshih <pkshih@realtek.com>
Cc: Linux Wireless <linux-wireless@vger.kernel.org>
Message-ID: <Otk4rgS--F-9@tuta.com>
Subject: [PATCH] rtw88: tx: increase TX report timeout for USB devices
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_450625_629192785.1779997899218"
Feedback-ID: 01c4e8c013a2562e865d8b77e5b3f9fcabf876cc11e122ee288eb6e126f2764b3bcd8be2e44ea7adb908e52f58339be100204e013477eb10895d54267c0038bec6:TurnOnPrivacy!:tutamail
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tuta.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tuta.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37075-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[volcomilluminated@tuta.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[tuta.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5F5A65F7B5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

------=_Part_450625_629192785.1779997899218
Content-Type: multipart/alternative; 
	boundary="----=_Part_450626_1745181212.1779997899218"

------=_Part_450626_1745181212.1779997899218
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

patch attached!
------=_Part_450626_1745181212.1779997899218
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
<div dir="auto">patch attached!</div>  </body>
</html>

------=_Part_450626_1745181212.1779997899218--

------=_Part_450625_629192785.1779997899218
Content-Type: text/plain; charset=us-ascii; 
	name=0001-rtw88-tx-increase-USB-TX-report-timeout.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; 
	filename=0001-rtw88-tx-increase-USB-TX-report-timeout.txt

USB devices have higher latency than PCIe devices. The current 500ms
timeout for TX report purging causes "failed to get tx report from
firmware" errors on boot with USB WiFi adapters.

Introduce RTW_TX_PROBE_TIMEOUT_USB at 1000ms and select it based on
the HCI type. PCIe devices retain the original 500ms timeout.

Tested on RTL8822BU (Edimax EW-7822ULC) with zero TX report errors
across 24+ hour operation and 17,706 packets with zero drops.

Signed-off-by: VolcomIlluminated <volcomilluminated@tuta.com>
---
--- /tmp/linux-6.18/drivers/net/wireless/realtek/rtw88/tx.c	2025-11-30 17:42:10.000000000 -0500
+++ /home/ptpx86mm1/kernelbuild/linux-6.18/drivers/net/wireless/realtek/rtw88/tx.c	2026-05-24 16:28:06.013490121 -0400
@@ -197,6 +197,7 @@
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
 	unsigned long flags;
+	unsigned long timeout;
 	u8 *drv_data;
 
 	/* pass sn to tx report handler through driver data */
@@ -207,7 +208,9 @@
 	__skb_queue_tail(&tx_report->queue, skb);
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 
-	mod_timer(&tx_report->purge_timer, jiffies + RTW_TX_PROBE_TIMEOUT);
+	timeout = rtwdev->hci.type == RTW_HCI_TYPE_USB ?
+		RTW_TX_PROBE_TIMEOUT_USB : RTW_TX_PROBE_TIMEOUT;
+	mod_timer(&tx_report->purge_timer, jiffies + timeout);
 }
 EXPORT_SYMBOL(rtw_tx_report_enqueue);
 
--- /tmp/linux-6.18/drivers/net/wireless/realtek/rtw88/tx.h	2025-11-30 17:42:10.000000000 -0500
+++ /home/ptpx86mm1/kernelbuild/linux-6.18/drivers/net/wireless/realtek/rtw88/tx.h	2026-05-24 16:23:26.012668469 -0400
@@ -8,6 +8,7 @@
 #define RTK_TX_MAX_AGG_NUM_MASK		0x1f
 
 #define RTW_TX_PROBE_TIMEOUT		msecs_to_jiffies(500)
+#define RTW_TX_PROBE_TIMEOUT_USB	msecs_to_jiffies(1000)
 
 struct rtw_tx_desc {
 	__le32 w0;

------=_Part_450625_629192785.1779997899218--

