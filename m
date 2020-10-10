Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA9A289D01
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Oct 2020 03:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgJJBVP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 21:21:15 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199]:47543 "EHLO
        mail-pf1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbgJJBF3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 21:05:29 -0400
Received: by mail-pf1-f199.google.com with SMTP id e7so8055989pfh.14
        for <linux-wireless@vger.kernel.org>; Fri, 09 Oct 2020 18:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=DDEseMxMpm+8pa9N0R0ZiF/fCUt6kdwa1OOWpeK33r0=;
        b=AG+2LWs2Wq6JnhphWuIrqJ+Tbxr2lTJfAhFIseDJEUMYYbq2cNTvfX/gbbZLL3bb+E
         C/u1vSKFBFykRnDZlWNmGmqu7Tmj2+DXPp6gB+6N0cezJIG+HcvJIegqY2huA+lOezqP
         BTkoUrABtHQJUh3U1dqs1z5ZLkqshJiYHFwtLPAvPI5PcxvletSAVTQmwAZ4lpfrOEXZ
         tke673y++ztegXbbyLB54s1DrnJQIWiDzCVlEmi7qjhvg2MmmJo35COBvOVTVuVu1qhd
         0hJqxY2FEUWjS+O4TWwe4aMBl91iGbfb5vGubCbDGQvTxBaMmIspx+vzJSAT9KYyYswO
         wXzg==
X-Gm-Message-State: AOAM533drsyoO0Jws9ub9naPJt2/bxT5GhYhcS+X5v/kA8pJF5Pm1VZw
        9KCJVuxz/znosomgBKoama+JGE3h8Fw4tJqojo0NqLQrzeGI
X-Google-Smtp-Source: ABdhPJwpfQNcKTazaWHy8QlWB9Y2DbphQW9rWJEsyRGOF2rnSosmcJqpeOxXfurwX5byo3kvylWCHJvvHUPE+AYPC4qGeVPsiN8a
MIME-Version: 1.0
X-Received: by 2002:a92:360d:: with SMTP id d13mr10658529ila.99.1602291369987;
 Fri, 09 Oct 2020 17:56:09 -0700 (PDT)
Date:   Fri, 09 Oct 2020 17:56:09 -0700
In-Reply-To: <20201010004944.GB557008@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef564605b1468771@google.com>
Subject: Re: WARNING in hif_usb_send/usb_submit_urb
From:   syzbot <syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, ath9k-devel@qca.qualcomm.com,
        eli.billauer@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/net/wireless/ath/ath9k/hif_usb.c:1319:7: error: implicit declaration of function 'usb_find_bulk_in'; did you mean 'usb_fill_bulk_urb'? [-Werror=implicit-function-declaration]
drivers/net/wireless/ath/ath9k/hif_usb.c:1319:24: error: implicit declaration of function 'endpoint' [-Werror=implicit-function-declaration]
drivers/net/wireless/ath/ath9k/hif_usb.c:1321:7: error: implicit declaration of function 'usb_find_bulk_out'; did you mean 'usb_fill_bulk_urb'? [-Werror=implicit-function-declaration]
drivers/net/wireless/ath/ath9k/hif_usb.c:1322:46: error: expected ')' before 'return'
drivers/net/wireless/ath/ath9k/hif_usb.c:1357:13: error: expected ')' before '}' token
drivers/net/wireless/ath/ath9k/hif_usb.c:1358:1: error: expected expression before '}' token


Tested on:

commit:         549738f1 Linux 5.9-rc8
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.9-rc8
dashboard link: https://syzkaller.appspot.com/bug?extid=f5378bcf0f0cab45c1c6
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1200b51b900000

