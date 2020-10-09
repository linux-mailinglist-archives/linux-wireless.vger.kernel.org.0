Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD792888E8
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbgJIMhQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 08:37:16 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:46582 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgJIMhQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 08:37:16 -0400
Received: by mail-il1-f200.google.com with SMTP id z8so6706302ilh.13
        for <linux-wireless@vger.kernel.org>; Fri, 09 Oct 2020 05:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2O9XejXxpQzqGczDlTdf2je5xfsWl83OvCPbQ6swRMk=;
        b=H9FxWqX7WQyDDOV1BHeqsG3Ojl/5fDR8+HNfar1+ltF8p8DxNVJGK8u3p5YdfqTOUg
         0nnM2pF2gz497Rrneud2jOmuhciZYbtZY6pPKLmSdLAP3fknz7wBy5EnzxJ/jLbVJNgd
         syVKfY5gTr9SqvOwDvfdPc1uFrUDT0mwUFhLTY1P05JHVzZhC+34mUSWsS0XOddkKsA6
         kEdeqxPi2vmW447v2uHa2mVtbwZ3I52Q/K7jCHbrgglpfhi1789czCY0hyWpR3e6gJur
         v8Ih7l64ymVTcrf3kr8uMZT+vv6qWxKQjRCwlUp2C5jOxqVeo87wQFC8PfXp8t75C6up
         yGhQ==
X-Gm-Message-State: AOAM533QzgCrip4n3uWpjw+SDRCS8CptZRnJO8U8c6odPtus5nlbriVm
        /FojNtFihjWOcK4Zi59YASEda4ZNPGrHhVPSRcxaP/3FLDQu
X-Google-Smtp-Source: ABdhPJyxysuw/42zqyT66T0krnzPty4U+MYP6wKgKnEygcexGIX26mxLKZOOt4xQCkXMTY/8mvhwVQqqA+yISTMU0Fx91fJt0sqS
MIME-Version: 1.0
X-Received: by 2002:a92:ba44:: with SMTP id o65mr10628905ili.255.1602247034075;
 Fri, 09 Oct 2020 05:37:14 -0700 (PDT)
Date:   Fri, 09 Oct 2020 05:37:14 -0700
In-Reply-To: <20201009132538.e1fd7f802947.I799b288466ea2815f9d4c84349fae697dca2f189@changeid>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f00d705b13c358b@google.com>
Subject: Re: KMSAN: uninit-value in ieee80211_skb_resize
From:   syzbot <syzbot+32fd1a1bfe355e93f1e2@syzkaller.appspotmail.com>
To:     glider@google.com, johannes.berg@intel.com,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+32fd1a1bfe355e93f1e2@syzkaller.appspotmail.com

Tested on:

commit:         5edb1df2 kmsan: drop the _nosanitize string functions
git tree:       https://github.com/google/kmsan.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=33941614a34daf96
dashboard link: https://syzkaller.appspot.com/bug?extid=32fd1a1bfe355e93f1e2
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107d7258500000

Note: testing is done by a robot and is best-effort only.
