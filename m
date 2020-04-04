Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA9F19E2A2
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Apr 2020 06:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgDDEJJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Apr 2020 00:09:09 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:41748 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgDDEJH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Apr 2020 00:09:07 -0400
Received: by mail-il1-f197.google.com with SMTP id f19so9119871ill.8
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2020 21:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=diBIYrBkL43yhmYF0/S2uMZTr+kD81tZauofr3nRl24=;
        b=TIzzNp00uPxJsTTghZqqIUkXd2ALc4i9QYBPYBF31F0hh4l0TTZxQB4r97FN0VB4cv
         ijMwpaseAxa/R9wc7Tq7dNolRSoPD6tKFuw1sestW0MAZ62AmmIz8jUFwKNeUllWR2VL
         h3yyY8VLzA12KDwVY8cKSaG5wjOp5DrxFgHjWcXU3qLTqVNMvx3ElAfs5yIq6Z6Dctbt
         J0ifoOaGeZbKYBmIbblpZBMoyQZqBpWVRBwSsBHIPp6N4sxInsSZTTsfsHUJdTDjir7j
         MMu2O6Q+SyiSdKgQsFgS7h77pwTLu2XeA58ER6LbLxTDDDQC9TGa61K7OBrCggHf1d+E
         gfGA==
X-Gm-Message-State: AGi0PuZCNnbjCBpfGPEROzRKsRuSWAz5iLBfYr/NTj94KUJ6oFivsGpY
        i9SV0FakBdv/oU8oMbDWWPsXLDDvU1fS1fnGSOjxCWWJE3O6
X-Google-Smtp-Source: APiQypJ5efjfRCN5u7ZAYjDOHXe+DOFRnUU7zbwH7K1RJaIG4HFLng7f7L5dljhYeD3j82EhyOQlk1THoej8y+TkewC+4f/Gn6uz
MIME-Version: 1.0
X-Received: by 2002:a92:d108:: with SMTP id a8mr12182305ilb.107.1585973345184;
 Fri, 03 Apr 2020 21:09:05 -0700 (PDT)
Date:   Fri, 03 Apr 2020 21:09:05 -0700
In-Reply-To: <CADG63jDQEbMbmRsmQ=xVQyG_Gy=vqTYhFZ1J+3k1dTX_K75s6w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcf19a05a26f3110@google.com>
Subject: Re: KASAN: use-after-free Read in ath9k_wmi_ctrl_rx
From:   syzbot <syzbot+5d338854440137ea0fef@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+5d338854440137ea0fef@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=a782c087b1f425c6
dashboard link: https://syzkaller.appspot.com/bug?extid=5d338854440137ea0fef
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11646f93e00000

Note: testing is done by a robot and is best-effort only.
