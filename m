Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111DD36C69D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 15:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhD0NCZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 09:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbhD0NCX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 09:02:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A073C061574;
        Tue, 27 Apr 2021 06:01:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f6-20020a17090a6546b029015088cf4a1eso7162650pjs.2;
        Tue, 27 Apr 2021 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q5RUesMH4DQNnV2BkXZ2yC6yQXV00pdjVgHeKiuGJE0=;
        b=gmUMMFfBjgP8EA0PckXp8dO57/8mgCkeNipSLmoTZVeJ/AeNPC/TyKAHv7fn6UF/ln
         hDe0FCWXF0s6jyaw8owoD7/XaCitT9cHbvNyo05rYIEcmLpiGFWPnIztokj3zAQa+AMh
         0dJRYOg3c1uSOjaS6dn19YqNifpBT0nJkDNwqSwKa68yyQ3JKULOOBXQyEwOpH12/J3B
         h3hRNJ1tsRsRdhkqOC3URB0kT9AgjYNIAPBY8Rlc41Uex0krj8AW7F6rbcAnfKWRR3dF
         DnlGHA3czu17oTc3GQXbsLb6tkv5HK6y6scAeOMG0eoEAvpiXikbIn2sbkYfg13/JlaG
         u8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q5RUesMH4DQNnV2BkXZ2yC6yQXV00pdjVgHeKiuGJE0=;
        b=RvH7VM7HOOoqfBSNKUR31JIWlZqCiul3CRE6DzeeXfNeXlUUdtqZtiTR4Oy/NNW/kN
         QvYKB+MiS2q6Tjspu8bL0mFccX1YufQa8GOrhfyMO7TxGdF9dgVyRYdN0QoR+ND9WLoY
         /3pZgRfFwTCtTb2Jscr9mq6Cre9XQS3djlNC/yzt484wMeQVb4RqtK6AToBQ+AvQ5EmQ
         0sExoIF99gYRZY+odSscXGD0AAg8wwzIt8K0MquSrmYS20KXKbrxvD9XHP7+VudM0I1k
         Lfc/IomOdHjepcr6GwHIZE8WBfxrbwhyTUSRXLrZB9dKx4lEIWB6DT+nIdPL4YpcmUUU
         OI3w==
X-Gm-Message-State: AOAM530Rl47Eg66DfeGxQ6AXU4gxGeKudBxP/UrwQ/ErxndhnaWeIQ4j
        7a9SbXZZ4tMjLJvUHk47ulQ=
X-Google-Smtp-Source: ABdhPJxffQLh9NPf+3ufyiBFRyLapuFpTEHBvbVVrYDMrzKlQBsBAgTaKV1g6Lzbr17od17Fm4NOkA==
X-Received: by 2002:a17:90a:7185:: with SMTP id i5mr4819171pjk.92.1619528489856;
        Tue, 27 Apr 2021 06:01:29 -0700 (PDT)
Received: from atulu-nitro ([2401:4900:3606:10f7:c9d1:7367:d344:d254])
        by smtp.gmail.com with ESMTPSA id y1sm13677915pgl.88.2021.04.27.06.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 06:01:27 -0700 (PDT)
Date:   Tue, 27 Apr 2021 18:31:19 +0530
From:   Atul Gopinathan <atulgopinathan@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, brookebasile@gmail.com,
        ath9k-devel@qca.qualcomm.com, davem@davemloft.net, kuba@kernel.org,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: Memory leak in ath9k_hif_usb_dealloc_tx_urbs()
Message-ID: <20210427130119.GA3288@atulu-nitro>
References: <20200911071427.32354-1-brookebasile@gmail.com>
 <20210330193652.10642-1-paskripkin@gmail.com>
 <YGQWf1lP4ZOUFiG5@kroah.com>
 <20210427113559.GA7527@atulu-nitro>
 <ec48c7d118a3093289907dc43f8dfb79d4879f7d.camel@gmail.com>
 <20210427152928.0871e17a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210427152928.0871e17a@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 27, 2021 at 03:29:28PM +0300, Pavel Skripkin wrote:
> On Tue, 27 Apr 2021 15:04:29 +0300
> Pavel Skripkin <paskripkin@gmail.com> wrote:
> 
> > Hi!
> > 
> > On Tue, 2021-04-27 at 17:05 +0530, Atul Gopinathan wrote:
> > > On Wed, Mar 31, 2021 at 08:28:15AM +0200, Greg KH wrote:
> > > > On Tue, Mar 30, 2021 at 10:36:52PM +0300, Pavel Skripkin wrote:
> > > > > Hi!
> > > > > 
> > > > > I did some debugging on this
> > > > > https://syzkaller.appspot.com/bug?id=3ea507fb3c47426497b52bd82b8ef0dd5b6cc7ee
> > > > > and, I believe, I recognized the problem. The problem appears in
> > > > > case of
> > > > > ath9k_htc_hw_init() fail. In case of this fail all tx_buf->urb
> > > > > krefs will be
> > > > > initialized to 1, but in free function:
> > > > > 
> > > > > static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb
> > > > > *hif_dev)
> > > > > 
> > > > > ....
> > > > > 
> > > > > static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb
> > > > > *hif_dev)
> > > > > {
> > > > >     ...
> > > > >         list_for_each_entry_safe(tx_buf, tx_buf_tmp,
> > > > >                                  &hif_dev->tx.tx_buf, list) {
> > > > >                 usb_get_urb(tx_buf->urb);
> > > > >                 ...
> > > > >                 usb_free_urb(tx_buf->urb);
> > > > >                 ...
> > > > >                 }
> > > > > 
> > > > > Krefs are incremented and then decremented, that means urbs
> > > > > won't be freed.
> > > > > I found your patch and I can't properly understand why You added
> > > > > usb_get_urb(tx_buf->urb).
> > > > > Can You explain please, I believe this will help me or somebody
> > > > > to fix this ussue :)
> > > > 
> > > > I think almost everyone who has looked into this has given up due
> > > > to the
> > > > mess of twisty-passages here with almost no real-world benefits
> > > > for unwinding them :)
> > > 
> > > Just wanted to confirm, what is the status of this bug then, as in
> > > is it
> > > invalid (not sure if that's the correct word)? I happened to stumble
> > > across the same syzkaller bug report Pavel posted above, in the
> > > morning.
> > > Saw that there has been no patch tests/fixes on this yet according
> > > to syzkaller. Spent a couple of hours going through it before
> > > sending a test patch to syzbot which returned an "OK" (and the
> > > patch is exactly what Pavel pointed out, I simply removed the
> > > `usb_get_urb()`). Before sending anything to the mailing list, I
> > > made sure to search all the relavant networking lists to see if
> > > this topic had been brought up (learnt
> > > to do this from my preious mistakes of sending already accepted
> > > patches) and
> > > luckily I found this.
> > > 
> > > Syzbot has had 380 crashes caused by this bug, with the latest being
> > > today. So I wanted to confirm what should be done be about this
> > > bug. 
> > > 
> > 
> > I saw on dashboard, that Dmitry tested latest upstream commit and
> > syzbot returned "OK", but usb_get_urb(tx_buf->urb); is still there.
> > 
> 
> I am sorry, I clicked wrong link on dashboard :( My bad.

Oh right, I forgot to mention. Just want to make it clear that the test
patch was mine. There was a bug in syzkaller, so when I sent the patches
for testing they returned a weird error. Dmitry later pointed out that
it was a syzkaller bug and was kind enough to re-send my patch on a
fixed commit of syzkaller.

https://groups.google.com/g/syzkaller-bugs/c/cBQP4fKjhFQ

> 
> I believe, You can test your patch on this
> https://syzkaller.appspot.com/bug?id=cabffad18eb74197f84871802fd2c5117b61febf.
> 
> usb_get_urb(tx_buf->urb) was introduced in patch related to this bug
> 
> > I think, this usb_get_urb prevents race condition, but I'm not sure
> > about it, that's why I sent an email to patch author. As You can see,
> > he has not responded yet :)

Ah that's how it is. Well not sure we could do much here. Also thanks
for clarifying things, I thought that no one had been looking into this
bug especially when it had so many crash counts which suprised me, but I
guess I was wrong.

Thank you!
Atul
