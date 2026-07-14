Return-Path: <linux-wireless+bounces-39094-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kDl6LFt4VmqV6QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39094-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:56:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A59D757A7A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:56:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=fqNzrlgW;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39094-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39094-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A416A3159E5E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534AF3168E6;
	Tue, 14 Jul 2026 17:52:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166881A9F87
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 17:52:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051536; cv=none; b=mTbYXcWVsS2SjiCJjL6VkvczZAl0w7nqexkb89PkFeBJ+fRRXp11PpvNxKXYA6MlGSGY2kO9T/NihsPoidoMKvHnOjXtE68WSQ+LuW1Nsfu4qMA+J+DDXLIazZMGt+pBu43XqG+Dawvy9t1hXicyBe3Fwd1mXFshnCv5DhSwnYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051536; c=relaxed/simple;
	bh=bzny1nsXtTZZpXzvVY60/2RKit2GowUZ5Gx+W1mKIoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMV4guFEf0fbg2x0WI5DVqbvHBgNIX6MbLBBqeP0uwuKEZcmx+SDRJ9NnuJ5gZxKSWh9BLE1gupinzEbVfTwpffqCE6aMTCBwjhOnEaIhmKogIVz+QxkxMnqtkV+B3PrV5WHf2+9fC3swljB3a9OPlLxV0oz4VfER7X6Spze+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fqNzrlgW; arc=none smtp.client-ip=95.215.58.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784051529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRU0+t+7h1CBmRFv6+gJSvHrc2yCYySi/K/KzXsr6BM=;
	b=fqNzrlgWdoNhmfrVQkhKWx8Pze0mnS0Uq4jWHzYPrZHO0Kt6Kd0ga3C7YbXF16yl7k4E5e
	HCyvyqGhcBCZJiAW0JP/XCwg6w8uHzQQD2QflnVnoXUBn/NdDZYwtal8lObBPxCBboWlwf
	TS4lGRJHAHPfLt5Jxb7kminU/QAwoB8=
From: luka.gejak@linux.dev
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	straube.linux@gmail.com,
	luka.gejak@linux.dev
Subject: [RFC PATCH v1 5/9] wifi: rtw88: 8723bs: keep the chip powered between scan and connect
Date: Tue, 14 Jul 2026 19:51:03 +0200
Message-ID: <8c24a47ae730f5369a2ba0b9ad809aab3950f5e1.1784047561.git.luka.gejak@linux.dev>
In-Reply-To: <cover.1784047561.git.luka.gejak@linux.dev>
References: <cover.1784047561.git.luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-39094-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:pkshih@realtek.com,m:straube.linux@gmail.com,m:luka.gejak@linux.dev,m:straubelinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A59D757A7A

From: Luka Gejak <luka.gejak@linux.dev>

A full power-off/on cycle between scan and connect corrupts the RTL8723BS
8051 firmware's management TX scheduler; the vendor driver keeps the chip
powered across that boundary. Implement a "soft IPS" that keeps the chip
powered and the coex/RF state intact, and re-establish the PTA antenna
path and RF bus on IPS leave (the first channel program after a power-on
IQK needs a second pass once the RF PLL has settled).

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 drivers/net/wireless/realtek/rtw88/ps.c | 50 ++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index add5a20b8432..f620a8a7fdec 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -18,9 +18,33 @@ static int rtw_ips_pwr_up(struct rtw_dev *rtwdev)
 	if (ret)
 		rtw_err(rtwdev, "leave idle state failed\n");
 
-	rtw_coex_ips_notify(rtwdev, COEX_IPS_LEAVE);
+	if (rtw_is_8723bs_sdio(rtwdev)) {
+		/* The BT-side coex init in rtw_power_on switches 8723BS SDIO to
+		 * the BT antenna path (BB_SEL_BTG=0x280), corrupting the RF
+		 * 3-wire bus. Run the scan-path PS-TDMA/coex-table/PTA setup
+		 * (which restores the WiFi PTA path) instead of the generic
+		 * COEX_IPS_LEAVE notify that would re-run the BT-path init.
+		 */
+		rtwdev->coex.stat.wl_under_ips = false;
+		rtw_coex_write_scbd(rtwdev,
+				    COEX_SCBD_ACTIVE | COEX_SCBD_ONOFF, true);
+		rtw_coex_8723bs_scan_workaround(rtwdev);
+	} else {
+		rtw_coex_ips_notify(rtwdev, COEX_IPS_LEAVE);
+	}
+
 	rtw_set_channel(rtwdev);
 
+	if (rtw_is_8723bs_sdio(rtwdev)) {
+		/* The first set_channel after IPS-leave can read back an
+		 * incorrect RF00 because power_on wrote RF registers on the BT
+		 * antenna path. Re-run set_channel after a settling delay so
+		 * the RF PLL re-locks from a clean baseline.
+		 */
+		usleep_range(1500, 2000);
+		rtw_set_channel(rtwdev);
+	}
+
 	return ret;
 }
 
@@ -29,6 +53,17 @@ int rtw_enter_ips(struct rtw_dev *rtwdev)
 	if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags))
 		return 0;
 
+	/* 8723BS SDIO: a full power-off/on cycle between scan and connect
+	 * corrupts the 8051 firmware's management TX scheduler. The vendor
+	 * driver keeps the chip powered on across that boundary. Enter a
+	 * "soft IPS" instead: keep the chip powered and the coex/RF state
+	 * intact, so leave-IPS needs no power-on / phy_set_param reload.
+	 */
+	if (rtw_is_8723bs_sdio(rtwdev)) {
+		set_bit(RTW_FLAG_SOFT_IPS, rtwdev->flags);
+		return 0;
+	}
+
 	rtw_coex_ips_notify(rtwdev, COEX_IPS_ENTER);
 
 	rtw_core_stop(rtwdev);
@@ -50,6 +85,19 @@ int rtw_leave_ips(struct rtw_dev *rtwdev)
 {
 	int ret;
 
+	/* 8723BS SDIO soft IPS: the chip was never powered off. Clear the
+	 * soft-IPS flag and refresh the active WLAN scoreboard / PTA antenna
+	 * path; no power-on / phy_set_param is needed.
+	 */
+	if (test_bit(RTW_FLAG_SOFT_IPS, rtwdev->flags)) {
+		clear_bit(RTW_FLAG_SOFT_IPS, rtwdev->flags);
+		rtwdev->coex.stat.wl_under_ips = false;
+		rtw_coex_write_scbd(rtwdev,
+				    COEX_SCBD_ACTIVE | COEX_SCBD_ONOFF, true);
+		rtw_coex_8723bs_scan_workaround(rtwdev);
+		return 0;
+	}
+
 	if (test_bit(RTW_FLAG_POWERON, rtwdev->flags))
 		return 0;
 
-- 
2.55.0


