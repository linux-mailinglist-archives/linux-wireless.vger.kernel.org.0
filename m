Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FDD36C532
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 13:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhD0Lgy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 07:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhD0Lgx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 07:36:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C36C061574;
        Tue, 27 Apr 2021 04:36:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h11so1513874pfn.0;
        Tue, 27 Apr 2021 04:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IUY3136rBJHpdsy9gPF9r8TyfY75qqRWpCu4OCSUOq8=;
        b=bG/0/0eul04k7Doe4nJU88gQzunUd9A7KmdMfs0AhebThhMuiODFaYVfGwDMhH0pa8
         WZzQj1mQBTkC+0SAZok5cEUaUhYuPL7qo/5zk1o4DoEzLxpIR4vREk+R0GHBqenhzfnV
         L8i1MC9XqjVaqSyxI9k7sZQ6fTVw40/HgnjW9k5IQUnc0LprXZ3GOHMzEQXSi/zy4HLC
         jXl+nglVnNwTQ8NbdZU1cbsLdbYOvaBPKnx5God93EaIPi0FY3rgjCcGeqjbugmCoD2/
         3dRRAu6lGMSNk4zwHXNHbjC/JM2+x/StNXgcbwzUfJ5oqJjZ1+BeFZ3uMAiBjphsuejr
         X/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IUY3136rBJHpdsy9gPF9r8TyfY75qqRWpCu4OCSUOq8=;
        b=ZscWcNW2PPik5eEACBWZsNf6ROMzZVGNPbPedHXpJf7JvLSRsOsRvHMjW1bWfQMvxJ
         ABKcn6JPwQPyE06MEer1ppivYCTRqb/f39uB9JXuweGgwNU4mQBY+cQ2GnKK2ZzPoNXn
         US4DLycqJPwwJFMb/mMWtijthNmwcOQjtbhuVs1OnwQBQcP4rNxOsdQs6Wn/PRy8nhA4
         dy+zhcXrLdXCVVwKuqJ679bYpJizQpc9llvsBpsuGuH82Gy0zzhxB95FFvon4meHcN1n
         czWT6PH64TYfJofq7cd2bP/B0MnDzfIAveEY49o05lkyhKXOMAQdHhKlChXuvZjY9QxP
         WigA==
X-Gm-Message-State: AOAM532aGiGR9XO9m1QbLrwLIpjHEwkQlWh1/xqSHiXr4SrnYHxl7Hmn
        NNSh1kvmcP8Y2FbB/258JYI=
X-Google-Smtp-Source: ABdhPJxhLOOyz8sHhOudu4oWpIBS9v6uWoB1Y11kfFa0J1ct2QY3nMIGqEORflL0FNyuCiMwlqowyA==
X-Received: by 2002:a63:be08:: with SMTP id l8mr10314932pgf.438.1619523369049;
        Tue, 27 Apr 2021 04:36:09 -0700 (PDT)
Received: from atulu-nitro ([2401:4900:2328:eaea:1419:503d:c39f:5ab1])
        by smtp.gmail.com with ESMTPSA id mr3sm2100856pjb.20.2021.04.27.04.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 04:36:08 -0700 (PDT)
Date:   Tue, 27 Apr 2021 17:05:59 +0530
From:   Atul Gopinathan <atulgopinathan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, brookebasile@gmail.com,
        ath9k-devel@qca.qualcomm.com, davem@davemloft.net, kuba@kernel.org,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: Memory leak in ath9k_hif_usb_dealloc_tx_urbs()
Message-ID: <20210427113559.GA7527@atulu-nitro>
References: <20200911071427.32354-1-brookebasile@gmail.com>
 <20210330193652.10642-1-paskripkin@gmail.com>
 <YGQWf1lP4ZOUFiG5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGQWf1lP4ZOUFiG5@kroah.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 31, 2021 at 08:28:15AM +0200, Greg KH wrote:
> On Tue, Mar 30, 2021 at 10:36:52PM +0300, Pavel Skripkin wrote:
> > Hi!
> > 
> > I did some debugging on this
> > https://syzkaller.appspot.com/bug?id=3ea507fb3c47426497b52bd82b8ef0dd5b6cc7ee
> > and, I believe, I recognized the problem. The problem appears in case of
> > ath9k_htc_hw_init() fail. In case of this fail all tx_buf->urb krefs will be
> > initialized to 1, but in free function:
> > 
> > static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev)
> > 
> > ....
> > 
> > static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev)
> > {
> >     ...
> > 	list_for_each_entry_safe(tx_buf, tx_buf_tmp,
> > 				 &hif_dev->tx.tx_buf, list) {
> > 		usb_get_urb(tx_buf->urb);
> > 		...
> > 		usb_free_urb(tx_buf->urb);
> > 		...
> > 		}
> > 
> > Krefs are incremented and then decremented, that means urbs won't be freed.
> > I found your patch and I can't properly understand why You added usb_get_urb(tx_buf->urb).
> > Can You explain please, I believe this will help me or somebody to fix this ussue :)
> 
> I think almost everyone who has looked into this has given up due to the
> mess of twisty-passages here with almost no real-world benefits for
> unwinding them :)

Just wanted to confirm, what is the status of this bug then, as in is it
invalid (not sure if that's the correct word)? I happened to stumble
across the same syzkaller bug report Pavel posted above, in the morning.
Saw that there has been no patch tests/fixes on this yet according to
syzkaller. Spent a couple of hours going through it before sending a
test patch to syzbot which returned an "OK" (and the patch is exactly
what Pavel pointed out, I simply removed the `usb_get_urb()`). Before
sending anything to the mailing list, I made sure to search all the
relavant networking lists to see if this topic had been brought up (learnt
to do this from my preious mistakes of sending already accepted patches) and
luckily I found this.

Syzbot has had 380 crashes caused by this bug, with the latest being
today. So I wanted to confirm what should be done be about this bug. 

Thank you!
Atul
