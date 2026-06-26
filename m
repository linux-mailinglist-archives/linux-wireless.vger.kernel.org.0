Return-Path: <linux-wireless+bounces-38143-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wTttDgYgPmqBAAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38143-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:45:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CED6CABAC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:45:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=KClJLtos;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38143-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38143-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFFDE3026F2D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9D93DC4D8;
	Fri, 26 Jun 2026 06:33:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34523D9020
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:33:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455635; cv=none; b=OGSYIMjobzplx9QwnsGs8ZNyPq15rNWTk8sjhwQYYUq68T1x82IwMQFArzOcFEAojzSW991vVpjFMoXuBknz9p+0l74HvuKR9byTlLhkodvvenepqCT8OD12kJK8hTCmcIRhHF6pz8F8jAZSY8u63d5bHihhgadzxL/TuOFNZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455635; c=relaxed/simple;
	bh=hkqIxD6fVwrva+sURH2ILC6gvpJ1AoIctQTD/o6YFfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJ5HP9peeIhZFbPQ38GenNwrQxGL0q2izUfajvKS+f/sjKRJD7TESffrNGbICePcJpUVTEmf9KhvhWJobJQQrq06xDozMwT05z5E2ZUgAMiFksleXj/ye6S8I0ZrmU3/8QW5PwiD6xpiNlb+RTQdwO8W32JT86AXK0F2PTupq+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=KClJLtos; arc=none smtp.client-ip=74.125.82.53
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1384ebe7a10so346185c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455633; x=1783060433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQy1ndPr1uBGcXK/2u9XQYwgX/lXgKOA7MjvsIYLOWg=;
        b=KClJLtosNNVm6FV6Sd0gFBDSpk4ZPqqJfGeU+bfPi3g2OQZot/pgUxbtHQ4XHEOVAh
         v7SEuIsdkkD3qmzcd/Ey4n64kI9aEzUerN6xxt7k3UdH8rL7fTuxHniRRNNF7MD1OO/r
         E4KyDBSi6oE6M1C1by5rQc4mWaArfGCGZPNU9Z1ul+7NWI3CORpE8EIpK/jGe+DQSGRt
         lwc40WILPZUMklPpOlp9VkAQIfZHZwd6zOjcTEO9hU2yfkc4+6yb9/W/1uS/GQfmFZjy
         T7OMFHulavljsPbA5FVFqb5b3sTejGDbRqg5Gs6FAyfFGXKVCdD23B6R9ecQRRNxr0xO
         kTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455633; x=1783060433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQy1ndPr1uBGcXK/2u9XQYwgX/lXgKOA7MjvsIYLOWg=;
        b=NRy+5qx7pF8p2SdLOaSZ89wXx5dV5qmTatsbIEMR8i5NsNB76/hDT42go0i0WubxiV
         Jgc9hcteOfWZmeN8MQtvC4+Sa4cCzDoDr8Do7JUKT2M+UUvtnNGqCZI7r3A32FrgUQEt
         5TbFHUDGoyANeOUQ68/Gg+j6QE9cDl/ZeOMHUrB90tJY9QKcEGKj1oRL9b5+DNWQsyAq
         caQK69TQAkYBLP6PQ/XzT0nljFJfHdpYvJbw2y06EEgeo7qp8L6dilj7jQb7ff5gnz6D
         Q/3hT1j1NxbHrAts4xNg5hdgt+/s1CQ2H+Nv77kaBi6xSaebvVRpgNRa6pBd/Ikg2/vS
         fkjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dgIy7k5gFrWm91OTt0rfMEWCtUEquYcKs/8OE6aCYB4fjZfD//osVoPlbqnrHpCzSpwLrB9qZ3PuvLwnHgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxafzdWUy52EMB1KDtGY1UkPUyhmOe34joaFvFGCjAlXuwpqH+5
	HtxWCN/L3I0x4wArA7KICjwctLz7kDPUXSAxPJKdh313Vvob/MCor0Qt8utOzVrp1MdUIlE4QY0
	sVP8VA1I=
X-Gm-Gg: AfdE7cldBPe5PG2zVFkEtRBjc3A8GWYzaej1QTscrJcElzVl9392GAREI+lYWvwgYFL
	bpMK0Qnb31oyhRo+R/wwkEfcIYE4LoLHPtc3fYlHZSN9cNiWaNotweU1Z9/1loeFrJem4MCITlm
	P93nt9/g77RRoH3GoHbs6E8ZQg6MFix0F6SFFvMuv9D9Kw5vaMWN7DsIAI9jqq/tmM19fO0nPR4
	aln68nj5vFmj6dDmvFwT/GBZ0g3GxBYTZESXOb4wGgRPkreEwPClERjV2tT3vRljnlYJ17GGfXK
	+Hjn7bF0XlhBMnS2qhqeM5hb/PIKb9iV00nRMa8k7ppKal0RJn0eJ+qTvRy833zRrWxUwgHKYDD
	agTGMgdToPCUTV8vaqZFTeJ2NXX7TGWSvVkUztOynN8LKx9gnaThMos1OIFIR9tYAscocIKx89B
	XbNngo4yagIDAy1pOADaeDEL92XQtsZQP6x57NsTuIrM00RZoLtS8JeraIS77mRiNprElwTCuHw
	sPYeC9HP632hhrCYVP9
X-Received: by 2002:a05:7022:490:b0:128:d4be:7428 with SMTP id a92af1059eb24-139dbb5b228mr4793574c88.19.1782455625408;
        Thu, 25 Jun 2026 23:33:45 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:33:45 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 32/33] wifi: mm81x: add Kconfig and Makefile
Date: Fri, 26 Jun 2026 16:29:28 +1000
Message-ID: <20260626063014.1275235-33-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38143-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35CED6CABAC

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/Kconfig                  |  1 +
 drivers/net/wireless/Makefile                 |  1 +
 drivers/net/wireless/morsemicro/Kconfig       | 15 ++++++++++++
 drivers/net/wireless/morsemicro/Makefile      |  2 ++
 drivers/net/wireless/morsemicro/mm81x/Kconfig | 24 +++++++++++++++++++
 .../net/wireless/morsemicro/mm81x/Makefile    | 21 ++++++++++++++++
 6 files changed, 64 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/Kconfig
 create mode 100644 drivers/net/wireless/morsemicro/Makefile
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/Kconfig
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/Makefile

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index c6599594dc99..baddadf9ec3c 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/intersil/Kconfig"
 source "drivers/net/wireless/marvell/Kconfig"
 source "drivers/net/wireless/mediatek/Kconfig"
 source "drivers/net/wireless/microchip/Kconfig"
+source "drivers/net/wireless/morsemicro/Kconfig"
 source "drivers/net/wireless/purelifi/Kconfig"
 source "drivers/net/wireless/ralink/Kconfig"
 source "drivers/net/wireless/realtek/Kconfig"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index e1c4141c6004..d74f817b37de 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_WLAN_VENDOR_INTERSIL) += intersil/
 obj-$(CONFIG_WLAN_VENDOR_MARVELL) += marvell/
 obj-$(CONFIG_WLAN_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_WLAN_VENDOR_MICROCHIP) += microchip/
+obj-$(CONFIG_WLAN_VENDOR_MORSEMICRO) += morsemicro/
 obj-$(CONFIG_WLAN_VENDOR_PURELIFI) += purelifi/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) += quantenna/
 obj-$(CONFIG_WLAN_VENDOR_RALINK) += ralink/
diff --git a/drivers/net/wireless/morsemicro/Kconfig b/drivers/net/wireless/morsemicro/Kconfig
new file mode 100644
index 000000000000..cb0653c77d87
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config WLAN_VENDOR_MORSEMICRO
+	bool "Morse Micro devices"
+	default y
+	help
+	  If you have a wireless card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all the
+	  questions about these cards. If you say Y, you will be asked for
+	  your specific card in the following questions.
+
+if WLAN_VENDOR_MORSEMICRO
+source "drivers/net/wireless/morsemicro/mm81x/Kconfig"
+endif # WLAN_VENDOR_MORSEMICRO
diff --git a/drivers/net/wireless/morsemicro/Makefile b/drivers/net/wireless/morsemicro/Makefile
new file mode 100644
index 000000000000..5b2670f7d171
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MM81X) += mm81x/
diff --git a/drivers/net/wireless/morsemicro/mm81x/Kconfig b/drivers/net/wireless/morsemicro/mm81x/Kconfig
new file mode 100644
index 000000000000..33cdcc0df4de
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/Kconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config MM81X
+	tristate "Morse Micro MM81x wireless devices"
+	depends on MAC80211
+	select FW_LOADER
+	select CRC7
+	help
+	  This module adds support for wireless devices based
+	  on Morse Micro MM81xx chipsets.
+
+config MM81X_USB
+	tristate "Morse Micro MM81x USB support"
+	depends on MM81X && USB
+	help
+	  This module adds support for the USB interface of
+	  devices using the Morse Micro MM81x chipset.
+
+config MM81X_SDIO
+	tristate "Morse Micro MM81x SDIO support"
+	depends on MM81X && MMC
+	help
+	  This module adds support for the SDIO interface of
+	  devices using the Morse Micro MM81x chipset.
diff --git a/drivers/net/wireless/morsemicro/mm81x/Makefile b/drivers/net/wireless/morsemicro/mm81x/Makefile
new file mode 100644
index 000000000000..0d494fda1412
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_MM81X) += mm81x_core.o
+
+mm81x_core-y += core.o
+mm81x_core-y += mac.o
+mm81x_core-y += hw.o
+mm81x_core-y += fw.o
+mm81x_core-y += command.o
+mm81x_core-y += ps.o
+mm81x_core-y += skbq.o
+mm81x_core-y += yaps_hw.o
+mm81x_core-y += yaps.o
+mm81x_core-y += rc.o
+mm81x_core-y += mmrc.o
+
+obj-$(CONFIG_MM81X_USB) += mm81x_usb.o
+mm81x_usb-y += usb.o
+
+obj-$(CONFIG_MM81X_SDIO) += mm81x_sdio.o
+mm81x_sdio-y += sdio.o
-- 
2.43.0


