Return-Path: <linux-wireless+bounces-21822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D55A95C8E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 05:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F9E1741FB
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC24517D346;
	Tue, 22 Apr 2025 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="UFtDmVPu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8DB15E90;
	Tue, 22 Apr 2025 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.165.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745292117; cv=none; b=KY/IkL7tB1m0fpzPdc/Sf71PMlURGbJGTGITczQHHTK8r0Mc8HH1Hbe6tush8PalEYRHTD25N75hjof4F94EKb6EO6QvjaoB3/FrTzlI4xNn3bLukThUkK9lBW6eWD/wMHD4huk69oUv+2d0T9apIkW9AyTXm8SoNbWjyxN++RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745292117; c=relaxed/simple;
	bh=a1kzD1ez9MdASOV6/mbftHpGw7HTKF9+BrEz5gtZV+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnrqSn7GofqY2WGZqO/A0Z3j6TQqNYim0/QrCUTGlkgh+klzYqfIzryFuXGZYBFIq+LTISo6rb89Z9isCs0Pltvo8IO0ddM3ACz78GRiqt25lpRhXFUAhAErMFMsi1RPKZ/deCYANxxxNCwRm49ulxgJpfCW9vybUMhSpHta5dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=UFtDmVPu; arc=none smtp.client-ip=151.80.165.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id D55653E886;
	Tue, 22 Apr 2025 03:21:47 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 7883140009;
	Tue, 22 Apr 2025 03:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1745292107; bh=a1kzD1ez9MdASOV6/mbftHpGw7HTKF9+BrEz5gtZV+k=;
	h=From:To:Cc:Subject:Date:From;
	b=UFtDmVPuzp9PBZXWEyvq2g+7ib3PMq620GpWnMrv8HQTEBNWXT14mdSILua+l5CYA
	 HTUMumgJdzM/3Xu/Ql4j3EHkGi8xxHoGY5WpneGMQGgE592FbCP6gzWB7AJVVi9CoR
	 vyaXqxdOz18umWoUZFdqXZpp3hDXS/zfAAmYtZOQ=
Received: from JellyZhongke.localdomain (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id C38D8407DA;
	Tue, 22 Apr 2025 03:21:43 +0000 (UTC)
From: Mingcong Bai <jeffbai@aosc.io>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>,
	Mingcong Bai <jeffbai@aosc.io>,
	stable@vger.kernel.org,
	Liangliang Zou <rawdiamondmc@outlook.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-wireless@vger.kernel.org (open list:REALTEK WIRELESS DRIVER (rtlwifi family)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH rtw-next] wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723
Date: Tue, 22 Apr 2025 11:21:31 +0800
Message-ID: <20250422032132.348598-1-jeffbai@aosc.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7883140009
X-Rspamd-Server: nf1.mymailcheap.com
X-Spamd-Result: default: False [3.40 / 10.00];
	FORGED_RECIPIENTS(2.00)[m:kexybiscuit@aosc.io,m:jeffbai@aosc.io,s:linux-kernel@vger.kernel.org];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[stable.vger.kernel.org:server fail,rawdiamondmc.outlook.com:server fail,jeffbai.aosc.io:server fail];
	FREEMAIL_CC(0.00)[aosc.io,vger.kernel.org,outlook.com,tuxdriver.com,lwfinger.net];
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

Cc: <stable@vger.kernel.org>
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


