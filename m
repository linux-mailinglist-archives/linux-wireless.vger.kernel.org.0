Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5059A19DF6A
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 22:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgDCUcE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 16:32:04 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:45643 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCUcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 16:32:04 -0400
Received: by mail-il1-f197.google.com with SMTP id p15so8186169ils.12
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2020 13:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=w8mFdsMhO76bZFqWMwIe+0AsU+lplHC+HdX5ScRWf2o=;
        b=Z1csnadTBGunSWAcl7687R1nt/eN7xuQ2DmgNImchZxEXvJXNV4b0NlKzfeSzGRQah
         R2nqWviIEt1nV/tZQRAZ5/7DGk2lQY5NxpSx7+APH9sNFGETQcDfzd01jHZHJJAZSq6M
         PsSQ2oQXpAnRazbugO0uZCrr+BgUAhlhNvOFb7qBXeSqDWi6rZTp6NnoN+oAHi6jHsq0
         9FKnPxnnpF2O0C6/xCYrf0H2G2Dy9kyHMppT38wPH6Qq+WQSYLCKLHLTQkJkbytQb9iQ
         3dWgx3CR6SfxcjJrvRQYtgcfs3pOFWSu5N/H05LMjFZFlyVdt4emOjr1cbhpZ+/8zIiG
         /uYw==
X-Gm-Message-State: AGi0PuZ0TX8qPc94kGt2VFI9WDIloOKk636KjXjVov9EOoFjv/Yw06LJ
        o0L06W5KBtmM8Y57LlQNmKmfLJIY17P3KjhJeUpC0SPls/Hq
X-Google-Smtp-Source: APiQypL7/jcPzgJ8/OUT0G36YxdR1mbGZlszf4LQ7Ts2iHfYZMZCQYXEICwC6jd7nw2CDDArjKeiPzryS0MxWW+sw+5fXTvdVwjx
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:790:: with SMTP id q16mr10888997ils.295.1585945923666;
 Fri, 03 Apr 2020 13:32:03 -0700 (PDT)
Date:   Fri, 03 Apr 2020 13:32:03 -0700
In-Reply-To: <CADG63jBkWfxOSsJ=7FkB-6ScdW48VPJZLV2KrhCVLjVRCASzhQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069c9de05a268cf5f@google.com>
Subject: Re: general protection fault in ath9k_hif_usb_rx_cb
From:   syzbot <syzbot+40d5d2e8a4680952f042@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, anenbupt@gmail.com,
        ath9k-devel@qca.qualcomm.com, davem@davemloft.net,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+40d5d2e8a4680952f042@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=a782c087b1f425c6
dashboard link: https://syzkaller.appspot.com/bug?extid=40d5d2e8a4680952f042
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b013b7e00000

Note: testing is done by a robot and is best-effort only.
