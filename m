Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047E62CF25E
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 17:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgLDQv7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 11:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbgLDQv7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 11:51:59 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED69C061A4F
        for <linux-wireless@vger.kernel.org>; Fri,  4 Dec 2020 08:51:18 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id b8so5756444ila.13
        for <linux-wireless@vger.kernel.org>; Fri, 04 Dec 2020 08:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWacdQiQJUJcaQsWaUdm9yI/RjddeUUPXCcFKJxryfE=;
        b=NF02XSYWP0YXa0gNHj4DXgSOCct6TSmhH5WBm9EFjZ7dYFFBbz3auahRXVdoGOqCvM
         OmHCZmIFgvVYwvuHe5k/yVvalKQpjlJWG7YV6AKeoX3iJPmngwUTT9/ew7cQvm6RRp7f
         RfLkiQWvtCjhLnoUxNe7vHaBDzYyzBzVjog6gAcGzyBU9OCqJwULFdYSHxD/NSaLLDtl
         qHRFyRg0WY46judmz+6E/ohX59mw51KfxnYKK74o/NFLk+WbQFXHaG8gEeSp15KFb6g+
         CKn9vYnr+OomHKSe+2WitudfkU1fg+ir7of7g1R5RdFcQRV2RtmtvQ0ZcKYawyXwGLyN
         MTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWacdQiQJUJcaQsWaUdm9yI/RjddeUUPXCcFKJxryfE=;
        b=Vm3poXXL99Gp3vjiw+uahRY81dqPGy6jo+EKkHUG0baPRzmEyAvHOig1OA5DWhCIUj
         LmYzAdKp/MKh2ZLZULYEOBTc2kFTaLmpyAxd2SIzHdP4KbiJvO4lU9i+rvezUMoaSCdy
         XfqV0h/uyO8Yy74zM0qGFV8OjwlRhqZk8fN7ZlTQvYIRZQTpyBWlRAXbXh3Hy9R7qE5b
         dHGArVg6bTy02ekwXE+AeBUs0xsEFQMRzTHekGDtq2Nj8DLR77QRtHlHkPawqVWD8Lmq
         VzVP3nUbTGA62tPZihhLe5HlWSEiahFMHzEW4SuCW45Fng5CZOvQE74Vuy/DvaS1MN/r
         4qeA==
X-Gm-Message-State: AOAM533h9GWAC5mFXQfxiiTopCE3U1Sz4t4eUeBLvpseSklTjP2xVIKs
        3EUfEbBgl1meKOZ42TBZyfmeUYYlLOTF1sUBX8jvOw==
X-Google-Smtp-Source: ABdhPJwB4KQEbvvCTtYRmtqXlhBgIqIGc35cgNB5S/m5ZQQQ5cMZa8AficDeiFdihVyVTpRZc0ogDqdB/jQYa/jyl18=
X-Received: by 2002:a92:da48:: with SMTP id p8mr7811440ilq.216.1607100677873;
 Fri, 04 Dec 2020 08:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20201204162428.2583119-1-eric.dumazet@gmail.com> <cac552ce70a747f078738a7167f0a75bc52fac7c.camel@sipsolutions.net>
In-Reply-To: <cac552ce70a747f078738a7167f0a75bc52fac7c.camel@sipsolutions.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 4 Dec 2020 17:51:06 +0100
Message-ID: <CANn89iKkKaD+rFfwaoWCMKmYhGd4jE_=nMWyVTaZQ4EXBKRZXQ@mail.gmail.com>
Subject: Re: [PATCH net] mac80211: mesh: fix mesh_pathtbl_init() error path
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzbot <syzkaller@googlegroups.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Dec 4, 2020 at 5:26 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2020-12-04 at 08:24 -0800, Eric Dumazet wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > If tbl_mpp can not be allocated, we call mesh_table_free(tbl_path)
> > while tbl_path rhashtable has not yet been initialized, which causes
> > panics.
>
> Thanks Eric!
>
> I was going to ask how you ran into this ...
>
> > Reported-by: syzbot <syzkaller@googlegroups.com>
>
> Until I saw this - but doesn't syzbot normally want a
> "syzbot+somehashid@..." as the reported-by?

Do not worry about this, I will not release the syzbot publicly, no
need to add more noise to various mailing lists for such a trivial
patch.
(This particular syzbot report included yet a buggy bisection, lets
not get yet another replies from annoyed developers )

This is why we add a Reported-by: syzbot <syzkaller@googlegroups.com>,
only to let the syzbot teams count the number of syzbot bugs fixed.
