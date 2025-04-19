Return-Path: <linux-wireless+bounces-21751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F68BA9423A
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1B8189E4A5
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230FE1A2860;
	Sat, 19 Apr 2025 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="n2r2y6cB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A317BEB6;
	Sat, 19 Apr 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745050405; cv=none; b=Jf03hxecVvKWvQZkuMVmp7kpZbLhB+OXUfTLtt4bgTN1iviFhYFtOFlNxVqsh86I3iYM7hts6AATh6wkigPRIYVmjp+Q5+NSTajFcM75lbUPApgO0RIcOPnnjUk+rAHPoGERGOWgwNhuz1Qqnu02RI6qX2cOqd6Y1vZBlt/LQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745050405; c=relaxed/simple;
	bh=h20O5mtqoh2oXGg2M9J4OqV9FerlYNY6edRK0mT37k4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7AqE5AnyleOMeQLpKWJfyj95W6mHmZOxMOKdOgzlwKoA+vjpxx4ZXluitY97u3jMxXJgKqm6NPUHDYLr/+BOQSSSLdG0KwyEbsuxMBWPQTAdoPqJFPRN99blUKsXwnj+7MNVeYGPLtga7RdqTcAg50gxyGVrxAbabaKhPfuW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=n2r2y6cB; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id CC4342618F;
	Sat, 19 Apr 2025 08:13:14 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 99A6D3E8FD;
	Sat, 19 Apr 2025 08:13:06 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 617CA400F8;
	Sat, 19 Apr 2025 08:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1745050384; bh=h20O5mtqoh2oXGg2M9J4OqV9FerlYNY6edRK0mT37k4=;
	h=From:To:Cc:Subject:Date:From;
	b=n2r2y6cBYz+v+L6R7fjjgB8DiomPxgD778zxyGcLKVevZdCCPOYkEJ0mjd8rMLE0l
	 tWC/G9bHRmHcUjP74wK10fnwzdUL3OO/IePtlFxR0jCqOJ5yVHu/lYR+Z4HAlG4It9
	 RBQsU3i/JMXSz5sy5OsStp4GVQ1q9fBWsrce/7AQ=
Received: from JellyNote.localdomain (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id BA7E3406FC;
	Sat, 19 Apr 2025 08:13:00 +0000 (UTC)
From: Mingcong Bai <jeffbai@aosc.io>
To: linux-kernel@vger.kernel.org
Cc: Kexy Biscuit <kexybiscuit@aosc.io>,
	Mingcong Bai <jeffbai@aosc.io>,
	Liangliang Zou <rawdiamondmc@outlook.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-wireless@vger.kernel.org
Subject: [RFC PATCH] wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723
Date: Sat, 19 Apr 2025 16:12:50 +0800
Message-ID: <20250419081251.285987-1-jeffbai@aosc.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 617CA400F8
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[rawdiamondmc.outlook.com:server fail,jeffbai.aosc.io:server fail];
	FREEMAIL_CC(0.00)[aosc.io,outlook.com,realtek.com,tuxdriver.com,lwfinger.net,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action

RTL8723BE found on some ASUSTek laptops, such as F441U and X555UQ with
subsystem ID 11ad:1723 are known to output large amounts of PCIe AER
errors during and after boot up, causing heavy lags and at times lock-ups:

  pcieport 0000:00:1c.5: AER: Correctable error message received from 0000:00:1c.5
  pcieport 0000:00:1c.5: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
  pcieport 0000:00:1c.5:    [ 0] RxErr

Disable ASPM on this combo as a quirk.

This patch is a revision of a previous patch (linked below) which
attempted to disable ASPM for RTL8723BE on all Intel Skylake and Kaby Lake
PCIe bridges. I take a more conservative approach as all known reports
point to ASUSTek laptops of these two generations with this particular
wireless card.

Please note, however, before the rtl8723be finishes probing, the AER
errors remained. After the module finishes probing, all AER errors would
indeed be eliminated, along with heavy lags, poor network throughput,
and/or occasional lock-ups.

Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
Reported-by: Liangliang Zou <rawdiamondmc@outlook.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218127
Link: https://lore.kernel.org/lkml/05390e0b-27fd-4190-971e-e70a498c8221@lwfinger.net/T/
Tested-by: Liangliang Zou <rawdiamondmc@outlook.com>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 0eafc4d125f9..898f597f70a9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -155,6 +155,16 @@ static void _rtl_pci_update_default_setting(struct ieee80211_hw *hw)
 	    ((u8)init_aspm) == (PCI_EXP_LNKCTL_ASPM_L0S |
 				PCI_EXP_LNKCTL_ASPM_L1 | PCI_EXP_LNKCTL_CCC))
 		ppsc->support_aspm = false;
+
+	/* RTL8723BE found on some ASUSTek laptops, such as F441U and
+	 * X555UQ with subsystem ID 11ad:1723 are known to output large
+	 * amounts of PCIe AER errors during and after boot up, causing
+	 * heavy lags, poor network throughput, and occasional lock-ups.
+	 */
+	if (rtlpriv->rtlhal.hw_type == HARDWARE_TYPE_RTL8723BE &&
+	    (rtlpci->pdev->subsystem_vendor == 0x11ad &&
+	     rtlpci->pdev->subsystem_device == 0x1723))
+		ppsc->support_aspm = false;
 }
 
 static bool _rtl_pci_platform_switch_device_pci_aspm(
-- 
2.49.0


