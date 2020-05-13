Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7A61D1EB0
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 21:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390547AbgEMTMb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 15:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390303AbgEMTMa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 15:12:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81A0C061A0C
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 12:12:29 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u6so816194ljl.6
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 12:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqGhLv9Ix95hU31HAKodRrHLXavDA2Vhvx/L+g+IKJw=;
        b=ZgrGjyC9MC0rE/AcMPzxwfmtWZjAAixNQsqagKWbpWzOEOdsqAV23D54rf8e6gkMOR
         FghAS0UdaTNHqTOfEX3g5nRMoO0CpqhkvfBkOFsGBd/k3B5zHXVbuctBilsZUL6n4ho4
         ccTFWeEwFcZ02qwf/K0/8Fib/x6WXeohp9BH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqGhLv9Ix95hU31HAKodRrHLXavDA2Vhvx/L+g+IKJw=;
        b=qJIMVICcVyXrUwXM1sh41n/iGhkKefNReSkwQYahMOvTrWC0QlqCPR1cxvxNu5AbLy
         vUnqzDy5H1REMMgHRKVO1UJL0zhm7AQI8c5iIHOATdzO4BzvkxeWpzBt7MpxpVhshx16
         YMP21XLjpaAUntsImkn73Z3h4twgX4y9QSu9NNgqBV3N2r1YdhxyOKQ3ROSJwrFIQd7Y
         mckx6SQsYbRypezyNWFoHbgGAS5xQrgRy5JOYPlqTJCZ8wTY/DsNOX03v3Ea7OGd3GcU
         KcNoOC2IFB8vbeQwpgaPtQDylIC0kLfoPX3RVskqOodaDkKqXAOPuUumEIQbCoOinEI7
         xdjg==
X-Gm-Message-State: AOAM530wIrORxC8mYd5LdcbhvNEU+U3DKrdPXgrcPivpkyfbRGb2J+nL
        3VAjzHzRVXink+/taVNRmzpISRZUfcc=
X-Google-Smtp-Source: ABdhPJyDvcAKkwsPtz2iiA8fxvrn8kNR+YwsLX12hGjxfY/xM1MUKXTXSQpUa2JOi8xUi0cmGb8G3w==
X-Received: by 2002:a2e:3009:: with SMTP id w9mr350555ljw.71.1589397148068;
        Wed, 13 May 2020 12:12:28 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id q16sm203182ljj.23.2020.05.13.12.12.26
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:12:26 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id r17so451614lff.9
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 12:12:26 -0700 (PDT)
X-Received: by 2002:a19:3804:: with SMTP id f4mr617212lfa.121.1589397145722;
 Wed, 13 May 2020 12:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190906185931.19288-1-navid.emamdoost@gmail.com>
 <CA+ASDXMnp-GTkrT7B5O+dtopJUmGBay=Tn=-nf1LW1MtaVOr+w@mail.gmail.com> <CAEkB2EQf-Q+q9QSwwj=Q208yAJj5hhSDrDiHqyU3WeSod2Bo+Q@mail.gmail.com>
In-Reply-To: <CAEkB2EQf-Q+q9QSwwj=Q208yAJj5hhSDrDiHqyU3WeSod2Bo+Q@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 13 May 2020 12:12:14 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOrsZq6jpu3R_1KQFr2yxd6yhjkxkNb7n6K3GBickoN5A@mail.gmail.com>
Message-ID: <CA+ASDXOrsZq6jpu3R_1KQFr2yxd6yhjkxkNb7n6K3GBickoN5A@mail.gmail.com>
Subject: Re: [PATCH] ath9k: release allocated buffer if timed out
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 12, 2020 at 8:25 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
> I found this via static analysis and as a result, did had the inputs
> to test it with (like the way fuzzing works).

Fuzzing is dynamic analysis, so I'm not sure how that fits.

> It may be beneficial if you could point me to any testing
> infrastructure that you use or are aware of for future cases.

syzbot (a real fuzzer -- I believe it uses fake USB devices [1])
caught the error, apparently:
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?id=ced21a4c726bdc60b1680c050a284b08803bc64c
so you might look at using that too.

Traditionally, "testing your patches" means having hardware that runs
the driver in question when patching said driver. That likely won't
scale for researchers, but then, perhaps it just means you need to be
more clear on how you caught the issue and how you did (or didn't)
test it, so it's easier to reconcile your claims with the testing done
by real users.

If you only did static analysis, then we can be more confident in
reverting. The fuzz-tested revert is an even nicer bonus.

Brian

[1] https://github.com/google/syzkaller/blob/master/docs/syzbot.md#usb-bugs
https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md
