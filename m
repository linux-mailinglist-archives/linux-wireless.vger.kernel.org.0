Return-Path: <linux-wireless+bounces-28044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF93BEDB20
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Oct 2025 22:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8090519A661D
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Oct 2025 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE74828689F;
	Sat, 18 Oct 2025 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ejlQvqtC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D5277C9A;
	Sat, 18 Oct 2025 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760817598; cv=none; b=ggCOsRf39KYsROOPLeloZODi6tWjcTd9R3iJmPSYGGhV71y+Dl4tHeySXFVhNueWM0NU2HSUZPhSNdxG8BsyizcE/ufNmsfT5X4hMeVra1jvVPZnG+WwULTsOoyAJb4+iV3Z670hZ+DCLTJfedsfW+o9ZdXdyr27+HW3LyPHtPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760817598; c=relaxed/simple;
	bh=bMV20D65SQY2T5+vRg8Qz5xebhjMdjI0P1Ep0l7Sirg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=loW/iLZ8BVZwl7fAXMDcabYPQI219rIBbrduIYBes8hnIQ5bySt+pV/qAyoduJ0afcCMK3JMeRGOPKD5AWg2sMekJkZ5cC/wtKzEBePb65Zamru6McfTrDuCbSiRhYp3yttuy6D0S03bemtZLsNL31CP9jYLUykpCZR3M1RKYwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ejlQvqtC; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1760817596; x=1792353596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sEYdbCmseZgzNgUq/qO65kcsC90lv2jjfE41BXg79O0=;
  b=ejlQvqtClOX7gRWZ2jDp9jQiPWKlWWAyxfwONJe/fZGCPRE9WJqU9WUK
   6pGeGvhrmMS+TxYf69wLWUtcLN80p6wJOVHeuEjDBZmXhM7saNrogbhCY
   mOSOzlEjQ2ThlYrB6b9cqqAsbMx8vtTiQk91xghu/Jqebo7jhExt+1vyq
   vgy8RdXtvlXYuZegfYPH4xoVIxKv4vCedPsr2qIGfvW3zNT7EJEz7M5XF
   xiNI5fFMYaqdM1TXkV/hZzpW+0QaF4sAbEfozmMeAbVgpfUtnEtcwcY88
   3RJIW+Fy8VUSuQeQph5ButI9ix5DJp/6NaCBsS5pjI9xexz7hsL7ForiZ
   Q==;
X-CSE-ConnectionGUID: B8e9Z53URZGiJYgR/wmpLw==
X-CSE-MsgGUID: sNPGVj6HR/uPqsJ6gHt1xg==
X-IronPort-AV: E=Sophos;i="6.18,263,1751241600"; 
   d="scan'208";a="5144657"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 19:59:54 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:10134]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.234:2525] with esmtp (Farcaster)
 id 3afe7262-b5b9-4d6d-8904-b41b36d4b890; Sat, 18 Oct 2025 19:59:54 +0000 (UTC)
X-Farcaster-Flow-ID: 3afe7262-b5b9-4d6d-8904-b41b36d4b890
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 18 Oct 2025 19:59:53 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Sat, 18 Oct 2025
 19:59:51 +0000
From: Eliav Farber <farbere@amazon.com>
To: <stf_xl@wp.pl>, <helmut.schaa@googlemail.com>, <kvalo@codeaurora.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <linux-wireless@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <stable@vger.kernel.org>, <nathan@kernel.org>,
	<farbere@amazon.com>
CC: "Jason A. Donenfeld" <Jason@zx2c4.com>, Andrew Morton
	<akpm@linux-foundation.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Kalle Valo <kvalo@kernel.org>, "Naresh
 Kamboju" <naresh.kamboju@linaro.org>
Subject: [PATCH 5.10.y] wifi: rt2x00: use explicitly signed or unsigned types
Date: Sat, 18 Oct 2025 19:59:35 +0000
Message-ID: <20251018195945.18825-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

commit 66063033f77e10b985258126a97573f84bb8d3b4 upstream.

On some platforms, `char` is unsigned, but this driver, for the most
part, assumed it was signed. In other places, it uses `char` to mean an
unsigned number, but only in cases when the values are small. And in
still other places, `char` is used as a boolean. Put an end to this
confusion by declaring explicit types, depending on the context.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Helmut Schaa <helmut.schaa@googlemail.com>
Cc: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20221019155541.3410813-1-Jason@zx2c4.com
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
This backport is required to fix build errors on an arm64 server when building with allmodconfig.
The build failures were introduced after backporting:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/queue-5.10?id=37c71b96ff37b6a069569841b1baa51be72299b2

The original commit in the mainline branch is:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ralink/rt2x00/rt2800lib.c?h=v6.18-rc1&id=66063033f77e10b985258126a97573f84bb8d3b4

This fix already exists in 5.15.y:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/net/wireless/ralink/rt2x00/rt2800lib.c?h=v5.15.194&id=2d3cef3d7a5df260a14a6679c4aca0c97e570ee5
…but is missing in 5.10.y.


The error encountered during the build:

In file included from <command-line>:
In function ‘rt2800_txpower_to_dev’,
    inlined from ‘rt2800_config_channel’ at drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4022:25:
././include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1168’ declared with attribute error: clamp() low limit -7 greater than high limit 15
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
  290 |                         prefix ## suffix();                             \
      |                         ^~~~~~
././include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^~~~~~~~~~~~~~~~
./include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^~~~~~~~~~~~
./include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^~~~~~~~~~~~~~~
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^~~~~~~
In function ‘rt2800_txpower_to_dev’,
    inlined from ‘rt2800_config_channel’ at drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4024:25:
././include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1168’ declared with attribute error: clamp() low limit -7 greater than high limit 15
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
  290 |                         prefix ## suffix();                             \
      |                         ^~~~~~
././include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^~~~~~~~~~~~~~~~
./include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^~~~~~~~~~~~
./include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^~~~~~~~~~~~~~~
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^~~~~~~
In function ‘rt2800_txpower_to_dev’,
    inlined from ‘rt2800_config_channel’ at drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4028:4:
././include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1168’ declared with attribute error: clamp() low limit -7 greater than high limit 15
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
  290 |                         prefix ## suffix();                             \
      |                         ^~~~~~
././include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^~~~~~~~~~~~~~~~
./include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^~~~~~~~~~~~
./include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^~~~~~~~~~~~~~~
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^~~~~~~
make[5]: *** [scripts/Makefile.build:286: drivers/net/wireless/ralink/rt2x00/rt2800lib.o] Error 1
make[4]: *** [scripts/Makefile.build:503: drivers/net/wireless/ralink/rt2x00] Error 2
make[3]: *** [scripts/Makefile.build:503: drivers/net/wireless/ralink] Error 2
make[2]: *** [scripts/Makefile.build:503: drivers/net/wireless] Error 2
make[1]: *** [scripts/Makefile.build:503: drivers/net] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1851: drivers] Error 2
make: *** Waiting for unfinished jobs....
  CC [M]  kernel/kheaders.o


 .../net/wireless/ralink/rt2x00/rt2400pci.c    |  8 ++---
 .../net/wireless/ralink/rt2x00/rt2400pci.h    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2500pci.c    |  8 ++---
 .../net/wireless/ralink/rt2x00/rt2500pci.h    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2500usb.c    |  8 ++---
 .../net/wireless/ralink/rt2x00/rt2500usb.h    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 36 +++++++++----------
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  8 ++---
 .../net/wireless/ralink/rt2x00/rt2x00usb.c    |  6 ++--
 drivers/net/wireless/ralink/rt2x00/rt61pci.c  |  4 +--
 drivers/net/wireless/ralink/rt2x00/rt61pci.h  |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt73usb.c  |  4 +--
 drivers/net/wireless/ralink/rt2x00/rt73usb.h  |  2 +-
 13 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
index 8f860c14da58..1520785c3ddb 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
@@ -1023,9 +1023,9 @@ static int rt2400pci_set_state(struct rt2x00_dev *rt2x00dev,
 {
 	u32 reg, reg2;
 	unsigned int i;
-	char put_to_sleep;
-	char bbp_state;
-	char rf_state;
+	bool put_to_sleep;
+	u8 bbp_state;
+	u8 rf_state;
 
 	put_to_sleep = (state != STATE_AWAKE);
 
@@ -1561,7 +1561,7 @@ static int rt2400pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
 	struct hw_mode_spec *spec = &rt2x00dev->spec;
 	struct channel_info *info;
-	char *tx_power;
+	u8 *tx_power;
 	unsigned int i;
 
 	/*
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2400pci.h b/drivers/net/wireless/ralink/rt2x00/rt2400pci.h
index b8187b6de143..979d5fd8babf 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2400pci.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2400pci.h
@@ -939,7 +939,7 @@
 #define DEFAULT_TXPOWER	39
 
 #define __CLAMP_TX(__txpower) \
-	clamp_t(char, (__txpower), MIN_TXPOWER, MAX_TXPOWER)
+	clamp_t(u8, (__txpower), MIN_TXPOWER, MAX_TXPOWER)
 
 #define TXPOWER_FROM_DEV(__txpower) \
 	((__CLAMP_TX(__txpower) - MAX_TXPOWER) + MIN_TXPOWER)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
index e940443c52ad..1be535c74917 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
@@ -1176,9 +1176,9 @@ static int rt2500pci_set_state(struct rt2x00_dev *rt2x00dev,
 {
 	u32 reg, reg2;
 	unsigned int i;
-	char put_to_sleep;
-	char bbp_state;
-	char rf_state;
+	bool put_to_sleep;
+	u8 bbp_state;
+	u8 rf_state;
 
 	put_to_sleep = (state != STATE_AWAKE);
 
@@ -1856,7 +1856,7 @@ static int rt2500pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
 	struct hw_mode_spec *spec = &rt2x00dev->spec;
 	struct channel_info *info;
-	char *tx_power;
+	u8 *tx_power;
 	unsigned int i;
 
 	/*
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500pci.h b/drivers/net/wireless/ralink/rt2x00/rt2500pci.h
index 7e64aee2a172..ba362675c52c 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500pci.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500pci.h
@@ -1219,6 +1219,6 @@
 	(((u8)(__txpower)) > MAX_TXPOWER) ? DEFAULT_TXPOWER : (__txpower)
 
 #define TXPOWER_TO_DEV(__txpower) \
-	clamp_t(char, __txpower, MIN_TXPOWER, MAX_TXPOWER)
+	clamp_t(u8, __txpower, MIN_TXPOWER, MAX_TXPOWER)
 
 #endif /* RT2500PCI_H */
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
index fce05fc88aaf..6d12e3879a90 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
@@ -984,9 +984,9 @@ static int rt2500usb_set_state(struct rt2x00_dev *rt2x00dev,
 	u16 reg;
 	u16 reg2;
 	unsigned int i;
-	char put_to_sleep;
-	char bbp_state;
-	char rf_state;
+	bool put_to_sleep;
+	u8 bbp_state;
+	u8 rf_state;
 
 	put_to_sleep = (state != STATE_AWAKE);
 
@@ -1663,7 +1663,7 @@ static int rt2500usb_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
 	struct hw_mode_spec *spec = &rt2x00dev->spec;
 	struct channel_info *info;
-	char *tx_power;
+	u8 *tx_power;
 	unsigned int i;
 
 	/*
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500usb.h b/drivers/net/wireless/ralink/rt2x00/rt2500usb.h
index 0c070288a140..746f0e950b76 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500usb.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500usb.h
@@ -839,6 +839,6 @@
 	(((u8)(__txpower)) > MAX_TXPOWER) ? DEFAULT_TXPOWER : (__txpower)
 
 #define TXPOWER_TO_DEV(__txpower) \
-	clamp_t(char, __txpower, MIN_TXPOWER, MAX_TXPOWER)
+	clamp_t(u8, __txpower, MIN_TXPOWER, MAX_TXPOWER)
 
 #endif /* RT2500USB_H */
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 4bdd3a95f2d2..adea793c6a76 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -3297,10 +3297,10 @@ static void rt2800_config_channel_rf53xx(struct rt2x00_dev *rt2x00dev,
 	if (rt2x00_has_cap_bt_coexist(rt2x00dev)) {
 		if (rt2x00_rt_rev_gte(rt2x00dev, RT5390, REV_RT5390F)) {
 			/* r55/r59 value array of channel 1~14 */
-			static const char r55_bt_rev[] = {0x83, 0x83,
+			static const u8 r55_bt_rev[] = {0x83, 0x83,
 				0x83, 0x73, 0x73, 0x63, 0x53, 0x53,
 				0x53, 0x43, 0x43, 0x43, 0x43, 0x43};
-			static const char r59_bt_rev[] = {0x0e, 0x0e,
+			static const u8 r59_bt_rev[] = {0x0e, 0x0e,
 				0x0e, 0x0e, 0x0e, 0x0b, 0x0a, 0x09,
 				0x07, 0x07, 0x07, 0x07, 0x07, 0x07};
 
@@ -3309,7 +3309,7 @@ static void rt2800_config_channel_rf53xx(struct rt2x00_dev *rt2x00dev,
 			rt2800_rfcsr_write(rt2x00dev, 59,
 					   r59_bt_rev[idx]);
 		} else {
-			static const char r59_bt[] = {0x8b, 0x8b, 0x8b,
+			static const u8 r59_bt[] = {0x8b, 0x8b, 0x8b,
 				0x8b, 0x8b, 0x8b, 0x8b, 0x8a, 0x89,
 				0x88, 0x88, 0x86, 0x85, 0x84};
 
@@ -3317,10 +3317,10 @@ static void rt2800_config_channel_rf53xx(struct rt2x00_dev *rt2x00dev,
 		}
 	} else {
 		if (rt2x00_rt_rev_gte(rt2x00dev, RT5390, REV_RT5390F)) {
-			static const char r55_nonbt_rev[] = {0x23, 0x23,
+			static const u8 r55_nonbt_rev[] = {0x23, 0x23,
 				0x23, 0x23, 0x13, 0x13, 0x03, 0x03,
 				0x03, 0x03, 0x03, 0x03, 0x03, 0x03};
-			static const char r59_nonbt_rev[] = {0x07, 0x07,
+			static const u8 r59_nonbt_rev[] = {0x07, 0x07,
 				0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
 				0x07, 0x07, 0x06, 0x05, 0x04, 0x04};
 
@@ -3331,14 +3331,14 @@ static void rt2800_config_channel_rf53xx(struct rt2x00_dev *rt2x00dev,
 		} else if (rt2x00_rt(rt2x00dev, RT5390) ||
 			   rt2x00_rt(rt2x00dev, RT5392) ||
 			   rt2x00_rt(rt2x00dev, RT6352)) {
-			static const char r59_non_bt[] = {0x8f, 0x8f,
+			static const u8 r59_non_bt[] = {0x8f, 0x8f,
 				0x8f, 0x8f, 0x8f, 0x8f, 0x8f, 0x8d,
 				0x8a, 0x88, 0x88, 0x87, 0x87, 0x86};
 
 			rt2800_rfcsr_write(rt2x00dev, 59,
 					   r59_non_bt[idx]);
 		} else if (rt2x00_rt(rt2x00dev, RT5350)) {
-			static const char r59_non_bt[] = {0x0b, 0x0b,
+			static const u8 r59_non_bt[] = {0x0b, 0x0b,
 				0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0a,
 				0x0a, 0x09, 0x08, 0x07, 0x07, 0x06};
 
@@ -3961,23 +3961,23 @@ static void rt2800_iq_calibrate(struct rt2x00_dev *rt2x00dev, int channel)
 	rt2800_bbp_write(rt2x00dev, 159, cal != 0xff ? cal : 0);
 }
 
-static char rt2800_txpower_to_dev(struct rt2x00_dev *rt2x00dev,
+static s8 rt2800_txpower_to_dev(struct rt2x00_dev *rt2x00dev,
 				  unsigned int channel,
-				  char txpower)
+				  s8 txpower)
 {
 	if (rt2x00_rt(rt2x00dev, RT3593) ||
 	    rt2x00_rt(rt2x00dev, RT3883))
 		txpower = rt2x00_get_field8(txpower, EEPROM_TXPOWER_ALC);
 
 	if (channel <= 14)
-		return clamp_t(char, txpower, MIN_G_TXPOWER, MAX_G_TXPOWER);
+		return clamp_t(s8, txpower, MIN_G_TXPOWER, MAX_G_TXPOWER);
 
 	if (rt2x00_rt(rt2x00dev, RT3593) ||
 	    rt2x00_rt(rt2x00dev, RT3883))
-		return clamp_t(char, txpower, MIN_A_TXPOWER_3593,
+		return clamp_t(s8, txpower, MIN_A_TXPOWER_3593,
 			       MAX_A_TXPOWER_3593);
 	else
-		return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
+		return clamp_t(s8, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
 }
 
 static void rt3883_bbp_adjust(struct rt2x00_dev *rt2x00dev,
@@ -8473,11 +8473,11 @@ static int rt2800_rf_lp_config(struct rt2x00_dev *rt2x00dev, bool btxcal)
 	return 0;
 }
 
-static char rt2800_lp_tx_filter_bw_cal(struct rt2x00_dev *rt2x00dev)
+static s8 rt2800_lp_tx_filter_bw_cal(struct rt2x00_dev *rt2x00dev)
 {
 	unsigned int cnt;
 	u8 bbp_val;
-	char cal_val;
+	s8 cal_val;
 
 	rt2800_bbp_dcoc_write(rt2x00dev, 0, 0x82);
 
@@ -8509,7 +8509,7 @@ static void rt2800_bw_filter_calibration(struct rt2x00_dev *rt2x00dev,
 	u8 rx_filter_target_20m = 0x27, rx_filter_target_40m = 0x31;
 	int loop = 0, is_ht40, cnt;
 	u8 bbp_val, rf_val;
-	char cal_r32_init, cal_r32_val, cal_diff;
+	s8 cal_r32_init, cal_r32_val, cal_diff;
 	u8 saverfb5r00, saverfb5r01, saverfb5r03, saverfb5r04, saverfb5r05;
 	u8 saverfb5r06, saverfb5r07;
 	u8 saverfb5r08, saverfb5r17, saverfb5r18, saverfb5r19, saverfb5r20;
@@ -9960,9 +9960,9 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
 	struct hw_mode_spec *spec = &rt2x00dev->spec;
 	struct channel_info *info;
-	char *default_power1;
-	char *default_power2;
-	char *default_power3;
+	s8 *default_power1;
+	s8 *default_power2;
+	s8 *default_power3;
 	unsigned int i, tx_chains, rx_chains;
 	u32 reg;
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
index 1139405c0ebb..6928f352f631 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
@@ -22,10 +22,10 @@
 struct rt2800_drv_data {
 	u8 calibration_bw20;
 	u8 calibration_bw40;
-	char rx_calibration_bw20;
-	char rx_calibration_bw40;
-	char tx_calibration_bw20;
-	char tx_calibration_bw40;
+	s8 rx_calibration_bw20;
+	s8 rx_calibration_bw40;
+	s8 tx_calibration_bw20;
+	s8 tx_calibration_bw40;
 	u8 bbp25;
 	u8 bbp26;
 	u8 txmixer_gain_24g;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
index 74c3d8cb3100..8b3c90231110 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
@@ -117,12 +117,12 @@ int rt2x00usb_vendor_request_buff(struct rt2x00_dev *rt2x00dev,
 				  const u16 buffer_length)
 {
 	int status = 0;
-	unsigned char *tb;
+	u8 *tb;
 	u16 off, len, bsize;
 
 	mutex_lock(&rt2x00dev->csr_mutex);
 
-	tb  = (char *)buffer;
+	tb  = (u8 *)buffer;
 	off = offset;
 	len = buffer_length;
 	while (len && !status) {
@@ -215,7 +215,7 @@ void rt2x00usb_register_read_async(struct rt2x00_dev *rt2x00dev,
 	rd->cr.wLength = cpu_to_le16(sizeof(u32));
 
 	usb_fill_control_urb(urb, usb_dev, usb_rcvctrlpipe(usb_dev, 0),
-			     (unsigned char *)(&rd->cr), &rd->reg, sizeof(rd->reg),
+			     (u8 *)(&rd->cr), &rd->reg, sizeof(rd->reg),
 			     rt2x00usb_register_read_async_cb, rd);
 	usb_anchor_urb(urb, rt2x00dev->anchor);
 	if (usb_submit_urb(urb, GFP_ATOMIC) < 0) {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt61pci.c b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
index 02da5dd37ddd..d04761c32a5d 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt61pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
@@ -1709,7 +1709,7 @@ static int rt61pci_set_state(struct rt2x00_dev *rt2x00dev, enum dev_state state)
 {
 	u32 reg, reg2;
 	unsigned int i;
-	char put_to_sleep;
+	bool put_to_sleep;
 
 	put_to_sleep = (state != STATE_AWAKE);
 
@@ -2656,7 +2656,7 @@ static int rt61pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
 	struct hw_mode_spec *spec = &rt2x00dev->spec;
 	struct channel_info *info;
-	char *tx_power;
+	u8 *tx_power;
 	unsigned int i;
 
 	/*
diff --git a/drivers/net/wireless/ralink/rt2x00/rt61pci.h b/drivers/net/wireless/ralink/rt2x00/rt61pci.h
index 5f208ad509bd..d72d0ffd1127 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt61pci.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt61pci.h
@@ -1484,6 +1484,6 @@ struct hw_pairwise_ta_entry {
 	(((u8)(__txpower)) > MAX_TXPOWER) ? DEFAULT_TXPOWER : (__txpower)
 
 #define TXPOWER_TO_DEV(__txpower) \
-	clamp_t(char, __txpower, MIN_TXPOWER, MAX_TXPOWER)
+	clamp_t(u8, __txpower, MIN_TXPOWER, MAX_TXPOWER)
 
 #endif /* RT61PCI_H */
diff --git a/drivers/net/wireless/ralink/rt2x00/rt73usb.c b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
index e69793773d87..32f6d689bd36 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt73usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
@@ -1378,7 +1378,7 @@ static int rt73usb_set_state(struct rt2x00_dev *rt2x00dev, enum dev_state state)
 {
 	u32 reg, reg2;
 	unsigned int i;
-	char put_to_sleep;
+	bool put_to_sleep;
 
 	put_to_sleep = (state != STATE_AWAKE);
 
@@ -2090,7 +2090,7 @@ static int rt73usb_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
 	struct hw_mode_spec *spec = &rt2x00dev->spec;
 	struct channel_info *info;
-	char *tx_power;
+	u8 *tx_power;
 	unsigned int i;
 
 	/*
diff --git a/drivers/net/wireless/ralink/rt2x00/rt73usb.h b/drivers/net/wireless/ralink/rt2x00/rt73usb.h
index 1b56d285c34b..bb0a68516c08 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt73usb.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt73usb.h
@@ -1063,6 +1063,6 @@ struct hw_pairwise_ta_entry {
 	(((u8)(__txpower)) > MAX_TXPOWER) ? DEFAULT_TXPOWER : (__txpower)
 
 #define TXPOWER_TO_DEV(__txpower) \
-	clamp_t(char, __txpower, MIN_TXPOWER, MAX_TXPOWER)
+	clamp_t(u8, __txpower, MIN_TXPOWER, MAX_TXPOWER)
 
 #endif /* RT73USB_H */
-- 
2.47.3


