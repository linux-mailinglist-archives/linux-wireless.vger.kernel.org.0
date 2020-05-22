Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019151DE844
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 15:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgEVNqk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 09:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgEVNqk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 09:46:40 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A2C061A0E
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 06:46:38 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id y13so6062683vsk.8
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kR7qqMGRLRdfRzqK6+0vu/8LZfKbHqHc5WGvZ7+qZ14=;
        b=gioZKgijyezBfiTPIag9dJrvK1gzJxnfWstFDEVoystTRDaMN4EuMTQ+W/QcQnc+zF
         rZN0QricxHYWU1G8i0CEO/xUbM1dIXpAyZydHWYNF1zDUaEPoXAhneYNXm55qkBfTADQ
         00yWfXCbqn81SbEazN2dJ+fODyjXY4BIy0hiLa09KY833vvLpMBscd5uCqlDAV3/tOQr
         slJy9i6cX5zqgvA+XCqVIyEl9fXExl1LqU31OMAlMTdPcUGDyq4ydf6Zrg0vGHAkDtxY
         E0tZCI2LZMr8w36mazMMxBYMo09IQvS9n0ocwTP5sTFSFJjmhYnvSbVNnb/WErqbGR/R
         cE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kR7qqMGRLRdfRzqK6+0vu/8LZfKbHqHc5WGvZ7+qZ14=;
        b=hT7vX6Fmsk2juBv/YOAKvyq6yvVselyPG3+ZeHJFZuw1OiT3Ig/Zg4snu/QsS89o3y
         MRzjvIXoSGd6DlSIaYr5WckQHbgbPeN7xnynV27dyEdVVlj9KKZYHHNenAztcJyEM8z1
         6GulTac5hSOnmuFgfKLwwNs65VESjQo2s+qvFqYFMaMPN6dsSWmB9bLVxHM5bgP7Kepe
         9NeF/QuYePyoxjeP0FjZaNl6tl43eoB1KpXofV0GyhuYK0k7J1jZmVDOgI2o6OrtMnkf
         wtPvIhj9m1SUnHksm4OvWtm8+z/4ikY+juqsDorX/Ljvcw70hxukXOIXF0VOLhvm4xFJ
         FZHw==
X-Gm-Message-State: AOAM533ZCPj4Ffpt7MMy4lJe76Ir0FfIeSnK+yZlrss28cxVnOF7R2SB
        6ZI8jgSTD+9WM2EcEHHfb63aYR5FreFvJHwnyQ==
X-Google-Smtp-Source: ABdhPJwbz3E3I2HcF1B/r20RAYkb7RaUDHXKNLxz3TlKY7BtTmXqiFUumBdudKcACf52Ky650mnEcjQX3HphUXxyX9U=
X-Received: by 2002:a05:6102:22f7:: with SMTP id b23mr10327693vsh.172.1590155197806;
 Fri, 22 May 2020 06:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
 <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net> <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net> <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum> <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum> <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
 <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
 <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net> <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
 <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
 <f6152cd7-1043-dde2-7fc1-634d8b07a231@lwfinger.net> <20200522121910.254aefc1@wiggum>
 <87a720gpfb.fsf@tynnyri.adurom.net>
In-Reply-To: <87a720gpfb.fsf@tynnyri.adurom.net>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 22 May 2020 14:46:26 +0100
Message-ID: <CALjTZvYiFfqN3UMSM89Pg1rB9fJga+L1hVkBriEDeaej7oXcPw@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Kalle,

On Fri, 22 May 2020 at 12:49, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> And did the "bad" performance even have any real visible changes to the
> user? IMHO this "bad" performance is small price to pay from getting
> WPA3 supported out-of-box, especially when the data throughput is
> unaffected.

I agree, I also believe the additional security provided by WPA3 is
more important. The CPU overhead impact exists and is measurable but,
to be honest, I didn't notice any worse performance while browsing the
web, for example (which is already slow enough on a G4 CPU, as you can
imagine).

Thanks,
Rui
