Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E33CBF94
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jul 2021 01:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbhGPXKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jul 2021 19:10:04 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52920 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbhGPXKD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jul 2021 19:10:03 -0400
Received: by mail-io1-f72.google.com with SMTP id b136-20020a6bb28e0000b0290520c8d13420so7013195iof.19
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jul 2021 16:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qaMOIh2upbMs9hOM1Tz4AOxQSYOvrsMlI718rr6A6Is=;
        b=IQFexnyXUGxjiG8jQNRpTcMJvB2FI2wspSgB4bjE2dKY4LAewQsnSnQdp3uU/cXuAR
         EMC8h+UU8cjZWf2G3BJZXSl8pwDfjWfB0fiLQggQMFojU9EZMPjTnm8jWv6fSfE+53eH
         EUVLOv73G2HbYP866XcfbEpjPgcu09fTW2CE+fBoorrwIrKMVDRdqT8c7XuSAGfXhS1n
         8hh3rlscmT+jD8Aj9RalzflLZQHWcbpMe5iBBsPFAfC3AdpyX6+ViRC9EzFexa+8ahS4
         U6mm8/EG0ZEJaWfqBhtJfCpGrfp+dG2Uagr05k+vksjy4V1bfAY1r7pDwhZyOA+iU/Yn
         pp6g==
X-Gm-Message-State: AOAM533p9LIbJCCcdsezyGbGg7hJuYtdI2Jvf9J7Er1jI2vzN3jE97OP
        RQSdnB4RLMiExa7hDMqTzR75scw6QGRfOF/NWV9xVvCLfr57
X-Google-Smtp-Source: ABdhPJxsZhI0CdLIY+rzWPN0HYQv81ux+PuPu2AjkvxwV5y7JgLfQU6oiuU1IVzcs8ebcrTDjOTOzG9MGTpliCM3OpXNwjB3HeBm
MIME-Version: 1.0
X-Received: by 2002:a92:d943:: with SMTP id l3mr8182316ilq.37.1626476826637;
 Fri, 16 Jul 2021 16:07:06 -0700 (PDT)
Date:   Fri, 16 Jul 2021 16:07:06 -0700
In-Reply-To: <00000000000055e16405b0fc1a90@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cbbcd05c745a560@google.com>
Subject: Re: [syzbot] WARNING in sta_info_alloc
From:   syzbot <syzbot+45d7c243c006f39dc55a@syzkaller.appspotmail.com>
To:     a@unstable.cc, anand.jain@oracle.com,
        b.a.t.m.a.n@lists.open-mesh.org, catalin.marinas@arm.com,
        clm@fb.com, davem@davemloft.net, dsterba@suse.com,
        johannes@sipsolutions.net, josef@toxicpanda.com, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        will.deacon@arm.com, will@kernel.org, zlim.lnx@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 282ab3ff16120ec670fe3330e85f8ebf13092f21
Author: David Sterba <dsterba@suse.com>
Date:   Mon Oct 14 12:38:33 2019 +0000

    btrfs: reduce compressed_bio members' types

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d5f6f2300000
start commit:   7f75285ca572 Merge tag 'for-5.12/dm-fixes-3' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5591c832f889fd9
dashboard link: https://syzkaller.appspot.com/bug?extid=45d7c243c006f39dc55a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164f385ad00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1427af9ad00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: reduce compressed_bio members' types

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
