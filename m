Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7453B1B841
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfEMOXp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 10:23:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39290 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfEMOXp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 10:23:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id w8so13082855wrl.6
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=eYwTzeU6ZY30B/JYnW2PX8dKTbyzANTuzswZ9p11ZEE=;
        b=VZJkhTIgl37jUXlLXnsuLgOhuH43bGJG0ixecoW20T67XwGLoAKWsQTYctLThEXhCV
         ShQaSkbVLsNHnL/sXrDG0f1IL0EdKDOD2EIwXJYbX8XR2OJS0snbblyj0kkWaU2nSsD/
         D2uUF1vIuOKigClHpNTvS38dXZLwqG6ewhtm+48iYAQ504A1ecx8LzfRhb79434GHseO
         flKKsfcTRadEYNDTv1iLpvIl/f09F506kdwq/jALijTDTSnQQl7TUeQvKluOG+sn4DN6
         jXBNqFTBKiYpO2unbft/RJZ54CIxEYCh6k/f9SZvLkXuoNzMfvvvkOAbWoSHCuydltH6
         agng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=eYwTzeU6ZY30B/JYnW2PX8dKTbyzANTuzswZ9p11ZEE=;
        b=tgGwg2v9Epak6poX3QwXw9++xWyeco2eeOkXNRSj1Q4z3jiUJ6rm/0WcKvxTRUMqKC
         WDbfgQOq1YFPnlnZSoJ9qZEOBIMOt2dAVuBaUw5xjgxsP5ls/bCX2MUFNaf3VbXmd13f
         JzGQcBpfNoEypEXvmlrVFS/C17/ezxFT23B6uZH4rwLZln4YWtlg+tKvVDeG4CqN8PNw
         TNlOCLuKaWFv5H8FJNFlCCbhKpV+EyA3Ip3pi/IXouypr15mMax6O0d3rJMtbnkprA6r
         dKYd4EcAe+gsZ4lHLbJV9eMWXFyZIBTkfUzn4Ys+g0K8nv+pfm6GR4ZovRZNlNs087Hz
         M0bw==
X-Gm-Message-State: APjAAAUDPu8ajglwz/CMpHxVMk0gFlwZFY+7PG1j6IvK88hXEYBFY7zz
        /GcE//YdOKmfagF8a4S4x0OS6S0+QUQzeC6DyQE=
X-Google-Smtp-Source: APXvYqwFTQAbqNWHE8FU4DdQRT0B9flIPbOAZGghsOWBHjjYaUiQxXOvU0hiuUnV8D5JIgnzCTOSfiuddMfxVrIDV1A=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr5774572wrq.285.1557757423219;
 Mon, 13 May 2019 07:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com>
 <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
 <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com> <CA+icZUWJ0kZSqogg18LdP2YkNXk=_SNnT7-ufkd_Xp1ak7uchg@mail.gmail.com>
 <20190513095059.GN9224@smile.fi.intel.com> <CA+icZUWXSup0BfXNZXxcrAAbu-b9KCiBU++OkC+eFqacMrTwRg@mail.gmail.com>
 <20190513105745.GR9224@smile.fi.intel.com> <CA+icZUVDTx_ZUuOgHVDmg5_a4tgrRkPp880+0KPaRJ1d=zF5VQ@mail.gmail.com>
 <20190513124049.GT9224@smile.fi.intel.com> <CA+icZUWU2OQszOYi1Jzp7yW+gB-TmhkBfmqaLAvy3WEOn9Rh8g@mail.gmail.com>
 <20190513141128.GY9224@smile.fi.intel.com>
In-Reply-To: <20190513141128.GY9224@smile.fi.intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 16:23:32 +0200
Message-ID: <CA+icZUWLhvn66Tx4ao8sZA_=-cjMHQ01rshmsRWEYWXY_3Jw4A@mail.gmail.com>
Subject: Re: [linux-nfc] ThinkPad T470 and NXP PN5xx (PN547 or PN548)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 4:11 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, May 13, 2019 at 03:32:52PM +0200, Sedat Dilek wrote:
> > BTW, which Linux Kconfig setting are minimum?
> >
> > scripts/config -m NFC_NCI -m NFC_NXP_NCI -m NFC_NXP_NCI_I2C
> >
> > What about?
> >
> > scripts/config -m NFC_NCI_SPI -m NFC_NCI_UART -m I2C_GPIO -m SPI_GPIO
> >
> > Required?
> > Not needed?
>
> I2C_GPIO and SPI_GPIO has nothing to do with all this. What indeed is needed is
> the pin control of the actual Intel SoC (unfortunately I don't know what
> exactly you have, so, you better to check yourself), something like
> CONFIG_PINCTRL_SKYLAKE=y.
>

OK.

What is with NFC_NCI_SPI and NFC_NCI_UART Kconfigs?

I had never changed PINCTRL Kconfigs, so what I have is/was...

$ grep PINCTRL .config | grep ^CONFIG | sort
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL=y

Which one is this?

And if PINCTRL_XXX is mandatory, shall it be added as Kconfig
dependency in drivers/nfc/nxp-nci/Kconfig?

- Sedat -

P.S.: List of unset PINCTRL Kconfigs

$ grep PINCTRL .config | grep ^'# CONFIG' | sort
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
