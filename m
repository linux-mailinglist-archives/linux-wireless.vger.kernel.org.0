Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2AD1B452
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 12:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfEMKwK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 06:52:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34723 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfEMKwJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 06:52:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so300943wma.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 03:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=AYtx5hBxa9dcVDHYSg+x/xz/m3EBPuTCozc29imMpkc=;
        b=UjRApXS2Ma7DFSBM2yH/4HdTzAoopwuNJ4zORhHVoCXdWNdOmVM9xl84JRcUoJUjfc
         hWcHBhvQqQKp34+skSyAf1DP2OSQz6Gw07oI0ypILwvaamuqaqs0nyrdfcruYoM1aqX8
         1mHnis/1YRHGrWAke8QCeE/HhB7pSGKBAUfGGt638hV3Z1YXUHlEHNpcJk8Prr1PFuWK
         /nu7R7WAwZDBYyD/cuFKSEVECWmegtIWSpEsXwdJsQwXQlZ0AEvFNdgBXYXDw5Tp/YBu
         plWIzxx0ZOVYrHvgn4YQ5L7VUMI60kTkafIj0JhxZo/+wQCb4pIUvTLc1CF2w06kTHty
         U2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=AYtx5hBxa9dcVDHYSg+x/xz/m3EBPuTCozc29imMpkc=;
        b=kDPrN4DHiIdHDeBvF+1RvAUEArojOGUfkJT9FvReKcUbgosrIjZuKAwVUcqFDPYqTt
         pwcsPl6HbNQvBkU7awoMiNnwb7fuyQPewEpViVWeE0pcMg8GyhxkWNsdvnzmsuB2xNme
         BjBeKwPNjNQ+mdek012zYqg5tS2l+EXcmczQAUJmJILgygIW6QYdxpbvrCkKQjHJ+6hr
         qKE4yR8urdXa/mwVFJfIarwqwcMYFgON9jp8qnARb6af5KWfXXoRne9uQkw9iBq/Fy0V
         DjGWUxzmew0kY+JFfkhhHrUrjbtbPgh+wGnOIctzj0Mc2YgV3lsZHgSbBpwB/1jrmTaA
         VO8g==
X-Gm-Message-State: APjAAAUXX56eTI664KrrKZ3SexBIBlaoJHM+Vq1huIWlhNb9jbMqkvGM
        KXBSfRc0A1WJFabVWxEbeYA2KXOvYLR4sw8rXk2wO5nXobA=
X-Google-Smtp-Source: APXvYqwChQbVqTQlTZgIMY+lJrzW7kWpx6AimfvhfXyEQWPCiGuidbvtNzzIuGMKkgz6n7KQ6TUMaIavMGL+fTKoOwg=
X-Received: by 2002:a1c:9616:: with SMTP id y22mr4499448wmd.73.1557744727424;
 Mon, 13 May 2019 03:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com> <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
 <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com> <CA+icZUWJ0kZSqogg18LdP2YkNXk=_SNnT7-ufkd_Xp1ak7uchg@mail.gmail.com>
 <2b1bd56f-8797-fb90-e2af-218edaedd089@intel.com>
In-Reply-To: <2b1bd56f-8797-fb90-e2af-218edaedd089@intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 12:51:55 +0200
Message-ID: <CA+icZUVMjCWwuC-ee1-+EPU6+mYqFZ7w4ai4t4EJcrsvZ2_BYg@mail.gmail.com>
Subject: Re: [linux-nfc] ThinkPad T470 and NXP PN5xx (PN547 or PN548)
To:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 12:15 PM Oleg Zhurakivskyy
<oleg.zhurakivskyy@intel.com> wrote:
>
>
> Hi Sedat,
>
> On 5/13/19 12:27 PM, Sedat Dilek wrote:
>
> > So, this seems to work.
>
> I spent a bit of time trying to find T470, couldn=E2=80=99t, anyway manag=
ed to get to =E2=80=9DNXP 1001=E2=80=9D and was going to hint you further.
>
> Congratulations, great job!
>
> And thanks a lot for documenting everything and posting it here. Perhaps,=
 eventually it could be upstreamed.
>

Hi Oleg,

Thanks to you and Andy.

As far as I have understood the pn5xx_i2c kernel driver (from NXP or
better to say the ACPI support modified one by jr64 user) is needed as
the NFC device is not auto-detected/configured via I2C and GPIO and
ACPI.

Unsure, why the pn544_i2c NFC driver shipped with the Linux v5.1.1
does not work.
Or what it is missing.

Helpful was the PDF from [1].

Furthermore, I have seen that Debian refused to integrate the NXP
libnfc-nci library due to policy issues (see [2]).

libnfc library shipped with Debian does not work.

- Sedat -

[1] http://www.nxp.com/documents/application_note/AN11697.pdf
[2] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D854606
