Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E81DE1BE4C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 22:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfEMUDN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 16:03:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54128 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMUDN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 16:03:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id 198so556854wme.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=U2V70HHgq1G8IBAe48iadiBr2eJH/xQZxJnZViWgA4s=;
        b=K0R9v5xEBOGo+2EQkGypkZFNd0TDfuRi9yYCnpmXT7M0vEVkcTVDCdPBlKkCW3mJg4
         mnIk0wni/j+eYSK+aZ7Q0n/Ka9pBjL89QEO1+yQ46b014uPLRjiHN4N8aKtLDUVpM2BE
         BvTHJ04iUsZh3YTo1uabjy+ToOz6dpcFH1p/sOQpkNmy+yp7qhz4AgkVZA6+EPQf4SxM
         xstucGBmq5NpGiKiK+omtA6jY2yDL6cAWb3Z9dkRudfWXj1JkX9Lxkn8ffvRU/HoGRJ9
         JN1PE506ShT+OKs1XRljJVRZIB2SkuNDQgoEUsB6TWERyy8MFTS8xWyS2HpDXSORE1u1
         cO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=U2V70HHgq1G8IBAe48iadiBr2eJH/xQZxJnZViWgA4s=;
        b=FqW8DP3kRUSl5jmTW4NcZMl8sY1JdaHwEfZgCjn2K5g7y0B1aOb8JuhEjG1h2grboy
         NM5lWbNxsiKWiwbOqxnqv0c8Qh4XkoaxgLeeW4evKYtB6vMwhhtNRW+yspNDYCG0lthb
         If1BUUhcmyEoXvN4HQUGBPhTVgQLiPWXj9tPE6STDswBlBvCUlwj8uQfzNhTg2350Mbt
         Dh1UeOEPlvW8Hzl0KY63cbCV+kBEKcJHAnqfSzZUCWA4cQHAZ1g7TNHQYCWgKfNm+Gb3
         6WbitWbt8PyMruhKT6anY8cR6c5Fiye6zgaWsTMpN+HSCmFh+8SA38//cHtbpWxTw7Hv
         OHdA==
X-Gm-Message-State: APjAAAUa8ieJeFKChF3kZz9YO+2WAlev2/wMpQrM7uByS36ASv9WMcpx
        +HoDV4iIhykSpMZp5tzVpt5ldGTlorm/0desz64joPDMFtk=
X-Google-Smtp-Source: APXvYqwzoneKL8ojrC8BcmjTUH07XF4Mv3gYTVaF4KZr9FLK0iqIm2jBeLxloXRciUvL1G8pSRlFZuhvHPDxW0PfwM8=
X-Received: by 2002:a1c:9616:: with SMTP id y22mr6079303wmd.73.1557777792012;
 Mon, 13 May 2019 13:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com>
 <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
 <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com> <CA+icZUWJ0kZSqogg18LdP2YkNXk=_SNnT7-ufkd_Xp1ak7uchg@mail.gmail.com>
 <20190513095059.GN9224@smile.fi.intel.com> <CA+icZUWXSup0BfXNZXxcrAAbu-b9KCiBU++OkC+eFqacMrTwRg@mail.gmail.com>
 <20190513105745.GR9224@smile.fi.intel.com> <CA+icZUVDTx_ZUuOgHVDmg5_a4tgrRkPp880+0KPaRJ1d=zF5VQ@mail.gmail.com>
 <20190513124049.GT9224@smile.fi.intel.com> <CA+icZUWU2OQszOYi1Jzp7yW+gB-TmhkBfmqaLAvy3WEOn9Rh8g@mail.gmail.com>
 <20190513141128.GY9224@smile.fi.intel.com> <CA+icZUUsutHt1NXLNFd17J3QK-LtFCuUUEw4qqp9urJ++dDaKA@mail.gmail.com>
In-Reply-To: <CA+icZUUsutHt1NXLNFd17J3QK-LtFCuUUEw4qqp9urJ++dDaKA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 22:02:58 +0200
Message-ID: <CA+icZUXrJieuF8DLVbce=sTVa_2Wc+sgjzh0z3d2Zw91cC9kXw@mail.gmail.com>
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

On Mon, May 13, 2019 at 9:46 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, May 13, 2019 at 4:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, May 13, 2019 at 03:32:52PM +0200, Sedat Dilek wrote:
> > > BTW, which Linux Kconfig setting are minimum?
> > >
> > > scripts/config -m NFC_NCI -m NFC_NXP_NCI -m NFC_NXP_NCI_I2C
> > >
> > > What about?
> > >
> > > scripts/config -m NFC_NCI_SPI -m NFC_NCI_UART -m I2C_GPIO -m SPI_GPIO
> > >
> > > Required?
> > > Not needed?
> >
> > I2C_GPIO and SPI_GPIO has nothing to do with all this. What indeed is needed is
> > the pin control of the actual Intel SoC (unfortunately I don't know what
> > exactly you have, so, you better to check yourself), something like
> > CONFIG_PINCTRL_SKYLAKE=y.
> >
>
> I played a bit with the Kconfigs...
>
> scripts/config -m NFC_NCI -m NFC_NXP_NCI -m NFC_NXP_NCI_I2C
>
> ...is sufficient.
>
> I don't know which CONFIG_PINCTRL_XXX is needed.
>

I looked at lspci output and I see a lot of "Intel Corporation Sunrise
Point-LP", especially...

00:15.0 Signal processing controller: Intel Corporation Sunrise
Point-LP Serial IO I2C Controller #0 (rev 21)

I have set...

CONFIG_PINCTRL_SUNRISEPOINT=y

From [1]:

config PINCTRL_SUNRISEPOINT
tristate "Intel Sunrisepoint pinctrl and GPIO driver"
depends on ACPI
select PINCTRL_INTEL
help
Sunrisepoint is the PCH of Intel Skylake. This pinctrl driver
provides an interface that allows configuring of PCH pins and
using them as GPIOs.

- Sedat -

[1] https://github.com/torvalds/linux/blob/master/drivers/pinctrl/intel/Kconfig#L109
