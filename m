Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E84E7EEC
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 05:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfJ2EBn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 00:01:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34452 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfJ2EBn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 00:01:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id c25so4703923qkk.1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2019 21:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDvFbMqtLQKHIm5EaIS2pT+S04TntpX/aAE34tFDiwo=;
        b=KlKGwIx8cfO8yaZzxzEbFh5++cMI7RVpXh/rLolviVV991j0eAW2/dnvaFoqFTPCjy
         h2b+K+ht+FSeKFG0KXR27D3uanJKHlxuYwqQlBglJMr7PDNNmahQJ7NgU99renrkdEDh
         x9RfFUDtymqLDHzFFjSoW5Y70KvoImCVUyBi3zlRJxRIUPPGCCEMV0kW8IvKmRSHxeHj
         DdECs4VPIWISAmBCqNocw/NkKqw33eVreZV2PVMwYwlK2EDto6ldP/95fYEACeogOM+G
         Ffdzauv5IHziGh0rbVHFWXzzkCR0i6eQP4GzII5VbNMwRf8EAJoz1q0k3xm0JnYwAXcI
         JcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDvFbMqtLQKHIm5EaIS2pT+S04TntpX/aAE34tFDiwo=;
        b=VgA/ljDGJtusAetSf+9wdYVdG57qN47kO+7Enmf19U1T3GsC3zkHqZnUvBTuHxnHJk
         4rWrOcHwRhUIlEXfl2DyVMofYfumYsbhDaaiyR18hl6ijx1GGMHkQhM+8HO6lfQVXl5q
         EvZ0fqUCH+9ZysRtvJFlcn6nm3wYqUDJPqc2e8lWfXSIDbsuw9jZ/Xra1Q7s1Vjl52Mo
         tGzaJQQKeJXZyH0EBr5+hwoFbhUaK4kb9CUcZaS4LMs3rmGfGJdLjYOVEgJBKEkd9mMC
         E3Che1hUt0f0lfZ6enPmSeKKckzP4T3O5FyPukPqE6bXdpfO5VjWaRO4G8WfKfwtIFVz
         oGxA==
X-Gm-Message-State: APjAAAXGcJ3jI9+UtVeQ+G7Ypl3Umcnjgbgy0Aexe62YgsRoaaAvpUX2
        NqyjZ+WNsUBVi+iivEa5u10xJBwfURp89jp/AdCuPg==
X-Google-Smtp-Source: APXvYqygyQgFGmyWASvk1Lk50rkSstRO54cIOU4m+cUxT5PiYJMd7ue19uwrQ7WE4d4krXOzVyhUGrLBiAQwCnsj0lE=
X-Received: by 2002:a37:847:: with SMTP id 68mr18123162qki.366.1572321702297;
 Mon, 28 Oct 2019 21:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191025093345.22643-1-yhchuang@realtek.com> <20191025093345.22643-4-yhchuang@realtek.com>
 <CAB4CAwf_Y0tMG37nZDtsU9FmACaOB=eALCNCazVk1kbAvOE26Q@mail.gmail.com> <F7CD281DE3E379468C6D07993EA72F84D1911E08@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D1911E08@RTITMBSVM04.realtek.com.tw>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 29 Oct 2019 12:01:30 +0800
Message-ID: <CAB4CAweAExW+8hj5asHeF3jpcyn79joATUCqRnpwFW7aRTb8OA@mail.gmail.com>
Subject: Re: [PATCH 3/6] rtw88: use a module parameter to control LPS enter
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        "g.schlmm@googlemail.com" <g.schlmm@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 28, 2019 at 11:13 AM Tony Chuang <yhchuang@realtek.com> wrote:
>
> > On Fri, Oct 25, 2019 at 5:33 PM <yhchuang@realtek.com> wrote:
> > >
> > > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > >
> > > If the number of packets is less than the LPS threshold, driver
> > > can then enter LPS mode.
> > > And driver used to take RTW_LPS_THRESHOLD as the threshold. As
> > > the macro can not be changed after compiled, use a parameter
> > > instead.
> > >
> > > The larger of the threshold, the more traffic required to leave
> > > power save mode, responsive time could be longer, but also the
> > > power consumption could be lower.
> > >
> > > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > > ---
Reviewed-by: Chris Chiu <chiu@endlessm.com>

> > >  drivers/net/wireless/realtek/rtw88/main.c | 7 +++++--
> > >  drivers/net/wireless/realtek/rtw88/ps.h   | 2 --
> > >  2 files changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/realtek/rtw88/main.c
> > b/drivers/net/wireless/realtek/rtw88/main.c
> > > index 7c1b89c4fb6c..bff8a0b129d9 100644
> > > --- a/drivers/net/wireless/realtek/rtw88/main.c
> > > +++ b/drivers/net/wireless/realtek/rtw88/main.c
> >
> > > @@ -199,8 +202,8 @@ static void rtw_watch_dog_work(struct
> > work_struct *work)
> > >         if (busy_traffic != test_bit(RTW_FLAG_BUSY_TRAFFIC,
> > rtwdev->flags))
> > >                 rtw_coex_wl_status_change_notify(rtwdev);
> > >
> > > -       if (stats->tx_cnt > RTW_LPS_THRESHOLD ||
> > > -           stats->rx_cnt > RTW_LPS_THRESHOLD)
> > > +       if (stats->tx_cnt > rtw_lps_threshold ||
> > > +           stats->rx_cnt > rtw_lps_threshold)
> > >                 ps_active = true;
> > >         else
> > >                 ps_active = false;
> >
> > The naming of 'ps_active' is a bit confusing. Per the commit message,
> > it will leave LPS
> > it tx/rx count > threshold. But I'll be misled by the name ps_active.
> > Does it mean the
> > current condition is PS active and ready to power sleep? I'd like to
> > rename it to old-fashioned
> > 'lps_enter' to represent the action that would be taken. It would be
> > easier for me to understand.
> >
> > Chris
> >
>
> I think according to the context, ps_active is good for me.
> But I can still send a separate patch to rename it.
> Or you can :)
>
> Yan-Hsuan

OK. Then I have no problem with this patch.

Chris
