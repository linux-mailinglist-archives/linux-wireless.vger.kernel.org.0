Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFB19E086
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 23:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgDCVtE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 17:49:04 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:35574 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgDCVtE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 17:49:04 -0400
Received: by mail-il1-f197.google.com with SMTP id t10so8410169ilf.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2020 14:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zSI07CjR5IyEH+/NIlKzkOBeWdFhLCDjSvm8dcjjF9E=;
        b=NyRjwu4wk0d30JiItIm9XVEUTCHs0TlClHKGO0jdtp+nbRlhJjwFw3qd/3k6Rclk+7
         YT6YUSSDd8AV3EqB9W+ko8u2KfQ4QwFWLkQkqy4v3TQie5JBBe3qHxXw8FXncGXGKvA5
         SccIJbXPEifsKE3eHIelMWqV5kbV/H4d+acaMC5sywPm1JQqRRsiFf/yMXpv610IogCc
         Ax+GL/QZp6xLwwxtosGBDoVqkyZymnn+Hjn/+HV+Omf0DbcJcetEnLcbeV2m4EGrmJbW
         8yF1aA1YBDNYI3hUF482Dpzo1EahxajEWq5oAJcUiKxTLdh5C1vLS37wsva1g1l851kL
         IifQ==
X-Gm-Message-State: AGi0PuaTS6AVlCNOb0LaQDXYt3hr9Q5fp3VDeuyom2Q5cRt10HlYGMkF
        U6/UkidDmipwOPpwqfhUSo24Y3vJw6U0qktn+7obC1oPUoXw
X-Google-Smtp-Source: APiQypIjGi0Wfgk0b25qP452rAzQr3GjIWACeIBF++/I8dzYGRRklPvqHEKztUVWk9BfQ+s9cnDjHNsygkQrmfW6PoH9mK/E1CNX
MIME-Version: 1.0
X-Received: by 2002:a02:2b11:: with SMTP id h17mr10019717jaa.140.1585950543555;
 Fri, 03 Apr 2020 14:49:03 -0700 (PDT)
Date:   Fri, 03 Apr 2020 14:49:03 -0700
In-Reply-To: <CADG63jDvVnX=_5oJSEqrsTUsCuYPj6Grz9dEFLvWpa1F=oa1Lw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7b02e05a269e206@google.com>
Subject: Re: KASAN: use-after-free Write in ath9k_htc_rx_msg
From:   syzbot <syzbot+b1c61e5f11be5782f192@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+b1c61e5f11be5782f192@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=a782c087b1f425c6
dashboard link: https://syzkaller.appspot.com/bug?extid=b1c61e5f11be5782f192
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11981b1fe00000

Note: testing is done by a robot and is best-effort only.
