Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173B948DE00
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 20:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbiAMTEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 14:04:08 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:52757 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiAMTEI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 14:04:08 -0500
Received: by mail-io1-f70.google.com with SMTP id 134-20020a6b018c000000b00605ac698b5eso3733683iob.19
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 11:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YnXlPLzLOeSu5XTDUNqCJDVyX7wesve914JTiyKl2c4=;
        b=Q+nIfKtLwZrvs6wg3U7MsPnI4T4CwaDKg/NzgRCPtkUbxF8e8H3KLIwmDU9bS5CIbH
         qTdJVKewTQiKV4aWq8CbHhPQAPcenHve4X/pHul1O5X3QkvcddYLTbY1508d6baXTzTn
         HDfg2Pz9/xlb1C21scPvlrd0aU4C1rmnKKwEJY1iRg5W3a/H6qk+qTkghK4lM6ypcYuk
         3TMbduMZli0xVaTW6AsTBJokWulhehw9cRnO8TS4cbZpEaIZgwzNSk2Tc211mGOr7ElX
         0xyt4hU6DudCycP5M9XM2oQVcEBMy4SUh8keBvAgjFVE9J+c2PM2smZzkFQ90BbLNBch
         qs8g==
X-Gm-Message-State: AOAM530vX30nSgpSgJjYvNOpTjpCUyGmquuJPqJmkoP+iGJG4NSGvKZz
        lmZ90EXrNJVDYcEwUDYB+lUfsC42A8a4dV163ciIbYlD0Ytb
X-Google-Smtp-Source: ABdhPJwzwAgBJut9x8nUk1XqzpsbqJ8B/iN04mKahNLszI9mA7kZUC437wbqHYrvmU0vdte769zywTMaAUDIiNFjNKyGoNX0UYW1
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d08:: with SMTP id c8mr2857216iow.199.1642100647552;
 Thu, 13 Jan 2022 11:04:07 -0800 (PST)
Date:   Thu, 13 Jan 2022 11:04:07 -0800
In-Reply-To: <00000000000086205205b0fff8b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c86f9d05d57b594d@google.com>
Subject: Re: [syzbot] general protection fault in ieee80211_chanctx_num_assigned
From:   syzbot <syzbot+00ce7332120071df39b1@syzkaller.appspotmail.com>
To:     arunkumar@space-mep.com, davem@davemloft.net,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        phind.uet@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 563fbefed46ae4c1f70cffb8eb54c02df480b2c2
Author: Nguyen Dinh Phi <phind.uet@gmail.com>
Date:   Wed Oct 27 17:37:22 2021 +0000

    cfg80211: call cfg80211_stop_ap when switch from P2P_GO type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16afe84bb00000
start commit:   7f75285ca572 Merge tag 'for-5.12/dm-fixes-3' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5591c832f889fd9
dashboard link: https://syzkaller.appspot.com/bug?extid=00ce7332120071df39b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1393cbf9d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1238ba29d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: cfg80211: call cfg80211_stop_ap when switch from P2P_GO type

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
