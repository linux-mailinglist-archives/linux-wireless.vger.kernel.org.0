Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D3F4799C3
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Dec 2021 09:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhLRIqH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Dec 2021 03:46:07 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:38666 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhLRIqH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Dec 2021 03:46:07 -0500
Received: by mail-io1-f72.google.com with SMTP id l124-20020a6b3e82000000b005ed165a1506so3062222ioa.5
        for <linux-wireless@vger.kernel.org>; Sat, 18 Dec 2021 00:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=XVqEkA8WZDlDVVYlT+qQd4IsUmoT02f/Z2qlP0bG9gs=;
        b=j3YqjsikA+eRldcsuqzyL+xg4ky7z7JV3QXxuzOjGprM/JP9lvXMxYKfEvjdL8JuZQ
         sFQqxpaXoGAQlAwCGKg9inIcytDBRQbo2hvhO+oxbOu/xfRQzwIxiYC8Zbz/JXJiikD6
         A8s+IEIukvec0U397UolfDuxunlXHO7Ajp9yXsPo1WNdRGtDhbdjWdJOK3b49qpBcce8
         bS92PM1TbudYelpdfJo4hMRWoHXZiE3h/gjyuFQVz/z8wjKFJ8wfIRHWGyqUIXU8huic
         oZN3Gxy9+3ZR4h6KhLTvUX6oaMygvox0K+O5+NtwMMc29sZwqJSouV/X7d/2WXbZD0eC
         NPmQ==
X-Gm-Message-State: AOAM5321pVJrQwPyjK6ILT1VcT0Zv/p+EjlwIkZsv4syAsH53tvTCakn
        7AjbahGJtrZbBRjPJnwdxHXqiO+K0bLQvZ0TOyCXeoI6XeMf
X-Google-Smtp-Source: ABdhPJyuro0eRzCQRI0a07S5Fkm0NFBfzp5SGa8KoLpOL6oXDEfke4RSYwNg/MHcMlwLlcVDHcciurr9HDKnp4Wrp26MUekUa6GR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1541:: with SMTP id j1mr3595398ilu.100.1639817166880;
 Sat, 18 Dec 2021 00:46:06 -0800 (PST)
Date:   Sat, 18 Dec 2021 00:46:06 -0800
In-Reply-To: <0000000000000a337b05bb76ff8b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba831905d367af3e@google.com>
Subject: Re: [syzbot] INFO: task hung in disconnect_work
From:   syzbot <syzbot+060f9ce2b428f88a288f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes.berg@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, phind.uet@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 563fbefed46ae4c1f70cffb8eb54c02df480b2c2
Author: Nguyen Dinh Phi <phind.uet@gmail.com>
Date:   Wed Oct 27 17:37:22 2021 +0000

    cfg80211: call cfg80211_stop_ap when switch from P2P_GO type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ad179db00000
start commit:   f40ddce88593 Linux 5.11
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=51ab7ccaffffc30c
dashboard link: https://syzkaller.appspot.com/bug?extid=060f9ce2b428f88a288f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1217953cd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13baa822d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: cfg80211: call cfg80211_stop_ap when switch from P2P_GO type

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
