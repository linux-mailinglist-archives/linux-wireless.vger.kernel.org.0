Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0290223416E
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbgGaIoL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jul 2020 04:44:11 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:42922 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbgGaIoG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jul 2020 04:44:06 -0400
Received: by mail-il1-f198.google.com with SMTP id c12so7707744iln.9
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jul 2020 01:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2MiWhebPAZEwNHbE02ggeQmHTDlIjaaAtS5l21f1BPw=;
        b=Plxw3VAvIj5FFDnc7X9PAMHEJmN35PqL5GHlmNtLXvpDoK/OLeVl1YRvRjuax2vcQg
         nYfAgU6dKVupxXipUzRFw4WArONYlyvkUf8YESTVkhjPlicePfqS1RAhZDQMFE3i7YJR
         YSY75EYNSpADfO+cLHwKx3b2+0q2XTcDdGhQtQ3fLoJWxUKdaZoe78pC6XrtJ6cBzfEd
         V/H3UTNwRra5NjQ8DTAPHufchcQQFvHMtqAPR4bvTtusVR/xQ6RuTANm71LJP0SX752+
         7XB2oIUDIbsF6sKzg60vtRMEAyEV40kRmBOoIpgl0qdw9XaUbJQzdMp6NUpGrB37fZB4
         4xRw==
X-Gm-Message-State: AOAM533sKEuDctJddgopZzLFoWMucIsPmkMFDL0/g43P56oS9gA/2fni
        vWjxClRxYNBImHZLPwYV43Nv7334JZOO2wOebbwmBZYjAzKb
X-Google-Smtp-Source: ABdhPJy4Rj2LLEiAspTEtCegum11hHhIEmst76GFNZjb8ziE/nZyOIvy4zdOy45COS+BYVrIBbRSJc0ymQWmZ3YMzOpl0u7SggRq
MIME-Version: 1.0
X-Received: by 2002:a6b:7416:: with SMTP id s22mr2545374iog.160.1596185045466;
 Fri, 31 Jul 2020 01:44:05 -0700 (PDT)
Date:   Fri, 31 Jul 2020 01:44:05 -0700
In-Reply-To: <000000000000f6d80505abb42b60@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1816805abb8caa1@google.com>
Subject: Re: WARNING in cancel_delayed_work
From:   syzbot <syzbot+35e70efb794757d7e175@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        luciano.coelho@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has bisected this issue to:

commit fbd05e4a6e82fd573d3aa79e284e424b8d78c149
Author: Luca Coelho <luciano.coelho@intel.com>
Date:   Thu Sep 15 15:15:09 2016 +0000

    cfg80211: add helper to find an IE that matches a byte-array

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1790af82900000
start commit:   83bdc727 random32: remove net_rand_state from the latent e..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1050af82900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e59ee776d5aa8d55
dashboard link: https://syzkaller.appspot.com/bug?extid=35e70efb794757d7e175
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1160faa2900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11816098900000

Reported-by: syzbot+35e70efb794757d7e175@syzkaller.appspotmail.com
Fixes: fbd05e4a6e82 ("cfg80211: add helper to find an IE that matches a byte-array")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
