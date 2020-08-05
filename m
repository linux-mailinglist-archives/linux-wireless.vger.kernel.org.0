Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADB323C6F4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Aug 2020 09:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHEHbM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Aug 2020 03:31:12 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:36061 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgHEHbJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Aug 2020 03:31:09 -0400
Received: by mail-il1-f198.google.com with SMTP id o191so30209987ila.3
        for <linux-wireless@vger.kernel.org>; Wed, 05 Aug 2020 00:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UAjlV35CqUYg8Wq8iE9joWFodTfiF9zQm++Jk44fcSY=;
        b=hRIi0+KUt5YStJH6KIDfPbUo5vPW8tYECy19Rgf9iAH6ALACiwYsZNyUeHmyWHTVFv
         pNNQg0TEfqgYI+mJoLsx0raWtJkub0j3OgW5wgQn7sww0O3wsQ/HQQMt6defEjZuveUD
         lATiqBoAPwY+80huIdUvr0bljDgIlacNNmsoL6VlPF9c+u0T6XcYJ/ljxUDWTo3KkFNr
         +xDUj47vlDCocK+Ep5wWePN50vTR003Z/V2SyIHJQxUnsZk/6SsUdlCrcHuyAsRFbQ8z
         QerJX6py+RT5Ki+mDrqWtlzNdRn48zbgKSLTml1ZgwTxUC1u5q2ZXffvr59PnA4xtkcs
         yGYw==
X-Gm-Message-State: AOAM530GJ8P//qHO6q7Ol3zB6kdHCLfCxqhE7SSkxJA8+ZFce9dnnddQ
        ArnfVH8CexdcHayqaSVQSlKVu2H/8FTzvRwdpNShLFA4NrFf
X-Google-Smtp-Source: ABdhPJydINKXG6kk6Rt5Q7YptVJc6WU2HIGHbqBbyEup0nCj4eB/muV9ogT+bIQJk1+5SdRMqrFrePgB51/EIuvRRPKG7IPv2d9A
MIME-Version: 1.0
X-Received: by 2002:a92:1b5b:: with SMTP id b88mr2679375ilb.104.1596612668103;
 Wed, 05 Aug 2020 00:31:08 -0700 (PDT)
Date:   Wed, 05 Aug 2020 00:31:08 -0700
In-Reply-To: <000000000000a39e4905abeb193f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed214e05ac1c5ae8@google.com>
Subject: Re: general protection fault in hci_phy_link_complete_evt
From:   syzbot <syzbot+18e38290a2a263b31aa0@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, johan.hedberg@gmail.com,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, kvalo@codeaurora.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux@armlinux.org.uk,
        marcel@holtmann.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has bisected this issue to:

commit b59abfbed638037f3b51eeb73266892cd2df177f
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Thu Sep 15 13:30:03 2016 +0000

    mac80211_hwsim: statically initialize hwsim_radios list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dd5f98900000
start commit:   c0842fbc random32: move the pseudo-random 32-bit definitio..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17dd5f98900000
console output: https://syzkaller.appspot.com/x/log.txt?x=13dd5f98900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf567e8c7428377e
dashboard link: https://syzkaller.appspot.com/bug?extid=18e38290a2a263b31aa0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e4e094900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1143e7ca900000

Reported-by: syzbot+18e38290a2a263b31aa0@syzkaller.appspotmail.com
Fixes: b59abfbed638 ("mac80211_hwsim: statically initialize hwsim_radios list")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
