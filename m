Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFD3A26F5
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 21:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfH2TGA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 15:06:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44720 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfH2TGA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 15:06:00 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so9021434iog.11
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2019 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6ODR4liUJUcLKxYPurm7ggAPp8kN1h7mndbudDzdgE=;
        b=dLd6n1cuN59FKLyUeX6f4ieG2cTQdv+xUByWesHiL3g3EZX/q5fQIXm8Xgom3esmGv
         XUV89a0MelbyPW8TYxAojgI8ihZHrop5G/RTHA2WpVz12rplN+eyyvAx8ye+L+/DNFtk
         x4yN5Qe9ZSjA86rtfL8FkqIWW8tYme+eiR1a/Ybpl/okzcmP21q7mV+keyA4PnKi03GM
         7UJFvlw69t+toAzFCp2vN75Ly9S1uGiFnF3uCmSe6t/0g6PXTK1iHyHWJUzHtIu3kGNQ
         Pgzb0B2g+TcdZsyFDEejksNW6Hais5Hr2Jc8PTMVsJgQCHMvIQ/KcIN3qiJTTUz10wQb
         +26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6ODR4liUJUcLKxYPurm7ggAPp8kN1h7mndbudDzdgE=;
        b=HBVg/HeGiYNvNaCxv1M1pIU3ZMdjyws5boj5bxxTYLcj9d1VX7M99vUCx73wrvnFpm
         GAURdZwRQVyBwFPVL+Om0r1Iad+EHuu8vE89lWVylmoTtrDJt8v9bpWQdj8yOk60r+V6
         7vKv6TTy1Fj+V9Irxctg8GF5YeKJCwjG1KVwfmkc8cHvrses6JyOhVn5JnNiRfensWk4
         3iXinHmv92FoQhEgLIA/3Oq+il+jdW+nbSywDAj45DJHunIMZBUm1HPPW2y8BhKKjtpu
         OTB/B1nL95u7hW+M8EynmgooiGlrwVD6tV4MtRgHojnR+fSGSuM6t6bt6lU4X6z1fk2f
         3t1g==
X-Gm-Message-State: APjAAAVH43mSXPPwZsDxC6r+oVJgstuoyjeHM8+dsv5VLaeI1LStucAm
        UnRIGly3nbGlwIXKAXvJmVzhF3/vcsku3chIhb4=
X-Google-Smtp-Source: APXvYqzEOJTQtWu0fJ7VMYY9IECqZX0ZuA4HMC9DeBW0981fs1Ilz42laGwf/1kso8DHr6Q/uWBUUKPUVBcValphx10=
X-Received: by 2002:a6b:620f:: with SMTP id f15mr12453499iog.190.1567105559154;
 Thu, 29 Aug 2019 12:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
 <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
 <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com> <80d9c12986ec0a13c34672ca1c16f37cae0cc096.camel@sipsolutions.net>
In-Reply-To: <80d9c12986ec0a13c34672ca1c16f37cae0cc096.camel@sipsolutions.net>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Fri, 30 Aug 2019 00:35:48 +0530
Message-ID: <CABPxzYLrTC3kS86iyfq+RY=XEgjedu2MWPtn+i+H50jPz3oh3w@mail.gmail.com>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ramon Fontes <ramonreisfontes@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 29, 2019 at 10:55 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Thu, 2019-08-29 at 14:04 -0300, Ramon Fontes wrote:
> > Yes, that's what I (we?) expect.
> >
> > Yes, wmediumd has some log files, but they don't help me to identify
> > the reason of the problem. I also unsuccessfully tried to modified the
> > wmediumd code. Both wmediumd and mac80211_hwsim work fine up to kernel
> > version 4.17. The problem comes only from kernel 4.18. Since there are
> > some wmediumd related-codes in mac80211_hwsim, I was wondering whether
> > something wasn't missing in mac80211_hwsim (or even some needed
> > changes in wmediumd) that is causing such problem.
>
> Hmm, but are there? There's basically no change in hwsim between 4.17
> and 4.18, only a few error path cleanups/fixes and the SUPPORTS_PS
> change which also shouldn't matter for this?
>
> > Another weird thing
> > is the channel, since the channel is the same as defined in hostapd
> > and doesn't match 5Ghz channels.
>
> You mean the DS element? That's just from the frame itself.
Is this supposed to work at all? AFAICS, in hwsim channel matching
checks are only done in non-mediumd path (no_nl), and wmediumd also
doesn't have any checks? So, hostapd responds to all probe requests in all
channels. Am I missing something?
