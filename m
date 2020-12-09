Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016FC2D4C2E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 21:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgLIUsq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 15:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgLIUsp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 15:48:45 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AAFC0613CF;
        Wed,  9 Dec 2020 12:48:05 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id j140so1663948vsd.4;
        Wed, 09 Dec 2020 12:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nSBCJhr29Kxl5oTL7FlzpzubY2bDnmJhKViwg1dvOg=;
        b=p5+n8RZuqsRyt0qM5odRYvOo0n1FodAIENoIOfdh8NuAuNA0BxSm24F9lFOmNIpvLb
         ge+FQsdKmGF/24Z8t8Gb+MAM8tblWdYejQNXHc5bYXoIZhve3i2Zpo35114Kq4Cy3PJo
         E3C8qto4QXPy3OSARjL0faprcxbD56MNr5Um2vq+lqu+YlkZk0KRv+1GqJ1rxACiY/mK
         CLhV8uJrA1bGITj2qf6/bNOPUXsG8oocJ2eF7l9TnfBQG7HU6cRvhS2xU/g9+J0j9PXX
         Tl79pb5S4DV9Umielrj0aw+0M9poGagreG5fLi/Hu7w3+7p6Gknaddaoe+1V0ny+Xo3Y
         C7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nSBCJhr29Kxl5oTL7FlzpzubY2bDnmJhKViwg1dvOg=;
        b=erUyyLjnmOD+MPkerg0v59RarB320/cvZYg2pH5zkB+0KRdE6BXDSVvVaXJ/n1xHhA
         Ex9wEGiPwA9kal3hvmLyJCqgTndIYVi1DKcwBRy4je2DypHHmTdQhAGDCZO8r+YclTzO
         d+3EsC+nDqo7CGvQrmNOj2RWDQNr1qhkumNSDtXtDQTgXhIjTgpL6VXdinrUZ+aRo0jW
         76wvvUcEsbnhcVkKCYc4KZ6zkiRKuBlxA2NN4qH31Rb5s4hvlxUMbo68IXCYAleNZ4P6
         VfWhrpKWGAw4ZkSq9DR4SEAr+dplx5+MChbffRgxtTSIxAqjsHF8VlqsufpaJF096qZH
         87TQ==
X-Gm-Message-State: AOAM530omyiq40x22TAevSyNzZa8xcmEe9FTO23H5Kc5EL6AXzpifLTN
        3Yf+vJub7Hf6WLFfhg+cRXOlbse9ccSEeB1hIi8=
X-Google-Smtp-Source: ABdhPJziJaz1nQoeYjAjKSVaeB45UuPfiKm1uNziH2nMgomiy7IkIopvxOpZMUd2GhLzmYyGXepDfffnXONl1ARcQAg=
X-Received: by 2002:a67:ad0f:: with SMTP id t15mr4236987vsl.24.1607546884653;
 Wed, 09 Dec 2020 12:48:04 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
 <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
 <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com>
 <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <CANUX_P1=yuPkK5BzJ99oniMiCgB0z98yNYUSw4_qk2Vg7ucoRQ@mail.gmail.com> <CALjTZvYZEbgfLEzxQdafJT6CFz76prA4+YM2EGA8k5Dgn3gigw@mail.gmail.com>
In-Reply-To: <CALjTZvYZEbgfLEzxQdafJT6CFz76prA4+YM2EGA8k5Dgn3gigw@mail.gmail.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Wed, 9 Dec 2020 22:47:53 +0200
Message-ID: <CANUX_P1YWSudJfwyuFVg-qdBHwQvQJiZayZBMY8E4it0qwB5Hw@mail.gmail.com>
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

On Wed, Dec 9, 2020 at 10:40 PM Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> Hi, Emmanuel,
>
> On Wed, 9 Dec 2020 at 20:32, Emmanuel Grumbach <egrumbach@gmail.com> wrote:
> >
> > Rui, I looked at the register dump and looks like you're using AMT on
> > your system?
> > Can you confirm?
>
> AMT? You mean Intel Active Management? Heavens, no, not that I know
> of! This is a personal laptop (Lenovo B51-80). (And I'd personally
> kill the ME with fire, if I could.)

Yes, I mean that thing. No VPRO sticker on the laptop?
Weird... So apparently I was wrong about the register value.

>
> Thanks,
> Rui
