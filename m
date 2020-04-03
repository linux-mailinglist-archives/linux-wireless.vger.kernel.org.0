Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA0619CE78
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 04:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389919AbgDCCHF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 22:07:05 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:49868 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbgDCCHF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 22:07:05 -0400
Received: by mail-il1-f198.google.com with SMTP id 75so5367539ilv.16
        for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2020 19:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7J/k6eEvJIq17JOSR8idMeCvoHGU5sGu3VSOhnubzmQ=;
        b=Hg/nLFWyjrmINSADNjzfZcd2BLzrS6Zy6Kg0es41f8P9gVy1uLxuYNZAbBdpn9WskN
         lew8Nx0+53o5WtJKVtrrsun6Glp8ZJg5a1QlJpSE9xRFEid1PuxDfQe7AYhkfRigiFLo
         tYf8S/oBilLIQkZbXO+PlfBMQFsN0D17gMo2JVkweifn7X+8dnn5jVUraJ5QFJoVVn/Q
         jgNWdtweXyB9Vfray7sex8byNoZhKS4pPCBlyqtYSOgLb4vjVDsKV1V60Y2n+yoe2ljy
         qJxAED3knyTsFOq4YcBzN0cGJW7rGSsPf1ESYt+y71qcCNYElREzSmGqEXfGpmeScziK
         XLrQ==
X-Gm-Message-State: AGi0PuZEwePD1+Eo0LLnwdsOIwoBiNwNabPS8F7lylNA3rZhnf5gvyno
        3df/638otalP7kCD1VJ39itstOuBvtGMwh8wR4csE0vEzhEX
X-Google-Smtp-Source: APiQypIAlBCMDIO8Mp11ihUP2Aa0Ng3EkKSMlaylNoj+IQZ2XoML5J9qeSvuWJ7dpt7NnOEllOT2e+Bk8VEnYuPTEsrmo2SdkbZx
MIME-Version: 1.0
X-Received: by 2002:a6b:dd14:: with SMTP id f20mr5790683ioc.123.1585879624594;
 Thu, 02 Apr 2020 19:07:04 -0700 (PDT)
Date:   Thu, 02 Apr 2020 19:07:04 -0700
In-Reply-To: <CADG63jC06pj4pSrKMKQeK1pedyRnjNTWWmTzg-6rNbQh5c6=Ug@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae3c0205a2595fc4@google.com>
Subject: Re: KASAN: use-after-free Write in ath9k_htc_rx_msg
From:   syzbot <syzbot+b1c61e5f11be5782f192@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, anenbupt@gmail.com,
        ath9k-devel@qca.qualcomm.com, davem@davemloft.net,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+b1c61e5f11be5782f192@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=a782c087b1f425c6
dashboard link: https://syzkaller.appspot.com/bug?extid=b1c61e5f11be5782f192
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=172383dbe00000

Note: testing is done by a robot and is best-effort only.
