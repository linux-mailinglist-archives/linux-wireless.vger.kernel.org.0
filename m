Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49CBB84F4E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 16:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbfHGO6H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 10:58:07 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71]:33181 "EHLO
        mail-ot1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388291AbfHGO6B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 10:58:01 -0400
Received: by mail-ot1-f71.google.com with SMTP id w5so55221972otg.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2019 07:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WeWUyZi7VCNLtsnaaTiz91GIAA++Rddp6QtWItBqJfk=;
        b=HqEii16ZpUYkwbwoI2TfpD6iVo/nwQOmsjW96a19oIGgO3izlMxwgU81CDccZMVBZl
         MeoS7AE2JHdO3j5oqAIaDzLrDHfBFx9L6xCKh7kUFzYvUAR9fcS4U6lVu82w97TsGzqW
         rfAyqDvUvBQDQivP14tysmlWU33JOFbVjwZa9DQp1whiEDiikRc1RdX/wOFqNYUerN24
         OQOCzvMG98Tu53t4sJLW/46+eDnJGbhZYKez3VtEVAAFzfNLG8XFO1iGtbZyzSTd6Y2I
         a/s4A7GlAOxk+JJaFcYW7Qwu/bfvl9mHW23Fi9BZaaBNj7GrdZAKQI59z1n08FwFC8ow
         fXkA==
X-Gm-Message-State: APjAAAWFsT23nI0bYm9m1L6SpRtF+mwuYj8E+I32vZ8jnm9xZuiIf1tg
        1+ThNGKoFTcIF1p3pyfA6ss+YD7IWtaVyAIiXO9baXCAAxfP
X-Google-Smtp-Source: APXvYqw99ZvGdJtrUfS8mJEwMciCjDs8w83xYn0jXYpAXZuw/cI0KvMd7vubohbBpqBJpfJV+utLREol6sQoZxVKwDY/RnvUoBr+
MIME-Version: 1.0
X-Received: by 2002:a5d:994b:: with SMTP id v11mr9744404ios.165.1565189881077;
 Wed, 07 Aug 2019 07:58:01 -0700 (PDT)
Date:   Wed, 07 Aug 2019 07:58:01 -0700
In-Reply-To: <1565187539.15973.6.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de260b058f882ae7@google.com>
Subject: Re: WARNING in zd_mac_clear
From:   syzbot <syzbot+74c65761783d66a9c97c@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net, dsd@gentoo.org,
        kune@deine-taler.de, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, stern@rowland.harvard.edu,
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
syzbot+74c65761783d66a9c97c@syzkaller.appspotmail.com

Tested on:

commit:         9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d8c03c600000

Note: testing is done by a robot and is best-effort only.
