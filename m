Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA75EA821
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Sep 2022 16:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiIZOO2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 10:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiIZONs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 10:13:48 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598261822DA
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 05:24:20 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id b9-20020a6be709000000b006a469cf388eso2702648ioh.19
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 05:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=u25rEeokQPPBefAKi6INDDiXFGPGGD4GJZGsMNXA1Sk=;
        b=F8sarK6CRnqmhyjOe+hDgPpj4QBsVbFr3FsA2Onz64SzlF5vXjmeC/w6OzN1Rkcx+l
         0mu/fq8xOi9gw/TM/2J9t8AHJXR44kLCMMUXXvlc9J+Ip+BoFq4gqXaHEcRkIlaO2Rst
         iE2Bn69Avui26bR5MJfaGWtTv3yCpswWxb4qrAooqLX+2Sv0gA2qaPx5KouBoqnaQAD/
         sJqDcKerQ4oFMFoGa+2UO6d4WTQRMSTfCvKN6K5q7Hg6BJo0bYD+3/snLUVNoLZkhgGQ
         bOnh76l83Puy6GdKwTsvkzGY1c0B7WH1YV9KBvE/SgniRCqvfO1NaFbSkL02GkxFj4+w
         WW+Q==
X-Gm-Message-State: ACrzQf1/YVUnHgHWA9Ew8qk8a5+0YyPQ0TWMS5tlut/9Cb/16EEO4D79
        r90HpAWVP3ycabdxh0HyqY6lDeEoQe9ScE47ikMQgvCxwQgm
X-Google-Smtp-Source: AMsMyM4V5W+/9GChVpBuWF5zPe6CNtlotcDxQpXmpyDrz/jXC7xVU0bsnOKzdU3v/Q6iho/N3rhSAA4eNlS1QHDXqjnuh7T3R6Eg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154c:b0:2f2:f8c:5b54 with SMTP id
 j12-20020a056e02154c00b002f20f8c5b54mr9835914ilu.134.1664195059375; Mon, 26
 Sep 2022 05:24:19 -0700 (PDT)
Date:   Mon, 26 Sep 2022 05:24:19 -0700
In-Reply-To: <20220926115901.4941-1-yin31149@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059e49c05e9939b85@google.com>
Subject: Re: [syzbot] WARNING in wireless_send_event
From:   syzbot <syzbot+473754e5af963cf014cf@syzkaller.appspotmail.com>
To:     18801353760@163.com, davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, keescook@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+473754e5af963cf014cf@syzkaller.appspotmail.com

Tested on:

commit:         aaa11ce2 Add linux-next specific files for 20220923
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1490566c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=473754e5af963cf014cf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162cc9e4880000

Note: testing is done by a robot and is best-effort only.
