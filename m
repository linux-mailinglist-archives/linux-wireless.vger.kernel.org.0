Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C7489E23
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jan 2022 18:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbiAJRNX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jan 2022 12:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbiAJRNV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jan 2022 12:13:21 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999CFC061748
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jan 2022 09:13:21 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id t18so3337844plg.9
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jan 2022 09:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=9RT3b7n6IVwu0+dS35p1vWHaLwN2/8EuSQd2Im0HeXk=;
        b=GzmCeZY6nGxXMf4dZX40TnsDDuDE0dITzZxNx2T6y5DAXu7Q32m5lYkNXwo1Q3e/+d
         QcR3wC3xPdNIjQTeUDI+1e7arqdmzbQRgjt/7tz+CG/b7RvhPk9N1HO2OxqTwvmFgkuh
         fAsk1KX3HUVSKVokzyUhp/RvShEbE1KrRcBMZ08d3x/nXANk7OTaxTPxSCaveyLDg0j0
         8/wq21owUcCxFNoq3rh7XH3fxLysFTUKR81vO+kDIvn+sg0Pb65Q2KjvhbhkpiuEFjuP
         cQd9g+gtdyIHpQsJKXhIDdH5BKLJOBvqrk13Pr3/XLGgf8GDkL4bxwZwWJtOMaHZAI9O
         Swcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9RT3b7n6IVwu0+dS35p1vWHaLwN2/8EuSQd2Im0HeXk=;
        b=EkL6uwATY6LRLCG4yJzIdGz5suLmJemSNM1cJi+MyCsaIk/tQ6gH+vgm0i7gHTv4Ad
         QizoPUzQpAIdaoBpqF1yozoN9ewE0DIxyRV8O7AU3YblLSNSK1ZvtjZuRPaY1kVptAjY
         6AWt9Gp0fgNRv0sS35PfIUx5AV9OAqHJ0oF3rj5QbiRZT+bK43uphyxofTQnYceakLsX
         qpMUkeLeGOeVBRUNkQm6kL12WGQEYe3MOCGPvf+vZ2d5ZIhoMYJ0C8FokXmY3V5G4d14
         4RaUO0flJTwSknYSXt6snnZxS9/58FdBv6ibZz0BsHC1IgYfCOddD9gzsvcnry2h+4YE
         YpVg==
X-Gm-Message-State: AOAM530EU0bLjkjCHXOQ0dqp+Ru2lEsS45crsdUMKBO62OC4CEtpsJKM
        7AyjPntpW4eDbInQVN6rOws=
X-Google-Smtp-Source: ABdhPJxZBdK1GZdtP412ZdRT1mGiLWafsyBymRqEfosZJGAEGGk+GbAKZZ8y35FVl484cF8masEZGA==
X-Received: by 2002:aa7:928e:0:b0:4ba:fa67:d87 with SMTP id j14-20020aa7928e000000b004bafa670d87mr489668pfa.41.1641834800875;
        Mon, 10 Jan 2022 09:13:20 -0800 (PST)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u8sm7475942pfi.147.2022.01.10.09.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 09:13:20 -0800 (PST)
Message-ID: <8557b62e0f1c6a94f7ec9b27a596d7499fd072d7.camel@gmail.com>
Subject: Re: Adding CMD_SET_CHANNEL for station iftypes
From:   James Prestwood <prestwoj@gmail.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Mon, 10 Jan 2022 09:13:19 -0800
In-Reply-To: <17e3eb62ed0.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
References: <2b18f86924c3d64437aa139f6401ee2e7705eeb0.camel@gmail.com>
         <47ba74aa23a5c4fb42660d5b40e974c24acf24bf.camel@sipsolutions.net>
         <91d38c40a62100dc6355c98e85b8b793ed8890df.camel@gmail.com>
         <d8250f97a2be736736374974095f219d858acb1e.camel@sipsolutions.net>
         <58ebff51d64d1ae6b01d85cff7bb9e137e19848a.camel@gmail.com>
         <17e3eb62ed0.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

On Sun, 2022-01-09 at 13:00 +0100, Arend van Spriel wrote:
> On January 8, 2022 12:31:19 AM James Prestwood <prestwoj@gmail.com>
> wrote:
> 
> > On Thu, 2022-01-06 at 23:01 +0100, Johannes Berg wrote:
> > > Hi Preston,
> > > 
> > > Ugh, sorry. I'm way behind on a whole bunch of emails (about 4
> > > dozen
> > > to
> > > be honest) ... trying to catch up, but only so many hours a day.
> > 
> > No worries, thanks for getting to it :)
> > 
> > > 
> 
> [...]
> 
> > 
> > > 
> > > At which point it's probably not really worth it? Emulating it in
> > > the
> > > driver by repeatedly issuing time events also seems like a bad
> > > idea,
> > > worse even than doing it in the application, since the
> > > application
> > > could
> > > at least try to synchronise it a bit with whatever it needs to be
> > > doing,
> > > whereas the driver can't do that at all.
> > 
> > If this is the case then sure, its just offloading the same nasty
> > procedure into the driver/FW. You know more than me about this
> > topic
> > but I'm still trying to understand how this would differ much from
> > AP
> > mode?
> > 
> > In my own mind I see SET_CHANNEL doing the same thing as START_AP,
> > just
> > without sending out beacons/probes and the iftype being station.
> > Maybe
> > this is an oversimplifation but it seems like the FW/driver *can*
> > sit
> > on channel without some time constraint if it supports AP mode.
> 
> Even if it only supports STA mode it can. The constraint being that
> it is 
> not associated (or busy trying to associate) to an AP. When it is 
> associated it has to sit on the channel of the AP, as announced in
> it's 
> beacon and/or probe response, at regular intervals. You referred to
> DPP to 
> provision the STA so I assume it is not associated, right? Could you
> write 
> out the whole scenario as you think it should/could be done?

Correct, I'm only talking about doing this while not associated.

As for my intentended scenario I simply want to call CMD_SET_CHANNEL
then run the entire DPP auth/config protocol while on this channel.
Then, once finished, call (a new API) CMD_SET_CHANNEL_CANCEL.

Currently I'm stuck doing CMD_REMAIN_ON_CHANNEL over and over. Which
leaves moments of time where the device is idle, potentially missing
DPP frames. This is especially bad for drivers which choose short ROC
timeouts. Also, since the ROC duration isn't honored userspace has to
manage its own separate timer and re-issue ROC if the driver decided to
use a different timeout. It just ends up being a mess and extremely
overcomplicated for something as simple as going offchannel. I feel
there has got to be a cleaner way to handle this.

P2P has a similar use case discovering peers AFAIK.

Thanks,
James

> 
> Regards,
> Arend
> 
> 


