Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15717F2B06
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 11:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjKUKzJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 05:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjKUKzI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 05:55:08 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBE195
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 02:55:04 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc385e90a9so60722675ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 02:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564104; x=1701168904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MucVPlPO96ILTl/BV8ROPTsisZcP2/vhsy4x7IWNNfc=;
        b=CcEHQAuXxEFd51hm6DEF2qt6gW4D+KvlFdmWfD15EjgquUAKa2++2/keyAtmsse+VZ
         IS+UHhHvhp1aqhfjpR/YR7uInpewEthP16GQ/QSjJhk8M/ibYwX7OpMEEQMFoDTzXB0y
         79bpO1stb7b9US/iKmfifUq+hmr0wXG3rDrGeoTRktzbhc3WtZkhhy8kW3HvLyk8oymW
         7o5/ewZi3qy4SH64cMyfARDUApXspxbRB33E7HK5yG//i/hckhkIdu/jFqK/xn8aO7dS
         w3Z84p+s0pNRnidxKZSsV51YuZoRiUJiA4osIaZ8BueYWfDBMsPT9uUYBWwK/CDRARny
         eG+A==
X-Gm-Message-State: AOJu0YxnDC51xkISdWLvbCUSpNvMpXEpEY+V7VM/2X5tHd5szpyoyam4
        SrrNoEvAdFuYYvhVp7TMuce6spvnOOt2KKDFIXTT2tCNnGfc
X-Google-Smtp-Source: AGHT+IG8ioXPYyO1oJsiFIQ7AFgEZu9Y+SvUceib759BZiDwK4pCkyKZ9Fnjg0bhNBDSdS8gRMqei0g4IcW2h6EnHa/2dyw3Kq/b
MIME-Version: 1.0
X-Received: by 2002:a17:902:9304:b0:1cc:20dd:8811 with SMTP id
 bc4-20020a170902930400b001cc20dd8811mr2954783plb.5.1700564104429; Tue, 21 Nov
 2023 02:55:04 -0800 (PST)
Date:   Tue, 21 Nov 2023 02:55:04 -0800
In-Reply-To: <000000000000959f6b05ed853d12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ccaa8060aa76f91@google.com>
Subject: Re: [syzbot] [net?] [nfc?] INFO: task hung in nfc_rfkill_set_block
From:   syzbot <syzbot+3e3c2f8ca188e30b1427@syzkaller.appspotmail.com>
To:     brauner@kernel.org, broonie@kernel.org, catalin.marinas@arm.com,
        davem@davemloft.net, edumazet@google.com, faenkhauser@gmail.com,
        hdanton@sina.com, johannes.berg@intel.com,
        johannes@sipsolutions.net, krzysztof.kozlowski@linaro.org,
        kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nfc@lists.01.org,
        linux-wireless@vger.kernel.org, luiz.von.dentz@intel.com,
        madvenka@linux.microsoft.com, netdev@vger.kernel.org,
        pabeni@redhat.com, scott@os.amperecomputing.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 2c3dfba4cf84ac4f306cc6653b37b6dd6859ae9d
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Thu Sep 14 13:45:17 2023 +0000

    rfkill: sync before userspace visibility/changes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d68677680000
start commit:   ae8373a5add4 Merge tag 'x86_urgent_for_6.4-rc4' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=927d4df6d674370e
dashboard link: https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1099e2c5280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113f66b1280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: rfkill: sync before userspace visibility/changes

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
