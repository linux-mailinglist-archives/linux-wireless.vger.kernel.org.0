Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4A258D311
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 07:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiHIFFT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 01:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiHIFFQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 01:05:16 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF54D91
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 22:05:15 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id h8-20020a6bfb08000000b00684f0587d0cso1757556iog.14
        for <linux-wireless@vger.kernel.org>; Mon, 08 Aug 2022 22:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=qUzj7rWhLGlDQzF8thFJBaPTyzvuhS4YOtcqLhUFOLs=;
        b=vJ9u7xl6HS9Fc6ruXi4tzxDIyi1BqYw4tjx7hM4w7gvuFuWviCX9UpwLt2FYX7d3Me
         NdcK7195JQCrfEQIkr1vWaLce2vQMdUa68vq/dB0lZtYqwPTGxoT6IEcBc+op/DKZEpN
         6dl/GbozueiBN98xz7BtHSnXYUaD1xMuRaGpMbHDJtP/Pd21eP9DV9qDjwhLTyOr6OrD
         a4/Cl0YpPLCSovgpV2ua+40PIBFbP63jLVXweoWWNkcTYPMo6I8Pcw1WF7Zi7BarHRzE
         nlDZrcPd9D0+7PdcY2BBnwCZJRddbi9zHMo1yxwMNFLFMqBzFd4+KXjk489ocshAJq4y
         y4pQ==
X-Gm-Message-State: ACgBeo07IXhsviQPYH9e73ZeGxUXVRx9W74ZhXYKr0uYlZZz9xBl26vE
        lqLcS5Ks2VzoaiL/hjKCFzcEkylT5YWw+KhSBlCqOYz22wQ2
X-Google-Smtp-Source: AA6agR5aIg7EG5tXDrRBXY91bjwDVFTlTStKPPlUOZ01fdT3atbXH2xDpCmUABiiS8AOM2W3io5UvxFVHYr9g5xTSjShCrM8MkT7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:2de:e162:c5bb with SMTP id
 u1-20020a056e021a4100b002dee162c5bbmr9825959ilv.102.1660021515241; Mon, 08
 Aug 2022 22:05:15 -0700 (PDT)
Date:   Mon, 08 Aug 2022 22:05:15 -0700
In-Reply-To: <000000000000cad57405e5b5dbb7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc500505e5c7e01f@google.com>
Subject: Re: [syzbot] possible deadlock in p9_req_put
From:   syzbot <syzbot+50f7e8d06c3768dd97f3@syzkaller.appspotmail.com>
To:     andrei.otcheretianski@intel.com, asmadeus@codewreck.org,
        davem@davemloft.net, edumazet@google.com, ericvh@gmail.com,
        fgheet255t@gmail.com, johannes.berg@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux_oss@crudebyte.com, lucho@ionkov.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has bisected this issue to:

commit 54283409cd162fc60480df514924ed4cb313735e
Author: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Date:   Tue Jun 14 14:20:04 2022 +0000

    wifi: mac80211: Consider MLO links in offchannel logic

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1046e22a080000
start commit:   ca688bff68bc Add linux-next specific files for 20220808
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1246e22a080000
console output: https://syzkaller.appspot.com/x/log.txt?x=1446e22a080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=50f7e8d06c3768dd97f3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f6ea66080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1640de8e080000

Reported-by: syzbot+50f7e8d06c3768dd97f3@syzkaller.appspotmail.com
Fixes: 54283409cd16 ("wifi: mac80211: Consider MLO links in offchannel logic")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
