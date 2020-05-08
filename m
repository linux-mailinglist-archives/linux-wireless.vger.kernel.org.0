Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092051CB9B0
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 23:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgEHVVa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 17:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgEHVVa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 17:21:30 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B12C061A0C
        for <linux-wireless@vger.kernel.org>; Fri,  8 May 2020 14:21:29 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t199so9706445oif.7
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2020 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N9PZkEvg0UqwOeul+LmDtHPrfDAfpoLi3WzZZTZO9Zs=;
        b=QvR5r+EC/s7nKRmrIPJB9+wcnSguqIoCSuWgmQgXOJ01jjpfJHn0a7G1Qhhxv73fbz
         OuXycRAF6lZ2ccv0KmWauNE+3TQVvXL4S3qa39JaRrx2yJ5xSre4cnHfKuW/dNqR+7uA
         lrPQX/SGaqHH8p39Krr6H5cKL6pBla0gud6QfV6mp87kAzBHPPLW3xJgxC4jMpEX/fum
         k/Rmo36VbitRtS5kZDIaKvOSlL/ZbgO/nTTbBsHZHsmq5e/Iv6AVPNUurJE+M10+z/ef
         B/5LpdELvNXruz54C3LExQILVM4upf1vuDXUt5nMhy9Rnz/PiassPCw+yIB+PhF+J5Bl
         p3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N9PZkEvg0UqwOeul+LmDtHPrfDAfpoLi3WzZZTZO9Zs=;
        b=OTvyoiBkpgD18yYWrxCPAh4gIaxR7MkS1Effzf9TlGLI5R53v4ei8CzwCsMZ8rDcjE
         Smih86UPil0RwyTIbG+vGAeUWSrYQ8LQH9yZCOVaUjKwliXrZOcXXunSqyXNQXWc3HLU
         qfzf7VqDkdxnhWh5GyHan5WRfevEDe+Ab082h4NpwaWxkAFeHXfDXqFaAuZKlaPcwoIs
         ofz2n1asaSUskcL8+R7nXVUHl89bB2fDXzRAKBYAs9amY7bxxda0yZDyi682ZrY1tBqR
         a25m/506Z8kK5fNtKOYdUxQifaVzKVNRZf5XY7S8nPZnrlWiekQfd+YSBykJ0kIIk7/x
         hV/A==
X-Gm-Message-State: AGi0PuaZyNSMo0vIz+SMl5Du+XYjPRwYEtPJIzrJfhKvSg7L1MdHyqaI
        gJCFqEleMfk3afsGfSP8eW88LenqVRaf8OiyzoNsXrd1VDY=
X-Google-Smtp-Source: APiQypLRAFs0Ig+sdCFg7zIuocU3BjY7qhmvASooe4AopGqK4UKF+uwSHESUcAsZbRS34q37UvimIwnIhIkRz14Ql8I=
X-Received: by 2002:a54:4f1a:: with SMTP id e26mr11975844oiy.45.1588972888535;
 Fri, 08 May 2020 14:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200508140802.558267-1-luca@coelho.fi> <iwlwifi.20200508170402.c3e50c36c628.I991bfa662c0ef35de5be9eaf5b78ef190b67cb56@changeid>
 <CALYz8ypzgHqn+WY8KG-isYXJfymy4Jh7CSEXsg5KdiGEm+EAVQ@mail.gmail.com>
 <600179d2c1679b933e5129a3aac6c1f788a1c24f.camel@coelho.fi>
 <CALYz8yozMjWmMVy9O277162n58MyD=NTLXAb0dVkLxR4-cnRew@mail.gmail.com> <e86656c0892ead97c21ab0b4c77070bfa56336a8.camel@coelho.fi>
In-Reply-To: <e86656c0892ead97c21ab0b4c77070bfa56336a8.camel@coelho.fi>
From:   =?UTF-8?B?0JrQuNGA0LjQu9C7INCb0YPQutC+0L3QuNC9?= 
        <klukonin@gmail.com>
Date:   Sat, 9 May 2020 02:21:01 +0500
Message-ID: <CALYz8ypyv4q9RRPeSttKSLnjQFpd=Ggj76Ck__Xm7RP_4K0w0A@mail.gmail.com>
Subject: Re: [PATCH 01/11] iwlwifi: set NO_HE if the regulatory domain forbids it
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yes, it's something new. Because currently there is no any country
where 802.11ax is forbidden.
May be this change is not so useful or useless at all.

Best Regards,
Lukonin Kirill

Best Regards,
Lukonin Kirill


=D1=81=D0=B1, 9 =D0=BC=D0=B0=D1=8F 2020 =D0=B3. =D0=B2 02:13, Luca Coelho <=
luca@coelho.fi>:
>
> On Sat, 2020-05-09 at 01:10 +0500, =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB =
=D0=9B=D1=83=D0=BA=D0=BE=D0=BD=D0=B8=D0=BD wrote:
> > Channels ON/OFF logic is OK.
> > But I (and possibly not only me) bought a lot of ax200 cards.
> > And now they all will work in 802.11ac mode without any reason and
> > without any chance to avoid such behavior.
> > That's something new, I think.
>
> The reason is regulatory.  That may be new, but it's just part of
> following regulations.
>
> --
> Cheers,
> Luca.
>
