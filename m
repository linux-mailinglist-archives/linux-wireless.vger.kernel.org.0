Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3A51D0EA3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 12:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbgEMKBh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 06:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388616AbgEMKBf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 06:01:35 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34F2C061A0C
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 03:01:35 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id o24so20932333oic.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 03:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vJ49GMeg/zDy5AF7hreNl5IJZLMS6IphvQDeugaJcpU=;
        b=FtM0sq7GcnkJ+n2ZRTMjcu+z01G0INQ/aX0UG0Msp25njgZ9cWOVLRe7uetnvcq/yp
         Z9V0Wq6fYb2djq9PgXjdw4MclFooynQcRNC7bdR0dqJe+qxvV/r1Pd7KvgouNLiV6KjH
         znfimn/YaJWzoDFFX6Btw3SAiMWGxCVMB0OIUArzX4g+AW9RDiij5XyXWHR/RcVEyfgB
         bMMgC8BZuTKVuwlltsuBoMWh0k1EX1RgFJT0++FrfJwQWfkisxfmvu/KIGafsVfvI04K
         zXIyWfy1RXvfz2l70bXCcp9mfiwottAR1AX5OOd29eDm1xTqOmitWNV9iEMaW/y9CNgJ
         S0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vJ49GMeg/zDy5AF7hreNl5IJZLMS6IphvQDeugaJcpU=;
        b=Ca1akxYy1cWKlCMSsT9qABpE71OkLZbNkuLaAj8BA4FNQF1rqlWaiwI6I/77eZOY3i
         W5cQjE/zjsGoB/o6fZb0bW0IDOTlRipPMzH2QR+A9R9tkawYsmMqntZ0Ry++yj+5C4HZ
         uHCEazopPidurLmUXfeWKIhBrVYUmtZLXNj1SbY7gIywKw3Fu8MS8pwov8036mgUwi49
         vFwtd4uiCK/8e+7oWwATaJclMxymyx36cyCDUP5Rqzfs0IHJ99MKRxESuRw93k1UGhp0
         FrN3ZDrXAVFCcMSzFRrkMyUPXIxQDXKrtS1e8zyvZgR7kH689WSfv9ktGtwcEdULKih7
         I9Kg==
X-Gm-Message-State: AGi0PuZ9yb95zMLo17wZlp6ssq5ATmqsAc5a7E2EowTrYVYxkF+B9rPN
        CafttxBCarzA9bePKROUqCZkg0VVPkTfEQ0vHLw=
X-Google-Smtp-Source: APiQypKnmSqZjATsxirOqZfJW4r0ZFcVz6iLTswisAoNrBwPNNELhWnb7+YUyOAxh8hpNKGx1ZjOtvDOZIpKxgKUrQ0=
X-Received: by 2002:aca:5e0b:: with SMTP id s11mr25193343oib.160.1589364095000;
 Wed, 13 May 2020 03:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200508140802.558267-1-luca@coelho.fi> <iwlwifi.20200508170402.c3e50c36c628.I991bfa662c0ef35de5be9eaf5b78ef190b67cb56@changeid>
 <CALYz8ypzgHqn+WY8KG-isYXJfymy4Jh7CSEXsg5KdiGEm+EAVQ@mail.gmail.com>
 <600179d2c1679b933e5129a3aac6c1f788a1c24f.camel@coelho.fi>
 <CALYz8yozMjWmMVy9O277162n58MyD=NTLXAb0dVkLxR4-cnRew@mail.gmail.com> <e86656c0892ead97c21ab0b4c77070bfa56336a8.camel@coelho.fi>
In-Reply-To: <e86656c0892ead97c21ab0b4c77070bfa56336a8.camel@coelho.fi>
From:   =?UTF-8?B?0JrQuNGA0LjQu9C7INCb0YPQutC+0L3QuNC9?= 
        <klukonin@gmail.com>
Date:   Wed, 13 May 2020 15:01:08 +0500
Message-ID: <CALYz8yrv62PAYHdsn00Cs3z3KdaNzuD6HGqr9+vt5K_cV6vDRw@mail.gmail.com>
Subject: Re: [PATCH 01/11] iwlwifi: set NO_HE if the regulatory domain forbids it
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Also. If I use two different wi-fi cards from two different vendors
(Intel & Qualcomm).
Does it mean that Intel ax200 wi-fi card will override Qualcomm HE restrict=
ions?
Looks like It's not a good idea to modify system settings because of
Intel's restrictions.
Other vendors can allow HE operations instead of Intel.

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
