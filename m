Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC84E47A616
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 09:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbhLTIgL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 03:36:11 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:39686 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhLTIgL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 03:36:11 -0500
Received: by mail-io1-f72.google.com with SMTP id m6-20020a0566022e8600b005ec18906edaso6650620iow.6
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 00:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=O3LXneiNH9IRbWHAKK3lrVYWgtCFvwj/GzY0w5gPzSA=;
        b=nyea4QMuU5CucrNls8ft/itSSPPebgkNqu7Vq0EHrx/vtRLhTrUOB6ymGbzkDd1qRl
         Q7cpoFaRzRl8Uy4QWkBiCUbQ/FkdQvzefbcDrUd/CLYU0MwpYXivDc4MT5If61lQjVIT
         tHVVy/SWQawoSxUxfkbNbWT/wPA4Fl1JHB6bCQl0upD6B8BOyFp0xrfTVh3Ij+AsPV7N
         ZODzwKPTDNLonqcoN9izoUtkmLm4E/0/Xy67FwgcMLbjQ0TlIY4ynsQPLOdRRL/k5lhO
         jWOsEqB2NTd0qB/41ug4/v3bmnuOJoB9Xeumloh7qi+TYyJVFnBAUccko1xR0Htc5f4R
         8q7g==
X-Gm-Message-State: AOAM530o8qNJ00XPmc9L3ps9+3A8F5d+wPCDjRazUHEwD0Ti+4mf/v8C
        EVNWSX0gkYtcg5MDA3K73fdhjmaLex/3QXD3gKCMa+V4Blus
X-Google-Smtp-Source: ABdhPJwDzIY6BCSPt6NhocGT4u74Rfl+fDqzK2BHg2sNL8ykWf2a3GluAuPJNgfc8D5oS9lUEiWH1t820hqfmf5IFmT82jX2gq92
MIME-Version: 1.0
X-Received: by 2002:a05:6638:191c:: with SMTP id p28mr7354021jal.181.1639989370732;
 Mon, 20 Dec 2021 00:36:10 -0800 (PST)
Date:   Mon, 20 Dec 2021 00:36:10 -0800
In-Reply-To: <20211220090836.cee3d59a1915.I36bba9b79dc2ff4d57c3c7aa30dff9a003fe8c5c@changeid>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0c8fb05d38fc731@google.com>
Subject: Re: [syzbot] WARNING in ieee80211_vif_release_channel (2)
From:   syzbot <syzbot+11c342e5e30e9539cabd@syzkaller.appspotmail.com>
To:     johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+11c342e5e30e9539cabd@syzkaller.appspotmail.com

Tested on:

commit:         60ec7fcf qlcnic: potential dereference null pointer of..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa556098924b78f0
dashboard link: https://syzkaller.appspot.com/bug?extid=11c342e5e30e9539cabd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1412bd93b00000

Note: testing is done by a robot and is best-effort only.
