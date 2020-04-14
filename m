Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FA21A7903
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 12:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438865AbgDNK70 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 06:59:26 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:56482 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438846AbgDNK7E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 06:59:04 -0400
Received: by mail-io1-f71.google.com with SMTP id v3so14149385iod.23
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2020 03:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=B/wMlDlQPegcALh4XzxDXP3zbriJPXSUWAjVGj5HNW0=;
        b=jd2Hfzir+J0/nqcA+jqqXpHNJH6F3i+ivc93sXVbAsM3rc5CwQD7FHsvTnpGSyUFSw
         UgSHcPJrNHXgsBe2pgTtlPNbf0IODVX6H2tSLNhhakPM/0OJyQfsRQYOMKn4EHjIVZHM
         HMHLUZrL+9uvYKVso7tJidi0lGuohH8XEwII3/6s6gpbHolx9fD2qDGwkPzPTAsyaLXE
         M5ecuLXtg8jkk48mtlrnA0CMfMlady2ZjHf1WzbYFCyoU5GDKjtsxIlDumGvVeLVWnPE
         WRT/nNFiE5JYf7V1CCW58LkfmT8PVp7ebzgJiVHCwtV0OKUd11ErovG2oBMQQHACzI7s
         n6gA==
X-Gm-Message-State: AGi0PubG39Q6p5PRd97SHojNvC8IJXBR/MsHfsmCL/xD6nyVTDx7/j81
        San1ezEb85qnanhR0iR44nl7iN5yZWxdZZ/1YtK/AQGHsMNw
X-Google-Smtp-Source: APiQypKAhI/rash2i+SF7YvWdutz9ltcTt0CfD36FY1rEVx5Y6wMm1OewFDHN3vNTTAmI5vEiUVtkIEsNuYKCiBd0yNc3Rmw/p18
MIME-Version: 1.0
X-Received: by 2002:a6b:770e:: with SMTP id n14mr20446473iom.110.1586861943126;
 Tue, 14 Apr 2020 03:59:03 -0700 (PDT)
Date:   Tue, 14 Apr 2020 03:59:03 -0700
In-Reply-To: <66c3db9b1978a384246c729034a934cc558b75a6.camel@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d7e0f05a33e163e@google.com>
Subject: Re: WARNING in hwsim_new_radio_nl
From:   syzbot <syzbot+a4aee3f42d7584d76761@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+a4aee3f42d7584d76761@syzkaller.appspotmail.com

Tested on:

commit:         e154659b mptcp: fix double-unlock in mptcp_poll
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=5af684c50f30bcb2
dashboard link: https://syzkaller.appspot.com/bug?extid=a4aee3f42d7584d76761
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=144e124fe00000

Note: testing is done by a robot and is best-effort only.
