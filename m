Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1CC280CD7
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Oct 2020 06:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgJBEbL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Oct 2020 00:31:11 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:39212 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgJBEbL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Oct 2020 00:31:11 -0400
Received: by mail-io1-f78.google.com with SMTP id y16so198380ioy.6
        for <linux-wireless@vger.kernel.org>; Thu, 01 Oct 2020 21:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2rR7OFCkiGOcbn8yg3FFIizJzk0Y5CDsOwEAe9MFfqY=;
        b=FFY7AenbEseT0q6IziggL8Y0vrOsB4NHyojv6C+qh3YaiUcSHE0DzRoGBL71nCDkCa
         D643o+jZzUp4JRI8lZXhEVUSgfrIEiNIDJbNVn5VQjRyRXpd6YQb3+DKur0iOYEVPMq4
         vapefCGOp6S79U5AbdAh92UC7kpMpgbl2swIPiVhfOCa0kyHKZZ5AxvHzV+gfcL5ZZ47
         D121OuZxtGCb/HFCOzUYq/dZ/N9xFFqsBHGRAoKT54Azty0KHbRL0s/SIdaTHlRpQdxp
         3s6zC3jlV5ojXvo6tP+vJXTqi53dGCvxPKXYGA2AZtLIQxxTBg94h9tzjFcMFtPMvTB4
         VpwA==
X-Gm-Message-State: AOAM532G/TnCJvsdtno5rYLkgpaExRv+x/ntw2C/vp90VMV0Qt2BiNIG
        hWDq10Sy6l9qvA3A18E7xzKp2j90sNrpulJzQUUPqRzavkmn
X-Google-Smtp-Source: ABdhPJwyio9B9RK4QMV+77SSkDUiL2aBMDrXygJtRXJZn8ix0TJV07LbSiIGdgU/ICZl+Xp6JhyjTk1bOjljcqJ5nfrSfAkO2l0T
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24c1:: with SMTP id y1mr616780jat.119.1601613068931;
 Thu, 01 Oct 2020 21:31:08 -0700 (PDT)
Date:   Thu, 01 Oct 2020 21:31:08 -0700
In-Reply-To: <0000000000007b357405b099798f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a954d05b0a89a86@google.com>
Subject: Re: WARNING in cfg80211_connect
From:   syzbot <syzbot+5f9392825de654244975@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, david@fromorbit.com, dchinner@redhat.com,
        hch@lst.de, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has bisected this issue to:

commit 16d4d43595b4780daac8fcea6d042689124cb094
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Jul 20 01:38:55 2016 +0000

    xfs: split direct I/O and DAX path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f662b7900000
start commit:   87d5034d Merge tag 'mlx5-updates-2020-09-30' of git://git...
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16f662b7900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12f662b7900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b5cc8ec2218e99d
dashboard link: https://syzkaller.appspot.com/bug?extid=5f9392825de654244975
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1100d333900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1414c997900000

Reported-by: syzbot+5f9392825de654244975@syzkaller.appspotmail.com
Fixes: 16d4d43595b4 ("xfs: split direct I/O and DAX path")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
