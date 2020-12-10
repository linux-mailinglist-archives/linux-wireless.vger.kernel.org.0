Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE702D65BF
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 20:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404093AbgLJS70 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 13:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393298AbgLJS6v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 13:58:51 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414EDC0613CF;
        Thu, 10 Dec 2020 10:58:11 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id z16so3433351vsp.5;
        Thu, 10 Dec 2020 10:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVsf3l9Q/619RhJuwHHIDbvbBlqa351J5BuLCbbBows=;
        b=UWmRpJB2WzP666xt7GNev1C208gdqFpOeVwKeLf4MY4P7U2U0jMWCogpUvU1ATgbOh
         Y+dmGewRCmPrcP4lne+u0e11Z0laig1fl8oCg4O8+FjuEC33lD8SDIhiKwTUyLUtEg3G
         zsCU0890ObXkxTJPqxpS60/HrWa9rsXR5lDQwrzAsInXc3TapDWNEnv/eTWcot8s3C23
         vUOWv2p2jCP3S3UqHBK47KvOASjtpu5inNKu+2lHDQo9l0Hca2nBc6qn7wuKYZPkI+6O
         0z7cy2WDsfjzQM24EJFcvjJFqIjD5Yc5Ri73KX/Rd84B3sDom3Lo31StED1whm/b83tj
         /rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVsf3l9Q/619RhJuwHHIDbvbBlqa351J5BuLCbbBows=;
        b=BpVy9fedYwBgu2z9c8SeksqbcC5uvOj8mWe8zzXSsMLfNPFrTk6TGNrBw5ivcG9BFg
         ewSNl4rptXNnbzQViUxLZetAriENvG/STnsXihDvRF+Cb3zAS4zwKIxJibi5ySZErNUi
         ykxPeJhm6+KayrBOrUfoz7vUyaNtOcfo9Mpos0a3FvMe50JJ8BStVeupMniEf7+4640r
         CCYb98mT+m4eIlSSVqnEb/I/wdCvurGf+pKCRCmm/fLvNburstjfi1SKNqJjj7HkaGxu
         zP4jUIAUyGxdrAWkyicLO90cRP9k3FutfCFOlWh9vlgo2CDjPa74RUuO9PHeDLHsYsWl
         k5Mg==
X-Gm-Message-State: AOAM532zEzVTZKAkRq+yX14vQ9hLsmppLgoZSOKN3yAi6a86Dj1ji73e
        T5KuAjmocYVWUg5zY7D1MrYt1f2Mqd8MSt1w/OU=
X-Google-Smtp-Source: ABdhPJwD5AykQ9B1DeA6aNbrWbZQ+VykZW6wtYNLzMipzJoYIJ8rENCRy5uJEPyWPvrcaaBeV97IiMjh8Pr+WVVTDXo=
X-Received: by 2002:a67:f519:: with SMTP id u25mr10712808vsn.39.1607626689452;
 Thu, 10 Dec 2020 10:58:09 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
 <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
 <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com>
 <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <CANUX_P1=yuPkK5BzJ99oniMiCgB0z98yNYUSw4_qk2Vg7ucoRQ@mail.gmail.com>
 <CALjTZvYZEbgfLEzxQdafJT6CFz76prA4+YM2EGA8k5Dgn3gigw@mail.gmail.com>
 <CANUX_P1YWSudJfwyuFVg-qdBHwQvQJiZayZBMY8E4it0qwB5Hw@mail.gmail.com>
 <CANUX_P0sOAdRjOgg=ogAHmQdTXp5UKyW2XQQRComa4Rv3Y-toQ@mail.gmail.com>
 <CALjTZvYfJVjxRO4Avc3rV+W+HO-vBABxwF=UUETzDeNv_QBbhg@mail.gmail.com> <CALjTZvZybsB3unK8X0WcA7kLF60=36F2senz6fEoJS6VVx6Hwg@mail.gmail.com>
In-Reply-To: <CALjTZvZybsB3unK8X0WcA7kLF60=36F2senz6fEoJS6VVx6Hwg@mail.gmail.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Thu, 10 Dec 2020 20:57:58 +0200
Message-ID: <CANUX_P2YqrpenS0Ey2vgyB98PixP5JAYk96LABGV3jeMvc_MJQ@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> Hi, again,
>
> I haven't tested any patch or bisected, but I have another data point.
> I built and tested Linux 5.8.18, with the same firmware, and it is
> working correctly. I reduced the test case to just rfkilling the
> connection, which showed the register dump immediately (before that I
> was using the airplane toggle on the keyboard, which isn't working
> correctly, it disables and immediately reenables the radio, for some
> unfathomable reason).
> So, now I'm inclined to believe this is some sort of race condition
> between rfkill and pending transactions.

Which also means it's not a regression.
You can add a dump_stack() in the function that dumps the registers to
get a clue.
