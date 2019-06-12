Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC41642CD7
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 18:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408028AbfFLQ7G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 12:59:06 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:38586 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfFLQ7B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 12:59:01 -0400
Received: by mail-it1-f199.google.com with SMTP id j83so5596964ita.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 09:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=w+d58fwxVEghqdBTL6OdFKQGL56looaKOR87EN5fMyI=;
        b=qmh4WdjhPpTj8PHZZcAmohaO0McTKehZWAET7nEBHYXB96SGah0dQGB3nh/7FLmCzW
         tDUIqcJLToRx3a8DhL209b0hZL1Avw+VShBUnJSBUvH2bOmHtkFHMnLivPhCbCSG2T6Q
         bVV67MUR1vBYjcjQrHP01QDshXID80CrobiwxFA0WfFI2MPeeUxJfOtv9nHO5kd9pvcQ
         5T4rb99AxWL2Fd50V5Dj5Ei0ha+Izza7AcxNeP0Z9cBn2F9SSpoY6qj+25B2B1TTRpDW
         XZpF8giZmJR9cHzjTFjEcgIrQ/91Qo//l+25wXLwuYrBQQhL4oW/DejvSOGAhWmYUnWV
         zkyg==
X-Gm-Message-State: APjAAAWvHaDBhFGAIYuz+8x6S3UPHsoxFWNoe33X5m/XioxNa8mb2Zr3
        Ocaa2LqUOZeR7tqsF5y6cdXC/fiCixYJn5tmK0JFpp3qyDkY
X-Google-Smtp-Source: APXvYqy+d3bgPSksKj/GZ6l17+4OtmOMiusgDBDhfkPRefGdUEPiGlxdnCa9vMOOT8gqL3aVm/rMw7s9G7469ZfCQsjH5cNtRoZr
MIME-Version: 1.0
X-Received: by 2002:a02:4484:: with SMTP id o126mr4901697jaa.34.1560358740768;
 Wed, 12 Jun 2019 09:59:00 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:59:00 -0700
In-Reply-To: <CAAeHK+wpzHG73AbB+199-TN35Kb1kEjGrKScSqU++7q7RSUGGg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007741b1058b235467@google.com>
Subject: Re: INFO: trying to register non-static key in del_timer_sync (2)
From:   syzbot <syzbot+dc4127f950da51639216@syzkaller.appspotmail.com>
To:     amitkarwar@gmail.com, andreyknvl@google.com, davem@davemloft.net,
        dvyukov@google.com, gbhat@marvell.com, huxinming820@gmail.com,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, nishants@marvell.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+dc4127f950da51639216@syzkaller.appspotmail.com

Tested on:

commit:         69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=39290eb0151bec39
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14171fd2a00000

Note: testing is done by a robot and is best-effort only.
