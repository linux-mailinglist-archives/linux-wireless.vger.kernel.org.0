Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48DD32E677
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Mar 2021 11:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCEKb3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Mar 2021 05:31:29 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:44195 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhCEKbF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Mar 2021 05:31:05 -0500
Received: by mail-io1-f70.google.com with SMTP id e11so1527527ioh.11
        for <linux-wireless@vger.kernel.org>; Fri, 05 Mar 2021 02:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oqzdkBv+UMzfuq0wtY2lfwFYesZb5iOxkKEg/xMPFnU=;
        b=ZXKBcOzaFL2Eejhr11V9lVyk2r+rJpMekTj7s6BPllXpy7vZxrEld13dAEC3DEm3wT
         fRWqmcHwvD3QhCcuKGzCHKrwXjH+NWxnuLav99WgezSXiph1avd5CbsvI0vmJUEscgnV
         iUK1vCtzPUFTnYZKjUx7kQvdoWr2TLGTlVZHte5XWgwT+khrLMiDmfzbQugsTGHvB2rm
         V4XeetdCFGNd9npEPrq6fqeawa2k+anHNSeEMtfgTZZcU1Uwlc5YocJ8auH5cJHGpXhK
         c6uZso/pu2yG+xS/7tbhXD5dYWDnW6zReFXwD6TXSBAIa3YwApkhrhFm7KD1iREnnPhz
         eN1w==
X-Gm-Message-State: AOAM533yKZvtJ+Tvr+kmyO71z1CMqw20oLyV2VL4XGA/XlRcjh3rmcsV
        OzhNiYvrvEV6Hss7bqWiRL1n6oOwl0nTcEhqmNeIXy0IL9uz
X-Google-Smtp-Source: ABdhPJy6kuvoqkE/AXYi6HdCtIbTSV2pqYeuGii4fFbf5Z+IKzuz2v+Q19CjPtHC1JjMEqCpSvFn4tiHu70E55tqnwO76f5lfrfu
MIME-Version: 1.0
X-Received: by 2002:a6b:7112:: with SMTP id q18mr7102109iog.174.1614940264923;
 Fri, 05 Mar 2021 02:31:04 -0800 (PST)
Date:   Fri, 05 Mar 2021 02:31:04 -0800
In-Reply-To: <0000000000001be3ac05ba42cef9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3088f05bcc7943d@google.com>
Subject: Re: INFO: task hung in rsvp_delete_filter_work
From:   syzbot <syzbot+a2ec7a7fb2331091aecf@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, johannes@sipsolutions.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vladbu@nvidia.com,
        xiyou.wangcong@gmail.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 396d7f23adf9e8c436dd81a69488b5b6a865acf8
Author: Vlad Buslov <vladbu@nvidia.com>
Date:   Tue Feb 16 16:22:00 2021 +0000

    net: sched: fix police ext initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13dc3caed00000
start commit:   14e8e0f6 tcp: shrink inet_connection_sock icsk_mtup enable..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac6e76902c1abb76
dashboard link: https://syzkaller.appspot.com/bug?extid=a2ec7a7fb2331091aecf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114d33d8d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12610ac4d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: sched: fix police ext initialization

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
