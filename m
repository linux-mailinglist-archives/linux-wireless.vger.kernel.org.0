Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83FFD1046CB
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 00:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfKTXAB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 18:00:01 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:52488 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfKTXAB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 18:00:01 -0500
Received: by mail-il1-f199.google.com with SMTP id t23so1090124ila.19
        for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2019 15:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ypoFC5Ro1whWyZkoNTFbjCm62awQmvPA/XY3KWGTpeY=;
        b=OmVaGKEhONgOCtL1YKvR/tAW2oyd/xC/NBN/cMYur3FX7BGNNS6NOCgYU5jJf9PMwc
         CgEBdQQF01IvXNDVWkufhaAlkJG70aLFuUTrotUlw+Dm3csgUNyTgaK0/JCgKa0RSa/B
         7Up5qY8rjcJCIzqbsyf8CojjFzvl8mHZ3htcwc5fEv/Kknbuhdwe68YJz4pkIJu3hEvD
         rep41j5rI9TGc/qZSPnSHOIZFNi8/LjGcSxQW3l1j4K2v1SKeZbTXceYdXLBacQP7dJV
         RxQ3p12VGLWwJ7pi9CY/7I+oGooDYT0QV0jKrmD3hD8KogmIr/W3etKAx/H3IQyBFEqS
         y3MA==
X-Gm-Message-State: APjAAAXfzf50JkmldIz3hHXRn7vxdynMlkHfIGQDgW6wJ+D0z3tbIx4t
        17eMRZelSeR23a126sTq029Xi9/KptDizCjsKGQEoso3sgQE
X-Google-Smtp-Source: APXvYqyofe8WhECLKlKXZgBJZBsZrYVm/t+Y8eRSVSR0U/8UgoTSuC2z2cvX43ZBQGe1osg94jcabQYUuLJ1jeNst5ogvlPqNJZy
MIME-Version: 1.0
X-Received: by 2002:a92:1705:: with SMTP id u5mr6454619ill.151.1574290800348;
 Wed, 20 Nov 2019 15:00:00 -0800 (PST)
Date:   Wed, 20 Nov 2019 15:00:00 -0800
In-Reply-To: <1574170553.28617.10.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed95090597cf2395@google.com>
Subject: Re: WARNING in ath6kl_htc_pipe_rx_complete
From:   syzbot <syzbot+555908813b2ea35dae9a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+555908813b2ea35dae9a@syzkaller.appspotmail.com

Tested on:

commit:         d60bbfea usb: raw: add raw-gadget interface
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=79de80330003b5f7
dashboard link: https://syzkaller.appspot.com/bug?extid=555908813b2ea35dae9a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125c855ae00000

Note: testing is done by a robot and is best-effort only.
