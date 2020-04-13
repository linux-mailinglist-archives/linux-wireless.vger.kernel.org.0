Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C651A677D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2020 16:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgDMOFG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Apr 2020 10:05:06 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:35185 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbgDMOFF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Apr 2020 10:05:05 -0400
Received: by mail-il1-f198.google.com with SMTP id t7so10744653ilf.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2020 07:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dSAaCUxfmH3RsO4S6JaqC9sPiFMT1emTj9SauC2DHLk=;
        b=b3QhdXUUIC8++6Fpisx4XHroSfc87Rdj2bYe5DMx8ALLr8p76I6iirmmz1Eeu/xSRz
         mnjrgGTvgFKo3OpAq6tTAPKMlZec5+KncCOGSyXspNuMmj8F3KzK3zLHEZhyQJI50REo
         hLWcZK5CacIC1xuN+/VcWgzBbfmHlTKw0ckpJj3P0dislMxaPQi95nLykUqYvX3kpyET
         d6YXKlAVjatrhfdVDR2ChqqWOHBWooFkTrYeVqXzfd4oHzVKz/GwTU2+ByrRiymEoj+h
         CwF4UvZvjvMtSAPYAz6TsOEZgSFEW87x/aeaNNtPfKnGuBHSOiSUPQ164spk8ih9XDwM
         hAfA==
X-Gm-Message-State: AGi0Pub+uMqlVrHCsFpTxP/K2o4wQu6rf47yypr1SyvytGtMALbjjO8Q
        dmzecw6AA6l9QOD8Xe0B/plIPHZrWQn8qoXMy/HhHeUDuKGr
X-Google-Smtp-Source: APiQypLR1F78iaVNLapYRHoDrHWZAKXWioEFmpkhtSEmyxWdBCDJ9YMPc5xSsHv6bj/OoSxNP8wJr0eMQai+nXX/+ecVqEcBkG0h
MIME-Version: 1.0
X-Received: by 2002:a02:7b05:: with SMTP id q5mr16487082jac.105.1586786703461;
 Mon, 13 Apr 2020 07:05:03 -0700 (PDT)
Date:   Mon, 13 Apr 2020 07:05:03 -0700
In-Reply-To: <000000000000bb471d05a2f246d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb517b05a32c917b@google.com>
Subject: Re: WARNING in hwsim_new_radio_nl
From:   syzbot <syzbot+a4aee3f42d7584d76761@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, mathew.j.martineau@linux.intel.com,
        matthieu.baerts@tessares.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has bisected this bug to:

commit 01cacb00b35cb62b139f07d5f84bcf0eeda8eff6
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Fri Mar 27 21:48:51 2020 +0000

    mptcp: add netlink-based PM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10225bb3e00000
start commit:   4f8a3cc1 Merge tag 'x86-urgent-2020-04-12' of git://git.ke..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12225bb3e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14225bb3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bfbde87e8e65624
dashboard link: https://syzkaller.appspot.com/bug?extid=a4aee3f42d7584d76761
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100825afe00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10df613fe00000

Reported-by: syzbot+a4aee3f42d7584d76761@syzkaller.appspotmail.com
Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
