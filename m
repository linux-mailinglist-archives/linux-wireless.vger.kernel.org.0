Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263267111B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 07:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfGWFZK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 01:25:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34336 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfGWFZJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 01:25:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so30227138wmd.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2019 22:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36XzBiR0lNsl1NT1ZMGeDGBh2Ns0XEDF+y60m/mGTrA=;
        b=c3uMwzuPpcZuRicTmflgMbaqoaCq160BrnYztPE3lXxe0nkwYPSbJY7sdsJlsud4b8
         6l87WeQdQLNkYZQ9JOqZq6od0JxSAz4+jD5jLoOSKg1mAj9NOzgsRGfpJ3GxAymmCTq8
         BB0lGEmIl61IRAVNZfz8gLrK1gEEju/xti14AwIlcLLLyKKVrdHm+MEkDiKYTEXDpQJg
         4JBb81pjCsyol2CxPpLYzcVTm9xmh0BnoPRVPBdn2cQmkYHQBrWBIxQ0iW+g0PB62c2J
         0gxy6kCkLJ6Gja5lWkLJWhV7rcOM8kU69Fjn+JpPWKnqogyeDOyO0lwpBXRFGouNpkeg
         MzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36XzBiR0lNsl1NT1ZMGeDGBh2Ns0XEDF+y60m/mGTrA=;
        b=eVtBCvIt3Y0khu6XzT1/x7UitBh1wv7ESRU+VQw5nLQOx3cbSMG+SbMGFa3nL09vm6
         YUqtdjwuMfUZDlT/f5M1uyxNnVVjbddQvdAMMbgkA9eb68Gndw3QNAMwKzGdj/EjSW8D
         MXqmsa4VT0xb09qlnEHtAWFdrVbWM84o6PYGsRmqZ/9MTSwkGUArH2NOapAL0ulB2njE
         2h/Itj0UE5eiZA2C0IaJRguRYxDURFOc4jNmbDtPVqiUU6CtVw1aVjcedWRddfZfc/fc
         4ePtT+Jbrkm9HZayiMeRGW2CrSS8jMDTXFgdO4jnILhmGI9xRsRo5MQLksN1gHE8H0um
         7zsg==
X-Gm-Message-State: APjAAAVkgA9UEixg7kkVc5mVtNIW6GGhQd02Fuo9lj57vqEFFoi1xu+X
        K7kXnkEh3XvJ3zDj9YEUC88KrAQtqGkGuuIWBEqsNfeR
X-Google-Smtp-Source: APXvYqwELE/Prq69oDDr7VnDZAjtw3sQLTEjUssYbxTp6VGB2vGRfXOh7vmvyYs1ZQd0l7WeqyC+icrKDQKpVleFUlQ=
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr69423863wmg.164.1563859507848;
 Mon, 22 Jul 2019 22:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLXrB0YvdK=MgbbF94QcQwqPV-FvHtm=uOVURuphFx=OfA@mail.gmail.com>
 <eddd4cdb148e0dc64326c1c9f2b257413b6131ae.camel@sipsolutions.net>
In-Reply-To: <eddd4cdb148e0dc64326c1c9f2b257413b6131ae.camel@sipsolutions.net>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 22 Jul 2019 22:24:55 -0700
Message-ID: <CALAqxLXpOrChTKdXT__x_vwZR_BbYZvmvDk5fT8fmfsDhQEqJA@mail.gmail.com>
Subject: Re: TI wlcore wifi not loading w/ v5.3-rc1
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 22, 2019 at 10:11 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Mon, 2019-07-22 at 22:20 +0000, John Stultz wrote:
> > Hey folks,
> >
> > Testing on my HiKey960, I'm seeing:
> > [    8.894909] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
> > [    8.902017] ------------[ cut here ]------------
> > [    8.906832] WARNING: CPU: 0 PID: 5 at net/wireless/core.c:868
> > wiphy_register+0x8b4/0xc08
> [...]
> > It seems like from the commit message, the wlcore driver isn't
> > providing the policy values the network core expects? I'm not sure
> > what the right fix would be, but wanted to raise the issue.
>
> There's a fix on the way, unfortunately I forgot to send the pull
> request before the merge window. I sent it out a couple of days ago and
> narrowly missed -rc1, but it'll be in rc2:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=91046d6364afde646734c7ead1f649d253c386e9
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1667e4f9bcfb6785362a300ac4486df0854a72aa

Ah! Thanks so much! Sorry for the noise!
-john
