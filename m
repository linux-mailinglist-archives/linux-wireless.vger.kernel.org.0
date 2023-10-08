Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAE27BCF4E
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Oct 2023 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbjJHQ5a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Oct 2023 12:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344924AbjJHQ53 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Oct 2023 12:57:29 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9247B6
        for <linux-wireless@vger.kernel.org>; Sun,  8 Oct 2023 09:57:28 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e1dc572fbeso6152468fac.2
        for <linux-wireless@vger.kernel.org>; Sun, 08 Oct 2023 09:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696784248; x=1697389048;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0OpDAngG10xpmhVSxqYUkvqTPKRTSFUJShfAHatMwg=;
        b=eweiwFL0/LZR//EA+g+RT6/OFYVk0MUnNEXTEkoIWFUuLnG0BGjfeE88iFUAgGWjiS
         gliAuGFZ7GQmQSk3QqEoSk6w0KL8mMX0m8AHUI8kuLtu81GhINQT4nJ22V2IPntsz1PW
         L/g8WAN4z8PaoOHabhYqdIC1/FJqeLm5YXX0sgJJF7llusum2XkzIKl78SfEP/rF6x9h
         cujfNCHeUZRAQzWs8dhvkCBadZbRsUCsHWD3yzcbJIn6ATR0C7vNOEZRNWdzMHQp3KCQ
         QrdCIrBQ2jj7ND+kforDxqij6DXSxaQoXZJVXmEMW6lK/0nTNPm1s26gcYTdMzESIsme
         E5sQ==
X-Gm-Message-State: AOJu0Yx9BXSfYxa9Z1E019hdLzBnxJaebpOiXCC4y+u75ya4hP6BPt1a
        8+KeTZZw5mwK2LeP0kGvEd82G20W1AuqMz9xfeBfB+1zrToL
X-Google-Smtp-Source: AGHT+IGNcEiyFDgDYD7nh8JVTo7bGNGHXpMgWzyPRnf99gRX7e4Lt8LB8Qc28HMJTdaAFFi5OEXyWxgCeH6wR0WotHyC+ZOJnxz5
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1b8a:b0:1e5:7dbf:c2d5 with SMTP id
 hm10-20020a0568701b8a00b001e57dbfc2d5mr3290437oab.4.1696784248369; Sun, 08
 Oct 2023 09:57:28 -0700 (PDT)
Date:   Sun, 08 Oct 2023 09:57:28 -0700
In-Reply-To: <000000000000d730410602d76cf6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006278b30607375e8f@google.com>
Subject: Re: [syzbot] [net?] [wireless?] INFO: rcu detected stall in cfg80211_wiphy_work
From:   syzbot <syzbot+b904439e05f11f81ac62@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        jhs@mojatatu.com, jiri@nvidia.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, pctammela@mojatatu.com,
        syzkaller-bugs@googlegroups.com, victor@mojatatu.com,
        vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit da71714e359b64bd7aab3bd56ec53f307f058133
Author: Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue Aug 22 10:12:31 2023 +0000

    net/sched: fix a qdisc modification with ambiguous command request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e978e9680000
start commit:   cacc6e22932f tpm: Add a helper for checking hwrng enabled
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=b904439e05f11f81ac62
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a49fcda80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136f8679a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: fix a qdisc modification with ambiguous command request

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
