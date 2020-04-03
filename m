Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2305919E12A
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Apr 2020 00:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgDCWpF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 18:45:05 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:56708 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgDCWpF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 18:45:05 -0400
Received: by mail-il1-f197.google.com with SMTP id 191so8458826ilb.23
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2020 15:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zSmQHMpVTPuNbvjhNgH4TOFQnalp5wC6Xun5Vz1zvC8=;
        b=YQ57CGMKRElEphAIY29pzqwqA4opWsEb0LKNL/L9kpNvZ0YgZeNvFp7xhacLtLuXVF
         I79Ox6cHvI1spW9xHCcTpLKmR/TukiQ0Ej/+KGWrtdHaZ+NItXt3lBY+ExIVqR5XvuQb
         5KY7RHVlD4oQy+1Pgh/J9QKUelc0HQNKyOoE4GG82x3sxMVefpI2g8ZteBsRjstNAfEv
         kfF3O0NuKjN7wwo5WdPTl6JnomvRU0RzZoHxzoskAGM4BShx//ZfAxa7Ci1Mqi0wCABh
         XywX1ysC2dEs+fcxqtqEyKIeRz3Tgu2VlKXT5zlq5aPa77q6ETTPvMQ1AAHPvjF6nNIc
         DYzg==
X-Gm-Message-State: AGi0PubxS+pYVf8mwUUAClCiNQDNDImeqFRozutKvKywxBCDqiWkpDI0
        UGcDgDacNud9fabfhaHqq3Wf0S/ASogiis1Oam2cTQUhoOuW
X-Google-Smtp-Source: APiQypIKDmUyBf9guvJkvEFIs6BXHK+tEO0WOLsZVEYo5TOyYoc094K76H4pzciRloGviGw2V0QWvIABWL18PjwKEBogYoICkj7b
MIME-Version: 1.0
X-Received: by 2002:a5d:9e4d:: with SMTP id i13mr9625291ioi.43.1585953904624;
 Fri, 03 Apr 2020 15:45:04 -0700 (PDT)
Date:   Fri, 03 Apr 2020 15:45:04 -0700
In-Reply-To: <CADG63jAuwRJ4uRH2qUGgqPP+Cjq0w7PrKziU4G3jWS3K4wpJog@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d8c7d05a26aab0c@google.com>
Subject: Re: KASAN: stack-out-of-bounds Write in ath9k_hif_usb_rx_cb
From:   syzbot <syzbot+d403396d4df67ad0bd5f@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+d403396d4df67ad0bd5f@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=a782c087b1f425c6
dashboard link: https://syzkaller.appspot.com/bug?extid=d403396d4df67ad0bd5f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bd0cfbe00000

Note: testing is done by a robot and is best-effort only.
