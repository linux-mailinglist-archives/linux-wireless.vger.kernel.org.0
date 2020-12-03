Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A871C2CE1FB
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 23:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgLCWlX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 17:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgLCWlW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 17:41:22 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AA8C061A4F
        for <linux-wireless@vger.kernel.org>; Thu,  3 Dec 2020 14:40:42 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id v22so3839718edt.9
        for <linux-wireless@vger.kernel.org>; Thu, 03 Dec 2020 14:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xj0b6s1S6xpPPjCYL4aLEzgZqx91J3FeyLtAU8fCjoo=;
        b=QGFvr7RHj/Ev4oo+p17ZThbimmZS+5G0enSbTQ/zu1bDT3QlzBwTTaUH4WIRu0O9eg
         uDFQcQ/qvWhUwmTueXyMvtCKJ47ncu+UVh/JLDtg14iJJL39+ZlJRKAg9z9YJc5sC0Og
         FsFTTWR1EfO6JqBH3SBQV49pu9x10xsFEkhOUluw7BgSB/kuG8fuhHgpChvQBku3w77m
         E0XyIQIH7xZKWI2OaO/H8NYuzmkWzgb7iSbY4viaX4Peu7Q5OV/IieDbTyjoiYgw0c+3
         H4T3J7HgbDTvIia+gGbuosikJQ9jWLUBmBcAWjt/zfi6piIoD/JzffHv0IuHO5OqC7ed
         QxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Xj0b6s1S6xpPPjCYL4aLEzgZqx91J3FeyLtAU8fCjoo=;
        b=G7eYrITAAoyeX6rbL6i0ysV4pwG6r148JxDEQDIO0Dg06tNCNKHx6udIR7jYqZRHX8
         M8ScNgfObhTdfDQZVk19b0ycKSXJYnK1CtkFUXpM4mqc/By+B/fWBUnho+usKjlo04SH
         L6RGU/WbCwoS+jgzOqBSOZycQ423JnlxDa1YXMEh9SyVzywXh5eeB2uS33AarGnVKJb6
         d0DOiUTRQLeyBq8LsdREs/rUxmyrb7D6Ye57UU6rvsfwkg3c1grjxBaVGaTsyQCwRnSR
         +iEDKTpE+XNE6vTzMZWO6mhXkgzk2Uwm1ONbY7d4sQ38wcHwFyY0/PSDDJS6P1IlKMUi
         4XRw==
X-Gm-Message-State: AOAM5304K50hktSVHtfM9tq4Rf7ueeBXCYstpWkp0ULY4ht3x45kd03l
        12Odz/dO/+wJOYicSjxwEz90KUUbINg=
X-Google-Smtp-Source: ABdhPJw1xTWybs+aQx2jpl9NtezgZLg8eYWtfTn5qIr+MbRRxfcT6ZC6Ja4/HWKbTQl8/e8fOw414g==
X-Received: by 2002:a50:f98b:: with SMTP id q11mr4936876edn.345.1607035240888;
        Thu, 03 Dec 2020 14:40:40 -0800 (PST)
Received: from localhost (catv-86-101-16-63.catv.broadband.hu. [86.101.16.63])
        by smtp.gmail.com with ESMTPSA id a10sm1572859ejk.92.2020.12.03.14.40.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 14:40:40 -0800 (PST)
Sender: Thomas Nagy <bkil.hu@gmail.com>
From:   bkil <b.K.il.h.u+tigbuh@gmail.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: recent FCC report and order allows 5850-5895 immediately
Date:   Thu,  3 Dec 2020 23:40:30 +0100
Message-Id: <a79286b90cdfdee3a83397008c0f7b6d67bc7f69.1607035229.git.b.K.il.h.u+tigbuh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The new band is called U-NII-4.

The report recommends combining it with 5725-5895 to allow 160 MHz
bandwidth, but that's technically not that easy with regdb due to the
differing restrictions of the two parts. Marking the line for U-NII-3
NO-OUTDOOR and PTMP-ONLY along with extending its range would be a
possible workaround, but this needs to be discussed.

I don't see a requirement for TPC, hence reducing EIRP by 3dB is not
needed. I've marked it 33dBm (minus 6dB for clients) to cope with 20MHz,
but the band can support higher power, though the logic is complicated.

The upper subband (5895-5925 MHz) of the new band is reserved for ITS.

"We limit unlicensed use to indoor operations in recognition of the
potential that ITS licensees may currently be operating"

"We also proposed that U-NII-4 devices be permitted to operate at the same
power levels as U-NII-3 devices."

"For the U-NII-4 band, indoor access point EIRP will be limited to
33 dBm/20 MHz and 36 dBm/40 MHz. When combined with U-NII-3 band spectrum,
indoor access point EIRP can scale to 36 dBm for 80 and 160 megahertz
channels."

"Client devices would be limited to power levels 6 dB below the power
limits for access points."

"the First Report and Order prohibit U-NII-4 client-to-client
communications to protect co-channel incumbent ITS"

Signed-off-by: bkil <b.K.il.h.u+tigbuh@gmail.com>
---
 db.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index c71a03a..e6dd063 100644
--- a/db.txt
+++ b/db.txt
@@ -1587,7 +1587,10 @@ country US: DFS-FCC
 	# requirements, we can extend the range by 5 MHz to make the kernel
 	# happy and be able to use channel 144.
 	(5470 - 5730 @ 160), (23), DFS
-	(5730 - 5850 @ 80), (30)
+	(5730 - 5850 @ 80), (30), AUTO-BW
+	# https://www.fcc.gov/document/fcc-modernizes-59-ghz-band-improve-wi-fi-a=
nd-automotive-safety-0
+	# max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clients
+	(5850 - 5895 @ 40), (27), NO-OUTDOOR, PTMP-ONLY, AUTO-BW
 	# 60g band
 	# reference: section IV-D https://docs.fcc.gov/public/attachments/FCC-16-=
89A1.pdf
 	# channels 1-6 EIRP=3D40dBm(43dBm peak)
