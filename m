Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676DA1AABA2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 17:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393423AbgDOPQp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 11:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389664AbgDOPQm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 11:16:42 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34221C061A0C
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2020 08:16:42 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id m67so17513970qke.12
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2020 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qQPAGL2IMZ0eMjrwtJCIRCLqfeX6RhiXaeITvmueB4=;
        b=PQEZoTsslxtO2VG1gZ9IEXJ+x1EGsPSa5w+d4wjTJVgOduX5sEJ6HZoJfJRBbXRsU9
         EXHzIHgdRzFaKGGE+fT3peXwkYEIAHFi3cdXG68+ylSdKhZL8gWe9zBXPqhUeWc2cNdF
         gsEt61yr3z2YAwQghdQbDx6ZcQjhSEnozaayKcy7LJF75jqkrlpPlsnvR009mnmOtVmq
         rjYjjR2c7Z1XHNg9dZbS7hATI88O0Qk6m97LJX9sd2Ky24Y2RfKkcTujsfHYrgtSzudc
         op08cFDcPhGoabbs8CyIn+yDkK6oWBZ58w+VvEJ/gPs6yUnaHhv7LTvRu4+UHccln//R
         Fm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qQPAGL2IMZ0eMjrwtJCIRCLqfeX6RhiXaeITvmueB4=;
        b=QYhxanjP4mgcYye6VnmeZugpy5h97OdJcpJb/ILaevIgcad5GYXF+M6V5+FydjTiGZ
         neaK1br2Q3h1fsrQ7iSvW8sG99ZEEAP+kCz5plPXj9WtQyk3TVVc17xHJbwIV1SQAhCS
         v2kcz88D/QVhUhwcyi1A+30ixXCP2+l/w4CqvbKm2lwMSkq3z55If/yn7ENZ3mmh+k5D
         GqHJdTMQIKKhI5O30H7uVP2vB0FmkerfZZOc0RA/J5zbN4jqrBrQk1liufvyO0BaVFNo
         HhfFgdDc7jxv6R5oWo4L8wurPBkfz1URxNQKjV0bcPN3Z8AVWD6FaM8LUzvsHpULwQID
         7B2A==
X-Gm-Message-State: AGi0PuYJ0hBTRZCtW2Dz6HtG101CGOraxmt+Bz+4K1gprEWNaRc8Rnj3
        0Q+wX6jY5tkbiBD8EKKQAddeHTxG3I/c+1pxy3H36A==
X-Google-Smtp-Source: APiQypJF3rrWtTJifwbFr2yPhwI9Guj+09QRJ+ZSsnlVpgr82MOSMQpPk7+ZCYHIQZ3xMrt25PXwdxnh13N+LBZi64Q=
X-Received: by 2002:a37:8d86:: with SMTP id p128mr27408591qkd.250.1586963800654;
 Wed, 15 Apr 2020 08:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cb517b05a32c917b@google.com> <ed2b00dfda5b6ce46a2c2a33093ee56f77af6a8f.camel@sipsolutions.net>
In-Reply-To: <ed2b00dfda5b6ce46a2c2a33093ee56f77af6a8f.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Apr 2020 17:16:28 +0200
Message-ID: <CACT4Y+YtT4_An1wtzNWe3_=kMAF3Yhj+pr=GM5ZYOJ9TN3ryXA@mail.gmail.com>
Subject: Re: WARNING in hwsim_new_radio_nl
To:     Johannes Berg <johannes@sipsolutions.net>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     syzbot <syzbot+a4aee3f42d7584d76761@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org, mathew.j.martineau@linux.intel.com,
        matthieu.baerts@tessares.net, netdev <netdev@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 14, 2020 at 12:41 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> Hi syzbot keepers,
>
> On Mon, 2020-04-13 at 07:05 -0700, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit 01cacb00b35cb62b139f07d5f84bcf0eeda8eff6
> > Author: Paolo Abeni <pabeni@redhat.com>
> > Date:   Fri Mar 27 21:48:51 2020 +0000
> >
> >     mptcp: add netlink-based PM
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10225bb3e00000
>
> This is, fairly obviously, incorrect. Same with the bisection for
> 6693adf1698864d21734, which is really the same underlying problem as
> this one (though at a different code site).
>
> However, it stands out that this was bisected to a commit that adds a
> new generic netlink family in both cases.
>
> This makes sense - the reproducer identifies the family by *number*, but
> that number isn't stable, generic netlink families should be identified
> by *name*.
>
> Perhaps somehow syzbot could be taught that, so that the bisection is
> stable across kernels with different generic netlink families
> registered?
>
> Alternatively, we _could_ add some kind of stable ID mode, but I'm not
> sure we really want to ... since that would mean people start hardcoding
> IDs?

+syzkaller mailing list

Hi Johannes,

syzkaller has a pseudo-syscall to map string genetlink family ID to
int ID. If that syscall would have been used, then I assume it should
have worked. However in this case, it managed to trigger the bug with
a plain opaque blob with no knowledge about the blob contents
whatsoever. I don't see any realistic way to preserve family ID in
this case.
