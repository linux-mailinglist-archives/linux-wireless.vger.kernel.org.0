Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0946A206A0
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 14:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfEPMEb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 08:04:31 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:50366 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbfEPME3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 08:04:29 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id EBE9030C039;
        Thu, 16 May 2019 05:04:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com EBE9030C039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1558008265;
        bh=KLjLcUAIRdAJHDEjgwBtJHEQZj2coqkKm1UG2H9B/wA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7B0MZor6GW4XW42YsHsuNtkBEVfowW6AnvzpOmNPtW7+/qUJvv+C6unDz2qpEAU2
         3MQrm0OaQQS/t0XQfRNdQLtBarSmu5C71HCsNPLWM5ZCpWPdl2lqPFJWvnAojG28FR
         zQlAREvb4DYaa+iIrPvtWSqKUtpXDtIShZS4UNIo=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id ECB8460D63;
        Thu, 16 May 2019 05:04:24 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id A1507B02BAB; Thu, 16 May 2019 14:04:23 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/7] brcmsmac: switch source files to using SPDX license identifier
Date:   Thu, 16 May 2019 14:04:07 +0200
Message-Id: <1558008251-13692-4-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With ISC license text in place under the LICENSES folder switch
to using the SPDX license identifier to refer to the ISC license.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
Hi Thomas, Greg,

The file drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
did not have license information nor copyright notice and as such
it got included in commit b24413180f56 ("License cleanup: add SPDX
GPL-2.0 license identifier to files with no license"). I added you
guys as I propose to align this source file with the rest of
the driver sources and change it to ISC license and add the missing
copyright notice while at it (not sure if that warrants a separate
patch).

Regards,
Arend
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile | 15 ++-------------
 .../net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c    | 13 +------------
 .../net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h    | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c  | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.h  | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.c | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.h | 13 +------------
 .../broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac.h    | 13 +------------
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h         | 13 +------------
 .../broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_tx.h | 13 +------------
 .../broadcom/brcm80211/brcmsmac/brcms_trace_events.c      | 13 +------------
 .../broadcom/brcm80211/brcmsmac/brcms_trace_events.h      | 13 +------------
 .../net/wireless/broadcom/brcm80211/brcmsmac/channel.c    | 13 +------------
 .../net/wireless/broadcom/brcm80211/brcmsmac/channel.h    | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/d11.h    | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c  | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.h  | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c    |  5 ++++-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.h    | 13 +------------
 .../wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c    | 13 +------------
 .../wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h    | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c   | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h   | 13 +------------
 .../net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c   | 13 +------------
 .../net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h   | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.c    | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.h    | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h    | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.c   | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.h   | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/scb.h    | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.c    | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.h    | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/types.h  | 13 +------------
 .../wireless/broadcom/brcm80211/brcmsmac/ucode_loader.c   | 13 +------------
 .../wireless/broadcom/brcm80211/brcmsmac/ucode_loader.h   | 13 +------------
 36 files changed, 40 insertions(+), 422 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile
index 482d773..a55d02c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile
@@ -1,20 +1,9 @@
+# SPDX-License-Identifier: ISC
 #
-# Makefile fragment for Broadcom 802.11n Networking Device Driver
+# Makefile fragment for Broadcom 802.11 Networking Device Driver
 #
 # Copyright (c) 2010 Broadcom Corporation
 #
-# Permission to use, copy, modify, and/or distribute this software for any
-# purpose with or without fee is hereby granted, provided that the above
-# copyright notice and this permission notice appear in all copies.
-#
-# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
-# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
-# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
-# SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
-# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
-# OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
-# CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-
 ccflags-y := \
 	-I $(srctree)/$(src) \
 	-I $(srctree)/$(src)/phy \
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c
index 5336597..c23f863 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
  *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- *
  * File contents: support functions for PCI/PCIe
  */
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h
index 2d08c15..58df62f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2011 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef	_BRCM_AIUTILS_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
index fa391e4..abc3164 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 #include <net/mac80211.h>
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.h
index 03bdcf2..1a8cb77 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef _BRCM_AMPDU_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.c
index 54c6169..7eb99aa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/slab.h>
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.h
index a3d487a..ff4ed9a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef _BRCM_ANTSEL_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac.h
index a0da324..a208054 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2011 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #if !defined(__TRACE_BRCMSMAC_H) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h
index 0e8a69a..40775cc 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2011 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #if !defined(__TRACE_BRCMSMAC_MSG_H) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_tx.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_tx.h
index cf2cc07..b96e920 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_tx.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_tx.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2011 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #if !defined(__TRACE_BRCMSMAC_TX_H) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_events.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_events.c
index 52fc9ee..71e393d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_events.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_events.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2011 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/module.h> /* bug in tracepoint.h, it should include this */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_events.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_events.h
index cbf2f06..3f59efc 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_events.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_events.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2011 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef __BRCMS_TRACE_EVENTS_H
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
index db783e9..53ef608 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/types.h>
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.h
index 39dd3a5..2a2f6d0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef _BRCM_CHANNEL_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/d11.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/d11.h
index 9035cc4..cc5758e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/d11.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/d11.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef	_BRCM_D11_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
index 6d776ef..38b571b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012 Broadcom Corporation
  * Copyright (c) 2012 Canonical Ltd.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 #include <linux/debugfs.h>
 #include <linux/if_ether.h>
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.h
index 56898e6..39f2290 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.h
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012 Broadcom Corporation
  * Copyright (c) 2012 Canonical Ltd.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 #ifndef _BRCMS_DEBUG_H_
 #define _BRCMS_DEBUG_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
index c0a5449..856366c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
@@ -1,4 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ */
 #include <net/mac80211.h>
 #include <linux/bcma/bcma_driver_chipcommon.h>
 #include <linux/gpio.h>
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.h
index 17a0b1f..b6f70d4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef _BRCM_LED_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 6188275..40a1eda 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
  * Copyright (c) 2013 Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #define __UNDEF_NO_VERSION__
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h
index 198053d..86dabda9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef _BRCM_MAC80211_IF_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
index 7d4e8f5..7c366a6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
  * Copyright (c) 2013 Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
index 9f76b88..7fc5346 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef _BRCM_MAIN_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
index a0de5db..9b85229 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
@@ -1,17 +1,6 @@
+//SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 /*
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h
index dd87747..3a57cf4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 /*
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.c
index 71b8038..c75770d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2011 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.h
index a014bbc..463563f2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h
index 4da38cb..3f17c67f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef _BRCM_PUB_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.c
index 0a0c0ad..95a36b1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <brcmu_wifi.h>
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.h
index 5bb88b78..9185477 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef _BRCM_RATE_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/scb.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/scb.h
index 3a3d736..f63fd09 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/scb.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/scb.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef _BRCM_SCB_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.c
index 0ab865d..6a81a44 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <net/mac80211.h>
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.h
index ba94930..bb3adb5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef _BRCM_STF_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/types.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/types.h
index ae1f3ad..0707394 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/types.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef _BRCM_TYPES_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ucode_loader.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ucode_loader.c
index 80e3ccf..5abe5a2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ucode_loader.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ucode_loader.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <defs.h>
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ucode_loader.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ucode_loader.h
index c87dd89..5652581 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ucode_loader.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ucode_loader.h
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2010 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 #ifndef	_BRCM_UCODE_H_
 #define	_BRCM_UCODE_H_
-- 
1.9.1

