Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367B33838A9
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245284AbhEQP6j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 11:58:39 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:34717 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344202AbhEQPxX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 11:53:23 -0400
Received: by mail-il1-f197.google.com with SMTP id e7-20020a056e020b27b02901bb39f4204dso6738686ilu.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 May 2021 08:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Bb50Zij/ZQ0u6u9oKc6cWklyqcRI8Ff5LrMssH6nOJ8=;
        b=Olt87BNMJOEtWCym9MWDJDDfbbgvI/dp04u+KzAHVhN2mEHXPA7JLbHHPQu734Vtw7
         xrBHq1j+LEnh5V4g/vmmM73SVczq3tRe1AFGHMekw4t/r1sG2zfHXDF0WiGrw/odqRFd
         oCuYuXj+CMbSVxRfASryz50OCneK+6EmY10xSdEKaNWfVYbJC2jo9AlqWcQpyltEcS8b
         /pjj7ycWYlREMp3JV8ueDFbiTN8Y4JOLgt0xdxfwkr6tCPUhQOQq0DsHc4/4eKh7t4Xy
         bQGFrGAmSN2ZcY/eKs+v2D8tWLsSHjrg4vIAf+VIK1JnA6Sfdc+A2edmpQvsoBxTMsJK
         iTlg==
X-Gm-Message-State: AOAM533BlPNFw+C29++Sgnq3V4j1vsKJHkDE0e2bRIwvriTmXt9RTcC0
        zUkHSYgQJdIpdxKGvLu7u3KX1Snn5DI/Qcb2fsc5W5iCn9pS
X-Google-Smtp-Source: ABdhPJy5vrq9zj/8+hZroyD37mq1sLZeYoOiDmm9mayPRLuaxJF7ttN1x53NmLIzbTpKIfuFAB1v57FAX1m3fMmIRD6l++bx+0gD
MIME-Version: 1.0
X-Received: by 2002:a05:6638:a48:: with SMTP id 8mr690895jap.38.1621266725807;
 Mon, 17 May 2021 08:52:05 -0700 (PDT)
Date:   Mon, 17 May 2021 08:52:05 -0700
In-Reply-To: <20210517170429.b0f85ab0eda1.Ie42a6ec6b940c971f3441286aeaaae2fe368e29a@changeid>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000472e1005c2889371@google.com>
Subject: Re: [syzbot] WARNING in ieee80211_free_ack_frame
From:   syzbot <syzbot+a063bbf0b15737362592@syzkaller.appspotmail.com>
To:     johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a063bbf0b15737362592@syzkaller.appspotmail.com

Tested on:

commit:         d07f6ca9 Linux 5.13-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master
kernel config:  https://syzkaller.appspot.com/x/.config?x=81ee2b1d45eadfce
dashboard link: https://syzkaller.appspot.com/bug?extid=a063bbf0b15737362592
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158f811dd00000

Note: testing is done by a robot and is best-effort only.
