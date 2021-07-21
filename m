Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB63D12D8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbhGUPL3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 11:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhGUPL3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 11:11:29 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3E6C061575
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jul 2021 08:52:04 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y38so998612ybi.1
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jul 2021 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0NSzMCBViK9VUo/AWDOH1q3+m7aEVw5xrnW3zvr8/+s=;
        b=n7/LVlsVJN1GGJYlq3BdudFCk5VTojoAOPQe2ye5NOML7DWYH53PqmPIVfBl1Hu9eJ
         D/XqhKXLY4YLSpGVM2l+Bs4m07Eoa0r/uJS5HYl6htzZRbt8z4gCkFJoxwQI1xlTCsBj
         zIoKe7eNktwD2N0YaEv8Hwa6yBySnItD2AlqelkoiZ/zAcyGl+YkkPSZXXaXulXYprbR
         UdRW+GRXrnsVoYDkwomxZ+iJwZSQS6E4oCpPMgiIIZHBVBr4FurTpmM3ETajvlboAymY
         GrVZzzpgzEdA/8X0fVgw94j4aC0PKIymB7AIilQIpZoaPc26WOzpJIE5oRdJFTJ7VdOb
         Y2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0NSzMCBViK9VUo/AWDOH1q3+m7aEVw5xrnW3zvr8/+s=;
        b=UheaPp7nH0PcHOKjZjfgBJ5Z/Ez29l+hbJO86ed8i7gqZwCfuxqbz4TesW6AU6xFX3
         MseRre33zvxDkAc571BGpMXh6FfDgkRvk93mpFVrzlHQEEnvDJg3ped5HAOIMZEku/xi
         jODU3qbZb7Z0O0/EYygPqH4+mHHhMM0jY/fxibiVVkyy/Yjaca7UQtwm3p/MX2DoU8Bz
         NeqC7ynP3YLxAmpTFP2LFRc5FhwvJq0ledLeb29CcF8co2a/tald3OH6mpc6rWQ7vsxx
         26N7ynuDCi6gyNINl8wXwIEGpoYTo5PZRL/iGhB0KfmCI3dsyjCHifNWYTWGgRQpp0OR
         kviw==
X-Gm-Message-State: AOAM530BlO+1/F/OKY95fWAaqdcD8H40Fzb/vENIOzahDsMUWHCFjdpr
        Hf7no+wlK6GFJmPUtfi3r7QX11z8rbAAtTkVJ+0=
X-Google-Smtp-Source: ABdhPJwaFGTpOC8t7SF4mUbd+mBqsaZJkntj6RcSGRXZXVhOSFcCDgxezjJplzic6Kp4yFfQ8QuhgNnf47nixmzNb0k=
X-Received: by 2002:a25:b3c9:: with SMTP id x9mr45681434ybf.514.1626882723690;
 Wed, 21 Jul 2021 08:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <CANB4YXTf0DhJfL6kPa26ZCzj8FRwwdw_enGROzL-zXuWGyrwOQ@mail.gmail.com>
 <CANB4YXRtyvgu946rL=gxaRqhXja1qfBQ+DSYfiMvYcax7o45EQ@mail.gmail.com>
 <YPgvMph+3vRbrol3@ubuntu-x1> <CANB4YXSDuYndC26KPkV+XqPkowbN54MMceuj7MNaxh+EwLN4kw@mail.gmail.com>
 <YPg83HXFIXDAEFx1@ubuntu-x1>
In-Reply-To: <YPg83HXFIXDAEFx1@ubuntu-x1>
From:   Timo Witte <timo.witte@gmail.com>
Date:   Wed, 21 Jul 2021 17:51:53 +0200
Message-ID: <CANB4YXS64QtxsgY0bx_Ri7bWfTY_5Ry7PbGwaGT3QVZb380vgQ@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Germany (DE) on 6GHz
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ok then let's just remove the 25mW line.
Here is the new patch:

diff --git a/db.txt b/db.txt
index 1e5ed03..debd878 100644
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
bilfunkDectWlanCBFunk/vfg552021WLAN6GHz.pdf
 country DE: DFS-ETSI
  (2400 - 2483.5 @ 40), (100 mW)
  (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
@@ -455,6 +461,8 @@ country DE: DFS-ETSI
  (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
  # short range devices (ETSI EN 300 440-1)
  (5725 - 5875 @ 80), (25 mW)
+ # WiFi 6E
+ (5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
  # 60 GHz band channels 1-4 (ETSI EN 302 567)
  (57000 - 66000 @ 2160), (40)


On Wed, Jul 21, 2021 at 5:27 PM Seth Forshee <sforshee@kernel.org> wrote:
>
> On Wed, Jul 21, 2021 at 04:57:03PM +0200, Timo Witte wrote:
> > From f9a99269b00f961e40024632c7b831c615bfa392 Mon Sep 17 00:00:00 2001
> > From: Timo Witte <timo.witte@gmail.com>
> > Date: Wed, 21 Jul 2021 16:51:40 +0200
> > Subject: [PATCH] add wifi6e for germany
> >
> > Signed-off-by: Timo Witte <timo.witte@gmail.com>
> > ---
> >  db.txt | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/db.txt b/db.txt
> > index 1e5ed03..411b7ac 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -448,6 +448,12 @@ country CZ: DFS-ETSI
> >  # Bereich 57 GHz - 66 GHz f=C3=BCr Funkanwendungen f=C3=BCr weitbandig=
e
> >  # Daten=C3=BCbertragungssysteme; =E2=80=9EMultiple Gigabit WAS/RLAN Sy=
stems (MGWS)=E2=80=9C).
> >  # https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete=
/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilunge=
n/2011_08_MGWS_pdf.pdf
> > +#
> > +# Allocation for the WiFi 6E Band (Allgemeinzuteilung von Frequenzen i=
m
> > +# Bereich 5945 MHz - 6425 MHz f=C3=BCr drahtlose Zugangssysteme,
> > +# einschlie=C3=9Flich lokaler Funknetze WAS/WLAN (=E2=80=9EWireless Ac=
cess Systems
> > +# including Wireless Local Area Networks=E2=80=9C))
> > +# https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete=
/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilunge=
n/MobilfunkDectWlanCBFunk/vfg552021WLAN6GHz.pdf
> >  country DE: DFS-ETSI
> >         (2400 - 2483.5 @ 40), (100 mW)
> >         (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DET=
SI
> > @@ -455,6 +461,10 @@ country DE: DFS-ETSI
> >         (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
> >         # short range devices (ETSI EN 300 440-1)
> >         (5725 - 5875 @ 80), (25 mW)
> > +       # WiFi 6E
> > +       (5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DE=
TSI
> > +       # WiFi 6E Short range (Outdoor allowed)
> > +       (5945 - 6425 @ 160), (25 mW), AUTO-BW, wmmrule=3DETSI
>
> Unfortunately the kernel doesn't support multiple rules for a given
> range with differing flags. Currently it is necessary to specify either
> the indoor power limit with NO-OUTDOOR or the outdoor power limit, but
> not both.
>
> Thanks,
> Seth
