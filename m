Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED72943BC67
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 23:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbhJZVbw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 17:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbhJZVbq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 17:31:46 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0987DC061243
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 14:29:22 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t4so556373oie.5
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x99H1lMbzIZFDp6LJaer03qi6jO5U0kgwHYTrz9uV5s=;
        b=RuWSspvOhOjASbTgefDL+ubQtVvDXSqmkIodYId3SpU45hdOVR4wXmEHJR1ErMZUkw
         PuKUnkrUL8PJibsL+V01zmJAV9jWuwfpxi7Ruw50ordiFRv8fhO+YVxtHAQP0tktnt4j
         tjqxa/bBvZhgBmIJrKWbXzAV4j+Z0ke8D/2hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x99H1lMbzIZFDp6LJaer03qi6jO5U0kgwHYTrz9uV5s=;
        b=iIRmtUmfR+zZFhjQQeyPjTcI5tKJe1GafFtzkFgTHpN3lXXZwbGoOEGwh1TQJOQ4r4
         gToT35do1ftzpHFhzzFE1GSgoKbZi4HesEeKV71BwjGv12nFovgzWtPI+Vj3XdQ6dxI2
         a99M6hl89KFbDbGdHr0OK2ELSY9yE0Poq6bcP1SW5MdPe6yhtbgL0J+hqmEpl/xZDFwt
         QgnCmifb9u/KNNcjiNrLljOqS8hICeFrwVCsuwZlrHKSS3EbprdjvW1aWuUNE2gngR7g
         Otg1wJhpP9gJijv2b5GYjDp+MniILB7lcAWvWuFpJ5fULeWYrHspKAQBMiYwEaoDPG63
         Tctw==
X-Gm-Message-State: AOAM532WSzO17DsDIclcZrYZG7IgVHpPL+uTQ+ON8N6U/X/LAb0Awzz6
        lX4e2S93zV47QOaX7KwJeh0pnlt2tZaLNQ==
X-Google-Smtp-Source: ABdhPJzQT5YkIuihr6BliqEcz/fhMi9njXZwlSukU1rTO34JYKYZpXVurQhaZzts+zeMtxymSO7uBg==
X-Received: by 2002:a05:6808:1287:: with SMTP id a7mr946450oiw.92.1635283761087;
        Tue, 26 Oct 2021 14:29:21 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id w20sm4842672otj.23.2021.10.26.14.29.20
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 14:29:20 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso645310otl.4
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 14:29:20 -0700 (PDT)
X-Received: by 2002:a05:6830:44a9:: with SMTP id r41mr21652663otv.230.1635283759965;
 Tue, 26 Oct 2021 14:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <YXKXf1cBjPWqD1Aw@elm.arvanta.net> <CA+ASDXPExGHnDdZwvMGbZTTYB76Psy2JMTH7RTnvO1Zggh6c_w@mail.gmail.com>
 <YXhw+qwY1rtkPk+1@elm.arvanta.net>
In-Reply-To: <YXhw+qwY1rtkPk+1@elm.arvanta.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Oct 2021 14:29:06 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP6v3sJj9YEXpOMk+F73dd5sUs_PHWm5+ye16yJsy2S0g@mail.gmail.com>
Message-ID: <CA+ASDXP6v3sJj9YEXpOMk+F73dd5sUs_PHWm5+ye16yJsy2S0g@mail.gmail.com>
Subject: Re: [BUG] mwifiex sdio wifi crashes on samsung peach pi chromebook
To:     =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 26, 2021 at 2:20 PM Milan P. Stani=C4=87 <mps@arvanta.net> wrot=
e:
> On Tue, 2021-10-26 at 13:55, Brian Norris wrote:
> > On Fri, Oct 22, 2021 at 4:20 AM Milan P. Stani=C4=87 <mps@arvanta.net> =
wrote:
> > > On my chromebook samsung peach pi (exynos-5800) wifi driver stops to
> > > work at random time, sometimes after few hours and sometimes after da=
y
> > > or two.
> >
> > I don't have official recommendations, nor HW to test at the moment,
> > but for the record, Peach Pi should have Marvell SD 8797. You can see
> > what firmware Chrome OS used to ship for those devices here:
> >
> > https://chromium.googlesource.com/chromiumos/third_party/marvell/+/HEAD=
/sd8797_uapsta.bin
> > https://chromium.googlesource.com/chromiumos/third_party/marvell/+log/H=
EAD/sd8797_uapsta.bin
>
> On these urls I can't find actual file to download, or I'm blind (or
> don't understand how this site 'works').
> Whatever I click I get new url and not binary file to download.

Ack, I forgot Gitiles is not super friendly for downloading binaries direct=
ly:

https://github.com/google/gitiles/issues/106

> Could you give url for binary file that I could download, please?

This should do it:

curl https://chromium.googlesource.com/chromiumos/third_party/marvell/+/HEA=
D/sd8797_uapsta.bin?format=3DTEXT
| base64 -d > sd8797_uapsta.bin

Or some similar invocation if you have to use the browser (click on
the "txt" link, then base64-decode the result).

> > > kernel is mainline 5.14.4 without patches, but I recall that I notice=
d
> > > this crashes on older ones but can't remember exact version.
> >
> > Did it ever work well? I'm curious if this was a kernel regression, or
> > perhaps just a long-standing firmware issue.
>
> Yes, it worked for few years but started to crash about few months ago
> and that happened when I upgraded complete root filesystem, so it could
> be related to upgraded firmware. Thank you for hint what to try to test.

Could be. It does look like mainline linux-firmware got an update for
this file in 2019, so it's possible your distro (or whatever provides
your rootfs) only semi-recently got the update.

Brian
