Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3182F9B04
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 09:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbhARIKV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 03:10:21 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:43074 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387465AbhARIJz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 03:09:55 -0500
Received: by mail-io1-f72.google.com with SMTP id n18so8043423ioo.10
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jan 2021 00:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wEiWUD1KoU2kz++HYBOdztSbeG+sfsDlGM9Lh98rKKM=;
        b=sUFyyddtFWH7ij22xIyV1TEAbuu/SQPxsZ+PUcpkXDRTvipJjcyqMLIZuKOcmEIVBF
         SUjzTk4nQcrqvOaK/L0gdOVSP1ldkvKexqwweEnsBFcFQBgYmgr2RVe9e2yC7CIuCDCt
         lMLn7rVTrVvexIlYB/YcBJnzhGjIurTkv4mwV5WLEvmeTQv4FFP3ECpD6U5+rTWRKfwS
         o4p0HkQ4S4abWdjrD1eZ+KrkreiZbO5g2Ci8wT7k8uUl5z/9Yf5hxpiBhv3bXRdKPcKn
         tZYg8NF3QCo4FJF9I4Pyyu+v0E1oironWMvWKivWRy9zeefDV5Eayzhjd3THNi2jO0o8
         BxiQ==
X-Gm-Message-State: AOAM532p/jkQ5arErsGrHaOimh1AAy+lyx5dRXk11gjy9vfuZPH0oyVX
        yQG+Yq3UEP3G/u8CgSweg5Yv6a0OoysX/KRiIkOpygvXtF4+
X-Google-Smtp-Source: ABdhPJy3DgoWHLFvzuYDkJzDwwA1JaPpvsFtlorUiuid/k905n8sJMZK4Xd3jj5HaJiA1RUHc/Jk2/sDAy2KQkj3cP16ie+7PFKI
MIME-Version: 1.0
X-Received: by 2002:a92:cccd:: with SMTP id u13mr20286819ilq.273.1610957353923;
 Mon, 18 Jan 2021 00:09:13 -0800 (PST)
Date:   Mon, 18 Jan 2021 00:09:13 -0800
In-Reply-To: <000000000000f054d005b8f87274@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d43c1305b9283c0a@google.com>
Subject: Re: WARNING in io_disable_sqo_submit
From:   syzbot <syzbot+2f5d1785dc624932da78@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, davem@davemloft.net,
        hdanton@sina.com, io-uring@vger.kernel.org,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has bisected this issue to:

commit dcd479e10a0510522a5d88b29b8f79ea3467d501
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Fri Oct 9 12:17:11 2020 +0000

    mac80211: always wind down STA state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b8b83b500000
start commit:   a1339d63 Merge tag 'powerpc-5.11-4' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1078b83b500000
console output: https://syzkaller.appspot.com/x/log.txt?x=17b8b83b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c60c9ff9cc916cbc
dashboard link: https://syzkaller.appspot.com/bug?extid=2f5d1785dc624932da78
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f207c7500000

Reported-by: syzbot+2f5d1785dc624932da78@syzkaller.appspotmail.com
Fixes: dcd479e10a05 ("mac80211: always wind down STA state")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
