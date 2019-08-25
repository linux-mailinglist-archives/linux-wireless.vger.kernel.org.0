Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24379C600
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2019 21:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfHYT7N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Aug 2019 15:59:13 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36597 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHYT7N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Aug 2019 15:59:13 -0400
Received: by mail-yb1-f195.google.com with SMTP id m9so6295774ybm.3;
        Sun, 25 Aug 2019 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rwdGdHc5KELH58u1BLWdqe0IVwKNlhK1cPic66vQ+zU=;
        b=bSajX2fiMz0VjXbIV4wnXHBDvSsPaxrH7TFTd2LSonNzwULf8szR+ynQRM5duKSLiZ
         6u+IW3HboTgjVDEKcLRnzQa8bx+oIxFbncZJaNvGhO2WjoGamaQ0ykejl12qRtdw+xwA
         r1xQMAGVkEQtHJZBIEH5P86kKBdFifIpN/5XOPQSiMriX2HbIjhjvWwI4XPEax4MGltn
         y9GtUmNeasaflS7e2dlYmmg5MO+WCPsjMEqmgYdfzVlMaDvPNsOYJ49o368Xq/OdibJq
         jVKbNQXVGxxEgkpKt5+8b7wIEm+b6i7b6qdSr9eUWrbkAxRbTuSnf2T+4rNxVulHHLgd
         s5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rwdGdHc5KELH58u1BLWdqe0IVwKNlhK1cPic66vQ+zU=;
        b=f2aUix0Ek9hiLQA2HwFSGHX5ahoMp+yzHtKbCR/mVGSYsCuehAKwJnyl9REo2HW/bi
         KkV7SsoXqlamZH43e3U2ReqZkzZa8fIGzXRgNz7SKjEM9j9dHSxsXu8ya5Ekawrr8Dwb
         bkY+D4E1+FrZ8pWYfWTzniUQw9Wj9FDd8rWsLNQ2zehcW7M+Zkdp8y3Qgcq9mFOPMx/s
         6dSwvx4DatL6MsQKuovwdYIRHin67aUUyCOtx/8p52KMthH0aeglSTPfojYUZHUOcQXB
         YLdUbKhBA1XWhC+xcngp3nIq2MNH8B81Wk6x4M5ZrMj4P0oiFhqtWT2s6dn4JvvGb6FE
         P2kg==
X-Gm-Message-State: APjAAAXz8b2RSjfED8VuXCUE0a9og6D67g16iAnWasd4hS0w8LpSMBjA
        6kf0j6ige9ImB1lcR1sLi3QJpOwA2qkWZVx1idLoKB7d
X-Google-Smtp-Source: APXvYqzwvRBFD8dbPT63nz0/dQB3HooyKUWSSED2MN2hPgbFCv35jNh6d0sMzl66Umz9z6f5+8DZoLUyJu3J6cf1iGw=
X-Received: by 2002:a25:2f56:: with SMTP id v83mr9833100ybv.2.1566763152247;
 Sun, 25 Aug 2019 12:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190822133524.6274-1-colin.king@canonical.com>
 <d3c16158-ef89-f5ee-2f67-4357c70e8fe9@lwfinger.net> <31258833-174f-080b-489e-85d3556bd1de@canonical.com>
In-Reply-To: <31258833-174f-080b-489e-85d3556bd1de@canonical.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Sun, 25 Aug 2019 21:59:01 +0200
Message-ID: <CACna6ryAmfhUENTWR33Xfngh_6zJe0EF_JKAxDUXXZPHYevkzA@mail.gmail.com>
Subject: Re: [PATCH] bcma: fix incorrect update of BCMA_CORE_PCI_MDIO_DATA
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 22 Aug 2019 at 18:11, Colin Ian King <colin.king@canonical.com> wro=
te:
> On 22/08/2019 17:03, Larry Finger wrote:
> > On 8/22/19 8:35 AM, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> An earlier commit re-worked the setting of the bitmask and is now
> >> assigning v with some bit flags rather than bitwise or-ing them
> >> into v, consequently the earlier bit-settings of v are being lost.
> >> Fix this by replacing an assignment with the bitwise or instead.
> >>
> >> Addresses-Coverity: ("Unused value")
> >> Fixes: 2be25cac8402 ("bcma: add constants for PCI and use them")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>   drivers/bcma/driver_pci.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/bcma/driver_pci.c b/drivers/bcma/driver_pci.c
> >> index f499a469e66d..d219ee947c07 100644
> >> --- a/drivers/bcma/driver_pci.c
> >> +++ b/drivers/bcma/driver_pci.c
> >> @@ -78,7 +78,7 @@ static u16 bcma_pcie_mdio_read(struct bcma_drv_pci
> >> *pc, u16 device, u8 address)
> >>           v |=3D (address << BCMA_CORE_PCI_MDIODATA_REGADDR_SHF_OLD);
> >>       }
> >>   -    v =3D BCMA_CORE_PCI_MDIODATA_START;
> >> +    v |=3D BCMA_CORE_PCI_MDIODATA_START;
> >>       v |=3D BCMA_CORE_PCI_MDIODATA_READ;
> >>       v |=3D BCMA_CORE_PCI_MDIODATA_TA;
> >
> > I'm not sure the "Fixes" attribute is correct.
> >
> > The changes for this section in commit 2be25cac8402 are
> >
> > -       v =3D (1 << 30); /* Start of Transaction */
> > -       v |=3D (1 << 28); /* Write Transaction */
> > -       v |=3D (1 << 17); /* Turnaround */
> > -       v |=3D (0x1F << 18);
> > +       v =3D BCMA_CORE_PCI_MDIODATA_START;
> > +       v |=3D BCMA_CORE_PCI_MDIODATA_WRITE;
> > +       v |=3D (BCMA_CORE_PCI_MDIODATA_DEV_ADDR <<
> > +             BCMA_CORE_PCI_MDIODATA_DEVADDR_SHF);
> > +       v |=3D (BCMA_CORE_PCI_MDIODATA_BLK_ADDR <<
> > +             BCMA_CORE_PCI_MDIODATA_REGADDR_SHF);
> > +       v |=3D BCMA_CORE_PCI_MDIODATA_TA;
> >
> > Because the code has done quite a bit of work on v just above this
> > section, I agree that this is likely an error, but that error happened
> > in an earlier commit. Thus 2be25cac8402 did not introduce the error,
> > merely copied it.
>
> Ugh, this goes back further. I didn't spot that. I'm less confident of
> what the correct settings should be now.
>
> >
> > Has this change been tested?
>
> Afraid not, I don't have the H/W.

Please send V2 with updated commit message (Fixes tag) +
bcma_pcie_mdio_write fixed. I'll try to test it.

--=20
Rafa=C5=82
