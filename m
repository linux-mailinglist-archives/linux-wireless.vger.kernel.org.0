Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD99535870A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 16:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhDHOVW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 10:21:22 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:52680 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhDHOVV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 10:21:21 -0400
Received: by mail-il1-f198.google.com with SMTP id e16so1397037ile.19
        for <linux-wireless@vger.kernel.org>; Thu, 08 Apr 2021 07:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lK/Gsw1h+v5z047IGUshl6SiGiWsVvoS54xTA/GUSx4=;
        b=LtNfcY18IZukSZPMmxBszGwpthwbSfL2i317pzDGToXR9lxOAQheB7e1Sz5WuNPJbt
         E78q/bznX5Ah0Qf3wIUu0zlkxOwph/lVWiW7S4lmQL+DIu0NW2cb4oAwlfenv6nIZeVn
         orNWeDR7fyzyY1b2HFqqcmsk4FRI3FYASrYw+0vzjDWysklx5exfTiDrNBjThJW0fMfv
         ZclWcJrJmZICpFZ6Chm7e/p8P9q8ZogNH4lRYl8c9O6lFGFaz/+YyAuL36nePcmm8nhi
         6CeKpNjiatY6Bz6TFOiZ8JCLmK/OvxjVLGBAr0CgXXZyl5nfnwH+9RtMEogAKnqOrG+A
         eT7g==
X-Gm-Message-State: AOAM532i30IjW8ZwBJFefy7Q1/RpVR4Ldr9F+d82f1zy8vT6mHXrxUZu
        G6pcRcOIuGRUXp5eQEAnRzXrO0p/rZJRzvKU0KKFCm9kcAVu
X-Google-Smtp-Source: ABdhPJxRoljtAsujDFr65RiuLFOzdeY921KMtJBRHS09dYORi9GHPBJ4DVh8nUqE0G6hukJkkR++rPQuVkrbIrvynHObXO87Y2P8
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2355:: with SMTP id r21mr6539396iot.62.1617891668802;
 Thu, 08 Apr 2021 07:21:08 -0700 (PDT)
Date:   Thu, 08 Apr 2021 07:21:08 -0700
In-Reply-To: <20210408154518.d9b06d39b4ee.Iff908997b2a4067e8d456b3cb96cab9771d252b8@changeid>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034913005bf76c2dc@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in validate_beacon_head
From:   syzbot <syzbot+72b99dcf4607e8c770f3@syzkaller.appspotmail.com>
To:     eric.dumazet@gmail.com, glider@google.com, johannes.berg@intel.com,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+72b99dcf4607e8c770f3@syzkaller.appspotmail.com

Tested on:

commit:         29ad81a1 arch/x86: add missing include to sparsemem.h
git tree:       https://github.com/google/kmsan.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6213d08918028fb
dashboard link: https://syzkaller.appspot.com/bug?extid=72b99dcf4607e8c770f3
compiler:       Debian clang version 11.0.1-2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14424d31d00000

Note: testing is done by a robot and is best-effort only.
