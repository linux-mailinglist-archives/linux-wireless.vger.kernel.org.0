Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E500E327F1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2019 07:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFCFUs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jun 2019 01:20:48 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:54148 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFCFUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jun 2019 01:20:48 -0400
Received: by mail-it1-f178.google.com with SMTP id m141so25335131ita.3
        for <linux-wireless@vger.kernel.org>; Sun, 02 Jun 2019 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLqb9lzllH51vODwbKirEsKH2Zaem62+62kV1ROkpBk=;
        b=AuDvbJR+WQPLdfJ95q2QB4kr1wjZqpbRlfgEJ2k/jg6ey4Qz5EgaBXQ1j7gV39SKAn
         eoP00HQpDvbEt+ajoLB6kabXPL0llL99ikdbv8ZHd8+UxEgL1ciwSUVdko9NIGg74CSB
         JqLHR82cnNtAamTkNX80THJfnA4RaY/97+bXGybOKBfxL0HtIwgD+qjYBst+jIT+yeDb
         UU9EIMSIM++tPG8+HOunHKotL8MKGiSuP/KtYX0FnDIviZj5qDCP1SKbZg/YK1s5MNzp
         4X6Z04MjpOKVl3fMOIkdciMHMFWxf2hvqGuIYBFDeb11zOh08CKqWJ1aW2vQN6bLk2l5
         2y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLqb9lzllH51vODwbKirEsKH2Zaem62+62kV1ROkpBk=;
        b=JAHLws7k7VcPg8aX5TdTqGBgYXorFIt3Wo4ZhZUtGRPuNhdvvt+ot8SqqK6P7scxSB
         EnYf2vW3hUZ/2hlb9SPor2t9WxVhjf6tD/j2lVm6evszVnXWMzQFJWf26XfT1C3jYc2S
         qwl+Fht1p2clWPvFe6abKlQx9BYOi9n/iNJ7krrDq9BJsPR9ekZLVT3tkAeWoRnXmcRq
         I0U9mu1G2TRs3Xw7prz/oFH63sOYuQgMSWE1ZKTsyTh+j7eBcntP6pvkC1Jofj1pXwl2
         qKLIgcg1/DaALhqHXcN2c3HrhOdXgIiw0YGfwN8+j0hZSMcrHbVQRsFJ19h7EUxBSbHO
         vfuA==
X-Gm-Message-State: APjAAAXK3Rte4LjXU/R7opHiRBFWdwrGrC7/qq3efMYxB8LuxbOQ1WdG
        GLH6MOh9kWJggVd3nR6dmge3MonhNxcmyOmMyWixbA==
X-Google-Smtp-Source: APXvYqzcTIOOyY1SqkMZ7PLOyIMYJeR6UGPJ/82VlqIilUZqtVwvf4mcLy/2WuWN8lMk3O/Ef/H+g77Ik69S39VJ8d0=
X-Received: by 2002:a24:9083:: with SMTP id x125mr9248429itd.76.1559539246962;
 Sun, 02 Jun 2019 22:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000927a7b0586561537@google.com> <MN2PR18MB263783F52CAD4A335FD8BB34A01A0@MN2PR18MB2637.namprd18.prod.outlook.com>
In-Reply-To: <MN2PR18MB263783F52CAD4A335FD8BB34A01A0@MN2PR18MB2637.namprd18.prod.outlook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Jun 2019 07:20:35 +0200
Message-ID: <CACT4Y+aQzBkAq86Hx4jNFnAUzjXnq8cS2NZKfeCaFrZa__g-cg@mail.gmail.com>
Subject: Re: [EXT] INFO: trying to register non-static key in del_timer_sync (2)
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     syzbot <syzbot+dc4127f950da51639216@syzkaller.appspotmail.com>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "nishants@marvell.com" <nishants@marvell.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Jun 1, 2019 at 7:52 PM Ganapathi Bhat <gbhat@marvell.com> wrote:
>
> Hi syzbot,
>
> >
> > syzbot found the following crash on:
> >
> As per the link(https://syzkaller.appspot.com/bug?extid=dc4127f950da51639216), the issue is fixed; Is it OK? Let us know if we need to do something?

Hi Ganapathi,

The "fixed" status relates to the similar past bug that was reported
and fixed more than a year ago:
https://groups.google.com/forum/#!msg/syzkaller-bugs/3YnGX1chF2w/jeQjeihtBAAJ
https://syzkaller.appspot.com/bug?id=b4b5c74c57c4b69f4fff86131abb799106182749

This one is still well alive and kicking, with 1200+ crashes and the
last one happened less then 30min ago.
