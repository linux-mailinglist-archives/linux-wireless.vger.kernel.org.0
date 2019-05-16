Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8815D2069F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfEPMEa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 08:04:30 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:50404 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbfEPME1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 08:04:27 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id EECCC30C04D;
        Thu, 16 May 2019 05:04:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com EECCC30C04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1558008266;
        bh=nmyt5h9wbzIWXDQGys8ekqbVsfvMFdH5xsw9tk8ABHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixfdmRkjdzxed065fNIqtU/TkBS5MHaD4cuuBmCUkSZYCcfD4vpQ7cw2cVyxXe4xx
         frMi8BWRoISoi1OB6v0tFC51vUUt+9lWoEVblGrLAJG8hHE5/Cg26JXw66m5/NjUAK
         Hmrel2TvEZlPIoPVoEKnd/L+UqgTNUMHc7lLjGJk=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 3756D60D5E;
        Thu, 16 May 2019 05:04:26 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id A2900B050D0; Thu, 16 May 2019 14:04:23 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 1/7] brcm80211: switch common header files to using SPDX license identifier
Date:   Thu, 16 May 2019 14:04:05 +0200
Message-Id: <1558008251-13692-2-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With ISC license text in place under the LICENSES folder switch
to using the SPDX license identifier to refer to the ISC license.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h   | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.h | 13 +------------
 .../net/wireless/broadcom/brcm80211/include/brcmu_utils.h   | 13 +------------
 .../net/wireless/broadcom/brcm80211/include/brcmu_wifi.h    | 13 +------------
 .../net/wireless/broadcom/brcm80211/include/chipcommon.h    | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/include/defs.h      | 13 +------------
 drivers/net/wireless/broadcom/brcm80211/include/soc.h       | 13 +------------
 7 files changed, 7 insertions(+), 84 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 839980d..d1037b6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
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
 
 #ifndef	_BRCM_HW_IDS_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.h b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.h
index 8b8b2ec..f634402 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.h
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
 
 #ifndef	_BRCMU_D11_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_utils.h b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_utils.h
index 4196952..9465323 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_utils.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_utils.h
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
 
 #ifndef	_BRCMU_UTILS_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
index dddebaa..7b31c21 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
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
 
 #ifndef	_BRCMU_WIFI_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/chipcommon.h b/drivers/net/wireless/broadcom/brcm80211/include/chipcommon.h
index de8225e..0340bba 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/chipcommon.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/chipcommon.h
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
 
 #ifndef	_SBCHIPC_H
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/defs.h b/drivers/net/wireless/broadcom/brcm80211/include/defs.h
index 8d1e85e..9e7e611 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/defs.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/defs.h
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
 
 #ifndef	_BRCM_DEFS_H_
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/soc.h b/drivers/net/wireless/broadcom/brcm80211/include/soc.h
index 123cfa8..92d942b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/soc.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/soc.h
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
 
 #ifndef	_BRCM_SOC_H
-- 
1.9.1

