Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AA3754736
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jul 2023 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjGOHWZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jul 2023 03:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGOHWY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jul 2023 03:22:24 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704DE2722
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jul 2023 00:22:19 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b9ca98ff25so335754a34.2
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jul 2023 00:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689405738; x=1691997738;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deZLZrvEZSfc6NLa+Id53ZoNS1q+sg7vXw6lADs5UZc=;
        b=gylbLvHVjxMp1NbGxreq9d58raJCdLaAj2VqmTgPn4eoCzkODVutI9f7GWkyXtIepF
         s8FdaafGAL9BBy7Q2PRzHTkpox18zwWIFNVekTD6EwqAuiFBRHh+ZLwInBbN+RmE/I6P
         8xsTSppCVn1cCRX7rylh+cwdq5Wd/tQWZIy8PAfSgFJYjYEDkTcBjsscRSIOxlnqIt0L
         KpGn1p6TdoKXlHpNn97fysmBTqKwTXKzkCjE3IXt4fuPLajgoNjvj1JcWcn/oNNkMZR3
         iDBonaGhoP1FdyuBOIsYs3PE2TqUIMI9KwcHWnA6njVne4VSY1wcINJWCx83TJrnep+y
         Zlvw==
X-Gm-Message-State: ABy/qLZ2A5dnghMZlcGQM+0Ow6KiM/iOZurfh+vMRjn4w8Rz/5rkh7Ii
        1e/0Jb+lnzsylpMCSGj40Tb0oeNX8QToGPQf68FSJT16PfR2
X-Google-Smtp-Source: APBJJlHH3FSfjH01K1UTktigpFdlK7JuDCmmfNBSiY8NRr4eGW+fSxrKOo/LJfiNFaYQXY2HWu5EgCuMiPB05g3I5MvkoHyT3gES
MIME-Version: 1.0
X-Received: by 2002:a9d:7406:0:b0:6b7:4ec4:cbb1 with SMTP id
 n6-20020a9d7406000000b006b74ec4cbb1mr5640443otk.7.1689405738355; Sat, 15 Jul
 2023 00:22:18 -0700 (PDT)
Date:   Sat, 15 Jul 2023 00:22:18 -0700
In-Reply-To: <0000000000000de35905ead6dcc1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea91fa0600816cb8@google.com>
Subject: Re: [syzbot] [afs?] general protection fault in skb_queue_tail (3)
From:   syzbot <syzbot+160a7250e255d25725eb@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        kuba@kernel.org, kvalo@kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, pchelkin@ispras.ru, quic_kvalo@quicinc.com,
        syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 061b0cb9327b80d7a0f63a33e7c3e2a91a71f142
Author: Fedor Pchelkin <pchelkin@ispras.ru>
Date:   Wed May 17 15:03:17 2023 +0000

    wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12253b7ca80000
start commit:   98555239e4c3 Merge tag 'arc-6.1-fixes' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=701f2aae1cb0470e
dashboard link: https://syzkaller.appspot.com/bug?extid=160a7250e255d25725eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1482f0b6880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119e4dce880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
