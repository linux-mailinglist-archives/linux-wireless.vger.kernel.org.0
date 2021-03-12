Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16124339767
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Mar 2021 20:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhCLT2Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Mar 2021 14:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhCLT2R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Mar 2021 14:28:17 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46903C061574
        for <linux-wireless@vger.kernel.org>; Fri, 12 Mar 2021 11:28:17 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id s1so3568900ilh.12
        for <linux-wireless@vger.kernel.org>; Fri, 12 Mar 2021 11:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhM+usImUJkJKq9zlG49PHHYQMi7QEpai7ML+B4zaVQ=;
        b=OA0/AdFHsOidV2OEa0NHEnw2JF8+nGBNFYJvqHSk6B3ouO/iQgOSY/tuU+9USIJetz
         eSHv2yxT2UiYWEEC0NJVg9kUrSDJ4EzItx8y6B8Cv6YSlRBjmjs6YcjY12AKg1rOw77T
         Q+yFlDPr8dbzbA4t4B+8LWXSzGRMjrGav+mc3mwWBrWYhtXooPawJfS/6oZYTFgJu6pJ
         9nkdOkpVrKCDwkAAuH1ek/v76Nz1TfR4TxjhAvkftQuL0y8sgkFCo6SWu5dQaCXoemql
         jfKbrERUN+sra9wqJ/5GU3rkW6hmHIQiMcOp2u26mmNf6B2oRb3YyADENSH7vZdBIuWB
         oFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhM+usImUJkJKq9zlG49PHHYQMi7QEpai7ML+B4zaVQ=;
        b=CB8IKjFwFv5ZnxGSEGlX/pjb+TT/+9MEYH+BRAqG4JWXSANBOOgrl7GzzUgkVduzYh
         TRlbNDOZ088Uf5P/LcYXY1acb0JyhTRuBtOAdKH+Isynnm14RY85zsqdIPWBjezr/l26
         Cc4jHYrTur4yrS7sHcYyyWwFgmtSbGS447O6W3XmRb9K5NvhLwlDlMsEz4vQR6tD1MRB
         qDKu2uyC9aNovTCtzxi1Cd2yoBkmrA+Do6K71LaAtRqRAWTn5UlsWiq3THVtRHD+8Q/V
         lgRbZXpBsLHRur/4+KhAnYZv7pJq8XSWufx33OpDtaxjLiARRxsIpp55i+3WrzyCRcjI
         P6dw==
X-Gm-Message-State: AOAM5300v56mOs3y5glKWHV166inrdVS3x4B/8K+tjmJgS+Kzxi273r1
        XaniRJ9nuaRA+79thVW+JfjCMq6OIQi5r9a77vU=
X-Google-Smtp-Source: ABdhPJwzlHF52RWl/1StyQDC6QvfgU3pxo6dzRzdQqIKvNshvgimUHp8Nfwdh4wvyEUdwEd5h2CeGpZKgSqhZYeIagY=
X-Received: by 2002:a92:6b10:: with SMTP id g16mr4070124ilc.26.1615577296538;
 Fri, 12 Mar 2021 11:28:16 -0800 (PST)
MIME-Version: 1.0
References: <CAM2RGhR89fcuPwkNxmiynU6qocjM85ROBA0M+Fw3y9VR-Mh2Pw@mail.gmail.com>
 <b99457e9-c562-45a8-40f8-fafbbda8fd2c@lwfinger.net>
In-Reply-To: <b99457e9-c562-45a8-40f8-fafbbda8fd2c@lwfinger.net>
From:   Evan Foss <evanfoss@gmail.com>
Date:   Fri, 12 Mar 2021 14:28:14 -0500
Message-ID: <CAM2RGhSkamk605iTCikYoNiF_bFU6kV9c198g=5UE_450i9ybw@mail.gmail.com>
Subject: Re: [b43] ssh bug
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        b43-dev <b43-dev@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

I was offering to do testing. You might not remember me from like 15
years ago but I remember you. I was fighting a BCM4311 back then.

The symptoms are interesting. It freezes not just that session but all
other ssh sessions. I want to point out that it doesn't fail in all
ssh use cases, just file i/o. ssh terminal sessions don't cause it but
are also frozen when it hits. After the bug is triggered no new
sessions can be initiated.

What is fun is that it starts doing file i/o before it triggers so
some small number of bytes or time are required. So often I can see
whole directories on remote file systems just before it locks up.

I looked at wl a while back but I really wanted to contribute testing
to fix what remains the one unpatched bug in the driver.

Thanks,
Evan

On Tue, Mar 9, 2021 at 5:26 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 3/9/21 6:18 AM, Evan Foss wrote:
> > Hi B43-dev,
> >
> > I am having trouble with the wifi card in my macbook pro 2012. It's a
> > BCM4331 and it hangs on ssh sessions.
> >
> > I noticed it documented here.
> > https://wiki.archlinux.org/index.php/broadcom_wireless#SSH_freeze_for_BCM4331_with_b43
> >
> > Is there some testing I could contribute to help fix this?
>
> Evan,
>
> I do not have that card, thus I cannot test with that chip.
>
> Given the age of the chips driven by b43, it is hard to imagine that there are
> any undisclosed proprietary secrets buried in the code. Broadcom should open
> source these old drivers.
>
> What are the symptoms of the frozen sessions? Is there anything in particular
> that you are doing when it freezes? Does the freeze require rebooting either of
> the machines in question? Is anything logged in the dmesg output of either machine?
>
> One useful test would be to run Wireshark to capture the data on the network
> interface. That capture file might have information that you would not want to
> share, but you should be able to supply only the last few packets.
>
> A macbook of that vintage should be able to run wl. That may be your best option.
>
> Larry
>
>


--
https://github.com/evanfoss

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

mQENBFYy4RYBCAC183JomLtbdAlcKiaPDoVHq52LDmVmH75aiEc69m7YxDt54/ai
VtYCAobbGVIyn3Hlz3uhF6LnPl/6Lm1VdnCfpwu3KQhCO6ds10ow2C30X4ohCqOd
hCVg5C+ILmQkEffFrFODy3ji+PYTF4pADvHCWsTMv0hf0llwFOJsBCK6cl02IffE
JPqy4PjM1nZ9HpzT84JBaG/4OGvTZ8SQ2yFUl265jagvygPTf88H1xpZHH1r8dB1
stjUHLmPH8AOyDgKxFchgGeDc3p/vJtgDDIXAFfDXG0NSRovLmtaQdGxe47Zf/go
bXiEM7YL2WqQe5zfEA919JxkEwlDKYniOSVzABEBAAG0N0V2YW4gRm9zcyAoVGhp
cyBpcyBteSBwdWJsaWMga2V5LikgPGV2YW5mb3NzQGdtYWlsLmNvbT6JATkEEwEC
ACMFAlYy4RYCGwMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCIpQTcE8nN
bbBaCACAm8pU5lG1ev2Fsw68Axtcl57SJrYieqX96c3YuYH9JpqMqJRnd9nDKw9X
tQuvuH7tUk0VbOaDqReOYJVI/4c5wb9AaOFp6K2DUcupq6XhgXpvz3HzoPwjAdIj
XuQzdRUx5+innTJrSkGuBYW/CZ2zqEx4xfLlq4rO0hoTUMR8QVp2cCrkw6BT0m86
APIw/ZnjoxM8IEzr7MxfRIg3qpzrZk28rmhx+k78Jyk61UhwcCPGIm/pjUopTwYJ
3YBdRB2cYD2aN7A1JVf5cRmSQYooHBGpH0kYvomGk97PKqypVuJ7OpG9xM58wUcC
qUVt9hKlePLzP8csYjt8onqI7qIIuQENBFYy4RYBCADlH8spG3WkCx62vB5mr5Z0
SCDd/RcyA4A5y5EOj5KurQkrSWpgi9Ho1yKruMJ6blQR2qkc66KqH9pnXDm/ZI1M
K/wdW3ngETxBmXoozzFMT89aEWIVR5/PFodWK1elekE9iJxACuR98Zg2QttTD3x8
A9w8VEyMLOXcDTrPFpHegMKswFBg5iuMulAdXAoGejWTI3n+qKFpabHm2Lfs6wjk
5rjucpTdeFK6UeWF1xAvNxXibuu5BlGwv53930qIXRwO/Gn2Rh5DXWxKU2fEIme/
xgQQmIsDeUoWbfybdjw/x7Q0LW4mINiLDQcGHHRQKFIxbAJCT3USPLGh5xwE9/Er
ABEBAAGJAR8EGAECAAkFAlYy4RYCGwwACgkQiKUE3BPJzW0uYAf9Hf30n8tM3mR2
Zo6ESE0ivgdgjaJtAWrBUx7JzAzPjBnBOlNnu5Y9lVEqetvUPH6e3PvaHYUuaUU8
0HwxuKBW9nUprgV6uIu1DZmlcp+SxpbuCy7RDpNocRLNWWFMaYYzznmTgfnTgD4D
gCq8Mf1mcfrluTkOAo+QNqbMfl1GISClopRqxVuAo59ewgMnFujwgd8w12BwWl24
CzqOs5HqcUslePj+LzcjSNgVCklYwKl+0dsb/fctMOCtHodwqm2CBJ+zydvNmYkD
fxda/J91Z1xrah5ec++FL0L4vs+jCiIWJeupJFKlr1hCMZiiGH7W554loK5l4jv3
EY347EidAw==
=Ta4p
-----END PGP PUBLIC KEY BLOCK-----
