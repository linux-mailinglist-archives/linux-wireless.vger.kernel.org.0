Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E7F10CE25
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 18:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfK1R4D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 12:56:03 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:38823 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfK1R4C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 12:56:02 -0500
Received: by mail-io1-f72.google.com with SMTP id q4so18618215ion.5
        for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2019 09:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=D3t8HLkD5KERASZ5/10L4Vedv8sGcluqQlgTqIienfY=;
        b=ljdbGySbgCG+EoXTJedGxfK0WE6rqLSyiNPa0GoLFNFZpvRTQZhwuZOTqCrNEZUutP
         vjzkIs+Az6O8CCGgXdI1sc2d30qfo9uYYpfX8KvoQ69pTU66XOKqnZMFdHtSSfiqaY/H
         Qr/slujBSn7FS6eFi6N7YRJZKhx2DSpip0GY8pGrI4XfjcJm179Ywbr6+vbcMRmr6zwk
         jKOCoVA42lM/roh3eEDfzgzTrZB9fMLd1e2zy03NGV9dFfUZa/XYj4HUx69qnjVJKgi5
         XOOF38T8xp+5ruSo1LC4tRu+eAM8KyStA6/v32fLiyT0mqK1udPDqYl27zyi3URXuYaH
         7X9w==
X-Gm-Message-State: APjAAAU4YZcYk5dPNNtrpOdc+DZgs7Z3/BAPopT7T6VGnj/5kVttAIkT
        0sTWuBJqVl5SqgbICt6s0lIzmE0c0Ylgwkg0vIO30ykI+nII
X-Google-Smtp-Source: APXvYqwtZGLupDC8dXt0vQ4ZsGccZwV0opxixk1mT9lcdgdGXO6PJkgun8hsxChuS0l4VyECRBAJr2PvxTFlSHngLobliKs2uuUl
MIME-Version: 1.0
X-Received: by 2002:a92:7f0a:: with SMTP id a10mr2543646ild.110.1574963760424;
 Thu, 28 Nov 2019 09:56:00 -0800 (PST)
Date:   Thu, 28 Nov 2019 09:56:00 -0800
In-Reply-To: <20191128173407.GD29518@localhost>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079707305986bd3cd@google.com>
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

syzbot tried to test the proposed patch but build/boot failed:

failed to checkout kernel repo https://github.com/google/kasan.git/master:  
failed to run  
["git" "fetch" "https://github.com/google/kasan.git" "master"]: exit status  
128
fatal: couldn't find remote ref master



Tested on:

commit:         [unknown
git tree:       https://github.com/google/kasan.git master
dashboard link: https://syzkaller.appspot.com/bug?extid=1d1597a5aa3679c65b9f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152f94dae00000

