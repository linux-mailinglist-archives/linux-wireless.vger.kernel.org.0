Return-Path: <linux-wireless+bounces-34999-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDDLCIyg5WkqmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-34999-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D6F42695D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 896F930157E2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05841377006;
	Mon, 20 Apr 2026 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hMRC3JI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798DB3783D4
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656504; cv=none; b=SraPEyJt34ryasocRaiDYfdeeBK3bN4c58HI4uMpNVNPhdRNknlt32veWI0EFP2DBtGACZGKF13ezpiRg11ko19zwKooPm9JiEj/wdnpsB2geBnl7Smy0xphVbHbos32wbd4B19Mq8FCyT1WM446NWr5qSkutLmlMjZr/f/wZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656504; c=relaxed/simple;
	bh=8eZtbBwY8ZlqXbCyWH3sM4V2T+hwbZdldlw/WPP4LF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfP8mdr2Jp2CurunSZ79hvAIgaDNuxxtWgIIzvYQWfYvUMsTLumJaNZlzRU24sW1i2ccDHlRw16lbFMMxg/48jBdt9LvfGiLopW3djy43H+xC36w0Z8gXCXK78upQ/x+nI9y29KgSPDcI5/0/G08DEDaOCnPlOC+/9RHuwDP8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hMRC3JI+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3ffWcB426773, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656501; bh=nCGEx4CzU+pugD3PBSZdHHd3F6GjONZkmhNAHXjNt/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=hMRC3JI+P8kA5WLiOEQUio4CnU2LpuKQCFNtQ61ufcdJpsqXZQNayDIsEwA8A3Hrf
	 pnb7Ar9zN974EIQ1q3wwX+p03dAYA2OvKFIfhT8raULdjcCECL6dndAz+3fOGS5/Zx
	 A2TU9E8XmxKM3jrzc7KgjMRaJ/3cLdy1DVFJZIB4CSV2c2WEtkcFsf3w+i+Q+MJ8eQ
	 p+ujQgRjOHc44ODW1x6ueXZyrW/spxQWIU91JP/WATALwLFY+eirM+gfDkCL6/JRls
	 SLYSvNb54HVSrPD1R/1WI6UVp8JFA+jLrF8BmxORpN8MQdQObaWkvOKYyf5wAIEnP+
	 8tZ8OT2it8ABA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3ffWcB426773
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:41:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:41:41 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:41:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 06/16] wifi: rtw89: Correct data type for scan index to avoid infinite loop
Date: Mon, 20 Apr 2026 11:40:41 +0800
Message-ID: <20260420034051.17666-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-34999-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D5D6F42695D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shin-Yi Lin <isaiah@realtek.com>

A kernel soft lockup was observed during Wi-Fi scanning on the 6GHz band.
The CPU becomes stuck in rtw89_hw_scan_add_chan_ax for over 20 seconds,
leading to a system panic.

RIP points to 0f b6 c3 (movzbl %bl, %eax), which zero-extends
the low 8 bits of RBX into RAX.
RBX (the counter i) has reached a huge value: 0x137466a1.

  watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [kworker/u16:4:6124]
  Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
  RIP: 0010:rtw89_hw_scan_add_chan_ax+0xb3/0x6e0 [rtw89_core]
  Code: a0 48 89 45 a8 44 89 6d 9c 44 89 75 98 eb 29 66 66 2e 0f 1f
  84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 c3 01
  <0f> b6 c3 41 3b 44 24 74 0f 83 0b 02 00 00 0f b6 c3 48 8d 14 80 49
  RSP: 0018:ffffcb48cbaa39f8 EFLAGS: 00000202
  RAX: 0000000000000005 RBX: 00000000137466a1 RCX: 0000000000000000
  RDX: ffff89ffc9d851a8 RSI: 0000000000004f0d RDI: 0000000096af0130
  RBP: ffffcb48cbaa3a60 R08: 0000000000000000 R09: ffff8a00b7502080
  R10: ffff8a00b75ff600 R11: 0000000000000000 R12: ffff89ffc7553870
  R13: ffff8a00b7ac8f19 R14: ffff8a00b75020d8 R15: ffff89ffc3d54d80
  FS:  0000000000000000(0000) GS:ffff8a014f962000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007558d7f9f4c4 CR3: 0000000178040001 CR4: 00000000001706f0
  Call Trace:
   <TASK>
   rtw89_hw_scan_prep_chan_list_ax+0x8a/0x400 [rtw89_core]
   rtw89_hw_scan_start+0x546/0x8a0 [rtw89_core]
   ? rtw89_fw_h2c_default_cmac_tbl+0x13c/0x1f0 [rtw89_core]
   rtw89_ops_hw_scan+0xae/0x120 [rtw89_core]
   drv_hw_scan+0xbb/0x180 [mac80211]
   __ieee80211_start_scan+0x2fc/0x750 [mac80211]
   ieee80211_request_scan+0xe/0x20 [mac80211]
   ieee80211_scan+0x123/0x190 [mac80211]
   rdev_scan+0x40/0x110 [cfg80211]
   cfg80211_scan_6ghz+0x5a1/0xa30 [cfg80211]

By objdump with source:

	for (i = 0; i < req->n_6ghz_params; i++) {
   5fbc0:	83 c3 01             	add    $0x1,%ebx --> i++
   5fbc3:	0f b6 c3             	movzbl %bl,%eax  --> get counter
   fbc6:	41 3b 44 24 74       	cmp    0x74(%r12),%eax

   * RBX: 00000000137466a1 -> %bl = a1 -> EAX = 000000a1 (161)

Fixes: c6aa9a9c4725 ("wifi: rtw89: add RNR support for 6 GHz scan")
Signed-off-by: Shin-Yi Lin <isaiah@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 17704f054727..089c9071b58f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8318,7 +8318,7 @@ static int rtw89_update_6ghz_rnr_chan_ax(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb;
 	bool found;
 	int ret = 0;
-	u8 i;
+	u32 i;
 
 	if (!req->n_6ghz_params)
 		return 0;
-- 
2.25.1


