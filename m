Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E851DD835
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 22:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgEUUX6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 16:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUUX5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 16:23:57 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F00C061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 13:23:57 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id z3so2033535vka.10
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9e0CD2omGxMjl6kkm0vDCVk+dOjyiQaSx1KziuUsrBc=;
        b=tfdN6Kl346dtu75g+3Lh/fdnMee9cyTgKjs/HPfel2umy+i039EqFXAE0dTJ0T7/MP
         EW6HypyYSp8PiF0iaC4t7wBNa30+5+LpgpgBCxnDF3Qr20ClZ0u5qFgekt5gYmIvqAMm
         eFhSY17zekgw8hIRPD7x/hrlBixNiijnXOpjL50CYm/aPf4NwcDcrwsvl77SRMZybh5G
         nMlJhRazvd2rczsPwLRbxhdc8zgEpoDCNgbQLouvAFVLjNE12SV56iw2cBjU3afuYEOW
         TA1qPa8vJV8SCAUmz7t+ufDklwJsk3WL6yyjt/ZvQh2JaMmbPZGyJkSET2GSbKvSzucl
         LjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9e0CD2omGxMjl6kkm0vDCVk+dOjyiQaSx1KziuUsrBc=;
        b=PmndGwwpoPwtg8TBIxqiG6Q5Yz8Iuptr25ncDpxGS1BxR/OVyvLTCfzOcgHe97KqKN
         CnEBo7CHJCFWa3dGqQmKGzl3yXNGhIWRm+aLG0eguJkYWacoksfCazPxdPn4ogkVpPjZ
         kExAzcgOLKkg1YEuHooj+6qD0UyLSPZSNaHHkbbsY/jWUzYzeiSJy/W9RLz8xpZL7eL1
         c9pgw0SQ7Ofpt53dqo4NTF+r1rjYr678qpno/OqqWF61KqRb05sktUoelDy3tRpE8aOq
         SPpgpD7HUQo+dU1AaysvqiWz2imkvdNTEyImewUavuAMmNy8PS7OE/U9XEOyfrGbq/S8
         0nuw==
X-Gm-Message-State: AOAM532MMP64pwOp/94i5UMA3Ez70ZryRuHl2bIwahGgM8/bwiDb2Nbe
        aVZkC+/Py6yyx5gKYd3ZhClUBAdNrSrb6vw0ng==
X-Google-Smtp-Source: ABdhPJyjKQ47AgbjjmSeskqpRBR4h5zgpPg030Wp3jaDvKx84XAcI4yYaDXO61a63B6eQbuh+kAUokLvfohQfi0f/1c=
X-Received: by 2002:a1f:9fc9:: with SMTP id i192mr9293564vke.97.1590092636129;
 Thu, 21 May 2020 13:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
 <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
 <29f5e3de-a32c-6292-9197-19dcc57fa6a3@lwfinger.net> <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
 <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
 <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net> <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net> <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum> <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum> <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
 <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
 <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net> <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
In-Reply-To: <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 21 May 2020 21:23:44 +0100
Message-ID: <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 21 May 2020 at 20:19, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> Sure, I'll give it a spin. I'm now compiling the kernel for the laptop
> with the other b43 card (BCM4311).

Nope, kmsg is clean. I'm pretty sure the condition is evaluating to
false because we do have the firmware, it's just that the crypto
engine doesn't support the required algo.
Is hardware encryption an all-or-nothing thing in mac80211? Wouldn't
it be possible use the hardware as much as possible and fall back to
software only for the unsupported features? (I guess the answer is
"no, because the firmware gets in the way", but I had to ask.)
