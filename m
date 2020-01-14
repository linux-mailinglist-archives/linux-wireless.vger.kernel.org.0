Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A5513AFB6
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 17:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgANQpe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 11:45:34 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:32829 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANQpe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 11:45:34 -0500
Received: by mail-il1-f196.google.com with SMTP id v15so12110301iln.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2020 08:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tMi49Ab7yK7SZHB0uLB/rbg/ERpqK6DFBONweoN4fo=;
        b=pubMzMgvjuwTCAwYEWRNYhKmBGzU+2fVOwO5jJ7fs6pjSK6KwCkGnKYlAowKsuBQjv
         aCqLEuRpWKa6zmQRrC3x3BACYsK+K+YqBCAdBZhJWaRR56ujtCeOLkZ1SmQM97t62/hm
         ba5dAVjNd4jixm2+lpjQHrKwuKVm+dV0W0fZf7GjQ5a9ilbXtI9JuwMkeBKOJ+Sy9eqy
         JFLl5d+oS1vb99DMYeA7GEVXfM9WHSpYsYaYz1l+WCmtGFfiPYdLd8AjVA3il+lUuHqj
         +WnUb5BfV2N2tKpFdZjjlIZneInrJi1zlRJJoCBBHiXf5LW7rWq08dfNujDTjrYQfFZu
         73RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tMi49Ab7yK7SZHB0uLB/rbg/ERpqK6DFBONweoN4fo=;
        b=HEfTd0f+1KPHLfxqjAQmWbcHZgePLGbIDARF9RHnrdFVy8fsZPk0uBVvQelKTFn8SK
         IkEYuUvAX9P4v86nhY4HojcWYUSRa/Radu4ajLMvrb4T3wPmuuo76wYeDMs3+rpFwexF
         l3Moy0bdp2nbIEUHOFPQkXkQcT1uC1gkGaN99077pYNUnR0a5RuyS9AIv2MI845wRg36
         xJ9LTr/LjqiGA7D2eZEeES30imvajy/dHZ0z/PZEqb02KM3A+aQG2Ac7LSap4bxcQtLZ
         5XCSI+64OEXiVqSr4NxVHx2mpRKcqDOmxXzfSSv44mmeVLlHqASyqrOJG5JGJeXQ8fli
         jJUw==
X-Gm-Message-State: APjAAAVFMjH+PIpp3v3gNFNyM77vA2vyfXbLioPHH2JVSJ5pdwv/toj5
        TnxvNpVuu7AaV8mde3zFhNN8rvePRj9inEDIsWc=
X-Google-Smtp-Source: APXvYqxAWCXie9x5/eu42510WwKipzerHkd9PBRCkfZ+p/lBGQNQY6zp0NzB/7WXQZvvSN5kLbbEo5fC12vvlblfc0c=
X-Received: by 2002:a92:7402:: with SMTP id p2mr4059731ilc.64.1579020333286;
 Tue, 14 Jan 2020 08:45:33 -0800 (PST)
MIME-Version: 1.0
References: <d6d2eb63-e2b5-26f1-34b3-d1b1dd511fe8@gmail.com>
 <CAKXUXMyswP6S7aZCcA6n50PPKb1=KXOd=-fctCsEg+vwByD63w@mail.gmail.com>
 <CAKSHSL40okJrsQv9zHhKwxzZ49C0kct1Nr4=zQu-NYGKp-z83w@mail.gmail.com>
 <CAEnQRZD=GH6s5dkuLxT=MojwuM6WZgL4WZN500yzk=qcjV=_wA@mail.gmail.com> <alpine.DEB.2.21.2001141558020.6231@hadrien>
In-Reply-To: <alpine.DEB.2.21.2001141558020.6231@hadrien>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 14 Jan 2020 16:46:40 +0100
Message-ID: <CAKXUXMy9jXV8dKkCLUCy5VtS1xbOgX67G126dCgW9p3RwxjZXA@mail.gmail.com>
Subject: Re: Google Summer of Code 2020 - Project ideas page for the Linux
 Foundation online
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Aveek Basu <basu.aveek@gmail.com>,
        Till Kamppeter <till.kamppeter@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Denis Silakov <silakov@ispras.ru>,
        "Gary O'Neall" <garysourceauditor@gmail.com>,
        Ira McDonald <blueroofmusic@gmail.com>,
        =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <jsmoeller@linuxfoundation.org>,
        Jay Berkenbilt <ejb@ql.org>, Jeff Licquia <jeff@licquia.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Mats Wichmann <mats@wichmann.us>,
        Matt Germonprez <germonprez@gmail.com>,
        Michael Sweet <msweet@apple.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Open Printing <printing-architecture@lists.linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Tobias Hoffmann <smilingthax@googlemail.com>,
        Vadim Mutilin <mutilin@ispras.ru>, dl9pf@gmx.de,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jan 14, 2020 at 4:00 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Tue, 14 Jan 2020, Daniel Baluta wrote:
>
> > Hi Aveek,
> >
> > I think Lucas was referring to Linux kernel community. There are
> > plenty of developers from all companies
> > around the world who might have some ideas.
> >
> > For example we could send an emal to lkml or kernelnewbies mailinglists.
>
> Actually, I think he was referring to this:
>
> https://lore.kernel.org/workflows/
>
> I'm not sure if there is any intersection between the people CCd on this
> message and that list, but I don't know the names of all of the people on
> that list.

Yes, that is the mailing list I was referring to. I was asking if we
should explicitly reach out on that mailing list for ideas on GSoC
student projects. They are discussing topics there that can be nicely
worked on by students without to much need of deep kernel expertise.

I am listening on that mailing list, but I have not seen anyone CC
here being active on the workflows mailing list.

So, what are the thoughts in actively reaching out to that mailing list?

Lukas
