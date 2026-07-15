Return-Path: <linux-wireless+bounces-39124-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ttL1GHsQV2ovEwEAu9opvQ
	(envelope-from <linux-wireless+bounces-39124-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 06:45:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A7F75A80E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 06:45:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39124-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39124-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=live.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFD2F304FA55
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 04:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCEE56A;
	Wed, 15 Jul 2026 04:45:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A86B54723
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 04:45:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784090728; cv=none; b=LVCWKUqlk6jAhPCF5KQEohm1RZvyo9CvolMmKsw8UOZfIew0TulxokFw7YIOHHR6t2GGKlnooW/CJ70ELaToz2RFqHyXkLtiT9518WFHrn5Imj7zOvlUJpnNTLhbiIxLXmK3p8EQJ2D6cDARtJrAtUfwZ929UnQn0BG6oqxP1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784090728; c=relaxed/simple;
	bh=0SKVwV/l8v7isum5HYv9wLdmuhlQpIQnBAHQWV69h9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c047OurTpG9ljCTFT4Ha9uXSOXhogvJbkH59PZbsDGjz1wnIIFkoRiPu1CD9Ee7VJIXKN19qbodOR5UeTnlxSGBTy1HVopdez8dHXJfYxK1Im7Vjyln8iOZtOwesTiIH8WY1JE81+zoaGUe6XfhGwBHkXH/R5zhYPOaXq90JI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.54
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-668005ba03cso2413974d50.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 21:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784090726; x=1784695526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JWW74AmImRLmdesZdoy1+m1+TdvbqosVmdq9Fea4fTA=;
        b=m9AB2/KWN8+btD95UqB65PUYdmy1B6aFrB1yHH4aiZnFB+4sdX0wOX/zJ8XMaFCkfj
         WddDDr1w2JhKjMeSazFo8dBX6em3fpez5NztlcE00vcA8uMG0MzyM9mrtnRfIKm9CS3u
         rX6sXcqg2J5S5AnMiS4XHs6FTIbRJoeS5ILdLhADkBia4xlEfJoppnehukhc4BTwQ8mC
         HIlYzvfzHH3xolijMb/dyFmf4SgErqbWnK3oQ7ftw7Iv7cB3qk5HYKW8H6/MMi6VbM0+
         iZkrzavotvgkcaRCEmfLgGcnsNpPp8EWBmhfTu5H3/rPJGwHkBMh+RtkyXPPNdyY2Tdc
         SmiA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8q6z4wJgfXVKyvYuUqK6j0cXtpV6KnXHk29r8nhk+p9dMfZbCqOYnafdTS3Dc+cVL4mcGQP/bAwJio1McQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcevTCrbmIydr3QiVrGZMHaWufHnVm6lud8wyP2hyzHO9Qs6sn
	2hup6q35JKw1QgkcHlIy5yTAIlkDouNtZOT1cyJGJSKnxyry/FwhgDS6
X-Gm-Gg: AfdE7ck/JnUEdjVC7K37XBnRDpEyQARllE9lfEBUiz44DzTpy38RBXl5wycg+rxM5aN
	OF6LPCfW3YwIVr0dpupQ6GgkFoBiNl2hd/83hyplBhuyEApB5F0oeBULaF4i+ozHgKGdiHuySAS
	VZ2zrU0ihUaar+T+NeeA9Z+g8ntufkh/BrCb+BiZJtlTEuzKcrqHhCEqE77YALhGYDZ7pDDgDqm
	yHgZNR0wJrhLxB+/5LzOqk5Yb6nNqveiW24hrVqeSKDpT172U54+856+8Y+a9EM/UZE0pVj604f
	FraL6b0rsiPjGmdo17g8cCMMRnFCfJD2DOprnLfmLN9u6t9CxVTVsVPpbgmh3Zc9zHwd6harV+h
	j01m1F8mtWAGzfGurSqm9AvefTLWmQgjbm02rWcwKLgBZTcop6nojGO3jRJHEfCqZQEZDa/QdWz
	UYZW6AFVZZh0RDKRY=
X-Received: by 2002:a05:690e:440c:b0:660:a41d:d180 with SMTP id 956f58d0204a3-668029bb4c1mr3288750d50.21.1784090725993;
        Tue, 14 Jul 2026 21:45:25 -0700 (PDT)
Received: from Mateus-Laptop ([2804:7f3:4a10:896d:88ce:72d6:47ee:a87d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667874c2d15sm17941180d50.0.2026.07.14.21.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 21:45:25 -0700 (PDT)
From: "Mateus B. Cassiano" <mbc07@live.com>
To: nbd@nbd.name
Cc: lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	"Mateus B. Cassiano" <mbc07@live.com>
Subject: [PATCH] wifi: mt76: pass LED define via ccflags-y in driver submodules
Date: Wed, 15 Jul 2026 00:44:32 -0400
Message-ID: <20260715044431.1207-2-mbc07@live.com>
X-Mailer: git-send-email 2.55.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[live.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:mbc07@live.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39124-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[mbc07@live.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,mediatek.com,vger.kernel.org,lists.infradead.org,live.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbc07@live.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[live.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,live.com:from_mime,live.com:email,live.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3A7F75A80E

Commit d2b01fbc329b ("mt76: pass LED define via ccflags-y")
converted the top-level Makefile from the deprecated EXTRA_CFLAGS
to ccflags-y so that -DCONFIG_MT76_LEDS keeps working now that
kbuild no longer honours EXTRA_CFLAGS.

However, ccflags-y (like EXTRA_CFLAGS before it) only applies to
the kbuild makefile it is set in and is not inherited by
subdirectories pulled in via obj-y/obj-m. The mt7603, mt7615 and
mt7915 driver subdirectories each set their own
"EXTRA_CFLAGS += ... -DCONFIG_MT76_LEDS", which is now a silent
no-op. As a result, CONFIG_MT76_LEDS is undefined when building
mt7603/init.c, mt7615/init.c, mt7615/pci_init.c and mt7915/init.c,
the IS_ENABLED(CONFIG_MT76_LEDS) blocks are compiled out, and the
mt76-* LED class devices are never registered for these drivers.

Convert these subdirectory Makefiles to ccflags-y as well.

mt7996/Makefile never carried the define at all, even though
mt7996/init.c has the same IS_ENABLED(CONFIG_MT76_LEDS) checks for
its LED callbacks and GPIO mux setup. Add ccflags-y there too so
mt7996 LED support is enabled consistently with the other drivers.

mt76x0, mt76x2, mt7921 and mt7925 contain no CONFIG_MT76_LEDS
references and are left untouched.

Fixes: d2b01fbc329b ("mt76: pass LED define via ccflags-y")
Link: https://github.com/openwrt/mt76/issues/1077
Signed-off-by: Mateus B. Cassiano <mbc07@live.com>
---
Notes for reviewers (not for the commit message):

Previously submitted as https://github.com/openwrt/mt76/pull/1090
before I noticed that PRs on the GitHub mirror don't seem to be
reviewed.

Tested on a D-Link DIR-882 A1 (dual MT7615 radios) by building
OpenWrt at commit e4c35c2eec66 with this change applied to the mt76
package: the mt76-* LED class devices appeared again under
/sys/class/leds. The same result was reported on different MT7615
hardware in
https://github.com/openwrt/mt76/issues/1077#issuecomment-4557037203

The mt7603 and mt7915 hunks are the same fix applied for consistency,
but I don't have that hardware to test.

mt7996 in particular enables IS_ENABLED(CONFIG_MT76_LEDS) code paths
that appear to have never been built with the define before, so it
would be good if someone with mt7996 hardware could confirm nothing
regresses. I'm happy to drop the mt7996 hunk and keep only the others
if preferred.
 mt7603/Makefile | 2 +-
 mt7615/Makefile | 2 +-
 mt7915/Makefile | 2 +-
 mt7996/Makefile | 1 +
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mt7603/Makefile b/mt7603/Makefile
index 57d28591..5e7ab30f 100644
--- a/mt7603/Makefile
+++ b/mt7603/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: BSD-3-Clause-Clear
-EXTRA_CFLAGS += -Werror -DCONFIG_MT76_LEDS
+ccflags-y += -Werror -DCONFIG_MT76_LEDS
 obj-m += mt7603e.o
 
 mt7603e-y := \
diff --git a/mt7615/Makefile b/mt7615/Makefile
index 9274c006..8b8eff3f 100644
--- a/mt7615/Makefile
+++ b/mt7615/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause-Clear
 
-EXTRA_CFLAGS += -DCONFIG_MT76_LEDS
+ccflags-y += -DCONFIG_MT76_LEDS
 obj-$(CONFIG_MT7615_COMMON) += mt7615-common.o
 obj-$(CONFIG_MT7615E) += mt7615e.o
 obj-$(CONFIG_MT7663_USB_SDIO_COMMON) += mt7663-usb-sdio-common.o
diff --git a/mt7915/Makefile b/mt7915/Makefile
index 6b0058ca..7ea5b05c 100644
--- a/mt7915/Makefile
+++ b/mt7915/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause-Clear
 
-EXTRA_CFLAGS += -DCONFIG_MT76_LEDS
+ccflags-y += -DCONFIG_MT76_LEDS
 obj-$(CONFIG_MT7915E) += mt7915e.o
 
 mt7915e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
diff --git a/mt7996/Makefile b/mt7996/Makefile
index 69d2d4bb..28ecee3c 100644
--- a/mt7996/Makefile
+++ b/mt7996/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause-Clear
 
+ccflags-y += -DCONFIG_MT76_LEDS
 obj-$(CONFIG_MT7996E) += mt7996e.o
 
 mt7996e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
-- 
2.43.0


