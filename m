Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AA024BAFA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 14:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgHTMVI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 08:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730208AbgHTJz2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 05:55:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C7DC061383
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 02:55:27 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id f19so769639qtp.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 02:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byj5e1NcGEKCZCoUKeCb/RN9/39259nsooaPeWr05l4=;
        b=mIYWqROvWD/RKdlCt/1BmnvTJH0idhKXzinoONCuobC26Ag8t2QIs/tRAQMvpAJ08U
         BzQnr6Nj3HJWweGGabib/1Ebtv6b9iTSVp37ZQ0WUFyGT/1Mwf9LHvU5nK4YjsOecvx0
         qeq35+syF+iWCEZEKoRYj8cJkQFXUe4PUx4IfwcRXiDj3YC7NyPY3pzIqRseHc7REiIh
         N/sY49jbKljaksEPUT/z8xb0zCJuW6D4i/ZcCidJbK5nRKJOJOPGEWLPa7qSCfoJtzPD
         ifR+I7dLcXN7mec2hk//+ojQ1if4Az7i7YBKVrbsiRurX/txFql1hnICOgzD9ep0YRYN
         Frng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byj5e1NcGEKCZCoUKeCb/RN9/39259nsooaPeWr05l4=;
        b=ndg+b6XT5BHmV1SkMVXpk++2zIbbT8XGP2kjLFUtvVOmaz6LcnvtsBG8LL3k+kVgQP
         RWTYOTDGJHR2ZwTW3emrU93U56uf6YMNC1L32GFm/dy2qM1p2XUIJdzxO4NtUW+d13hn
         xkJ/24I44l9+bOqeb8OzGEhpWD983TLIJvcc+C3nf+EjZQ8JsLAJijpS/eAc7QdtFOfl
         dEIi/oNwrJzX++RqoJOwShvoTW0xOHWY/5d0MlhXxTSOZtj+tdNFPap2IO01rQPXUTCT
         OJbpp1eHW6WXO9ZehAVq/ps+7+UuES/onOAUlYtNinbHdrJatbx+Dut5OZcUS47rgv+7
         w2+w==
X-Gm-Message-State: AOAM533qpB6Bg0TDIIX2EwITFFJpjwl3GFgVe6jyhRXJPbZMEP36wAsY
        3cI/ysbZrZw5Rqp/DtE5hesdkyu5Jp3CG/afyVt96tnTLcFfgw==
X-Google-Smtp-Source: ABdhPJxN/Qcu0Avu7t5f0IsPNNgIlJfLFijf+/xkCrEm8gQAOrgnBi2Xab4nv3xb6LKbZ1GtGC+38K0MG7TuYx2ZwF0=
X-Received: by 2002:ac8:480c:: with SMTP id g12mr1838251qtq.257.1597917326809;
 Thu, 20 Aug 2020 02:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a7e38a05a997edb2@google.com> <0000000000005c13f505ad3f5c42@google.com>
 <CAHmME9rd+54EOO-b=wmVxtzbvckET2WSMm-3q8LJmfp38A9ceg@mail.gmail.com>
In-Reply-To: <CAHmME9rd+54EOO-b=wmVxtzbvckET2WSMm-3q8LJmfp38A9ceg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 20 Aug 2020 11:55:15 +0200
Message-ID: <CACT4Y+b7eZNuCOBhwxpzXoEXqOAk9ZGBJBakr6nqYrnd54URpQ@mail.gmail.com>
Subject: Re: WARNING in __cfg80211_connect_result
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     syzbot <syzbot+cc4c0f394e2611edba66@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 20, 2020 at 11:48 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Aug 19, 2020 at 8:42 PM syzbot
> <syzbot+cc4c0f394e2611edba66@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this issue to:
> >
> > commit e7096c131e5161fa3b8e52a650d7719d2857adfd
> > Author: Jason A. Donenfeld <Jason@zx2c4.com>
> > Date:   Sun Dec 8 23:27:34 2019 +0000
> >
> >     net: WireGuard secure network tunnel
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175ad8b1900000
> > start commit:   e3ec1e8c net: eliminate meaningless memcpy to data in pskb..
> > git tree:       net-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=14dad8b1900000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10dad8b1900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3d400a47d1416652
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cc4c0f394e2611edba66
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d9de91900000
> >
> > Reported-by: syzbot+cc4c0f394e2611edba66@syzkaller.appspotmail.com
> > Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
>
> Having trouble linking this back to wireguard... Those oopses don't
> have anything to do with it either. Bisection error?

I don't see anything obviously wrong in the bisection log:
bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175ad8b1900000

On the other hand, it looks super precise. It tracked "WARNING in
__cfg80211_connect_result" all the way down to the wireguard commit
with no flakes or anything.
