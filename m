Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEED32237E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 02:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBWBUw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 20:20:52 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:43565 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBWBUt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 20:20:49 -0500
Received: by mail-il1-f199.google.com with SMTP id b4so9181207ilj.10
        for <linux-wireless@vger.kernel.org>; Mon, 22 Feb 2021 17:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ACL/TW56hmM3icGPdSa0X3n3g07ekXH6PTx0W+ED+Os=;
        b=e0G4eel/BZcFRZfxoK+746D/5J8Rr/xlct/LY91OB1EVbKTR+A8WLiHHGxjOa9DbmY
         0qRbtPDZws751C5FXN1sUK45QPrVyZUZs1QA8j7rNkC0renAGTn7LP7wbPY7tuK5k7Oa
         kMS/zbuAmiaJ4mqIc6Fv2vAsLxvGs809stSGq3AvBsVKfKyj+12gXuLv+moA5X/Gktx+
         nIPMrzBXSgGl6/ROJJfdKqm1W1/4KDdTzqrYomTxDgStdBSr5wNpo+2sb92EbujLCe/c
         3xW12Im4Yozi70n7gFtPg6aQLvET0rACZx+WFIXj1oXikVDyIBqjGtsUpl4Ng+hZtX/Y
         1cYg==
X-Gm-Message-State: AOAM532jKLvZ+WEkik+kw1JKP8YDjPQwoVVHlucmviiepTVg6CFqtqxD
        ejkwQ8SQYWJvg390xrL9RGx/2rXHPGdgzt2pF5uQhjfE443l
X-Google-Smtp-Source: ABdhPJx9ZFVHGhyVAJurNdjMzu3Qfr+RlQdpRk1YumGN7EUKjFQqc3Ah/e+LPTa1FrJaCYq/dtjAB9VwGPIQe5m3XHIN7YtRNaeU
MIME-Version: 1.0
X-Received: by 2002:a02:a888:: with SMTP id l8mr6116516jam.50.1614043208198;
 Mon, 22 Feb 2021 17:20:08 -0800 (PST)
Date:   Mon, 22 Feb 2021 17:20:08 -0800
In-Reply-To: <0000000000007f199405baa1ffc4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013b2eb05bbf6b8ce@google.com>
Subject: Re: WARNING in init_timer_key
From:   syzbot <syzbot+105896fac213f26056f9@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, gerrit@erg.abdn.ac.uk, hkallweit1@gmail.com,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has bisected this issue to:

commit b9df4fd7e99cb8bfd80c4143f3045d63b1754ad0
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Sun Oct 6 16:19:54 2019 +0000

    net: core: change return type of pskb_may_pull to bool

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b4545cd00000
start commit:   1048ba83 Linux 5.11-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13b4545cd00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b4545cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ae5569643a9955f
dashboard link: https://syzkaller.appspot.com/bug?extid=105896fac213f26056f9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f0e564d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147075e8d00000

Reported-by: syzbot+105896fac213f26056f9@syzkaller.appspotmail.com
Fixes: b9df4fd7e99c ("net: core: change return type of pskb_may_pull to bool")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
