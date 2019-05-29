Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F312D923
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 11:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfE2JdQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 05:33:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42229 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfE2JdP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 05:33:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id 188so1726027ljf.9
        for <linux-wireless@vger.kernel.org>; Wed, 29 May 2019 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=khQe+ZPxYMqpBG1IezHbw09lCcnzVR0JRN8Fkyeq7b8=;
        b=sE6oWhvGektjgQ2nv82QgjE4E2YY/BOIETk6k+usn02woD4AyDAjZPwjQy0eWoVI6/
         DzIBrlcrXV+GiW7i6T9UxBDYyjRXfMPDS1dFgpNSN/4KH20pBM4RJx0iLvglAFJZ1YXN
         +UbNXphwb5NJphqNiX/L1Jg0B96FkfLMxBKpV/tO8zmGh0DN2oIJqRwJmHaYIV+cub7l
         JuLVxSBnMOwrzp64j/MmjYwF9n+mp5eEROY7LfYW+C85GwDD/XOg6dZ5Tmu1jiCwg/JC
         wrC3x06ZB/7u7nC3yiuIqq4NhfI/2mBFn4ssb5T7yKD4dfvTsQQxCSTJscMGWS5UUNxp
         RZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=khQe+ZPxYMqpBG1IezHbw09lCcnzVR0JRN8Fkyeq7b8=;
        b=fWMBrIpSr7FULm6hRJTVTqDE1KIeC5a3/Sjzvg6LP9/jBsrxf9ae8+AqOnedsRAjte
         KPMDZYp/X1YliSmbHDX8aibTi9B+CJZYOaugDVN9pok430tFHB3LLFvmn/YCfgTTIT0Z
         V4MUUc2PNq3E7y5ZSpstk8OFC9ZrDIdzGMhN259/Iy1exNLQWt3766+jsuHMBSGaStXc
         UIAqOmG0SaCmrXUit2+wEVEwfSHOhG66xI1cWTJyL+bK2HPophwZKw4BsU6xVfnnxh1j
         qgiCmhyUNtEaFBzMdWsZQ+xF51SBV6m9Pb62sFPSJzef9i3345a0I45lzZOONrmfoKdw
         i3Gg==
X-Gm-Message-State: APjAAAWXKUZ8gcAiEjxDOgCY7LFxYV9UxuutpK/4xmmuH7KCOLuHiN8N
        e5GYboDbDQIUv4bI2hS+ufCo9ISO7H15JK0N81Q=
X-Google-Smtp-Source: APXvYqyJs9ytxOvaS7WtJu2bOez7wZjUzL6XU9hg52gn5XanxdahjBLtr/+80Tk/gObfJudbJa7jdwum3qvi6bXEvmU=
X-Received: by 2002:a2e:9e4d:: with SMTP id g13mr24700101ljk.80.1559122393813;
 Wed, 29 May 2019 02:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
 <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com>
 <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org> <CA+icZUXDLQKyTH-_pPi7A2=Bu5ratwab930Fcecrdr4NtMnFcw@mail.gmail.com>
 <27f2ce02-8deb-384f-af10-7737b703770a@linaro.org> <CA+icZUVaBdswfmRfbRtdVJY8ymeDOwDSFEf7G6jneqEmpW84bg@mail.gmail.com>
 <525160f3-a76c-4b45-2e05-c27aaabbf74d@linaro.org>
In-Reply-To: <525160f3-a76c-4b45-2e05-c27aaabbf74d@linaro.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 29 May 2019 11:33:02 +0200
Message-ID: <CA+icZUWrP5avSSxzK45gza6VUYWiUDHv9jyC4vrF+aCYVmMCZQ@mail.gmail.com>
Subject: Re: NXP NFC version and ACPI
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        oleg.zhurakivskyy@intel.com, clement.perrochaud@effinnov.com,
        charles.gorand@effinnov.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Martin Weinelt <hexa@darmstadt.ccc.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, May 19, 2019 at 6:46 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> FYI, when I tried to make the NFC work on my x280, I tried the module at:
>
> https://github.com/jr64/nxp-pn5xx
>
> AFAIR, it finally worked somehow.
>
> May be you can cross check with your series and the change in this
> module to find out what could be missing? (I can do that but it will be
> certainly easier for you spot something in the code you wrote).
>
> I can experiment your changes in my laptop if needed.
>

[ CC Martin W. ]

Hi Daniel,

I was on holidays the last week and started working yesterday.

The patchset is from Andy S. (see CC list).
Hmm, I haven't see a v3 yet.

As said I am new to NFC and played a bit with Andy's v2 patchset and
neard (daemon).
Before this I played with stuff from https://github.com/jr64/nxp-pn5xx
together with NXP's libnfc-nci.
Martin W. is reporting problems with v2 in [1].

Is it possible to report your experiences/findings to Andy's v2
patchset/cover-letter "[PATCH v2 00/12] NFC: nxp-nci: clean up and
support new ID"?

Thanks.

Regards,
- Sedat -

[1] https://github.com/nfc-tools/libnfc/issues/455#issuecomment-493576740






>
> On 14/05/2019 16:59, Sedat Dilek wrote:
> > On Tue, May 14, 2019 at 10:17 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > [...]
> >
> > Just for the records:
> >
> > root@iniza:~# rfkill --output ID,TYPE
> > ID TYPE
> >  0 bluetooth
> >  1 nfc
> >  2 wlan
> >  3 bluetooth
> >
> > root@iniza:~# rfkill list nfc
> > 1: nfc0: NFC
> >         Soft blocked: no
> >         Hard blocked: no
> >
> > - Sedat -
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
