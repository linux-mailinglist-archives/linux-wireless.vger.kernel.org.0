Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921323FE492
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Sep 2021 23:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244224AbhIAVL5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Sep 2021 17:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbhIAVL5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Sep 2021 17:11:57 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F100BC061575
        for <linux-wireless@vger.kernel.org>; Wed,  1 Sep 2021 14:10:59 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c10so1008775qko.11
        for <linux-wireless@vger.kernel.org>; Wed, 01 Sep 2021 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Er+bUfyfPvArhYuBPd9KcOdL9ky31FKA1apq9cDnwfk=;
        b=jc108vPKn+qoC2+EtUZK7f8iWMtJBLiSI/k3pDpscWBvuMzAYdCnqmZ0tXum3oWpGa
         GghPMV+NZld70nm9K8c3N/sytLAQDNSWHYZEt/gz0x+kXWmE+z8yq3a+I31qlZeTa6ad
         Q8C11zOwXse34JREiZdLUgjbLseCYofrlEPlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Er+bUfyfPvArhYuBPd9KcOdL9ky31FKA1apq9cDnwfk=;
        b=cJiRKY1K05cuu5kp3inZ8gBNmudNGhBG6LJi+5aTVgZzBnls454sCI3S+W4IrGvsQs
         Lvi0FHC80QxpwNkbwVVy1v6UaOv6sov4oXCMz7TaGVV+Er6ONy5j+Fh2G2U2ZBvXsHLd
         obeBffewO9AC+rrWjqp9BTqsmE/aVOe6CxI32gbmv5rNvEZ3zY2Fpg/4RvycqS3EVVbq
         NEArN0CZZha1mqonwGihvYvxJxL1LfI9qqgs3YCvcCDIHdIdSANnBcubJ4LovVOIFyM5
         Vz6rCChnJXo6ZHK3JYHBbyZ8z8GGyfLb+mOcZiQNFSlaYA+K6rQqI53Z3j+8FO+HFgw6
         PFnw==
X-Gm-Message-State: AOAM5335GIsHfLQZZiMCVE0kqgBVCuEHcPbOEbaddZz2VcdTerVTksAB
        9olTn8geqQ/bVtwV1dc2a7x6Y8b7qsZTww==
X-Google-Smtp-Source: ABdhPJwZkuqW1hNEqcpQDozsEjiLSV0CqI+69YR4ORrbXNPTXgsFpR/IUP6SNEWAduxK1E3jV8+Vug==
X-Received: by 2002:a05:620a:214f:: with SMTP id m15mr1612773qkm.59.1630530658861;
        Wed, 01 Sep 2021 14:10:58 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id e15sm657511qtp.33.2021.09.01.14.10.58
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 14:10:58 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id e133so1444647ybh.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Sep 2021 14:10:58 -0700 (PDT)
X-Received: by 2002:a4a:a2c5:: with SMTP id r5mr1141610ool.66.1630530255934;
 Wed, 01 Sep 2021 14:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210830123704.221494-1-verdre@v0yd.nl> <20210830123704.221494-2-verdre@v0yd.nl>
 <CA+ASDXPKZ0i5Bi11Q=qqppY8OCgw=7m0dnPn0s+y+GAvvQodog@mail.gmail.com> <CAHp75VdR4VC+Ojy9NjAtewAaPAgowq-3rffrr3uAdOeiN8gN-A@mail.gmail.com>
In-Reply-To: <CAHp75VdR4VC+Ojy9NjAtewAaPAgowq-3rffrr3uAdOeiN8gN-A@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 1 Sep 2021 14:04:04 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNGR2=sQ+w1LkMiY_UCfaYgQ5tcu2pbBn46R2asv83sSQ@mail.gmail.com>
Message-ID: <CA+ASDXNGR2=sQ+w1LkMiY_UCfaYgQ5tcu2pbBn46R2asv83sSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mwifiex: Use non-posted PCI register writes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 1, 2021 at 1:41 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Sep 1, 2021 at 11:25 PM Brian Norris <briannorris@chromium.org> w=
rote:
> > On Mon, Aug 30, 2021 at 5:37 AM Jonas Dre=C3=9Fler <verdre@v0yd.nl> wro=
te:
>
> ...
>
> > This might be good for many cases, but please read this commit:
> >
> > https://git.kernel.org/linus/062e008a6e83e7c4da7df0a9c6aefdbc849e2bb3
> > mwifiex: pcie: use posted write to wake up firmware
> >
> > It's very much intentional that this is a posted write in some cases.
> >
> > Without ensuring this doesn't regress, NAK from me.
>
> Can you ensure that from Chrome / Google perspective, please?

I mean, the context link should be pretty obvious. But sure: with this patc=
h:

(a) all my least-favorite audio issues to debug return (audio is
especially latency-sensitive on the Rockchip RK3399 systems I have)
(b) latency spikes to ~6ms:
# trace-cmd record -p function_graph -O funcgraph-abstime -l
mwifiex_pm_wakeup_card
# trace-cmd report
   kworker/u13:0-199   [003]   348.987306: funcgraph_entry:      #
6219.500 us |  mwifiex_pm_wakeup_card();
   kworker/u13:0-199   [003]   349.316312: funcgraph_entry:      #
6267.625 us |  mwifiex_pm_wakeup_card();
   kworker/u13:3-4057  [001]   352.238530: funcgraph_entry:      #
6184.250 us |  mwifiex_pm_wakeup_card();
   kworker/u13:0-199   [002]   356.626366: funcgraph_entry:      #
6553.166 us |  mwifiex_pm_wakeup_card();
   kworker/u13:3-4057  [002]   356.709389: funcgraph_entry:      #
6212.500 us |  mwifiex_pm_wakeup_card();
   kworker/u13:3-4057  [002]   356.847215: funcgraph_entry:      #
6230.292 us |  mwifiex_pm_wakeup_card();
   kworker/u13:3-4057  [000]   356.897576: funcgraph_entry:      #
6451.667 us |  mwifiex_pm_wakeup_card();
   kworker/u13:0-199   [004]   357.175025: funcgraph_entry:      #
6204.042 us |  mwifiex_pm_wakeup_card();

whereas it used to look more like:

   kworker/u13:1-173   [005]   212.230542: funcgraph_entry:
7.000 us   |  mwifiex_pm_wakeup_card();
   kworker/u13:3-1768  [005]   213.886063: funcgraph_entry:
9.334 us   |  mwifiex_pm_wakeup_card();
   kworker/u13:3-1768  [002]   214.473273: funcgraph_entry:      +
11.375 us  |  mwifiex_pm_wakeup_card();
   kworker/u13:3-1768  [005]   214.530705: funcgraph_entry:
5.542 us   |  mwifiex_pm_wakeup_card();
   kworker/u13:1-173   [002]   215.050168: funcgraph_entry:      +
13.125 us  |  mwifiex_pm_wakeup_card();
   kworker/u13:1-173   [002]   215.106492: funcgraph_entry:      +
11.959 us  |  mwifiex_pm_wakeup_card();
   kworker/u13:3-1768  [005]   215.484807: funcgraph_entry:
8.459 us   |  mwifiex_pm_wakeup_card();
   kworker/u13:1-173   [003]   215.515238: funcgraph_entry:      +
15.166 us  |  mwifiex_pm_wakeup_card();
   kworker/u13:3-1768  [001]   217.175691: funcgraph_entry:      +
11.083 us  |  mwifiex_pm_wakeup_card();

I think it would be enough to only modify mwifiex_pm_wakeup_card() to
retain the posted version, but I'm not sure how that fits in with the
rest of the author's work. I suppose I can give a later version a run
if needed.

Brian
