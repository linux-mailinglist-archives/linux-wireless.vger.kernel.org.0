Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D287A3347
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Sep 2023 00:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjIPWq7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Sep 2023 18:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjIPWqe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Sep 2023 18:46:34 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7A6CD3
        for <linux-wireless@vger.kernel.org>; Sat, 16 Sep 2023 15:46:29 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1d6ce46e952so455370fac.3
        for <linux-wireless@vger.kernel.org>; Sat, 16 Sep 2023 15:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694904388; x=1695509188;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDqDFKt22vTyovtCZWANFsO5nNiwiMzMNFzNzYfo0Os=;
        b=pEsWF48FlQE6g/WRMlJN8Bm3mr+kfxC5lG7PVuqTpPpwVEipd2xCNxZvwklbB/VtCN
         pstKSTQ1DA5rBdGL57U5TzkZKYoFUilz+giiAcE5lMDUdYHrYBpFTSAz7ibfbrurBB5J
         hMD+qP5qptgVaZ8f3O0m3ptbjUefEufrLNyQHh5ZPqxiY61Dymv28+rjf5w2QpypJqZ2
         DRXiWlKBMdMgoimdqTS323/uVW8tX+CCEbM7nHjumUtDnwysiptRFJQPBpx/TOrfUAXX
         3M52fGNx3hlBOiaCnLHQ1P4xqk/TqN5QwJp7q1tzsZi0OKE+bN8NwYRuM5igZQuHceu0
         iehA==
X-Gm-Message-State: AOJu0Yx+WEJ3dibeC22Up8vjlN5nS57ZZVfWM7rf1uHh++cJiwN+ZbZp
        FLZC7haIQjqacKbOGBXOIo+EiVkMoO5cwecGWBaYT5OSzSqt
X-Google-Smtp-Source: AGHT+IGFt2/DGjfuD8g7w+zltENZ+tJGOW79oCyv49p0OKQfhDgbLtstLWHD8wZfqIVCeXLT3TMuamCtQy1cHE/sONREKAZOrt3P
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5b2e:b0:1d5:9c14:99c8 with SMTP id
 ds46-20020a0568705b2e00b001d59c1499c8mr1933940oab.10.1694904388474; Sat, 16
 Sep 2023 15:46:28 -0700 (PDT)
Date:   Sat, 16 Sep 2023 15:46:28 -0700
In-Reply-To: <000000000000997319060049b1e4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000df89060581ae9e@google.com>
Subject: Re: [syzbot] [net?] [wireless?] INFO: task hung in
 cfg80211_event_work (2)
From:   syzbot <syzbot+85f0eb24e10cec9b8a10@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kerneljasonxing@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has bisected this issue to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1411bef8680000
start commit:   727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1611bef8680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1211bef8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c13b5305ee70d27
dashboard link: https://syzkaller.appspot.com/bug?extid=85f0eb24e10cec9b8a10
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15913b90680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156720a8680000

Reported-by: syzbot+85f0eb24e10cec9b8a10@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
