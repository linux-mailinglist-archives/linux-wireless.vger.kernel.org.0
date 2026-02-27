Return-Path: <linux-wireless+bounces-32273-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOOuIwEcoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32273-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:22:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E4A1B2A1C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 150CF307CDCA
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0A53033F5;
	Fri, 27 Feb 2026 04:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="FHevPlaC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D43542D6
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165723; cv=none; b=GXo919Om7qLWiy8Yz0QyEzzskPyqyZ+So+powRMI5NC0w/GxFpfb02lA/nz1+NbVqIrGzLaCTx9Dp/2nGirKnfg5QTQF/v1qGj6YRuADe2uKMwWGTUZCVjOzhZB0YvP+lqo8SFzAg4oV+A6pv8sxixkxhtjN0k6LKaw1u5nEJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165723; c=relaxed/simple;
	bh=Qk197MdwALKPpzdV61IR3loiMBnfsnu03bZRBaPS63k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atdu29c9AxBPEtjdBuiXZ5yoMHkwBPv5Vv4qxpza72y6q9+745SgwnI/W/VMLHqq8bfAKvXgY7SNo8k/znwDt0NWK3iLFhtvjnkisYlKP95KTG5lj0+HfnhDAw/8X85KegHhgNAxP3QScTSvfAmBUvk/pnx7EuYu5NKfojZoMeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=FHevPlaC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad9a9be502so10939285ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165721; x=1772770521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSBcL8i9Z7G8rYud35fWwvLn5o6pR7vEeqtMFTBWits=;
        b=FHevPlaCq6V3wtf2kQtOoHaKlX58kUbqSjDU+vZetqzrF4ZkpXljSsJPDpBKqMo4i5
         aaB8+WuKNKg1p70iw7Am9smD9o0abWW+GagUBtaSL2EOglXl/0q+r33KfmRbpsQj6PnD
         G63ocAjPnfNHWNJNG6fjV5P7YmrdCd3xNBVASkfg4gd55Old4qdKyY9Djt4ZQQDBxexU
         9pYljNauup1XLlviZdL8M08IVAhDWAUjYcJ7Nr7dPyA9Vkio4WTZ47zMdtPvNtDHami6
         62+3bGVlD4Bl9Xlj+IcxyjDnRvj7KydFZXbzXQ7tnEtGnnGovHxDozw0jGwqHScYzaUB
         inow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165721; x=1772770521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sSBcL8i9Z7G8rYud35fWwvLn5o6pR7vEeqtMFTBWits=;
        b=ClLs6R1V5gsKKkiw+BSVJ2YEQ1C1YQtD/lvi+0/Gqn9B7HeiKAj5KSZpCPgMMxh2hv
         AEkE1cICft2gYoS2VAlTTKUG9/bypYKThuC3mWLWyPccf6vlY1Ujpnrp1Raf60JadRg8
         NADc8EIFbjynFOUAea6ELHkfR8FYTrui0YZUZQzQ73LDwP8ofpvgSYMEzpEjBJ0+nLRM
         9qwRSm54vWw7kBnd7WTndw8N9DMmZBI59WwPB2ovFJjcf07cJfbHqBn+8WqLzL9p9jTA
         9S4JhnnD0JDGECJSq9Gnyq/XUVjRTxaSmy5vbBgvyDq8HIn7eLRgHXNSfXFFYOT69egf
         MwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlgwvdxiFeFUyAb2Rpc7XGQ2bP/+hD1z4+L2TpyyKF1rMP86KwWyosaEJ2rzZVvtKMO7akIbOamKsDCurvaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCkL5xn13DVwo0WCUx5obUT87y+xj9+7zcRP8Szz+aeE7w6uyZ
	lkFKX3l4F/DuEI+47YYG5NhGKpOytShRKIcgRpm6aCxecXBrA/HHxOqbGZMtvFoSQlk=
X-Gm-Gg: ATEYQzxCoJx7hzIt+dNBoROaC/ibPyWfVmzidpTtAEWQd098mVW5z4W1fhQoJZaPoS2
	Jt6uDF4dDkqzK2fobI6YEk9VsfATSuLnv4pcjqDbqGglk7L5uqiOVLrHfgY4f1A2Aeg+Rm4AXD0
	xb/8gQj0hkrd6BOYzYgUwGdr2g0Xo2CiyiKWapJer9FOFRK9NdK+JReeltEStJrq7h0aT2ncDZc
	QiVyVKYxa4t+dWe4b29yczc8UFIbF1SHWQH8PQRupCHAxLVcgIkZK2j1mxiQ79XludG0fZHDI6H
	74eeLbocoQC32ZRWRw+3MrxIRCmHpEzeg/AnBL8i25A9OIrZcSpfa1wovEn8kD32ufJcpVtP4FU
	eX9pBd1xaWWfinW/SP92Ga4GDQ6tcUyv+Nzr/Dj9nUmmJ0v/X+jelbRnNH7G7bO8d9McQ1MtJQT
	3CKWbq2ol2rnkE3jTDiCwzREvzCbll0IMBNwr2oIW5DV/EBiK5RmmS/8LSYJ5iyXxYPRJQGB8M4
	DEqNmKOIort7yd90n/wbnoacNCYUh8=
X-Received: by 2002:a17:902:d54a:b0:2ad:bd4c:a0 with SMTP id d9443c01a7336-2ae2e4bba1fmr14028125ad.47.1772165721235;
        Thu, 26 Feb 2026 20:15:21 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:15:21 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 34/35] wifi: mm81x: add Kconfig and Makefile
Date: Fri, 27 Feb 2026 15:10:44 +1100
Message-ID: <20260227041108.66508-35-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32273-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39E4A1B2A1C
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/Kconfig                  |  1 +
 drivers/net/wireless/Makefile                 |  1 +
 drivers/net/wireless/morsemicro/Kconfig       | 15 ++++++++
 drivers/net/wireless/morsemicro/Makefile      |  2 ++
 drivers/net/wireless/morsemicro/mm81x/Kconfig | 34 +++++++++++++++++++
 .../net/wireless/morsemicro/mm81x/Makefile    | 19 +++++++++++
 6 files changed, 72 insertions(+)
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
index 000000000000..b61953096dfc
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config MM81X
+	tristate "Morse Micro MM81x wireless driver"
+	depends on MAC80211
+	select FW_LOADER
+	select CRC7
+	help
+	  This enables the Morse Micro MM81x wireless driver.
+
+	  The driver supports USB and SDIO attached devices. Enable at least
+	  one of the bus options below to register the corresponding bus
+	  driver.
+
+if MM81X
+
+config MM81X_USB
+	bool "USB bus support"
+	depends on USB
+	help
+	  Enable USB bus support for Morse Micro MM81x devices.
+
+config MM81X_SDIO
+	bool "SDIO bus support"
+	depends on MMC
+	help
+	  Enable SDIO bus support for Morse Micro MM81x devices.
+
+config MM81X_DEBUG
+	bool "Enable debug logging"
+	help
+	  Enable extra debug logging and debug dump helpers.
+
+endif
diff --git a/drivers/net/wireless/morsemicro/mm81x/Makefile b/drivers/net/wireless/morsemicro/mm81x/Makefile
new file mode 100644
index 000000000000..b580d200b94a
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_MM81X) += mm81x.o
+
+mm81x-y += core.o
+mm81x-y += mac.o
+mm81x-y += hw.o
+mm81x-y += debug.o
+mm81x-y += fw.o
+mm81x-y += command.o
+mm81x-y += ps.o
+mm81x-y += skbq.o
+mm81x-y += yaps_hw.o
+mm81x-y += yaps.o
+mm81x-y += rc.o
+mm81x-y += mmrc.o
+
+mm81x-$(CONFIG_MM81X_USB) += usb.o
+mm81x-$(CONFIG_MM81X_SDIO) += sdio.o
-- 
2.43.0


