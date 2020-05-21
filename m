Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4400B1DCC22
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 13:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgEULa4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 07:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbgEULaz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 07:30:55 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9410CC061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 04:30:55 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a11so2428692uah.12
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aehwiST4ehzo26Jl3FBKR3m0MpWLLtTbM7BjtOibyho=;
        b=n5UVYu+aFoDFVnVlEBazmytP/7vZCEoSG+hZtnoM31lTSfVchsILahln31MU56atHh
         6W5T62LhTyFc1dt1wHu+yTKlb7MBKmhyyJFdw6r6bwvy9DuYu2iqlm7XiF5+VVQzfqfd
         49Wc/HWIdqFUKLqy+FxsELobFDbvB5Dfnn3gnSTrZS5hoW4LJVHzDRypYV8lFVCwSu8c
         1EoJm98WwxjXpKdiMlF9eo91kGhtUm0vP1cRpJJDUuOWNGQynZnMkf6IZa4v0TG3TyNl
         ZniGaLeB7Zfq+qbdD1I2VcH0Nsd6QonohhMAPEM8JyPIX4eObfRXt2/BX3feQNwNbkDl
         kn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aehwiST4ehzo26Jl3FBKR3m0MpWLLtTbM7BjtOibyho=;
        b=GW0BbtAlPHb0ehZG79AUactlvSBQ9c4jlqhEf1Vq0gj2n0V9iew/YGV4/FjtKy+oL2
         UcvcXPu9SIuMbBso6HvGVHu5aPa5F3qp60d5/SrIfQ2+YkyuIf1z0p1rv/5qoVX7QEeY
         L8CN7PQRDLD/QwTY7ogRneVFaNJtqZxEO/WK+V1rgWdFKhK1Fs2eA52MdW/MkIku20ki
         7PfRYjWBGqYsFBS0I1c7hTE4VVDuN7ZkRT4wM8CzVZMSxSjrxsolomLAHzl6rMemT0zt
         O2u79w+PAD2L9kAPca9NkwZTJjnYjF8oKJ5fZiuze2HH+/e16FB+NzbEAAIu+z2T+HtH
         L10A==
X-Gm-Message-State: AOAM531PIRxqonMkos/+SwPDgO7j5NfYNzoDrqVROgwtgdKipx8ZPAno
        aIW1QbmEaLj5NrJV8yLGzEatjVvdPFdeLaNrmg==
X-Google-Smtp-Source: ABdhPJwuV5Rz/iSKQJ9lJMqvDJE6j1dXtQM2k2zl+tC/taFs0nU6jxvngG752dnh9v0j+K0zICfl3zVxudON5exuVW8=
X-Received: by 2002:ab0:25:: with SMTP id 34mr3292186uai.63.1590060654791;
 Thu, 21 May 2020 04:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net> <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
 <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
 <29f5e3de-a32c-6292-9197-19dcc57fa6a3@lwfinger.net> <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
 <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
 <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net> <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net> <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com> <20200521124608.4b5c78f2@wiggum>
In-Reply-To: <20200521124608.4b5c78f2@wiggum>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 21 May 2020 12:30:43 +0100
Message-ID: <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Michael,

On Thu, 21 May 2020 at 11:46, Michael B=C3=BCsch <m@bues.ch> wrote:
>
> Great. Thank you for testing.
>
> Should we consider defaulting hwcrypto to off?

IMHO, not without testing. See below. :)

> I wonder what the performance penalty is, if any, on today's CPUs
> that have some HW-crypto embedded. Of course that depends on whether we
> actually use that here.
>
> Could we have some benchmarks (throughput and CPU load wise)?

I'm preparing to do some performance tests as we speak. Nothing too
elaborate, just transferring a file over NFS and having a look at the
CPU usage, with both hardware crypto enabled/disabled (while I
initially thought of doing it over SFTP, the crypto overhead will
surely overwhelm this system). Do you suggest a more scientifically
acceptable test?
Also note that this a PowerPC laptop (iBook G4). This means it's using
the generic C crypto algorithms, there are no SIMD (VMX/AltiVec)
implementations of AES and friends on PowerPC, at least from what I've
seen in the kconfig.

Thanks,
Rui
