Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3D10D4C4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 12:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfK2L1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 06:27:01 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:53500 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfK2L1B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 06:27:01 -0500
Received: by mail-io1-f69.google.com with SMTP id w19so20156608iod.20
        for <linux-wireless@vger.kernel.org>; Fri, 29 Nov 2019 03:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1R/eyR91b2qzrd9oYXwpA7kVnLlS3eW/CPo2xuZ2tZs=;
        b=psT84Lm6CLIlRwdCQ1qvCwvf26j1cPapvRyn6Y9Niy5Y3MYDBgr0QemD99VWCRGoBs
         3tD80xPCnEj3PRRJJ5V5AF+jczw/Iop2yYmu0Y2ZBXsQZ+pOCDCkqifGCDAqGDFTEOnf
         9jVy4T/vDUCEkIpMLTgxfHGDys8VYbLBjet7ltJU9jxUlAxyTasV3amjLHMpMD1pq5/C
         fSGqI/JTLQ0QLbfo77cN7B+MdD2jmWH0aXYFLWcJnHh1idfoKfCxBpOX+9lEczew+SIu
         bCtb5NjWMuWOUYA0qPwqujflrstT92TfcqxjbS5mA/sAB66xWJ/C8UppywlSvX63XbbM
         DKkw==
X-Gm-Message-State: APjAAAVxiEc8qTnunRYybAlqJV7eTUQVJKNxYnNfKv16SoQQW9Mm9AIP
        jVkQjXuwrN8uej/qXVgCIiFIR86kHTBMH9Vff4OPOevZA54G
X-Google-Smtp-Source: APXvYqx2WOuve6jGICcXm51Pk+hIsPcOb1OO3yj2Zia1Hs0+ZR99DkvW/INJgLvPm6G6NaW5WS+Y11Kyq0HaFv6HhYvElj2iUAAo
MIME-Version: 1.0
X-Received: by 2002:a92:c525:: with SMTP id m5mr52192194ili.91.1575026820788;
 Fri, 29 Nov 2019 03:27:00 -0800 (PST)
Date:   Fri, 29 Nov 2019 03:27:00 -0800
In-Reply-To: <20191129104156.GH29518@localhost>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a380f05987a8239@google.com>
Subject: Re: WARNING: ODEBUG bug in rsi_probe
From:   syzbot <syzbot+1d1597a5aa3679c65b9f@syzkaller.appspotmail.com>
To:     amitkarwar@gmail.com, andreyknvl@google.com, davem@davemloft.net,
        johan@kernel.org, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        siva8118@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+1d1597a5aa3679c65b9f@syzkaller.appspotmail.com

Tested on:

commit:         d34f9519 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
dashboard link: https://syzkaller.appspot.com/bug?extid=1d1597a5aa3679c65b9f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122808a6e00000

Note: testing is done by a robot and is best-effort only.
