Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEFB3931C
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 19:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfFGR0B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 13:26:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42367 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbfFGRZ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 13:25:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so2552838otn.9;
        Fri, 07 Jun 2019 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=KxyBt4jFYkAeqzf1jEUKJMpLVe7B1ILDm+weChcMIWw=;
        b=HnwPzkHoHgK8lOOT8fORnOn+rF7rlPB11fEFxNBLb2wCizpjrn0Ago99EygaIR8z9u
         XjWZkQctj5jJAG65bHjVuFjL9i0NhzMIzc2MKuveTgOfRmLS73o8vaC7lJVfFG2wbpkC
         /OZwr8Ebeu5i/HUwj+we5xFYlBaGtcopi2b8mf1IsWP8y7fZErxntTbPrgY6YzPB0kJM
         KfY2EJbS4bt8fNWlB43PwrRUqLdbGh918XvALaSKWGIELcuFjeYd+QdQ4SVO866gE6hr
         M2pWQf/bvEnpr0J/7Bo4mw92Ep5jTmUxXGMDFK02ArX+W/+iDJY7TusqO52L71+Y777n
         RpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language;
        bh=KxyBt4jFYkAeqzf1jEUKJMpLVe7B1ILDm+weChcMIWw=;
        b=Qe48ernt2hz/Xj00xVC4Hw0JU51JfhGzuaKJpQDLX306meotJ+vnyfFHLcldzUzt4T
         SW9AU3K5TLjWzrTxMM94+7UJPvj6zjiIjMR3rrDkyosNP3pk9rM5r4IFdlfXZM7HDWZn
         DUZNCBwKuw2OnIxHeETzrIM4iapAskVMoOsvao838xD5gVwl8r/BdzRDVqU0Hr4TTBk6
         Y8JP5T4nmhN9LURy9uJ5jMYjbPCSuwJWjbRCXvjEE7d3HBFZ8V9l3jtvMvnpDTkrfoUg
         Y3aK0mJAWgu4VRdgi+G56j5HSsnRUfgwNZi74bE9hJUfV5sGYZS0tFgcnIMfjWEmEW/n
         od5Q==
X-Gm-Message-State: APjAAAVxPmoLFk18Xw+u/JKjIyrWgYlCbYkmps438tmBlrwOVIHjyAw0
        3WMxDvC7KOifFPAutHyWxdE=
X-Google-Smtp-Source: APXvYqwXL1deWJrUvbwAmin4bTYZyo7x2kVTaz7L0oNC2lOp+UdNDa2GM6U8DS0msSrwKTPNKwAkzg==
X-Received: by 2002:a9d:5d1a:: with SMTP id b26mr20723333oti.50.1559928356639;
        Fri, 07 Jun 2019 10:25:56 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c19sm945378otl.70.2019.06.07.10.25.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 10:25:55 -0700 (PDT)
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
Date:   Fri, 7 Jun 2019 12:25:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
Content-Type: multipart/mixed;
 boundary="------------248DB5856E99694593DD245B"
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------248DB5856E99694593DD245B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/19 5:50 PM, Aaro Koskinen wrote:
> Hi,
> 
> When upgrading from v5.0 -> v5.1 on G4 PowerBook, I noticed WLAN does
> not work anymore:
> 
> [   42.004303] b43legacy-phy0: Loading firmware version 0x127, patch level 14 (2005-04-18 02:36:27)
> [   42.184837] b43legacy-phy0 debug: Chip initialized
> [   42.184873] b43legacy-phy0 ERROR: The machine/kernel does not support the required 30-bit DMA mask
> 
> The same happens with the current mainline.
> 
> Bisected to:
> 
> 	commit 65a21b71f948406201e4f62e41f06513350ca390
> 	Author: Christoph Hellwig <hch@lst.de>
> 	Date:   Wed Feb 13 08:01:26 2019 +0100
> 
> 	    powerpc/dma: remove dma_nommu_dma_supported
> 
> 	    This function is largely identical to the generic version used
> 	    everywhere else.  Replace it with the generic version.
> 
> 	    Signed-off-by: Christoph Hellwig <hch@lst.de>
> 	    Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> 	    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Aaro,

Please try the attached patch. I'm not really pleased with it and I will 
continue to determine why the fallback to a 30-bit mask fails, but at least this 
one works for me.

Larry



--------------248DB5856E99694593DD245B
Content-Type: text/x-patch;
 name="0001-b43legacy-Fix-DMA-breakage-from-commit-commit-65a21b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-b43legacy-Fix-DMA-breakage-from-commit-commit-65a21b.pa";
 filename*1="tch"

From 25e2f50273e785598b6bd9a8aee28cf825d3fe9f Mon Sep 17 00:00:00 2001
From: Larry Finger <Larry.Finger@lwfinger.net>
Date: Fri, 7 Jun 2019 12:04:16 -0500
Subject: [PATCH] b43legacy: Fix DMA breakage from commit commit 65a21b71f948
To: kvalo@codeaurora.org
Cc: linux-wireless@vger.kernel.org,
    pkshih@realtek.com

Following commit 65a21b71f948 ("powerpc/dma: remove dma_nommu_dma_supported"),
this driver errors with a message that "The machine/kernel does not
support the required 30-bit DMA mask." Indeed, the hardware only allows
31-bit masks. This solution is to change the fallback mask from 30-
to 31-bits for 32-bit PPC systems.

Fixes: 65a21b71f948 ("powerpc/dma: remove dma_nommu_dma_supported")
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/broadcom/b43legacy/dma.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/dma.c b/drivers/net/wireless/broadcom/b43legacy/dma.c
index 1cc25f44dd9a..75613f516e50 100644
--- a/drivers/net/wireless/broadcom/b43legacy/dma.c
+++ b/drivers/net/wireless/broadcom/b43legacy/dma.c
@@ -27,6 +27,15 @@
 #include <linux/slab.h>
 #include <net/dst.h>
 
+/* Special handling for PPC32 - The maximum DMA mask is 31 bits, and
+ * the fallback to 30 bits fails. Set the fallback at 31.
+ */
+#ifdef CONFIG_PPC32
+#define FB_DMA	31
+#else
+#define FB_DMA	30
+#endif
+
 /* 32bit DMA ops. */
 static
 struct b43legacy_dmadesc32 *op32_idx2desc(struct b43legacy_dmaring *ring,
@@ -418,7 +427,7 @@ static bool b43legacy_dma_mapping_error(struct b43legacy_dmaring *ring,
 
 	switch (ring->type) {
 	case B43legacy_DMA_30BIT:
-		if ((u64)addr + buffersize > (1ULL << 30))
+		if ((u64)addr + buffersize > (1ULL << FB_DMA))
 			goto address_error;
 		break;
 	case B43legacy_DMA_32BIT:
@@ -617,12 +626,12 @@ static u64 supported_dma_mask(struct b43legacy_wldev *dev)
 	if (tmp & B43legacy_DMA32_TXADDREXT_MASK)
 		return DMA_BIT_MASK(32);
 
-	return DMA_BIT_MASK(30);
+	return DMA_BIT_MASK(FB_DMA);
 }
 
 static enum b43legacy_dmatype dma_mask_to_engine_type(u64 dmamask)
 {
-	if (dmamask == DMA_BIT_MASK(30))
+	if (dmamask == DMA_BIT_MASK(FB_DMA))
 		return B43legacy_DMA_30BIT;
 	if (dmamask == DMA_BIT_MASK(32))
 		return B43legacy_DMA_32BIT;
@@ -802,7 +811,7 @@ static int b43legacy_dma_set_mask(struct b43legacy_wldev *dev, u64 mask)
 			continue;
 		}
 		if (mask == DMA_BIT_MASK(32)) {
-			mask = DMA_BIT_MASK(30);
+			mask = DMA_BIT_MASK(FB_DMA);
 			fallback = true;
 			continue;
 		}
-- 
2.21.0


--------------248DB5856E99694593DD245B--
