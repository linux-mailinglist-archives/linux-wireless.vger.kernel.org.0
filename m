Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5140F28241B
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Oct 2020 14:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgJCMpJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Oct 2020 08:45:09 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:50733 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJCMpI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Oct 2020 08:45:08 -0400
Received: by mail-io1-f80.google.com with SMTP id b16so2645945iod.17
        for <linux-wireless@vger.kernel.org>; Sat, 03 Oct 2020 05:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=O/u2fqyXLK0YS4cdPeK1MlCoIRulDbI3uMHYLDBM+gE=;
        b=uOmQM8iYcoX6E6vX9MFj1wlnqvocYTwrBgsrQbwRjAszGC0ouTOm/xrhGFuqpGRAGp
         kiuM9/bGCXHYJI7fh/1zIMPZC79Zo5T6IRRdbCgV4/FfigvSU3oagm20PzezQ0aQ8gJ0
         CJOAFJUx0DzF6PDf2EZIVzaiKnGlNgWWCykDIPDedwXRl+XbQPuXz+ka7vNkwUQi9FQD
         QaPVuP/zfCymBtxCRlch2Abr7yw05OxkyOAmbbfKRaeGNGB81w00HskDK0nw+nV/9w1K
         Ie5w/+XgB2KxnS+7Wy+lhtJ0LsNXCI2cUlmq0wRYuv65dGAOTXekvP9TSYrY9d0aNXP+
         9Zjg==
X-Gm-Message-State: AOAM530hXMDplk97mIZAQCXSXXqeN4IZwTVa4gLtNIsTjTTdtdVRAx1a
        WNGYdvQVDbdv7kG7MVpfGSwRqd5DmD6pf2nD2PaGsA9lyCyh
X-Google-Smtp-Source: ABdhPJyRz/A5CvPNMT52s8+m2dfKNAHR+kvMHdTA8FDr9QHOAF5bCyv1hMFXDVTQUR3nCvvebSNewG0c6aM/CU6AfigENWeZaUPi
MIME-Version: 1.0
X-Received: by 2002:a5e:8516:: with SMTP id i22mr2945386ioj.93.1601729107907;
 Sat, 03 Oct 2020 05:45:07 -0700 (PDT)
Date:   Sat, 03 Oct 2020 05:45:07 -0700
In-Reply-To: <000000000000fa10d905b0b1eb89@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080daf705b0c39e95@google.com>
Subject: Re: WARNING in drv_bss_info_changed
From:   syzbot <syzbot+4cf3e4e092f2f4120a52@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, g.nault@alphalink.fr,
        johannes@sipsolutions.net, ktkhai@virtuozzo.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has bisected this issue to:

commit 489b30b53f0540b9f8e391cbb2839cea48b5d1c1
Author: Kirill Tkhai <ktkhai@virtuozzo.com>
Date:   Thu Mar 15 09:10:57 2018 +0000

    net: Convert l2tp_net_ops

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175b598f900000
start commit:   fcadab74 Merge tag 'drm-fixes-2020-10-01-1' of git://anong..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14db598f900000
console output: https://syzkaller.appspot.com/x/log.txt?x=10db598f900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
dashboard link: https://syzkaller.appspot.com/bug?extid=4cf3e4e092f2f4120a52
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145eb667900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15422c1f900000

Reported-by: syzbot+4cf3e4e092f2f4120a52@syzkaller.appspotmail.com
Fixes: 489b30b53f05 ("net: Convert l2tp_net_ops")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
