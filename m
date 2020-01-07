Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6543F132345
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2020 11:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgAGKMC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 05:12:02 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:51832 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgAGKMC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 05:12:02 -0500
Received: by mail-io1-f70.google.com with SMTP id t18so32693334iob.18
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2020 02:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uY0IMSD0dpLD3QQHBJ18OrMq7eBYbFB7tHn+vZdbCpU=;
        b=Q0ZfB4/JKWvUGARaDL4PGttlzBOELFXVmnYZYfM6rdhITDgv3302FF3PVXrbGHO/Qn
         VSAMq9bdwrALw+tnQc77qb2BDB8XtqxarD9zVrO64ijOEnk5Mzb+0sPZM3XEthSr0yEE
         T0ZrCwS1eXqhdh6z7a/lc+DMpyMVMhPyq2mlQY+0uMPCWe5E0fEP1uzAde42YK4szEUz
         sagQyGeJmQVQjcOsapk1WhOatI7yaqe1fd+0wTtEV5rN8AoCDhv0lXKYoyb8FYOPQzGW
         yz+z6q09Rk3NVEv20YEEObx6VaVAX4654ompu7HuM3tS286pgditzUomwWDaM1TxfIwL
         7SbQ==
X-Gm-Message-State: APjAAAWa1b4bO+sSCxYwgyZGzGsiy11sfLUVTup6K0mnRoooHp2Oe/Xy
        bfU9UWOJ6wEyvfwZVOlwd8rHR4tIMLmVf9/xaFF6f/FGIvW7
X-Google-Smtp-Source: APXvYqwv0/OkCF9+faxbADAvRTX3QIb9FKZF7SgcrbkDTc9kexfy5mcSiu6q64gZKoVVyGS18zybmgeFYRrHU+aAiI+B41Zqko2l
MIME-Version: 1.0
X-Received: by 2002:a5d:8cda:: with SMTP id k26mr48129317iot.26.1578391921440;
 Tue, 07 Jan 2020 02:12:01 -0800 (PST)
Date:   Tue, 07 Jan 2020 02:12:01 -0800
In-Reply-To: <0000000000004ceb27059b868b57@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb3c3c059b8a01e3@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in cfg80211_wext_siwfrag
From:   syzbot <syzbot+e8a797964a4180eb57d5@syzkaller.appspotmail.com>
To:     astrachan@google.com, davem@davemloft.net, ghartman@google.com,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        muntsinger@google.com, netdev@vger.kernel.org,
        schuffelen@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has bisected this bug to:

commit c7cdba31ed8b87526db978976392802d3f93110c
Author: Cody Schuffelen <schuffelen@google.com>
Date:   Wed Nov 21 03:14:49 2018 +0000

     mac80211-next: rtnetlink wifi simulation device

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11cf6885e00000
start commit:   d89091a4 macb: Don't unregister clks unconditionally
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13cf6885e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15cf6885e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2f3ef188b7e16cf
dashboard link: https://syzkaller.appspot.com/bug?extid=e8a797964a4180eb57d5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c85915e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c02bc1e00000

Reported-by: syzbot+e8a797964a4180eb57d5@syzkaller.appspotmail.com
Fixes: c7cdba31ed8b ("mac80211-next: rtnetlink wifi simulation device")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
