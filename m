Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FA03D11B4
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 16:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbhGUOO6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 10:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbhGUOOx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 10:14:53 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4EFC061575
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jul 2021 07:55:29 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g19so3611842ybe.11
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jul 2021 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UmsZjPxH8FFxWnaoHfCAeuJj3SPZVHDgTz7Y67PjsJw=;
        b=qXF6UC97hj/Wdh0m7Ge7VrRo7v5oDgIagVPIcGwkl6aYfGtlUBoH0bjq5p0rab6BHV
         O0oIHlRv2xsyWiv5e1xtyHCI3oLvjsY21U12zc5hyt3fda8T/DOCh1MPb8YaiEjR16PC
         1TbcahEnGdE4ZQm5gXEKtaTeDdGTcvKdqKT84/muCwiNPeXTGjWSWcCSodfo4V2Sk9Ou
         6AsvUrGseF8ehUL9LCRrbMrkg5+kfp/1zqWon2vd1LZjKB2/hZoWc7anhyY/ymuRDKGf
         PwlHRWyWNACm5bQEl0yuWNR09FG9VXQf9H3lDdpPhTWqDF2bt2RFIYQKNPb8QcbupQz/
         AnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UmsZjPxH8FFxWnaoHfCAeuJj3SPZVHDgTz7Y67PjsJw=;
        b=rvqIm2iiUjPyhsi3POMjXotsYUcwtH5wcfZtrl3XtGd6X0uOPv1zo5gsYhF2kT+Hcb
         C82fAcmKh1ipq3gJhB5xS7onYOMYBU9ndalv2Kdjt8YiZE7l5eMd+7jJjDSF00uJzVsN
         KvvjJsheVll7ZbD9trVAiaH2rybqv3UR+L8XaCB0LE242e2mv6lesQctXsMwvmqugX5g
         z63XiAgLJQ6NV6saZDEbZZlkexeu3vDt7L4lKmOROeRtC7iz5jgu+b8w9goAP1raOBC+
         h0opzgfliB6a+cKQ3qbkywkehh3zXCY4D1k/a95joXt6xJ0kWRLWJn8ZzvE3+ljEveIk
         T8Pw==
X-Gm-Message-State: AOAM5308ZROHTU6thlPw41c1TaiU7nmLBfv6n/0Ecz0fg8Tf3WoOsgPR
        oO1oPEYGLT5pXYqZzNULP5Il4f1ovsGZfWlHxR034rN1n896f/jb5/k=
X-Google-Smtp-Source: ABdhPJzPZ8Qh2c7vwCZx686Si7TVtVkWpZaSsQdxQQpi+yWhWjDizc/ffGknaUmOg5L1zJBTR5XgnL/amZUVOHZwCzY=
X-Received: by 2002:a25:7394:: with SMTP id o142mr47934092ybc.220.1626879328309;
 Wed, 21 Jul 2021 07:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <CANB4YXTf0DhJfL6kPa26ZCzj8FRwwdw_enGROzL-zXuWGyrwOQ@mail.gmail.com>
 <CANB4YXRtyvgu946rL=gxaRqhXja1qfBQ+DSYfiMvYcax7o45EQ@mail.gmail.com> <YPgvMph+3vRbrol3@ubuntu-x1>
In-Reply-To: <YPgvMph+3vRbrol3@ubuntu-x1>
From:   Timo Witte <timo.witte@gmail.com>
Date:   Wed, 21 Jul 2021 16:55:17 +0200
Message-ID: <CANB4YXRcr=XM00r_mz2ejAfuYwHMibffOcxNiDP=acpmFUchMA@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Germany (DE) on 6GHz
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Timo Witte <timo.witte@gmail.com>
---
 db.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/db.txt b/db.txt
index 1e5ed03..411b7ac 100644
--- a/db.txt
+++ b/db.txt
@@ -448,6 +448,12 @@ country CZ: DFS-ETSI
 # Bereich 57 GHz - 66 GHz f=C3=BCr Funkanwendungen f=C3=BCr weitbandige
 # Daten=C3=BCbertragungssysteme; =E2=80=9EMultiple Gigabit WAS/RLAN System=
s (MGWS)=E2=80=9C).
 # https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Tel=
ekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/20=
11_08_MGWS_pdf.pdf
+#
+# Allocation for the WiFi 6E Band (Allgemeinzuteilung von Frequenzen im
+# Bereich 5945 MHz - 6425 MHz f=C3=BCr drahtlose Zugangssysteme,
+# einschlie=C3=9Flich lokaler Funknetze WAS/WLAN (=E2=80=9EWireless Access=
 Systems
+# including Wireless Local Area Networks=E2=80=9C))
+# https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Tel=
ekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/Mo=
bilfunkDectWlanCBFunk/v>
 country DE: DFS-ETSI
        (2400 - 2483.5 @ 40), (100 mW)
        (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
@@ -455,6 +461,10 @@ country DE: DFS-ETSI
        (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
        # short range devices (ETSI EN 300 440-1)
        (5725 - 5875 @ 80), (25 mW)
+       # WiFi 6E
+       (5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
+       # WiFi 6E Short range (Outdoor allowed)
+       (5945 - 6425 @ 160), (25 mW), AUTO-BW, wmmrule=3DETSI
        # 60 GHz band channels 1-4 (ETSI EN 302 567)
        (57000 - 66000 @ 2160), (40)

--=20
2.31.1

On Wed, Jul 21, 2021 at 4:29 PM Seth Forshee <sforshee@kernel.org> wrote:
>
> On Mon, Jul 19, 2021 at 02:20:34AM +0200, Timo Witte wrote:
> > The bundesnetzagentur has assigned WiFi 6E frequencies for germany you
> > this is the
> > publication of that change:
> > https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Te=
lekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/M=
obilfunkDectWlanCBFunk/vfg552021WLAN6GHz.pdf?__blob=3DpublicationFile&v=3D3
> >
> > Following frequencies have been assigned for general use:
> > 5945 - 6425 Mhz
> > maximum (200 mW)
> > No outdoor usage is allowed for 200mW
> >
> > For "very low power devices" outdoor usage
> > is allowed, but only with (25 mW)
> > same frequency range 5945 - 6425
> >
> > There is no DFS requirement.
>
> This all matches with my reading of a translated version of the
> document. Do you plan to send a patch to add this range? If not, I can
> send one.
>
> Thanks,
> Seth
