Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D92AB19E050
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgDCVbE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 17:31:04 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:39249 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgDCVbE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 17:31:04 -0400
Received: by mail-il1-f200.google.com with SMTP id w76so8402505ila.6
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2020 14:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SPAwpvKMvYbr6XxAGejDItd1iT8+uNKheRzWPuMzaNE=;
        b=E2foNnncLr7pFk0ESZkUPu8xoCz51On2Xbrz0+DouUkluXmselTOgmvhT/+CnF1RSr
         ZeM1Zxncgh2cshcLKV2dAlYyCjYrsfn9tszAQl36ABIhreo1B82gbboxW1hF8VJZ0PP0
         bREJ/mNc9qbT1vluxws7ON+pcFe+ou+103G9dz3xa/RheMTgt20aBfnZVutu9hzhHfws
         QbBbInQZMvDygImcigkGwrHFjvobs1TbQVJc+mQ1m9Ku+jt08RbSQdSqvNiXTJOJnuvG
         0CMjjZkUVxh9yC7ul7gwgwPT+yOg1mCJpAggon2ocqRVmvpzhRUpaYP90lHSYNavJo8N
         sl0Q==
X-Gm-Message-State: AGi0PuZSnaPhdcehRB7fMPyGjGVfAQ/KpvjD9aK2bSrIUePrOS+kp+jy
        4qwpFQ2EYOPIOKmz3/7ldd4tBpolm6RTV+MSXISIPKl9Bl3S
X-Google-Smtp-Source: APiQypKtbpUx/vzWx0thrapB3XZjS4Im1jHjhnIpoPxECPWeYSgLiP8MWdcuJaBa01aC7/l5u2pJ7JQUYFzktar8s2Ldy/IUQ2JZ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1550:: with SMTP id h16mr9161068iow.171.1585949464055;
 Fri, 03 Apr 2020 14:31:04 -0700 (PDT)
Date:   Fri, 03 Apr 2020 14:31:04 -0700
In-Reply-To: <CADG63jDxb5zkvQwNn=M1ONCsEVZxZBUo8SzN86U01w4tQ5F4Rg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006fd4d605a269a296@google.com>
Subject: Re: KASAN: use-after-free Read in htc_connect_service
From:   syzbot <syzbot+9505af1ae303dabdc646@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+9505af1ae303dabdc646@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=9505af1ae303dabdc646
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bab2cde00000

Note: testing is done by a robot and is best-effort only.
