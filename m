Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6548F1B4D7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 13:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfEMLW1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 07:22:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36095 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMLW1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 07:22:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id o4so14824932wra.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 04:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qkb9DqnL9mnIE6zOdp6NJcmfQ54eK3ym+z4ZrIXH+i8=;
        b=ZXACPMjbpjxI5hdYko+h9+rnVSbFrw+kb3NB2Y0fLxLz8foEfMzckP6EAi1+mMtFzA
         7xUxrMQ4DJEW8MSfXD4It1Ozt4HlpTOcOl8/Uw0IRcmV7SumYJ5Y7YHj6lt0R646fDjY
         PNP8fP5gj8F8BAHHl47+KQeETT7j52THIs1k1e8bCTf8Z9YYmtqlK3wFQF2GYmUQZ4Ax
         vjUNuP5BcmoyUiilqqIfUC/+JvIqGgn/5yjd8rPSKj+OWGasjVj15h+iVtMnT1lep6lG
         crUdv/1aLCLX2Pj/RNCkCA4anvbkl6adnShn1/cv6tA9sOEFJh4XqIOQm99W5HZiVR2Z
         1ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qkb9DqnL9mnIE6zOdp6NJcmfQ54eK3ym+z4ZrIXH+i8=;
        b=JP+T1yiuaL5J746+8iCY2rXsnnBAfYYOGBPzWnyMaOvbWAbMCW6t1rbR0/FISLoia3
         GHEpYVkt2kIBGrHpP1JVJLucsdT9/8yVBRJRiZmBH/LL+UOihXtkxhiFRVwZNziYsLX+
         /2U1u69cTmnINmVY2q/LdrlQ+QVJXiMRLmwrhFGdgU8F7sq8/quiNHs1f49kEbuJgzXC
         rWK8HDtsZ45Atb0afjXq9RzmtJ8ECOUfkDXKPA5VwFl4vxXW9ehY3jE5Q2knj5opcLXS
         1H95coRNC4WeAfPRR2nibYvbY2Gtnh4avlAegiEeA87ctBh4DSItzz/otZWA7y51cxuY
         uH1w==
X-Gm-Message-State: APjAAAVQLYdE0iMOU8v7YZbvfNRrbnui/GiWIrScE9aglHVEN0MlFWcn
        vQHHIu9/Jm4bujtjma5mIKOzM7CLDD6zNvqdz2Un7VintBE=
X-Google-Smtp-Source: APXvYqzLlMZOpoDQxozscgNM6RUugIjYWmMICLN7o87gYxklznn+z6RsiGhv+kBpjR/tzv0kwXHd7GTC+KqBEgW/7s4=
X-Received: by 2002:a5d:430f:: with SMTP id h15mr16837817wrq.132.1557746545346;
 Mon, 13 May 2019 04:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com> <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
 <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com> <CA+icZUWJ0kZSqogg18LdP2YkNXk=_SNnT7-ufkd_Xp1ak7uchg@mail.gmail.com>
 <20190513095059.GN9224@smile.fi.intel.com> <CA+icZUWXSup0BfXNZXxcrAAbu-b9KCiBU++OkC+eFqacMrTwRg@mail.gmail.com>
 <20190513105745.GR9224@smile.fi.intel.com> <CA+icZUVDTx_ZUuOgHVDmg5_a4tgrRkPp880+0KPaRJ1d=zF5VQ@mail.gmail.com>
In-Reply-To: <CA+icZUVDTx_ZUuOgHVDmg5_a4tgrRkPp880+0KPaRJ1d=zF5VQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 13:22:13 +0200
Message-ID: <CA+icZUWFKfO_1O6QLiy__tOo2m=v+hmG+rsaO+MpuXsvHOFXPw@mail.gmail.com>
Subject: Re: [linux-nfc] ThinkPad T470 and NXP PN5xx (PN547 or PN548)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 1:20 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, May 13, 2019 at 12:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, May 13, 2019 at 12:38:27PM +0200, Sedat Dilek wrote:
> > > On Mon, May 13, 2019 at 11:51 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Mon, May 13, 2019 at 11:27:07AM +0200, Sedat Dilek wrote:
> > > >
> > > > > Sorry to say, I still have not get all correlations...
> > > >
> > > > Can you provide the output of the following on running Linux system=
 with latest
> > > > possible kernel you can install (I am expecting v5.1) and command l=
ine with
> > > > 'ignore_loglevel'?
> > > >
> > > > 1. `dmesg`
> > > > 2. `grep -H 15 /sys/bus/acpi/devices/*/status`
> > > > 3. `acpidump -o t470-tables.dat` # the file t470-tables.dat
> > > > 4. `lspci -vv -nk`
> > > >
> > > > P.S. You may use GitHub gist for this set (please, don't share arch=
ives) or any
> > > > other resource like pastebin.
> > > >
> > >
> > > Looks like I am unable to use Debian's gist-paste package today or
> > > need more coffee.
> > >
> > > So, I add this here.
> > >
> > > I added my kernel-config.
> >
> >
> > Thanks. I just sent a series to (hopefully) support it in the vanilla k=
ernel.
> > Can you test it?
> >
> > P.S. I see in dmesg the pn544 tries to bind to the NXP1001. Do you have=
 some
> > custom patches for that in your kernel? If so, please drop them.
> >
>
> Hi Andy,
>
> this looks promising!
>
> I have attached v2 of the disired outputs.
>

Output of modinfo looks good to me

root@iniza:~# modinfo nxp-nci_i2c
filename:
/lib/modules/5.1.1-1-amd64-gcc8-ldbfd/kernel/drivers/nfc/nxp-nci/nxp-nci_i2=
c.ko
author:         Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
author:         Cl=C3=A9ment Perrochaud <clement.perrochaud@nxp.com>
description:    I2C driver for NXP NCI NFC controllers
license:        GPL
alias:          i2c:nxp-nci_i2c
alias:          acpi*:NXP7471:*
alias:          acpi*:NXP1001:*
alias:          of:N*T*Cnxp,nxp-nci-i2cC*
alias:          of:N*T*Cnxp,nxp-nci-i2c
depends:        nci,nxp-nci
retpoline:      Y
intree:         Y
name:           nxp_nci_i2c
vermagic:       5.1.1-1-amd64-gcc8-ldbfd SMP mod_unload modversions

- Sedat -
