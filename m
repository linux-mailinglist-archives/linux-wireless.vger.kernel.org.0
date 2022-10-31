Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BECC612FA5
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 06:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJaFS2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Oct 2022 01:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJaFS0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Oct 2022 01:18:26 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273595F5B
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 22:18:25 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id z15-20020a5e860f000000b006c09237cc06so7440684ioj.21
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 22:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqHgzxDahGo8WLLuBYy59P40M4NmqDz0QC8mWC+Acpo=;
        b=yNAfXf70N9QKGNI+eWb2MIHd+nx67uWy7gUOCAsDr3UsCOPLvzH7lwWhCbNwvyzfCO
         xUApItY3eVXIQ9oGs3r5rxqH+yd9h+sQEPLwKORAk69KvPvAZ5N6x7vE7uVVyDB4ArAv
         pJEue/ZNrbcluDvFfIJAp4XEuFDRwd1CqGmss3L3Gn5Im73sFZeLdIruT9lDbAapM9UY
         bNSGQ1LZXLEWz5u2xx7eyCRE8S3GLney6Dd3id+UAwMwZFgcMDxc0BlN3xogICFHb6Ms
         7yugWkmGM+faaw/f363+x1jT+fuewsu+RB8dqSkF6+ehhWrdQEFU7bgjggvJ7A9Sc0aB
         pOeA==
X-Gm-Message-State: ACrzQf0bkiFAsysUmVvc13Fox/44HFIDtYGueAzxobOBbjXVlT6E5Qsa
        uBS1pxTFJsgzkN60MaCFbx3YV7FymrI4TUbxBOVX3lCu8OhE
X-Google-Smtp-Source: AMsMyM5Z+FcFSBgakH6YLy5XAtjRF33Ed5FIP7Y7cGMGJkLgInKlZZou46sPbAtjT/FJ3HaHpKsanl3V/5hWpmqfJlnSgrtqio13
MIME-Version: 1.0
X-Received: by 2002:a05:6602:154f:b0:6bc:f701:cb37 with SMTP id
 h15-20020a056602154f00b006bcf701cb37mr6189453iow.136.1667193504510; Sun, 30
 Oct 2022 22:18:24 -0700 (PDT)
Date:   Sun, 30 Oct 2022 22:18:24 -0700
In-Reply-To: <20221030153622.22720-1-yin31149@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bbc8205ec4dbc91@google.com>
Subject: Re: [syzbot] memory leak in regulatory_hint_core
From:   syzbot <syzbot+232ebdbd36706c965ebf@syzkaller.appspotmail.com>
To:     18801353760@163.com, davem@davemloft.net, edumazet@google.com,
        jhs@mojatatu.com, jiri@resnulli.us, johannes@sipsolutions.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com, yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+232ebdbd36706c965ebf@syzkaller.appspotmail.com

Tested on:

commit:         aae703b0 Merge tag 'for-6.1-rc1-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=131ffba1880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f454d7d3b63980
dashboard link: https://syzkaller.appspot.com/bug?extid=232ebdbd36706c965ebf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17589461880000

Note: testing is done by a robot and is best-effort only.
