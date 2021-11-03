Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE1A443F54
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 10:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhKCJX7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 05:23:59 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:37776 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhKCJXm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 05:23:42 -0400
Received: by mail-io1-f71.google.com with SMTP id w8-20020a0566022c0800b005dc06acea8dso1087820iov.4
        for <linux-wireless@vger.kernel.org>; Wed, 03 Nov 2021 02:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=m0x/vjn1b5f/KQVtbiTugH8iyc+rTEBjqfCujOBc6KU=;
        b=zqdckDmrIZbqJ5R+o9hAFEUndiWeq5gn6LjQip6xExH+SbfL5gRk1DK8JBO7xM1B/9
         Ujejw8FpVJAtM3Za4hzS4lc0uPPqyax6y5CJDLNIxCxtXgI6dE4Yl0bBRrdSwsIrpwb8
         in13dyZeOWRAgaqepObRK/fRHEWF/ADGeUh0he9XK722XoS32HQkWVfAxA0D792cC3Mj
         jqdNOBC2pwPxOJeV5/ce8CwYZikP+ItfQ2E8FHI8vs95O9Re9Jj9AqdE9IrXYJzzR7m2
         28lIwKZJFAsBLmTUox/1PWC/ewsz6dt/Q1JCM8ppBSKsVzTMMhNM7YNjj9YcXDQ2nOnc
         srag==
X-Gm-Message-State: AOAM530btOnIaaskO4kWhZmk86ru+PDCRNKkNXTPldRoBnnn6ZyBX1Y9
        feEtuKTpa7f66Z65SkN8tk1+hwp68sku1stffPUvWg2t9vY9
X-Google-Smtp-Source: ABdhPJyeDb9czZ8qDK3OqoArXDmdKQFuFP0+8cMoyPIsvGDz9n8XoH3936ZJWLiT/GO9DjagwWDNHHM+4IY4AOR3Ui2o8QuLqvKk
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca6:: with SMTP id x6mr18027085ill.225.1635931266408;
 Wed, 03 Nov 2021 02:21:06 -0700 (PDT)
Date:   Wed, 03 Nov 2021 02:21:06 -0700
In-Reply-To: <000000000000bd9ee505b01f60e2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002e72b05cfdeee4d@google.com>
Subject: Re: [syzbot] WARNING in hrtimer_forward
From:   syzbot <syzbot+ca740b95a16399ceb9a5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com, hchunhui@mail.ustc.edu.cn,
        hdanton@sina.com, ja@ssi.bg, jmorris@namei.org,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kaber@trash.net, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 313bbd1990b6ddfdaa7da098d0c56b098a833572
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Wed Sep 15 09:29:37 2021 +0000

    mac80211-hwsim: fix late beacon hrtimer handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108b5712b00000
start commit:   ba5f4cfeac77 bpf: Add comment to document BTF type PTR_TO_..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=d44e1360b76d34dc
dashboard link: https://syzkaller.appspot.com/bug?extid=ca740b95a16399ceb9a5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1148fe4b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f5218d900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mac80211-hwsim: fix late beacon hrtimer handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
