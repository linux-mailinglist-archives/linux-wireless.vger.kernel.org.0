Return-Path: <linux-wireless+bounces-35677-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLOqKW/j8mnyvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35677-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:06:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF6C49D81C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D92A31098CC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 05:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCF93783CE;
	Thu, 30 Apr 2026 04:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="TSy87SD3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED43783B4
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525154; cv=none; b=ZUCtNrli0QJ6wkOH6Vqko2jvU2RwOCiWCz6tRTgB97wOYTYTzkemEprLfo2pQUJ9JI6psTjmGJPYrW2kwcix7A2ncQZQZ0UgahCw33j8bGsQavBao9sCPbHSOvZsE+RLrU+DahelvUuvoQaIK/iRws5EVhh0k7lB1QfVYCNuCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525154; c=relaxed/simple;
	bh=hkqIxD6fVwrva+sURH2ILC6gvpJ1AoIctQTD/o6YFfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ/uW2GwAy9px1+CZIDgaCXhRy8zeETkP3SclR+duuVhgfpIG7phUAZybhYGv49HL/Ff03qYuLdJfQ7X/+TEaRXxCaTLnVZGAuSulJA/fhGhMCKjY74lDPLgXnyEZkFkhz/9zbcIqyMXbJ1TycU4SOVRJo40hMzt2byYmO1Or14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=TSy87SD3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82748257f5fso1187738b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525152; x=1778129952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQy1ndPr1uBGcXK/2u9XQYwgX/lXgKOA7MjvsIYLOWg=;
        b=TSy87SD3Ro7mYmbLiomniiNRLgyNCWUsqcP8nwk6imYcVZLO2c3oBD/CA1Xxf9kxL/
         4sN8LhXqayJ/7FaAWuQKTwgql0ZuWjYJbUh7wC/3dpffZYDcABAMpPXD67DtyLrzAiBM
         G6PIalgzzj6KgqgXEhBrIKXgWML62mztOPXLq7sUIOF0cZVQonwghQuP8hAPlpG8P//8
         I422pV9NOBYB4QcmsMkE8ynZUJ9f5QeCbcrNxKLUg9n3Yl3POyI+3fUW0Rzjt+SKbT/P
         JA63w2GDERLAyRw1jaX6uRwdMw0Iju2sQx0gb91xUPALG8LKNDR81bvWaqSw81owmb2s
         mSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525152; x=1778129952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQy1ndPr1uBGcXK/2u9XQYwgX/lXgKOA7MjvsIYLOWg=;
        b=o32d4G2pskco4I5RGHgX/hV3ccG6POYTgRzQNxX+a7SVC7e7ExlaP9FUEipKQbQLBF
         lgGaDk3SXO980XevLM+5iZzrogKsZ9EW4GUcSANZvMsgkHs8vpxTam3LqNr2XOS3KnVy
         BUhcsLGvFZ27hTAf4V+cjPNItb6z7tY31gAr2/M97xYpBLcnEleK/b+LRr0pviVLTkhs
         waTz8/zINb0qvXRO/0MA/UIL31LO7OGj8hINDbZVpqkIB9sMb5wDf3Qyv+kLWjsMgsc9
         zNivPi2AsVLwYQCrUcotbIe5ZOJzRABeABBMOE/IN9ekyBZB6TO+dBhv2Dvf6TECgsix
         wnAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xLr3csbWTCNt2FxiLra8G4RcuCl2gRmbE1hpERd10RUNO6zjzeJd7YEn5m6u3ShY+oJcrZfHfe+p1gth+2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLDO369NaounwmbkkUpS7yfcNCiKmIquaPt4kJmu3ULorV090
	hH9ed1MysaKXpf7oglH2SFfnv6a32YLy5PsECf7nIv4Sd0GYtQMX6aWy43SuubjwmYU=
X-Gm-Gg: AeBDievbKMY4LBIU9xAvrdUBAqvFRk/5da8RyssQ8nSBaPPjLoxRSqOWlHBFaZuKuNK
	j5Eeec8sPu4v4lVJ6SlkWzacAX/GyH0lENlJkKoir9/SpZDSXA0BCshm6/vr8IFUewbJ4JP1TLs
	VHmv8YCf5I3uOKi6EgcnWFy0x/jQU45GUJtqvEVVNfcolLNiIOm3asuKfjUuAAt1kUThtbbiF1t
	bWkww1AGgMcLiDLtuAUOqE0n27nm8gQ4PrEhac/1f7PEOE7ZliL/EZQYdOejjrrvWdc7cMGJHRy
	VZZETmrv0Bj8uqmr7NHHuBhi9FWUBse5ow1Mb6aoQMrXMcoXiOk25JAyMQ5GRX63FTTHcU6FcMj
	hyBWcwFaAXdhiztYUDH+Q8D+ck5B3d4+P6bGTDBWDsRoYsXnlA+ZsLS6Ns4SXK5+k4esLBCix3d
	vKnZGWZaDYNnrIFBvj+z7IeL7K9EUOA54EE6S+6vzhtIraO5LGZJIBarpKdQ1rZSffG9BaiIcDB
	mtBuBl7BNZxUVgo3JxPGufH94NPvqhBsF6N1WEMA540HpRCee1I
X-Received: by 2002:aa7:88d5:0:b0:82f:6eca:563e with SMTP id d2e1a72fcca58-835001b9118mr984090b3a.34.1777525152295;
        Wed, 29 Apr 2026 21:59:12 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:59:11 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 30/31] wifi: mm81x: add Kconfig and Makefile
Date: Thu, 30 Apr 2026 14:55:56 +1000
Message-ID: <20260430045615.334669-31-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0DF6C49D81C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35677-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20251104.gappssmtp.com:dkim,morsemicro.com:mid,morsemicro.com:email]

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


