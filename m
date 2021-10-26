Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329B743BC9B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 23:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhJZVqi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 17:46:38 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:54097 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbhJZVqf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 17:46:35 -0400
Received: by mail-il1-f198.google.com with SMTP id x4-20020a923004000000b00258f6abf8feso404472ile.20
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 14:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Nkd2MDdhdhQrC35TeT4YASfH+oAymLKxIIDaJwAJcS4=;
        b=dTwWKSe6g8SQbCKJMruolfyiYj/yUv9DMgReI7IL45Ix7H7KDV3V8bX6/SVN1QpnRT
         vbjHS/KSaWTUtPsznKqmH9nR+hKj6N35hJ6IlwNGp74Zc0/+48AqIsk96hyRwRJofBtt
         v4UBNogSozI7pQqa9DcjWEHsCmwvUqYUqXl1YwsWV7L9vLR7sAV9L1/vDF8XA8ZIToAI
         ZTab+n+afIZjk42Uwa0LQ4CsLQEVczymqzaZWyTLUe4GB8bb/AQS3Lak2S75BTT0m2Ua
         Yr93vtUZh2g1Ph99iPxHMwFdKvs38ZE3GKGirg0S+hi0v1+UUQkXykhQwH8qNFcEJm2y
         iRWw==
X-Gm-Message-State: AOAM531RX1FatvPIwzfU942Xw4R53NHqvbkizXWJdfrNCKTGNGHbQ2IL
        ohJZbF/s9JGu2Ptv7KYxskEjtQRtMcJTFCCZunsn5hYw7rkA
X-Google-Smtp-Source: ABdhPJzN3TKKDvt07oWmvWN3D3GEM2iDA5um8MqVj3ZDnbSUvjr5KloSalmIqlOE/uEbmF1x00ad/bebF/k+Xst7WWwNpmIp8BjG
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3281:: with SMTP id d1mr17208695ioz.84.1635284650740;
 Tue, 26 Oct 2021 14:44:10 -0700 (PDT)
Date:   Tue, 26 Oct 2021 14:44:10 -0700
In-Reply-To: <00000000000058e2f605b6d2ad46@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6cfc405cf4860a7@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in ieee80211_tasklet_handler
From:   syzbot <syzbot+7bb955045fc0840decd3@syzkaller.appspotmail.com>
To:     davem@davemloft.net, fweisbec@gmail.com, hdanton@sina.com,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        mingo@kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 313bbd1990b6ddfdaa7da098d0c56b098a833572
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Wed Sep 15 09:29:37 2021 +0000

    mac80211-hwsim: fix late beacon hrtimer handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151766bab00000
start commit:   835d31d319d9 Merge tag 'media/v5.15-1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c32e23fada3a0e4
dashboard link: https://syzkaller.appspot.com/bug?extid=7bb955045fc0840decd3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e08125300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b17dde300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mac80211-hwsim: fix late beacon hrtimer handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
