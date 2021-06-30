Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542D03B86BF
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jun 2021 18:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhF3QGS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Jun 2021 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbhF3QGS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Jun 2021 12:06:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32273C061756
        for <linux-wireless@vger.kernel.org>; Wed, 30 Jun 2021 09:03:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gn32so5114059ejc.2
        for <linux-wireless@vger.kernel.org>; Wed, 30 Jun 2021 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :references:content-transfer-encoding;
        bh=D+HdESE/0kImJ3JvndQPrJ4lv0LDDAWGN+8xozTNEsQ=;
        b=DFzemgQfphcn7B/yPeY7CjGVJUpn2+AIJ1VtAHUVm+k9YyHjQByrQlArZjr90cpyu6
         A/8xJhO/+F6uBw/zTU6y99VE32KWuR9cO4bLEOlFROPD++8GqGcZ/ZQBkRTd0Zlp23D+
         MSxLGbsBhnKs1j1VAo6oDSi1lTVrGAA62tBy4dZuO4vG/odtPP7+4DeWGdm/R+KTu6hL
         2K/Gd3dZ7U83/gpGf5wyVGokekbKvl6KvHazRn47iQ4HA3RnLXFqv/sHhSBYc5FtTIiF
         +Tx4ADfvO1+E7zmAU305VbHwv9lWI6tf9HgkAeDzYv8td+/vOA5KBu3YJLQnO6EVO5uq
         w0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:in-reply-to:references:content-transfer-encoding;
        bh=D+HdESE/0kImJ3JvndQPrJ4lv0LDDAWGN+8xozTNEsQ=;
        b=qw3Oe99s2o7+1mwpLy2H+wpsjpgk+qCu+1lWgP+/vU+YmvJzdt0QR2MYKU2baxhPrN
         47sJfUnjEnjo0Vx4avcucuWRTqQaMNmyVWi6DBBTmyihyOI3dkBuG7i610AGNzWp4pXG
         n46zB4Tgvk70Be4S6W0sBTudIMZFpFlkS2792VY10pbNbM/Tho4PUijtx58GoYTsM2Z+
         jmPk+JRsjIpl9SC8czhYjQGOummYCl0F+mVY5KlItpjT/1no0J/ia3hRTFCPQlYsTW/d
         OxNblHXDXO2PBFBU72PWe8rKamqT9vnUpconjpp/5nR3GXQr+SnUnx7uS2njeywNPsSF
         xFVg==
X-Gm-Message-State: AOAM532XE4vNyeoNUJukBzCIc/pyK0DXD44gBwEpUqVf8Pz+mhueDDeg
        cJzCcwkMgiIDu0iFfKE8EdV/+E9tOenDwA==
X-Google-Smtp-Source: ABdhPJzf7ooRHJrLofMGwiO5YeSX+yIRzVtueXqQYLhiZ1l02ikmwzMj2HT/ijow/OPreBos09n3pA==
X-Received: by 2002:a17:906:c2cf:: with SMTP id ch15mr35933992ejb.517.1625069026805;
        Wed, 30 Jun 2021 09:03:46 -0700 (PDT)
Received: from localhost (92-249-252-40.pool.digikabel.hu. [92.249.252.40])
        by smtp.gmail.com with ESMTPSA id lu21sm9718647ejb.31.2021.06.30.09.03.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jun 2021 09:03:46 -0700 (PDT)
Sender: Thomas Nagy <bkil.hu@gmail.com>
From:   bkil <b.K.il.h.u+tigbuh@gmail.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH v2] wireless-regdb: recent FCC report and order allows 5850-5895 immediately
Date:   Wed, 30 Jun 2021 18:03:20 +0200
Message-Id: <10ffaa74a0779b7c7047de70cb1db7dfb0000022.1625068999.git.b.K.il.h.u+tigbuh@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPuHQ=GbacSTgyimkJtx1FXp319Df=LdrPQZ6ZDnPQ_JVXueKw@mail.gmail.com>
References: <CAPuHQ=GbacSTgyimkJtx1FXp319Df=LdrPQZ6ZDnPQ_JVXueKw@mail.gmail.com>
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
index c71a03a..ae6ea31 100644
--- a/db.txt
+++ b/db.txt
@@ -1587,7 +1587,10 @@ country US: DFS-FCC
 	# requirements, we can extend the range by 5 MHz to make the kernel
 	# happy and be able to use channel 144.
 	(5470 - 5730 @ 160), (23), DFS
-	(5730 - 5850 @ 80), (30)
+	(5730 - 5850 @ 160), (30), AUTO-BW
+	# https://www.federalregister.gov/documents/2021/05/03/2021-08802/use-of-=
the-5850-5925-ghz-band
+	# max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clients
+	(5850 - 5895 @ 160), (27), NO-OUTDOOR, PTMP-ONLY, AUTO-BW, NO-IR
 	# 60g band
 	# reference: section IV-D https://docs.fcc.gov/public/attachments/FCC-16-=
89A1.pdf
 	# channels 1-6 EIRP=3D40dBm(43dBm peak)
